module Cli exposing (run)

import Ansi.Color
import BackendTask
import BackendTask.File
import Cli.Option
import Cli.OptionsParser
import Cli.Program
import Dict
import Elm
import Elm.Annotation
import Elm.Case
import Elm.Declare
import Elm.Op
import FatalError
import Gen.Debug
import Gen.Http
import Gen.Json.Decode
import Gen.Json.Decode.Extra
import Gen.Json.Encode
import Gen.Maybe
import Gen.Result
import Json.Decode
import Json.Schema.Definitions
import List.Extra
import OpenApi exposing (OpenApi)
import OpenApi.Components
import OpenApi.Info
import OpenApi.MediaType
import OpenApi.Operation
import OpenApi.Path
import OpenApi.Reference
import OpenApi.RequestBody
import OpenApi.Response
import OpenApi.Schema
import OpenApi.Server
import Pages.Script
import Path
import Result.Extra
import String.Extra


type alias CliOptions =
    { entryFilePath : String
    , outputFile : Maybe String
    , namespace : Maybe String
    }


program : Cli.Program.Config CliOptions
program =
    Cli.Program.config
        |> Cli.Program.add
            (Cli.OptionsParser.build CliOptions
                |> Cli.OptionsParser.with
                    (Cli.Option.requiredPositionalArg "entryFilePath")
                |> Cli.OptionsParser.with
                    (Cli.Option.optionalKeywordArg "output")
                |> Cli.OptionsParser.with
                    (Cli.Option.optionalKeywordArg "namespace")
            )


run : Pages.Script.Script
run =
    Pages.Script.withCliOptions program
        (\{ entryFilePath, outputFile, namespace } ->
            BackendTask.File.rawFile entryFilePath
                |> BackendTask.mapError
                    (\error ->
                        FatalError.fromString <|
                            Ansi.Color.fontColor Ansi.Color.brightRed <|
                                case error.recoverable of
                                    BackendTask.File.FileDoesntExist ->
                                        "Uh oh! There is no file at " ++ entryFilePath

                                    BackendTask.File.FileReadError str ->
                                        "Uh oh! Can't read!"

                                    BackendTask.File.DecodingError decodeErr ->
                                        "Uh oh! Decoding failure!"
                    )
                |> BackendTask.andThen decodeOpenApiSpecOrFail
                |> BackendTask.andThen (generateFileFromOpenApiSpec { outputFile = outputFile, namespace = namespace })
        )


decodeOpenApiSpecOrFail : String -> BackendTask.BackendTask FatalError.FatalError OpenApi.OpenApi
decodeOpenApiSpecOrFail =
    Json.Decode.decodeString OpenApi.decode
        >> Result.mapError
            (Json.Decode.errorToString
                >> Ansi.Color.fontColor Ansi.Color.brightRed
                >> FatalError.fromString
            )
        >> BackendTask.fromResult


