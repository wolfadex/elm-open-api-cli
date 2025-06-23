module CodeGenOpenApi exposing (run)

import Ansi.Color
import BackendTask
import Common
import Elm
import Elm.Annotation
import Elm.Arg
import Elm.Op
import Gen.Data.Id
import Gen.Json.Decode
import Gen.Json.Encode
import Gen.String
import Gen.Time
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

        timeFormat : OpenApi.Config.Format
        timeFormat =
            { basicType = Common.Integer
            , format = "unix-seconds"
            , encode =
                \posix ->
                    Elm.Op.intDivide (Gen.Time.call_.posixToMillis posix) (Elm.int 1000)
                        |> Gen.Json.Encode.call_.int
            , decoder =
                Gen.Json.Decode.int
                    |> Elm.Op.pipe
                        (Elm.apply Gen.Json.Decode.values_.map
                            [ Elm.fn
                                (Elm.Arg.var "seconds")
                                (\seconds ->
                                    Gen.Time.call_.millisToPosix (Elm.Op.multiply seconds (Elm.int 1000))
                                )
                            ]
                        )
            , annotation = Gen.Time.annotation_.posix
            , requiresPackages = [ "elm/time" ]
            , sharedDeclarations = []
            , toParamString =
                \posix ->
                    Elm.Op.intDivide (Gen.Time.call_.posixToMillis posix) (Elm.int 1000)
                        |> Gen.String.call_.fromInt
            }

        makeIdFormat : String -> Elm.Annotation.Annotation -> OpenApi.Config.Format
        makeIdFormat format idAnnotation =
            { basicType = Common.String
            , format = format
            , encode =
                \id ->
                    Gen.Data.Id.call_.toString id
                        |> Gen.Json.Encode.call_.string
            , decoder =
                Gen.Data.Id.decode
            , annotation = idAnnotation
            , requiresPackages = [ "elm/json" ]
            , sharedDeclarations = []
            , toParamString =
                Gen.Data.Id.call_.toString
            }

        config : OpenApi.Config.Config
        config =
            OpenApi.Config.init "./generated"
                |> OpenApi.Config.withInput exampleApi
                |> OpenApi.Config.withFormat timeFormat
                |> OpenApi.Config.withFormat (makeIdFormat "thread-id" Gen.Data.Id.annotation_.threadId)
                |> OpenApi.Config.withFormat (makeIdFormat "message-id" Gen.Data.Id.annotation_.messageId)
                |> OpenApi.Config.withFormat (makeIdFormat "email" Gen.Data.Id.annotation_.userId)
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
