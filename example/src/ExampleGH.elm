module ExampleGH exposing (main)

import Browser
import Http
import RealworldConduitApi


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
    , RealworldConduitApi.getArticle { toMsg = ApiResponse, params = { slug = "" } }
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


type Msg
    = ApiResponse (Result (RealworldConduitApi.Error RealworldConduitApi.GetArticle_Error String) RealworldConduitApi.SingleArticleResponse)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ApiResponse response ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view _ =
    { title = "Example SDK Usage"
    , body = []
    }
