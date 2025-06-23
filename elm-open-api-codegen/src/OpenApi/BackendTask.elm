module OpenApi.BackendTask exposing (withConfig)

import Ansi
import Ansi.Color
import BackendTask exposing (BackendTask)
import BackendTask.Extra
import BackendTask.File
import BackendTask.Http
import BackendTask.Stream
import CliMonad
import Common
import Dict
import Dict.Extra
import Elm
import FastDict
import FastSet
import FatalError exposing (FatalError)
import Json.Decode
import Json.Encode
import Json.Value
import OpenApi
import OpenApi.Common.Internal
import OpenApi.Config
import OpenApi.Generate
import Pages.Script
import Pages.Script.Spinner
import Result.Extra
import Set
import String.Extra
import Url
import UrlPath
import Yaml.Decode


withInnerStep :
    Int
    -> Int
    -> String
    -> (a -> BackendTask FatalError b)
    -> Pages.Script.Spinner.Steps FatalError ( a, c, d )
    -> Pages.Script.Spinner.Steps FatalError ( b, c, d )
withInnerStep index total label toTask =
    Pages.Script.Spinner.withStep (counter index total ++ " " ++ label)
        (\( input, acc1, acc2 ) -> toTask input |> BackendTask.map (\result -> ( result, acc1, acc2 )))


withConfig : OpenApi.Config.Config -> BackendTask FatalError ()
withConfig config =
    let
        total : Int
        total =
            List.length (OpenApi.Config.inputs config)
    in
    List.foldl
        (\input ( index, steps ) ->
            ( index + 1
            , steps
                |> (case OpenApi.Config.oasPath input of
                        OpenApi.Config.Url url ->
                            withInnerStep index
                                total
                                ("Download OAS from " ++ Url.toString url)
                                (\_ -> BackendTask.andThen (parseOriginal input) (readFromUrl url))

                        OpenApi.Config.File path ->
                            withInnerStep index
                                total
                                ("Read OAS from " ++ path)
                                (\_ -> BackendTask.andThen (parseOriginal input) (readFromFile path))
                   )
                |> (\prev ->
                        let
                            overrides : List OpenApi.Config.Path
                            overrides =
                                OpenApi.Config.overrides input
                        in
                        if List.isEmpty overrides then
                            prev
                                |> withInnerStep index
                                    total
                                    "No overrides"
                                    (\( _, original ) -> BackendTask.succeed (Json.Value.encode original))

                        else
                            List.foldl
                                (\override ->
                                    case override of
                                        OpenApi.Config.Url url ->
                                            withInnerStep index
                                                total
                                                ("Download override from " ++ Url.toString url)
                                                (\( acc, original ) -> BackendTask.map (\read -> ( ( override, read ) :: acc, original )) (readFromUrl url))

                                        OpenApi.Config.File path ->
                                            withInnerStep index
                                                total
                                                ("Read override from " ++ path)
                                                (\( acc, original ) -> BackendTask.map (\read -> ( ( override, read ) :: acc, original )) (readFromFile path))
                                )
                                prev
                                overrides
                                |> withInnerStep index total "Merging overrides" mergeOverrides
                   )
                |> (case OpenApi.Config.writeMergedTo input of
                        Nothing ->
                            identity

                        Just destination ->
                            withInnerStep index total "Writing merged OAS" (writeMerged destination)
                   )
                |> Pages.Script.Spinner.withStep (counter index total ++ " Parse OAS")
                    (\( merged, apiSpecAcc, formatsAcc ) ->
                        merged
                            |> decodeOpenApiSpecOrFail { hasAttemptedToConvertFromSwagger = False } config input
                            |> BackendTask.map
                                (\( apiSpec, formats ) ->
                                    ( ()
                                    , ( input, apiSpec ) :: apiSpecAcc
                                    , formats :: formatsAcc
                                    )
                                )
                    )
            )
        )
        ( 1
        , Pages.Script.Spinner.steps
            |> Pages.Script.Spinner.withStep "Collecting configuration" (\_ -> BackendTask.succeed ( (), [], [] ))
        )
        (OpenApi.Config.inputs config)
        |> Tuple.second
        |> Pages.Script.Spinner.withStep "Generate Elm modules"
            (\( (), apiSpecs, allFormats ) ->
                OpenApi.Config.toGenerationConfig (List.concat allFormats) config apiSpecs
                    |> generateFilesFromOpenApiSpecs
            )
        |> Pages.Script.Spinner.withStep "Format with elm-format" (onFirst attemptToFormat)
        |> Pages.Script.Spinner.withStep "Write to disk" (onFirst (writeSdkToDisk (OpenApi.Config.outputDirectory config)))
        |> Pages.Script.Spinner.runSteps
        |> BackendTask.andThen printSuccessMessageAndWarnings


