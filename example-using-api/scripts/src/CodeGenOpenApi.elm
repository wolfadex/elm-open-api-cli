module CodeGenOpenApi exposing (run)

import Ansi.Color
import BackendTask
import Common
import Gen.ArticleId
import OpenApi.BackendTask
import OpenApi.Config
import Pages.Script


{-| Generate an Elm "SDK" for a hypothetical OpenAPI service.
-}
run : Pages.Script.Script
run =
    let
        exampleApi : OpenApi.Config.Input
        exampleApi =
            OpenApi.Config.inputFrom (OpenApi.Config.File "./openapi.yaml")
                |> OpenApi.Config.withOutputModuleName [ "ExampleApi" ]
                |> OpenApi.Config.withEffectTypes [ OpenApi.Config.ElmHttpCmd ]

        articleIdFormat : OpenApi.Config.Format
        articleIdFormat =
            { basicType = Common.String
            , format = "article-id"
            , encode =
                Gen.ArticleId.call_.encode
            , decoder =
                Gen.ArticleId.decode
            , annotation =
                Gen.ArticleId.annotation_.articleId
            , requiresPackages = []
            , sharedDeclarations = []
            , toParamString =
                Gen.ArticleId.call_.toString
            }

        config : OpenApi.Config.Config
        config =
            OpenApi.Config.init "./generated"
                |> OpenApi.Config.withInput exampleApi
                |> OpenApi.Config.withFormat articleIdFormat
    in
    Pages.Script.withoutCliOptions
        (BackendTask.doEach
            [ "Generating OpenAPI code"
                |> Ansi.Color.fontColor Ansi.Color.brightGreen
                |> Pages.Script.log
            , OpenApi.BackendTask.withConfig config
            ]
        )
