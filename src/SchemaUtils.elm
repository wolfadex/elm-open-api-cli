module SchemaUtils exposing
    ( OneOfName
    , decodeOptionalField
    , decodeOptionalFieldDocumentation
    , getAlias
    , oneOfDeclarations
    , recordType
    , refToTypeName
    , schemaToType
    , toVariantName
    , typeToAnnotation
    , typeToAnnotationMaybe
    , typeToDecoder
    , typeToEncoder
    )

import CliMonad exposing (CliMonad)
import Common
import Dict
import Elm
import Elm.Annotation
import Elm.Case
import Elm.Declare
import Elm.Op
import Elm.ToString
import FastDict
import Gen.Basics
import Gen.Bytes
import Gen.Json.Decode
import Gen.Json.Encode
import Gen.List
import Gen.Maybe
import Json.Decode
import Json.Schema.Definitions
import Maybe.Extra
import OpenApi
import OpenApi.Components
import OpenApi.Schema
import Result.Extra
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


schemaToProperties : Bool -> List String -> Json.Schema.Definitions.Schema -> CliMonad (FastDict.Dict String Common.Field)
schemaToProperties qualify namespace allOfItem =
    case allOfItem of
        Json.Schema.Definitions.ObjectSchema allOfItemSchema ->
            CliMonad.map2 FastDict.union
                (subSchemaToProperties qualify namespace allOfItemSchema)
                (subSchemaRefToProperties qualify namespace allOfItemSchema)

        Json.Schema.Definitions.BooleanSchema _ ->
            CliMonad.todoWithDefault FastDict.empty "Boolean schema inside allOf"


subSchemaRefToProperties : Bool -> List String -> Json.Schema.Definitions.SubSchema -> CliMonad (FastDict.Dict String Common.Field)
subSchemaRefToProperties qualify namespace allOfItem =
    case allOfItem.ref of
        Nothing ->
            CliMonad.succeed FastDict.empty

        Just ref ->
            getAlias (String.split "/" ref)
                |> CliMonad.withPath ref
                |> CliMonad.andThen (schemaToProperties qualify namespace)


subSchemaToProperties : Bool -> List String -> Json.Schema.Definitions.SubSchema -> CliMonad (FastDict.Dict String Common.Field)
subSchemaToProperties qualify namespace sch =
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
                schemaToType qualify namespace valueSchema
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


