module CliMonad exposing
    ( CliMonad
    , Message
    , Path
    , andThen
    , andThen2
    , combine
    , combineDict
    , combineMap
    , decodeOptionalField
    , errorToWarning
    , fail
    , fixOneOfName
    , fromApiSpec
    , map
    , map2
    , map3
    , recordType
    , refToTypeName
    , run
    , stepOrFail
    , succeed
    , toVariantName
    , todoWithDefault
    , typeToAnnotation
    , typeToAnnotationMaybe
    , typeToDecoder
    , typeToEncoder
    , withPath
    , withWarning
    )

import Common
import Dict
import Elm
import Elm.Annotation
import Elm.Case
import Elm.Declare
import Elm.Op
import FastDict
import Gen.Basics
import Gen.Bytes
import Gen.Debug
import Gen.Json.Decode
import Gen.Json.Encode
import Gen.List
import Gen.Maybe
import OpenApi exposing (OpenApi)


type alias Message =
    { message : String
    , path : Path
    }


type alias Path =
    List String


type alias OneOfName =
    Common.TypeName


type CliMonad a
    = CliMonad
        ({ openApi : OpenApi, generateTodos : Bool }
         ->
            Result
                Message
                ( a
                , List Message
                , FastDict.Dict OneOfName Common.OneOfData
                )
        )


withPath : String -> CliMonad a -> CliMonad a
withPath segment (CliMonad f) =
    CliMonad
        (\inputs ->
            case f inputs of
                Err message ->
                    Err (addPath segment message)

                Ok ( res, warns, enums ) ->
                    Ok ( res, List.map (addPath segment) warns, enums )
        )


addPath : String -> Message -> Message
addPath segment { path, message } =
    { path = segment :: path
    , message = message
    }


withWarning : String -> CliMonad a -> CliMonad a
withWarning message (CliMonad f) =
    CliMonad
        (\inputs ->
            Result.map
                (\( res, warnings, enums ) -> ( res, { path = [], message = message } :: warnings, enums ))
                (f inputs)
        )


todo : String -> CliMonad Elm.Expression
todo message =
    todoWithDefault (Gen.Debug.todo message) message


todoWithDefault : a -> String -> CliMonad a
todoWithDefault default message =
    CliMonad
        (\{ generateTodos } ->
            if generateTodos then
                Ok ( default, [ { path = [], message = message } ], FastDict.empty )

            else
                Err
                    { path = []
                    , message = "Todo: " ++ message
                    }
        )


fail : String -> CliMonad a
fail message =
    CliMonad (\_ -> Err { path = [], message = message })


succeed : a -> CliMonad a
succeed x =
    CliMonad (\_ -> Ok ( x, [], FastDict.empty ))


map : (a -> b) -> CliMonad a -> CliMonad b
map f (CliMonad x) =
    CliMonad (\input -> Result.map (\( xr, xw, xm ) -> ( f xr, xw, xm )) (x input))


map2 : (a -> b -> c) -> CliMonad a -> CliMonad b -> CliMonad c
map2 f (CliMonad x) (CliMonad y) =
    CliMonad (\input -> Result.map2 (\( xr, xw, xm ) ( yr, yw, ym ) -> ( f xr yr, xw ++ yw, FastDict.union xm ym )) (x input) (y input))


map3 : (a -> b -> c -> d) -> CliMonad a -> CliMonad b -> CliMonad c -> CliMonad d
map3 f (CliMonad x) (CliMonad y) (CliMonad z) =
    CliMonad (\input -> Result.map3 (\( xr, xw, xm ) ( yr, yw, ym ) ( zr, zw, zm ) -> ( f xr yr zr, xw ++ yw ++ zw, FastDict.union (FastDict.union xm ym) zm )) (x input) (y input) (z input))


andThen : (a -> CliMonad b) -> CliMonad a -> CliMonad b
andThen f (CliMonad x) =
    CliMonad
        (\input ->
            Result.andThen
                (\( y, yw, ym ) ->
                    let
                        (CliMonad z) =
                            f y
                    in
                    z input
                        |> Result.map (\( w, ww, wm ) -> ( w, yw ++ ww, FastDict.union ym wm ))
                )
                (x input)
        )