generateFileFromOpenApiSpec : { outputFile : Maybe String, namespace : Maybe String } -> OpenApi.OpenApi -> BackendTask.BackendTask FatalError.FatalError ()
generateFileFromOpenApiSpec { outputFile, namespace } apiSpec =
    let
        fileNamespace : String
        fileNamespace =
            case namespace of
                Just n ->
                    n

                Nothing ->
                    let
                        defaultNamespace =
                            apiSpec
                                |> OpenApi.info
                                |> OpenApi.Info.title
                                |> makeNamespaceValid
                                |> removeInvalidChars
                    in
                    case outputFile of
                        Just path ->
                            let
                                split : List String
                                split =
                                    String.split "/" path
                            in
                            case List.Extra.dropWhile ((/=) "generated") split of
                                "generated" :: rest ->
                                    rest
                                        |> String.join "."
                                        |> String.replace ".elm" ""

                                _ ->
                                    case List.Extra.dropWhile ((/=) "src") split of
                                        "src" :: rest ->
                                            rest
                                                |> String.join "."
                                                |> String.replace ".elm" ""

                                        _ ->
                                            defaultNamespace

                        Nothing ->
                            defaultNamespace

        pathDeclarations =
            apiSpec
                |> OpenApi.paths
                |> Dict.foldr
                    (\url path res ->
                        let
                            ops =
                                [ ( "GET", OpenApi.Path.get )
                                , ( "POST", OpenApi.Path.post )
                                , ( "PUT", OpenApi.Path.put )
                                , ( "PATCH", OpenApi.Path.patch )
                                , ( "DELETE", OpenApi.Path.delete )
                                , ( "HEAD", OpenApi.Path.head )
                                , ( "TRACE", OpenApi.Path.trace )
                                ]
                                    |> List.filterMap
                                        (\( method, getter ) ->
                                            path
                                                |> getter
                                                |> Maybe.map
                                                    (toRequestFunction method apiSpec url
                                                        >> Elm.exposeWith
                                                            { exposeConstructor = False
                                                            , group = Just "Request functions"
                                                            }
                                                    )
                                        )
                        in
                        ops ++ res
                    )
                    []

        responsesDeclarations =
            apiSpec
                |> OpenApi.components
                |> Maybe.map OpenApi.Components.responses
                |> Maybe.withDefault Dict.empty
                |> Dict.foldl
                    (\name schema ->
                        Result.map2 (::)
                            (responseToDeclarations name schema)
                    )
                    (Ok [])
                |> (\r ->
                        case r of
                            Ok lst ->
                                List.concat lst

                            Err ( path, e ) ->
                                Debug.todo <| "Error " ++ e ++ " at path " ++ String.join "." path
                   )

        componentDeclarations =
            apiSpec
                |> OpenApi.components
                |> Maybe.map OpenApi.Components.schemas
                |> Maybe.withDefault Dict.empty
                |> Dict.foldl
                    (\name schema ->
                        Result.map2 (::)
                            (schemaToDeclarations name (OpenApi.Schema.get schema))
                    )
                    (Ok [])
                |> (\r ->
                        case r of
                            Ok lst ->
                                List.concat lst

                            Err ( path, e ) ->
                                Debug.todo <| "Error " ++ e ++ " at path " ++ String.join "." path
                   )

        helperDeclarations =
            -- The max value here should match with the max value supported by `intToWord`
            List.range 1 99
                |> List.map
                    (\i ->
                        intToWord i
                            |> Result.andThen
                                (\intWord ->
                                    let
                                        typeName : String
                                        typeName =
                                            typifyName ("enum_" ++ intWord)
                                    in
                                    List.range 1 i
                                        |> List.foldr
                                            (\j res ->
                                                Result.map2
                                                    (\jWord r ->
                                                        Elm.variantWith (typifyName (typeName ++ "_" ++ jWord)) [ Elm.Annotation.var (elmifyName jWord) ]
                                                            :: r
                                                    )
                                                    (intToWord j)
                                                    res
                                            )
                                            (Ok [])
                                        |> Result.map (Elm.customType typeName)
                                )
                    )
                |> Result.Extra.combine
                -- |> Result.withDefault []
                |> (\r ->
                        case r of
                            Ok lst ->
                                lst

                            Err e ->
                                Debug.todo <| "Error " ++ e
                   )

        file =
            Elm.fileWith [ fileNamespace ]
                { docs =
                    List.sortBy
                        (\{ group } ->
                            case group of
                                Just "Request functions" ->
                                    1

                                Just "Types" ->
                                    2

                                Just "Encoders" ->
                                    3

                                Just "Decoders" ->
                                    4

                                _ ->
                                    5
                        )
                        >> List.map Elm.docs
                , aliases = []
                }
                (pathDeclarations
                    ++ (nullableType :: componentDeclarations ++ responsesDeclarations ++ helperDeclarations)
                )

        outputPath =
            Maybe.withDefault
                ([ "generated", file.path ]
                    |> Path.join
                    |> Path.toRelative
                )
                outputFile
    in
    Pages.Script.writeFile
        { path = outputPath
        , body = file.contents
        }
        |> BackendTask.mapError
            (\error ->
                FatalError.fromString <|
                    Ansi.Color.fontColor Ansi.Color.brightRed <|
                        case error.recoverable of
                            Pages.Script.FileWriteError ->
                                "Uh oh! Failed to write file"
            )
        |> BackendTask.andThen (\() -> Pages.Script.log ("SDK generated at " ++ outputPath))


schemaToDeclarations : String -> Json.Schema.Definitions.Schema -> Result ( Path, String ) (List Elm.Declaration)
schemaToDeclarations name schema =
    case schemaToAnnotation schema of
        Ok ann ->
            [ Elm.alias (typifyName name) ann
                |> Elm.exposeWith
                    { exposeConstructor = False
                    , group = Just "Types"
                    }
                |> Ok
            , Result.map
                (\schemaDecoder ->
                    Elm.Declare.function ("decode" ++ typifyName name)
                        []
                        (\_ ->
                            schemaDecoder
                                |> Elm.withType (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.named [] (typifyName name)))
                        )
                        |> .declaration
                        |> Elm.exposeWith
                            { exposeConstructor = False
                            , group = Just "Decoders"
                            }
                )
                (schemaToDecoder schema)
            , Elm.Declare.function ("encode" ++ typifyName name)
                []
                (\_ ->
                    schemaToEncoder schema
                        |> Elm.withType (Elm.Annotation.function [ Elm.Annotation.named [] (typifyName name) ] Gen.Json.Encode.annotation_.value)
                )
                |> .declaration
                |> Elm.exposeWith
                    { exposeConstructor = False
                    , group = Just "Encoders"
                    }
                |> Ok
            ]
                |> Result.Extra.combine

        Err ( path, msg ) ->
            Err ( name :: path, msg )