schemaToType : Bool -> List String -> Json.Schema.Definitions.Schema -> CliMonad Common.Type
schemaToType qualify namespace schema =
    case schema of
        Json.Schema.Definitions.BooleanSchema _ ->
            CliMonad.todoWithDefault Common.Value "Boolean schema"

        Json.Schema.Definitions.ObjectSchema subSchema ->
            let
                nullable : CliMonad Common.Type -> CliMonad Common.Type
                nullable =
                    CliMonad.map Common.Nullable

                singleTypeToType : Json.Schema.Definitions.SingleType -> CliMonad Common.Type
                singleTypeToType singleType =
                    case singleType of
                        Json.Schema.Definitions.ObjectType ->
                            objectSchemaToType qualify namespace subSchema

                        Json.Schema.Definitions.StringType ->
                            CliMonad.succeed Common.String

                        Json.Schema.Definitions.IntegerType ->
                            CliMonad.succeed Common.Int

                        Json.Schema.Definitions.NumberType ->
                            CliMonad.succeed Common.Float

                        Json.Schema.Definitions.BooleanType ->
                            CliMonad.succeed Common.Bool

                        Json.Schema.Definitions.NullType ->
                            CliMonad.todoWithDefault Common.Value "Null type annotation"

                        Json.Schema.Definitions.ArrayType ->
                            case subSchema.items of
                                Json.Schema.Definitions.NoItems ->
                                    CliMonad.fail "Found an array type but no items definition"

                                Json.Schema.Definitions.ArrayOfItems _ ->
                                    CliMonad.todoWithDefault Common.Value "Array of items as item definition"

                                Json.Schema.Definitions.ItemDefinition itemSchema ->
                                    CliMonad.map Common.List (schemaToType qualify namespace itemSchema)

                anyOfToType : List Json.Schema.Definitions.Schema -> CliMonad Common.Type
                anyOfToType _ =
                    CliMonad.succeed Common.Value

                oneOfToType : List Json.Schema.Definitions.Schema -> CliMonad Common.Type
                oneOfToType oneOf =
                    CliMonad.combineMap (schemaToType qualify namespace) oneOf
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
                                    schemaToType qualify namespace onlySchema

                                Just [ firstSchema, secondSchema ] ->
                                    case ( firstSchema, secondSchema ) of
                                        ( Json.Schema.Definitions.ObjectSchema firstSubSchema, Json.Schema.Definitions.ObjectSchema secondSubSchema ) ->
                                            -- The first 2 cases here are for pseudo-nullable schemas where the higher level schema type is AnyOf
                                            -- but it's actually made up of only 2 types and 1 of them is nullable. This acts as a hack of sorts to
                                            -- mark a value as nullable in the schema.
                                            case ( firstSubSchema.type_, secondSubSchema.type_ ) of
                                                ( Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType, _ ) ->
                                                    nullable (schemaToType qualify namespace secondSchema)

                                                ( _, Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType ) ->
                                                    nullable (schemaToType qualify namespace firstSchema)

                                                _ ->
                                                    anyOfToType [ firstSchema, secondSchema ]

                                        _ ->
                                            anyOfToType [ firstSchema, secondSchema ]

                                Just anyOf ->
                                    anyOfToType anyOf

                                Nothing ->
                                    case subSchema.allOf of
                                        Just [ onlySchema ] ->
                                            schemaToType qualify namespace onlySchema

                                        Just [] ->
                                            CliMonad.succeed Common.Value

                                        Just _ ->
                                            -- If we have more than one item in `allOf`, then it's _probably_ an object
                                            -- TODO: improve this to actually check if all the `allOf` subschema are objects.
                                            objectSchemaToType qualify namespace subSchema

                                        Nothing ->
                                            case subSchema.oneOf of
                                                Just [ onlySchema ] ->
                                                    schemaToType qualify namespace onlySchema

                                                Just [] ->
                                                    CliMonad.succeed Common.Value

                                                Just oneOfs ->
                                                    oneOfToType oneOfs

                                                Nothing ->
                                                    case subSchema.enum of
                                                        Nothing ->
                                                            CliMonad.succeed Common.Value

                                                        Just enums ->
                                                            case
                                                                enums
                                                                    |> List.map (Json.Decode.decodeValue Json.Decode.string)
                                                                    |> Result.Extra.combine
                                                            of
                                                                Err _ ->
                                                                    CliMonad.fail "Attempted to parse an enum as a string and failed"

                                                                Ok decodedEnums ->
                                                                    CliMonad.succeed (Common.Enum decodedEnums)

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
                                    Common.Nullable res
                            )


typeToOneOfVariant : Bool -> List String -> Common.Type -> CliMonad (Maybe { name : Common.TypeName, type_ : Common.Type })
typeToOneOfVariant qualify namespace type_ =
    type_
        |> typeToAnnotation qualify namespace
        |> CliMonad.map
            (\ann ->
                let
                    rawName : Common.TypeName
                    rawName =
                        ann
                            |> Elm.ToString.annotation
                            |> .signature
                            |> Common.typifyName
                in
                if String.contains "{" rawName then
                    Nothing

                else
                    Just
                        { name = rawName
                        , type_ = type_
                        }
            )


