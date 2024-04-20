module SchemaUtils exposing
    ( getAlias
    , schemaToAnnotation
    , schemaToType
    )

import CliMonad exposing (CliMonad, NamespaceScope)
import Common exposing (Field, Type(..), TypeName, typifyName)
import Dict
import Elm.Annotation
import Elm.ToString
import FastDict exposing (Dict)
import Json.Schema.Definitions
import Maybe.Extra
import OpenApi
import OpenApi.Components
import OpenApi.Schema
import Set exposing (Set)


getSchema : String -> CliMonad Json.Schema.Definitions.Schema
getSchema refName =
    CliMonad.fromApiSpec identity
        |> CliMonad.stepOrFail ("Could not find components in the schema, while looking up" ++ refName)
            OpenApi.components
        |> CliMonad.stepOrFail ("Could not find component's schema, while looking up" ++ refName)
            (\components -> Dict.get refName (OpenApi.Components.schemas components))
        |> CliMonad.map OpenApi.Schema.get


getAlias : List String -> CliMonad Json.Schema.Definitions.Schema
getAlias refUri =
    case refUri of
        [ "#", "components", _, name ] ->
            getSchema name

        _ ->
            CliMonad.fail <| "Couldn't get the type ref (" ++ String.join "/" refUri ++ ") for the response"


schemaToProperties : NamespaceScope -> Json.Schema.Definitions.Schema -> CliMonad (Dict String Field)
schemaToProperties namespace allOfItem =
    case allOfItem of
        Json.Schema.Definitions.ObjectSchema allOfItemSchema ->
            CliMonad.map2 FastDict.union
                (subSchemaToProperties namespace allOfItemSchema)
                (subSchemaRefToProperties namespace allOfItemSchema)

        Json.Schema.Definitions.BooleanSchema _ ->
            CliMonad.todoWithDefault FastDict.empty "Boolean schema inside allOf"


subSchemaRefToProperties : NamespaceScope -> Json.Schema.Definitions.SubSchema -> CliMonad (Dict String Field)
subSchemaRefToProperties namespace allOfItem =
    case allOfItem.ref of
        Nothing ->
            CliMonad.succeed FastDict.empty

        Just ref ->
            getAlias (String.split "/" ref)
                |> CliMonad.withPath ref
                |> CliMonad.andThen (schemaToProperties namespace)


subSchemaToProperties : NamespaceScope -> Json.Schema.Definitions.SubSchema -> CliMonad (Dict String Field)
subSchemaToProperties namespace sch =
    -- TODO: rename
    let
        requiredSet : Set String
        requiredSet =
            sch.required
                |> Maybe.withDefault []
                |> Set.fromList
    in
    sch.properties
        |> Maybe.map (\(Json.Schema.Definitions.Schemata schemata) -> schemata)
        |> Maybe.withDefault []
        |> CliMonad.combineMap
            (\( key, valueSchema ) ->
                schemaToType namespace valueSchema
                    |> CliMonad.withPath key
                    |> CliMonad.map
                        (\type_ ->
                            ( key
                            , { type_ = type_
                              , required = Set.member key requiredSet
                              }
                            )
                        )
            )
        |> CliMonad.map FastDict.fromList


