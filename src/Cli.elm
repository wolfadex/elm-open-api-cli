module Cli exposing (run)

import Ansi.Color
import BackendTask
import BackendTask.File
import Cli.Option
import Cli.OptionsParser
import Cli.Program
import FatalError
import Json.Decode
import Json.Encode
import List.Extra
import OpenApi
import OpenApi.Generate
import OpenApi.Info
import Pages.Script
import UrlPath
import Yaml.Decode


type alias CliOptions =
    { entryFilePath : String
    , outputFile : Maybe String
    , namespace : Maybe String
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
                    (Cli.Option.optionalKeywordArg "output")
                |> Cli.OptionsParser.with
                    (Cli.Option.optionalKeywordArg "namespace")
                |> Cli.OptionsParser.with
                    (Cli.Option.optionalKeywordArg "generateTodos")
            )


run : Pages.Script.Script
run =
    Pages.Script.withCliOptions program
        (\{ entryFilePath, outputFile, namespace, generateTodos } ->
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
                |> BackendTask.andThen decodeOpenApiSpecOrFail
                |> BackendTask.andThen (generateFileFromOpenApiSpec { outputFile = outputFile, namespace = namespace, generateTodos = generateTodos })
        )


decodeOpenApiSpecOrFail : String -> BackendTask.BackendTask FatalError.FatalError OpenApi.OpenApi
decodeOpenApiSpecOrFail input =
    let
        -- TODO: Better handling of errors: https://github.com/wolfadex/elm-api-sdk-generator/issues/40
        decoded : Result Json.Decode.Error OpenApi.OpenApi
        decoded =
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
    { outputFile : Maybe String
    , namespace : Maybe String
    , generateTodos : Maybe String
    }
    -> OpenApi.OpenApi
    -> BackendTask.BackendTask FatalError.FatalError ()
generateFileFromOpenApiSpec config apiSpec =
    let
        fileNamespace : String
        fileNamespace =
            case config.namespace of
                Just n ->
                    n

                Nothing ->
                    let
                        defaultNamespace : String
                        defaultNamespace =
                            apiSpec
                                |> OpenApi.info
                                |> OpenApi.Info.title
                                |> OpenApi.Generate.makeNamespaceValid
                                |> OpenApi.Generate.removeInvalidChars
                    in
                    case config.outputFile of
                        Just path ->
                            let
                                split : List String
                                split =
                                    String.split "/" path
                            in
                            case List.Extra.dropWhile ((/=) "generated") split of
                                "generated" :: rest ->
                                    rest
                                        |> String.join "."
                                        |> String.replace ".elm" ""

                                _ ->
                                    case List.Extra.dropWhile ((/=) "src") split of
                                        "src" :: rest ->
                                            rest
                                                |> String.join "."
                                                |> String.replace ".elm" ""

                                        _ ->
                                            defaultNamespace

                        Nothing ->
                            defaultNamespace

        generateTodos : Bool
        generateTodos =
            List.member
                (String.toLower <| Maybe.withDefault "no" config.generateTodos)
                [ "y", "yes", "true" ]
    in
    OpenApi.Generate.file
        { namespace = fileNamespace
        , generateTodos = generateTodos
        }
        apiSpec
        |> Result.mapError FatalError.fromString
        |> BackendTask.fromResult
        |> BackendTask.andThen
            (\( decls, warnings ) ->
                warnings
                    |> List.map logWarning
                    |> BackendTask.combine
                    |> BackendTask.map (\_ -> decls)
            )
        |> BackendTask.andThen
            (\{ contents, path } ->
                let
                    outputPath : String
                    outputPath =
                        Maybe.withDefault
                            ([ "generated", path ]
                                |> UrlPath.join
                                |> UrlPath.toRelative
                            )
                            config.outputFile
                in
                Pages.Script.writeFile
                    { path = outputPath
                    , body = contents
                    }
                    |> BackendTask.mapError
                        (\error ->
                            FatalError.fromString <|
                                Ansi.Color.fontColor Ansi.Color.brightRed <|
                                    case error.recoverable of
                                        Pages.Script.FileWriteError ->
                                            "Uh oh! Failed to write file"
                        )
                    |> BackendTask.map (\_ -> outputPath)
            )
        |> BackendTask.andThen (\outputPath -> Pages.Script.log ("SDK generated at " ++ outputPath))


logWarning : String -> BackendTask.BackendTask FatalError.FatalError ()
logWarning warning =
    Pages.Script.log <|
        Ansi.Color.fontColor Ansi.Color.brightYellow "Warning: "
            ++ warning
