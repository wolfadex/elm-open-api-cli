module SchemaUtils exposing
    ( OneOfName
    , getAlias
    , oneOfDeclarations
    , recordType
    , refToTypeName
    , schemaToType
    , subschemaToEnumMaybe
    , toVariantName
    , typeToAnnotationWithMaybe
    , typeToAnnotationWithNullable
    , typeToDecoder
    , typeToEncoder
    )

import CliMonad exposing (CliMonad)
import Common
import Dict
import Elm
import Elm.Annotation
import Elm.Arg
import Elm.Case
import Elm.Let
import Elm.Op
import Elm.Op.Extra
import Elm.ToString
import FastDict
import Gen.Basics
import Gen.Bytes
import Gen.Dict
import Gen.Json.Decode
import Gen.Json.Encode
import Gen.List
import Gen.Maybe
import Gen.Result
import Gen.String
import Json.Decode
import Json.Encode
import Json.Schema.Definitions
import List.Extra
import Maybe.Extra
import Murmur3
import NonEmpty exposing (NonEmpty)
import OpenApi
import OpenApi.Common.Internal
import OpenApi.Components
import OpenApi.Schema
import Result.Extra
import Set exposing (Set)


getSchema : CliMonad.Input -> String -> CliMonad Json.Schema.Definitions.Schema
getSchema input refName =
    CliMonad.getApiSpec input
        |> CliMonad.succeed
        |> CliMonad.stepOrFail ("Could not find components in the schema, while looking up " ++ refName)
            OpenApi.components
        |> CliMonad.stepOrFail ("Could not find component's schema, while looking up " ++ refName)
            (\components -> Dict.get refName (OpenApi.Components.schemas components))
        |> CliMonad.map OpenApi.Schema.get


getAlias : CliMonad.Input -> List String -> CliMonad Json.Schema.Definitions.Schema
getAlias input refUri =
    case refUri of
        [ "#", "components", _, refName ] ->
            getSchema input refName

        _ ->
            CliMonad.fail <| "Couldn't get the type ref (" ++ String.join "/" refUri ++ ") for the response"


subSchemaAllOfToProperties : CliMonad.Input -> Bool -> List (List String) -> Json.Schema.Definitions.SubSchema -> CliMonad (List ( Common.UnsafeName, Common.Field ))
subSchemaAllOfToProperties input qualify seen subSchema =
    subSchema.allOf
        |> Maybe.withDefault []
        |> CliMonad.combineMap (schemaToProperties input qualify seen)
        |> CliMonad.map (List.foldl listUnion [])
        |> CliMonad.withPath (Common.UnsafeName "allOf")


schemaToProperties : CliMonad.Input -> Bool -> List (List String) -> Json.Schema.Definitions.Schema -> CliMonad (List ( Common.UnsafeName, Common.Field ))
schemaToProperties input qualify seen allOfItem =
    case allOfItem of
        Json.Schema.Definitions.ObjectSchema allOfItemSchema ->
            CliMonad.map3
                (\a b c ->
                    listUnion a b
                        |> listUnion c
                )
                (subSchemaToProperties input qualify seen allOfItemSchema)
                (subSchemaRefToProperties input qualify seen allOfItemSchema)
                (subSchemaAllOfToProperties input qualify seen allOfItemSchema)

        Json.Schema.Definitions.BooleanSchema _ ->
            CliMonad.todoWithDefault input [] "Boolean schema inside allOf"


listUnion : List ( Common.UnsafeName, a ) -> List ( Common.UnsafeName, a ) -> List ( Common.UnsafeName, a )
listUnion l r =
    let
        toDict : List ( Common.UnsafeName, b ) -> FastDict.Dict String b
        toDict v =
            FastDict.fromList (List.map (Tuple.mapFirst Common.unwrapUnsafe) v)
    in
    FastDict.union (toDict l) (toDict r)
        |> FastDict.toList
        |> List.map (Tuple.mapFirst Common.UnsafeName)


subSchemaRefToProperties : CliMonad.Input -> Bool -> List (List String) -> Json.Schema.Definitions.SubSchema -> CliMonad (List ( Common.UnsafeName, Common.Field ))
subSchemaRefToProperties input qualify seen allOfItem =
    case allOfItem.ref of
        Nothing ->
            CliMonad.succeed []

        Just ref ->
            getAlias input (String.split "/" ref)
                |> CliMonad.andThen (schemaToProperties input qualify seen)
                |> CliMonad.withPath (Common.UnsafeName ref)


subSchemaToProperties : CliMonad.Input -> Bool -> List (List String) -> Json.Schema.Definitions.SubSchema -> CliMonad (List ( Common.UnsafeName, Common.Field ))
subSchemaToProperties input qualify seen sch =
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
                schemaToType input qualify seen valueSchema
                    |> CliMonad.map
                        (\{ type_, documentation } ->
                            ( Common.UnsafeName key
                            , { type_ = type_
                              , required = Set.member key requiredSet
                              , documentation = documentation
                              }
                            )
                        )
                    |> CliMonad.withPath (Common.UnsafeName key)
            )


