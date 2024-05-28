module Cli exposing (run)

import Ansi
import Ansi.Color
import BackendTask
import BackendTask.File
import BackendTask.Http
import BackendTask.Stream
import Cli.Option
import Cli.OptionsParser
import Cli.Program
import CliMonad
import Elm
import FatalError
import Json.Decode
import Json.Encode
import List.Extra
import OpenApi
import OpenApi.Generate exposing (EffectType(..))
import OpenApi.Info
import Pages.Script
import Pages.Script.Spinner
import Result.Extra
import String.Extra
import Url
import UrlPath
import Yaml.Decode


type alias CliOptions =
    { entryFilePath : String
    , outputDirectory : String
    , outputModuleName : Maybe String
    , effectTypes : List EffectType
    , generateTodos : Maybe String
    , autoConvertSwagger : Bool
    , swaggerConversionUrl : String
    , swaggerConversionCommand : Maybe String
    , swaggerConversionCommandArgs : List String
    }


program : Cli.Program.Config CliOptions
program =
    Cli.Program.config
        |> Cli.Program.add
            (Cli.OptionsParser.build CliOptions
                |> Cli.OptionsParser.with
                    (Cli.Option.requiredPositionalArg "entryFilePath")
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
                    (Cli.Option.optionalKeywordArg "generateTodos")
                |> Cli.OptionsParser.with
                    (Cli.Option.flag "auto-convert-swagger")
                |> Cli.OptionsParser.with
                    (Cli.Option.optionalKeywordArg "swagger-conversion-url"
                        |> Cli.Option.withDefault "https://converter.swagger.io/api/convert"
                    )
                |> Cli.OptionsParser.with
                    (Cli.Option.optionalKeywordArg "swagger-conversion-command")
                |> Cli.OptionsParser.with
                    (Cli.Option.keywordArgList "swagger-conversion-command-args")
                |> Cli.OptionsParser.withDoc """

  options:
  
  --output-dir                       The directory to output to. Defaults to: generated/

  --module-name                      The Elm module name. Default to <OAS info.title>

  --effect-types                     Which kind of APIs to generate, the options are:
                                      - cmd: input -> Cmd msg
                                      - riskycmd: as above, but using Http.riskyRequest
                                      - task: input -> Task Http.Error msg
                                      - riskytask: as above, but using Http.riskyRequest
                                      - backendtask: for dillonkearns/elm-pages
                                      - concurrenttask: for andrewMacmurray/elm-concurrent-task

  --auto-convert-swagger             If passed in, and a Swagger doc is encountered,
                                     will attempt to convert it to an Open API file.
                                     If not passed in, and a Swagger doc is encountered,
                                     the user will be manually prompted to convert
    
  --swagger-conversion-url           The URL to use to convert a Swagger doc to an Open API
                                     file. Defaults to https://converter.swagger.io/api/convert
    
  --swagger-conversion-command       Instead of making an HTTP request to convert
                                     from Swagger to Open API, use this command
    
  --swagger-conversion-command-args  Additional arguments to pass to the Swagger conversion command,
                                     before the contents of the Swagger file are passed in
    
  --generateTodos                    Whether to generate TODOs for unimplemented endpoints,
                                     or fail when something unexpected is encountered.
                                     Defaults to `no`. To generate `Debug.todo ""`
                                     instead of failing use one of: `yes`, `y`, `true`
"""
            )


effectTypesValidation : Maybe String -> Result String (List EffectType)
effectTypesValidation str =
    case str of
        Nothing ->
            Ok [ Cmd, Task ]

        Just v ->
            v
                |> String.split ","
                |> List.map String.trim
                |> Result.Extra.combineMap effectTypeValidation


effectTypeValidation : String -> Result String EffectType
effectTypeValidation effectType =
    case effectType of
        "cmd" ->
            Ok Cmd

        "cmdrisky" ->
            Ok CmdRisky

        "task" ->
            Ok Task

        "taskrisky" ->
            Ok TaskRisky

        "backendtask" ->
            Ok BackendTask

        _ ->
            Err <| "Unexpected effect type: " ++ effectType


