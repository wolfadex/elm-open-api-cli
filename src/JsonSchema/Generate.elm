module JsonSchema.Generate exposing (schemaToDeclarations)

import CliMonad exposing (CliMonad)
import Common
import Elm
import Elm.Annotation
import Elm.Arg
import Elm.Case
import Elm.Op
import Elm.ToString
import Gen.Json.Decode
import Gen.Json.Encode
import Gen.Maybe
import Json.Schema.Definitions
import NonEmpty
import SchemaUtils


schemaToDeclarations : Common.UnsafeName -> Json.Schema.Definitions.Schema -> CliMonad (List CliMonad.Declaration)
schemaToDeclarations name schema =
    SchemaUtils.schemaToType [] schema
        |> CliMonad.andThen
            (\{ type_, documentation } ->
                let
                    typeName : Common.TypeName
                    typeName =
                        Common.toTypeName name
                in
                case type_ of
                    Common.Enum enumVariants ->
                        [ { moduleName = Common.Types
                          , name = typeName
                          , declaration =
                                enumVariants
                                    |> NonEmpty.toList
                                    |> List.map (\variantName -> Elm.variant (SchemaUtils.toVariantName typeName variantName))
                                    |> Elm.customType typeName
                                    |> (case documentation of
                                            Nothing ->
                                                identity

                                            Just doc ->
                                                Elm.withDocumentation doc
                                       )
                                    |> Elm.exposeConstructor
                          , group = "Enum"
                          }
                            |> CliMonad.succeed
                        , { moduleName = Common.Types
                          , name = Common.toValueName name ++ "ToString"
                          , declaration =
                                Elm.fn (Elm.Arg.var "value")
                                    (\value ->
                                        enumVariants
                                            |> NonEmpty.toList
                                            |> List.map
                                                (\variant ->
                                                    Elm.Case.branch
                                                        (Elm.Arg.customType (SchemaUtils.toVariantName typeName variant)
                                                            (Elm.string (Common.unwrapUnsafe variant))
                                                        )
                                                        identity
                                                )
                                            |> Elm.Case.custom value (Elm.Annotation.named [] typeName)
                                    )
                                    |> Elm.withType (Elm.Annotation.function [ Elm.Annotation.named [] typeName ] Elm.Annotation.string)
                                    |> Elm.declaration (Common.toValueName name ++ "ToString")
                                    |> Elm.expose
                          , group = "Enum"
                          }
                            |> CliMonad.succeed
                        , { moduleName = Common.Types
                          , name = Common.toValueName name ++ "FromString"
                          , declaration =
                                Elm.fn (Elm.Arg.varWith "value" Elm.Annotation.string)
                                    (\value ->
                                        Elm.Case.string value
                                            { cases =
                                                enumVariants
                                                    |> NonEmpty.toList
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
                                    |> Elm.withType (Elm.Annotation.function [ Elm.Annotation.string ] (Elm.Annotation.maybe (Elm.Annotation.named [] typeName)))
                                    |> Elm.declaration (Common.toValueName name ++ "FromString")
                                    |> Elm.expose
                          , group = "Enum"
                          }
                            |> CliMonad.succeed
                        , { moduleName = Common.Types
                          , name = Common.toValueName name ++ "Variants"
                          , declaration =
                                enumVariants
                                    |> NonEmpty.toList
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
                                    |> Elm.expose
                          , group = "Enum"
                          }
                            |> CliMonad.succeed
                        , CliMonad.map
                            (\importFrom ->
                                { moduleName = Common.Json
                                , name = "decode" ++ typeName
                                , declaration =
                                    Elm.declaration
                                        ("decode" ++ typeName)
                                        (Gen.Json.Decode.string
                                            |> Gen.Json.Decode.andThen
                                                (\str ->
                                                    Gen.Maybe.caseOf_.maybe
                                                        (Elm.apply
                                                            (Elm.value
                                                                { importFrom = importFrom
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
                                            |> Elm.withType (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.named importFrom typeName))
                                        )
                                        |> Elm.expose
                                , group = "Decoders"
                                }
                            )
                            (CliMonad.moduleToNamespace Common.Types)
                        , CliMonad.map
                            (\importFrom ->
                                { moduleName = Common.Json
                                , name = "encode" ++ typeName
                                , declaration =
                                    Elm.declaration ("encode" ++ typeName)
                                        (Elm.functionReduced "rec"
                                            (\value ->
                                                Elm.apply
                                                    (Elm.value
                                                        { importFrom = importFrom
                                                        , name = Common.toValueName name ++ "ToString"
                                                        , annotation = Nothing
                                                        }
                                                    )
                                                    [ value ]
                                                    |> Gen.Json.Encode.call_.string
                                            )
                                            |> Elm.withType (Elm.Annotation.function [ Elm.Annotation.named importFrom typeName ] Gen.Json.Encode.annotation_.value)
                                        )
                                        |> Elm.expose
                                , group = "Encoders"
                                }
                            )
                            (CliMonad.moduleToNamespace Common.Types)
                        ]
                            |> CliMonad.combine

                    _ ->
                        type_
                            |> SchemaUtils.typeToAnnotationWithNullable
                            |> CliMonad.andThen
                                (\annotation ->
                                    if (Elm.ToString.annotation annotation).signature == typeName then
                                        CliMonad.succeed []

                                    else
                                        [ { moduleName = Common.Types
                                          , name = typeName
                                          , declaration =
                                                Elm.alias typeName annotation
                                                    |> (case documentation of
                                                            Nothing ->
                                                                identity

                                                            Just doc ->
                                                                Elm.withDocumentation doc
                                                       )
                                                    |> Elm.expose
                                          , group = "Aliases"
                                          }
                                            |> CliMonad.succeed
                                        , CliMonad.map2
                                            (\importFrom schemaDecoder ->
                                                { moduleName = Common.Json
                                                , name = "decode" ++ typeName
                                                , declaration =
                                                    Elm.declaration
                                                        ("decode" ++ typeName)
                                                        (schemaDecoder
                                                            |> Elm.withType (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.named importFrom typeName))
                                                        )
                                                        |> Elm.expose
                                                , group = "Decoders"
                                                }
                                            )
                                            (CliMonad.moduleToNamespace Common.Types)
                                            (schemaToDecoder schema)
                                        , CliMonad.map2
                                            (\importFrom encoder ->
                                                { moduleName = Common.Json
                                                , name = "encode" ++ typeName
                                                , declaration =
                                                    Elm.declaration ("encode" ++ typeName)
                                                        (Elm.functionReduced "rec" encoder
                                                            |> Elm.withType (Elm.Annotation.function [ Elm.Annotation.named importFrom typeName ] Gen.Json.Encode.annotation_.value)
                                                        )
                                                        |> Elm.expose
                                                , group = "Encoders"
                                                }
                                            )
                                            (CliMonad.moduleToNamespace Common.Types)
                                            (schemaToEncoder schema)
                                        ]
                                            |> CliMonad.combine
                                )
            )
        |> CliMonad.withPath name


schemaToDecoder : Json.Schema.Definitions.Schema -> CliMonad Elm.Expression
schemaToDecoder schema =
    SchemaUtils.schemaToType [] schema
        |> CliMonad.andThen (\{ type_ } -> SchemaUtils.typeToDecoder type_)


schemaToEncoder : Json.Schema.Definitions.Schema -> CliMonad (Elm.Expression -> Elm.Expression)
schemaToEncoder schema =
    SchemaUtils.schemaToType [] schema
        |> CliMonad.andThen (\{ type_ } -> SchemaUtils.typeToEncoder type_)