schemaToType : CliMonad.Input -> Bool -> List (List String) -> Json.Schema.Definitions.Schema -> CliMonad { type_ : Common.Type, documentation : Maybe String }
schemaToType input qualify seen schema =
    case schema of
        Json.Schema.Definitions.BooleanSchema _ ->
            CliMonad.todoWithDefault input { type_ = Common.Value, documentation = Nothing } "Boolean schema"

        Json.Schema.Definitions.ObjectSchema subSchema ->
            let
                nullable : CliMonad { type_ : Common.Type, documentation : Maybe String } -> CliMonad { type_ : Common.Type, documentation : Maybe String }
                nullable =
                    CliMonad.map
                        (\({ type_, documentation } as t) ->
                            case type_ of
                                Common.Nullable _ ->
                                    t

                                _ ->
                                    { type_ = Common.Nullable type_
                                    , documentation = documentation
                                    }
                        )

                singleTypeToType : Json.Schema.Definitions.SingleType -> CliMonad { type_ : Common.Type, documentation : Maybe String }
                singleTypeToType singleType =
                    let
                        basic : Common.BasicType -> (a -> Common.ConstValue) -> Json.Decode.Decoder a -> CliMonad { type_ : Common.Type, documentation : Maybe String }
                        basic basicType toConst decoder =
                            let
                                build : Maybe a -> CliMonad { type_ : Common.Type, documentation : Maybe String }
                                build const =
                                    { type_ =
                                        Common.Basic basicType
                                            { const = Maybe.map toConst const
                                            , format = subSchema.format
                                            }
                                    , documentation = subSchema.description
                                    }
                                        |> CliMonad.succeed
                            in
                            case subSchema.const of
                                Nothing ->
                                    build Nothing

                                Just const ->
                                    case Json.Decode.decodeValue decoder const of
                                        Ok value ->
                                            build (Just value)

                                        Err _ ->
                                            CliMonad.fail ("Invalid const value: " ++ Json.Encode.encode 0 const)
                    in
                    case singleType of
                        Json.Schema.Definitions.ObjectType ->
                            objectSchemaToType input qualify seen subSchema

                        Json.Schema.Definitions.StringType ->
                            basic Common.String Common.ConstString Json.Decode.string

                        Json.Schema.Definitions.IntegerType ->
                            basic Common.Integer Common.ConstInteger Json.Decode.int

                        Json.Schema.Definitions.NumberType ->
                            basic Common.Number Common.ConstNumber Json.Decode.float

                        Json.Schema.Definitions.BooleanType ->
                            basic Common.Boolean Common.ConstBoolean Json.Decode.bool

                        Json.Schema.Definitions.NullType ->
                            CliMonad.succeed { type_ = Common.Null, documentation = subSchema.description }

                        Json.Schema.Definitions.ArrayType ->
                            case subSchema.items of
                                Json.Schema.Definitions.NoItems ->
                                    CliMonad.fail "Found an array type but no items definition"

                                Json.Schema.Definitions.ArrayOfItems _ ->
                                    CliMonad.todoWithDefault input { type_ = Common.Value, documentation = subSchema.description } "Array of items as item definition"

                                Json.Schema.Definitions.ItemDefinition itemSchema ->
                                    CliMonad.map
                                        (\{ type_, documentation } ->
                                            { type_ = Common.List type_
                                            , documentation =
                                                [ subSchema.description
                                                , Maybe.map
                                                    (\doc ->
                                                        if String.contains "\n" doc then
                                                            "A list of:\n" ++ doc

                                                        else
                                                            "A list of: " ++ doc
                                                    )
                                                    documentation
                                                ]
                                                    |> joinIfNotEmpty "\n\n"
                                            }
                                        )
                                        (schemaToType input qualify seen itemSchema)

                anyOfToType : List Json.Schema.Definitions.Schema -> CliMonad { type_ : Common.Type, documentation : Maybe String }
                anyOfToType schemas =
                    schemaIntersection input qualify seen schemas
                        |> CliMonad.andThen
                            (\disjoint ->
                                case disjoint of
                                    Nothing ->
                                        oneOfToType schemas

                                    Just collision ->
                                        case areAllArrays schemas of
                                            Just innerSchemas ->
                                                oneOfToType innerSchemas
                                                    |> CliMonad.map
                                                        (\t ->
                                                            { type_ = Common.List t.type_
                                                            , documentation = t.documentation
                                                            }
                                                        )

                                            Nothing ->
                                                CliMonad.succeed
                                                    { type_ = Common.Value
                                                    , documentation = subSchema.description
                                                    }
                                                    |> CliMonad.withExtendedWarning
                                                        { message = "anyOf between overlapping types is not supported"
                                                        , details =
                                                            [ "Clash between"
                                                            , "  - " ++ collision.leftSchema
                                                            , "  - " ++ collision.rightSchema
                                                            , "Possible clashing value:"
                                                            ]
                                                                ++ (Json.Encode.encode 2 collision.value
                                                                        |> String.lines
                                                                        |> List.map (\line -> "  " ++ line)
                                                                   )
                                                        }
                            )

                oneOfCombine : List Json.Schema.Definitions.Schema -> CliMonad { type_ : Common.Type, documentation : Maybe String }
                oneOfCombine oneOf =
                    oneOf
                        |> CliMonad.combineMap (schemaToType input qualify seen)
                        |> CliMonad.andThen (oneOfType input)
                        |> CliMonad.map
                            (\{ type_, documentation } ->
                                { type_ = type_
                                , documentation =
                                    [ subSchema.description
                                    , documentation
                                    ]
                                        |> joinIfNotEmpty "\n\n"
                                }
                            )
                        |> CliMonad.withPath (Common.UnsafeName "oneOf")

                oneOfToType : List Json.Schema.Definitions.Schema -> CliMonad { type_ : Common.Type, documentation : Maybe String }
                oneOfToType oneOf =
                    case oneOf of
                        -- handle the oneOf syntax for nullable values
                        -- "oneOf": [
                        --   { "type": "null" },
                        --   { "$ref": "#/components/schemas/Foo" }
                        -- ]
                        [ (Json.Schema.Definitions.ObjectSchema firstSchema) as first, (Json.Schema.Definitions.ObjectSchema secondSchema) as second ] ->
                            case ( firstSchema.type_, secondSchema.type_ ) of
                                ( Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType, _ ) ->
                                    schemaToType input qualify seen second
                                        |> nullable

                                ( _, Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType ) ->
                                    schemaToType input qualify seen first
                                        |> nullable

                                _ ->
                                    oneOfCombine oneOf

                        _ ->
                            oneOfCombine oneOf
            in
            case subSchema.type_ of
                Json.Schema.Definitions.SingleType Json.Schema.Definitions.StringType ->
                    case subschemaToEnumMaybe subSchema of
                        Ok Nothing ->
                            singleTypeToType Json.Schema.Definitions.StringType

                        Ok (Just { decodedEnums, hasNull }) ->
                            CliMonad.succeed
                                { type_ = Common.enum decodedEnums
                                , documentation = subSchema.description
                                }
                                |> (if hasNull then
                                        nullable

                                    else
                                        identity
                                   )

                        Err e ->
                            CliMonad.fail e

                Json.Schema.Definitions.SingleType singleType ->
                    singleTypeToType singleType

                Json.Schema.Definitions.AnyType ->
                    case subSchema.ref of
                        Just ref ->
                            CliMonad.succeed { type_ = Common.ref ref, documentation = subSchema.description }

                        Nothing ->
                            case subSchema.anyOf of
                                Just [ onlySchema ] ->
                                    schemaToType input qualify seen onlySchema

                                Just [ firstSchema, secondSchema ] ->
                                    case ( firstSchema, secondSchema ) of
                                        ( Json.Schema.Definitions.ObjectSchema firstSubSchema, Json.Schema.Definitions.ObjectSchema secondSubSchema ) ->
                                            -- The first 2 cases here are for pseudo-nullable schemas where the higher level schema type is AnyOf
                                            -- but it's actually made up of only 2 types and 1 of them is nullable. This acts as a hack of sorts to
                                            -- mark a value as nullable in the schema.
                                            case ( firstSubSchema.type_, secondSubSchema.type_ ) of
                                                ( Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType, _ ) ->
                                                    nullable (schemaToType input qualify seen secondSchema)

                                                ( _, Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType ) ->
                                                    nullable (schemaToType input qualify seen firstSchema)

                                                _ ->
                                                    anyOfToType [ firstSchema, secondSchema ]

                                        _ ->
                                            anyOfToType [ firstSchema, secondSchema ]

                                Just anyOf ->
                                    anyOfToType anyOf

                                Nothing ->
                                    case subSchema.allOf of
                                        Just [ onlySchema ] ->
                                            schemaToType input qualify seen onlySchema

                                        Just [] ->
                                            CliMonad.succeed { type_ = Common.Value, documentation = subSchema.description }

                                        Just _ ->
                                            -- If we have more than one item in `allOf`, then it's _probably_ an object
                                            -- TODO: improve this to actually check if all the `allOf` subschema are objects.
                                            objectSchemaToType input qualify seen subSchema

                                        Nothing ->
                                            case subSchema.oneOf of
                                                Just [ onlySchema ] ->
                                                    schemaToType input qualify seen onlySchema

                                                Just [] ->
                                                    CliMonad.succeed { type_ = Common.Value, documentation = subSchema.description }

                                                Just oneOfs ->
                                                    oneOfToType oneOfs

                                                Nothing ->
                                                    case subschemaToEnumMaybe subSchema of
                                                        Ok Nothing ->
                                                            CliMonad.succeed { type_ = Common.Value, documentation = subSchema.description }

                                                        Ok (Just { decodedEnums, hasNull }) ->
                                                            CliMonad.succeed
                                                                { type_ = Common.enum decodedEnums
                                                                , documentation = subSchema.description
                                                                }
                                                                |> (if hasNull then
                                                                        nullable

                                                                    else
                                                                        identity
                                                                   )

                                                        Err e ->
                                                            CliMonad.fail e

                Json.Schema.Definitions.NullableType Json.Schema.Definitions.StringType ->
                    case subschemaToEnumMaybe subSchema of
                        Ok Nothing ->
                            nullable (singleTypeToType Json.Schema.Definitions.StringType)

                        Ok (Just { decodedEnums }) ->
                            CliMonad.succeed
                                { type_ = Common.enum decodedEnums
                                , documentation = subSchema.description
                                }
                                |> nullable

                        Err e ->
                            CliMonad.fail e

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
                        |> CliMonad.andThen (oneOfType input)
                        |> CliMonad.map
                            (\{ type_, documentation } ->
                                { type_ =
                                    if List.isEmpty nulls then
                                        type_

                                    else
                                        Common.Nullable type_
                                , documentation = documentation
                                }
                            )


areAllArrays : List Json.Schema.Definitions.Schema -> Maybe (List Json.Schema.Definitions.Schema)
areAllArrays schemas =
    schemas
        |> Maybe.Extra.combineMap
            (\schema ->
                case schema of
                    Json.Schema.Definitions.BooleanSchema _ ->
                        Nothing

                    Json.Schema.Definitions.ObjectSchema o ->
                        case o.type_ of
                            Json.Schema.Definitions.SingleType Json.Schema.Definitions.ArrayType ->
                                case o.items of
                                    Json.Schema.Definitions.NoItems ->
                                        Nothing

                                    Json.Schema.Definitions.ItemDefinition s ->
                                        Just [ s ]

                                    Json.Schema.Definitions.ArrayOfItems ss ->
                                        Just ss

                            _ ->
                                Nothing
            )
        |> Maybe.map List.concat


type alias SchemaIntersection =
    { leftSchema : String
    , value : Json.Encode.Value
    , rightSchema : String
    }


schemaIntersection : CliMonad.Input -> Bool -> List (List String) -> List Json.Schema.Definitions.Schema -> CliMonad (Maybe SchemaIntersection)
schemaIntersection input qualify seen schemas =
    let
        areDisjoint : Json.Schema.Definitions.Schema -> Json.Schema.Definitions.Schema -> CliMonad (Maybe SchemaIntersection)
        areDisjoint l r =
            case ( l, r ) of
                ( Json.Schema.Definitions.BooleanSchema lb, Json.Schema.Definitions.BooleanSchema rb ) ->
                    if lb == rb then
                        { leftSchema = "bool"
                        , value = Json.Encode.bool lb
                        , rightSchema = "bool"
                        }
                            |> Just
                            |> CliMonad.succeed
                            |> CliMonad.withWarning "anyOf between two booleans with the same value"

                    else
                        CliMonad.succeed Nothing

                ( Json.Schema.Definitions.BooleanSchema _, Json.Schema.Definitions.ObjectSchema _ ) ->
                    CliMonad.succeed Nothing

                ( Json.Schema.Definitions.ObjectSchema _, Json.Schema.Definitions.BooleanSchema _ ) ->
                    CliMonad.succeed Nothing

                ( Json.Schema.Definitions.ObjectSchema lo, Json.Schema.Definitions.ObjectSchema ro ) ->
                    CliMonad.andThen2
                        (\lt rt ->
                            typesIntersection input qualify seen lt.type_ rt.type_
                        )
                        (schemaToType input qualify seen l)
                        (schemaToType input qualify seen r)
                        |> CliMonad.map
                            (Maybe.map
                                (\res ->
                                    { leftSchema = describeSubSchema lo
                                    , value = res
                                    , rightSchema = describeSubSchema ro
                                    }
                                )
                            )

        go :
            Json.Schema.Definitions.Schema
            -> List Json.Schema.Definitions.Schema
            -> CliMonad (Maybe SchemaIntersection)
        go item queue =
            queue
                |> CliMonad.combineMap (\other -> areDisjoint item other)
                |> CliMonad.andThen
                    (\r ->
                        case Maybe.Extra.values r of
                            h :: _ ->
                                CliMonad.succeed (Just h)

                            [] ->
                                case queue of
                                    [] ->
                                        CliMonad.succeed Nothing

                                    h :: t ->
                                        go h t
                    )
    in
    case schemas of
        [] ->
            CliMonad.succeed Nothing

        h :: t ->
            go h t


describeSubSchema : Json.Schema.Definitions.SubSchema -> String
describeSubSchema subSchema =
    case subSchema.ref of
        Nothing ->
            subSchema.source
                |> Json.Decode.decodeValue removeDocumentation
                |> Result.withDefault subSchema.source
                |> Json.Encode.encode 0

        Just ref ->
            ref


