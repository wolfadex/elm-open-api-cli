module Cli exposing (run)

import Cli.Option
import Cli.OptionsParser
import Cli.Program
import Json.Decode
import OpenApi.BackendTask
import OpenApi.Config
import Pages.Script
import Result.Extra


type alias CliOptions =
    { entryFilePath : OpenApi.Config.Path
    , outputDirectory : String
    , outputModuleName : Maybe String
    , effectTypes : List OpenApi.Config.EffectType
    , generateTodos : Bool
    , autoConvertSwagger : Bool
    , swaggerConversionUrl : Maybe String
    , swaggerConversionCommand : Maybe String
    , swaggerConversionCommandArgs : List String
    , server : OpenApi.Config.Server
    , overrides : List OpenApi.Config.Path
    , writeMergedTo : Maybe String
    }


program : Cli.Program.Config CliOptions
program =
    Cli.Program.config
        |> Cli.Program.add
            (Cli.OptionsParser.build CliOptions
                |> Cli.OptionsParser.with
                    (Cli.Option.requiredPositionalArg "entryFilePath"
                        |> Cli.Option.map OpenApi.Config.pathFromString
                    )
                |> Cli.OptionsParser.with
                    (Cli.Option.optionalKeywordArg "output-dir"
                        |> Cli.Option.withDefault "generated"
                    )
                |> Cli.OptionsParser.with
                    (Cli.Option.optionalKeywordArg "module-name")
                |> Cli.OptionsParser.with
                    (Cli.Option.optionalKeywordArg "effect-types"
                        |> Cli.Option.validateMap effectTypesValidation
                    )
                |> Cli.OptionsParser.with
                    (Cli.Option.flag "generateTodos")
                |> Cli.OptionsParser.with
                    (Cli.Option.flag "auto-convert-swagger")
                |> Cli.OptionsParser.with
                    (Cli.Option.optionalKeywordArg "swagger-conversion-url")
                |> Cli.OptionsParser.with
                    (Cli.Option.optionalKeywordArg "swagger-conversion-command")
                |> Cli.OptionsParser.with
                    (Cli.Option.keywordArgList "swagger-conversion-command-args")
                |> Cli.OptionsParser.with
                    (Cli.Option.optionalKeywordArg "server"
                        |> Cli.Option.validateMap serverValidation
                    )
                |> Cli.OptionsParser.with
                    (Cli.Option.keywordArgList "overrides"
                        |> Cli.Option.map (List.map OpenApi.Config.pathFromString)
                    )
                |> Cli.OptionsParser.with
                    (Cli.Option.optionalKeywordArg "write-merged-to")
                |> Cli.OptionsParser.withDoc """
version: 0.6.1

options:

  --output-dir                       The directory to output to. Defaults to `generated/`.

  --module-name                      The Elm module name. Defaults to `OAS info.title`.

  --effect-types                     A list of which kind of APIs to generate.
                                     Each item should be of the form `package.type`.
                                     If `package` is omitted it defaults to `elm/http`.
                                     If `type` is omitted it defaults to `cmd,task`.
                                     If not specified, defaults to `cmd,task` (for elm/http).
                                     The options for package are:
                                      - elm/http
                                      - dillonkearns/elm-pages
                                      - lamdera/program-test
                                     The options for type are:
                                      - cmd: Cmd for elm/http,
                                             Effect.Command for lamdera/program-test
                                      - cmdrisky: as above, but using Http.riskyRequest
                                      - cmdrecord: the input to Http.request
                                      - task: Task for elm/http
                                              Effect.Task for lamdera/program-test
                                              BackendTask for dillonkearns/elm-pages
                                      - taskrisky: as above, but using Http.riskyTask
                                                   cannot be used for dillonkearns/elm-pages
                                      - taskrecord: the input to Http.task

  --server                           The base URL for the OpenAPI server.
                                     If not specified this will be extracted from the OAS
                                     or default to root of the web application.

                                     You can pass in an object to define multiple servers, like
                                     {"dev": "http://localhost", "prod": "https://example.com"}.

                                     This will add a `server` parameter to functions and define
                                     a `Servers` module with your servers. You can pass in an
                                     empty object if you have fully dynamic servers.

  --auto-convert-swagger             If passed in, and a Swagger doc is encountered,
                                     will attempt to convert it to an Open API file.
                                     If not passed in, and a Swagger doc is encountered,
                                     the user will be manually prompted to convert.

  --swagger-conversion-url           The URL to use to convert a Swagger doc to an Open API
                                     file. Defaults to `https://converter.swagger.io/api/convert`.

  --swagger-conversion-command       Instead of making an HTTP request to convert
                                     from Swagger to Open API, use this command.

  --swagger-conversion-command-args  Additional arguments to pass to the Swagger conversion command,
                                     before the contents of the Swagger file are passed in.

  --generateTodos                    Whether to generate TODOs for unimplemented endpoints,
                                     or fail when something unexpected is encountered.
                                     Defaults to `no`. To generate `Debug.todo ""`
                                     instead of failing use one of: `yes`, `y`, `true`.

  --overrides                        Load an additional file to override parts of the original Open API file.

  --write-merged-to                  Write the merged Open API spec to the given file.
"""
            )


effectTypesValidation : Maybe String -> Result String (List OpenApi.Config.EffectType)
effectTypesValidation str =
    case str of
        Nothing ->
            Ok []

        Just v ->
            v
                |> String.split ","
                |> List.map String.trim
                |> Result.Extra.combineMap effectTypeValidation
                |> Result.map List.concat