counter : Int -> Int -> String
counter index total =
    let
        totalString : String
        totalString =
            String.fromInt total
    in
    "["
        ++ String.padLeft (String.length totalString) '0' (String.fromInt index)
        ++ "/"
        ++ totalString
        ++ "]"


onFirst : (a -> BackendTask.BackendTask error c) -> ( a, b ) -> BackendTask.BackendTask error ( c, b )
onFirst f ( a, b ) =
    f a |> BackendTask.map (\c -> ( c, b ))


parseOriginal : OpenApi.Config.Input -> String -> BackendTask.BackendTask FatalError.FatalError ( List a, Json.Value.JsonValue )
parseOriginal input original =
    case decodeMaybeYaml (OpenApi.Config.oasPath input) original of
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


decodeOpenApiSpecOrFail :
    { hasAttemptedToConvertFromSwagger : Bool }
    -> OpenApi.Config.Config
    -> OpenApi.Config.Input
    -> Json.Decode.Value
    -> BackendTask.BackendTask FatalError.FatalError ( OpenApi.OpenApi, List { format : String, basicType : Common.BasicType } )
decodeOpenApiSpecOrFail { hasAttemptedToConvertFromSwagger } config input value =
    case
        Result.map2 Tuple.pair
            (Json.Decode.decodeValue OpenApi.decode value)
            (extractFormats value)
    of
        Ok pair ->
            BackendTask.succeed pair

        Err decodeError ->
            if hasAttemptedToConvertFromSwagger then
                jsonErrorToFatalError decodeError
                    |> BackendTask.fail

            else
                case Json.Decode.decodeValue swaggerFieldDecoder value of
                    Err _ ->
                        jsonErrorToFatalError decodeError
                            |> BackendTask.fail

                    Ok _ ->
                        let
                            askForConversion : BackendTask error Bool
                            askForConversion =
                                if OpenApi.Config.autoConvertSwagger config then
                                    BackendTask.succeed True

                                else
                                    Pages.Script.question
                                        (Ansi.Color.fontColor Ansi.Color.brightCyan (OpenApi.Config.pathToString (OpenApi.Config.oasPath input))
                                            ++ """ is a Swagger doc (aka Open API v2) and this tool only supports Open API v3.
Would you like to use """
                                            ++ Ansi.Color.fontColor Ansi.Color.brightCyan (OpenApi.Config.swaggerConversionUrl config)
                                            ++ " to upgrade to v3? (y/n)\n"
                                        )
                                        |> BackendTask.map (\response -> String.toLower response == "y")
                        in
                        askForConversion
                            |> BackendTask.andThen
                                (\shouldConvert ->
                                    if shouldConvert then
                                        convertToSwaggerAndThenDecode config input value

                                    else
                                        ("""The input file appears to be a Swagger doc,
and the CLI was not configured to automatically convert it to an Open API spec.
See the """
                                            ++ Ansi.Color.fontColor Ansi.Color.brightCyan "--auto-convert-swagger"
                                            ++ " flag for more info."
                                        )
                                            |> FatalError.fromString
                                            |> BackendTask.fail
                                )


extractFormats : Json.Decode.Value -> Result Json.Decode.Error (List { format : String, basicType : Common.BasicType })
extractFormats value =
    Json.Decode.decodeValue formatDecoder value