removeDocumentation : Json.Decode.Decoder Json.Decode.Value
removeDocumentation =
    Json.Decode.lazy
        (\_ ->
            Json.Decode.oneOf
                [ Json.Decode.dict removeDocumentation
                    |> Json.Decode.map
                        (\dict ->
                            dict
                                |> Dict.remove "description"
                                |> Dict.toList
                                |> Json.Encode.object
                        )
                , Json.Decode.list removeDocumentation
                    |> Json.Decode.map (Json.Encode.list identity)
                , Json.Decode.value -- everything else can pass through
                ]
        )


exampleOfType : CliMonad.Input -> Bool -> List (List String) -> Common.Type -> CliMonad Json.Encode.Value
exampleOfType input qualify seen type_ =
    case type_ of
        Common.Nullable _ ->
            CliMonad.succeed Json.Encode.null

        Common.Object fields ->
            fields
                |> CliMonad.combineMap
                    (\( fieldName, field ) ->
                        if field.required then
                            exampleOfType input qualify seen field.type_
                                |> CliMonad.map
                                    (\example ->
                                        Just ( Common.unwrapUnsafe fieldName, example )
                                    )
                                |> CliMonad.withPath fieldName

                        else
                            CliMonad.succeed Nothing
                    )
                |> CliMonad.map
                    (\exampleFields ->
                        exampleFields
                            |> Maybe.Extra.values
                            |> Json.Encode.object
                    )

        Common.Basic t { const, format } ->
            case ( const, t ) of
                ( Just (Common.ConstBoolean b), _ ) ->
                    Json.Encode.bool b
                        |> CliMonad.succeed

                ( Just (Common.ConstInteger i), _ ) ->
                    Json.Encode.int i
                        |> CliMonad.succeed

                ( Just (Common.ConstString s), _ ) ->
                    Json.Encode.string s
                        |> CliMonad.succeed

                ( Just (Common.ConstNumber f), _ ) ->
                    Json.Encode.float f
                        |> CliMonad.succeed

                ( Nothing, Common.Integer ) ->
                    Json.Encode.int 0
                        |> CliMonad.succeed

                ( Nothing, Common.Boolean ) ->
                    Json.Encode.bool True
                        |> CliMonad.succeed

                ( Nothing, Common.Number ) ->
                    Json.Encode.int 0
                        |> CliMonad.succeed

                ( Nothing, Common.String ) ->
                    exampleString input format

        Common.Null ->
            CliMonad.succeed Json.Encode.null

        Common.List _ ->
            CliMonad.succeed (Json.Encode.list never [])

        Common.Dict _ fields ->
            fields
                |> CliMonad.combineMap
                    (\( fieldName, field ) ->
                        if field.required then
                            exampleOfType input qualify seen field.type_
                                |> CliMonad.map
                                    (\example ->
                                        Just ( Common.unwrapUnsafe fieldName, example )
                                    )
                                |> CliMonad.withPath fieldName

                        else
                            CliMonad.succeed Nothing
                    )
                |> CliMonad.map
                    (\exampleFields ->
                        exampleFields
                            |> Maybe.Extra.values
                            |> Json.Encode.object
                    )

        Common.OneOf _ ( t, _ ) ->
            exampleOfType input qualify seen t.type_

        Common.Enum ( t, _ ) ->
            Json.Encode.string (Common.unwrapUnsafe t)
                |> CliMonad.succeed

        Common.Value ->
            Json.Encode.null
                |> CliMonad.succeed

        Common.Ref ref ->
            if List.Extra.count ((==) ref) seen > 2 then
                Json.Encode.string "<<recursive>>"
                    |> CliMonad.succeed

            else
                let
                    newSeen : List (List String)
                    newSeen =
                        ref :: seen
                in
                ref
                    |> getAlias input
                    |> CliMonad.andThen (schemaToType input qualify newSeen)
                    |> CliMonad.andThen (\t -> exampleOfType input qualify newSeen t.type_)
                    |> CliMonad.withPath (Common.UnsafeName (String.join "/" ref))

        Common.Bytes ->
            Json.Encode.string "<bytes>"
                |> CliMonad.succeed

        Common.Unit ->
            Json.Encode.string "<empty>"
                |> CliMonad.succeed


exampleString : CliMonad.Input -> Maybe String -> CliMonad Json.Encode.Value
exampleString input format =
    CliMonad.withFormat input Common.String format .example (Json.Encode.string "")


type SimplifiedForDisjointBasicType
    = SimplifiedForDisjointNumber (Maybe Float)
    | SimplifiedForDisjointString (Maybe String)
    | SimplifiedForDisjointBool (Maybe Bool)


typesIntersection : CliMonad.Input -> Bool -> List (List String) -> Common.Type -> Common.Type -> CliMonad (Maybe Json.Encode.Value)
typesIntersection input qualify seen lType rType =
    let
        followLeftRef : List String -> CliMonad (Maybe Json.Encode.Value)
        followLeftRef lRef =
            if List.Extra.count ((==) lRef) seen > 2 then
                CliMonad.fail ("Recursive type: " ++ String.join "/" lRef)

            else
                let
                    newSeen : List (List String)
                    newSeen =
                        lRef :: seen
                in
                getAlias input lRef
                    |> CliMonad.andThen (schemaToType input qualify newSeen)
                    |> CliMonad.andThen (\{ type_ } -> typesIntersection input qualify newSeen type_ rType)
                    |> CliMonad.withPath (Common.UnsafeName (String.join "/" lRef))
    in
    case ( lType, rType ) of
        ( Common.Ref lRef, Common.Ref rRef ) ->
            if lRef == rRef then
                exampleOfType input qualify seen lType
                    |> CliMonad.map Just

            else
                followLeftRef lRef

        ( Common.Ref lRef, _ ) ->
            followLeftRef lRef

        ( _, Common.Ref rRef ) ->
            if List.Extra.count ((==) rRef) seen > 2 then
                CliMonad.fail ("Recursive type: " ++ String.join "/" rRef)

            else
                let
                    newSeen : List (List String)
                    newSeen =
                        rRef :: seen
                in
                getAlias input rRef
                    |> CliMonad.andThen (schemaToType input qualify newSeen)
                    |> CliMonad.andThen (\{ type_ } -> typesIntersection input qualify newSeen lType type_)
                    |> CliMonad.withPath (Common.UnsafeName (String.join "/" rRef))

        ( Common.Value, _ ) ->
            CliMonad.map Just (exampleOfType input qualify seen rType)

        ( _, Common.Value ) ->
            CliMonad.map Just (exampleOfType input qualify seen lType)

        ( Common.Nullable _, Common.Nullable _ ) ->
            CliMonad.succeed (Just Json.Encode.null)

        ( Common.Null, Common.Nullable _ ) ->
            CliMonad.succeed (Just Json.Encode.null)

        ( Common.Nullable _, Common.Null ) ->
            CliMonad.succeed (Just Json.Encode.null)

        ( Common.Nullable c, Common.Basic _ _ ) ->
            typesIntersection input qualify seen c rType

        ( Common.Basic _ _, Common.Nullable c ) ->
            typesIntersection input qualify seen lType c

        ( Common.Nullable c, Common.Object _ ) ->
            typesIntersection input qualify seen c rType

        ( Common.Object _, Common.Nullable c ) ->
            typesIntersection input qualify seen lType c

        ( Common.Null, Common.Null ) ->
            CliMonad.succeed (Just Json.Encode.null)

        ( Common.Null, Common.List _ ) ->
            CliMonad.succeed Nothing

        ( Common.List _, Common.Null ) ->
            CliMonad.succeed Nothing

        ( Common.OneOf _ alternatives, _ ) ->
            alternatives
                |> nonEmptyToList
                |> CliMonad.combineMap
                    (\alternative ->
                        typesIntersection input qualify seen alternative.type_ rType
                            |> CliMonad.withPath alternative.name
                    )
                |> CliMonad.map (List.Extra.findMap identity)

        ( _, Common.OneOf _ alternatives ) ->
            alternatives
                |> nonEmptyToList
                |> CliMonad.combineMap
                    (\alternative ->
                        typesIntersection input qualify seen lType alternative.type_
                            |> CliMonad.withPath alternative.name
                    )
                |> CliMonad.map (List.Extra.findMap identity)

        ( Common.List _, Common.List _ ) ->
            -- Empty lists are not possible to distinguish
            CliMonad.succeed (Just (Json.Encode.list never []))

        ( Common.Basic lbasic lopt, Common.Basic rbasic ropt ) ->
            case
                ( simplifyForDisjoint lbasic lopt.const
                , simplifyForDisjoint rbasic ropt.const
                )
            of
                ( Err warning, _ ) ->
                    CliMonad.fail warning

                ( _, Err warning ) ->
                    CliMonad.fail warning

                ( Ok (SimplifiedForDisjointBool lconst), Ok (SimplifiedForDisjointBool rconst) ) ->
                    CliMonad.succeed
                        (if lconst == rconst then
                            Just (Json.Encode.bool (Maybe.withDefault True lconst))

                         else
                            Nothing
                        )

                ( Ok (SimplifiedForDisjointNumber lconst), Ok (SimplifiedForDisjointNumber rconst) ) ->
                    CliMonad.succeed
                        (if lconst == rconst then
                            Just (Json.Encode.float (Maybe.withDefault 0 lconst))

                         else
                            Nothing
                        )

                ( Ok (SimplifiedForDisjointString lconst), Ok (SimplifiedForDisjointString rconst) ) ->
                    case ( lconst, rconst ) of
                        ( Just lstr, Just rstr ) ->
                            if lstr == rstr then
                                CliMonad.succeed (Just (Json.Encode.string lstr))

                            else
                                CliMonad.succeed Nothing

                        _ ->
                            case ( lopt.format, ropt.format ) of
                                ( Just lFormat, Just rFormat ) ->
                                    if lFormat /= rFormat then
                                        stringFormatsIntersection lFormat rFormat

                                    else
                                        CliMonad.map Just (exampleString input (Just lFormat))

                                _ ->
                                    lopt.format
                                        |> Maybe.Extra.orElse ropt.format
                                        |> exampleString input
                                        |> CliMonad.map Just

                _ ->
                    CliMonad.succeed Nothing

        ( Common.Object lFields, Common.Object rFields ) ->
            objectsIntersection input qualify seen ( lFields, Nothing ) ( rFields, Nothing )

        ( Common.Dict lAdditional lFields, Common.Dict rAdditional rFields ) ->
            objectsIntersection input qualify seen ( lFields, Just lAdditional.type_ ) ( rFields, Just rAdditional.type_ )

        ( Common.Enum lItems, Common.Enum rItems ) ->
            let
                lSet : Set String
                lSet =
                    lItems
                        |> nonEmptyToList
                        |> List.map Common.unwrapUnsafe
                        |> Set.fromList

                rSet : Set String
                rSet =
                    rItems
                        |> nonEmptyToList
                        |> List.map Common.unwrapUnsafe
                        |> Set.fromList
            in
            Set.intersect lSet rSet
                |> Set.toList
                |> List.head
                |> Maybe.map Json.Encode.string
                |> CliMonad.succeed

        ( Common.Enum lItems, Common.Basic Common.String rOptions ) ->
            stringAndEnumIntersection rOptions lItems

        ( Common.Basic Common.String lOptions, Common.Enum rItems ) ->
            stringAndEnumIntersection lOptions rItems

        ( Common.Enum _, Common.Object _ ) ->
            CliMonad.succeed Nothing

        ( Common.Object _, Common.Enum _ ) ->
            CliMonad.succeed Nothing

        ( Common.Basic _ _, Common.Object _ ) ->
            CliMonad.succeed Nothing

        ( Common.Object _, Common.Basic _ _ ) ->
            CliMonad.succeed Nothing

        _ ->
            CliMonad.succeed Nothing
                |> CliMonad.withWarning ("Disjoint check not implemented for types " ++ typeToString lType ++ " and " ++ typeToString rType)


