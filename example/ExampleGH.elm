module ExampleGH exposing (main)

import Browser
import GitHub_v3_REST_API
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
    , GitHub_v3_REST_API.metaRoot
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


type Msg
    = RootResponse (Result Http.Error GitHub_v3_REST_API.Root)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RootResponse response ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view _ =
    { title = "Example SDK Usage"
    , body = []
    }
