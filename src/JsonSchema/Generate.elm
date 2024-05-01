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


schemaToDeclarations : List String -> String -> Json.Schema.Definitions.Schema -> CliMonad (List Elm.Declaration)
schemaToDeclarations namespace name schema =
    schemaToAnnotation namespace schema
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
                    [ Elm.alias typeName ann
                        |> Elm.exposeWith
                            { exposeConstructor = False
                            , group = Just "Types"
                            }
                        |> CliMonad.succeed
                    , CliMonad.map
                        (\schemaDecoder ->
                            Elm.declaration ("decode" ++ typeName)
                                (schemaDecoder
                                    |> Elm.withType (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.named [] typeName))
                                )
                                |> Elm.exposeWith
                                    { exposeConstructor = False
                                    , group = Just "Decoders"
                                    }
                        )
                        (schemaToDecoder namespace schema)
                    , CliMonad.map
                        (\encoder ->
                            Elm.declaration ("encode" ++ typeName)
                                (Elm.functionReduced "rec" encoder
                                    |> Elm.withType (Elm.Annotation.function [ Elm.Annotation.named [] typeName ] Gen.Json.Encode.annotation_.value)
                                )
                                |> Elm.exposeWith
                                    { exposeConstructor = False
                                    , group = Just "Encoders"
                                    }
                        )
                        (schemaToEncoder namespace schema)
                    ]
                        |> CliMonad.combine
            )
        |> CliMonad.withPath name


schemaToAnnotation : List String -> Json.Schema.Definitions.Schema -> CliMonad Elm.Annotation.Annotation
schemaToAnnotation namespace schema =
    SchemaUtils.schemaToType namespace schema |> CliMonad.andThen (CliMonad.typeToAnnotation namespace)


schemaToDecoder : List String -> Json.Schema.Definitions.Schema -> CliMonad Elm.Expression
schemaToDecoder namespace schema =
    SchemaUtils.schemaToType namespace schema
        |> CliMonad.andThen (CliMonad.typeToDecoder namespace)


schemaToEncoder : List String -> Json.Schema.Definitions.Schema -> CliMonad (Elm.Expression -> Elm.Expression)
schemaToEncoder namespace schema =
    SchemaUtils.schemaToType namespace schema |> CliMonad.andThen (CliMonad.typeToEncoder namespace)