objectsIntersection :
    CliMonad.Input
    -> Bool
    -> List (List String)
    -> ( Common.Object, Maybe Common.Type )
    -> ( Common.Object, Maybe Common.Type )
    -> CliMonad (Maybe Json.Encode.Value)
objectsIntersection input qualify seen ( lFields, lAdditional ) ( rFields, rAdditional ) =
    let
        lDict : FastDict.Dict String Common.Field
        lDict =
            lFields
                |> List.map (\( k, v ) -> ( Common.unwrapUnsafe k, v ))
                |> FastDict.fromList

        rDict : FastDict.Dict String Common.Field
        rDict =
            rFields
                |> List.map (\( k, v ) -> ( Common.unwrapUnsafe k, v ))
                |> FastDict.fromList
    in
    FastDict.merge
        (\lkey lField acc ->
            if lField.required then
                if rAdditional == Just lField.type_ then
                    CliMonad.map2
                        (\example ->
                            Maybe.map
                                (\prev ->
                                    ( lkey, example ) :: prev
                                )
                        )
                        (exampleOfType input qualify seen lField.type_
                            |> CliMonad.withPath (Common.UnsafeName lkey)
                        )
                        acc

                else
                    CliMonad.succeed Nothing

            else
                acc
        )
        (\bkey lField rField acc ->
            if not lField.required && not rField.required then
                acc

            else
                CliMonad.map2
                    (Maybe.map2
                        (\bValue iAcc ->
                            ( bkey, bValue ) :: iAcc
                        )
                    )
                    (typesIntersection input qualify seen lField.type_ rField.type_
                        |> CliMonad.withPath (Common.UnsafeName bkey)
                    )
                    acc
        )
        (\rkey rField acc ->
            if rField.required then
                if lAdditional == Just rField.type_ then
                    CliMonad.map2
                        (\example ->
                            Maybe.map
                                (\prev ->
                                    ( rkey, example ) :: prev
                                )
                        )
                        (exampleOfType input qualify seen rField.type_
                            |> CliMonad.withPath (Common.UnsafeName rkey)
                        )
                        acc

                else
                    CliMonad.succeed Nothing

            else
                acc
        )
        lDict
        rDict
        (CliMonad.succeed (Just []))
        |> CliMonad.map (Maybe.map Json.Encode.object)


stringAndEnumIntersection :
    { format : Maybe String, const : Maybe Common.ConstValue }
    -> NonEmpty Common.UnsafeName
    -> CliMonad (Maybe Json.Encode.Value)
stringAndEnumIntersection rOptions lItems =
    case rOptions.const of
        Just (Common.ConstString rConst) ->
            if List.member (Common.UnsafeName rConst) (nonEmptyToList lItems) then
                CliMonad.succeed (Just (Json.Encode.string rConst))

            else
                CliMonad.succeed Nothing

        Just _ ->
            CliMonad.fail "Wrong constant type"

        Nothing ->
            case rOptions.format of
                Nothing ->
                    lItems
                        |> Tuple.first
                        |> Common.unwrapUnsafe
                        |> Json.Encode.string
                        |> Just
                        |> CliMonad.succeed

                Just rFormat ->
                    CliMonad.succeed Nothing
                        |> CliMonad.withWarning ("Disjoint check not implemented for types enum and string:" ++ rFormat)


stringFormatsIntersection : String -> String -> CliMonad (Maybe Json.Encode.Value)
stringFormatsIntersection lFormat rFormat =
    -- TODO: check for disjoint formats
    CliMonad.succeed Nothing
        |> CliMonad.withWarning ("Disjoint check not implemented for string:" ++ lFormat ++ " and string:" ++ rFormat)


nonEmptyToList : ( a, List a ) -> List a
nonEmptyToList ( h, t ) =
    h :: t


typeToString : Common.Type -> String
typeToString type_ =
    case type_ of
        Common.Null ->
            "null"

        Common.Nullable _ ->
            "nullable"

        Common.Object _ ->
            "object"

        Common.Basic _ _ ->
            "basic"

        Common.List _ ->
            "list"

        Common.Dict _ _ ->
            "dict"

        Common.OneOf _ _ ->
            "oneOf"

        Common.Enum _ ->
            "enum"

        Common.Value ->
            "value"

        Common.Ref _ ->
            "ref"

        Common.Bytes ->
            "bytes"

        Common.Unit ->
            "unit"


simplifyForDisjoint : Common.BasicType -> Maybe Common.ConstValue -> Result String SimplifiedForDisjointBasicType
simplifyForDisjoint basic const =
    case ( basic, const ) of
        ( Common.Boolean, Nothing ) ->
            Ok (SimplifiedForDisjointBool Nothing)

        ( Common.Boolean, Just (Common.ConstBoolean b) ) ->
            Ok (SimplifiedForDisjointBool (Just b))

        ( Common.Boolean, Just _ ) ->
            Err "Invalid const for boolean type"

        ( Common.String, Nothing ) ->
            Ok (SimplifiedForDisjointString Nothing)

        ( Common.String, Just (Common.ConstString b) ) ->
            Ok (SimplifiedForDisjointString (Just b))

        ( Common.String, Just _ ) ->
            Err "Invalid const for string type"

        ( Common.Integer, Nothing ) ->
            Ok (SimplifiedForDisjointNumber Nothing)

        ( Common.Integer, Just (Common.ConstInteger i) ) ->
            Ok (SimplifiedForDisjointNumber (Just (toFloat i)))

        ( Common.Integer, Just _ ) ->
            Err "Invalid const for integer type"

        ( Common.Number, Nothing ) ->
            Ok (SimplifiedForDisjointNumber Nothing)

        ( Common.Number, Just (Common.ConstInteger i) ) ->
            Ok (SimplifiedForDisjointNumber (Just (toFloat i)))

        ( Common.Number, Just (Common.ConstNumber f) ) ->
            Ok (SimplifiedForDisjointNumber (Just f))

        ( Common.Number, Just _ ) ->
            Err "Invalid const for number type"


subschemaToEnumMaybe :
    Json.Schema.Definitions.SubSchema
    ->
        Result
            String
            (Maybe
                { decodedEnums : NonEmpty String
                , hasNull : Bool
                }
            )
subschemaToEnumMaybe subSchema =
    case subSchema.enum of
        Nothing ->
            Ok Nothing

        Just enums ->
            case Result.Extra.combineMap (Json.Decode.decodeValue (Json.Decode.nullable Json.Decode.string)) enums of
                Err _ ->
                    Err "Attempted to parse an enum as a string and failed"

                Ok decodedEnums ->
                    case Maybe.Extra.values decodedEnums |> NonEmpty.fromList of
                        Nothing ->
                            Err "Found an enum with no non-null values"

                        Just variants ->
                            { decodedEnums = variants
                            , hasNull = List.member Nothing decodedEnums
                            }
                                |> Just
                                |> Ok


typeToOneOfVariant :
    CliMonad.Input
    -> Bool
    -> { type_ : Common.Type, documentation : Maybe String }
    -> CliMonad (Maybe { name : Common.UnsafeName, type_ : Common.Type, documentation : Maybe String })
typeToOneOfVariant input qualify { type_, documentation } =
    type_
        |> typeToAnnotationWithNullable input qualify
        |> CliMonad.map
            (\ann ->
                let
                    rawName : String
                    rawName =
                        ann
                            |> Elm.ToString.annotation
                            |> .signature
                in
                if String.contains "{" rawName then
                    Nothing

                else
                    Just
                        { name = Common.UnsafeName rawName
                        , type_ = type_
                        , documentation = documentation
                        }
            )


