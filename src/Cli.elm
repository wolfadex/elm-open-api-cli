module Cli exposing (run, withConfig)

import Ansi
import Ansi.Color
import BackendTask exposing (BackendTask)
import BackendTask.File
import BackendTask.Http
import BackendTask.Stream
import Cli.Option
import Cli.OptionsParser
import Cli.Program
import CliMonad
import Dict
import Elm
import FastSet
import FatalError exposing (FatalError)
import Json.Decode
import Json.Encode
import Json.Value
import List.Extra
import OpenApi
import OpenApi.Config
import OpenApi.Generate
import OpenApi.Info
import Pages.Script
import Pages.Script.Spinner
import Result.Extra
import String.Extra
import Url
import UrlPath
import Yaml.Decode


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
                |> withConfig
        )


parseCliOptions : CliOptions -> OpenApi.Config.Config
parseCliOptions cliOptions =
    let
        config : OpenApi.Config.Config
        config =
            OpenApi.Config.init cliOptions.entryFilePath cliOptions.outputDirectory
    in
    { config
        | outputModuleName = Maybe.map (String.split ".") cliOptions.outputModuleName
        , effectTypes =
            if List.isEmpty cliOptions.effectTypes then
                config.effectTypes

            else
                cliOptions.effectTypes
        , generateTodos = cliOptions.generateTodos
        , autoConvertSwagger = cliOptions.autoConvertSwagger
        , swaggerConversionUrl =
            cliOptions.swaggerConversionUrl
                |> Maybe.withDefault config.swaggerConversionUrl
        , swaggerConversionCommand =
            cliOptions.swaggerConversionCommand
                |> Maybe.map (\command -> { command = command, args = cliOptions.swaggerConversionCommandArgs })
        , server = cliOptions.server
        , overrides = cliOptions.overrides
        , writeMergedTo = cliOptions.writeMergedTo
    }


withConfig : OpenApi.Config.Config -> BackendTask FatalError ()
withConfig config =
    Pages.Script.Spinner.steps
        |> (case config.oasPath of
                OpenApi.Config.Url url ->
                    Pages.Script.Spinner.withStep ("Download OAS from " ++ Url.toString url)
                        (\_ -> BackendTask.andThen (parseOriginal config) (readFromUrl url))

                OpenApi.Config.File path ->
                    Pages.Script.Spinner.withStep ("Read OAS from " ++ path)
                        (\_ -> BackendTask.andThen (parseOriginal config) (readFromFile path))
           )
        |> (\prev ->
                if List.isEmpty config.overrides then
                    prev
                        |> Pages.Script.Spinner.withStep "No overrides"
                            (\( _, original ) -> BackendTask.succeed (Json.Value.encode original))

                else
                    List.foldl
                        (\override ->
                            case override of
                                OpenApi.Config.Url url ->
                                    Pages.Script.Spinner.withStep ("Download override from " ++ Url.toString url)
                                        (\( acc, original ) -> BackendTask.map (\read -> ( ( override, read ) :: acc, original )) (readFromUrl url))

                                OpenApi.Config.File path ->
                                    Pages.Script.Spinner.withStep ("Read override from " ++ path)
                                        (\( acc, original ) -> BackendTask.map (\read -> ( ( override, read ) :: acc, original )) (readFromFile path))
                        )
                        prev
                        config.overrides
                        |> Pages.Script.Spinner.withStep "Merging overrides" mergeOverrides
           )
        |> (case config.writeMergedTo of
                Nothing ->
                    identity

                Just destination ->
                    Pages.Script.Spinner.withStep "Writing merged OAS" (writeMerged destination)
           )
        |> Pages.Script.Spinner.withStep "Parse OAS" (decodeOpenApiSpecOrFail { hasAttemptedToConvertFromSwagger = False } config)
        |> Pages.Script.Spinner.withStep "Generate Elm modules"
            (generateFileFromOpenApiSpec
                { outputModuleName = config.outputModuleName
                , generateTodos = config.generateTodos
                , effectTypes = config.effectTypes
                , server = config.server
                , formats = config.formats
                }
            )
        |> Pages.Script.Spinner.withStep "Format with elm-format" (onFirst attemptToFormat)
        |> Pages.Script.Spinner.withStep "Write to disk" (onFirst (writeSdkToDisk config.outputDirectory))
        |> Pages.Script.Spinner.runSteps
        |> BackendTask.andThen printSuccessMessageAndWarnings


