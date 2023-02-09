port module Main exposing (main)

import Dict
import Elm
import Elm.Annotation
import Elm.Case
import Elm.Declare
import Elm.Op
import Gen.Debug
import Gen.Http
import Gen.Json.Decode
import Gen.Json.Decode.Extra
import Gen.Json.Encode
import Json.Decode
import Json.Encode exposing (Value)
import Json.Schema
import Json.Schema.Definitions
import OpenApi exposing (OpenApi)
import OpenApi.Components
import OpenApi.Info
import OpenApi.Operation
import OpenApi.Path
import OpenApi.Schema
import String.Extra


main : Program () Model Msg
main =
    Platform.worker
        { init = init
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    {}


init : () -> ( Model, Cmd Msg )
init () =
    ( {}
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    gotSpec GotSpec


port gotSpec : (Value -> msg) -> Sub msg


port writeMsg : String -> Cmd msg


port writeFile : ( String, String ) -> Cmd msg


type Msg
    = GotSpec Value


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotSpec specValue ->
            case Json.Decode.decodeValue OpenApi.decode specValue of
                Ok apiSpec ->
                    ( model
                    , let
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
                                                    Elm.Declare.fn
                                                        ((OpenApi.Operation.operationId operation
                                                            |> Maybe.withDefault url
                                                         )
                                                            |> makeNamespaceValid
                                                            |> removeInvlidChars
                                                            |> String.Extra.camelize
                                                        )
                                                        ( "toMsg", Nothing )
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
                      in
                      writeFile ( file.path, file.contents )
                    )

                Err err ->
                    ( model
                    , err
                        |> Json.Decode.errorToString
                        |> writeMsg
                    )


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
                                    Gen.Json.Decode.value

                                Just anyOf ->
                                    -- Elm.Annotation.named [ "Debug" ] "Todo"
                                    Gen.Debug.todo "decode anyOf"

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
                                    -- Elm.Annotation.named [ "Debug" ] "Todo"
                                    Gen.Debug.todo "decode anyOf"

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
                                    Elm.Annotation.named [ "Debug" ] "Todo"

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
