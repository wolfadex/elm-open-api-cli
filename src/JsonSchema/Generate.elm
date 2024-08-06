module JsonSchema.Generate exposing (schemaToDeclarations)

import CliMonad exposing (CliMonad)
import Common
import Elm
import Elm.Annotation
import Elm.Case
import Elm.Op
import Elm.ToString
import Gen.Json.Decode
import Gen.Json.Encode
import Gen.Maybe
import Json.Schema.Definitions
import SchemaUtils


schemaToDeclarations : Common.UnsafeName -> Json.Schema.Definitions.Schema -> CliMonad (List ( Common.Module, Elm.Declaration ))
schemaToDeclarations name schema =
    SchemaUtils.schemaToType False schema
        |> CliMonad.andThen
            (\{ type_, documentation } ->
                let
                    typeName : Common.TypeName
                    typeName =
                        Common.toTypeName name
                in
                case type_ of
                    Common.Enum enumVariants ->
                        [ ( Common.Types
                          , enumVariants
                                |> List.map (\variantName -> Elm.variant (SchemaUtils.toVariantName typeName variantName))
                                |> Elm.customType typeName
                                |> (case documentation of
                                        Nothing ->
                                            identity

                                        Just doc ->
                                            Elm.withDocumentation doc
                                   )
                                |> Elm.exposeWith
                                    { exposeConstructor = True
                                    , group = Just "Enum"
                                    }
                          )
                            |> CliMonad.succeed
                        , ( Common.Types
                          , Elm.fn ( "value", Just (Elm.Annotation.named [] typeName) )
                                (\value ->
                                    enumVariants
                                        |> List.map
                                            (\variant ->
                                                Elm.Case.branch0
                                                    (SchemaUtils.toVariantName typeName variant)
                                                    (Elm.string (Common.unwrapUnsafe variant))
                                            )
                                        |> Elm.Case.custom value (Elm.Annotation.named [] typeName)
                                )
                                |> Elm.declaration (Common.toValueName name ++ "ToString")
                                |> Elm.exposeWith
                                    { exposeConstructor = False
                                    , group = Just "Enum"
                                    }
                          )
                            |> CliMonad.succeed
                        , ( Common.Types
                          , Elm.fn ( "value", Just Elm.Annotation.string )
                                (\value ->
                                    Elm.Case.string value
                                        { cases =
                                            enumVariants
                                                |> List.map
                                                    (\variant ->
                                                        ( Common.unwrapUnsafe variant
                                                        , Gen.Maybe.make_.just
                                                            (Elm.value
                                                                { name = SchemaUtils.toVariantName typeName variant
                                                                , importFrom = []
                                                                , annotation = Just (Elm.Annotation.named [] typeName)
                                                                }
                                                            )
                                                        )
                                                    )
                                        , otherwise = Gen.Maybe.make_.nothing
                                        }
                                )
                                |> Elm.declaration (Common.toValueName name ++ "FromString")
                                |> Elm.exposeWith
                                    { exposeConstructor = False
                                    , group = Just "Enum"
                                    }
                          )
                            |> CliMonad.succeed
                        , ( Common.Types
                          , enumVariants
                                |> List.map
                                    (\variant ->
                                        Elm.value
                                            { name = SchemaUtils.toVariantName typeName variant
                                            , importFrom = []
                                            , annotation = Just (Elm.Annotation.named [] typeName)
                                            }
                                    )
                                |> Elm.list
                                |> Elm.declaration (Common.toValueName name ++ "Variants")
                                |> Elm.exposeWith
                                    { exposeConstructor = False
                                    , group = Just "Enum"
                                    }
                          )
                            |> CliMonad.succeed
                        , CliMonad.map
                            (\typesNamespace ->
                                ( Common.Json
                                , Elm.declaration
                                    ("decode" ++ typeName)
                                    (Gen.Json.Decode.string
                                        |> Gen.Json.Decode.andThen
                                            (\str ->
                                                Gen.Maybe.caseOf_.maybe
                                                    (Elm.apply
                                                        (Elm.value
                                                            { importFrom = typesNamespace
                                                            , name = Common.toValueName name ++ "FromString"
                                                            , annotation = Nothing
                                                            }
                                                        )
                                                        [ str ]
                                                    )
                                                    { just = Gen.Json.Decode.succeed
                                                    , nothing =
                                                        Gen.Json.Decode.call_.fail
                                                            (Elm.Op.append
                                                                str
                                                                (Elm.string (" is not a valid " ++ typeName))
                                                            )
                                                    }
                                            )
                                        |> Elm.withType (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.named typesNamespace typeName))
                                    )
                                    |> Elm.exposeWith
                                        { exposeConstructor = False
                                        , group = Just "Decoders"
                                        }
                                )
                            )
                            (CliMonad.moduleToNamespace Common.Types)
                        , CliMonad.map
                            (\typesNamespace ->
                                ( Common.Json
                                , Elm.declaration ("encode" ++ typeName)
                                    (Elm.functionReduced "rec"
                                        (\value ->
                                            Elm.apply
                                                (Elm.value
                                                    { importFrom = typesNamespace
                                                    , name = Common.toValueName name ++ "ToString"
                                                    , annotation = Nothing
                                                    }
                                                )
                                                [ value ]
                                                |> Gen.Json.Encode.call_.string
                                        )
                                        |> Elm.withType (Elm.Annotation.function [ Elm.Annotation.named typesNamespace typeName ] Gen.Json.Encode.annotation_.value)
                                    )
                                    |> Elm.exposeWith
                                        { exposeConstructor = False
                                        , group = Just "Encoders"
                                        }
                                )
                            )
                            (CliMonad.moduleToNamespace Common.Types)
                        ]
                            |> CliMonad.combine

                    _ ->
                        type_
                            |> SchemaUtils.typeToAnnotation False
                            |> CliMonad.andThen
                                (\annotation ->
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
                                            (\typesNamespace schemaDecoder ->
                                                ( Common.Json
                                                , Elm.declaration
                                                    ("decode" ++ typeName)
                                                    (schemaDecoder
                                                        |> Elm.withType (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.named typesNamespace typeName))
                                                    )
                                                    |> Elm.exposeWith
                                                        { exposeConstructor = False
                                                        , group = Just "Decoders"
                                                        }
                                                )
                                            )
                                            (CliMonad.moduleToNamespace Common.Types)
                                            (schemaToDecoder False schema)
                                        , CliMonad.map2
                                            (\typesNamespace encoder ->
                                                ( Common.Json
                                                , Elm.declaration ("encode" ++ typeName)
                                                    (Elm.functionReduced "rec" encoder
                                                        |> Elm.withType (Elm.Annotation.function [ Elm.Annotation.named typesNamespace typeName ] Gen.Json.Encode.annotation_.value)
                                                    )
                                                    |> Elm.exposeWith
                                                        { exposeConstructor = False
                                                        , group = Just "Encoders"
                                                        }
                                                )
                                            )
                                            (CliMonad.moduleToNamespace Common.Types)
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