onFirst : (a -> BackendTask.BackendTask error c) -> ( a, b ) -> BackendTask.BackendTask error ( c, b )
onFirst f ( a, b ) =
    f a |> BackendTask.map (\c -> ( c, b ))


parseOriginal : OpenApi.Config.Config -> String -> BackendTask.BackendTask FatalError.FatalError ( List a, Json.Value.JsonValue )
parseOriginal config original =
    case decodeMaybeYaml config.oasPath original of
        Err e ->
            e
                |> jsonErrorToFatalError
                |> BackendTask.fail

        Ok decoded ->
            BackendTask.succeed ( [], decoded )


mergeOverrides : ( List ( OpenApi.Config.Path, String ), Json.Value.JsonValue ) -> BackendTask.BackendTask FatalError.FatalError Json.Decode.Value
mergeOverrides ( overrides, original ) =
    Result.map
        (\overridesValues ->
            List.foldl
                (\override acc -> Result.andThen (overrideWith override) acc)
                (Ok original)
                overridesValues
                |> Result.mapError FatalError.fromString
                |> Result.map Json.Value.encode
        )
        (overrides
            |> List.reverse
            |> Result.Extra.combineMap (\( path, file ) -> decodeMaybeYaml path file)
            |> Result.mapError jsonErrorToFatalError
        )
        |> Result.Extra.join
        |> BackendTask.fromResult


writeMerged : String -> Json.Decode.Value -> BackendTask.BackendTask FatalError.FatalError Json.Decode.Value
writeMerged destination spec =
    Pages.Script.writeFile
        { path = destination
        , body = spec |> Json.Encode.encode 4
        }
        |> BackendTask.allowFatal
        |> BackendTask.map (\_ -> spec)


decodeOpenApiSpecOrFail : { hasAttemptedToConvertFromSwagger : Bool } -> OpenApi.Config.Config -> Json.Decode.Value -> BackendTask.BackendTask FatalError.FatalError OpenApi.OpenApi
decodeOpenApiSpecOrFail { hasAttemptedToConvertFromSwagger } config value =
    value
        |> Json.Decode.decodeValue OpenApi.decode
        |> BackendTask.fromResult
        |> BackendTask.onError
            (\decodeError ->
                if hasAttemptedToConvertFromSwagger then
                    jsonErrorToFatalError decodeError
                        |> BackendTask.fail

                else
                    case Json.Decode.decodeValue swaggerFieldDecoder value of
                        Err _ ->
                            jsonErrorToFatalError decodeError
                                |> BackendTask.fail

                        Ok _ ->
                            if config.autoConvertSwagger then
                                convertToSwaggerAndThenDecode config value

                            else
                                Pages.Script.question
                                    (Ansi.Color.fontColor Ansi.Color.brightCyan (OpenApi.Config.pathToString config.oasPath)
                                        ++ """ is a Swagger doc (aka Open API v2) and this tool only supports Open API v3.
Would you like to use """
                                        ++ Ansi.Color.fontColor Ansi.Color.brightCyan config.swaggerConversionUrl
                                        ++ " to upgrade to v3? (y/n)\n"
                                    )
                                    |> BackendTask.andThen
                                        (\response ->
                                            case String.toLower response of
                                                "y" ->
                                                    convertToSwaggerAndThenDecode config value

                                                _ ->
                                                    ("""The input file appears to be a Swagger doc,
and the CLI was not configured to automatically convert it to an Open API spec.
See the """
                                                        ++ Ansi.Color.fontColor Ansi.Color.brightCyan "--auto-convert-swagger"
                                                        ++ " flag for more info."
                                                    )
                                                        |> FatalError.fromString
                                                        |> BackendTask.fail
                                        )
            )


