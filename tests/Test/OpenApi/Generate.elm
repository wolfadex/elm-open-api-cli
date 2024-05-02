module Test.OpenApi.Generate exposing (suite)

import Char
import CliMonad
import Elm
import Expect
import Fuzz
import Json.Decode
import OpenApi
import OpenApi.Generate
import String.Extra
import Test exposing (Test)


suite : Test
suite =
    Test.describe "open api generation"
        [ Test.fuzz Fuzz.string
            "sanitizeModuleName"
          <|
            \inputName ->
                let
                    moduleName : Maybe String
                    moduleName =
                        OpenApi.Generate.sanitizeModuleName inputName
                in
                if String.any Char.isAlphaNum inputName then
                    case moduleName of
                        Just finalName ->
                            if String.all Char.isAlphaNum finalName then
                                Expect.pass

                            else
                                Expect.fail ("Unexpected chars in module name: " ++ finalName)

                        Nothing ->
                            Expect.fail "Unexpected Nothing"

                else
                    Expect.equal moduleName Nothing
        , Test.fuzz Fuzz.string
            "valid output file & module name"
          <|
            \inputName ->
                let
                    oasString : String
                    oasString =
                        """{
  "openapi": "3.1.0",
  "info": {
    "title":    \"""" ++ inputName ++ """",
    "version": "1.0.0"
  }
}"""
                in
                case Json.Decode.decodeString OpenApi.decode oasString of
                    Err _ ->
                        Expect.pass

                    Ok oas ->
                        let
                            namespace : List String
                            namespace =
                                OpenApi.Generate.sanitizeModuleName inputName
                                    |> Maybe.withDefault "Carl"
                                    |> List.singleton

                            genFiles : Result CliMonad.Message ( List Elm.File, List CliMonad.Message )
                            genFiles =
                                OpenApi.Generate.files
                                    { namespace = namespace
                                    , generateTodos = False
                                    }
                                    oas
                        in
                        case genFiles of
                            Err _ ->
                                Expect.fail "Unexpected generation error"

                            Ok ( files, _ ) ->
                                case files of
                                    [] ->
                                        Expect.fail "Expected to generate 2 files but found none"

                                    [ file ] ->
                                        Expect.fail ("Expected to generate 2 files but found 1: " ++ file.path)

                                    [ apiFile, helperFile ] ->
                                        let
                                            apiPath : String
                                            apiPath =
                                                String.join "/" namespace ++ "/Api.elm"
                                        in
                                        if apiFile.path == apiPath then
                                            let
                                                helperPath : String
                                                helperPath =
                                                    String.join "/" namespace ++ "/OpenApi.elm"
                                            in
                                            if helperFile.path == helperPath then
                                                Expect.pass

                                            else
                                                Expect.fail ("Expected to generate a file with the path " ++ helperPath ++ " but I found " ++ helperFile.path)

                                        else
                                            Expect.fail ("Expected to generate a file with the path " ++ apiPath ++ " but I found " ++ apiFile.path)

                                    _ :: _ :: extraFiles ->
                                        Expect.fail ("Expected to generate 2 files but found extra: " ++ String.Extra.toSentenceOxford (List.map .path extraFiles))

        -- Known bug: https://github.com/wolfadex/elm-open-api-cli/issues/48
        , Test.test "The OAS title: service API (params in:body)" <|
            \() ->
                let
                    moduleName : Maybe String
                    moduleName =
                        OpenApi.Generate.sanitizeModuleName "service API (params in:body)"
                in
                Expect.equal moduleName (Just "ServiceApiParamsInBody")
        ]
