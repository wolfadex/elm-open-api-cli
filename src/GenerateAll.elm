module GenerateAll exposing (run)

import Ansi.Color
import BackendTask
import Cli
import OpenApi.Config as Config exposing (Config)
import Pages.Script exposing (Script)


{-| Generate various SDKs as test cases, all at once.

    This saves a lot of time versus running the generator on one OAS at a time.

-}
run : Script
run =
    let
        recursiveAllofRefs : Config.Input
        recursiveAllofRefs =
            Config.inputFrom (Config.File "./example/recursive-allof-refs.yaml")

        singleEnum : Config.Input
        singleEnum =
            Config.inputFrom (Config.File "./example/single-enum.yaml")

        patreon : Config.Input
        patreon =
            Config.inputFrom (Config.File "./example/patreon.json")

        realworldConduit : Config.Input
        realworldConduit =
            Config.inputFrom (Config.File "./example/realworld-conduit.yaml")

        amadeusAirlineLookup : Config.Input
        amadeusAirlineLookup =
            Config.inputFrom (Config.File "./example/amadeus-airline-lookup.json")

        dbFahrplanApi : Config.Input
        dbFahrplanApi =
            Config.inputFrom (Config.File "./example/db-fahrplan-api-specification.yaml")

        marioPartyStats : Config.Input
        marioPartyStats =
            Config.inputFrom (Config.File "./example/MarioPartyStats.json")

        viaggiatreno : Config.Input
        viaggiatreno =
            Config.inputFrom (Config.File "./example/viaggiatreno.yaml")

        trustmark : Config.Input
        trustmark =
            Config.inputFrom (Config.File "./example/trustmark.json")
                |> Config.withOutputModuleName [ "Trustmark" ]
                |> Config.withEffectTypes [ Config.ElmHttpCmd ]
                |> Config.withServer (Config.Single "https://api.sandbox.retrofitintegration.data-hub.org.uk")

        trustmarkTradeCheck : Config.Input
        trustmarkTradeCheck =
            Config.inputFrom (Config.File "./example/trustmark-trade-check.json")
                |> Config.withOutputModuleName [ "Trustmark", "TradeCheck" ]
                |> Config.withEffectTypes [ Config.ElmHttpCmd ]

        gitHub : Config.Input
        gitHub =
            Config.inputFrom (Config.File "./example/github-spec.json")

        config : Config
        config =
            Config.init "./generated"
                |> Config.withInput recursiveAllofRefs
                |> Config.withInput singleEnum
                |> Config.withInput patreon
                |> Config.withInput realworldConduit
                |> Config.withInput amadeusAirlineLookup
                |> Config.withInput dbFahrplanApi
                |> Config.withInput marioPartyStats
                |> Config.withInput viaggiatreno
                |> Config.withInput trustmark
                |> Config.withInput trustmarkTradeCheck
                |> Config.withInput gitHub
                |> Config.withAutoConvertSwagger True
    in
    Pages.Script.withoutCliOptions
        (BackendTask.doEach
            [ Cli.withConfig config
            , "\nCompiling Example app"
                |> Ansi.Color.fontColor Ansi.Color.brightGreen
                |> Pages.Script.log
            , Pages.Script.exec "sh" [ "-c", "cd example && npx --no -- elm make src/Example.elm --output=/dev/null" ]
            ]
        )