convertToSwaggerAndThenDecode : OpenApi.Config.Config -> Json.Decode.Value -> BackendTask.BackendTask FatalError.FatalError OpenApi.OpenApi
convertToSwaggerAndThenDecode config value =
    convertSwaggerToOpenApi config (Json.Encode.encode 0 value)
        |> BackendTask.andThen
            (\input ->
                parseOriginal config input
                    |> BackendTask.andThen mergeOverrides
            )
        |> Pages.Script.Spinner.runTask "Convert Swagger to Open API"
        |> BackendTask.andThen (\input -> decodeOpenApiSpecOrFail { hasAttemptedToConvertFromSwagger = True } config input)


jsonErrorToFatalError : Json.Decode.Error -> FatalError.FatalError
jsonErrorToFatalError decodeError =
    decodeError
        |> Json.Decode.errorToString
        |> Ansi.Color.fontColor Ansi.Color.brightRed
        |> FatalError.fromString


overrideWith : Json.Value.JsonValue -> Json.Value.JsonValue -> Result String Json.Value.JsonValue
overrideWith override original =
    case override of
        Json.Value.ObjectValue overrideObject ->
            case original of
                Json.Value.ObjectValue originalObject ->
                    Dict.merge
                        (\key value res -> Result.map (\acc -> ( key, value ) :: acc) res)
                        (\key originalValue overrideValue res ->
                            if overrideValue == Json.Value.NullValue then
                                res

                            else
                                Result.map2
                                    (\acc newValue -> ( key, newValue ) :: acc)
                                    res
                                    (overrideWith overrideValue originalValue)
                        )
                        (\key value res -> Result.map (\acc -> ( key, value ) :: acc) res)
                        (Dict.fromList originalObject)
                        (Dict.fromList overrideObject)
                        (Ok [])
                        |> Result.map (\list -> Json.Value.ObjectValue (List.reverse list))

                _ ->
                    overrideError override original

        Json.Value.ArrayValue overrideArray ->
            case original of
                Json.Value.ArrayValue originalArray ->
                    mergeArrays overrideArray originalArray []

                _ ->
                    overrideError override original

        Json.Value.BoolValue _ ->
            Ok override

        Json.Value.NumericValue _ ->
            Ok override

        Json.Value.StringValue _ ->
            Ok override

        Json.Value.NullValue ->
            Ok override


mergeArrays : List Json.Value.JsonValue -> List Json.Value.JsonValue -> List Json.Value.JsonValue -> Result String Json.Value.JsonValue
mergeArrays override original acc =
    case original of
        ogHead :: ogTail ->
            case override of
                Json.Value.NullValue :: ovTail ->
                    mergeArrays ovTail ogTail acc

                ovHead :: ovTail ->
                    case overrideWith ovHead ogHead of
                        Ok newHead ->
                            mergeArrays ovTail ogTail (newHead :: acc)

                        Err e ->
                            Err e

                [] ->
                    if List.isEmpty original then
                        Ok (Json.Value.ArrayValue (List.reverse acc))

                    else
                        Ok (Json.Value.ArrayValue (List.reverse acc ++ original))

        [] ->
            if List.isEmpty override then
                Ok (Json.Value.ArrayValue (List.reverse acc))

            else
                Ok (Json.Value.ArrayValue (List.reverse acc ++ override))


overrideError : Json.Value.JsonValue -> Json.Value.JsonValue -> Result String Json.Value.JsonValue
overrideError override original =
    let
        toString : Json.Value.JsonValue -> String
        toString v =
            Json.Encode.encode 0 (Json.Value.encode v)

        message : String
        message =
            "Cannot override original value " ++ toString original ++ " with override " ++ toString override
    in
    Err message


