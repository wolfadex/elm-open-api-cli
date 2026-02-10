module Test.OpenApi.Generate exposing (fuzzInputName, fuzzTitle, issue48, pr267)

import Ansi.Color
import CliMonad
import Dict
import Dict.Extra
import Diff
import Diff.ToString
import Elm
import Expect
import FastDict
import FastSet
import Fuzz
import Json.Decode
import Json.Encode
import OpenApi
import OpenApi.Config
import OpenApi.Generate
import String.Extra
import String.Multiline
import Test exposing (Test)
import Utils
import Yaml.Decode


moduleNames : List { a | moduleName : List String } -> String
moduleNames modules =
    modules
        |> List.map (\{ moduleName } -> String.join "." moduleName)
        |> String.Extra.toSentenceOxford


expectModuleName : { a | moduleName : List String } -> List String -> Expect.Expectation
expectModuleName file expectedPath =
    Expect.equal file.moduleName expectedPath
        |> Expect.onFail
            ("Expected to generate a file with the module name "
                ++ String.join "." expectedPath
                ++ " but I found "
                ++ moduleNames [ file ]
            )


composeExpectations : List Expect.Expectation -> Expect.Expectation
composeExpectations expectations =
    Expect.all
        (List.map (\x -> always x) expectations)
        ()


fuzzInputName : Test
fuzzInputName =
    Test.fuzz Fuzz.string
        "sanitizeModuleName"
    <|
        \inputName ->
            let
                moduleName : Maybe String
                moduleName =
                    Utils.sanitizeModuleName inputName
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


