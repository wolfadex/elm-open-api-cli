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


schemaToDeclarations : String -> Json.Schema.Definitions.Schema -> CliMonad (List ( Common.Module, Elm.Declaration ))
schemaToDeclarations name schema =
    SchemaUtils.schemaToType False schema
        |> CliMonad.andThen
            (\{ type_, documentation } ->
                case type_ of
                    Common.Enum _ ->
                        CliMonad.succeed []

                    _ ->
                        type_
                            |> SchemaUtils.typeToAnnotation False
                            |> CliMonad.andThen
                                (\annotation ->
                                    let
                                        typeName : Common.TypeName
                                        typeName =
                                            Common.typifyName name
                                    in
                                    if (Elm.ToString.annotation annotation).signature == typeName then
                                        CliMonad.succeed []

                                    else
                                        [ ( Common.Types
                                          , Elm.alias typeName annotation
                                                |> (case documentation of
                                                        Nothing ->
                                                            identity

                                                        Just doc ->
                                                            Elm.withDocumentation doc
                                                   )
                                                |> Elm.exposeWith
                                                    { exposeConstructor = False
                                                    , group = Just "Aliases"
                                                    }
                                          )
                                            |> CliMonad.succeed
                                        , CliMonad.map2
                                            (\namespace schemaDecoder ->
                                                ( Common.Json
                                                , Elm.declaration
                                                    ("decode" ++ typeName)
                                                    (schemaDecoder
                                                        |> Elm.withType (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.named (Common.moduleToNamespace namespace Common.Types) typeName))
                                                    )
                                                    |> Elm.exposeWith
                                                        { exposeConstructor = False
                                                        , group = Just "Decoders"
                                                        }
                                                )
                                            )
                                            CliMonad.namespace
                                            (schemaToDecoder False schema)
                                        , CliMonad.map2
                                            (\namespace encoder ->
                                                ( Common.Json
                                                , Elm.declaration ("encode" ++ typeName)
                                                    (Elm.functionReduced "rec" encoder
                                                        |> Elm.withType (Elm.Annotation.function [ Elm.Annotation.named (Common.moduleToNamespace namespace Common.Types) typeName ] Gen.Json.Encode.annotation_.value)
                                                    )
                                                    |> Elm.exposeWith
                                                        { exposeConstructor = False
                                                        , group = Just "Encoders"
                                                        }
                                                )
                                            )
                                            CliMonad.namespace
                                            (schemaToEncoder False schema)
                                        ]
                                            |> CliMonad.combine
                                )
            )
        |> CliMonad.withPath name


schemaToDecoder : Bool -> Json.Schema.Definitions.Schema -> CliMonad Elm.Expression
schemaToDecoder qualify schema =
    SchemaUtils.schemaToType True schema
        |> CliMonad.andThen (\{ type_ } -> SchemaUtils.typeToDecoder qualify type_)


schemaToEncoder : Bool -> Json.Schema.Definitions.Schema -> CliMonad (Elm.Expression -> Elm.Expression)
schemaToEncoder qualify schema =
    SchemaUtils.schemaToType True schema
        |> CliMonad.andThen (\{ type_ } -> SchemaUtils.typeToEncoder qualify type_)