andThen2 : (a -> b -> CliMonad c) -> CliMonad a -> CliMonad b -> CliMonad c
andThen2 f x y =
    x
        |> andThen
            (\xr ->
                y
                    |> andThen (\yr -> f xr yr)
            )


{-| Runs the transformation from OpenApi to declaration.

Automatically appends the needed `enum` declarations.

-}
run : List String -> { openApi : OpenApi, generateTodos : Bool } -> CliMonad (List Elm.Declaration) -> Result Message ( List Elm.Declaration, List Message )
run namespace input (CliMonad x) =
    x input
        |> Result.andThen
            (\( decls, warnings, oneOfs ) ->
                let
                    (CliMonad h) =
                        oneOfDeclarations namespace oneOfs |> withPath "While generating `oneOf`s"
                in
                h input
                    |> Result.map
                        (\( enumDecls, enumWarnings, _ ) ->
                            ( decls ++ enumDecls
                            , (enumWarnings ++ warnings)
                                |> List.reverse
                            )
                        )
            )


oneOfDeclarations :
    List String
    -> FastDict.Dict OneOfName Common.OneOfData
    -> CliMonad (List Elm.Declaration)
oneOfDeclarations namespace enums =
    combineMap
        (oneOfDeclaration namespace)
        (FastDict.toList enums)


oneOfDeclaration :
    List String
    -> ( OneOfName, Common.OneOfData )
    -> CliMonad Elm.Declaration
oneOfDeclaration namespace ( oneOfName, variants ) =
    let
        variantDeclaration : { name : Common.VariantName, type_ : Common.Type } -> CliMonad Elm.Variant
        variantDeclaration { name, type_ } =
            typeToAnnotation namespace type_
                |> map
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
        |> combineMap variantDeclaration
        |> map
            (Elm.customType oneOfName
                >> Elm.exposeWith
                    { exposeConstructor = True
                    , group = Just "Types"
                    }
            )


combineMap : (a -> CliMonad b) -> List a -> CliMonad (List b)
combineMap f ls =
    combine (List.map f ls)


combine : List (CliMonad a) -> CliMonad (List a)
combine =
    List.foldr (map2 (::)) (succeed [])


fromApiSpec : (OpenApi -> a) -> CliMonad a
fromApiSpec f =
    CliMonad (\input -> Ok ( f input.openApi, [], FastDict.empty ))


errorToWarning : CliMonad a -> CliMonad (Maybe a)
errorToWarning (CliMonad f) =
    CliMonad
        (\input ->
            case f input of
                Ok ( res, warns, enums ) ->
                    Ok ( Just res, warns, enums )

                Err { path, message } ->
                    Ok ( Nothing, [ { path = path, message = message } ], FastDict.empty )
        )


objectToAnnotation : List String -> { useMaybe : Bool } -> Common.Object -> CliMonad Elm.Annotation.Annotation
objectToAnnotation namespace config fields =
    FastDict.toList fields
        |> combineMap (\( k, v ) -> map (Tuple.pair (Common.toValueName k)) (fieldToAnnotation namespace config v))
        |> map recordType


fieldToAnnotation : List String -> { useMaybe : Bool } -> Common.Field -> CliMonad Elm.Annotation.Annotation
fieldToAnnotation namespace { useMaybe } { type_, required } =
    let
        annotation : CliMonad Elm.Annotation.Annotation
        annotation =
            if useMaybe then
                typeToAnnotationMaybe namespace type_

            else
                typeToAnnotation namespace type_
    in
    if required then
        annotation

    else
        map Gen.Maybe.annotation_.maybe annotation


recordType : List ( String, Elm.Annotation.Annotation ) -> Elm.Annotation.Annotation
recordType fields =
    fields
        |> List.map (Tuple.mapFirst Common.toValueName)
        |> Elm.Annotation.record