run : Pages.Script.Script
run =
    Pages.Script.withCliOptions program
        (\cliOptions ->
            Pages.Script.Spinner.steps
                |> (case typeOfPath cliOptions.entryFilePath of
                        Url url ->
                            Pages.Script.Spinner.withStep ("Download OAS from " ++ Url.toString url)
                                (\_ -> readFromUrl url)

                        File path ->
                            Pages.Script.Spinner.withStep ("Read OAS from " ++ path)
                                (\_ -> readFromFile path)
                   )
                |> Pages.Script.Spinner.withStep "Parse OAS" (decodeOpenApiSpecOrFail { hasAttemptedToConvertFromSwagger = False } cliOptions)
                |> Pages.Script.Spinner.withStep "Generate Elm modules"
                    (generateFileFromOpenApiSpec
                        { outputModuleName = cliOptions.outputModuleName
                        , generateTodos = cliOptions.generateTodos
                        , effectTypes = cliOptions.effectTypes
                        }
                    )
                |> Pages.Script.Spinner.withStep "Format with elm-format" (onFirst attemptToFormat)
                |> Pages.Script.Spinner.withStep "Write to disk" (onFirst (writeSdkToDisk cliOptions.outputDirectory))
                |> Pages.Script.Spinner.runSteps
                |> BackendTask.andThen printSuccessMessageAndWarnings
        )


onFirst : (a -> BackendTask.BackendTask error c) -> ( a, b ) -> BackendTask.BackendTask error ( c, b )
onFirst f ( a, b ) =
    f a |> BackendTask.map (\c -> ( c, b ))


