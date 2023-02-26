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
import OpenApi.Response
import OpenApi.Schema
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
                |> Dict.foldl
                    (\url path res ->
                        [ path
                            |> OpenApi.Path.get
                            |> Maybe.map (toRequestFunction apiSpec url)
                        ]
                            |> List.filterMap identity
                            |> (++) res
                    )
                    []

        componentDeclarations =
            apiSpec
                |> OpenApi.components
                |> Maybe.map OpenApi.Components.schemas
                |> Maybe.withDefault Dict.empty
                |> Dict.foldl
                    (\name schema ->
                        schemaToAnnotation (OpenApi.Schema.get schema)
                            |> Result.mapError (\( path, msg ) -> ( name :: path, msg ))
                            |> Result.map2
                                (\ann res ->
                                    [ Elm.alias (typifyName name) ann
                                    , Elm.Declare.function ("decode" ++ typifyName name)
                                        []
                                        (\_ ->
                                            schemaToDecoder (OpenApi.Schema.get schema)
                                                |> Elm.withType (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.named [] (typifyName name)))
                                        )
                                        |> .declaration
                                    , Elm.Declare.function ("encode" ++ typifyName name)
                                        []
                                        (\_ ->
                                            schemaToEncoder (OpenApi.Schema.get schema)
                                                |> Elm.withType (Elm.Annotation.function [ Elm.Annotation.named [] (typifyName name) ] Gen.Json.Encode.annotation_.value)
                                        )
                                        |> .declaration
                                    ]
                                        :: res
                                )
                    )
                    (Ok [])
                |> (\r ->
                        case r of
                            Ok lst ->
                                List.concat lst

                            Err ( path, e ) ->
                                Debug.todo <| "Error " ++ e ++ " at path " ++ String.join "." path
                   )

        file =
            Elm.file [ fileNamespace ]
                (pathDeclarations
                    ++ (nullableType :: componentDeclarations)
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


toRequestFunction : OpenApi -> String -> OpenApi.Operation.Operation -> Elm.Declaration
toRequestFunction apiSpec url operation =
    let
        responses : Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response)
        responses =
            OpenApi.Operation.responses operation

        stepOrFail msg f =
            Result.andThen
                (\y ->
                    case f y of
                        Just z ->
                            Ok z

                        Nothing ->
                            Err <| "Couldn't find a response decoder. " ++ msg
                )

        fromResult r =
            case r of
                Ok t ->
                    t

                Err msg ->
                    ( Elm.Annotation.var "todo"
                    , Gen.Debug.todo msg
                    )

        ( successType, successDecoder ) =
            Ok responses
                |> stepOrFail
                    ("Among the "
                        ++ String.fromInt (Dict.size responses)
                        ++ " possible responses, there was no successfull one."
                    )
                    getFirstSuccessResponse
                |> stepOrFail "I found a successfull response, but I couldn't convert it to a concrete one"
                    OpenApi.Reference.toConcrete
                |> stepOrFail "The response doesn't have an application/json content option"
                    (OpenApi.Response.content
                        >> Dict.get "application/json"
                    )
                |> stepOrFail "The response's application/json content option doesn't have a schema"
                    OpenApi.MediaType.schema
                |> stepOrFail "Couldn't get the object schema for the response"
                    (OpenApi.Schema.get >> toObjectSchema)
                |> stepOrFail "Couldn't get the type ref for the response"
                    (.ref >> Maybe.andThen (schemaTypeRef apiSpec))
                |> Result.map
                    (\st ->
                        ( Elm.Annotation.named [] st
                        , Elm.val ("decode" ++ st)
                        )
                    )
                |> fromResult
    in
    Elm.Declare.fn
        ((OpenApi.Operation.operationId operation
            |> Maybe.withDefault url
         )
            |> makeNamespaceValid
            |> removeInvalidChars
            |> String.Extra.camelize
        )
        ( "toMsg"
        , Just
            (Elm.Annotation.function
                [ Gen.Result.annotation_.result Gen.Http.annotation_.error successType ]
                (Elm.Annotation.var "msg")
            )
        )
        (\toMsg ->
            Gen.Http.get
                { url = url
                , expect =
                    Gen.Http.expectJson
                        (\result -> Elm.apply toMsg [ result ])
                        successDecoder
                }
        )
        |> .declaration


schemaTypeRef : OpenApi -> String -> Maybe String
schemaTypeRef openApi refUri =
    case String.split "/" refUri of
        [ "#", "components", "schemas", schemaName ] ->
            Just (typifyName schemaName)

        _ ->
            Nothing


toObjectSchema : Json.Schema.Definitions.Schema -> Maybe Json.Schema.Definitions.SubSchema
toObjectSchema schema =
    case schema of
        Json.Schema.Definitions.BooleanSchema _ ->
            Nothing

        Json.Schema.Definitions.ObjectSchema subSchema ->
            Just subSchema


getFirstSuccessResponse : Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response) -> Maybe (OpenApi.Reference.ReferenceOr OpenApi.Response.Response)
getFirstSuccessResponse responses =
    responses
        |> Dict.toList
        |> List.filter (\( statusCode, _ ) -> String.startsWith "2" statusCode)
        |> List.head
        |> Maybe.map Tuple.second


nullableType =
    Elm.customType "Nullable"
        [ Elm.variant "Null"
        , Elm.variantWith "Present" [ Elm.Annotation.var "value" ]
        ]


