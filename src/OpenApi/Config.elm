module OpenApi.Config exposing (Config, EffectType(..), Format, Path(..), Server(..), defaultFormats, init, pathFromString, pathToString)

import Common
import Dict
import Elm
import Elm.Annotation
import Gen.Date
import Gen.Json.Decode
import Gen.Json.Encode
import Gen.Parser.Advanced
import Gen.Result
import Gen.Rfc3339
import Gen.Time
import Url


type alias Config =
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
    , formats : List Format
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
    , sharedDeclarations : List Elm.Declaration
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
init oasPath outputDirectory =
    { oasPath = oasPath
    , outputDirectory = outputDirectory
    , outputModuleName = Nothing
    , effectTypes = [ ElmHttpCmd, ElmHttpTask ]
    , generateTodos = False
    , autoConvertSwagger = False
    , swaggerConversionUrl = "https://converter.swagger.io/api/convert"
    , swaggerConversionCommand = Nothing
    , server = Default
    , overrides = []
    , writeMergedTo = Nothing
    , formats = defaultFormats
    }


defaultFormats : List Format
defaultFormats =
    [ dateTimeFormat
    , dateFormat
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