responseToDeclarations : String -> OpenApi.Reference.ReferenceOr OpenApi.Response.Response -> Result ( Path, String ) (List Elm.Declaration)
responseToDeclarations name reference =
    case OpenApi.Reference.toConcrete reference of
        Just response ->
            let
                content =
                    OpenApi.Response.content response
            in
            if Dict.isEmpty content then
                -- If there is no content then we go with the unit value, `()` as the response type
                Ok []

            else
                case responseToSchema response of
                    Ok schema ->
                        schemaToDeclarations name schema

                    Err msg ->
                        Err ( [ name ], msg )

        Nothing ->
            Err ( [ name ], "Could not convert reference to concrete value" )


stepOrFail : String -> (a -> Maybe value) -> Result String a -> Result String value
stepOrFail msg f =
    Result.andThen
        (\y ->
            case f y of
                Just z ->
                    Ok z

                Nothing ->
                    Err <| "Couldn't find a response decoder. " ++ msg
        )


toRequestFunction : String -> OpenApi -> String -> OpenApi.Operation.Operation -> Elm.Declaration
toRequestFunction method apiSpec url operation =
    let
        body : Result String (Maybe ( Elm.Annotation.Annotation, Elm.Expression ))
        body =
            case OpenApi.Operation.requestBody operation of
                Nothing ->
                    Ok Nothing

                Just requestOrRef ->
                    case OpenApi.Reference.toConcrete requestOrRef of
                        Just request ->
                            Ok request
                                |> stepOrFail "The request doesn't have an application/json content option"
                                    (OpenApi.RequestBody.content
                                        >> Dict.get "application/json"
                                    )
                                |> stepOrFail "The request's application/json content option doesn't have a schema"
                                    (OpenApi.MediaType.schema >> Maybe.map OpenApi.Schema.get)
                                |> Result.andThen
                                    (\schema ->
                                        Result.map
                                            (\ann ->
                                                Just
                                                    ( ann
                                                    , schemaToEncoder schema
                                                    )
                                            )
                                            (schemaToAnnotation schema)
                                            |> Result.mapError Tuple.second
                                    )

                        Nothing ->
                            Ok requestOrRef
                                |> stepOrFail "I found a successfull response, but I couldn't convert it to a concrete one"
                                    OpenApi.Reference.toReference
                                |> (\mr ->
                                        mr
                                            |> stepOrFail
                                                ("Couldn't get the type ref for the response [ref = "
                                                    ++ Result.withDefault "?" (Result.map OpenApi.Reference.ref mr)
                                                    ++ "]"
                                                )
                                                (OpenApi.Reference.ref >> schemaTypeRef apiSpec)
                                   )
                                |> Result.map
                                    (\st ->
                                        Just
                                            ( Elm.Annotation.named [] st
                                            , Elm.val ("decode" ++ st)
                                            )
                                    )

        fullUrl : String
        fullUrl =
            case OpenApi.servers apiSpec of
                [] ->
                    url

                firstServer :: _ ->
                    if String.startsWith "/" url then
                        OpenApi.Server.url firstServer ++ url

                    else
                        OpenApi.Server.url firstServer ++ "/" ++ url

        functionName : String
        functionName =
            (OpenApi.Operation.operationId operation
                |> Maybe.withDefault url
            )
                |> makeNamespaceValid
                |> removeInvalidChars
                |> String.Extra.camelize

        toMsgParam =
            ( "toMsg"
            , Just
                (Elm.Annotation.function
                    [ Gen.Result.annotation_.result Gen.Http.annotation_.error successType ]
                    (Elm.Annotation.var "msg")
                )
            )

        ( successType, maybeSuccessDecoder ) =
            operationToSuccessTypeAndDecoder apiSpec operation

        function =
            case body of
                Ok Nothing ->
                    Elm.Declare.fn functionName
                        toMsgParam
                        (\toMsg ->
                            Gen.Http.request
                                { method = method
                                , headers = []
                                , timeout = Gen.Maybe.make_.nothing
                                , tracker = Gen.Maybe.make_.nothing
                                , url = fullUrl
                                , expect =
                                    case maybeSuccessDecoder of
                                        Just successDecoder ->
                                            Gen.Http.expectJson
                                                (\result -> Elm.apply toMsg [ result ])
                                                successDecoder

                                        Nothing ->
                                            Gen.Http.expectWhatever (\result -> Elm.apply toMsg [ result ])
                                , body = Gen.Http.emptyBody
                                }
                        )
                        |> .declaration

                Ok (Just ( bodyType, bodyEncoder )) ->
                    Elm.Declare.fn2 functionName
                        toMsgParam
                        ( "body", Just bodyType )
                        (\toMsg bodyValue ->
                            Gen.Http.request
                                { method = method
                                , headers = []
                                , timeout = Gen.Maybe.make_.nothing
                                , tracker = Gen.Maybe.make_.nothing
                                , url = fullUrl
                                , expect =
                                    case maybeSuccessDecoder of
                                        Just successDecoder ->
                                            Gen.Http.expectJson
                                                (\result -> Elm.apply toMsg [ result ])
                                                successDecoder

                                        Nothing ->
                                            Gen.Http.expectWhatever (\result -> Elm.apply toMsg [ result ])
                                , body = Gen.Http.jsonBody <| Elm.apply bodyEncoder [ bodyValue ]
                                }
                        )
                        |> .declaration

                Err e ->
                    Elm.Declare.function functionName
                        []
                        (\_ ->
                            Gen.Debug.todo <|
                                "["
                                    ++ method
                                    ++ " "
                                    ++ url
                                    ++ "]Could not deal with body type: "
                                    ++ e
                        )
                        |> .declaration
    in
    function
        |> Elm.withDocumentation (OpenApi.Operation.description operation |> Maybe.withDefault "")


