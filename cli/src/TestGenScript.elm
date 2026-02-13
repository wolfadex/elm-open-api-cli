module TestGenScript exposing (run)

import Ansi.Color
import BackendTask exposing (BackendTask)
import BackendTask.Custom
import Cli
import Cli.Option
import Cli.OptionsParser
import Cli.Program
import FatalError exposing (FatalError)
import Json.Decode
import Json.Encode
import OpenApi.Config
import Pages.Script


{-| Generate various SDKs as test cases, all at once.

    This is more than twice as fast as running the generator separately for
    each OAS.

-}
run : Pages.Script.Script
run =
    let
        additionalProperties : OpenApi.Config.Input
        additionalProperties =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/additional-properties.yaml")

        recursiveAllofRefs : OpenApi.Config.Input
        recursiveAllofRefs =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/recursive-allof-refs.yaml")

        overridingGlobalSecurity : OpenApi.Config.Input
        overridingGlobalSecurity =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/overriding-global-security.yaml")
                |> OpenApi.Config.withOverrides [ OpenApi.Config.File "./example/overriding-global-security-override.yaml" ]

        singleEnum : OpenApi.Config.Input
        singleEnum =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/single-enum.yaml")

        patreon : OpenApi.Config.Input
        patreon =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/patreon.json")

        realworldConduit : OpenApi.Config.Input
        realworldConduit =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/realworld-conduit.yaml")

        amadeusAirlineLookup : OpenApi.Config.Input
        amadeusAirlineLookup =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/amadeus-airline-lookup.json")

        dbFahrplanApi : OpenApi.Config.Input
        dbFahrplanApi =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/db-fahrplan-api-specification.yaml")

        marioPartyStats : OpenApi.Config.Input
        marioPartyStats =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/MarioPartyStats.json")

        viaggiatreno : OpenApi.Config.Input
        viaggiatreno =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/viaggiatreno.yaml")

        trustmark : OpenApi.Config.Input
        trustmark =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/trustmark.json")
                |> OpenApi.Config.withOutputModuleName [ "Trustmark" ]
                |> OpenApi.Config.withEffectTypes [ OpenApi.Config.ElmHttpCmd ]
                |> OpenApi.Config.withServer (OpenApi.Config.Single "https://api.sandbox.retrofitintegration.data-hub.org.uk")

        trustmarkTradeCheck : OpenApi.Config.Input
        trustmarkTradeCheck =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/trustmark-trade-check.json")
                |> OpenApi.Config.withOutputModuleName [ "Trustmark", "TradeCheck" ]
                |> OpenApi.Config.withEffectTypes [ OpenApi.Config.ElmHttpCmd ]

        gitHub : OpenApi.Config.Input
        gitHub =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/github-spec.json")
                |> OpenApi.Config.withWarnOnMissingEnums False

        ifconfigOvh : OpenApi.Config.Input
        ifconfigOvh =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/ifconfig.ovh.json")

        anyOfEnums : OpenApi.Config.Input
        anyOfEnums =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/anyOfEnums.yaml")

        binaryResponse : OpenApi.Config.Input
        binaryResponse =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/binary-response.yaml")

        nullableEnum : OpenApi.Config.Input
        nullableEnum =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/nullable-enum.yaml")

        cookieAuth : OpenApi.Config.Input
        cookieAuth =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/cookie-auth.yaml")

        telegramBot : OpenApi.Config.Input
        telegramBot =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/telegram-bot.json")

        simpleRef : OpenApi.Config.Input
        simpleRef =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./example/simple-ref.yaml")

        bug : Int -> OpenApi.Config.Input
        bug n =
            OpenApi.Config.inputFrom (OpenApi.Config.File ("./example/openapi-generator-bugs/" ++ String.fromInt n ++ ".yaml"))

        profileConfig : OpenApi.Config.Config
        profileConfig =
            -- Slimmed config for profiling
            OpenApi.Config.init "./generated"
                |> OpenApi.Config.withNoElmFormat True
                |> OpenApi.Config.withKeepGoing True
                |> OpenApi.Config.withInput additionalProperties
                |> OpenApi.Config.withInput recursiveAllofRefs
                |> OpenApi.Config.withInput overridingGlobalSecurity
                |> OpenApi.Config.withInput singleEnum
                |> OpenApi.Config.withInput realworldConduit
                |> OpenApi.Config.withInput amadeusAirlineLookup
                |> OpenApi.Config.withInput marioPartyStats
                |> OpenApi.Config.withInput viaggiatreno
                |> OpenApi.Config.withInput trustmark
                |> OpenApi.Config.withInput trustmarkTradeCheck
                |> OpenApi.Config.withInput ifconfigOvh
                |> OpenApi.Config.withInput anyOfEnums
                |> OpenApi.Config.withInput binaryResponse
                |> OpenApi.Config.withInput nullableEnum
                |> OpenApi.Config.withInput cookieAuth
                |> OpenApi.Config.withInput simpleRef
                |> OpenApi.Config.withInput (bug 7889)
                |> OpenApi.Config.withInput (bug 10398)
                |> OpenApi.Config.withInput (bug 16104)
                |> OpenApi.Config.withInput (bug 22119)
                |> OpenApi.Config.withInput (bug 22530)

        config : OpenApi.Config.Config
        config =
            profileConfig
                |> OpenApi.Config.withInput patreon
                |> OpenApi.Config.withInput dbFahrplanApi
                |> OpenApi.Config.withInput gitHub
                |> OpenApi.Config.withInput telegramBot
                |> OpenApi.Config.withNoElmFormat False
                |> OpenApi.Config.withAutoConvertSwagger OpenApi.Config.AlwaysConvert
    in
    Pages.Script.withCliOptions programConfig
        (\profile ->
            if profile then
                profiling "main" (Cli.withConfig profileConfig)

            else
                BackendTask.doEach
                    [ Cli.withConfig config
                    , "\nCompiling Example app"
                        |> Ansi.Color.fontColor Ansi.Color.brightGreen
                        |> Pages.Script.log
                    , Pages.Script.exec "sh"
                        [ "-c", "cd example && npx --no -- elm make src/Example.elm --output=/dev/null" ]
                    ]
        )


programConfig : Cli.Program.Config Bool
programConfig =
    Cli.Program.config
        |> Cli.Program.add
            (Cli.OptionsParser.build identity
                |> Cli.OptionsParser.with (Cli.Option.flag "profile")
            )


profiling : String -> BackendTask FatalError a -> BackendTask FatalError a
profiling label task =
    BackendTask.Custom.run "profile" (Json.Encode.string label) (Json.Decode.succeed ())
        |> BackendTask.allowFatal
        |> BackendTask.andThen
            (\() ->
                task
            )
        |> BackendTask.andThen
            (\res ->
                BackendTask.Custom.run "profileEnd" (Json.Encode.string label) (Json.Decode.succeed ())
                    |> BackendTask.allowFatal
                    |> BackendTask.map (\() -> res)
            )
