module OpenApi.Config exposing
    ( Config, EffectType(..), effectTypeToPackage, Format, Input, Path(..), Server(..)
    , init, inputFrom, pathFromString
    , withAutoConvertSwagger, withEffectTypes, withFormat, withFormats, withGenerateTodos, withInput, withSwaggerConversionCommand, withSwaggerConversionUrl
    , withOutputModuleName, withOverrides, withServer, withWriteMergedTo
    , autoConvertSwagger, inputs, outputDirectory, swaggerConversionCommand, swaggerConversionUrl
    , oasPath, overrides, writeMergedTo
    , toGenerationConfig, pathToString
    , defaultFormats
    )

{-|


# Types

@docs Config, EffectType, effectTypeToPackage, Format, Input, Path, Server


# Creation

@docs init, inputFrom, pathFromString
@docs withAutoConvertSwagger, withEffectTypes, withFormat, withFormats, withGenerateTodos, withInput, withSwaggerConversionCommand, withSwaggerConversionUrl
@docs withOutputModuleName, withOverrides, withServer, withWriteMergedTo


# Config properties

@docs autoConvertSwagger, inputs, outputDirectory, swaggerConversionCommand, swaggerConversionUrl


# Input properties

@docs oasPath, overrides, writeMergedTo


# Output

@docs toGenerationConfig, pathToString


# Internal

@docs defaultFormats

-}

import Common
import Dict
import Elm
import Elm.Annotation
import Elm.Case
import Elm.Op
import Gen.Base64
import Gen.Bytes
import Gen.Date
import Gen.Json.Decode
import Gen.Json.Encode
import Gen.Maybe
import Gen.Parser.Advanced
import Gen.Result
import Gen.Rfc3339
import Gen.Time
import Gen.Url
import OpenApi
import OpenApi.Info
import Url
import Utils


{-| Configuration for OpenAPI code generation. See:

  - inputFrom
  - builder functions in this module, such as withInput, withFormat, etc.

-}
type Config
    = Config
        { inputs : List Input
        , outputDirectory : String
        , generateTodos : Bool
        , autoConvertSwagger : Bool
        , swaggerConversionUrl : String
        , swaggerConversionCommand : Maybe { command : String, args : List String }
        , staticFormats : List Format
        , dynamicFormats : List { format : String, basicType : Common.BasicType } -> List Format
        }


{-| An OpenAPI schema used as the basis for code generation.
-}
type Input
    = Input
        { oasPath : Path
        , outputModuleName : Maybe (List String)
        , server : Server
        , overrides : List Path
        , writeMergedTo : Maybe String
        , effectTypes : List EffectType
        }


{-| Different effect types, for API call generation. Each represents a way to create HTTP calls in Elm or Lamdera.
-}
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


{-| Determine which package is needed for an EffectType
-}
effectTypeToPackage : EffectType -> Common.Package
effectTypeToPackage effectType =
    case effectType of
        ElmHttpCmd ->
            Common.ElmHttp

        ElmHttpCmdRisky ->
            Common.ElmHttp

        ElmHttpCmdRecord ->
            Common.ElmHttp

        ElmHttpTask ->
            Common.ElmHttp

        ElmHttpTaskRisky ->
            Common.ElmHttp

        ElmHttpTaskRecord ->
            Common.ElmHttp

        DillonkearnsElmPagesTaskRecord ->
            Common.ElmHttp

        DillonkearnsElmPagesTask ->
            Common.DillonkearnsElmPages

        LamderaProgramTestCmd ->
            Common.LamderaProgramTest

        LamderaProgramTestCmdRisky ->
            Common.LamderaProgramTest

        LamderaProgramTestCmdRecord ->
            Common.LamderaProgramTest

        LamderaProgramTestTask ->
            Common.LamderaProgramTest

        LamderaProgramTestTaskRisky ->
            Common.LamderaProgramTest

        LamderaProgramTestTaskRecord ->
            Common.LamderaProgramTest


{-| OpenAPI server setting.

To skip generating a Server.elm file, use `Multiple []`.

-}
type Server
    = Default
    | Single String
    | Multiple (Dict.Dict String String)