oneOfType :
    CliMonad.Input
    -> List { type_ : Common.Type, documentation : Maybe String }
    -> CliMonad { type_ : Common.Type, documentation : Maybe String }
oneOfType input types =
    types
        |> CliMonad.combineMap (typeToOneOfVariant input False)
        |> CliMonad.map
            (\maybeVariants ->
                case Maybe.Extra.combine maybeVariants |> Maybe.andThen NonEmpty.fromList of
                    Nothing ->
                        { type_ = Common.Value, documentation = Nothing }

                    Just variants ->
                        let
                            sortedVariants :
                                ( { name : Common.UnsafeName
                                  , type_ : Common.Type
                                  , documentation : Maybe String
                                  }
                                , List
                                    { name : Common.UnsafeName
                                    , type_ : Common.Type
                                    , documentation : Maybe String
                                    }
                                )
                            sortedVariants =
                                NonEmpty.sortBy (\{ name } -> Common.unwrapUnsafe name) variants

                            names : List Common.UnsafeName
                            names =
                                List.map .name (NonEmpty.toList sortedVariants)

                            readableName : String
                            readableName =
                                names
                                    |> List.map fixOneOfName
                                    |> String.join "_Or_"
                        in
                        { type_ =
                            Common.OneOf
                                (if String.length readableName > 200 then
                                    "OneOf" ++ String.fromInt (Murmur3.hashString 1234 readableName)

                                 else
                                    readableName
                                )
                                sortedVariants
                        , documentation =
                            sortedVariants
                                |> NonEmpty.toList
                                |> List.map (\{ name, documentation } -> Maybe.map (\doc -> " - " ++ Common.toValueName name ++ ": " ++ doc) documentation)
                                |> joinIfNotEmpty "\n\n"
                                |> Maybe.map (\doc -> "This is a oneOf. The alternatives are:\n\n" ++ doc)
                        }
            )


{-| Transform an object schema's named and inherited (via $ref) properties to a type
-}
objectSchemaToTypeHelp : CliMonad.Input -> Bool -> List (List String) -> Json.Schema.Definitions.SubSchema -> CliMonad { type_ : Common.Type, documentation : Maybe String }
objectSchemaToTypeHelp input qualify seen subSchema =
    CliMonad.map2
        (\schemaProps allOfProps ->
            let
                ( props, propsDocumentations ) =
                    listUnion schemaProps allOfProps
                        |> List.map
                            (\( name, field ) ->
                                ( ( name, field )
                                , field.documentation
                                    |> Maybe.map
                                        (\doc ->
                                            " - " ++ Common.toValueName name ++ ": " ++ String.join "\n      " (String.split "\n" doc)
                                        )
                                )
                            )
                        |> List.unzip

                propsDocumentation : Maybe String
                propsDocumentation =
                    propsDocumentations
                        |> joinIfNotEmpty "\n"
            in
            { type_ = Common.Object props
            , documentation =
                case propsDocumentation of
                    Nothing ->
                        subSchema.description

                    Just _ ->
                        [ Just (Maybe.withDefault "Fields:" subSchema.description) -- A nonempty line is needed for formatting
                        , propsDocumentation
                        ]
                            |> joinIfNotEmpty "\n\n"
            }
        )
        (subSchemaToProperties input qualify seen subSchema)
        (subSchemaAllOfToProperties input qualify seen subSchema)


objectSchemaToType : CliMonad.Input -> Bool -> List (List String) -> Json.Schema.Definitions.SubSchema -> CliMonad { type_ : Common.Type, documentation : Maybe String }
objectSchemaToType input qualify seen subSchema =
    let
        declaredProperties : CliMonad { type_ : Common.Type, documentation : Maybe String }
        declaredProperties =
            objectSchemaToTypeHelp input qualify seen subSchema

        declaredAndAdditionalProperties : CliMonad { type_ : Common.Type, documentation : Maybe String } -> CliMonad { type_ : Common.Type, documentation : Maybe String }
        declaredAndAdditionalProperties additionalSchema =
            CliMonad.andThen2
                (\declaredProperties_ additionalProperties ->
                    case declaredProperties_.type_ of
                        Common.Object properties ->
                            { type_ = Common.Dict additionalProperties properties
                            , documentation =
                                [ declaredProperties_.documentation
                                , additionalProperties.documentation
                                    |> Maybe.map
                                        (\doc ->
                                            case String.lines doc of
                                                [] ->
                                                    " - additionalProperties"

                                                first :: [] ->
                                                    " - additionalProperties: " ++ first

                                                first :: rest ->
                                                    " - additionalProperties: "
                                                        ++ first
                                                        ++ "\n\n   Each value in the dict is a record of:    "
                                                        ++ String.join "\n    " rest
                                        )
                                ]
                                    |> joinIfNotEmpty "\n\n"
                            }
                                |> CliMonad.succeed

                        _ ->
                            CliMonad.fail "Internal error: non-Object from objectSchemaToTypeHelp"
                )
                declaredProperties
                additionalSchema
    in
    (case subSchema.patternProperties of
        Just _ ->
            CliMonad.succeed ()
                |> CliMonad.withWarning "patternProperties not implemented yet"

        Nothing ->
            CliMonad.succeed ()
    )
        |> CliMonad.andThen
            (\() ->
                case subSchema.additionalProperties of
                    -- Object contains only specified properties, not arbitrary extra ones.
                    Just (Json.Schema.Definitions.BooleanSchema False) ->
                        declaredProperties

                    -- It's unclear whether "true" is *technically* an acceptable value for
                    -- additionalProperties, but the GitHub API spec uses it. Since the type
                    -- of the properties could be anything, we keep them as Json Values.
                    Just (Json.Schema.Definitions.BooleanSchema True) ->
                        CliMonad.succeed
                            { type_ = Common.Value
                            , documentation = Just "Arbitrary data whose type is not defined by the API spec"
                            }
                            |> declaredAndAdditionalProperties

                    -- The object contains an additionalProperties entry that describes the
                    -- type of the values, which may have arbitrary keys, in the object.
                    Just additionalPropertiesSchema ->
                        schemaToType input qualify seen additionalPropertiesSchema
                            |> declaredAndAdditionalProperties

                    Nothing ->
                        declaredProperties
            )


joinIfNotEmpty : String -> List (Maybe String) -> Maybe String
joinIfNotEmpty sep chunks =
    let
        filtered : List String
        filtered =
            List.filterMap identity chunks
    in
    if List.isEmpty filtered then
        Nothing

    else
        Just (String.join sep filtered)


type alias OneOfName =
    Common.TypeName


oneOfDeclarations :
    CliMonad.Input
    -> FastDict.Dict OneOfName (List Common.OneOfData)
    -> CliMonad (List CliMonad.Declaration)
oneOfDeclarations input enums =
    FastDict.toList enums
        |> CliMonad.combineMap
            (\oneOf ->
                oneOfDeclaration input oneOf
                    |> CliMonad.withPath (Common.UnsafeName (Tuple.first oneOf))
            )


oneOfDeclaration :
    CliMonad.Input
    -> ( OneOfName, List Common.OneOfData )
    -> CliMonad CliMonad.Declaration
oneOfDeclaration input ( oneOfName, variants ) =
    let
        variantDeclaration : { name : Common.UnsafeName, type_ : Common.Type, documentation : Maybe String } -> CliMonad Elm.Variant
        variantDeclaration { name, type_ } =
            typeToAnnotationWithNullable input False type_
                |> CliMonad.map
                    (\variantAnnotation ->
                        let
                            variantName : Common.VariantName
                            variantName =
                                toVariantName oneOfName name
                        in
                        Elm.variantWith variantName [ variantAnnotation ]
                    )
                |> CliMonad.withPath name
    in
    variants
        |> CliMonad.combineMap variantDeclaration
        |> CliMonad.map
            (\decl ->
                { moduleName = Common.Types
                , name = oneOfName
                , group = "One of"
                , declaration =
                    decl
                        |> Elm.customType oneOfName
                        |> Elm.exposeConstructor
                }
            )


toVariantName : Common.TypeName -> Common.UnsafeName -> String
toVariantName oneOfName variantName =
    oneOfName ++ "__" ++ fixOneOfName variantName


{-| When we go from `Elm.Annotation` to `String` it includes the module name if it's an imported type.
We don't want that for our generated types, so we remove it here.
-}
fixOneOfName : Common.UnsafeName -> String
fixOneOfName name =
    name
        |> Common.unwrapUnsafe
        |> String.replace "OpenApi.Nullable" "Nullable"
        |> String.replace "." ""
        |> Common.UnsafeName
        |> Common.toTypeName