operationToSuccessTypeAndDecoder : OpenApi -> OpenApi.Operation.Operation -> ( Elm.Annotation.Annotation, Maybe Elm.Expression )
operationToSuccessTypeAndDecoder apiSpec operation =
    let
        responses : Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response)
        responses =
            OpenApi.Operation.responses operation

        debugFromResult : Result String ( Elm.Annotation.Annotation, Maybe Elm.Expression ) -> ( Elm.Annotation.Annotation, Maybe Elm.Expression )
        debugFromResult r =
            case r of
                Ok t ->
                    t

                Err msg ->
                    ( Elm.Annotation.var "todo"
                    , Just <| Gen.Debug.todo msg
                    )
    in
    Ok responses
        |> stepOrFail
            ("Among the "
                ++ String.fromInt (Dict.size responses)
                ++ " possible responses, there was no successfull one."
            )
            getFirstSuccessResponse
        |> Result.andThen
            (\( code, responseOrRef ) ->
                case OpenApi.Reference.toConcrete responseOrRef of
                    Just response ->
                        if code == "204" && Dict.get "application/json" (OpenApi.Response.content response) == Nothing then
                            Ok ( Elm.Annotation.unit, Nothing )

                        else
                            Ok response
                                |> stepOrFail "The response doesn't have an application/json content option"
                                    (OpenApi.Response.content
                                        >> Dict.get "application/json"
                                    )
                                |> stepOrFail "The response's application/json content option doesn't have a schema"
                                    (OpenApi.MediaType.schema >> Maybe.map OpenApi.Schema.get)
                                |> Result.andThen
                                    (\schema ->
                                        Result.map2 Tuple.pair
                                            (schemaToAnnotation schema)
                                            (Result.map Just <| schemaToDecoder schema)
                                            |> Result.mapError Tuple.second
                                    )

                    Nothing ->
                        Ok responseOrRef
                            |> stepOrFail "I found a successfull response, but I couldn't convert it to a concrete one"
                                OpenApi.Reference.toReference
                            |> (\mr ->
                                    mr
                                        |> stepOrFail
                                            ("Couldn't get the type ref for the response [ref = "
                                                ++ Result.withDefault "?" (Result.map OpenApi.Reference.ref mr)
                                                ++ "]"
                                            )
                                            (OpenApi.Reference.ref >> schemaTypeRef apiSpec)
                               )
                            |> Result.map
                                (\st ->
                                    ( Elm.Annotation.named [] st
                                    , Just <| Elm.val ("decode" ++ st)
                                    )
                                )
            )
        |> debugFromResult


schemaTypeRef : OpenApi -> String -> Maybe String
schemaTypeRef openApi refUri =
    case String.split "/" refUri of
        [ "#", "components", "schemas", schemaName ] ->
            Just (typifyName schemaName)

        [ "#", "components", "responses", responseName ] ->
            Just (typifyName responseName)

        _ ->
            Nothing


toObjectSchema : Json.Schema.Definitions.Schema -> Maybe Json.Schema.Definitions.SubSchema
toObjectSchema schema =
    case schema of
        Json.Schema.Definitions.BooleanSchema _ ->
            Nothing

        Json.Schema.Definitions.ObjectSchema subSchema ->
            Just subSchema


getFirstSuccessResponse : Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response) -> Maybe ( String, OpenApi.Reference.ReferenceOr OpenApi.Response.Response )
getFirstSuccessResponse responses =
    responses
        |> Dict.toList
        |> List.filter (\( statusCode, _ ) -> String.startsWith "2" statusCode)
        |> List.head


nullableType : Elm.Declaration
nullableType =
    Elm.customType "Nullable"
        [ Elm.variant "Null"
        , Elm.variantWith "Present" [ Elm.Annotation.var "value" ]
        ]
        |> Elm.exposeWith
            { exposeConstructor = True
            , group = Just "Types"
            }


typifyName : String -> String
typifyName name =
    name
        |> String.uncons
        |> Maybe.map (\( first, rest ) -> String.cons first (String.replace "-" " " rest))
        |> Maybe.withDefault ""
        |> String.replace "_" " "
        |> String.Extra.toTitleCase
        |> String.replace " " ""