typeToAnnotation : List String -> Common.Type -> CliMonad Elm.Annotation.Annotation
typeToAnnotation namespace type_ =
    case type_ of
        Common.Nullable t ->
            typeToAnnotation namespace t
                |> map
                    (\ann ->
                        Elm.Annotation.namedWith (namespace ++ [ "OpenApi" ])
                            "Nullable"
                            [ ann ]
                    )

        Common.Object fields ->
            objectToAnnotation namespace { useMaybe = False } fields

        Common.String ->
            succeed Elm.Annotation.string

        Common.Int ->
            succeed Elm.Annotation.int

        Common.Float ->
            succeed Elm.Annotation.float

        Common.Bool ->
            succeed Elm.Annotation.bool

        Common.List t ->
            map Elm.Annotation.list (typeToAnnotation namespace t)

        Common.OneOf oneOfName oneOfData ->
            oneOfAnnotation oneOfName oneOfData

        Common.Value ->
            succeed Gen.Json.Encode.annotation_.value

        Common.Ref ref ->
            map (Elm.Annotation.named []) (refToTypeName ref)

        Common.Bytes ->
            succeed Gen.Bytes.annotation_.bytes

        Common.Unit ->
            succeed Elm.Annotation.unit


typeToAnnotationMaybe : List String -> Common.Type -> CliMonad Elm.Annotation.Annotation
typeToAnnotationMaybe namespace type_ =
    case type_ of
        Common.Nullable t ->
            map Elm.Annotation.maybe (typeToAnnotationMaybe namespace t)

        Common.Object fields ->
            objectToAnnotation namespace { useMaybe = True } fields

        Common.String ->
            succeed Elm.Annotation.string

        Common.Int ->
            succeed Elm.Annotation.int

        Common.Float ->
            succeed Elm.Annotation.float

        Common.Bool ->
            succeed Elm.Annotation.bool

        Common.List t ->
            map Elm.Annotation.list (typeToAnnotationMaybe namespace t)

        Common.OneOf oneOfName oneOfData ->
            oneOfAnnotation oneOfName oneOfData

        Common.Value ->
            succeed Gen.Json.Encode.annotation_.value

        Common.Ref ref ->
            map (Elm.Annotation.named []) (refToTypeName ref)

        Common.Bytes ->
            succeed Gen.Bytes.annotation_.bytes

        Common.Unit ->
            succeed Elm.Annotation.unit


oneOfAnnotation : Common.TypeName -> Common.OneOfData -> CliMonad Elm.Annotation.Annotation
oneOfAnnotation oneOfName oneOfData =
    CliMonad
        (\_ ->
            Ok
                ( Elm.Annotation.named [] oneOfName
                , []
                , FastDict.singleton oneOfName oneOfData
                )
        )


{-| When we go from `Elm.Annotation` to `String` it includes the module name if it's an imported type.
We don't want that for our generated types, so we remove it here.
-}
fixOneOfName : String -> String
fixOneOfName name =
    name
        |> String.replace "OpenApi.Nullable" "Nullable"
        |> String.replace "." ""


toVariantName : String -> String -> String
toVariantName oneOfName variantName =
    oneOfName ++ "__" ++ fixOneOfName variantName


stepOrFail : String -> (a -> Maybe value) -> CliMonad a -> CliMonad value
stepOrFail msg f =
    andThen
        (\y ->
            case f y of
                Just z ->
                    succeed z

                Nothing ->
                    fail msg
        )


refToTypeName : List String -> CliMonad Common.TypeName
refToTypeName ref =
    case ref of
        [ "#", "components", _, name ] ->
            succeed (Common.typifyName name)

        _ ->
            fail <| "Couldn't get the type ref (" ++ String.join "/" ref ++ ") for the response"


combineDict : Dict.Dict comparable (CliMonad a) -> CliMonad (Dict.Dict comparable a)
combineDict dict =
    dict
        |> Dict.foldr
            (\k vcm rescm ->
                map2
                    (\v res ->
                        ( k, v ) :: res
                    )
                    vcm
                    rescm
            )
            (succeed [])
        |> map Dict.fromList