oneOfType : List String -> List Common.Type -> CliMonad Common.Type
oneOfType namespace types =
    types
        |> CliMonad.combineMap (typeToOneOfVariant False namespace)
        |> CliMonad.map
            (\maybeVariants ->
                case Maybe.Extra.combine maybeVariants of
                    Nothing ->
                        Common.Value

                    Just variants ->
                        let
                            sortedVariants : List { name : Common.TypeName, type_ : Common.Type }
                            sortedVariants =
                                List.sortBy .name variants

                            names : List String
                            names =
                                List.map .name sortedVariants
                        in
                        Common.OneOf
                            (names
                                |> List.map fixOneOfName
                                |> String.join "_Or_"
                            )
                            sortedVariants
            )


objectSchemaToType : Bool -> List String -> Json.Schema.Definitions.SubSchema -> CliMonad Common.Type
objectSchemaToType qualify namespace subSchema =
    let
        propertiesFromAllOf : CliMonad (FastDict.Dict String Common.Field)
        propertiesFromAllOf =
            subSchema.allOf
                |> Maybe.withDefault []
                |> CliMonad.combineMap (schemaToProperties qualify namespace)
                |> CliMonad.map (List.foldl FastDict.union FastDict.empty)
    in
    CliMonad.map2
        (\schemaProps allOfProps ->
            allOfProps
                |> FastDict.union schemaProps
                |> Common.Object
        )
        (subSchemaToProperties qualify namespace subSchema)
        propertiesFromAllOf


type alias OneOfName =
    Common.TypeName


oneOfDeclarations :
    List String
    -> FastDict.Dict OneOfName Common.OneOfData
    -> CliMonad (List ( Common.Module, Elm.Declaration ))
oneOfDeclarations namespace enums =
    CliMonad.combineMap
        (oneOfDeclaration namespace)
        (FastDict.toList enums)


oneOfDeclaration :
    List String
    -> ( OneOfName, Common.OneOfData )
    -> CliMonad ( Common.Module, Elm.Declaration )
oneOfDeclaration namespace ( oneOfName, variants ) =
    let
        variantDeclaration : { name : Common.VariantName, type_ : Common.Type } -> CliMonad Elm.Variant
        variantDeclaration { name, type_ } =
            typeToAnnotation False namespace type_
                |> CliMonad.map
                    (\variantAnnotation ->
                        let
                            variantName : Common.VariantName
                            variantName =
                                toVariantName oneOfName name
                        in
                        Elm.variantWith variantName [ variantAnnotation ]
                    )
    in
    variants
        |> CliMonad.combineMap variantDeclaration
        |> CliMonad.map
            (\decl ->
                ( Common.Types
                , decl
                    |> Elm.customType oneOfName
                    |> Elm.exposeWith
                        { exposeConstructor = True
                        , group = Just "One of"
                        }
                )
            )


toVariantName : String -> String -> String
toVariantName oneOfName variantName =
    oneOfName ++ "__" ++ fixOneOfName variantName


{-| When we go from `Elm.Annotation` to `String` it includes the module name if it's an imported type.
We don't want that for our generated types, so we remove it here.
-}
fixOneOfName : String -> String
fixOneOfName name =
    name
        |> String.replace "OpenApi.Nullable" "Nullable"
        |> String.replace "." ""


typeToAnnotation : Bool -> List String -> Common.Type -> CliMonad Elm.Annotation.Annotation
typeToAnnotation qualify namespace type_ =
    case type_ of
        Common.Nullable t ->
            typeToAnnotation qualify namespace t
                |> CliMonad.map
                    (\ann ->
                        Elm.Annotation.namedWith (Common.moduleToNamespace namespace Common.Common)
                            "Nullable"
                            [ ann ]
                    )

        Common.Object fields ->
            objectToAnnotation qualify namespace { useMaybe = False } fields

        Common.String ->
            CliMonad.succeed Elm.Annotation.string

        Common.Int ->
            CliMonad.succeed Elm.Annotation.int

        Common.Float ->
            CliMonad.succeed Elm.Annotation.float

        Common.Bool ->
            CliMonad.succeed Elm.Annotation.bool

        Common.List t ->
            CliMonad.map Elm.Annotation.list (typeToAnnotation qualify namespace t)

        Common.Enum _ ->
            CliMonad.succeed Elm.Annotation.string

        Common.OneOf oneOfName oneOfData ->
            oneOfAnnotation qualify namespace oneOfName oneOfData

        Common.Value ->
            CliMonad.succeed Gen.Json.Encode.annotation_.value

        Common.Ref ref ->
            CliMonad.map
                (if qualify then
                    Elm.Annotation.named (Common.moduleToNamespace namespace Common.Types)

                 else
                    Elm.Annotation.named []
                )
                (refToTypeName ref)

        Common.Bytes ->
            CliMonad.succeed Gen.Bytes.annotation_.bytes

        Common.Unit ->
            CliMonad.succeed Elm.Annotation.unit


