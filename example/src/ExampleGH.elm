module ExampleGH exposing (main)

import Browser
import GitHubV3RestApi.Api
import GitHubV3RestApi.OpenApi
import GitHubV3RestApi.OpenApi.Util
import GitHubV3RestApi.Schema
import Http


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }


type alias Model =
    {}


init : () -> ( Model, Cmd Msg )
init () =
    ( {}
    , GitHubV3RestApi.Api.metaRoot { toMsg = RootResponsed }
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


type Msg
    = RootResponsed (Result Http.Error GitHubV3RestApi.Api.Root)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RootResponsed response ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view _ =
    { title = "Example SDK Usage"
    , body = []
    }