convertSwaggerToOpenApi : OpenApi.Config.Config -> String -> BackendTask.BackendTask FatalError.FatalError String
convertSwaggerToOpenApi config input =
    case config.swaggerConversionCommand of
        Just { command, args } ->
            BackendTask.Stream.fromString input
                |> BackendTask.Stream.pipe (BackendTask.Stream.command command args)
                |> BackendTask.Stream.read
                |> BackendTask.mapError
                    (\error ->
                        FatalError.fromString <|
                            ("Attempted to convert the Swagger doc to an Open API spec using\n"
                                ++ Ansi.Color.fontColor Ansi.Color.brightCyan
                                    (String.join " "
                                        (command :: args)
                                    )
                                ++ "\nbut encountered an issue:\n\n"
                                ++ (Ansi.Color.fontColor Ansi.Color.brightRed <|
                                        case error.recoverable of
                                            BackendTask.Stream.StreamError err ->
                                                err

                                            BackendTask.Stream.CustomError errCode maybeBody ->
                                                case maybeBody of
                                                    Just body ->
                                                        body

                                                    Nothing ->
                                                        String.fromInt errCode
                                   )
                            )
                    )
                |> BackendTask.map .body

        Nothing ->
            BackendTask.Http.post config.swaggerConversionUrl
                (BackendTask.Http.stringBody "application/yaml" input)
                (BackendTask.Http.expectJson Json.Decode.value)
                |> BackendTask.map (Json.Encode.encode 0)
                |> BackendTask.mapError
                    (\error ->
                        FatalError.fromString
                            ("Attempted to convert the Swagger doc to an Open API spec but encountered an issue:\n\n"
                                ++ (Ansi.Color.fontColor Ansi.Color.brightRed <|
                                        case error.recoverable of
                                            BackendTask.Http.BadUrl _ ->
                                                "with the URL: " ++ config.swaggerConversionUrl

                                            BackendTask.Http.Timeout ->
                                                "the request timed out"

                                            BackendTask.Http.NetworkError ->
                                                "with a network error"

                                            BackendTask.Http.BadStatus { statusCode, statusText } _ ->
                                                "status code " ++ String.fromInt statusCode ++ ", " ++ statusText

                                            BackendTask.Http.BadBody _ _ ->
                                                "expected a string response body but got something else"
                                   )
                            )
                    )


swaggerFieldDecoder : Json.Decode.Decoder String
swaggerFieldDecoder =
    Json.Decode.field "swagger" Json.Decode.string


decodeMaybeYaml : OpenApi.Config.Path -> String -> Result Json.Decode.Error Json.Value.JsonValue
decodeMaybeYaml oasPath input =
    let
        -- TODO: Better handling of errors: https://github.com/wolfadex/elm-open-api-cli/issues/40
        isJson : Bool
        isJson =
            case oasPath of
                OpenApi.Config.File file ->
                    String.endsWith ".json" file

                OpenApi.Config.Url url ->
                    String.endsWith ".json" url.path
    in
    -- Short-circuit the error-prone yaml parsing of JSON structures if we
    -- are reasonably confident that it is a JSON file
    if isJson then
        Json.Decode.decodeString Json.Value.decoder input

    else
        case Yaml.Decode.fromString yamlToJsonValueDecoder input of
            Err _ ->
                Json.Decode.decodeString Json.Value.decoder input

            Ok jsonFromYaml ->
                Ok jsonFromYaml


yamlToJsonValueDecoder : Yaml.Decode.Decoder Json.Value.JsonValue
yamlToJsonValueDecoder =
    Yaml.Decode.oneOf
        [ Yaml.Decode.map Json.Value.NumericValue Yaml.Decode.float
        , Yaml.Decode.map Json.Value.StringValue Yaml.Decode.string
        , Yaml.Decode.map Json.Value.BoolValue Yaml.Decode.bool
        , Yaml.Decode.map (\_ -> Json.Value.NullValue) Yaml.Decode.null
        , Yaml.Decode.map
            Json.Value.ArrayValue
            (Yaml.Decode.list (Yaml.Decode.lazy (\_ -> yamlToJsonValueDecoder)))
        , Yaml.Decode.map
            (\dict -> Json.Value.ObjectValue (Dict.toList dict))
            (Yaml.Decode.dict (Yaml.Decode.lazy (\_ -> yamlToJsonValueDecoder)))
        ]


