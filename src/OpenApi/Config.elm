module OpenApi.Config exposing (Config, EffectType(..), Format, Path(..), Server(..), autoConvertSwagger, defaultFormats, init, oasPath, outputDirectory, overrides, pathFromString, pathToString, swaggerConversionCommand, swaggerConversionUrl, toGenerationConfig, withAutoConvertSwagger, withEffectTypes, withFormat, withFormats, withGenerateTodos, withOutputModuleName, withOverrides, withServer, withSwaggerConversionCommand, withSwaggerConversionUrl, withWriteMergedTo, writeMergedTo)

import Common
import Dict
import Elm
import Elm.Annotation
import Elm.Op
import Gen.Date
import Gen.Json.Decode
import Gen.Json.Encode
import Gen.Maybe
import Gen.Parser.Advanced
import Gen.Result
import Gen.Rfc3339
import Gen.String
import Gen.Time
import Gen.Url
import Url


type Config
    = Config
        { oasPath : Path
        , outputDirectory : String
        , outputModuleName : Maybe (List String)
        , effectTypes : List EffectType
        , generateTodos : Bool
        , autoConvertSwagger : Bool
        , swaggerConversionUrl : String
        , swaggerConversionCommand : Maybe { command : String, args : List String }
        , server : Server
        , overrides : List Path
        , writeMergedTo : Maybe String
        , staticFormats : List Format
        , dynamicFormats : List { format : String, basicType : Common.BasicType } -> List Format
        }


type EffectType
    = ElmHttpCmd
    | ElmHttpCmdRecord
    | ElmHttpCmdRisky
    | ElmHttpTask
    | ElmHttpTaskRecord
    | ElmHttpTaskRisky
    | DillonkearnsElmPagesTask
    | DillonkearnsElmPagesTaskRecord
    | LamderaProgramTestCmd
    | LamderaProgramTestCmdRisky
    | LamderaProgramTestCmdRecord
    | LamderaProgramTestTask
    | LamderaProgramTestTaskRisky
    | LamderaProgramTestTaskRecord


type Server
    = Default
    | Single String
    | Multiple (Dict.Dict String String)


type alias Format =
    { basicType : Common.BasicType
    , format : String
    , encode : Elm.Expression -> Elm.Expression
    , decoder : Elm.Expression
    , toParamString : Elm.Expression -> Elm.Expression
    , annotation : Elm.Annotation.Annotation
    , sharedDeclarations : List ( String, Elm.Expression )
    , requiresPackages : List String
    }


pathFromString : String -> Path
pathFromString path =
    case Url.fromString path of
        Just url ->
            Url url

        Nothing ->
            File path


pathToString : Path -> String
pathToString pathType =
    case pathType of
        File file ->
            file

        Url url ->
            Url.toString url


type Path
    = File String -- swagger.json ./swagger.json /folder/swagger.json
    | Url Url.Url -- https://petstore3.swagger.io/api/v3/openapi.json


init : Path -> String -> Config
init initialOasPath initialOutputDirectory =
    { oasPath = initialOasPath
    , outputDirectory = initialOutputDirectory
    , outputModuleName = Nothing
    , effectTypes = [ ElmHttpCmd, ElmHttpTask ]
    , generateTodos = False
    , autoConvertSwagger = False
    , swaggerConversionUrl = "https://converter.swagger.io/api/convert"
    , swaggerConversionCommand = Nothing
    , server = Default
    , overrides = []
    , writeMergedTo = Nothing
    , staticFormats = defaultFormats
    , dynamicFormats = \_ -> []
    }
        |> Config


defaultFormats : List Format
defaultFormats =
    [ dateTimeFormat
    , dateFormat
    , uriFormat
    , defaultIntFormat "int32" Common.Integer
    , defaultIntFormat "int32" Common.Number
    , defaultFloatFormat "float"
    , defaultFloatFormat "double"
    , defaultStringFormat "password"
    ]


dateTimeFormat : Format
dateTimeFormat =
    let
        toString : Elm.Expression -> Elm.Expression
        toString instant =
            Gen.Rfc3339.make_.dateTimeOffset
                (Elm.record
                    [ ( "instant", instant )
                    , ( "offset"
                      , Elm.record
                            [ ( "hour", Elm.int 0 )
                            , ( "minute", Elm.int 0 )
                            ]
                      )
                    ]
                )
                |> Gen.Rfc3339.toString
    in
    { basicType = Common.String
    , format = "date-time"
    , annotation = Gen.Time.annotation_.posix
    , encode =
        \instant ->
            instant
                |> toString
                |> Gen.Json.Encode.call_.string
    , decoder =
        Gen.Json.Decode.string
            |> Gen.Json.Decode.andThen
                (\raw ->
                    Gen.Result.caseOf_.result
                        (Gen.Parser.Advanced.call_.run Gen.Rfc3339.dateTimeOffsetParser raw)
                        { ok = \record -> Gen.Json.Decode.succeed (Elm.get "instant" record)

                        -- TODO: improve error message
                        , err = \_ -> Gen.Json.Decode.fail "Invalid RFC-3339 date-time"
                        }
                )
    , toParamString = toString
    , sharedDeclarations = []
    , requiresPackages =
        [ "elm/parser"
        , "elm/time"
        , "justinmimbs/time-extra"
        , "wolfadex/elm-rfc3339"
        ]
    }