elmifyName : String -> String
elmifyName name =
    name
        |> typifyName
        |> String.uncons
        |> Maybe.map (\( first, rest ) -> String.cons (Char.toLower first) rest)
        |> Maybe.withDefault ""
        |> deSymbolify


{-| Sometimes a word in the schema contains invalid characers for an Elm name.
We don't want to completely remove them though.
-}
deSymbolify : String -> String
deSymbolify str =
    str
        |> String.replace "+" "plus"
        |> String.replace "-" "minus"


schemaToEncoder : Json.Schema.Definitions.Schema -> Elm.Expression
schemaToEncoder schema =
    case schema of
        Json.Schema.Definitions.BooleanSchema bool ->
            Gen.Debug.todo ""

        Json.Schema.Definitions.ObjectSchema subSchema ->
            let
                singleTypeToDecoder singleType =
                    case singleType of
                        Json.Schema.Definitions.ObjectType ->
                            Elm.fn ( "rec", Nothing )
                                (\rec ->
                                    subSchema.properties
                                        |> Maybe.map (\(Json.Schema.Definitions.Schemata schemata) -> schemata)
                                        |> Maybe.withDefault []
                                        |> List.map
                                            (\( key, valueSchema ) ->
                                                Elm.tuple
                                                    (Elm.string key)
                                                    (Elm.apply (schemaToEncoder valueSchema) [ Elm.get (elmifyName key) rec ])
                                            )
                                        |> Gen.Json.Encode.object
                                )

                        Json.Schema.Definitions.StringType ->
                            Gen.Json.Encode.values_.string

                        Json.Schema.Definitions.IntegerType ->
                            Gen.Json.Encode.values_.int

                        Json.Schema.Definitions.NumberType ->
                            Gen.Json.Encode.values_.float

                        Json.Schema.Definitions.BooleanType ->
                            Gen.Json.Encode.values_.bool

                        Json.Schema.Definitions.NullType ->
                            Gen.Debug.todo ""

                        Json.Schema.Definitions.ArrayType ->
                            case subSchema.items of
                                Json.Schema.Definitions.NoItems ->
                                    Gen.Debug.todo "err"

                                Json.Schema.Definitions.ArrayOfItems _ ->
                                    Gen.Debug.todo ""

                                Json.Schema.Definitions.ItemDefinition itemSchema ->
                                    Elm.apply
                                        Gen.Json.Encode.values_.list
                                        [ schemaToEncoder itemSchema ]
            in
            case subSchema.type_ of
                Json.Schema.Definitions.SingleType singleType ->
                    singleTypeToDecoder singleType

                Json.Schema.Definitions.AnyType ->
                    case subSchema.ref of
                        Nothing ->
                            case subSchema.anyOf of
                                Nothing ->
                                    Elm.val "identity"

                                Just anyOf ->
                                    case anyOf of
                                        [ onlySchema ] ->
                                            Gen.Debug.todo "decode anyOf: exactly 1 item"

                                        [ firstSchema, secondSchema ] ->
                                            case ( firstSchema, secondSchema ) of
                                                ( Json.Schema.Definitions.ObjectSchema firstSubSchema, Json.Schema.Definitions.ObjectSchema secondSubSchema ) ->
                                                    case ( firstSubSchema.type_, secondSubSchema.type_ ) of
                                                        ( Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType, _ ) ->
                                                            Elm.fn ( "nullableValue", Nothing )
                                                                (\nullableValue ->
                                                                    Elm.Case.custom
                                                                        nullableValue
                                                                        (Elm.Annotation.namedWith [] "Nullable" [ Elm.Annotation.var "value" ])
                                                                        [ Elm.Case.branch0 "Null" Gen.Json.Encode.null
                                                                        , Elm.Case.branch1 "Present"
                                                                            ( "value", Elm.Annotation.var "value" )
                                                                            (\value -> Elm.apply (schemaToEncoder secondSchema) [ value ])
                                                                        ]
                                                                )

                                                        ( _, Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType ) ->
                                                            Elm.fn ( "nullableValue", Nothing )
                                                                (\nullableValue ->
                                                                    Elm.Case.custom
                                                                        nullableValue
                                                                        (Elm.Annotation.namedWith [] "Nullable" [ Elm.Annotation.var "value" ])
                                                                        [ Elm.Case.branch0 "Null" Gen.Json.Encode.null
                                                                        , Elm.Case.branch1 "Present"
                                                                            ( "value", Elm.Annotation.var "value" )
                                                                            (\value -> Elm.apply (schemaToEncoder firstSchema) [ value ])
                                                                        ]
                                                                )

                                                        _ ->
                                                            Gen.Debug.todo ("decode anyOf 2: not nullable:: " ++ Debug.toString firstSubSchema ++ " ,,, " ++ Debug.toString secondSubSchema)

                                                _ ->
                                                    Gen.Debug.todo "decode anyOf 2: not both object schemas"

                                        manySchemas ->
                                            Gen.Debug.todo "decode anyOf: not exactly 2 items"

                        Just ref ->
                            case String.split "/" ref of
                                [ "#", "components", "schemas", schemaName ] ->
                                    Elm.val ("encode" ++ typifyName schemaName)

                                _ ->
                                    Gen.Debug.todo ("other ref: " ++ ref)

                Json.Schema.Definitions.NullableType singleType ->
                    Elm.fn ( "nullableValue", Nothing )
                        (\nullableValue ->
                            Elm.Case.custom
                                nullableValue
                                (Elm.Annotation.namedWith [] "Nullable" [ Elm.Annotation.var "value" ])
                                [ Elm.Case.branch0 "Null" Gen.Json.Encode.null
                                , Elm.Case.branch1 "Present"
                                    ( "value", Elm.Annotation.var "value" )
                                    (\value -> Elm.apply (singleTypeToDecoder singleType) [ value ])
                                ]
                        )

                Json.Schema.Definitions.UnionType singleTypes ->
                    Gen.Debug.todo "union type"


