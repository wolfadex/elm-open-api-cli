module OpenApi.Config exposing (Config, Path(..), defaultFormats, init, pathFromString, pathToString)

import CliMonad
import Common
import Elm
import Elm.Annotation
import Gen.Date
import Gen.Json.Decode
import Gen.Json.Encode
import Gen.Parser.Advanced
import Gen.Result
import Gen.Rfc3339
import Gen.Time
import OpenApi.Generate
import Url


type alias Config =
    { oasPath : Path
    , outputDirectory : String
    , outputModuleName : Maybe (List String)
    , effectTypes : List OpenApi.Generate.EffectType
    , generateTodos : Bool
    , autoConvertSwagger : Bool
    , swaggerConversionUrl : String
    , swaggerConversionCommand : Maybe { command : String, args : List String }
    , server : OpenApi.Generate.Server
    , overrides : List Path
    , writeMergedTo : Maybe String
    , formats : List CliMonad.Format
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
init oasPath outputDirectory =
    { oasPath = oasPath
    , outputDirectory = outputDirectory
    , outputModuleName = Nothing
    , effectTypes = []
    , generateTodos = False
    , autoConvertSwagger = False
    , swaggerConversionUrl = "https://converter.swagger.io/api/convert"
    , swaggerConversionCommand = Nothing
    , server = OpenApi.Generate.Default
    , overrides = []
    , writeMergedTo = Nothing
    , formats = defaultFormats
    }


defaultFormats : List CliMonad.Format
defaultFormats =
    [ dateTimeFormat
    , dateFormat
    , defaultStringFormat "password"
    ]


dateTimeFormat : CliMonad.Format
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


dateFormat : CliMonad.Format
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


defaultStringFormat : String -> CliMonad.Format
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