formatDecoder : Json.Decode.Decoder (List { format : String, basicType : Common.BasicType })
formatDecoder =
    let
        typeDecoder : Json.Decode.Decoder Common.BasicType
        typeDecoder =
            Json.Decode.string
                |> Json.Decode.andThen
                    (\type_ ->
                        case type_ of
                            "string" ->
                                Json.Decode.succeed Common.String

                            "integer" ->
                                Json.Decode.succeed Common.Integer

                            "boolean" ->
                                Json.Decode.succeed Common.Boolean

                            "number" ->
                                Json.Decode.succeed Common.Number

                            _ ->
                                Json.Decode.fail "Unexpected type"
                    )
    in
    Json.Decode.oneOf
        [ Json.Decode.list (Json.Decode.lazy (\_ -> formatDecoder))
            |> Json.Decode.map List.concat
        , Json.Decode.dict Json.Decode.value
            |> Json.Decode.andThen
                (\dict ->
                    case ( Dict.get "format" dict, Dict.get "type" dict ) of
                        ( Just format, Just type_ ) ->
                            Result.map2
                                (\fmt basicType ->
                                    [ { format = fmt
                                      , basicType = basicType
                                      }
                                    ]
                                )
                                (Json.Decode.decodeValue Json.Decode.string format)
                                (Json.Decode.decodeValue typeDecoder type_)
                                |> resultToDecoder

                        _ ->
                            dict
                                |> Dict.values
                                |> Result.Extra.combineMap
                                    (\v -> Json.Decode.decodeValue (Json.Decode.lazy (\_ -> formatDecoder)) v)
                                |> Result.map List.concat
                                |> resultToDecoder
                )
        , Json.Decode.succeed []
        ]


resultToDecoder : Result Json.Decode.Error a -> Json.Decode.Decoder a
resultToDecoder result =
    case result of
        Ok ok ->
            Json.Decode.succeed ok

        Err e ->
            Json.Decode.fail (Json.Decode.errorToString e)


convertToSwaggerAndThenDecode : OpenApi.Config.Config -> OpenApi.Config.Input -> Json.Decode.Value -> BackendTask.BackendTask FatalError.FatalError ( OpenApi.OpenApi, List { format : String, basicType : Common.BasicType } )
convertToSwaggerAndThenDecode config input value =
    convertSwaggerToOpenApi config (Json.Encode.encode 0 value)
        |> BackendTask.andThen
            (\swagger ->
                parseOriginal input swagger
                    |> BackendTask.andThen mergeOverrides
            )
        |> Pages.Script.Spinner.runTask "Convert Swagger to Open API"
        |> BackendTask.andThen (\converted -> decodeOpenApiSpecOrFail { hasAttemptedToConvertFromSwagger = True } config input converted)


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

                            else if key == "security" then
                                Result.map (\acc -> ( key, overrideValue ) :: acc) res

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
    case OpenApi.Config.swaggerConversionCommand config of
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
            let
                swaggerConversionUrl : String
                swaggerConversionUrl =
                    OpenApi.Config.swaggerConversionUrl config
            in
            BackendTask.Http.post swaggerConversionUrl
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
                                                "with the URL: " ++ swaggerConversionUrl

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


generateFilesFromOpenApiSpecs :
    List ( OpenApi.Generate.Config, OpenApi.OpenApi )
    ->
        BackendTask.BackendTask
            FatalError.FatalError
            ( List Elm.File
            , { warnings : List CliMonad.Message
              , requiredPackages : FastSet.Set String
              }
            )
