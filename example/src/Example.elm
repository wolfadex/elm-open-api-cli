module Example exposing (main)

-- import BimcloudApi20232AlphaRelease

import AirlineCodeLookupApi.Api
import AirlineCodeLookupApi.Types
import Browser
import GithubV3RestApi.Api
import GithubV3RestApi.Types
import OpenApi.Common
import RealworldConduitApi.Api
import RealworldConduitApi.Types


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
        [ RealworldConduitApi.Api.getArticle
            { toMsg = ConduitResponse
            , params = { slug = "" }
            }
        , AirlineCodeLookupApi.Api.getairlines
            { toMsg = AmadeusResponse
            , params = { airlineCodes = Nothing }
            }

        -- , BimcloudApi20232AlphaRelease.blobStoreService10BeginBatchUpload
        --     { toMsg = BimResponse
        --     , params = { sessionMinusid = Nothing, description = Nothing }
        --     }
        , GithubV3RestApi.Api.metaRoot { toMsg = GithubResponse }
        ]
    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


type Msg
    = ConduitResponse (Result (OpenApi.Common.Error RealworldConduitApi.Types.GetArticle_Error String) RealworldConduitApi.Types.SingleArticleResponse)
    | AmadeusResponse (Result (OpenApi.Common.Error AirlineCodeLookupApi.Types.Getairlines_Error String) AirlineCodeLookupApi.Types.Airlines)
      -- | BimResponse (Result (OpenApi.Common.Error BimcloudApi20232AlphaRelease.BlobStoreService10BeginBatchUpload_Error Bytes.Bytes) Bytes.Bytes)
    | GithubResponse (Result (OpenApi.Common.Error () String) GithubV3RestApi.Types.Root)


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