{-| Specify how to generate code and type annotations for data with a `format:` declared.
-}
type alias Format =
    { basicType : Common.BasicType
    , format : String
    , encode : Elm.Expression -> Elm.Expression
    , decoder : Elm.Expression
    , toParamString : Elm.Expression -> Elm.Expression
    , annotation : Elm.Annotation.Annotation
    , sharedDeclarations : List ( String, { value : Elm.Expression, group : String } )
    , requiresPackages : List String
    }


{-| Specify the location of an input, such as a schema or schema overrides file.
-}
type Path
    = File String -- swagger.json ./swagger.json /folder/swagger.json
    | Url Url.Url -- https://petstore3.swagger.io/api/v3/openapi.json


{-| Create a Path
-}
pathFromString : String -> Path
pathFromString path =
    case Url.fromString path of
        Just url ->
            Url url

        Nothing ->
            File path


{-| Unwrap a Path
-}
pathToString : Path -> String
pathToString pathType =
    case pathType of
        File file ->
            file

        Url url ->
            Url.toString url


{-| Create a new Config, given an initial value for output directory
-}
init : String -> Config
init initialOutputDirectory =
    { inputs = []
    , outputDirectory = initialOutputDirectory
    , generateTodos = False
    , autoConvertSwagger = False
    , swaggerConversionUrl = "https://converter.swagger.io/api/convert"
    , swaggerConversionCommand = Nothing
    , staticFormats = defaultFormats
    , dynamicFormats = \_ -> []
    }
        |> Config


{-| Create an Input for a Config
-}
inputFrom : Path -> Input
inputFrom path =
    { oasPath = path
    , outputModuleName = Nothing
    , server = Default
    , overrides = []
    , writeMergedTo = Nothing
    , effectTypes = [ ElmHttpCmd, ElmHttpTask ]
    }
        |> Input



-------------
-- Formats --
-------------


{-| Built-in Formats
-}
defaultFormats : List Format
defaultFormats =
    [ dateTimeFormat
    , dateFormat
    , uriFormat
    , byteFormat
    ]


{-| Default format for `format: date-time`
-}
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


{-| Default format for `format: date`
-}
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


{-| Default format for `format: uri`
-}
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


{-| Default format for `format: byte`
-}
byteFormat : Format
byteFormat =
    { basicType = Common.String
    , format = "byte"
    , annotation = Gen.Bytes.annotation_.bytes
    , encode =
        \bytes ->
            Gen.Base64.fromBytes bytes
                |> Gen.Maybe.withDefault (Elm.string "")
                |> Gen.Json.Encode.call_.string
    , toParamString =
        \bytes ->
            Gen.Base64.fromBytes bytes
                |> Gen.Maybe.withDefault (Elm.string "")
    , decoder =
        Gen.Json.Decode.string
            |> Gen.Json.Decode.andThen
                (\raw ->
                    Elm.Case.maybe (Gen.Base64.call_.toBytes raw)
                        { just = ( "bytes", Gen.Json.Decode.succeed )
                        , nothing = Gen.Json.Decode.fail "Invalid base64 data"
                        }
                )
    , sharedDeclarations = []
    , requiresPackages = [ Common.base64PackageName ]
    }



-------------
-- Setters --
-------------


{-| Set the type of Effects generated for an Input
-}
withEffectTypes : List EffectType -> Input -> Input
withEffectTypes effectTypes (Input input) =
    Input { input | effectTypes = effectTypes }


{-| Set an Input's generated Elm module name
-}
withOutputModuleName : List String -> Input -> Input
withOutputModuleName moduleName (Input input) =
    Input { input | outputModuleName = Just moduleName }


{-| Add override file(s) to an input, to override parts of the schema.

Override files cannot delete a key from a schema, but can add keys or change the values of keys.

However, specifying `security: []` in an override for a Path will override the top-level `security` declaration.

-}
withOverrides : List Path -> Input -> Input
withOverrides newOverrides (Input input) =
    Input { input | overrides = newOverrides }


{-| Set whether to generate Debug.todo's.
-}
withGenerateTodos : Bool -> Config -> Config
withGenerateTodos generateTodos (Config config) =
    Config { config | generateTodos = generateTodos }