decodeOpenApiSpecOrFail : { hasAttemptedToConvertFromSwagger : Bool } -> CliOptions -> String -> BackendTask.BackendTask FatalError.FatalError OpenApi.OpenApi
decodeOpenApiSpecOrFail config cliOptions input =
    input
        |> BackendTask.succeed
        |> BackendTask.andThen
            (decodeMaybeYaml OpenApi.decode cliOptions.entryFilePath
                >> BackendTask.fromResult
            )
        |> BackendTask.onError
            (\decodeError ->
                if config.hasAttemptedToConvertFromSwagger then
                    decodeError
                        |> Json.Decode.errorToString
                        |> Ansi.Color.fontColor Ansi.Color.brightRed
                        |> FatalError.fromString
                        |> BackendTask.fail

                else
                    case decodeMaybeYaml swaggerFieldDecoder cliOptions.entryFilePath input of
                        Err error ->
                            error
                                |> Json.Decode.errorToString
                                |> Ansi.Color.fontColor Ansi.Color.brightRed
                                |> FatalError.fromString
                                |> BackendTask.fail

                        Ok _ ->
                            if cliOptions.autoConvertSwagger then
                                convertSwaggerToOpenApi cliOptions input
                                    |> Pages.Script.Spinner.runTask "Convert Swagger to Open API"
                                    |> BackendTask.andThen (decodeOpenApiSpecOrFail { hasAttemptedToConvertFromSwagger = True } cliOptions)

                            else
                                Pages.Script.question
                                    (Ansi.Color.fontColor Ansi.Color.brightCyan cliOptions.entryFilePath
                                        ++ """ is a Swagger doc (aka Open API v2) and this tool only supports Open API v3.
Would you like to use """
                                        ++ Ansi.Color.fontColor Ansi.Color.brightCyan cliOptions.swaggerConversionUrl
                                        ++ " to upgrade to v3? (y/n)\n"
                                    )
                                    |> BackendTask.andThen
                                        (\response ->
                                            case String.toLower response of
                                                "y" ->
                                                    convertSwaggerToOpenApi cliOptions input
                                                        |> Pages.Script.Spinner.runTask "Convert Swagger to Open API"
                                                        |> BackendTask.andThen (decodeOpenApiSpecOrFail { hasAttemptedToConvertFromSwagger = True } cliOptions)

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


convertSwaggerToOpenApi : CliOptions -> String -> BackendTask.BackendTask FatalError.FatalError String
convertSwaggerToOpenApi cliOptions input =
    case cliOptions.swaggerConversionCommand of
        Just command ->
            BackendTask.Stream.fromString input
                |> BackendTask.Stream.pipe (BackendTask.Stream.command command cliOptions.swaggerConversionCommandArgs)
                |> BackendTask.Stream.read
                |> BackendTask.mapError
                    (\error ->
                        FatalError.fromString <|
                            ("Attempted to convert the Swagger doc to an Open API spec using\n"
                                ++ Ansi.Color.fontColor Ansi.Color.brightCyan
                                    (String.join " "
                                        (command :: cliOptions.swaggerConversionCommandArgs)
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
            BackendTask.Http.post cliOptions.swaggerConversionUrl
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
                                                "with the URL: " ++ cliOptions.swaggerConversionUrl

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


decodeMaybeYaml : Json.Decode.Decoder a -> String -> String -> Result Json.Decode.Error a
decodeMaybeYaml decoder entryFilePath input =
    let
        -- TODO: Better handling of errors: https://github.com/wolfadex/elm-open-api-cli/issues/40
        isJson : Bool
        isJson =
            String.endsWith ".json" entryFilePath
    in
    -- Short-circuit the error-prone yaml parsing of JSON structures if we
    -- are reasonably confident that it is a JSON file
    if isJson then
        Json.Decode.decodeString decoder input

    else
        case Yaml.Decode.fromString yamlToJsonDecoder input of
            Err _ ->
                Json.Decode.decodeString decoder input

            Ok jsonFromYaml ->
                Json.Decode.decodeValue decoder jsonFromYaml


yamlToJsonDecoder : Yaml.Decode.Decoder Json.Encode.Value
yamlToJsonDecoder =
    Yaml.Decode.oneOf
        [ Yaml.Decode.map Json.Encode.float Yaml.Decode.float
        , Yaml.Decode.map Json.Encode.string Yaml.Decode.string
        , Yaml.Decode.map Json.Encode.bool Yaml.Decode.bool
        , Yaml.Decode.map (\_ -> Json.Encode.null) Yaml.Decode.null
        , Yaml.Decode.map
            (Json.Encode.list identity)
            (Yaml.Decode.list (Yaml.Decode.lazy (\_ -> yamlToJsonDecoder)))
        , Yaml.Decode.map
            (Json.Encode.dict identity identity)
            (Yaml.Decode.dict (Yaml.Decode.lazy (\_ -> yamlToJsonDecoder)))
        ]


generateFileFromOpenApiSpec :
    { outputModuleName : Maybe String
    , generateTodos : Maybe String
    , effectTypes : List EffectType
    }
    -> OpenApi.OpenApi
    -> BackendTask.BackendTask FatalError.FatalError ( List Elm.File, List CliMonad.Message )
generateFileFromOpenApiSpec config apiSpec =
    let
        moduleName : List String
        moduleName =
            case config.outputModuleName of
                Just modName ->
                    String.split "." modName

                Nothing ->
                    apiSpec
                        |> OpenApi.info
                        |> OpenApi.Info.title
                        |> OpenApi.Generate.sanitizeModuleName
                        |> Maybe.withDefault "Api"
                        |> List.singleton

        generateTodos : Bool
        generateTodos =
            List.member
                (String.toLower <| Maybe.withDefault "no" config.generateTodos)
                [ "y", "yes", "true" ]
    in
    OpenApi.Generate.files
        { namespace = moduleName
        , generateTodos = generateTodos
        , effectTypes = config.effectTypes
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
            (\mayebFound ->
                case mayebFound of
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


printSuccessMessageAndWarnings : ( List String, List CliMonad.Message ) -> BackendTask.BackendTask FatalError.FatalError ()
printSuccessMessageAndWarnings ( outputPaths, warnings ) =
    let
        indentBy : Int -> String -> String
        indentBy amount input =
            String.repeat amount " " ++ input

        requiredLinks : List String
        requiredLinks =
            [ "elm/http", "elm/json" ]
                |> List.map toElmDependencyLink

        optionalLinks : List String
        optionalLinks =
            [ "elm/bytes", "elm/url" ]
                |> List.map toElmDependencyLink

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
              , "You'll also need " ++ String.Extra.toSentenceOxford requiredLinks ++ " installed. Try running:"
              , ""
              , indentBy 4 "elm install elm/http"
              , indentBy 4 "elm install elm/json"
              , ""
              , ""
              , "and possibly need " ++ String.Extra.toSentenceOxford optionalLinks ++ " installed. If that's the case, try running:"
              , indentBy 4 "elm install elm/bytes"
              , indentBy 4 "elm install elm/url"
              ]
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


typeOfPath : String -> PathType
typeOfPath path =
    case Url.fromString path of
        Just url ->
            Url url

        Nothing ->
            File path


type PathType
    = File String -- swagger.json ./swagger.json /folder/swagger.json
    | Url Url.Url -- https://petstore3.swagger.io/api/v3/openapi.json
