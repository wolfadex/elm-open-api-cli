port module Main exposing (main)

import Dict
import Elm
import Elm.Annotation
import Elm.Declare
import Gen.Http
import Json.Decode
import Json.Encode exposing (Value)
import OpenApi exposing (OpenApi)
import OpenApi.Components exposing (schemas)
import OpenApi.Info
import OpenApi.Operation
import OpenApi.Path
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
                                                        (("get" ++ url)
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

                        componentsDeclarations =
                            apiSpec
                                |> OpenApi.components
                                |> Maybe.map OpenApi.Components.schemas
                                |> Maybe.withDefault Dict.empty

                        file =
                            Elm.file [ namespace ]
                                pathDeclarations
                      in
                      writeFile ( file.path, file.contents )
                    )

                Err err ->
                    ( model
                    , err
                        |> Json.Decode.errorToString
                        |> writeMsg
                    )


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
