module JsonSchema.Generate exposing (schemaToDeclarations)

import CliMonad exposing (CliMonad)
import Common
import Elm
import Elm.Annotation
import Elm.ToString
import Gen.Json.Decode
import Gen.Json.Encode
import Json.Schema.Definitions
import SchemaUtils


schemaToDeclarations : List String -> String -> Json.Schema.Definitions.Schema -> CliMonad (List ( Common.Module, Elm.Declaration ))
schemaToDeclarations namespace name schema =
    schemaToAnnotation False namespace schema
        |> CliMonad.andThen
            (\ann ->
                let
                    typeName : Common.TypeName
                    typeName =
                        Common.typifyName name
                in
                if (Elm.ToString.annotation ann).signature == typeName then
                    CliMonad.succeed []

                else
                    [ ( Common.Types
                      , Elm.alias typeName ann
                            |> Elm.exposeWith
                                { exposeConstructor = False
                                , group = Nothing
                                }
                      )
                        |> CliMonad.succeed
                    , CliMonad.map
                        (\schemaDecoder ->
                            ( Common.Json
                            , Elm.declaration
                                ("decode" ++ typeName)
                                (schemaDecoder
                                    |> Elm.withType (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.named (namespace ++ [ Common.moduleToString Common.Types ]) typeName))
                                )
                                |> Elm.exposeWith
                                    { exposeConstructor = False
                                    , group = Just "Decoders"
                                    }
                            )
                        )
                        (schemaToDecoder False namespace schema)
                    , CliMonad.map
                        (\encoder ->
                            ( Common.Json
                            , Elm.declaration ("encode" ++ typeName)
                                (Elm.functionReduced "rec" encoder
                                    |> Elm.withType (Elm.Annotation.function [ Elm.Annotation.named (namespace ++ [ Common.moduleToString Common.Types ]) typeName ] Gen.Json.Encode.annotation_.value)
                                )
                                |> Elm.exposeWith
                                    { exposeConstructor = False
                                    , group = Just "Encoders"
                                    }
                            )
                        )
                        (schemaToEncoder False namespace schema)
                    ]
                        |> CliMonad.combine
            )
        |> CliMonad.withPath name


schemaToAnnotation : Bool -> List String -> Json.Schema.Definitions.Schema -> CliMonad Elm.Annotation.Annotation
schemaToAnnotation qualify namespace schema =
    SchemaUtils.schemaToType qualify namespace schema
        |> CliMonad.andThen (SchemaUtils.typeToAnnotation qualify namespace)


schemaToDecoder : Bool -> List String -> Json.Schema.Definitions.Schema -> CliMonad Elm.Expression
schemaToDecoder qualify namespace schema =
    SchemaUtils.schemaToType True namespace schema
        |> CliMonad.andThen (SchemaUtils.typeToDecoder qualify namespace)


schemaToEncoder : Bool -> List String -> Json.Schema.Definitions.Schema -> CliMonad (Elm.Expression -> Elm.Expression)
schemaToEncoder qualify namespace schema =
    SchemaUtils.schemaToType True namespace schema
        |> CliMonad.andThen (SchemaUtils.typeToEncoder qualify namespace)