generateFileFromOpenApiSpec :
    { outputModuleName : Maybe (List String)
    , generateTodos : Bool
    , effectTypes : List OpenApi.Config.EffectType
    , server : OpenApi.Config.Server
    , formats : List OpenApi.Config.Format
    }
    -> OpenApi.OpenApi
    ->
        BackendTask.BackendTask
            FatalError.FatalError
            ( List Elm.File
            , { warnings : List CliMonad.Message
              , requiredPackages : FastSet.Set String
              }
            )
generateFileFromOpenApiSpec config apiSpec =
    let
        moduleName : List String
        moduleName =
            case config.outputModuleName of
                Just modName ->
                    modName

                Nothing ->
                    apiSpec
                        |> OpenApi.info
                        |> OpenApi.Info.title
                        |> OpenApi.Generate.sanitizeModuleName
                        |> Maybe.withDefault "Api"
                        |> List.singleton
    in
    OpenApi.Generate.files
        { namespace = moduleName
        , generateTodos = config.generateTodos
        , effectTypes = config.effectTypes
        , server = config.server
        , formats = config.formats
        }
        apiSpec
        |> Result.mapError (messageToString >> FatalError.fromString)
        |> BackendTask.fromResult


{-| Check to see if `elm-format` is available, and if so format the files
-}
attemptToFormat : List Elm.File -> BackendTask.BackendTask FatalError.FatalError (List Elm.File)
attemptToFormat files =
    Pages.Script.which "elm-format"
        |> BackendTask.andThen
            (\maybeFound ->
                case maybeFound of
                    Just _ ->
                        files
                            |> List.map
                                (\file ->
                                    BackendTask.Stream.fromString file.contents
                                        |> BackendTask.Stream.pipe (BackendTask.Stream.command "elm-format" [ "--stdin" ])
                                        |> BackendTask.Stream.read
                                        |> BackendTask.map (\formatted -> { file | contents = formatted.body })
                                        -- Never fail on formatting errors
                                        |> BackendTask.onError (\_ -> BackendTask.succeed file)
                                )
                            |> BackendTask.combine

                    Nothing ->
                        BackendTask.succeed files
            )


writeSdkToDisk : String -> List Elm.File -> BackendTask.BackendTask FatalError.FatalError (List String)
writeSdkToDisk outputDirectory =
    List.map
        (\file ->
            let
                filePath : String
                filePath =
                    outputDirectory
                        ++ "/"
                        ++ file.path

                outputPath : String
                outputPath =
                    filePath
                        |> String.split "/"
                        |> UrlPath.join
                        |> UrlPath.toRelative
            in
            Pages.Script.writeFile
                { path = outputPath
                , body = file.contents
                }
                |> BackendTask.mapError
                    (\error ->
                        case error.recoverable of
                            Pages.Script.FileWriteError ->
                                FatalError.fromString <|
                                    Ansi.Color.fontColor Ansi.Color.brightRed
                                        ("Uh oh! Failed to write " ++ outputPath)
                    )
                |> BackendTask.map (\_ -> outputPath)
        )
        >> BackendTask.combine


printSuccessMessageAndWarnings :
    ( List String
    , { warnings : List CliMonad.Message
      , requiredPackages : FastSet.Set String
      }
    )
    -> BackendTask.BackendTask FatalError.FatalError ()