{-| Set whether to automatically convert a Swagger schema to an OpenAPI one.
-}
withAutoConvertSwagger : Bool -> Config -> Config
withAutoConvertSwagger newAutoConvertSwagger (Config config) =
    Config { config | autoConvertSwagger = newAutoConvertSwagger }


{-| Set the URL to convert a Swagger schema to an OpenAPI one.
-}
withSwaggerConversionUrl : String -> Config -> Config
withSwaggerConversionUrl newSwaggerConversionUrl (Config config) =
    Config { config | swaggerConversionUrl = newSwaggerConversionUrl }


{-| Set the shell command to convert a Swagger schema to an OpenAPI one.
-}
withSwaggerConversionCommand : { command : String, args : List String } -> Config -> Config
withSwaggerConversionCommand newSwaggerConversionCommand (Config config) =
    Config { config | swaggerConversionCommand = Just newSwaggerConversionCommand }


{-| Configure Server.elm module generation.
-}
withServer : Server -> Input -> Input
withServer newServer (Input input) =
    Input { input | server = newServer }


{-| Set output for merged writing.
-}
withWriteMergedTo : String -> Input -> Input
withWriteMergedTo newWriteMergedTo (Input input) =
    Input { input | writeMergedTo = Just newWriteMergedTo }


{-| Add a custom Format.
-}
withFormat : Format -> Config -> Config
withFormat newFormat (Config config) =
    Config { config | staticFormats = newFormat :: config.staticFormats }


{-| Add dynamic formats.
-}
withFormats :
    (List { format : String, basicType : Common.BasicType } -> List Format)
    -> Config
    -> Config
withFormats newFormat (Config config) =
    Config { config | dynamicFormats = \input -> newFormat input ++ config.dynamicFormats input }


{-| Add an input schema.
-}
withInput : Input -> Config -> Config
withInput input (Config config) =
    Config { config | inputs = input :: config.inputs }



-------------
-- Getters --
-------------


{-| Retrieve Swagger conversion URL.
-}
swaggerConversionUrl : Config -> String
swaggerConversionUrl (Config config) =
    config.swaggerConversionUrl


{-| Retrieve Swagger conversion command.
-}
swaggerConversionCommand : Config -> Maybe { command : String, args : List String }
swaggerConversionCommand (Config config) =
    config.swaggerConversionCommand


{-| Retrieve whether to automatically convert Swagger to OpenAPI.
-}
autoConvertSwagger : Config -> Bool
autoConvertSwagger (Config config) =
    config.autoConvertSwagger


{-| Retrieve a Config's output directory.
-}
outputDirectory : Config -> String
outputDirectory (Config config) =
    config.outputDirectory


{-| Retrieve Inputs.
-}
inputs : Config -> List Input
inputs (Config config) =
    List.reverse config.inputs


{-| Retrieve OpenAPI Schema path.
-}
oasPath : Input -> Path
oasPath (Input input) =
    input.oasPath


{-| Retrieve writeMergedTo path, if applicable.
-}
writeMergedTo : Input -> Maybe String
writeMergedTo (Input input) =
    input.writeMergedTo


{-| Retrieve schema override paths.
-}
overrides : Input -> List Path
overrides (Input input) =
    input.overrides



------------
-- Output --
------------


{-| For internal use only.
-}
toGenerationConfig :
    List { format : String, basicType : Common.BasicType }
    -> Config
    -> List ( Input, OpenApi.OpenApi )
    ->
        List
            ( { namespace : List String
              , generateTodos : Bool
              , effectTypes : List EffectType
              , server : Server
              , formats : List Format
              }
            , OpenApi.OpenApi
            )
toGenerationConfig formatsInput (Config config) augmentedInputs =
    List.map
        (\( Input input, spec ) ->
            ( { namespace =
                    case input.outputModuleName of
                        Just modName ->
                            modName

                        Nothing ->
                            spec
                                |> OpenApi.info
                                |> OpenApi.Info.title
                                |> Utils.sanitizeModuleName
                                |> Maybe.withDefault "Api"
                                |> List.singleton
              , generateTodos = config.generateTodos
              , effectTypes = input.effectTypes
              , server = input.server
              , formats = config.staticFormats ++ config.dynamicFormats formatsInput
              }
            , spec
            )
        )
        augmentedInputs