typeToAnnotationMaybe : Bool -> List String -> Common.Type -> CliMonad Elm.Annotation.Annotation
typeToAnnotationMaybe qualify namespace type_ =
    case type_ of
        Common.Nullable t ->
            CliMonad.map Elm.Annotation.maybe (typeToAnnotationMaybe qualify namespace t)

        Common.Object fields ->
            objectToAnnotation qualify namespace { useMaybe = True } fields

        Common.String ->
            CliMonad.succeed Elm.Annotation.string

        Common.Int ->
            CliMonad.succeed Elm.Annotation.int

        Common.Float ->
            CliMonad.succeed Elm.Annotation.float

        Common.Bool ->
            CliMonad.succeed Elm.Annotation.bool

        Common.List t ->
            CliMonad.map Elm.Annotation.list (typeToAnnotationMaybe qualify namespace t)

        Common.Enum _ ->
            CliMonad.succeed Elm.Annotation.string

        Common.OneOf oneOfName oneOfData ->
            oneOfAnnotation qualify namespace oneOfName oneOfData

        Common.Value ->
            CliMonad.succeed Gen.Json.Encode.annotation_.value

        Common.Ref ref ->
            CliMonad.map
                (if qualify then
                    Elm.Annotation.named (Common.moduleToNamespace namespace Common.Types)

                 else
                    Elm.Annotation.named []
                )
                (refToTypeName ref)

        Common.Bytes ->
            CliMonad.succeed Gen.Bytes.annotation_.bytes

        Common.Unit ->
            CliMonad.succeed Elm.Annotation.unit


objectToAnnotation : Bool -> List String -> { useMaybe : Bool } -> Common.Object -> CliMonad Elm.Annotation.Annotation
objectToAnnotation qualify namespace config fields =
    FastDict.toList fields
        |> CliMonad.combineMap (\( k, v ) -> CliMonad.map (Tuple.pair (Common.toValueName k)) (fieldToAnnotation qualify namespace config v))
        |> CliMonad.map recordType


recordType : List ( String, Elm.Annotation.Annotation ) -> Elm.Annotation.Annotation
recordType fields =
    fields
        |> List.map (Tuple.mapFirst Common.toValueName)
        |> Elm.Annotation.record


fieldToAnnotation : Bool -> List String -> { useMaybe : Bool } -> Common.Field -> CliMonad Elm.Annotation.Annotation
fieldToAnnotation qualify namespace { useMaybe } { type_, required } =
    let
        annotation : CliMonad Elm.Annotation.Annotation
        annotation =
            if useMaybe then
                typeToAnnotationMaybe qualify namespace type_

            else
                typeToAnnotation qualify namespace type_
    in
    if required then
        annotation

    else
        CliMonad.map Gen.Maybe.annotation_.maybe annotation