schemaToDecoder : Json.Schema.Definitions.Schema -> Result ( Path, String ) Elm.Expression
schemaToDecoder schema =
    case schema of
        Json.Schema.Definitions.BooleanSchema bool ->
            Ok (Gen.Debug.todo "")

        Json.Schema.Definitions.ObjectSchema subSchema ->
            let
                singleTypeToDecoder : Json.Schema.Definitions.SingleType -> Result ( Path, String ) Elm.Expression
                singleTypeToDecoder singleType =
                    case singleType of
                        Json.Schema.Definitions.ObjectType ->
                            let
                                properties =
                                    subSchema.properties
                                        |> Maybe.map (\(Json.Schema.Definitions.Schemata schemata) -> schemata)
                                        |> Maybe.withDefault []
                            in
                            List.foldl
                                (\( key, valueSchema ) prevExprRes ->
                                    Result.map2
                                        (\internalDecoder prevExpr ->
                                            Elm.Op.pipe
                                                (Elm.apply
                                                    Gen.Json.Decode.Extra.values_.andMap
                                                    [ Gen.Json.Decode.field key internalDecoder ]
                                                )
                                                prevExpr
                                        )
                                        (schemaToDecoder valueSchema)
                                        prevExprRes
                                )
                                (Ok
                                    (Gen.Json.Decode.succeed
                                        (Elm.function
                                            (List.map (\( key, _ ) -> ( elmifyName key, Nothing )) properties)
                                            (\args ->
                                                Elm.record
                                                    (List.map2
                                                        (\( key, _ ) arg -> ( elmifyName key, arg ))
                                                        properties
                                                        args
                                                    )
                                            )
                                        )
                                    )
                                )
                                properties

                        Json.Schema.Definitions.StringType ->
                            Ok Gen.Json.Decode.string

                        Json.Schema.Definitions.IntegerType ->
                            Ok Gen.Json.Decode.int

                        Json.Schema.Definitions.NumberType ->
                            Ok Gen.Json.Decode.float

                        Json.Schema.Definitions.BooleanType ->
                            Ok Gen.Json.Decode.bool

                        Json.Schema.Definitions.NullType ->
                            Ok (Gen.Debug.todo "null type decoder")

                        Json.Schema.Definitions.ArrayType ->
                            case subSchema.items of
                                Json.Schema.Definitions.NoItems ->
                                    Ok (Gen.Debug.todo "array of nothing?")

                                Json.Schema.Definitions.ArrayOfItems _ ->
                                    Ok (Gen.Debug.todo "array of items")

                                Json.Schema.Definitions.ItemDefinition itemSchema ->
                                    Result.map Gen.Json.Decode.list
                                        (schemaToDecoder itemSchema)
            in
            case subSchema.type_ of
                Json.Schema.Definitions.SingleType singleType ->
                    singleTypeToDecoder singleType

                Json.Schema.Definitions.AnyType ->
                    case subSchema.ref of
                        Nothing ->
                            case subSchema.anyOf of
                                Nothing ->
                                    Ok Gen.Json.Decode.value

                                Just anyOf ->
                                    case anyOf of
                                        [ firstSchema, secondSchema ] ->
                                            case ( firstSchema, secondSchema ) of
                                                ( Json.Schema.Definitions.ObjectSchema firstSubSchema, Json.Schema.Definitions.ObjectSchema secondSubSchema ) ->
                                                    case ( firstSubSchema.type_, secondSubSchema.type_ ) of
                                                        ( Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType, _ ) ->
                                                            Result.map
                                                                (\schemaDecoderExpr ->
                                                                    Gen.Json.Decode.oneOf
                                                                        [ Elm.apply
                                                                            Gen.Json.Decode.values_.map
                                                                            [ Elm.val "Present", schemaDecoderExpr ]
                                                                        , Gen.Json.Decode.null (Elm.val "Null")
                                                                        ]
                                                                )
                                                                (schemaToDecoder secondSchema)

                                                        ( _, Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType ) ->
                                                            Result.map
                                                                (\schemaDecoderExpr ->
                                                                    Gen.Json.Decode.oneOf
                                                                        [ Elm.apply
                                                                            Gen.Json.Decode.values_.map
                                                                            [ Elm.val "Present", schemaDecoderExpr ]
                                                                        , Gen.Json.Decode.null (Elm.val "Null")
                                                                        ]
                                                                )
                                                                (schemaToDecoder firstSchema)

                                                        _ ->
                                                            Ok (Gen.Debug.todo ("decode anyOf 2: not nullable:: " ++ Debug.toString firstSubSchema ++ " ,,, " ++ Debug.toString secondSubSchema))

                                                _ ->
                                                    Ok (Gen.Debug.todo "decode anyOf 2: not both object schemas")

                                        _ ->
                                            Ok (Gen.Debug.todo "decode anyOf: not exactly 2 items")

                        Just ref ->
                            case String.split "/" ref of
                                [ "#", "components", "schemas", schemaName ] ->
                                    Ok (Elm.val ("decode" ++ typifyName schemaName))

                                _ ->
                                    Ok (Gen.Debug.todo ("other ref: " ++ ref))

                Json.Schema.Definitions.NullableType singleType ->
                    Result.map
                        (\nullType ->
                            Gen.Json.Decode.oneOf
                                [ Elm.apply
                                    Gen.Json.Decode.values_.map
                                    [ Elm.val "Present", nullType ]
                                , Gen.Json.Decode.null (Elm.val "Null")
                                ]
                        )
                        (singleTypeToDecoder singleType)

                Json.Schema.Definitions.UnionType singleTypes ->
                    Ok (Gen.Debug.todo "union type")