printSuccessMessageAndWarnings ( outputPaths, { requiredPackages, warnings } ) =
    let
        indentBy : Int -> String -> String
        indentBy amount input =
            String.repeat amount " " ++ input

        allRequiredPackages : List String
        allRequiredPackages =
            requiredPackages
                |> FastSet.insert "elm/http"
                |> FastSet.insert "elm/json"
                |> FastSet.insert "elm/url"
                |> FastSet.insert "elm/bytes"
                |> FastSet.toList

        toInstall : String -> String
        toInstall dependency =
            indentBy 4 "elm install " ++ dependency

        toSentence : List String -> String
        toSentence links =
            links
                |> List.map toElmDependencyLink
                |> String.Extra.toSentenceOxford

        toElmDependencyLink : String -> String
        toElmDependencyLink dependency =
            Ansi.link
                { text = dependency
                , url = "https://package.elm-lang.org/packages/" ++ dependency ++ "/latest/"
                }

        warningTask : BackendTask.BackendTask FatalError.FatalError ()
        warningTask =
            warnings
                |> List.Extra.gatherEqualsBy .message
                |> List.map logWarning
                |> BackendTask.doEach

        successTask : BackendTask.BackendTask error ()
        successTask =
            [ [ ""
              , "🎉 SDK generated:"
              , ""
              ]
            , outputPaths
                |> List.map (indentBy 4)
            , [ ""
              , ""
              , "You'll also need " ++ toSentence allRequiredPackages ++ " installed. Try running:"
              , ""
              ]
            , List.map toInstall allRequiredPackages
            ]
                |> List.concat
                |> List.map Pages.Script.log
                |> BackendTask.doEach
    in
    BackendTask.doEach [ successTask, warningTask ]


messageToString : CliMonad.Message -> String
messageToString { path, message } =
    if List.isEmpty path then
        "Error! " ++ message

    else
        "Error! " ++ message ++ "\n  Path: " ++ String.join " -> " path


logWarning : ( CliMonad.Message, List CliMonad.Message ) -> BackendTask.BackendTask FatalError.FatalError ()
logWarning ( head, tail ) =
    let
        firstLine : String
        firstLine =
            Ansi.Color.fontColor Ansi.Color.brightYellow "Warning: " ++ head.message

        paths : List String
        paths =
            (head :: tail)
                |> List.filterMap
                    (\{ path } ->
                        if List.isEmpty path then
                            Nothing

                        else
                            Just ("  at " ++ String.join " -> " path)
                    )
    in
    (firstLine :: paths)
        |> List.map Pages.Script.log
        |> BackendTask.doEach



-- HELPERS


readFromUrl : Url.Url -> BackendTask.BackendTask FatalError.FatalError String
readFromUrl url =
    let
        path : String
        path =
            Url.toString url
    in
    BackendTask.Http.get path BackendTask.Http.expectString
        |> BackendTask.mapError
            (\error ->
                FatalError.fromString <|
                    Ansi.Color.fontColor Ansi.Color.brightRed <|
                        case error.recoverable of
                            BackendTask.Http.BadUrl _ ->
                                "Uh oh! There is no file at " ++ path

                            BackendTask.Http.Timeout ->
                                "Uh oh! Timed out waiting for response"

                            BackendTask.Http.NetworkError ->
                                "Uh oh! A network error happened"

                            BackendTask.Http.BadStatus { statusCode, statusText } _ ->
                                "Uh oh! The server responded with a " ++ String.fromInt statusCode ++ " " ++ statusText ++ " status"

                            BackendTask.Http.BadBody _ _ ->
                                "Uh oh! The body of the response was invalid"
            )


readFromFile : String -> BackendTask.BackendTask FatalError.FatalError String
readFromFile entryFilePath =
    BackendTask.File.rawFile entryFilePath
        |> BackendTask.mapError
            (\error ->
                FatalError.fromString <|
                    Ansi.Color.fontColor Ansi.Color.brightRed <|
                        case error.recoverable of
                            BackendTask.File.FileDoesntExist ->
                                "Uh oh! There is no file at " ++ entryFilePath

                            BackendTask.File.FileReadError _ ->
                                "Uh oh! Can't read!"

                            BackendTask.File.DecodingError _ ->
                                "Uh oh! Decoding failure!"
            )