effectTypeValidation : String -> Result String (List OpenApi.Config.EffectType)
effectTypeValidation effectType =
    case effectType of
        "cmd" ->
            Ok [ OpenApi.Config.ElmHttpCmd ]

        "cmdrisky" ->
            Ok [ OpenApi.Config.ElmHttpCmdRisky ]

        "cmdrecord" ->
            Ok [ OpenApi.Config.ElmHttpCmdRecord ]

        "task" ->
            Ok [ OpenApi.Config.ElmHttpTask ]

        "taskrisky" ->
            Ok [ OpenApi.Config.ElmHttpTaskRisky ]

        "taskrecord" ->
            Ok [ OpenApi.Config.ElmHttpTaskRecord ]

        "elm/http" ->
            Ok [ OpenApi.Config.ElmHttpCmd, OpenApi.Config.ElmHttpTask ]

        "elm/http.cmd" ->
            Ok [ OpenApi.Config.ElmHttpCmd ]

        "elm/http.cmdrisky" ->
            Ok [ OpenApi.Config.ElmHttpCmdRisky ]

        "elm/http.cmdrecord" ->
            Ok [ OpenApi.Config.ElmHttpCmdRecord ]

        "elm/http.task" ->
            Ok [ OpenApi.Config.ElmHttpTask ]

        "elm/http.taskrisky" ->
            Ok [ OpenApi.Config.ElmHttpTaskRisky ]

        "elm/http.taskrecord" ->
            Ok [ OpenApi.Config.ElmHttpTaskRecord ]

        "dillonkearns/elm-pages" ->
            Ok [ OpenApi.Config.DillonkearnsElmPagesTask ]

        "dillonkearns/elm-pages.task" ->
            Ok [ OpenApi.Config.DillonkearnsElmPagesTask ]

        "dillonkearns/elm-pages.taskrecord" ->
            Ok [ OpenApi.Config.DillonkearnsElmPagesTaskRecord ]

        "lamdera/program-test" ->
            Ok [ OpenApi.Config.LamderaProgramTestCmd, OpenApi.Config.LamderaProgramTestTask ]

        "lamdera/program-test.cmd" ->
            Ok [ OpenApi.Config.LamderaProgramTestCmd ]

        "lamdera/program-test.cmdrisky" ->
            Ok [ OpenApi.Config.LamderaProgramTestCmdRisky ]

        "lamdera/program-test.cmdrecord" ->
            Ok [ OpenApi.Config.LamderaProgramTestCmdRecord ]

        "lamdera/program-test.task" ->
            Ok [ OpenApi.Config.LamderaProgramTestTask ]

        "lamdera/program-test.taskrisky" ->
            Ok [ OpenApi.Config.LamderaProgramTestTaskRisky ]

        "lamdera/program-test.taskrecord" ->
            Ok [ OpenApi.Config.LamderaProgramTestTaskRecord ]

        _ ->
            Err <| "Unexpected effect type: " ++ effectType


serverValidation : Maybe String -> Result String OpenApi.Config.Server
serverValidation server =
    case Maybe.withDefault "" server of
        "" ->
            Ok OpenApi.Config.Default

        input ->
            case Json.Decode.decodeString (Json.Decode.dict Json.Decode.string) input of
                Ok servers ->
                    Ok <| OpenApi.Config.Multiple servers

                Err _ ->
                    if String.startsWith "{" input then
                        Err <| "Invalid JSON: " ++ input

                    else
                        Ok <| OpenApi.Config.Single input


run : Pages.Script.Script
run =
    Pages.Script.withCliOptions program
        (\cliOptions ->
            cliOptions
                |> parseCliOptions
                |> OpenApi.BackendTask.withConfig
        )


parseCliOptions : CliOptions -> OpenApi.Config.Config
parseCliOptions cliOptions =
    let
        -- Apply an update if the input is `Just x`
        maybe :
            (value -> config -> config)
            -> Maybe value
            -> config
            -> config
        maybe updater maybeValue config =
            case maybeValue of
                Nothing ->
                    config

                Just value ->
                    updater value config

        -- Apply an update if a condition is met
        iif : Bool -> (config -> config) -> config -> config
        iif cond updater config =
            if cond then
                updater config

            else
                config

        input : OpenApi.Config.Input
        input =
            OpenApi.Config.inputFrom cliOptions.entryFilePath
                |> OpenApi.Config.withServer cliOptions.server
                |> OpenApi.Config.withOverrides cliOptions.overrides
                |> maybe OpenApi.Config.withWriteMergedTo cliOptions.writeMergedTo
                |> maybe OpenApi.Config.withOutputModuleName (Maybe.map (String.split ".") cliOptions.outputModuleName)
                |> iif (not (List.isEmpty cliOptions.effectTypes)) (OpenApi.Config.withEffectTypes cliOptions.effectTypes)
    in
    OpenApi.Config.init cliOptions.outputDirectory
        |> OpenApi.Config.withInput input
        |> OpenApi.Config.withGenerateTodos cliOptions.generateTodos
        |> OpenApi.Config.withAutoConvertSwagger cliOptions.autoConvertSwagger
        |> maybe OpenApi.Config.withSwaggerConversionUrl cliOptions.swaggerConversionUrl
        |> maybe OpenApi.Config.withSwaggerConversionCommand
            (cliOptions.swaggerConversionCommand
                |> Maybe.map (\command -> { command = command, args = cliOptions.swaggerConversionCommandArgs })
            )
