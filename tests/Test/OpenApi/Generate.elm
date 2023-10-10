module Test.OpenApi.Generate exposing (suite)

import Char
import Elm
import Expect
import Fuzz
import Json.Decode
import OpenApi
import OpenApi.Generate
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
                            moduleName : String
                            moduleName =
                                OpenApi.Generate.sanitizeModuleName inputName
                                    |> Maybe.withDefault "Api"

                            genFile : Result String ( Elm.File, List Elm.Warning )
                            genFile =
                                OpenApi.Generate.file
                                    { namespace = moduleName
                                    , generateTodos = False
                                    }
                                    oas
                        in
                        case genFile of
                            Err _ ->
                                Expect.fail "Unexpected generation error"

                            Ok ( file, _ ) ->
                                Expect.equal file.path (moduleName ++ ".elm")

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