generateFilesFromOpenApiSpecs configs =
    configs
        |> BackendTask.Extra.combineMap
            (\( config, apiSpec ) ->
                OpenApi.Generate.files config apiSpec
                    |> Result.mapError
                        (\err ->
                            err
                                |> messageToString
                                |> FatalError.fromString
                        )
                    |> BackendTask.fromResult
            )
        |> BackendTask.map
            (\result ->
                let
                    groupOrder : String -> Int
                    groupOrder group =
                        case group of
                            "Request functions" ->
                                1

                            "Types" ->
                                2

                            "Encoders" ->
                                3

                            "Decoders" ->
                                4

                            _ ->
                                5

                    commonDeclarationsFromResult : List { declaration : Elm.Declaration, group : String }
                    commonDeclarationsFromResult =
                        result
                            |> List.concatMap .modules
                            |> Dict.Extra.groupBy .moduleName
                            |> Dict.toList
                            |> List.concatMap
                                (\( moduleName, declarations ) ->
                                    if moduleName == Common.commonModuleName then
                                        declarations
                                            |> List.foldl (\e acc -> FastDict.union e.declarations acc) FastDict.empty
                                            |> FastDict.values

                                    else
                                        []
                                )

                    allEffectTypes : List OpenApi.Config.EffectType
                    allEffectTypes =
                        List.concatMap
                            (\( { effectTypes }, _ ) -> effectTypes)
                            configs

                    commonFile : Elm.File
                    commonFile =
                        OpenApi.Common.Internal.declarations
                            { effectTypes = allEffectTypes
                            , requiresBase64 = List.any (\{ requiredPackages } -> FastSet.member Common.base64PackageName requiredPackages) result
                            }
                            ++ commonDeclarationsFromResult
                            |> fileFromGroups Common.commonModuleName

                    fileFromGroups : List String -> List { group : String, declaration : Elm.Declaration } -> Elm.File
                    fileFromGroups moduleName declarations =
                        declarations
                            |> Dict.Extra.groupBy (\{ group } -> ( groupOrder group, group ))
                            |> Dict.toList
                            |> List.concatMap
                                (\( ( _, group ), decls ) ->
                                    [ Elm.docs ("## " ++ group)
                                    , Elm.group (List.map .declaration decls)
                                    ]
                                )
                            |> Elm.file moduleName
                in
                ( result
                    |> List.concatMap .modules
                    |> Dict.Extra.groupBy .moduleName
                    |> Dict.toList
                    |> List.filterMap
                        (\( moduleName, declarations ) ->
                            if moduleName == Common.commonModuleName then
                                Nothing

                            else
                                declarations
                                    |> List.foldl (\e acc -> FastDict.union e.declarations acc) FastDict.empty
                                    |> FastDict.values
                                    |> fileFromGroups moduleName
                                    |> Just
                        )
                    |> (::) commonFile
                , { warnings = List.concatMap .warnings result
                  , requiredPackages =
                        List.foldl
                            (\{ requiredPackages } acc -> FastSet.union requiredPackages acc)
                            FastSet.empty
                            result
                  }
                )
            )


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
                            |> BackendTask.Extra.combineMap
                                (\file ->
                                    BackendTask.Stream.fromString file.contents
                                        |> BackendTask.Stream.pipe (BackendTask.Stream.command "elm-format" [ "--stdin" ])
                                        |> BackendTask.Stream.read
                                        |> BackendTask.map (\formatted -> { file | contents = formatted.body })
                                        -- Never fail on formatting errors
                                        |> BackendTask.onError (\_ -> BackendTask.succeed file)
                                )

                    Nothing ->
                        BackendTask.succeed files
            )


writeSdkToDisk : String -> List Elm.File -> BackendTask.BackendTask FatalError.FatalError (List String)
writeSdkToDisk outputDirectory files =
    BackendTask.Extra.combineMap
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
        files


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
                |> Dict.Extra.groupBy .message
                |> Dict.toList
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


logWarning : ( String, List CliMonad.Message ) -> BackendTask.BackendTask FatalError.FatalError ()
logWarning ( message, messages ) =
    let
        firstLine : String
        firstLine =
            Ansi.Color.fontColor Ansi.Color.brightYellow "Warning: " ++ message

        paths : List String
        paths =
            messages
                |> List.filterMap
                    (\{ path } ->
                        if List.isEmpty path then
                            Nothing

                        else
                            Just ("  at " ++ String.join " -> " path)
                    )
                |> Set.fromList
                |> Set.toList
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
