port module Main exposing (main)

import Dict
import Elm
import Elm.Annotation
import Elm.Declare
import Gen.Http
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
                                                                        (Elm.int 55)
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
                                        Elm.alias (typifyName name)
                                            (schemaToAnnotation (OpenApi.Schema.get schema))
                                            :: res
                                    )
                                    []

                        file =
                            Elm.file [ namespace ]
                                (pathDeclarations ++ componentDeclarations)
                      in
                      writeFile ( file.path, file.contents )
                    )

                Err err ->
                    ( model
                    , err
                        |> Json.Decode.errorToString
                        |> writeMsg
                    )


typifyName : String -> String
typifyName name =
    name
        |> String.replace "-" " "
        |> String.replace "_" " "
        |> String.Extra.toTitleCase
        |> String.replace " " ""


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
                                        ( key, schemaToAnnotation valueSchema )
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
                    Elm.Annotation.maybe (singleTypeToAnnotation singleType)

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
    ]