schemaToType : NamespaceScope -> Json.Schema.Definitions.Schema -> CliMonad Type
schemaToType namespace schema =
    case schema of
        Json.Schema.Definitions.BooleanSchema _ ->
            CliMonad.todoWithDefault Value "Boolean schema"

        Json.Schema.Definitions.ObjectSchema subSchema ->
            let
                nullable : CliMonad Type -> CliMonad Type
                nullable =
                    CliMonad.map Nullable

                singleTypeToType : Json.Schema.Definitions.SingleType -> CliMonad Type
                singleTypeToType singleType =
                    case singleType of
                        Json.Schema.Definitions.ObjectType ->
                            objectSchemaToType namespace subSchema

                        Json.Schema.Definitions.StringType ->
                            CliMonad.succeed String

                        Json.Schema.Definitions.IntegerType ->
                            CliMonad.succeed Int

                        Json.Schema.Definitions.NumberType ->
                            CliMonad.succeed Float

                        Json.Schema.Definitions.BooleanType ->
                            CliMonad.succeed Bool

                        Json.Schema.Definitions.NullType ->
                            CliMonad.todoWithDefault Value "Null type annotation"

                        Json.Schema.Definitions.ArrayType ->
                            case subSchema.items of
                                Json.Schema.Definitions.NoItems ->
                                    CliMonad.fail "Found an array type but no items definition"

                                Json.Schema.Definitions.ArrayOfItems _ ->
                                    CliMonad.todoWithDefault Value "Array of items as item definition"

                                Json.Schema.Definitions.ItemDefinition itemSchema ->
                                    CliMonad.map List (schemaToType namespace itemSchema)

                anyOfToType : List Json.Schema.Definitions.Schema -> CliMonad Type
                anyOfToType _ =
                    CliMonad.succeed Value

                oneOfToType : List Json.Schema.Definitions.Schema -> CliMonad Type
                oneOfToType oneOf =
                    CliMonad.combineMap (schemaToType namespace) oneOf
                        |> CliMonad.andThen (oneOfType namespace)
            in
            case subSchema.type_ of
                Json.Schema.Definitions.SingleType singleType ->
                    singleTypeToType singleType

                Json.Schema.Definitions.AnyType ->
                    case subSchema.ref of
                        Just ref ->
                            CliMonad.succeed <| Common.ref ref

                        Nothing ->
                            case subSchema.anyOf of
                                Just [ onlySchema ] ->
                                    schemaToType namespace onlySchema

                                Just [ firstSchema, secondSchema ] ->
                                    case ( firstSchema, secondSchema ) of
                                        ( Json.Schema.Definitions.ObjectSchema firstSubSchema, Json.Schema.Definitions.ObjectSchema secondSubSchema ) ->
                                            -- The first 2 cases here are for pseudo-nullable schemas where the higher level schema type is AnyOf
                                            -- but it's actually made up of only 2 types and 1 of them is nullable. This acts as a hack of sorts to
                                            -- mark a value as nullable in the schema.
                                            case ( firstSubSchema.type_, secondSubSchema.type_ ) of
                                                ( Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType, _ ) ->
                                                    nullable (schemaToType namespace secondSchema)

                                                ( _, Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType ) ->
                                                    nullable (schemaToType namespace firstSchema)

                                                _ ->
                                                    anyOfToType [ firstSchema, secondSchema ]

                                        _ ->
                                            anyOfToType [ firstSchema, secondSchema ]

                                Just anyOf ->
                                    anyOfToType anyOf

                                Nothing ->
                                    case subSchema.allOf of
                                        Just [ onlySchema ] ->
                                            schemaToType namespace onlySchema

                                        Just [] ->
                                            CliMonad.succeed Value

                                        Just _ ->
                                            -- If we have more than one item in `allOf`, then it's _probably_ an object
                                            -- TODO: improve this to actually check if all the `allOf` subschema are objects.
                                            objectSchemaToType namespace subSchema

                                        Nothing ->
                                            case subSchema.oneOf of
                                                Just [ onlySchema ] ->
                                                    schemaToType namespace onlySchema

                                                Just [] ->
                                                    CliMonad.succeed Value

                                                Just oneOfs ->
                                                    oneOfToType oneOfs

                                                Nothing ->
                                                    CliMonad.succeed Value

                Json.Schema.Definitions.NullableType singleType ->
                    nullable (singleTypeToType singleType)

                Json.Schema.Definitions.UnionType singleTypes ->
                    let
                        ( nulls, nonNulls ) =
                            List.partition
                                (\st -> st == Json.Schema.Definitions.NullType)
                                singleTypes
                    in
                    nonNulls
                        |> CliMonad.combineMap singleTypeToType
                        |> CliMonad.andThen (oneOfType namespace)
                        |> CliMonad.map
                            (\res ->
                                if List.isEmpty nulls then
                                    res

                                else
                                    Nullable res
                            )


typeToOneOfVariant : NamespaceScope -> Type -> CliMonad (Maybe { name : TypeName, type_ : Type })
typeToOneOfVariant namespace type_ =
    type_
        |> CliMonad.typeToAnnotation namespace
        |> CliMonad.map
            (\ann ->
                let
                    rawName : TypeName
                    rawName =
                        ann
                            |> Elm.ToString.annotation
                            |> .signature
                            |> typifyName
                in
                if String.contains "{" rawName then
                    Nothing

                else
                    Just
                        { name =
                            rawName
                                |> String.split "."
                                |> List.reverse
                                |> List.head
                                |> Maybe.withDefault rawName
                        , type_ = type_
                        }
            )


oneOfType : NamespaceScope -> List Type -> CliMonad Type
oneOfType namespace types =
    types
        |> CliMonad.combineMap (typeToOneOfVariant namespace)
        |> CliMonad.map
            (\maybeVariants ->
                case Maybe.Extra.combine maybeVariants of
                    Nothing ->
                        Value

                    Just variants ->
                        let
                            sortedVariants : List { name : TypeName, type_ : Type }
                            sortedVariants =
                                variants
                                    |> List.sortBy .name

                            names : List String
                            names =
                                sortedVariants
                                    |> List.map .name
                        in
                        OneOf (String.join "_Or_" names) sortedVariants
            )


objectSchemaToType : NamespaceScope -> Json.Schema.Definitions.SubSchema -> CliMonad Type
objectSchemaToType namespace subSchema =
    let
        propertiesFromAllOf : CliMonad (Dict String Field)
        propertiesFromAllOf =
            subSchema.allOf
                |> Maybe.withDefault []
                |> CliMonad.combineMap (schemaToProperties namespace)
                |> CliMonad.map (List.foldl FastDict.union FastDict.empty)
    in
    CliMonad.map2
        (\schemaProps allOfProps ->
            allOfProps
                |> FastDict.union schemaProps
                |> Object
        )
        (subSchemaToProperties namespace subSchema)
        propertiesFromAllOf


schemaToAnnotation : NamespaceScope -> Json.Schema.Definitions.Schema -> CliMonad Elm.Annotation.Annotation
schemaToAnnotation namespace schema =
    schema
        |> schemaToType namespace
        |> CliMonad.andThen (CliMonad.typeToAnnotation namespace)