fuzzTitle : Test
fuzzTitle =
    Test.fuzz Fuzz.string
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
  },
  "paths": {
    "/": {
      "get": {
      }
    }
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
                            Utils.sanitizeModuleName inputName
                                |> Maybe.withDefault "Carl"
                                |> List.singleton

                        genFiles :
                            Result
                                CliMonad.Message
                                { modules :
                                    List
                                        { moduleName : List String
                                        , declarations : FastDict.Dict String { group : String, declaration : Elm.Declaration }
                                        }
                                , warnings : List CliMonad.Message
                                , requiredPackages : FastSet.Set String
                                }
                        genFiles =
                            OpenApi.Generate.files
                                { namespace = namespace
                                , generateTodos = False
                                , effectTypes = [ OpenApi.Config.ElmHttpCmd, OpenApi.Config.ElmHttpTask ]
                                , server = OpenApi.Config.Default
                                , formats = OpenApi.Config.defaultFormats
                                , warnOnMissingEnums = True
                                }
                                oas
                    in
                    case genFiles of
                        Err e ->
                            Expect.fail ("Error in generation: " ++ Debug.toString e)

                        Ok { modules } ->
                            case modules of
                                [ jsonFile, apiFile, helperFile ] ->
                                    let
                                        jsonPath : List String
                                        jsonPath =
                                            namespace ++ [ "Json" ]

                                        apiPath : List String
                                        apiPath =
                                            namespace ++ [ "Api" ]

                                        helperPath : List String
                                        helperPath =
                                            namespace ++ [ "OpenApi" ]
                                    in
                                    composeExpectations
                                        [ expectModuleName jsonFile jsonPath
                                        , expectModuleName apiFile apiPath
                                        , expectModuleName helperFile helperPath
                                        ]

                                [] ->
                                    Expect.fail "Expected to generate 3 files but found none"

                                _ ->
                                    Expect.fail
                                        ("Expected to generate 3 files but found "
                                            ++ (List.length modules |> String.fromInt)
                                            ++ ": "
                                            ++ moduleNames modules
                                        )


{-| Known bug: <https://github.com/wolfadex/elm-open-api-cli/issues/48>
-}
issue48 : Test
issue48 =
    Test.test "The OAS title: service API (params in:body)" <|
        \() ->
            let
                moduleName : Maybe String
                moduleName =
                    Utils.sanitizeModuleName "service API (params in:body)"
            in
            Expect.equal moduleName (Just "ServiceApiParamsInBody")


pr267 : Test
pr267 =
    Test.test "Responses and schemas don't clash" <|
        \() ->
            let
                jsonFileString : String
                jsonFileString =
                    String.Multiline.here """
                        module Output.Json exposing
                            ( decodeForbidden, decodeMessage
                            , encodeForbidden, encodeMessage
                            )
                        
                        {-|
                        @docs decodeForbidden, decodeMessage
                        
                        @docs encodeForbidden, encodeMessage
                        -}
                        
                        
                        import Json.Decode
                        import Json.Encode
                        import OpenApi.Common
                        import Output.Types
                        
                        
                        {- ## Decoders -}
                        
                        
                        decodeForbidden : Json.Decode.Decoder Output.Types.Forbidden
                        decodeForbidden =
                            decodeMessage
                        
                        
                        decodeMessage : Json.Decode.Decoder Output.Types.Message
                        decodeMessage =
                            Json.Decode.succeed
                                (\\msg -> { msg = msg }) |> OpenApi.Common.jsonDecodeAndMap
                                                                   (Json.Decode.field
                                                                            "msg"
                                                                            Json.Decode.string
                                                                   )
                        
                        
                        {- ## Encoders -}
                        
                        
                        encodeForbidden : Output.Types.Forbidden -> Json.Encode.Value
                        encodeForbidden =
                            encodeMessage
                        
                        
                        encodeMessage : Output.Types.Message -> Json.Encode.Value
                        encodeMessage rec =
                            Json.Encode.object [ ( "msg", Json.Encode.string rec.msg ) ]
                    """

                apiFileString : String
                apiFileString =
                    String.Multiline.here """
                        module Output.Api exposing ( api, apiTask )

                        {-|
                        @docs api, apiTask
                        -}


                        import Dict
                        import Http
                        import Json.Decode
                        import OpenApi.Common
                        import Output.Json
                        import Output.Types
                        import Task
                        import Url.Builder


                        {- ## Operations -}


                        api config =
                            Http.request
                                { url = Url.Builder.absolute [ "api" ] []
                                , method = "GET"
                                , headers = []
                                , expect =
                                    OpenApi.Common.expectJsonCustom
                                        (Dict.fromList [])
                                        Output.Json.decodeForbidden
                                        config.toMsg
                                , body = Http.emptyBody
                                , timeout = Nothing
                                , tracker = Nothing
                                }


                        apiTask : {} -> Task.Task (OpenApi.Common.Error e String) Output.Types.Forbidden
                        apiTask config =
                            Http.task
                                { url = Url.Builder.absolute [ "api" ] []
                                , method = "GET"
                                , headers = []
                                , resolver =
                                    OpenApi.Common.jsonResolverCustom
                                        (Dict.fromList [])
                                        Output.Json.decodeForbidden
                                , body = Http.emptyBody
                                , timeout = Nothing
                                }
                    """

                helperFileString : String
                helperFileString =
                    String.Multiline.here """
                    """

                oasString : String
                oasString =
                    String.Multiline.here """
                    openapi: 3.0.1
                    info:
                      title: "Simple Ref"
                      version: 1.0.0
                    components:
                      schemas:
                        Forbidden:
                          $ref: "#/components/schemas/Message"
                        Message:
                          type: object
                          properties:
                            msg:
                              type: string
                          required:
                            - msg
                      responses:
                        Forbidden:
                          description: Wrong credentials
                          content:
                            application/json:
                              schema:
                                $ref: "#/components/schemas/Forbidden"
                    paths:
                      "/api":
                        get:
                          responses:
                            200:
                              $ref: "#/components/responses/Forbidden"
                    """
            in
            case
                oasString
                    |> Yaml.Decode.fromString yamlToJsonValueDecoder
                    |> Result.mapError Debug.toString
                    |> Result.andThen
                        (\json ->
                            json
                                |> Json.Decode.decodeValue OpenApi.decode
                                |> Result.mapError Debug.toString
                        )
            of
                Err e ->
                    Expect.fail e

                Ok oas ->
                    let
                        genFiles :
                            Result
                                CliMonad.Message
                                { modules :
                                    List
                                        { moduleName : List String
                                        , declarations : FastDict.Dict String { group : String, declaration : Elm.Declaration }
                                        }
                                , warnings : List CliMonad.Message
                                , requiredPackages : FastSet.Set String
                                }
                        genFiles =
                            OpenApi.Generate.files
                                { namespace = [ "Output" ]
                                , generateTodos = False
                                , effectTypes = [ OpenApi.Config.ElmHttpCmd, OpenApi.Config.ElmHttpTask ]
                                , server = OpenApi.Config.Default
                                , formats = OpenApi.Config.defaultFormats
                                , warnOnMissingEnums = True
                                }
                                oas
                    in
                    case genFiles of
                        Err e ->
                            Expect.fail ("Error in generation: " ++ Debug.toString e)

                        Ok { modules } ->
                            case modules of
                                [ apiFile, jsonFile, helperFile ] ->
                                    composeExpectations
                                        [ expectEqualMultiline apiFileString (fileToString apiFile)
                                        , expectEqualMultiline jsonFileString (fileToString jsonFile)
                                        , expectEqualMultiline helperFileString (fileToString helperFile)
                                        ]

                                [] ->
                                    Expect.fail "Expected to generate 3 files but found none"

                                _ ->
                                    Expect.fail
                                        ("Expected to generate 3 files but found "
                                            ++ (List.length modules |> String.fromInt)
                                            ++ ": "
                                            ++ moduleNames modules
                                        )


yamlToJsonValueDecoder : Yaml.Decode.Decoder Json.Encode.Value
yamlToJsonValueDecoder =
    Yaml.Decode.oneOf
        [ Yaml.Decode.map Json.Encode.float Yaml.Decode.float
        , Yaml.Decode.map (\_ -> Json.Encode.null) Yaml.Decode.null
        , Yaml.Decode.map Json.Encode.string Yaml.Decode.string
        , Yaml.Decode.map Json.Encode.bool Yaml.Decode.bool
        , Yaml.Decode.map
            (Json.Encode.list identity)
            (Yaml.Decode.list (Yaml.Decode.lazy (\_ -> yamlToJsonValueDecoder)))
        , Yaml.Decode.map
            (\dict -> Json.Encode.object (Dict.toList dict))
            (Yaml.Decode.dict (Yaml.Decode.lazy (\_ -> yamlToJsonValueDecoder)))
        ]


fileToString : { moduleName : List String, declarations : FastDict.Dict String { group : String, declaration : Elm.Declaration } } -> String
fileToString file =
    file.declarations
        |> FastDict.toList
        |> Dict.Extra.groupBy (\( _, { group } ) -> group)
        |> Dict.toList
        |> List.map
            (\( group, decls ) ->
                Elm.group
                    (Elm.comment ("## " ++ group) :: List.map (\( _, { declaration } ) -> declaration) decls)
            )
        |> Elm.file file.moduleName
        |> .contents


expectEqualMultiline : String -> String -> Expect.Expectation
expectEqualMultiline exp actual =
    if exp == actual then
        Expect.pass

    else
        let
            header : String
            header =
                Ansi.Color.fontColor Ansi.Color.blue "Diff from expected to actual:"
        in
        Expect.fail
            (header
                ++ "\n"
                ++ (Diff.diffLinesWith
                        (Diff.defaultOptions
                            |> Diff.ignoreLeadingWhitespace
                        )
                        exp
                        actual
                        |> Diff.ToString.diffToString { context = 4, color = True }
                   )
            )
