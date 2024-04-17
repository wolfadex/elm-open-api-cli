module Cli exposing (run)

import Ansi
import Ansi.Color
import BackendTask
import BackendTask.File
import BackendTask.Http
import Cli.Option
import Cli.OptionsParser
import Cli.Program
import CliMonad exposing (Message)
import FatalError
import Json.Decode
import Json.Encode
import List.Extra
import OpenApi
import OpenApi.Generate
import OpenApi.Info
import Pages.Script
import String.Extra
import Url
import UrlPath
import Yaml.Decode


type alias CliOptions =
    { entryFilePath : String
    , outputDirectory : String
    , outputModuleName : Maybe String
    , generateTodos : Maybe String
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
                    (Cli.Option.optionalKeywordArg "generateTodos")
            )


run : Pages.Script.Script
run =
    Pages.Script.withCliOptions program
        (\{ entryFilePath, outputDirectory, outputModuleName, generateTodos } ->
            (case typeOfPath entryFilePath of
                Url url ->
                    readFromUrl url

                File path ->
                    readFromFile path
            )
                |> BackendTask.andThen (decodeOpenApiSpecOrFail entryFilePath)
                |> BackendTask.andThen
                    (generateFileFromOpenApiSpec
                        { outputDirectory = outputDirectory
                        , outputModuleName = outputModuleName
                        , generateTodos = generateTodos
                        }
                    )
        )


decodeOpenApiSpecOrFail : String -> String -> BackendTask.BackendTask FatalError.FatalError OpenApi.OpenApi
decodeOpenApiSpecOrFail filePath input =
    let
        -- TODO: Better handling of errors: https://github.com/wolfadex/elm-api-sdk-generator/issues/40
        isJson : Bool
        isJson =
            String.endsWith ".json" filePath

        decoded : Result Json.Decode.Error OpenApi.OpenApi
        decoded =
            -- Short-circuit the error-prone yaml parsing of JSON structures if we
            -- are reasonably confident that it is a JSON file
            if isJson then
                Json.Decode.decodeString OpenApi.decode input

            else
                case Yaml.Decode.fromString yamlToJsonDecoder input of
                    Err _ ->
                        Json.Decode.decodeString OpenApi.decode input

                    Ok jsonFromYaml ->
                        Json.Decode.decodeValue OpenApi.decode jsonFromYaml
    in
    decoded
        |> Result.mapError
            (Json.Decode.errorToString
                >> Ansi.Color.fontColor Ansi.Color.brightRed
                >> FatalError.fromString
            )
        |> BackendTask.fromResult


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
    { outputDirectory : String
    , outputModuleName : Maybe String
    , generateTodos : Maybe String
    }
    -> OpenApi.OpenApi
    -> BackendTask.BackendTask FatalError.FatalError ()
generateFileFromOpenApiSpec config apiSpec =
    let
        moduleName : List String
        moduleName =
            case config.outputModuleName of
                Just modName ->
                    modName
                        |> String.split "."

                Nothing ->
                    apiSpec
                        |> OpenApi.info
                        |> OpenApi.Info.title
                        |> OpenApi.Generate.sanitizeModuleName
                        |> Maybe.map (String.split ".")
                        |> Maybe.withDefault [ "Api" ]

        generateTodos : Bool
        generateTodos =
            List.member
                (String.toLower <| Maybe.withDefault "no" config.generateTodos)
                [ "y", "yes", "true" ]
    in
    OpenApi.Generate.files
        { namespace = moduleName
        , generateTodos = generateTodos
        }
        apiSpec
        |> Result.mapError (messageToString >> FatalError.fromString)
        |> BackendTask.fromResult
        |> BackendTask.andThen
            (\( files, warnings ) ->
                warnings
                    |> List.Extra.gatherEqualsBy .message
                    |> List.map logWarning
                    |> doAll
                    |> BackendTask.map (\_ -> files)
            )
        |> BackendTask.andThen
            (List.map
                (\file ->
                    let
                        filePath : String
                        filePath =
                            config.outputDirectory
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
                                            Ansi.Color.fontColor Ansi.Color.brightRed <|
                                                "Uh oh! Failed to write file"
                            )
                        |> BackendTask.map (\_ -> outputPath)
                )
                >> BackendTask.combine
            )
        |> BackendTask.andThen
            (\outputPaths ->
                [ [ ""
                  , "🎉 SDK generated at:"
                  , ""
                  ]
                , outputPaths
                    |> List.map (\outputPath -> "    " ++ outputPath)
                , [ ""
                  , ""
                  , "You'll also need "
                        ++ Ansi.link
                            { text = "elm/http"
                            , url = "https://package.elm-lang.org/packages/elm/http/latest/"
                            }
                        ++ " and "
                        ++ Ansi.link
                            { text = "elm/json"
                            , url = "https://package.elm-lang.org/packages/elm/json/latest/"
                            }
                        ++ " installed. Try running:"
                  , ""
                  , "    elm install elm/http"
                  , "    elm install elm/json"
                  , ""
                  , ""
                  , "and possibly need "
                        ++ Ansi.link
                            { text = "elm/bytes"
                            , url = "https://package.elm-lang.org/packages/elm/bytes/latest/"
                            }
                        ++ " installed. Try running:"
                  , ""
                  , "    elm install elm/bytes"
                  ]
                ]
                    |> List.concat
                    |> List.map Pages.Script.log
                    |> doAll
            )


doAll : List (BackendTask.BackendTask error ()) -> BackendTask.BackendTask error ()
doAll list =
    case list of
        [] ->
            BackendTask.succeed ()

        head :: tail ->
            head |> BackendTask.andThen (\_ -> doAll tail)


messageToString : Message -> String
messageToString { path, message } =
    if List.isEmpty path then
        "Error! " ++ message

    else
        "Error! " ++ message ++ "\n  Path: " ++ String.join " -> " path


logWarning : ( Message, List Message ) -> BackendTask.BackendTask FatalError.FatalError ()
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
        |> doAll



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
