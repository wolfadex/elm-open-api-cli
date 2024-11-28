module OpenApi.Config exposing (Config, PathType(..), pathTypeFromString, pathTypeToString)

import CliMonad
import OpenApi.Generate
import Url


type alias Config =
    { oasPath : PathType
    , outputDirectory : String
    , outputModuleName : Maybe (List String)
    , effectTypes : List OpenApi.Generate.EffectType
    , generateTodos : Bool
    , autoConvertSwagger : Bool
    , swaggerConversionUrl : String
    , swaggerConversionCommand : Maybe { command : String, args : List String }
    , server : OpenApi.Generate.Server
    , overrides : List PathType
    , writeMergedTo : Maybe String
    , formats : List CliMonad.Format
    }


pathTypeFromString : String -> PathType
pathTypeFromString path =
    case Url.fromString path of
        Just url ->
            Url url

        Nothing ->
            File path


pathTypeToString : PathType -> String
pathTypeToString pathType =
    case pathType of
        File file ->
            file

        Url url ->
            Url.toString url


type PathType
    = File String -- swagger.json ./swagger.json /folder/swagger.json
    | Url Url.Url -- https://petstore3.swagger.io/api/v3/openapi.json