responseToSchema : OpenApi.Response.Response -> Result String Json.Schema.Definitions.Schema
responseToSchema response =
    Ok response
        |> stepOrFail "Could not get application's application/json content"
            (OpenApi.Response.content
                >> Dict.get "application/json"
            )
        |> stepOrFail "The response's application/json content option doesn't have a schema"
            OpenApi.MediaType.schema
        |> Result.map OpenApi.Schema.get


type alias Path =
    List String


schemaToAnnotation : Json.Schema.Definitions.Schema -> Result ( Path, String ) Elm.Annotation.Annotation
schemaToAnnotation schema =
    case schema of
        Json.Schema.Definitions.BooleanSchema bool ->
            Err ( [], "Todo: boolean schema" )

        Json.Schema.Definitions.ObjectSchema subSchema ->
            let
                nullable : Result ( Path, String ) Elm.Annotation.Annotation -> Result ( Path, String ) Elm.Annotation.Annotation
                nullable =
                    Result.map
                        (\ann ->
                            Elm.Annotation.namedWith []
                                "Nullable"
                                [ ann ]
                        )

                singleTypeToAnnotation singleType =
                    case singleType of
                        Json.Schema.Definitions.ObjectType ->
                            subSchema.properties
                                |> Maybe.map (\(Json.Schema.Definitions.Schemata schemata) -> schemata)
                                |> Maybe.withDefault []
                                |> Result.Extra.combineMap
                                    (\( key, valueSchema ) ->
                                        case schemaToAnnotation valueSchema of
                                            Ok ann ->
                                                Ok ( elmifyName key, ann )

                                            Err ( path, msg ) ->
                                                Err ( key :: path, msg )
                                    )
                                |> Result.map Elm.Annotation.record

                        Json.Schema.Definitions.StringType ->
                            Ok Elm.Annotation.string

                        Json.Schema.Definitions.IntegerType ->
                            Ok Elm.Annotation.int

                        Json.Schema.Definitions.NumberType ->
                            Ok Elm.Annotation.float

                        Json.Schema.Definitions.BooleanType ->
                            Ok Elm.Annotation.bool

                        Json.Schema.Definitions.NullType ->
                            Err ( [], "Null type annotation not supported yet" )

                        Json.Schema.Definitions.ArrayType ->
                            case subSchema.items of
                                Json.Schema.Definitions.NoItems ->
                                    Err ( [], "Found an array type but no items definition" )

                                Json.Schema.Definitions.ArrayOfItems _ ->
                                    Err ( [], "Array of items not supported as item definition yet" )

                                Json.Schema.Definitions.ItemDefinition itemSchema ->
                                    Result.map Elm.Annotation.list (schemaToAnnotation itemSchema)

                enumAnnotation : List Json.Schema.Definitions.Schema -> Result ( Path, String ) Elm.Annotation.Annotation
                enumAnnotation anyOf =
                    intToWord (List.length anyOf)
                        |> Result.mapError (Tuple.pair [])
                        |> Result.andThen
                            (\intWord ->
                                anyOf
                                    |> List.foldr
                                        (\next res ->
                                            Result.map2 (::)
                                                (schemaToAnnotation next)
                                                res
                                        )
                                        (Ok [])
                                    |> Result.map
                                        (Elm.Annotation.namedWith [] (typifyName ("enum_" ++ intWord)))
                            )
            in
            case subSchema.type_ of
                Json.Schema.Definitions.SingleType singleType ->
                    singleTypeToAnnotation singleType

                Json.Schema.Definitions.AnyType ->
                    case subSchema.ref of
                        Nothing ->
                            case subSchema.anyOf of
                                Nothing ->
                                    Ok <| Gen.Json.Encode.annotation_.value

                                Just anyOf ->
                                    case anyOf of
                                        [ firstSchema, secondSchema ] ->
                                            case ( firstSchema, secondSchema ) of
                                                ( Json.Schema.Definitions.ObjectSchema firstSubSchema, Json.Schema.Definitions.ObjectSchema secondSubSchema ) ->
                                                    -- The first 2 cases here are for pseudo-nullable schemas where the higher level schema type is AnyOf
                                                    -- but it's actually made up of only 2 types and 1 of them is nullable. This acts as a hack of sorts to
                                                    -- mark a value as nullable in the schema.
                                                    case ( firstSubSchema.type_, secondSubSchema.type_ ) of
                                                        ( Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType, _ ) ->
                                                            nullable (schemaToAnnotation secondSchema)

                                                        ( _, Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType ) ->
                                                            nullable (schemaToAnnotation firstSchema)

                                                        _ ->
                                                            enumAnnotation anyOf

                                                _ ->
                                                    enumAnnotation anyOf

                                        _ ->
                                            enumAnnotation anyOf

                        Just ref ->
                            case String.split "/" ref of
                                [ "#", "components", "schemas", schemaName ] ->
                                    Ok <| Elm.Annotation.named [] (typifyName schemaName)

                                _ ->
                                    Err ( [], "Todo: some other ref: " ++ ref )

                Json.Schema.Definitions.NullableType singleType ->
                    nullable (singleTypeToAnnotation singleType)

                Json.Schema.Definitions.UnionType singleTypes ->
                    Debug.todo "union type"