dateFormat : Format
dateFormat =
    { basicType = Common.String
    , format = "date"
    , annotation = Gen.Date.annotation_.date
    , encode =
        \date ->
            date
                |> Gen.Date.toIsoString
                |> Gen.Json.Encode.call_.string
    , toParamString = Gen.Date.toIsoString
    , decoder =
        Gen.Json.Decode.string
            |> Gen.Json.Decode.andThen
                (\raw ->
                    Gen.Result.caseOf_.result
                        (Gen.Date.call_.fromIsoString raw)
                        { ok = Gen.Json.Decode.succeed
                        , err = Gen.Json.Decode.call_.fail
                        }
                )
    , sharedDeclarations = []
    , requiresPackages = [ "justinmimbs/date" ]
    }


uriFormat : Format
uriFormat =
    { basicType = Common.String
    , format = "uri"
    , annotation = Gen.Url.annotation_.url
    , encode =
        \url ->
            url
                |> Gen.Url.toString
                |> Gen.Json.Encode.call_.string
    , toParamString = Gen.Url.toString
    , decoder =
        Gen.Json.Decode.string
            |> Gen.Json.Decode.andThen
                (\raw ->
                    Gen.Maybe.caseOf_.maybe
                        (Gen.Url.call_.fromString raw)
                        { just = Gen.Json.Decode.succeed
                        , nothing =
                            Gen.Json.Decode.call_.fail
                                (Elm.Op.append raw (Elm.string " is not a valid URL"))
                        }
                )
    , sharedDeclarations = []
    , requiresPackages = [ "justinmimbs/date" ]
    }


defaultIntFormat : String -> Common.BasicType -> Format
defaultIntFormat format basicType =
    { basicType = basicType
    , format = format
    , annotation = Elm.Annotation.int
    , encode = Gen.Json.Encode.call_.int
    , decoder = Gen.Json.Decode.int
    , toParamString = Gen.String.call_.fromInt
    , sharedDeclarations = []
    , requiresPackages = []
    }


defaultFloatFormat : String -> Format
defaultFloatFormat format =
    { basicType = Common.Number
    , format = format
    , annotation = Elm.Annotation.float
    , encode = Gen.Json.Encode.call_.float
    , decoder = Gen.Json.Decode.float
    , toParamString = Gen.String.call_.fromFloat
    , sharedDeclarations = []
    , requiresPackages = []
    }


defaultStringFormat : String -> Format
defaultStringFormat format =
    { basicType = Common.String
    , format = format
    , annotation = Elm.Annotation.string
    , encode = Gen.Json.Encode.call_.string
    , decoder = Gen.Json.Decode.string
    , toParamString = identity
    , sharedDeclarations = []
    , requiresPackages = []
    }


withEffectTypes : List EffectType -> Config -> Config
withEffectTypes effectTypes (Config config) =
    Config { config | effectTypes = effectTypes }


withOutputModuleName : List String -> Config -> Config
withOutputModuleName moduleName (Config config) =
    Config { config | outputModuleName = Just moduleName }


withOverrides : List Path -> Config -> Config
withOverrides newOverrides (Config config) =
    Config { config | overrides = newOverrides }


withGenerateTodos : Bool -> Config -> Config
withGenerateTodos generateTodos (Config config) =
    Config { config | generateTodos = generateTodos }


withAutoConvertSwagger : Bool -> Config -> Config
withAutoConvertSwagger newAutoConvertSwagger (Config config) =
    Config { config | autoConvertSwagger = newAutoConvertSwagger }


withSwaggerConversionUrl : String -> Config -> Config
withSwaggerConversionUrl newSwaggerConversionUrl (Config config) =
    Config { config | swaggerConversionUrl = newSwaggerConversionUrl }


withSwaggerConversionCommand : { command : String, args : List String } -> Config -> Config
withSwaggerConversionCommand newSwaggerConversionCommand (Config config) =
    Config { config | swaggerConversionCommand = Just newSwaggerConversionCommand }


withServer : Server -> Config -> Config
withServer newServer (Config config) =
    Config { config | server = newServer }


withWriteMergedTo : String -> Config -> Config
withWriteMergedTo newWriteMergedTo (Config config) =
    Config { config | writeMergedTo = Just newWriteMergedTo }


withFormat : Format -> Config -> Config
withFormat newFormat (Config config) =
    Config { config | staticFormats = newFormat :: config.staticFormats }


withFormats :
    (List { format : String, basicType : Common.BasicType } -> List Format)
    -> Config
    -> Config
withFormats newFormat (Config config) =
    Config { config | dynamicFormats = \input -> newFormat input ++ config.dynamicFormats input }


swaggerConversionUrl : Config -> String
swaggerConversionUrl (Config config) =
    config.swaggerConversionUrl


swaggerConversionCommand : Config -> Maybe { command : String, args : List String }
swaggerConversionCommand (Config config) =
    config.swaggerConversionCommand


autoConvertSwagger : Config -> Bool
autoConvertSwagger (Config config) =
    config.autoConvertSwagger


oasPath : Config -> Path
oasPath (Config config) =
    config.oasPath


toGenerationConfig :
    List { format : String, basicType : Common.BasicType }
    -> Config
    ->
        { outputModuleName : Maybe (List String)
        , generateTodos : Bool
        , effectTypes : List EffectType
        , server : Server
        , formats : List Format
        }
toGenerationConfig input (Config config) =
    { outputModuleName = config.outputModuleName
    , generateTodos = config.generateTodos
    , effectTypes = config.effectTypes
    , server = config.server
    , formats = config.staticFormats ++ config.dynamicFormats input
    }


writeMergedTo : Config -> Maybe String
writeMergedTo (Config config) =
    config.writeMergedTo


overrides : Config -> List Path
overrides (Config config) =
    config.overrides


outputDirectory : Config -> String
outputDirectory (Config config) =
    config.outputDirectory