typeToEncoder : Bool -> List String -> Common.Type -> CliMonad (Elm.Expression -> Elm.Expression)
typeToEncoder qualify namespace type_ =
    case type_ of
        Common.String ->
            CliMonad.succeed Gen.Json.Encode.call_.string

        Common.Int ->
            CliMonad.succeed Gen.Json.Encode.call_.int

        Common.Float ->
            CliMonad.succeed Gen.Json.Encode.call_.float

        Common.Bool ->
            CliMonad.succeed Gen.Json.Encode.call_.bool

        Common.Enum constructors ->
            CliMonad.succeed
                (\expr ->
                    Elm.Case.string
                        expr
                        { cases =
                            List.map
                                (\constructor ->
                                    ( constructor, Gen.Json.Encode.values_.string )
                                )
                                constructors
                        , otherwise = Gen.Json.Encode.call_.string expr
                        }
                )

        Common.Object properties ->
            let
                propertiesList : List ( Common.FieldName, Common.Field )
                propertiesList =
                    FastDict.toList properties

                allRequired : Bool
                allRequired =
                    List.all (\( _, { required } ) -> required) propertiesList
            in
            propertiesList
                |> CliMonad.combineMap
                    (\( key, field ) ->
                        typeToEncoder qualify namespace field.type_
                            |> CliMonad.map
                                (\encoder rec ->
                                    let
                                        fieldExpr : Elm.Expression
                                        fieldExpr =
                                            Elm.get (Common.toValueName key) rec

                                        toTuple : Elm.Expression -> Elm.Expression
                                        toTuple value =
                                            Elm.tuple
                                                (Elm.string key)
                                                (encoder value)
                                    in
                                    if allRequired then
                                        toTuple fieldExpr

                                    else if field.required then
                                        Gen.Maybe.make_.just (toTuple fieldExpr)

                                    else
                                        Gen.Maybe.map toTuple fieldExpr
                                )
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
            typeToEncoder qualify namespace t
                |> CliMonad.map
                    (\encoder ->
                        Gen.Json.Encode.call_.list (Elm.functionReduced "rec" encoder)
                    )

        Common.Nullable t ->
            typeToEncoder qualify namespace t
                |> CliMonad.map
                    (\encoder nullableValue ->
                        Elm.Case.custom
                            nullableValue
                            (Elm.Annotation.namedWith (Common.moduleToNamespace namespace Common.Common) "Nullable" [ Elm.Annotation.var "value" ])
                            [ Elm.Case.branch0 "Null" Gen.Json.Encode.null
                            , Elm.Case.branch1 "Present"
                                ( "value", Elm.Annotation.var "value" )
                                encoder
                            ]
                    )

        Common.Value ->
            CliMonad.succeed <| Gen.Basics.identity

        Common.Ref ref ->
            CliMonad.map
                (\name rec ->
                    Elm.apply
                        (Elm.value
                            { importFrom =
                                if qualify then
                                    Common.moduleToNamespace namespace Common.Json

                                else
                                    []
                            , name = "encode" ++ name
                            , annotation = Nothing
                            }
                        )
                        [ rec ]
                )
                (refToTypeName ref)

        Common.OneOf oneOfName oneOfData ->
            oneOfData
                |> CliMonad.combineMap
                    (\variant ->
                        CliMonad.map2
                            (\ann variantEncoder ->
                                Elm.Case.branch1 (toVariantName oneOfName variant.name)
                                    ( "content", ann )
                                    variantEncoder
                            )
                            (typeToAnnotation True namespace variant.type_)
                            (typeToEncoder qualify namespace variant.type_)
                    )
                |> CliMonad.map
                    (\branches rec ->
                        Elm.Case.custom rec
                            (Elm.Annotation.named (Common.moduleToNamespace namespace Common.Types) oneOfName)
                            branches
                    )

        Common.Bytes ->
            CliMonad.todo "encoder for bytes not implemented"
                |> CliMonad.map (\encoder _ -> encoder)

        Common.Unit ->
            CliMonad.succeed (\_ -> Gen.Json.Encode.null)


oneOfAnnotation : Bool -> List String -> Common.TypeName -> Common.OneOfData -> CliMonad Elm.Annotation.Annotation
oneOfAnnotation qualify namespace oneOfName oneOfData =
    Elm.Annotation.named
        (if qualify then
            Common.moduleToNamespace namespace Common.Types

         else
            []
        )
        oneOfName
        |> CliMonad.succeedWith
            (FastDict.singleton oneOfName oneOfData)


refToTypeName : List String -> CliMonad Common.TypeName
refToTypeName ref =
    case ref of
        [ "#", "components", _, name ] ->
            CliMonad.succeed (Common.typifyName name)

        _ ->
            CliMonad.fail <| "Couldn't get the type ref (" ++ String.join "/" ref ++ ") for the response"


typeToDecoder : Bool -> List String -> Common.Type -> CliMonad Elm.Expression
typeToDecoder qualify namespace type_ =
    case type_ of
        Common.Object properties ->
            let
                propertiesList : List ( String, Common.Field )
                propertiesList =
                    FastDict.toList properties
            in
            List.foldl
                (\( key, field ) prevExprRes ->
                    CliMonad.map2
                        (\internalDecoder prevExpr ->
                            Elm.Op.pipe
                                (Elm.apply
                                    (Elm.value
                                        { importFrom = Common.moduleToNamespace namespace Common.Common
                                        , name = "jsonDecodeAndMap"
                                        , annotation = Nothing
                                        }
                                    )
                                    [ if field.required then
                                        Gen.Json.Decode.field key internalDecoder

                                      else
                                        decodeOptionalField.callFrom
                                            (Common.moduleToNamespace namespace Common.Common)
                                            (Elm.string key)
                                            internalDecoder
                                    ]
                                )
                                prevExpr
                        )
                        (typeToDecoder qualify namespace field.type_)
                        prevExprRes
                )
                (CliMonad.succeed
                    (Gen.Json.Decode.succeed
                        (Elm.function
                            (List.map (\( key, _ ) -> ( Common.toValueName key, Nothing )) propertiesList)
                            (\args ->
                                Elm.record
                                    (List.map2
                                        (\( key, _ ) arg -> ( Common.toValueName key, arg ))
                                        propertiesList
                                        args
                                    )
                            )
                        )
                    )
                )
                propertiesList

        Common.String ->
            CliMonad.succeed Gen.Json.Decode.string

        Common.Int ->
            CliMonad.succeed Gen.Json.Decode.int

        Common.Float ->
            CliMonad.succeed Gen.Json.Decode.float

        Common.Bool ->
            CliMonad.succeed Gen.Json.Decode.bool

        Common.Unit ->
            CliMonad.succeed (Gen.Json.Decode.succeed Elm.unit)

        Common.List t ->
            CliMonad.map Gen.Json.Decode.list
                (typeToDecoder qualify namespace t)

        Common.Enum constructors ->
            CliMonad.succeed
                (Gen.Json.Decode.andThen
                    (\enumStr ->
                        Elm.Case.string enumStr
                            { cases =
                                List.map
                                    (\constructor ->
                                        ( constructor, Gen.Json.Decode.succeed enumStr )
                                    )
                                    constructors
                            , otherwise = Gen.Json.Decode.fail "Unknown enum"
                            }
                    )
                    Gen.Json.Decode.string
                )

        Common.Value ->
            CliMonad.succeed Gen.Json.Decode.value

        Common.Nullable t ->
            CliMonad.map
                (\decoder ->
                    Gen.Json.Decode.oneOf
                        [ Gen.Json.Decode.call_.map
                            (Elm.value
                                { importFrom = Common.moduleToNamespace namespace Common.Common
                                , name = "Present"
                                , annotation = Nothing
                                }
                            )
                            decoder
                        , Gen.Json.Decode.null
                            (Elm.value
                                { importFrom = Common.moduleToNamespace namespace Common.Common
                                , name = "Null"
                                , annotation = Nothing
                                }
                            )
                        ]
                )
                (typeToDecoder qualify namespace t)

        Common.Ref ref ->
            CliMonad.map
                (\name ->
                    Elm.value
                        { importFrom =
                            if qualify then
                                Common.moduleToNamespace namespace Common.Json

                            else
                                []
                        , name = "decode" ++ name
                        , annotation = Nothing
                        }
                )
                (refToTypeName ref)

        Common.OneOf oneOfName variants ->
            variants
                |> CliMonad.combineMap
                    (\variant ->
                        typeToDecoder qualify namespace variant.type_
                            |> CliMonad.map
                                (Gen.Json.Decode.call_.map
                                    (Elm.value
                                        { importFrom = Common.moduleToNamespace namespace Common.Types
                                        , name = toVariantName oneOfName variant.name
                                        , annotation = Nothing
                                        }
                                    )
                                )
                    )
                |> CliMonad.map
                    (\decoders ->
                        decoders
                            |> Gen.Json.Decode.oneOf
                            |> Elm.withType (Elm.Annotation.named (Common.moduleToNamespace namespace Common.Types) oneOfName)
                    )

        Common.Bytes ->
            CliMonad.todo "Bytes decoder not implemented yet"


{-| Decode an optional field

    decodeString (decodeOptionalField "x" int) "{ \"x\": 3 }"
    --> Ok (Just 3)

    decodeString (decodeOptionalField "x" int) "{ \"x\": true }"
    --> Err ...

    decodeString (decodeOptionalField "x" int) "{ \"y\": 4 }"
    --> Ok Nothing

-}
decodeOptionalField :
    { declaration : Elm.Declaration
    , call : Elm.Expression -> Elm.Expression -> Elm.Expression
    , callFrom : List String -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , value : List String -> Elm.Expression
    }
decodeOptionalField =
    let
        decoderAnnotation : Elm.Annotation.Annotation
        decoderAnnotation =
            Gen.Json.Decode.annotation_.decoder (Elm.Annotation.var "t")

        resultAnnotation : Elm.Annotation.Annotation
        resultAnnotation =
            Gen.Json.Decode.annotation_.decoder (Gen.Maybe.annotation_.maybe <| Elm.Annotation.var "t")
    in
    Elm.Declare.fn2 "decodeOptionalField"
        ( "key", Just Elm.Annotation.string )
        ( "fieldDecoder", Just decoderAnnotation )
    <|
        \key fieldDecoder ->
            -- The tricky part is that we want to make sure that
            -- if the field exists we error out if it has an incorrect shape.
            -- So what we do is we `oneOf` with `value` to avoid the `Nothing` branch,
            -- `andThen` we decode it. This is why we can't just use `maybe`, we would
            -- give `Nothing` when the shape is wrong.
            Gen.Json.Decode.oneOf
                [ Gen.Json.Decode.call_.map
                    (Elm.fn ( "_", Nothing ) <| \_ -> Elm.bool True)
                    (Gen.Json.Decode.call_.field key Gen.Json.Decode.value)
                , Gen.Json.Decode.succeed (Elm.bool False)
                ]
                |> Gen.Json.Decode.andThen
                    (\hasField ->
                        Elm.ifThen hasField
                            (Gen.Json.Decode.call_.field key
                                (Gen.Json.Decode.oneOf
                                    [ Gen.Json.Decode.map Gen.Maybe.make_.just fieldDecoder
                                    , Gen.Json.Decode.null Gen.Maybe.make_.nothing
                                    ]
                                )
                            )
                            (Gen.Json.Decode.succeed Gen.Maybe.make_.nothing)
                    )
                |> Elm.withType resultAnnotation


decodeOptionalFieldDocumentation : String
decodeOptionalFieldDocumentation =
    """Decode an optional field

    decodeString (decodeOptionalField "x" int) "{ "x": 3 }"
    --> Ok (Just 3)

    decodeString (decodeOptionalField "x" int) "{ "x": true }"
    --> Err ...

    decodeString (decodeOptionalField "x" int) "{ "y": 4 }"
    --> Ok Nothing"""