{-| Transform an OpenAPI type into an Elm annotation. Nullable values are represented using Nullable.
-}
typeToAnnotationWithNullable : CliMonad.Input -> Bool -> Common.Type -> CliMonad Elm.Annotation.Annotation
typeToAnnotationWithNullable input qualify type_ =
    case type_ of
        Common.Nullable t ->
            CliMonad.map
                OpenApi.Common.Internal.annotation_.nullable
                (typeToAnnotationWithNullable input qualify t)

        Common.Object fields ->
            objectToAnnotation input qualify { useMaybe = False } fields

        Common.Basic basicType basic ->
            basicTypeToAnnotation input basicType basic

        Common.Null ->
            CliMonad.succeed Elm.Annotation.unit

        Common.List t ->
            CliMonad.map Elm.Annotation.list (typeToAnnotationWithNullable input qualify t)

        Common.Dict additionalProperties [] ->
            -- We do not use `Elm.Annotation.dict` here because it will NOT
            -- result in `import Dict` being generated in the module, due to
            -- a bug in elm-codegen.
            CliMonad.map (Gen.Dict.annotation_.dict Elm.Annotation.string)
                (typeToAnnotationWithNullable input qualify additionalProperties.type_)

        Common.Dict additionalProperties fields ->
            let
                additionalPropertiesField :
                    ( Common.UnsafeName
                    , { type_ : Common.Type, required : Bool, documentation : Maybe String }
                    )
                additionalPropertiesField =
                    ( Common.UnsafeName "additionalProperties"
                    , { type_ = Common.Dict additionalProperties []
                      , required = True
                      , documentation = additionalProperties.documentation
                      }
                    )
            in
            (additionalPropertiesField :: fields)
                |> objectToAnnotation input qualify { useMaybe = False }

        Common.Enum variants ->
            CliMonad.enumName input (NonEmpty.toList variants)
                |> CliMonad.map
                    (\maybeName ->
                        case maybeName of
                            Nothing ->
                                Elm.Annotation.string

                            Just name ->
                                nameToAnnotation input qualify name
                    )

        Common.OneOf oneOfName oneOfData ->
            oneOfAnnotation input qualify oneOfName (NonEmpty.toList oneOfData)

        Common.Value ->
            CliMonad.succeed Gen.Json.Encode.annotation_.value

        Common.Ref ref ->
            refToTypeName ref
                |> CliMonad.map
                    (\name ->
                        nameToAnnotation input qualify name
                    )
                |> CliMonad.withPath (Common.UnsafeName (String.join "/" ref))

        Common.Bytes ->
            CliMonad.succeed Gen.Bytes.annotation_.bytes
                |> CliMonad.withRequiredPackage "elm/bytes"

        Common.Unit ->
            CliMonad.succeed Elm.Annotation.unit


{-| Transform an OpenAPI type into an Elm annotation. Nullable values are represented using Maybe.
-}
typeToAnnotationWithMaybe : CliMonad.Input -> Bool -> Common.Type -> CliMonad Elm.Annotation.Annotation
typeToAnnotationWithMaybe input qualify type_ =
    case type_ of
        Common.Nullable t ->
            CliMonad.map Elm.Annotation.maybe (typeToAnnotationWithMaybe input qualify t)

        Common.Object fields ->
            objectToAnnotation input qualify { useMaybe = True } fields

        Common.Basic basicType basic ->
            basicTypeToAnnotation input basicType basic

        Common.Null ->
            CliMonad.succeed Elm.Annotation.unit

        Common.List t ->
            CliMonad.map Elm.Annotation.list (typeToAnnotationWithMaybe input qualify t)

        Common.Dict additionalProperties [] ->
            -- We do not use `Elm.Annotation.dict` here because it will NOT
            -- result in `import Dict` being generated in the module, due to
            -- a bug in elm-codegen.
            CliMonad.map (Gen.Dict.annotation_.dict Elm.Annotation.string)
                (typeToAnnotationWithMaybe input qualify additionalProperties.type_)

        Common.Dict additionalProperties fields ->
            let
                additionalPropertiesField :
                    ( Common.UnsafeName
                    , { type_ : Common.Type, required : Bool, documentation : Maybe String }
                    )
                additionalPropertiesField =
                    ( Common.UnsafeName "additionalProperties"
                    , { type_ = Common.Dict additionalProperties []
                      , required = True
                      , documentation = additionalProperties.documentation
                      }
                    )
            in
            (additionalPropertiesField :: fields)
                |> objectToAnnotation input qualify { useMaybe = True }

        Common.Enum variants ->
            variants
                |> NonEmpty.toList
                |> CliMonad.enumName input
                |> CliMonad.map
                    (\maybeName ->
                        case maybeName of
                            Nothing ->
                                Elm.Annotation.string

                            Just name ->
                                nameToAnnotation input qualify name
                    )

        Common.OneOf oneOfName oneOfData ->
            oneOfAnnotation input qualify oneOfName (NonEmpty.toList oneOfData)

        Common.Value ->
            CliMonad.succeed Gen.Json.Encode.annotation_.value

        Common.Ref ref ->
            refToTypeName ref
                |> CliMonad.map
                    (\name -> nameToAnnotation input qualify name)
                |> CliMonad.withPath (Common.UnsafeName (String.join "/" ref))

        Common.Bytes ->
            CliMonad.succeed Gen.Bytes.annotation_.bytes
                |> CliMonad.withRequiredPackage "elm/bytes"

        Common.Unit ->
            CliMonad.succeed Elm.Annotation.unit


nameToAnnotation : CliMonad.Input -> Bool -> Common.UnsafeName -> Elm.Annotation.Annotation
nameToAnnotation input qualify name =
    Elm.Annotation.named
        (if qualify then
            CliMonad.moduleToNamespace input Common.Types

         else
            []
        )
        (Common.toTypeName name)


basicTypeToAnnotation : CliMonad.Input -> Common.BasicType -> { a | format : Maybe String } -> CliMonad Elm.Annotation.Annotation
basicTypeToAnnotation input basicType { format } =
    let
        default : Elm.Annotation.Annotation
        default =
            case basicType of
                Common.String ->
                    Elm.Annotation.string

                Common.Integer ->
                    Elm.Annotation.int

                Common.Boolean ->
                    Elm.Annotation.bool

                Common.Number ->
                    Elm.Annotation.float
    in
    CliMonad.withFormat input basicType format .annotation default


objectToAnnotation : CliMonad.Input -> Bool -> { useMaybe : Bool } -> Common.Object -> CliMonad Elm.Annotation.Annotation
objectToAnnotation input qualify config fields =
    fields
        |> CliMonad.combineMap
            (\( k, v ) ->
                fieldToAnnotation input qualify config v
                    |> CliMonad.map (Tuple.pair k)
                    |> CliMonad.withPath k
            )
        |> CliMonad.map recordType


recordType : List ( Common.UnsafeName, Elm.Annotation.Annotation ) -> Elm.Annotation.Annotation
recordType fields =
    fields
        |> List.map (Tuple.mapFirst Common.toValueName)
        |> Elm.Annotation.record


fieldToAnnotation : CliMonad.Input -> Bool -> { useMaybe : Bool } -> Common.Field -> CliMonad Elm.Annotation.Annotation
fieldToAnnotation input qualify { useMaybe } { type_, required } =
    let
        annotation : CliMonad Elm.Annotation.Annotation
        annotation =
            if useMaybe then
                typeToAnnotationWithMaybe input qualify type_

            else
                typeToAnnotationWithNullable input qualify type_
    in
    if required then
        annotation

    else
        CliMonad.map Gen.Maybe.annotation_.maybe annotation


