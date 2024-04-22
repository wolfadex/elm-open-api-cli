module ExampleGH exposing (main)

-- import BimcloudApi20232AlphaRelease

import AirlineCodeLookupApi
import Browser
import Bytes
import Bytes.Decode
import GithubV3RestApi
import Http
import OpenApi
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
    , Cmd.batch
        [ RealworldConduitApi.getArticle
            { toMsg = ConduitResponse
            , params = { slug = "" }
            }
        , AirlineCodeLookupApi.getairlines
            { toMsg = AmadeusResponse
            , params = { airlineCodes = Nothing }
            }

        -- , BimcloudApi20232AlphaRelease.blobStoreService10BeginBatchUpload
        --     { toMsg = BimResponse
        --     , params = { sessionMinusid = Nothing, description = Nothing }
        --     }
        , GithubV3RestApi.metaRoot { toMsg = GithubResponse }
        ]
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


type Msg
    = ConduitResponse (Result (OpenApi.Error RealworldConduitApi.GetArticle_Error String) RealworldConduitApi.SingleArticleResponse)
    | AmadeusResponse (Result (OpenApi.Error AirlineCodeLookupApi.Getairlines_Error String) AirlineCodeLookupApi.Airlines)
      -- | BimResponse (Result (OpenApi.Error BimcloudApi20232AlphaRelease.BlobStoreService10BeginBatchUpload_Error Bytes.Bytes) Bytes.Bytes)
    | GithubResponse (Result (OpenApi.Error () String) GithubV3RestApi.Root)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ConduitResponse response ->
            ( model, Cmd.none )

        AmadeusResponse response ->
            ( model, Cmd.none )

        -- BimResponse response ->
        --     ( model, Cmd.none )
        GithubResponse response ->
            ( model, Cmd.none )


view : Model -> Browser.Document Msg
view _ =
    { title = "Example SDK Usage"
    , body = []
    }
