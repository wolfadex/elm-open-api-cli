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
import Gen.Platform.Cmd
import Gen.Result
import Json.Decode
import Json.Encode exposing (Value)
import Json.Schema
import Json.Schema.Definitions
import OpenApi exposing (OpenApi)
import OpenApi.Components
import OpenApi.Info
import OpenApi.Operation
import OpenApi.Path
import OpenApi.Reference
import OpenApi.Response
import OpenApi.Schema
import Pages.Script
import Path
import String.Extra


type alias CliOptions =
    { entryFilePath : String
    , outputFile : Maybe String
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
            )


run : Pages.Script.Script
run =
    Pages.Script.withCliOptions program
        (\{ entryFilePath, outputFile } ->
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
                |> BackendTask.andThen (generateFileFromOpenApiSpec outputFile)
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


generateFileFromOpenApiSpec : Maybe String -> OpenApi.OpenApi -> BackendTask.BackendTask FatalError.FatalError ()
generateFileFromOpenApiSpec outputFile apiSpec =
    let
        namespace : String
        namespace =
            apiSpec
                |> OpenApi.info
                |> OpenApi.Info.title
                |> makeNamespaceValid
                |> removeInvlidChars

        pathDeclarations =
            apiSpec
                |> OpenApi.paths
                |> Dict.foldl
                    (\url path res ->
                        [ path
                            |> OpenApi.Path.get
                            |> Maybe.map
                                (\operation ->
                                    let
                                        maybeFirstSuccessResponse =
                                            operation
                                                |> OpenApi.Operation.responses
                                                |> getFirstSuccessResponse
                                    in
                                    Elm.Declare.fn
                                        ((OpenApi.Operation.operationId operation
                                            |> Maybe.withDefault url
                                         )
                                            |> makeNamespaceValid
                                            |> removeInvlidChars
                                            |> String.Extra.camelize
                                        )
                                        ( "toMsg"
                                        , Just
                                            (Elm.Annotation.function
                                                [ Gen.Result.annotation_.result Gen.Http.annotation_.error (Elm.Annotation.var "todo") ]
                                                (Elm.Annotation.var "msg")
                                            )
                                        )
                                        (\toMsg ->
                                            Gen.Http.get
                                                { url = url
                                                , expect =
                                                    Gen.Http.expectJson
                                                        (\result -> Elm.apply toMsg [ result ])
                                                        (Gen.Debug.todo "todo")
                                                }
                                        )
                                        |> .declaration
                                )
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
                    (\name schema res ->
                        [ Elm.alias (typifyName name)
                            (schemaToAnnotation (OpenApi.Schema.get schema))
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
                    []
                |> List.concat

        file =
            Elm.file [ namespace ]
                (pathDeclarations
                    ++ (nullableType :: componentDeclarations)
                )

        outputPath =
            [ "generated", file.path ]
                |> Path.join
                |> Path.toRelative
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
            Debug.todo ""

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
                            Elm.value
                                { importFrom = [ "Json", "Encode" ]
                                , name = "string"
                                , annotation = Nothing
                                }

                        Json.Schema.Definitions.IntegerType ->
                            Elm.value
                                { importFrom = [ "Json", "Encode" ]
                                , name = "int"
                                , annotation = Nothing
                                }

                        Json.Schema.Definitions.NumberType ->
                            Elm.value
                                { importFrom = [ "Json", "Encode" ]
                                , name = "float"
                                , annotation = Nothing
                                }

                        Json.Schema.Definitions.BooleanType ->
                            Elm.value
                                { importFrom = [ "Json", "Encode" ]
                                , name = "bool"
                                , annotation = Nothing
                                }

                        Json.Schema.Definitions.NullType ->
                            Debug.todo ""

                        Json.Schema.Definitions.ArrayType ->
                            case subSchema.items of
                                Json.Schema.Definitions.NoItems ->
                                    Debug.todo "err"

                                Json.Schema.Definitions.ArrayOfItems _ ->
                                    Debug.todo ""

                                Json.Schema.Definitions.ItemDefinition itemSchema ->
                                    Elm.apply
                                        (Elm.value
                                            { importFrom = [ "Json", "Encode" ]
                                            , name = "list"
                                            , annotation = Nothing
                                            }
                                        )
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
                                    Debug.todo ("other ref: " ++ ref)

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
                    Debug.todo "union type"


schemaToDecoder : Json.Schema.Definitions.Schema -> Elm.Expression
schemaToDecoder schema =
    case schema of
        Json.Schema.Definitions.BooleanSchema bool ->
            Debug.todo ""

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
                                            (Elm.value
                                                { importFrom = [ "Json", "Decode", "Extra" ]
                                                , name = "andMap"
                                                , annotation = Nothing
                                                }
                                            )
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
                            Debug.todo ""

                        Json.Schema.Definitions.ArrayType ->
                            case subSchema.items of
                                Json.Schema.Definitions.NoItems ->
                                    Debug.todo "err"

                                Json.Schema.Definitions.ArrayOfItems _ ->
                                    Debug.todo ""

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
                                                                    (Elm.value
                                                                        { importFrom = [ "Json", "Decode" ]
                                                                        , name = "map"
                                                                        , annotation = Nothing
                                                                        }
                                                                    )
                                                                    [ Elm.val "Present", schemaToDecoder secondSchema ]
                                                                , Gen.Json.Decode.null (Elm.val "Null")
                                                                ]

                                                        ( _, Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType ) ->
                                                            Gen.Json.Decode.oneOf
                                                                [ Elm.apply
                                                                    (Elm.value
                                                                        { importFrom = [ "Json", "Decode" ]
                                                                        , name = "map"
                                                                        , annotation = Nothing
                                                                        }
                                                                    )
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
                                    Debug.todo ("other ref: " ++ ref)

                Json.Schema.Definitions.NullableType singleType ->
                    Gen.Json.Decode.oneOf
                        [ Elm.apply
                            (Elm.value
                                { importFrom = [ "Json", "Decode" ]
                                , name = "map"
                                , annotation = Nothing
                                }
                            )
                            [ Elm.val "Present", singleTypeToDecoder singleType ]
                        , Gen.Json.Decode.null (Elm.val "Null")
                        ]

                Json.Schema.Definitions.UnionType singleTypes ->
                    Debug.todo "union type"


schemaToAnnotation : Json.Schema.Definitions.Schema -> Elm.Annotation.Annotation
schemaToAnnotation schema =
    case schema of
        Json.Schema.Definitions.BooleanSchema bool ->
            Debug.todo ""

        Json.Schema.Definitions.ObjectSchema subSchema ->
            let
                singleTypeToAnnotation singleType =
                    case singleType of
                        Json.Schema.Definitions.ObjectType ->
                            subSchema.properties
                                |> Maybe.map (\(Json.Schema.Definitions.Schemata schemata) -> schemata)
                                |> Maybe.withDefault []
                                |> List.map
                                    (\( key, valueSchema ) ->
                                        ( elmifyName key, schemaToAnnotation valueSchema )
                                    )
                                |> Elm.Annotation.record

                        Json.Schema.Definitions.StringType ->
                            Elm.Annotation.string

                        Json.Schema.Definitions.IntegerType ->
                            Elm.Annotation.int

                        Json.Schema.Definitions.NumberType ->
                            Elm.Annotation.float

                        Json.Schema.Definitions.BooleanType ->
                            Elm.Annotation.bool

                        Json.Schema.Definitions.NullType ->
                            Debug.todo ""

                        Json.Schema.Definitions.ArrayType ->
                            case subSchema.items of
                                Json.Schema.Definitions.NoItems ->
                                    Debug.todo "err"

                                Json.Schema.Definitions.ArrayOfItems _ ->
                                    Debug.todo ""

                                Json.Schema.Definitions.ItemDefinition itemSchema ->
                                    Elm.Annotation.list (schemaToAnnotation itemSchema)
            in
            case subSchema.type_ of
                Json.Schema.Definitions.SingleType singleType ->
                    singleTypeToAnnotation singleType

                Json.Schema.Definitions.AnyType ->
                    case subSchema.ref of
                        Nothing ->
                            case subSchema.anyOf of
                                Nothing ->
                                    Elm.Annotation.named [ "Json", "Encode" ] "Value"

                                Just anyOf ->
                                    case anyOf of
                                        [ firstSchema, secondSchema ] ->
                                            case ( firstSchema, secondSchema ) of
                                                ( Json.Schema.Definitions.ObjectSchema firstSubSchema, Json.Schema.Definitions.ObjectSchema secondSubSchema ) ->
                                                    case ( firstSubSchema.type_, secondSubSchema.type_ ) of
                                                        ( Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType, _ ) ->
                                                            Elm.Annotation.namedWith []
                                                                "Nullable"
                                                                [ schemaToAnnotation secondSchema ]

                                                        ( _, Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType ) ->
                                                            Elm.Annotation.namedWith []
                                                                "Nullable"
                                                                [ schemaToAnnotation firstSchema ]

                                                        _ ->
                                                            Elm.Annotation.named [ "Debug", "Todo" ] "AnyOfOneNotNullable"

                                                _ ->
                                                    Elm.Annotation.named [ "Debug", "Todo" ] "AnyOfNotBothObjectSchemas"

                                        _ ->
                                            Elm.Annotation.named [ "Debug", "Todo" ] "AnyOfNotExactly2Items"

                        Just ref ->
                            case String.split "/" ref of
                                [ "#", "components", "schemas", schemaName ] ->
                                    Elm.Annotation.named [] (typifyName schemaName)

                                _ ->
                                    Debug.todo ("other ref: " ++ ref)

                Json.Schema.Definitions.NullableType singleType ->
                    Elm.Annotation.namedWith []
                        "Nullable"
                        [ singleTypeToAnnotation singleType ]

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


removeInvlidChars : String -> String
removeInvlidChars str =
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