makeNamespaceValid : String -> String
makeNamespaceValid str =
    String.map
        (\char ->
            if List.member char invalidModuleNameChars then
                '_'

            else
                char
        )
        str


removeInvalidChars : String -> String
removeInvalidChars str =
    String.filter (\char -> char /= '\'') str


invalidModuleNameChars : List Char
invalidModuleNameChars =
    [ ' '
    , '.'
    , '/'
    , '{'
    , '}'
    , '-'
    ]


intToWord : Int -> Result String String
intToWord i =
    case i of
        1 ->
            Ok "one"

        2 ->
            Ok "two"

        3 ->
            Ok "three"

        4 ->
            Ok "four"

        5 ->
            Ok "five"

        6 ->
            Ok "six"

        7 ->
            Ok "seven"

        8 ->
            Ok "eight"

        9 ->
            Ok "nine"

        10 ->
            Ok "ten"

        11 ->
            Ok "eleven"

        12 ->
            Ok "twelve"

        13 ->
            Ok "thirteen"

        14 ->
            Ok "fourteen"

        15 ->
            Ok "fifteen"

        16 ->
            Ok "sixteen"

        17 ->
            Ok "seventeen"

        18 ->
            Ok "eighteen"

        19 ->
            Ok "nineteen"

        _ ->
            if i < 0 then
                Err "Negative numbers aren't supported"

            else if i == 0 then
                Err "Zero isn't supported"

            else if i == 20 then
                Ok "twenty"

            else if i < 30 then
                intToWord (i - 20)
                    |> Result.map (\ones -> "twenty-" ++ ones)

            else if i == 30 then
                Ok "thirty"

            else if i < 40 then
                intToWord (i - 30)
                    |> Result.map (\ones -> "thirty-" ++ ones)

            else if i == 40 then
                Ok "forty"

            else if i < 50 then
                intToWord (i - 40)
                    |> Result.map (\ones -> "forty-" ++ ones)

            else if i == 50 then
                Ok "fifty"

            else if i < 60 then
                intToWord (i - 50)
                    |> Result.map (\ones -> "fifty-" ++ ones)

            else if i == 60 then
                Ok "sixty"

            else if i < 70 then
                intToWord (i - 60)
                    |> Result.map (\ones -> "sixty-" ++ ones)

            else if i == 70 then
                Ok "seventy"

            else if i < 80 then
                intToWord (i - 70)
                    |> Result.map (\ones -> "seventy-" ++ ones)

            else if i == 80 then
                Ok "eighty"

            else if i < 90 then
                intToWord (i - 80)
                    |> Result.map (\ones -> "eighty-" ++ ones)

            else if i == 90 then
                Ok "ninety"

            else if i < 100 then
                intToWord (i - 90)
                    |> Result.map (\ones -> "ninety-" ++ ones)

            else
                Err ("Numbers larger than 99 aren't currently supported and I got an " ++ String.fromInt i)