typifyName : String -> String
typifyName name =
    name
        |> String.replace "-" " "
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


schemaToDecoder : Json.Schema.Definitions.Schema -> Elm.Expression
schemaToDecoder schema =
    case schema of
        Json.Schema.Definitions.BooleanSchema bool ->
            Gen.Debug.todo ""

        Json.Schema.Definitions.ObjectSchema subSchema ->
            let
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
                                (\( key, valueSchema ) prevExpr ->
                                    Elm.Op.pipe
                                        (Elm.apply
                                            Gen.Json.Decode.Extra.values_.andMap
                                            [ Gen.Json.Decode.field key (schemaToDecoder valueSchema) ]
                                        )
                                        prevExpr
                                )
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
                                properties

                        Json.Schema.Definitions.StringType ->
                            Gen.Json.Decode.string

                        Json.Schema.Definitions.IntegerType ->
                            Gen.Json.Decode.int

                        Json.Schema.Definitions.NumberType ->
                            Gen.Json.Decode.float

                        Json.Schema.Definitions.BooleanType ->
                            Gen.Json.Decode.bool

                        Json.Schema.Definitions.NullType ->
                            Gen.Debug.todo ""

                        Json.Schema.Definitions.ArrayType ->
                            case subSchema.items of
                                Json.Schema.Definitions.NoItems ->
                                    Gen.Debug.todo "err"

                                Json.Schema.Definitions.ArrayOfItems _ ->
                                    Gen.Debug.todo ""

                                Json.Schema.Definitions.ItemDefinition itemSchema ->
                                    Gen.Json.Decode.list (schemaToDecoder itemSchema)
            in
            case subSchema.type_ of
                Json.Schema.Definitions.SingleType singleType ->
                    singleTypeToDecoder singleType

                Json.Schema.Definitions.AnyType ->
                    case subSchema.ref of
                        Nothing ->
                            case subSchema.anyOf of
                                Nothing ->
                                    Gen.Json.Decode.value

                                Just anyOf ->
                                    case anyOf of
                                        [ firstSchema, secondSchema ] ->
                                            case ( firstSchema, secondSchema ) of
                                                ( Json.Schema.Definitions.ObjectSchema firstSubSchema, Json.Schema.Definitions.ObjectSchema secondSubSchema ) ->
                                                    case ( firstSubSchema.type_, secondSubSchema.type_ ) of
                                                        ( Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType, _ ) ->
                                                            Gen.Json.Decode.oneOf
                                                                [ Elm.apply
                                                                    Gen.Json.Decode.values_.map
                                                                    [ Elm.val "Present", schemaToDecoder secondSchema ]
                                                                , Gen.Json.Decode.null (Elm.val "Null")
                                                                ]

                                                        ( _, Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType ) ->
                                                            Gen.Json.Decode.oneOf
                                                                [ Elm.apply
                                                                    Gen.Json.Decode.values_.map
                                                                    [ Elm.val "Present", schemaToDecoder firstSchema ]
                                                                , Gen.Json.Decode.null (Elm.val "Null")
                                                                ]

                                                        _ ->
                                                            Gen.Debug.todo ("decode anyOf 2: not nullable:: " ++ Debug.toString firstSubSchema ++ " ,,, " ++ Debug.toString secondSubSchema)

                                                _ ->
                                                    Gen.Debug.todo "decode anyOf 2: not both object schemas"

                                        _ ->
                                            Gen.Debug.todo "decode anyOf: not exactly 2 items"

                        Just ref ->
                            case String.split "/" ref of
                                [ "#", "components", "schemas", schemaName ] ->
                                    Elm.val ("decode" ++ typifyName schemaName)

                                _ ->
                                    Gen.Debug.todo ("other ref: " ++ ref)

                Json.Schema.Definitions.NullableType singleType ->
                    Gen.Json.Decode.oneOf
                        [ Elm.apply
                            Gen.Json.Decode.values_.map
                            [ Elm.val "Present", singleTypeToDecoder singleType ]
                        , Gen.Json.Decode.null (Elm.val "Null")
                        ]

                Json.Schema.Definitions.UnionType singleTypes ->
                    Gen.Debug.todo "union type"


type alias Path =
    List String


schemaToAnnotation : Json.Schema.Definitions.Schema -> Result ( Path, String ) Elm.Annotation.Annotation
schemaToAnnotation schema =
    let
        nullable : Result ( Path, String ) Elm.Annotation.Annotation -> Result ( Path, String ) Elm.Annotation.Annotation
        nullable =
            Result.map
                (\ann ->
                    Elm.Annotation.namedWith []
                        "Nullable"
                        [ ann ]
                )
    in
    case schema of
        Json.Schema.Definitions.BooleanSchema bool ->
            Err ( [], "Todo: boolean schema" )

        Json.Schema.Definitions.ObjectSchema subSchema ->
            let
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
                                                    case ( firstSubSchema.type_, secondSubSchema.type_ ) of
                                                        ( Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType, _ ) ->
                                                            nullable (schemaToAnnotation secondSchema)

                                                        ( _, Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType ) ->
                                                            nullable (schemaToAnnotation firstSchema)

                                                        _ ->
                                                            Err ( [], "Todo: AnyOf (except if one is nullable)" )

                                                _ ->
                                                    Err ( [], "Todo: AnyOf (when not both ObjectSchemas)" )

                                        _ ->
                                            Err ( [], "Todo: AnyOf (when not exactly 2 items)" )

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