typeToEncoder : CliMonad.Input -> Common.Type -> CliMonad (Elm.Expression -> Elm.Expression)
typeToEncoder input type_ =
    case type_ of
        Common.Basic basicType basic ->
            basicTypeToEncoder input basicType basic

        Common.Null ->
            CliMonad.succeed (\_ -> Gen.Json.Encode.null)

        Common.Enum variants ->
            variants
                |> NonEmpty.toList
                |> CliMonad.enumName input
                |> CliMonad.map
                    (\maybeName rec ->
                        case maybeName of
                            Nothing ->
                                Gen.Json.Encode.call_.string rec

                            Just name ->
                                Elm.apply
                                    (Elm.value
                                        { importFrom = CliMonad.moduleToNamespace input Common.Json
                                        , name = "encode" ++ Common.toTypeName name
                                        , annotation = Nothing
                                        }
                                    )
                                    [ rec ]
                    )

        Common.Object properties ->
            let
                allRequired : Bool
                allRequired =
                    List.all (\( _, { required } ) -> required) properties
            in
            properties
                |> CliMonad.combineMap
                    (\( key, field ) ->
                        typeToEncoder input field.type_
                            |> CliMonad.map
                                (\encoder rec ->
                                    let
                                        fieldExpr : Elm.Expression
                                        fieldExpr =
                                            Elm.get (Common.toValueName key) rec

                                        toTuple : Elm.Expression -> Elm.Expression
                                        toTuple value =
                                            Elm.tuple
                                                (Elm.string (Common.unwrapUnsafe key))
                                                (encoder value)
                                    in
                                    if allRequired then
                                        toTuple fieldExpr

                                    else if field.required then
                                        Gen.Maybe.make_.just (toTuple fieldExpr)

                                    else
                                        Gen.Maybe.map toTuple fieldExpr
                                )
                            |> CliMonad.withPath key
                    )
                |> CliMonad.map
                    (\toProperties value ->
                        if allRequired then
                            Gen.Json.Encode.object <|
                                List.map (\prop -> prop value) toProperties

                        else
                            Gen.Json.Encode.call_.object <|
                                Gen.List.filterMap Gen.Basics.identity <|
                                    List.map (\prop -> prop value) toProperties
                    )

        Common.List t ->
            typeToEncoder input t
                |> CliMonad.map
                    (\encoder ->
                        Gen.Json.Encode.call_.list (Elm.functionReduced "rec" encoder)
                    )

        -- An object with additionalProperties (the type of those properties is
        -- `additionalProperties`) and no normal `properties` fields: A simple Dict.
        Common.Dict additionalProperties [] ->
            typeToEncoder input additionalProperties.type_
                |> CliMonad.map
                    (\encoder ->
                        Gen.Json.Encode.call_.dict Gen.Basics.values_.identity (Elm.functionReduced "rec" encoder)
                    )

        -- An object with additionalProperties *and* normal `properties` fields.
        Common.Dict additionalProperties properties ->
            let
                allRequired : Bool
                allRequired =
                    List.all (\( _, { required } ) -> required) properties
            in
            properties
                |> CliMonad.combineMap
                    (\( key, field ) ->
                        typeToEncoder input field.type_
                            |> CliMonad.map
                                (\encoder rec ->
                                    let
                                        fieldExpr : Elm.Expression
                                        fieldExpr =
                                            Elm.get (Common.toValueName key) rec

                                        toTuple : Elm.Expression -> Elm.Expression
                                        toTuple value =
                                            Elm.tuple
                                                (Elm.string (Common.unwrapUnsafe key))
                                                (encoder value)
                                    in
                                    if allRequired then
                                        toTuple fieldExpr

                                    else if field.required then
                                        Gen.Maybe.make_.just (toTuple fieldExpr)

                                    else
                                        Gen.Maybe.map toTuple fieldExpr
                                )
                            |> CliMonad.withPath key
                    )
                |> CliMonad.map2
                    (\additionalPropertyEncoder toProperties ->
                        \value ->
                            Gen.Json.Encode.call_.object
                                (Gen.List.call_.append
                                    (if allRequired then
                                        Elm.list (List.map (\prop -> prop value) toProperties)

                                     else
                                        Gen.List.filterMap Gen.Basics.identity (List.map (\prop -> prop value) toProperties)
                                    )
                                    (Gen.List.call_.map
                                        (Elm.fn (Elm.Arg.tuple (Elm.Arg.var "key") (Elm.Arg.var "value"))
                                            (\( key, data ) ->
                                                Elm.tuple key (additionalPropertyEncoder data)
                                            )
                                        )
                                        (Gen.Dict.toList (Elm.get "additionalProperties" value))
                                    )
                                )
                    )
                    (typeToEncoder input additionalProperties.type_)

        Common.Nullable t ->
            CliMonad.map
                (\encoder nullableValue ->
                    Elm.Case.custom
                        nullableValue
                        (OpenApi.Common.Internal.annotation_.nullable (Elm.Annotation.var "value"))
                        [ Elm.Case.branch (Elm.Arg.customType "Null" ()) (\_ -> Gen.Json.Encode.null)
                        , Elm.Case.branch
                            (Elm.Arg.customType "Present" identity
                                |> Elm.Arg.item (Elm.Arg.varWith "value" (Elm.Annotation.var "value"))
                            )
                            encoder
                        ]
                )
                (typeToEncoder input t)

        Common.Value ->
            CliMonad.succeed <| Gen.Basics.identity

        Common.Ref ref ->
            refToTypeName ref
                |> CliMonad.map
                    (\name rec ->
                        Elm.apply
                            (Elm.value
                                { importFrom = CliMonad.moduleToNamespace input Common.Json
                                , name = "encode" ++ Common.toTypeName name
                                , annotation = Nothing
                                }
                            )
                            [ rec ]
                    )
                |> CliMonad.withPath (Common.UnsafeName (String.join "/" ref))

        Common.OneOf oneOfName oneOfData ->
            oneOfData
                |> NonEmpty.toList
                |> CliMonad.combineMap
                    (\variant ->
                        CliMonad.map2
                            (\ann variantEncoder ->
                                Elm.Case.branch
                                    (Elm.Arg.customType (toVariantName oneOfName variant.name) identity
                                        |> Elm.Arg.item (Elm.Arg.varWith "content" ann)
                                    )
                                    variantEncoder
                            )
                            (typeToAnnotationWithNullable input True variant.type_)
                            (typeToEncoder input variant.type_)
                            |> CliMonad.withPath variant.name
                    )
                |> CliMonad.map
                    (\branches rec ->
                        let
                            typesNamespace : List String
                            typesNamespace =
                                CliMonad.moduleToNamespace input Common.Types
                        in
                        Elm.Case.custom rec
                            (Elm.Annotation.named typesNamespace oneOfName)
                            branches
                    )

        Common.Bytes ->
            CliMonad.todo input "Encoder for bytes not implemented"
                |> CliMonad.map (\encoder _ -> encoder)

        Common.Unit ->
            CliMonad.succeed (\_ -> Gen.Json.Encode.null)


basicTypeToEncoder : CliMonad.Input -> Common.BasicType -> { a | format : Maybe String } -> CliMonad (Elm.Expression -> Elm.Expression)
basicTypeToEncoder input basicType { format } =
    let
        default : Elm.Expression -> Elm.Expression
        default =
            case basicType of
                Common.String ->
                    Gen.Json.Encode.call_.string

                Common.Integer ->
                    Gen.Json.Encode.call_.int

                Common.Number ->
                    Gen.Json.Encode.call_.float

                Common.Boolean ->
                    Gen.Json.Encode.call_.bool
    in
    CliMonad.withFormat input basicType format .encode default


oneOfAnnotation : CliMonad.Input -> Bool -> Common.TypeName -> List Common.OneOfData -> CliMonad Elm.Annotation.Annotation
oneOfAnnotation input qualify oneOfName oneOfData =
    Elm.Annotation.named
        (if qualify then
            CliMonad.moduleToNamespace input Common.Types

         else
            []
        )
        oneOfName
        |> CliMonad.succeedWith
            (FastDict.singleton oneOfName oneOfData)


refToTypeName : List String -> CliMonad Common.UnsafeName
refToTypeName ref =
    case ref of
        [ "#", "components", _, name ] ->
            CliMonad.succeed (Common.UnsafeName name)

        _ ->
            CliMonad.fail <| "Couldn't get the type ref (" ++ String.join "/" ref ++ ") for the response"