typeToDecoder : List String -> Common.Type -> CliMonad Elm.Expression
typeToDecoder namespace type_ =
    case type_ of
        Common.Object properties ->
            let
                propertiesList : List ( String, Common.Field )
                propertiesList =
                    FastDict.toList properties
            in
            List.foldl
                (\( key, field ) prevExprRes ->
                    map2
                        (\internalDecoder prevExpr ->
                            Elm.Op.pipe
                                (Elm.apply
                                    (Elm.value
                                        { importFrom = namespace ++ [ "OpenApi" ]
                                        , name = "jsonDecodeAndMap"
                                        , annotation = Nothing
                                        }
                                    )
                                    [ if field.required then
                                        Gen.Json.Decode.field key internalDecoder

                                      else
                                        decodeOptionalField.callFrom (namespace ++ [ "OpenApi" ]) (Elm.string key) internalDecoder
                                    ]
                                )
                                prevExpr
                        )
                        (typeToDecoder namespace field.type_)
                        prevExprRes
                )
                (succeed
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
            succeed Gen.Json.Decode.string

        Common.Int ->
            succeed Gen.Json.Decode.int

        Common.Float ->
            succeed Gen.Json.Decode.float

        Common.Bool ->
            succeed Gen.Json.Decode.bool

        Common.Unit ->
            succeed (Gen.Json.Decode.succeed Elm.unit)

        Common.List t ->
            map Gen.Json.Decode.list
                (typeToDecoder namespace t)

        Common.Value ->
            succeed Gen.Json.Decode.value

        Common.Nullable t ->
            map
                (\decoder ->
                    Gen.Json.Decode.oneOf
                        [ Gen.Json.Decode.call_.map
                            (Elm.value
                                { importFrom = namespace ++ [ "OpenApi" ]
                                , name = "Present"
                                , annotation = Nothing
                                }
                            )
                            decoder
                        , Gen.Json.Decode.null
                            (Elm.value
                                { importFrom = namespace ++ [ "OpenApi" ]
                                , name = "Null"
                                , annotation = Nothing
                                }
                            )
                        ]
                )
                (typeToDecoder namespace t)

        Common.Ref ref ->
            map (\name -> Elm.val ("decode" ++ name)) (refToTypeName ref)

        Common.OneOf oneOfName variants ->
            variants
                |> combineMap
                    (\variant ->
                        typeToDecoder namespace variant.type_
                            |> map
                                (Gen.Json.Decode.call_.map
                                    (Elm.val
                                        (toVariantName oneOfName variant.name)
                                    )
                                )
                    )
                |> map
                    (Gen.Json.Decode.oneOf
                        >> Elm.withType (Elm.Annotation.named [] oneOfName)
                    )

        Common.Bytes ->
            todo "Bytes decoder not implemented yet"


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


typeToEncoder : List String -> Common.Type -> CliMonad (Elm.Expression -> Elm.Expression)
typeToEncoder namespace type_ =
    case type_ of
        Common.String ->
            succeed Gen.Json.Encode.call_.string

        Common.Int ->
            succeed Gen.Json.Encode.call_.int

        Common.Float ->
            succeed Gen.Json.Encode.call_.float

        Common.Bool ->
            succeed Gen.Json.Encode.call_.bool

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
                |> combineMap
                    (\( key, field ) ->
                        typeToEncoder namespace field.type_
                            |> map
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
                |> map
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
            typeToEncoder namespace t
                |> map
                    (\encoder ->
                        Gen.Json.Encode.call_.list (Elm.functionReduced "rec" encoder)
                    )

        Common.Nullable t ->
            typeToEncoder namespace t
                |> map
                    (\encoder nullableValue ->
                        Elm.Case.custom
                            nullableValue
                            (Elm.Annotation.namedWith (namespace ++ [ "OpenApi" ]) "Nullable" [ Elm.Annotation.var "value" ])
                            [ Elm.Case.branch0 "Null" Gen.Json.Encode.null
                            , Elm.Case.branch1 "Present"
                                ( "value", Elm.Annotation.var "value" )
                                encoder
                            ]
                    )

        Common.Value ->
            succeed <| Gen.Basics.identity

        Common.Ref ref ->
            map (\name rec -> Elm.apply (Elm.val ("encode" ++ name)) [ rec ]) (refToTypeName ref)

        Common.OneOf oneOfName oneOfData ->
            oneOfData
                |> combineMap
                    (\variant ->
                        map2
                            (\ann variantEncoder ->
                                Elm.Case.branch1 (toVariantName oneOfName variant.name)
                                    ( "content", ann )
                                    variantEncoder
                            )
                            (typeToAnnotation namespace variant.type_)
                            (typeToEncoder namespace variant.type_)
                    )
                |> map
                    (\branches rec ->
                        Elm.Case.custom rec
                            (Elm.Annotation.named [] oneOfName)
                            branches
                    )

        Common.Bytes ->
            todo "encoder for bytes not implemented"
                |> map (\encoder _ -> encoder)

        Common.Unit ->
            succeed (\_ -> Gen.Json.Encode.null)
