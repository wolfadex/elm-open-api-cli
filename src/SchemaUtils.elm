module SchemaUtils exposing
    ( OneOfName
    , getRequestBody
    , getSchema
    , oneOfDeclarations
    , recordType
    , schemaToType
    , subschemaToEnumMaybe
    , toVariantName
    , typeToAnnotationWithMaybe
    , typeToAnnotationWithNullable
    , typeToDecoder
    , typeToEncoder
    , typeToString
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
import IntersectionResult exposing (IntersectionResult)
import Json.Decode
import Json.Encode
import Json.Schema.Definitions
import LazyList exposing (LazyList)
import List.Extra
import Maybe.Extra
import Murmur3
import NonEmpty exposing (NonEmpty)
import OpenApi
import OpenApi.Common.Internal
import OpenApi.Components
import OpenApi.Reference
import OpenApi.RequestBody
import OpenApi.Schema
import Pretty
import Result.Extra
import Set exposing (Set)


getSchema : Common.RefTo Common.Schema -> CliMonad Json.Schema.Definitions.Schema
getSchema ref =
    let
        ( _, Common.UnsafeName refName ) =
            Common.unwrapRef ref
    in
    CliMonad.getApiSpec
        |> CliMonad.stepOrFail ("Could not find components in the schema, while looking up " ++ refName)
            OpenApi.components
        |> CliMonad.stepOrFail ("Could not find component's schema, while looking up " ++ refName)
            (\components -> Dict.get refName (OpenApi.Components.schemas components))
        |> CliMonad.map OpenApi.Schema.get


getRequestBody : Common.RefTo Common.RequestBody -> CliMonad (OpenApi.Reference.ReferenceOr OpenApi.RequestBody.RequestBody)
getRequestBody ref =
    let
        ( _, Common.UnsafeName refName ) =
            Common.unwrapRef ref
    in
    CliMonad.getApiSpec
        |> CliMonad.stepOrFail ("Could not find components in the schema, while looking up " ++ refName)
            OpenApi.components
        |> CliMonad.stepOrFail ("Could not find component's schema, while looking up " ++ refName)
            (\components -> Dict.get refName (OpenApi.Components.requestBodies components))


subSchemaAllOfToProperties : List (Common.RefTo Common.Schema) -> Json.Schema.Definitions.SubSchema -> CliMonad (List ( Common.UnsafeName, Common.Field ))
subSchemaAllOfToProperties seen subSchema =
    subSchema.allOf
        |> Maybe.withDefault []
        |> CliMonad.combineMap (schemaToProperties seen)
        |> CliMonad.map (List.foldl listUnion [])
        |> CliMonad.withPath (Common.UnsafeName "allOf")


schemaToProperties : List (Common.RefTo Common.Schema) -> Json.Schema.Definitions.Schema -> CliMonad (List ( Common.UnsafeName, Common.Field ))
schemaToProperties seen allOfItem =
    case allOfItem of
        Json.Schema.Definitions.ObjectSchema allOfItemSchema ->
            CliMonad.map3
                (\a b c ->
                    listUnion a b
                        |> listUnion c
                )
                (subSchemaToProperties seen allOfItemSchema)
                (subSchemaRefToProperties seen allOfItemSchema)
                (subSchemaAllOfToProperties seen allOfItemSchema)

        Json.Schema.Definitions.BooleanSchema _ ->
            CliMonad.todoWithDefault [] "Boolean schema inside allOf"


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


subSchemaRefToProperties : List (Common.RefTo Common.Schema) -> Json.Schema.Definitions.SubSchema -> CliMonad (List ( Common.UnsafeName, Common.Field ))
subSchemaRefToProperties seen allOfItem =
    case allOfItem.ref of
        Nothing ->
            CliMonad.succeed []

        Just ref ->
            Common.parseSchemaRef ref
                |> CliMonad.fromResult
                |> CliMonad.andThen getSchema
                |> CliMonad.andThen (schemaToProperties seen)
                |> CliMonad.withPath (Common.UnsafeName ref)


subSchemaToProperties : List (Common.RefTo Common.Schema) -> Json.Schema.Definitions.SubSchema -> CliMonad (List ( Common.UnsafeName, Common.Field ))
subSchemaToProperties seen sch =
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
                schemaToType seen valueSchema
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


schemaToType : List (Common.RefTo Common.Schema) -> Json.Schema.Definitions.Schema -> CliMonad { type_ : Common.Type, documentation : Maybe String }
schemaToType seen schema =
    case schema of
        Json.Schema.Definitions.BooleanSchema _ ->
            CliMonad.todoWithDefault { type_ = Common.Value, documentation = Nothing } "Boolean schema"

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
                            objectSchemaToType seen subSchema

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
                                    CliMonad.todoWithDefault { type_ = Common.Value, documentation = subSchema.description } "Array of items as item definition"

                                Json.Schema.Definitions.ItemDefinition itemSchema ->
                                    CliMonad.map
                                        (\item ->
                                            toListType subSchema.description item
                                        )
                                        (schemaToType seen itemSchema)

                anyOfToType : List Json.Schema.Definitions.Schema -> CliMonad { type_ : Common.Type, documentation : Maybe String }
                anyOfToType schemas =
                    schemaIntersection seen schemas
                        |> CliMonad.andThen
                            (\disjoint ->
                                let
                                    onIntersection :
                                        { a | leftSchema : Pretty.Doc (), rightSchema : Pretty.Doc () }
                                        -> Maybe Json.Encode.Value
                                        -> CliMonad { type_ : Common.Type, documentation : Maybe String }
                                    onIntersection collision value =
                                        case areAllArrays schemas of
                                            Just innerSchemas ->
                                                oneOfToType innerSchemas
                                                    |> CliMonad.map (toListType subSchema.description)

                                            Nothing ->
                                                let
                                                    formatSchema : Pretty.Doc () -> Pretty.Doc ()
                                                    formatSchema s =
                                                        Pretty.string "- "
                                                            |> Pretty.a s
                                                            |> Pretty.nest 2

                                                    details : Pretty.Doc ()
                                                    details =
                                                        case value of
                                                            Just found ->
                                                                [ Pretty.string "Clash between"
                                                                , formatSchema collision.leftSchema
                                                                , formatSchema collision.rightSchema
                                                                , Pretty.string "Possible clashing value:"
                                                                , Json.Encode.encode 2 found
                                                                    |> String.lines
                                                                    |> List.map Pretty.string
                                                                    |> Pretty.lines
                                                                    |> Pretty.indent 2
                                                                ]
                                                                    |> Pretty.lines

                                                            Nothing ->
                                                                [ Pretty.string "Clash between"
                                                                , formatSchema collision.leftSchema
                                                                , formatSchema collision.rightSchema
                                                                , Pretty.string "Could not build a clashing value"
                                                                ]
                                                                    |> Pretty.lines
                                                in
                                                CliMonad.succeed
                                                    { type_ = Common.Value
                                                    , documentation = subSchema.description
                                                    }
                                                    |> CliMonad.withExtendedWarning
                                                        { message = "anyOf between overlapping types is not supported"
                                                        , details = details
                                                        }
                                in
                                case disjoint of
                                    NoSchemaIntersection ->
                                        oneOfToType schemas

                                    FoundSchemaIntersection collision ->
                                        onIntersection collision (Just collision.value)

                                    SchemaMayIntersect collision ->
                                        onIntersection collision Nothing
                            )

                oneOfCombine : List Json.Schema.Definitions.Schema -> CliMonad { type_ : Common.Type, documentation : Maybe String }
                oneOfCombine oneOf =
                    oneOf
                        |> CliMonad.combineMap (schemaToType seen)
                        |> CliMonad.andThen oneOfType
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
                                    schemaToType seen second
                                        |> nullable

                                ( _, Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType ) ->
                                    schemaToType seen first
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
                            Common.parseSchemaRef ref
                                |> CliMonad.fromResult
                                |> CliMonad.map
                                    (\parsed ->
                                        { type_ = Common.Ref parsed
                                        , documentation = subSchema.description
                                        }
                                    )

                        Nothing ->
                            case subSchema.anyOf of
                                Just [ onlySchema ] ->
                                    schemaToType seen onlySchema

                                Just [ firstSchema, secondSchema ] ->
                                    case ( firstSchema, secondSchema ) of
                                        ( Json.Schema.Definitions.ObjectSchema firstSubSchema, Json.Schema.Definitions.ObjectSchema secondSubSchema ) ->
                                            -- The first 2 cases here are for pseudo-nullable schemas where the higher level schema type is AnyOf
                                            -- but it's actually made up of only 2 types and 1 of them is nullable. This acts as a hack of sorts to
                                            -- mark a value as nullable in the schema.
                                            case ( firstSubSchema.type_, secondSubSchema.type_ ) of
                                                ( Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType, _ ) ->
                                                    nullable (schemaToType seen secondSchema)

                                                ( _, Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType ) ->
                                                    nullable (schemaToType seen firstSchema)

                                                _ ->
                                                    anyOfToType [ firstSchema, secondSchema ]

                                        _ ->
                                            anyOfToType [ firstSchema, secondSchema ]

                                Just anyOf ->
                                    anyOfToType anyOf

                                Nothing ->
                                    case subSchema.allOf of
                                        Just [ onlySchema ] ->
                                            schemaToType seen onlySchema

                                        Just [] ->
                                            CliMonad.succeed { type_ = Common.Value, documentation = subSchema.description }

                                        Just _ ->
                                            -- If we have more than one item in `allOf`, then it's _probably_ an object
                                            -- TODO: improve this to actually check if all the `allOf` subschema are objects.
                                            objectSchemaToType seen subSchema

                                        Nothing ->
                                            case subSchema.oneOf of
                                                Just [ onlySchema ] ->
                                                    schemaToType seen onlySchema

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
                        |> CliMonad.andThen oneOfType
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


toListType :
    Maybe String
    ->
        { type_ : Common.Type
        , documentation : Maybe String
        }
    -> { type_ : Common.Type, documentation : Maybe String }
toListType description { type_, documentation } =
    { type_ = Common.List type_
    , documentation =
        [ description
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


type SchemaIntersectionResult
    = NoSchemaIntersection
    | SchemaMayIntersect
        { leftSchema : Pretty.Doc ()
        , rightSchema : Pretty.Doc ()
        }
    | FoundSchemaIntersection
        { leftSchema : Pretty.Doc ()
        , value : Json.Encode.Value
        , rightSchema : Pretty.Doc ()
        }


schemaIntersection : List (Common.RefTo Common.Schema) -> List Json.Schema.Definitions.Schema -> CliMonad SchemaIntersectionResult
schemaIntersection seen schemas =
    let
        intersect : Json.Schema.Definitions.Schema -> Json.Schema.Definitions.Schema -> CliMonad SchemaIntersectionResult
        intersect l r =
            case ( l, r ) of
                ( Json.Schema.Definitions.BooleanSchema lb, Json.Schema.Definitions.BooleanSchema rb ) ->
                    if lb == rb then
                        { leftSchema = Pretty.string "bool"
                        , value = Json.Encode.bool lb
                        , rightSchema = Pretty.string "bool"
                        }
                            |> FoundSchemaIntersection
                            |> CliMonad.succeed

                    else
                        CliMonad.succeed NoSchemaIntersection

                ( Json.Schema.Definitions.BooleanSchema _, Json.Schema.Definitions.ObjectSchema _ ) ->
                    CliMonad.succeed NoSchemaIntersection

                ( Json.Schema.Definitions.ObjectSchema _, Json.Schema.Definitions.BooleanSchema _ ) ->
                    CliMonad.succeed NoSchemaIntersection

                ( Json.Schema.Definitions.ObjectSchema lo, Json.Schema.Definitions.ObjectSchema ro ) ->
                    CliMonad.andThen2
                        (\lt rt ->
                            typesIntersection seen lt.type_ rt.type_
                        )
                        (schemaToType seen l)
                        (schemaToType seen r)
                        |> CliMonad.andThen
                            (\res ->
                                case res of
                                    IntersectionResult.FoundIntersection i ->
                                        CliMonad.map2
                                            (\ld rd ->
                                                { leftSchema = ld
                                                , value = i
                                                , rightSchema = rd
                                                }
                                                    |> FoundSchemaIntersection
                                            )
                                            (describeSubSchema lo)
                                            (describeSubSchema ro)

                                    IntersectionResult.MayIntersect ->
                                        CliMonad.map2
                                            (\ld rd ->
                                                { leftSchema = ld
                                                , rightSchema = rd
                                                }
                                                    |> SchemaMayIntersect
                                            )
                                            (describeSubSchema lo)
                                            (describeSubSchema ro)

                                    IntersectionResult.NoIntersection ->
                                        CliMonad.succeed NoSchemaIntersection
                            )

        go :
            LazyList ( Json.Schema.Definitions.Schema, Json.Schema.Definitions.Schema )
            -> SchemaIntersectionResult
            -> CliMonad SchemaIntersectionResult
        go queue acc =
            case queue of
                LazyList.LazyEmpty ->
                    CliMonad.succeed acc

                LazyList.LazyCons ( l, r ) t ->
                    intersect l r
                        |> CliMonad.andThen
                            (\f ->
                                case f of
                                    FoundSchemaIntersection _ ->
                                        CliMonad.succeed f

                                    SchemaMayIntersect _ ->
                                        go (t ()) f

                                    NoSchemaIntersection ->
                                        go (t ()) acc
                            )

        lazyList : LazyList Json.Schema.Definitions.Schema
        lazyList =
            LazyList.fromList schemas
    in
    go (LazyList.uniquePairs lazyList) NoSchemaIntersection


describeSubSchema : Json.Schema.Definitions.SubSchema -> CliMonad (Pretty.Doc ())
describeSubSchema subSchema =
    let
        sourceToString : Json.Decode.Value -> Pretty.Doc ()
        sourceToString source =
            source
                |> Json.Decode.decodeValue removeDocumentation
                |> Result.withDefault subSchema.source
                |> Json.Encode.encode 0
                |> Pretty.string
    in
    case subSchema.ref of
        Nothing ->
            CliMonad.succeed (sourceToString subSchema.source)

        Just ref ->
            Common.parseSchemaRef ref
                |> CliMonad.fromResult
                |> CliMonad.andThen
                    (\parsedRef ->
                        getSchema parsedRef
                            |> CliMonad.map
                                (\f ->
                                    let
                                        source : Json.Decode.Value
                                        source =
                                            case f of
                                                Json.Schema.Definitions.ObjectSchema o ->
                                                    o.source

                                                Json.Schema.Definitions.BooleanSchema b ->
                                                    Json.Encode.bool b
                                    in
                                    Pretty.string (ref ++ ": ")
                                        |> Pretty.a (sourceToString source)
                                )
                            |> CliMonad.withPath (Common.refToString parsedRef)
                    )


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


exampleOfType : List (Common.RefTo Common.Schema) -> Common.Type -> CliMonad Json.Encode.Value
exampleOfType seen type_ =
    case type_ of
        Common.Nullable _ ->
            CliMonad.succeed Json.Encode.null

        Common.Object fields ->
            fields
                |> CliMonad.combineMap
                    (\( fieldName, field ) ->
                        if field.required then
                            exampleOfType seen field.type_
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
                    exampleString format

        Common.Null ->
            CliMonad.succeed Json.Encode.null

        Common.List _ ->
            CliMonad.succeed (Json.Encode.list never [])

        Common.Dict _ fields ->
            fields
                |> CliMonad.combineMap
                    (\( fieldName, field ) ->
                        if field.required then
                            exampleOfType seen field.type_
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
            exampleOfType seen t.type_

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
                    newSeen : List (Common.RefTo Common.Schema)
                    newSeen =
                        ref :: seen
                in
                refToType newSeen ref
                    |> CliMonad.andThen (\t -> exampleOfType newSeen t)
                    |> CliMonad.withPath (Common.refToString ref)

        Common.Bytes ->
            Json.Encode.string "<bytes>"
                |> CliMonad.succeed

        Common.Unit ->
            Json.Encode.string "<empty>"
                |> CliMonad.succeed


refToType : List (Common.RefTo Common.Schema) -> Common.RefTo Common.Schema -> CliMonad Common.Type
refToType seen ref =
    CliMonad.getOrCache ref
        (\() ->
            getSchema ref
                |> CliMonad.andThen (schemaToType seen)
                |> CliMonad.map .type_
        )


exampleString : Maybe String -> CliMonad Json.Encode.Value
exampleString format =
    CliMonad.withFormat Common.String format .example (Json.Encode.string "")


type SimplifiedForIntersectionBasicType
    = SimplifiedForIntersectionNumber (Maybe Float)
    | SimplifiedForIntersectionString (Maybe String)
    | SimplifiedForIntersectionBool (Maybe Bool)


typesIntersection : List (Common.RefTo Common.Schema) -> Common.Type -> Common.Type -> CliMonad (IntersectionResult Json.Encode.Value)
typesIntersection seen lType rType =
    let
        followRef : Common.RefTo Common.Schema -> Common.Type -> CliMonad (IntersectionResult Json.Encode.Value)
        followRef ref oType =
            if List.Extra.count ((==) ref) seen > 2 then
                CliMonad.succeed IntersectionResult.MayIntersect

            else
                let
                    newSeen : List (Common.RefTo Common.Schema)
                    newSeen =
                        ref :: seen
                in
                refToType newSeen ref
                    |> CliMonad.andThen (\type_ -> typesIntersection newSeen type_ oType)
                    |> CliMonad.withPath (Common.refToString ref)
    in
    case ( lType, rType ) of
        ( Common.Ref lRef, Common.Ref rRef ) ->
            if lRef == rRef then
                exampleOfType seen lType
                    |> CliMonad.map IntersectionResult.FoundIntersection

            else
                followRef lRef rType

        ( Common.Ref lRef, _ ) ->
            followRef lRef rType

        ( _, Common.Ref rRef ) ->
            followRef rRef lType

        ( Common.Value, _ ) ->
            CliMonad.map IntersectionResult.FoundIntersection (exampleOfType seen rType)

        ( _, Common.Value ) ->
            CliMonad.map IntersectionResult.FoundIntersection (exampleOfType seen lType)

        ( Common.Nullable _, Common.Nullable _ ) ->
            CliMonad.succeed (IntersectionResult.FoundIntersection Json.Encode.null)

        ( Common.Null, Common.Nullable _ ) ->
            CliMonad.succeed (IntersectionResult.FoundIntersection Json.Encode.null)

        ( Common.Nullable _, Common.Null ) ->
            CliMonad.succeed (IntersectionResult.FoundIntersection Json.Encode.null)

        ( Common.Nullable c, _ ) ->
            typesIntersection seen c rType

        ( _, Common.Nullable c ) ->
            typesIntersection seen lType c

        ( Common.Null, Common.Null ) ->
            CliMonad.succeed (IntersectionResult.FoundIntersection Json.Encode.null)

        ( Common.Null, Common.List _ ) ->
            CliMonad.succeed IntersectionResult.NoIntersection

        ( Common.List _, Common.Null ) ->
            CliMonad.succeed IntersectionResult.NoIntersection

        ( Common.OneOf _ alternatives, _ ) ->
            typesIntersectionOneOf seen (NonEmpty.toList alternatives) rType

        ( _, Common.OneOf _ alternatives ) ->
            typesIntersectionOneOf seen (NonEmpty.toList alternatives) lType

        ( Common.List _, Common.List _ ) ->
            -- Empty lists are not possible to distinguish
            CliMonad.succeed (IntersectionResult.FoundIntersection (Json.Encode.list never []))

        ( Common.Basic lbasic lopt, Common.Basic rbasic ropt ) ->
            case
                ( simplifyForIntersection lbasic lopt.const
                , simplifyForIntersection rbasic ropt.const
                )
            of
                ( Err warning, _ ) ->
                    CliMonad.fail warning

                ( _, Err warning ) ->
                    CliMonad.fail warning

                ( Ok (SimplifiedForIntersectionBool lconst), Ok (SimplifiedForIntersectionBool rconst) ) ->
                    CliMonad.succeed
                        (if lconst == rconst then
                            IntersectionResult.FoundIntersection (Json.Encode.bool (Maybe.withDefault True lconst))

                         else
                            IntersectionResult.NoIntersection
                        )

                ( Ok (SimplifiedForIntersectionNumber lconst), Ok (SimplifiedForIntersectionNumber rconst) ) ->
                    CliMonad.succeed
                        (if lconst == rconst then
                            IntersectionResult.FoundIntersection (Json.Encode.float (Maybe.withDefault 0 lconst))

                         else
                            IntersectionResult.NoIntersection
                        )

                ( Ok (SimplifiedForIntersectionString lconst), Ok (SimplifiedForIntersectionString rconst) ) ->
                    case ( lconst, rconst ) of
                        ( Just lstr, Just rstr ) ->
                            if lstr == rstr then
                                CliMonad.succeed (IntersectionResult.FoundIntersection (Json.Encode.string lstr))

                            else
                                CliMonad.succeed IntersectionResult.NoIntersection

                        _ ->
                            case ( lopt.format, ropt.format ) of
                                ( Just lFormat, Just rFormat ) ->
                                    if lFormat /= rFormat then
                                        stringFormatsIntersection lFormat rFormat

                                    else
                                        CliMonad.map IntersectionResult.FoundIntersection (exampleString (Just lFormat))

                                _ ->
                                    lopt.format
                                        |> Maybe.Extra.orElse ropt.format
                                        |> exampleString
                                        |> CliMonad.map IntersectionResult.FoundIntersection

                _ ->
                    CliMonad.succeed IntersectionResult.NoIntersection

        ( Common.Object lFields, Common.Object rFields ) ->
            objectsIntersection seen ( lFields, Nothing ) ( rFields, Nothing )

        ( Common.Dict lAdditional lFields, Common.Dict rAdditional rFields ) ->
            objectsIntersection seen ( lFields, Just lAdditional.type_ ) ( rFields, Just rAdditional.type_ )

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
            case Set.toList (Set.intersect lSet rSet) of
                h :: _ ->
                    CliMonad.succeed (IntersectionResult.FoundIntersection (Json.Encode.string h))

                [] ->
                    CliMonad.succeed IntersectionResult.NoIntersection

        ( Common.Enum lItems, Common.Basic Common.String rOptions ) ->
            stringAndEnumIntersection rOptions lItems

        ( Common.Basic Common.String lOptions, Common.Enum rItems ) ->
            stringAndEnumIntersection lOptions rItems

        ( Common.Enum _, Common.Object _ ) ->
            CliMonad.succeed IntersectionResult.NoIntersection

        ( Common.Object _, Common.Enum _ ) ->
            CliMonad.succeed IntersectionResult.NoIntersection

        ( Common.Basic _ _, Common.Object _ ) ->
            CliMonad.succeed IntersectionResult.NoIntersection

        ( Common.Object _, Common.Basic _ _ ) ->
            CliMonad.succeed IntersectionResult.NoIntersection

        ( Common.Enum _, Common.Dict _ _ ) ->
            CliMonad.succeed IntersectionResult.NoIntersection

        ( Common.Dict _ _, Common.Enum _ ) ->
            CliMonad.succeed IntersectionResult.NoIntersection

        ( Common.Basic _ _, Common.Dict _ _ ) ->
            CliMonad.succeed IntersectionResult.NoIntersection

        ( Common.Dict _ _, Common.Basic _ _ ) ->
            CliMonad.succeed IntersectionResult.NoIntersection

        _ ->
            CliMonad.succeed IntersectionResult.MayIntersect
                |> CliMonad.withWarning ("Disjoint check not implemented for types " ++ typeToString lType ++ " and " ++ typeToString rType)


typesIntersectionOneOf : List (Common.RefTo Common.Schema) -> List Common.OneOfData -> Common.Type -> CliMonad (IntersectionResult Json.Encode.Value)
typesIntersectionOneOf seen alternatives t =
    alternatives
        |> CliMonad.combineMap
            (\alternative ->
                typesIntersection seen alternative.type_ t
                    |> CliMonad.withPath alternative.name
            )
        |> CliMonad.map findAnyIntersection


findAnyIntersection : List (IntersectionResult a) -> IntersectionResult a
findAnyIntersection =
    List.foldl
        (\e acc ->
            -- We're looking for at least one intersection, so:
            case ( e, acc ) of
                -- if we find it we're good;
                ( IntersectionResult.FoundIntersection f, _ ) ->
                    IntersectionResult.FoundIntersection f

                ( _, IntersectionResult.FoundIntersection f ) ->
                    IntersectionResult.FoundIntersection f

                -- if we could have found it, then we can't rule out an intersection;
                ( IntersectionResult.MayIntersect, _ ) ->
                    IntersectionResult.MayIntersect

                ( _, IntersectionResult.MayIntersect ) ->
                    IntersectionResult.MayIntersect

                -- otherwise it means there actually is none.
                ( IntersectionResult.NoIntersection, IntersectionResult.NoIntersection ) ->
                    IntersectionResult.NoIntersection
        )
        IntersectionResult.NoIntersection


objectsIntersection :
    List (Common.RefTo Common.Schema)
    -> ( Common.Object, Maybe Common.Type )
    -> ( Common.Object, Maybe Common.Type )
    -> CliMonad (IntersectionResult Json.Encode.Value)
objectsIntersection seen ( lFields, lAdditional ) ( rFields, rAdditional ) =
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

        combine : IntersectionResult a -> IntersectionResult (List a) -> IntersectionResult (List a)
        combine e prev =
            -- Here we're trying to build a record that satisfies both schemas so:
            case ( e, prev ) of
                -- if we already failed there is nothing to do;
                ( IntersectionResult.NoIntersection, _ ) ->
                    IntersectionResult.NoIntersection

                ( _, IntersectionResult.NoIntersection ) ->
                    IntersectionResult.NoIntersection

                -- if we failed to build a concrete intersection then we'll keep failing;
                ( IntersectionResult.MayIntersect, _ ) ->
                    IntersectionResult.MayIntersect

                ( _, IntersectionResult.MayIntersect ) ->
                    IntersectionResult.MayIntersect

                -- otherwise we can keep building.
                ( IntersectionResult.FoundIntersection p, IntersectionResult.FoundIntersection a ) ->
                    IntersectionResult.FoundIntersection (p :: a)
    in
    FastDict.merge
        (\lkey lField acc ->
            if lField.required then
                case rAdditional of
                    Nothing ->
                        CliMonad.succeed IntersectionResult.NoIntersection

                    Just rAdditionalType ->
                        CliMonad.map2
                            (\i prev ->
                                combine
                                    (IntersectionResult.map
                                        (\example -> ( lkey, example ))
                                        i
                                    )
                                    prev
                            )
                            (typesIntersection seen lField.type_ rAdditionalType
                                |> CliMonad.withPath (Common.UnsafeName lkey)
                            )
                            acc

            else
                acc
        )
        (\bkey lField rField acc ->
            if not lField.required && not rField.required then
                acc

            else
                CliMonad.map2
                    (\i prev ->
                        combine
                            (IntersectionResult.map (\example -> ( bkey, example )) i)
                            prev
                    )
                    (typesIntersection seen lField.type_ rField.type_
                        |> CliMonad.withPath (Common.UnsafeName bkey)
                    )
                    acc
        )
        (\rkey rField acc ->
            if rField.required then
                case lAdditional of
                    Nothing ->
                        CliMonad.succeed IntersectionResult.NoIntersection

                    Just lAdditionalType ->
                        CliMonad.map2
                            (\i prev ->
                                combine
                                    (IntersectionResult.map
                                        (\example -> ( rkey, example ))
                                        i
                                    )
                                    prev
                            )
                            (typesIntersection seen rField.type_ lAdditionalType
                                |> CliMonad.withPath (Common.UnsafeName rkey)
                            )
                            acc

            else
                acc
        )
        lDict
        rDict
        (CliMonad.succeed (IntersectionResult.FoundIntersection []))
        |> CliMonad.map (IntersectionResult.map Json.Encode.object)


stringAndEnumIntersection :
    { format : Maybe String, const : Maybe Common.ConstValue }
    -> NonEmpty Common.UnsafeName
    -> CliMonad (IntersectionResult Json.Encode.Value)
stringAndEnumIntersection rOptions lItems =
    case rOptions.const of
        Just (Common.ConstString rConst) ->
            if List.member (Common.UnsafeName rConst) (nonEmptyToList lItems) then
                CliMonad.succeed (IntersectionResult.FoundIntersection (Json.Encode.string rConst))

            else
                CliMonad.succeed IntersectionResult.NoIntersection

        Just _ ->
            CliMonad.fail "Wrong constant type"

        Nothing ->
            case rOptions.format of
                Nothing ->
                    lItems
                        |> Tuple.first
                        |> Common.unwrapUnsafe
                        |> Json.Encode.string
                        |> IntersectionResult.FoundIntersection
                        |> CliMonad.succeed

                Just rFormat ->
                    CliMonad.succeed IntersectionResult.MayIntersect
                        |> CliMonad.withWarning ("Disjoint check not implemented for types enum and string:" ++ rFormat)


stringFormatsIntersection : String -> String -> CliMonad (IntersectionResult Json.Encode.Value)
stringFormatsIntersection lFormat rFormat =
    -- TODO: check for disjoint formats
    CliMonad.succeed IntersectionResult.MayIntersect
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


simplifyForIntersection : Common.BasicType -> Maybe Common.ConstValue -> Result String SimplifiedForIntersectionBasicType
simplifyForIntersection basic const =
    case ( basic, const ) of
        ( Common.Boolean, Nothing ) ->
            Ok (SimplifiedForIntersectionBool Nothing)

        ( Common.Boolean, Just (Common.ConstBoolean b) ) ->
            Ok (SimplifiedForIntersectionBool (Just b))

        ( Common.Boolean, Just _ ) ->
            Err "Invalid const for boolean type"

        ( Common.String, Nothing ) ->
            Ok (SimplifiedForIntersectionString Nothing)

        ( Common.String, Just (Common.ConstString b) ) ->
            Ok (SimplifiedForIntersectionString (Just b))

        ( Common.String, Just _ ) ->
            Err "Invalid const for string type"

        ( Common.Integer, Nothing ) ->
            Ok (SimplifiedForIntersectionNumber Nothing)

        ( Common.Integer, Just (Common.ConstInteger i) ) ->
            Ok (SimplifiedForIntersectionNumber (Just (toFloat i)))

        ( Common.Integer, Just _ ) ->
            Err "Invalid const for integer type"

        ( Common.Number, Nothing ) ->
            Ok (SimplifiedForIntersectionNumber Nothing)

        ( Common.Number, Just (Common.ConstInteger i) ) ->
            Ok (SimplifiedForIntersectionNumber (Just (toFloat i)))

        ( Common.Number, Just (Common.ConstNumber f) ) ->
            Ok (SimplifiedForIntersectionNumber (Just f))

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


type alias VariantInfo =
    { name : Common.UnsafeName
    , type_ : Common.Type
    , documentation : Maybe String
    }


typeToOneOfVariant : { type_ : Common.Type, documentation : Maybe String } -> CliMonad (Maybe VariantInfo)
typeToOneOfVariant { type_, documentation } =
    let
        wrap : String -> Common.Type -> CliMonad (Maybe VariantInfo)
        wrap label t =
            typeToOneOfVariant { type_ = t, documentation = documentation }
                |> CliMonad.map
                    (Maybe.map
                        (\inner ->
                            { name = Common.UnsafeName (label ++ Common.unwrapUnsafe inner.name)
                            , type_ = type_
                            , documentation = documentation
                            }
                        )
                    )

        simple : Common.UnsafeName -> CliMonad (Maybe VariantInfo)
        simple name =
            { name = name
            , type_ = type_
            , documentation = documentation
            }
                |> Just
                |> CliMonad.succeed

        fromAnnotation : Elm.Annotation.Annotation -> CliMonad (Maybe VariantInfo)
        fromAnnotation ann =
            let
                rawName : String
                rawName =
                    ann
                        |> Elm.ToString.annotation
                        |> .signature
            in
            if String.contains "{" rawName then
                Nothing
                    |> CliMonad.succeed

            else
                { name = Common.UnsafeName rawName
                , type_ = type_
                , documentation = documentation
                }
                    |> Just
                    |> CliMonad.succeed
    in
    case type_ of
        Common.Nullable t ->
            wrap "Nullable" t

        Common.List t ->
            wrap "List" t

        Common.Dict additionalProperties [] ->
            wrap "Dict" additionalProperties.type_

        Common.Dict _ _ ->
            CliMonad.succeed Nothing

        Common.Object _ ->
            CliMonad.succeed Nothing

        Common.Null ->
            simple (Common.UnsafeName "()")

        Common.Bytes ->
            simple (Common.UnsafeName "Bytes")

        Common.Unit ->
            simple (Common.UnsafeName "()")

        Common.OneOf oneOfName _ ->
            simple (Common.UnsafeName oneOfName)

        Common.Value ->
            simple (Common.UnsafeName "JsonEncodeValue")

        Common.Ref ref ->
            Common.unwrapRef ref
                |> Tuple.second
                |> simple

        Common.Enum variants ->
            CliMonad.enumName (NonEmpty.toList variants)
                |> CliMonad.andThen
                    (\maybeName ->
                        maybeName
                            |> Maybe.withDefault (Common.UnsafeName "String")
                            |> simple
                    )

        Common.Basic basicType { format } ->
            CliMonad.withFormat basicType format (\{ annotation } -> Just annotation) Nothing
                |> CliMonad.andThen
                    (\maybeAnnotation ->
                        case maybeAnnotation of
                            Just ann ->
                                fromAnnotation ann

                            Nothing ->
                                case basicType of
                                    Common.String ->
                                        simple (Common.UnsafeName "String")

                                    Common.Integer ->
                                        simple (Common.UnsafeName "Int")

                                    Common.Boolean ->
                                        simple (Common.UnsafeName "Bool")

                                    Common.Number ->
                                        simple (Common.UnsafeName "Float")
                    )


oneOfType :
    List { type_ : Common.Type, documentation : Maybe String }
    -> CliMonad { type_ : Common.Type, documentation : Maybe String }
oneOfType types =
    types
        |> CliMonad.combineMap typeToOneOfVariant
        |> CliMonad.map
            (\maybeVariants ->
                case Maybe.Extra.combine maybeVariants |> Maybe.andThen NonEmpty.fromList of
                    Nothing ->
                        { type_ = Common.Value, documentation = Nothing }

                    Just variants ->
                        let
                            sortedVariants :
                                NonEmpty.NonEmpty
                                    { name : Common.UnsafeName
                                    , type_ : Common.Type
                                    , documentation : Maybe String
                                    }
                            sortedVariants =
                                NonEmpty.sortBy (\{ name } -> Common.unwrapUnsafe name) variants

                            names : List Common.UnsafeName
                            names =
                                List.map .name (NonEmpty.toList sortedVariants)

                            readableName : String
                            readableName =
                                names
                                    |> List.map Common.toTypeName
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
objectSchemaToTypeHelp : List (Common.RefTo Common.Schema) -> Json.Schema.Definitions.SubSchema -> CliMonad { type_ : Common.Type, documentation : Maybe String }
objectSchemaToTypeHelp seen subSchema =
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
        (subSchemaToProperties seen subSchema)
        (subSchemaAllOfToProperties seen subSchema)


objectSchemaToType : List (Common.RefTo Common.Schema) -> Json.Schema.Definitions.SubSchema -> CliMonad { type_ : Common.Type, documentation : Maybe String }
objectSchemaToType seen subSchema =
    let
        declaredProperties : CliMonad { type_ : Common.Type, documentation : Maybe String }
        declaredProperties =
            objectSchemaToTypeHelp seen subSchema

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
                        schemaToType seen additionalPropertiesSchema
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
    FastDict.Dict OneOfName (List Common.OneOfData)
    -> CliMonad (List CliMonad.Declaration)
oneOfDeclarations enums =
    FastDict.toList enums
        |> CliMonad.combineMap
            (\oneOf ->
                oneOfDeclaration oneOf
                    |> CliMonad.withPath (Common.UnsafeName (Tuple.first oneOf))
            )


oneOfDeclaration :
    ( OneOfName, List Common.OneOfData )
    -> CliMonad CliMonad.Declaration
oneOfDeclaration ( oneOfName, variants ) =
    let
        variantDeclaration : { name : Common.UnsafeName, type_ : Common.Type, documentation : Maybe String } -> CliMonad Elm.Variant
        variantDeclaration { name, type_ } =
            typeToAnnotationWithNullable type_
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
                { moduleName = Common.Types Common.Schema
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
    oneOfName ++ "__" ++ Common.toTypeName variantName


{-| Transform an OpenAPI type into an Elm annotation. Nullable values are represented using Nullable.
-}
typeToAnnotationWithNullable : Common.Type -> CliMonad Elm.Annotation.Annotation
typeToAnnotationWithNullable type_ =
    case type_ of
        Common.Nullable t ->
            CliMonad.map
                OpenApi.Common.Internal.annotation_.nullable
                (typeToAnnotationWithNullable t)

        Common.Object fields ->
            objectToAnnotation { useMaybe = False } fields

        Common.Basic basicType basic ->
            basicTypeToAnnotation basicType basic

        Common.Null ->
            CliMonad.succeed Elm.Annotation.unit

        Common.List t ->
            CliMonad.map Elm.Annotation.list (typeToAnnotationWithNullable t)

        Common.Dict additionalProperties [] ->
            -- We do not use `Elm.Annotation.dict` here because it will NOT
            -- result in `import Dict` being generated in the module, due to
            -- a bug in elm-codegen.
            CliMonad.map (Gen.Dict.annotation_.dict Elm.Annotation.string)
                (typeToAnnotationWithNullable additionalProperties.type_)

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
                |> objectToAnnotation { useMaybe = False }

        Common.Enum variants ->
            CliMonad.enumName (NonEmpty.toList variants)
                |> CliMonad.andThen
                    (\maybeName ->
                        case maybeName of
                            Nothing ->
                                CliMonad.succeed Elm.Annotation.string

                            Just name ->
                                CliMonad.nameToAnnotation Common.Schema name
                    )

        Common.OneOf oneOfName oneOfData ->
            oneOfAnnotation oneOfName (NonEmpty.toList oneOfData)

        Common.Value ->
            CliMonad.succeed Gen.Json.Encode.annotation_.value

        Common.Ref ref ->
            CliMonad.refToAnnotation ref

        Common.Bytes ->
            CliMonad.succeed Gen.Bytes.annotation_.bytes
                |> CliMonad.withRequiredPackage "elm/bytes"

        Common.Unit ->
            CliMonad.succeed Elm.Annotation.unit


{-| Transform an OpenAPI type into an Elm annotation. Nullable values are represented using Maybe.
-}
typeToAnnotationWithMaybe : Common.Type -> CliMonad Elm.Annotation.Annotation
typeToAnnotationWithMaybe type_ =
    case type_ of
        Common.Nullable t ->
            CliMonad.map Elm.Annotation.maybe (typeToAnnotationWithMaybe t)

        Common.Object fields ->
            objectToAnnotation { useMaybe = True } fields

        Common.Basic basicType basic ->
            basicTypeToAnnotation basicType basic

        Common.Null ->
            CliMonad.succeed Elm.Annotation.unit

        Common.List t ->
            CliMonad.map Elm.Annotation.list (typeToAnnotationWithMaybe t)

        Common.Dict additionalProperties [] ->
            -- We do not use `Elm.Annotation.dict` here because it will NOT
            -- result in `import Dict` being generated in the module, due to
            -- a bug in elm-codegen.
            CliMonad.map (Gen.Dict.annotation_.dict Elm.Annotation.string)
                (typeToAnnotationWithMaybe additionalProperties.type_)

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
                |> objectToAnnotation { useMaybe = True }

        Common.Enum variants ->
            variants
                |> NonEmpty.toList
                |> CliMonad.enumName
                |> CliMonad.andThen
                    (\maybeName ->
                        case maybeName of
                            Nothing ->
                                CliMonad.succeed Elm.Annotation.string

                            Just name ->
                                CliMonad.nameToAnnotation Common.Schema name
                    )

        Common.OneOf oneOfName oneOfData ->
            oneOfAnnotation oneOfName (NonEmpty.toList oneOfData)

        Common.Value ->
            CliMonad.succeed Gen.Json.Encode.annotation_.value

        Common.Ref ref ->
            CliMonad.refToAnnotation ref

        Common.Bytes ->
            CliMonad.succeed Gen.Bytes.annotation_.bytes
                |> CliMonad.withRequiredPackage "elm/bytes"

        Common.Unit ->
            CliMonad.succeed Elm.Annotation.unit


basicTypeToAnnotation : Common.BasicType -> { a | format : Maybe String } -> CliMonad Elm.Annotation.Annotation
basicTypeToAnnotation basicType { format } =
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
    CliMonad.withFormat basicType format .annotation default


objectToAnnotation : { useMaybe : Bool } -> Common.Object -> CliMonad Elm.Annotation.Annotation
objectToAnnotation config fields =
    fields
        |> CliMonad.combineMap
            (\( k, v ) ->
                fieldToAnnotation config v
                    |> CliMonad.map (Tuple.pair k)
                    |> CliMonad.withPath k
            )
        |> CliMonad.map recordType


recordType : List ( Common.UnsafeName, Elm.Annotation.Annotation ) -> Elm.Annotation.Annotation
recordType fields =
    fields
        |> List.map (Tuple.mapFirst Common.toValueName)
        |> Elm.Annotation.record


fieldToAnnotation : { useMaybe : Bool } -> Common.Field -> CliMonad Elm.Annotation.Annotation
fieldToAnnotation { useMaybe } { type_, required } =
    let
        annotation : CliMonad Elm.Annotation.Annotation
        annotation =
            if useMaybe then
                typeToAnnotationWithMaybe type_

            else
                typeToAnnotationWithNullable type_
    in
    if required then
        annotation

    else
        CliMonad.map Gen.Maybe.annotation_.maybe annotation


typeToEncoder : Common.Type -> CliMonad (Elm.Expression -> Elm.Expression)
typeToEncoder type_ =
    case type_ of
        Common.Basic basicType basic ->
            basicTypeToEncoder basicType basic

        Common.Null ->
            CliMonad.succeed (\_ -> Gen.Json.Encode.null)

        Common.Enum variants ->
            variants
                |> NonEmpty.toList
                |> CliMonad.enumName
                |> CliMonad.andThen
                    (\maybeName ->
                        case maybeName of
                            Nothing ->
                                CliMonad.succeed Gen.Json.Encode.call_.string

                            Just name ->
                                CliMonad.refToEncoder (Common.refTo Common.Schema name)
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
                        typeToEncoder field.type_
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
            typeToEncoder t
                |> CliMonad.map
                    (\encoder ->
                        Gen.Json.Encode.call_.list (Elm.functionReduced "rec" encoder)
                    )

        -- An object with additionalProperties (the type of those properties is
        -- `additionalProperties`) and no normal `properties` fields: A simple Dict.
        Common.Dict additionalProperties [] ->
            typeToEncoder additionalProperties.type_
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
                        typeToEncoder field.type_
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
                    (typeToEncoder additionalProperties.type_)

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
                (typeToEncoder t)

        Common.Value ->
            CliMonad.succeed <| Gen.Basics.identity

        Common.Ref ref ->
            CliMonad.refToEncoder ref

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
                            (typeToAnnotationWithNullable variant.type_)
                            (typeToEncoder variant.type_)
                            |> CliMonad.withPath variant.name
                    )
                |> CliMonad.map2
                    (\importFrom branches rec ->
                        Elm.Case.custom rec
                            (Elm.Annotation.named importFrom oneOfName)
                            branches
                    )
                    (CliMonad.moduleToNamespace (Common.Types Common.Schema))

        Common.Bytes ->
            CliMonad.todo "Encoder for bytes not implemented"
                |> CliMonad.map (\encoder _ -> encoder)

        Common.Unit ->
            CliMonad.succeed (\_ -> Gen.Json.Encode.null)


basicTypeToEncoder : Common.BasicType -> { a | format : Maybe String } -> CliMonad (Elm.Expression -> Elm.Expression)
basicTypeToEncoder basicType { format } =
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
    CliMonad.withFormat basicType format .encode default


oneOfAnnotation : Common.TypeName -> List Common.OneOfData -> CliMonad Elm.Annotation.Annotation
oneOfAnnotation oneOfName oneOfData =
    CliMonad.moduleToNamespace (Common.Types Common.Schema)
        |> CliMonad.andThen
            (\importFrom ->
                Elm.Annotation.named
                    importFrom
                    oneOfName
                    |> CliMonad.succeedWith
                        (FastDict.singleton oneOfName oneOfData)
            )


typeToDecoder : Common.Type -> CliMonad Elm.Expression
typeToDecoder type_ =
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
                        (typeToDecoder field.type_ |> CliMonad.withPath key)
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
            basicTypeToDecoder basicType basic

        Common.Null ->
            CliMonad.succeed (Gen.Json.Decode.null Elm.unit)

        Common.Unit ->
            CliMonad.succeed (Gen.Json.Decode.succeed Elm.unit)

        Common.List t ->
            CliMonad.map Gen.Json.Decode.list
                (typeToDecoder t)

        Common.Dict additionalProperties [] ->
            CliMonad.map Gen.Json.Decode.dict
                (typeToDecoder additionalProperties.type_)

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
                            (typeToDecoder field.type_ |> CliMonad.withPath key)
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
                    (typeToDecoder additionalProperties.type_)

        Common.Enum variants ->
            variants
                |> NonEmpty.toList
                |> CliMonad.enumName
                |> CliMonad.andThen
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
                                    |> CliMonad.succeed

                            Just name ->
                                CliMonad.refToDecoder (Common.refTo Common.Schema name)
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
                (typeToDecoder t)

        Common.Ref ref ->
            CliMonad.refToDecoder ref

        Common.OneOf oneOfName variants ->
            variants
                |> NonEmpty.toList
                |> CliMonad.combineMap
                    (\variant ->
                        typeToDecoder variant.type_
                            |> CliMonad.map2
                                (\importFrom ->
                                    Gen.Json.Decode.call_.map
                                        (Elm.value
                                            { importFrom = importFrom
                                            , name = toVariantName oneOfName variant.name
                                            , annotation = Nothing
                                            }
                                        )
                                )
                                (CliMonad.moduleToNamespace (Common.Types Common.Schema))
                            |> CliMonad.withPath variant.name
                    )
                |> CliMonad.map2
                    (\importFrom decoders ->
                        decoders
                            |> Gen.Json.Decode.oneOf
                            |> Elm.withType (Elm.Annotation.named importFrom oneOfName)
                    )
                    (CliMonad.moduleToNamespace (Common.Types Common.Schema))

        Common.Bytes ->
            CliMonad.todo "Bytes decoder not implemented yet"


basicTypeToDecoder : Common.BasicType -> { format : Maybe String, const : Maybe Common.ConstValue } -> CliMonad Elm.Expression
basicTypeToDecoder basicType { format, const } =
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
    CliMonad.withFormat basicType format .decoder default


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