typeToDecoder : CliMonad.Input -> Common.Type -> CliMonad Elm.Expression
typeToDecoder input type_ =
    case type_ of
        Common.Object properties ->
            List.foldl
                (\( key, field ) prevExprRes ->
                    CliMonad.map2
                        (\internalDecoder prevExpr ->
                            Elm.Op.Extra.pipeInto "prev"
                                (OpenApi.Common.Internal.commonSubmodule.call.jsonDecodeAndMap
                                    (if field.required then
                                        Gen.Json.Decode.field (Common.unwrapUnsafe key) internalDecoder

                                     else
                                        OpenApi.Common.Internal.commonSubmodule.call.decodeOptionalField
                                            (Elm.string (Common.unwrapUnsafe key))
                                            internalDecoder
                                    )
                                )
                                prevExpr
                        )
                        (typeToDecoder input field.type_ |> CliMonad.withPath key)
                        prevExprRes
                )
                (CliMonad.succeed
                    (Gen.Json.Decode.succeed
                        (Elm.function
                            (List.map (\( key, _ ) -> ( Common.toValueName key, Nothing )) properties)
                            (\args ->
                                Elm.record
                                    (List.map2
                                        (\( key, _ ) arg -> ( Common.toValueName key, arg ))
                                        properties
                                        args
                                    )
                            )
                        )
                    )
                )
                properties

        Common.Basic basicType basic ->
            basicTypeToDecoder input basicType basic

        Common.Null ->
            CliMonad.succeed (Gen.Json.Decode.null Elm.unit)

        Common.Unit ->
            CliMonad.succeed (Gen.Json.Decode.succeed Elm.unit)

        Common.List t ->
            CliMonad.map Gen.Json.Decode.list
                (typeToDecoder input t)

        Common.Dict additionalProperties [] ->
            CliMonad.map Gen.Json.Decode.dict
                (typeToDecoder input additionalProperties.type_)

        Common.Dict additionalProperties properties ->
            properties
                |> List.foldl
                    (\( key, field ) prevExprRes ->
                        CliMonad.map2
                            (\internalDecoder prevExpr ->
                                prevExpr
                                    |> Elm.Op.Extra.pipeInto "prev"
                                        (OpenApi.Common.Internal.commonSubmodule.call.jsonDecodeAndMap
                                            (if field.required then
                                                Gen.Json.Decode.field (Common.unwrapUnsafe key) internalDecoder

                                             else
                                                OpenApi.Common.Internal.commonSubmodule.call.decodeOptionalField
                                                    (Elm.string (Common.unwrapUnsafe key))
                                                    internalDecoder
                                            )
                                        )
                            )
                            (typeToDecoder input field.type_ |> CliMonad.withPath key)
                            prevExprRes
                    )
                    (CliMonad.succeed
                        (Gen.Json.Decode.succeed
                            (Elm.function
                                (List.map (\( key, _ ) -> ( Common.toValueName key, Nothing )) properties
                                    ++ [ ( Common.toValueName (Common.UnsafeName "additionalProperties"), Nothing ) ]
                                )
                                (\args ->
                                    Elm.record
                                        (List.map2
                                            (\( key, _ ) arg -> ( Common.toValueName key, arg ))
                                            (properties
                                                ++ [ ( Common.UnsafeName "additionalProperties"
                                                     , { type_ = additionalProperties.type_
                                                       , required = True
                                                       , documentation = Nothing
                                                       }
                                                     )
                                                   ]
                                            )
                                            args
                                        )
                                )
                            )
                        )
                    )
                |> CliMonad.map2
                    (\dictValueDecoder prevExpr ->
                        prevExpr
                            |> Elm.Op.Extra.pipeInto "prev"
                                (OpenApi.Common.Internal.commonSubmodule.call.jsonDecodeAndMap
                                    (Gen.Json.Decode.keyValuePairs Gen.Json.Decode.value
                                        |> Elm.Op.Extra.pipeInto "keyValuePairs"
                                            (Gen.Json.Decode.andThen
                                                (\keyValuePairs ->
                                                    Gen.List.call_.filterMap
                                                        (Elm.fn (Elm.Arg.tuple (Elm.Arg.var "key") (Elm.Arg.var "jsonValue"))
                                                            (\( key, jsonValue ) ->
                                                                let
                                                                    propertyNames : Elm.Expression
                                                                    propertyNames =
                                                                        properties
                                                                            |> List.map (Tuple.first >> Common.unwrapUnsafe >> Elm.string)
                                                                            |> Elm.list
                                                                in
                                                                Elm.ifThen (Elm.apply Gen.List.values_.member [ key, propertyNames ])
                                                                    Elm.nothing
                                                                    (Elm.Let.letIn
                                                                        (\additionalPropertyDecoder ->
                                                                            Elm.Case.result
                                                                                (Elm.apply Gen.Json.Decode.values_.decodeValue
                                                                                    [ additionalPropertyDecoder, jsonValue ]
                                                                                )
                                                                                { err =
                                                                                    ( "decodeError"
                                                                                    , \decodeError ->
                                                                                        let
                                                                                            decoderErrorAsString : Elm.Expression
                                                                                            decoderErrorAsString =
                                                                                                Elm.apply Gen.Json.Decode.values_.errorToString
                                                                                                    [ decodeError ]
                                                                                        in
                                                                                        Elm.just
                                                                                            (Gen.Result.make_.err
                                                                                                (Elm.Op.Extra.appends
                                                                                                    [ Elm.string "Field '"
                                                                                                    , key
                                                                                                    , Elm.string "': "
                                                                                                    , decoderErrorAsString
                                                                                                    ]
                                                                                                )
                                                                                            )
                                                                                    )
                                                                                , ok =
                                                                                    ( "decodedValue"
                                                                                    , \decodedValue ->
                                                                                        Elm.just
                                                                                            (Gen.Result.make_.ok (Elm.tuple key decodedValue))
                                                                                    )
                                                                                }
                                                                        )
                                                                        |> Elm.Let.value "additionalPropertyDecoder" dictValueDecoder
                                                                        |> Elm.Let.toExpression
                                                                    )
                                                            )
                                                        )
                                                        keyValuePairs
                                                        |> Elm.Op.Extra.pipeInto "resultPairs"
                                                            (\resultPairs ->
                                                                Elm.Let.letIn
                                                                    (\fieldErrors ->
                                                                        Elm.ifThen (Elm.apply Gen.List.values_.isEmpty [ fieldErrors ])
                                                                            (resultPairs
                                                                                |> Elm.Op.Extra.pipeInto "prev"
                                                                                    (Gen.List.call_.filterMap
                                                                                        Gen.Result.values_.toMaybe
                                                                                    )
                                                                                |> Elm.Op.Extra.pipeInto "prev" Gen.Dict.call_.fromList
                                                                                |> Elm.Op.Extra.pipeInto "prev" Gen.Json.Decode.succeed
                                                                            )
                                                                            (Elm.list
                                                                                [ Elm.string "Errors while decoding additionalProperties:\n- "
                                                                                , Elm.apply Gen.String.values_.join
                                                                                    [ Elm.string "\n\n- ", fieldErrors ]
                                                                                , Elm.string "\n"
                                                                                ]
                                                                                |> Elm.Op.Extra.pipeInto "prev" Gen.String.call_.concat
                                                                                |> Elm.Op.Extra.pipeInto "prev" Gen.Json.Decode.call_.fail
                                                                            )
                                                                    )
                                                                    |> Elm.Let.value "fieldErrors"
                                                                        (Elm.apply Gen.List.values_.filterMap
                                                                            [ Elm.fn (Elm.Arg.var "field")
                                                                                (\field ->
                                                                                    Elm.Case.result field
                                                                                        { ok = ( "_", \_ -> Elm.nothing )
                                                                                        , err = ( "error", \error -> Elm.just error )
                                                                                        }
                                                                                )
                                                                            , resultPairs
                                                                            ]
                                                                        )
                                                                    |> Elm.Let.toExpression
                                                            )
                                                )
                                            )
                                    )
                                )
                    )
                    (typeToDecoder input additionalProperties.type_)

        Common.Enum variants ->
            variants
                |> NonEmpty.toList
                |> CliMonad.enumName input
                |> CliMonad.map
                    (\maybeName ->
                        case maybeName of
                            Nothing ->
                                Gen.Json.Decode.string
                                    |> Gen.Json.Decode.andThen
                                        (\raw ->
                                            let
                                                unwrappedVariants : List String
                                                unwrappedVariants =
                                                    List.map Common.unwrapUnsafe (NonEmpty.toList variants)
                                            in
                                            Elm.Case.string raw
                                                { cases =
                                                    unwrappedVariants
                                                        |> List.map (\variant -> ( variant, Gen.Json.Decode.succeed (Elm.string variant) ))
                                                , otherwise =
                                                    Gen.Json.Decode.call_.fail
                                                        (Elm.Op.Extra.appends
                                                            [ Elm.string "Value \""
                                                            , raw
                                                            , Elm.string ("\" is not valid for the enum, possible values: \"" ++ String.join "\", \"" unwrappedVariants ++ "\"")
                                                            ]
                                                        )
                                                }
                                        )

                            Just name ->
                                Elm.value
                                    { importFrom = CliMonad.moduleToNamespace input Common.Json
                                    , name = "decode" ++ Common.toTypeName name
                                    , annotation = Nothing
                                    }
                    )

        Common.Value ->
            CliMonad.succeed Gen.Json.Decode.value

        Common.Nullable t ->
            CliMonad.map
                (\decoder ->
                    Gen.Json.Decode.oneOf
                        [ Gen.Json.Decode.map
                            OpenApi.Common.Internal.make_.present
                            decoder
                        , Gen.Json.Decode.null
                            OpenApi.Common.Internal.make_.null
                        ]
                )
                (typeToDecoder input t)

        Common.Ref ref ->
            CliMonad.map
                (\name ->
                    Elm.value
                        { importFrom = CliMonad.moduleToNamespace input Common.Json
                        , name = "decode" ++ Common.toTypeName name
                        , annotation = Nothing
                        }
                )
                (refToTypeName ref)
                |> CliMonad.withPath (Common.UnsafeName (String.join "/" ref))

        Common.OneOf oneOfName variants ->
            variants
                |> NonEmpty.toList
                |> CliMonad.combineMap
                    (\variant ->
                        typeToDecoder input variant.type_
                            |> CliMonad.map
                                (Gen.Json.Decode.call_.map
                                    (Elm.value
                                        { importFrom = CliMonad.moduleToNamespace input Common.Types
                                        , name = toVariantName oneOfName variant.name
                                        , annotation = Nothing
                                        }
                                    )
                                )
                            |> CliMonad.withPath variant.name
                    )
                |> CliMonad.map
                    (\decoders ->
                        let
                            typesNamespace : List String
                            typesNamespace =
                                CliMonad.moduleToNamespace input Common.Types
                        in
                        decoders
                            |> Gen.Json.Decode.oneOf
                            |> Elm.withType (Elm.Annotation.named typesNamespace oneOfName)
                    )

        Common.Bytes ->
            CliMonad.todo input "Bytes decoder not implemented yet"


basicTypeToDecoder : CliMonad.Input -> Common.BasicType -> { format : Maybe String, const : Maybe Common.ConstValue } -> CliMonad Elm.Expression
basicTypeToDecoder input basicType { format, const } =
    let
        base : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
        base toString decoder =
            case const of
                Nothing ->
                    decoder

                Just expected ->
                    decoder
                        |> Gen.Json.Decode.andThen
                            (\actual ->
                                Elm.ifThen
                                    (Elm.Op.equal actual (constToExpr expected))
                                    (Gen.Json.Decode.succeed actual)
                                    (Gen.Json.Decode.call_.fail
                                        (Elm.Op.append
                                            (Elm.string
                                                ("Unexpected value: expected "
                                                    ++ constToString expected
                                                    ++ " got "
                                                )
                                            )
                                            (toString actual)
                                        )
                                    )
                            )

        default : Elm.Expression
        default =
            case basicType of
                Common.String ->
                    base
                        (\s -> Gen.Json.Encode.encode 0 (Gen.Json.Encode.call_.string s))
                        Gen.Json.Decode.string

                Common.Integer ->
                    base Gen.String.call_.fromInt Gen.Json.Decode.int

                Common.Number ->
                    base Gen.String.call_.fromFloat Gen.Json.Decode.float

                Common.Boolean ->
                    let
                        boolToString : Bool -> String
                        boolToString b =
                            if b then
                                "true"

                            else
                                "false"
                    in
                    case const of
                        Just (Common.ConstBoolean expected) ->
                            Gen.Json.Decode.bool
                                |> Gen.Json.Decode.andThen
                                    (\actual ->
                                        Elm.ifThen
                                            (Elm.Op.equal actual (Elm.bool expected))
                                            (Gen.Json.Decode.succeed actual)
                                            (Gen.Json.Decode.call_.fail
                                                (Elm.string
                                                    ("Unexpected value: expected "
                                                        ++ boolToString expected
                                                        ++ " got "
                                                        ++ boolToString (not expected)
                                                    )
                                                )
                                            )
                                    )

                        Just _ ->
                            Gen.Json.Decode.bool

                        Nothing ->
                            Gen.Json.Decode.bool
    in
    CliMonad.withFormat input basicType format .decoder default


constToString : Common.ConstValue -> String
constToString const =
    case const of
        Common.ConstInteger i ->
            String.fromInt i

        Common.ConstBoolean True ->
            "true"

        Common.ConstBoolean False ->
            "false"

        Common.ConstNumber f ->
            String.fromFloat f

        Common.ConstString s ->
            Json.Encode.encode 0 (Json.Encode.string s)


constToExpr : Common.ConstValue -> Elm.Expression
constToExpr const =
    case const of
        Common.ConstInteger i ->
            Elm.int i

        Common.ConstBoolean b ->
            Elm.bool b

        Common.ConstString s ->
            Elm.string s

        Common.ConstNumber f ->
            Elm.float f
