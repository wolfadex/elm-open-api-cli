module Main exposing (main)

import Browser
import Html
import Http
import OpenApi exposing (OpenApi)


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { githubOpenApiSpec : Result Http.Error OpenApi
    }


init : () -> ( Model, Cmd Msg )
init () =
    ( { githubOpenApiSpec = Err (Http.BadStatus -999) }
    , Http.get
        { url = "https://raw.githubusercontent.com/github/rest-api-description/main/descriptions-next/api.github.com/api.github.com.json"

        -- { url = "github-openapi-spec-full.json"
        , expect = Http.expectJson GitHubOpenApiSpecResponse OpenApi.decode
        }
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


type Msg
    = NoOp
    | GitHubOpenApiSpecResponse (Result Http.Error OpenApi)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        GitHubOpenApiSpecResponse response ->
            ( { model | githubOpenApiSpec = response }, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    { title = "Elm Nix"
    , body =
        [ case model.githubOpenApiSpec of
            Ok api ->
                Html.text "Success!"

            Err err ->
                Html.text <|
                    case err of
                        Http.BadStatus _ ->
                            "bad status"

                        Http.BadUrl _ ->
                            "bad url"

                        Http.NetworkError ->
                            "network error"

                        Http.Timeout ->
                            "timeout"

                        Http.BadBody body ->
                            body
        ]
    }
