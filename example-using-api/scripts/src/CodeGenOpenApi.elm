module CodeGenOpenApi exposing (run)

import Ansi.Color
import BackendTask
import OpenApi.BackendTask
import OpenApi.Config
import Pages.Script


{-| Generate an Elm "SDK" for an example OpenAPI service.
-}
run : Pages.Script.Script
run =
    let
        exampleApi : OpenApi.Config.Input
        exampleApi =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./openapi.yaml")
                |> OpenApi.Config.withOutputModuleName [ "ExampleApi" ]
                |> OpenApi.Config.withEffectTypes [ OpenApi.Config.ElmHttpCmd ]

        config : OpenApi.Config.Config
        config =
            OpenApi.Config.init "./generated"
                |> OpenApi.Config.withAutoConvertSwagger True
                |> OpenApi.Config.withInput exampleApi
    in
    Pages.Script.withoutCliOptions
        (BackendTask.doEach
            [ -- Remove this `exec` if you don't need to run a "before" script
              Pages.Script.exec "./scripts/before-codegen.sh" []
            , "Generating OpenAPI code"
                |> Ansi.Color.fontColor Ansi.Color.brightGreen
                |> Pages.Script.log
            , OpenApi.BackendTask.withConfig config

            -- Remove this `exec` if you don't need to run an "after" script
            , Pages.Script.exec "./scripts/after-codegen.sh" []
            ]
        )
