module CliMonad exposing
    ( CliMonad, Message, OneOfName, Path, Declaration
    , run, stepOrFail
    , succeed, succeedWith, fail
    , map, map2, map3
    , andThen, andThen2, andThen3, andThen4, combine, combineDict, combineMap, foldl
    , errorToWarning, getApiSpec, enumName, moduleToNamespace, getOrCache
    , withPath, withWarning, withExtendedWarning, withRequiredPackage
    , todo, todoWithDefault
    , withFormat
    )

{-|

@docs CliMonad, Message, OneOfName, Path, Declaration
@docs run, stepOrFail
@docs succeed, succeedWith, fail
@docs map, map2, map3
@docs andThen, andThen2, andThen3, andThen4, combine, combineDict, combineMap, foldl
@docs errorToWarning, getApiSpec, enumName, moduleToNamespace, getOrCache
@docs withPath, withWarning, withExtendedWarning, withRequiredPackage
@docs todo, todoWithDefault
@docs withFormat

-}

import Common
import Dict
import Elm
import Elm.Annotation
import FastDict
import FastSet
import Gen.Debug
import Gen.Json.Decode
import Gen.Json.Encode
import Json.Encode
import OpenApi exposing (OpenApi)
import OpenApi.Config
import String.Extra


type alias Message =
    { message : String
    , path : Path
    , details : List String
    }


type alias Path =
    List String


type alias OneOfName =
    Common.TypeName


{-| The first String is the `type`, the second the `format`.
-}
type alias InternalFormatName =
    ( String, String )


type alias InternalFormat =
    { encode : Elm.Expression -> Elm.Expression
    , decoder : Elm.Expression
    , toParamString : Elm.Expression -> Elm.Expression
    , annotation : Elm.Annotation.Annotation
    , sharedDeclarations : List ( String, { value : Elm.Expression, group : String } )
    , requiresPackages : List String
    , example : Json.Encode.Value
    }


type alias Input =
    { openApi : OpenApi
    , generateTodos : Bool
    , enums : FastDict.Dict (List String) { name : Common.UnsafeName, documentation : Maybe String }
    , namespace : List String
    , formats : FastDict.Dict InternalFormatName InternalFormat
    , warnOnMissingEnums : Bool
    }


type CliMonad a
    = CliMonad
        (Input
         -> FastDict.Dict (List String) Common.Type
         -> Result Message ( a, Output, FastDict.Dict (List String) Common.Type )
        )


type alias Output =
    { warnings : List Message
    , oneOfs : FastDict.Dict OneOfName (List Common.OneOfData)
    , requiredPackages : FastSet.Set String
    , sharedDeclarations : FastDict.Dict String { value : Elm.Expression, group : String }
    }


type alias Declaration =
    { moduleName : Common.Module
    , name : String
    , declaration : Elm.Declaration
    , group : String
    }


{-| Runs the transformation from OpenApi to declaration.

Automatically appends the needed `oneOf` declarations.

-}
run :
    (FastDict.Dict OneOfName (List Common.OneOfData) -> CliMonad (List Declaration))
    ->
        { openApi : OpenApi
        , generateTodos : Bool
        , enums : FastDict.Dict (List String) { name : Common.UnsafeName, documentation : Maybe String }
        , namespace : List String
        , formats : List OpenApi.Config.Format
        , warnOnMissingEnums : Bool
        }
    -> CliMonad (List Declaration)
    ->
        Result
            Message
            { declarations : List Declaration
            , warnings : List Message
            , requiredPackages : FastSet.Set String
            }
run oneOfDeclarations input (CliMonad x) =
    let
        internalInput : Input
        internalInput =
            { openApi = input.openApi
            , generateTodos = input.generateTodos
            , enums = input.enums
            , namespace = input.namespace
            , formats =
                input.formats
                    |> List.map toInternalFormat
                    |> FastDict.fromList
            , warnOnMissingEnums = input.warnOnMissingEnums
            }

        res =
            x internalInput FastDict.empty
    in
    res
        |> Result.andThen
            (\( decls, output, cache ) ->
                let
                    (CliMonad h) =
                        oneOfDeclarations output.oneOfs
                            |> withPath (Common.UnsafeName "While generating `oneOf`s")

                    declarationsForFormats : Output -> List Declaration
                    declarationsForFormats out =
                        out.sharedDeclarations
                            |> FastDict.toList
                            |> List.map
                                (\( name, { value, group } ) ->
                                    { moduleName = Common.Common
                                    , name = name
                                    , declaration = Elm.expose (Elm.declaration name value)
                                    , group = group
                                    }
                                )
                in
                h internalInput cache
                    |> Result.map
                        (\( oneOfDecls, oneOfOutput, _ ) ->
                            { declarations = decls ++ oneOfDecls ++ declarationsForFormats output ++ declarationsForFormats oneOfOutput
                            , warnings =
                                (oneOfOutput.warnings ++ output.warnings)
                                    |> List.reverse
                            , requiredPackages = FastSet.union output.requiredPackages oneOfOutput.requiredPackages
                            }
                        )
            )


getOrCache : List String -> (() -> CliMonad Common.Type) -> CliMonad Common.Type
getOrCache key compute =
    CliMonad
        (\input cache ->
            case FastDict.get key cache of
                Nothing ->
                    let
                        (CliMonad inner) =
                            compute ()
                    in
                    case inner input cache of
                        Ok ( computed, output, cache2 ) ->
                            Ok ( computed, output, FastDict.insert key computed cache2 )

                        Err e ->
                            Err e

                Just found ->
                    Ok ( found, emptyOutput, cache )
        )


emptyOutput : Output
emptyOutput =
    { warnings = []
    , oneOfs = FastDict.empty
    , requiredPackages = FastSet.empty
    , sharedDeclarations = FastDict.empty
    }


withPath : Common.UnsafeName -> CliMonad a -> CliMonad a
withPath segment (CliMonad f) =
    CliMonad
        (\input cache ->
            case f input cache of
                Err message ->
                    Err (addPath segment message)

                Ok ( res, output, cache2 ) ->
                    Ok ( res, { output | warnings = List.map (addPath segment) output.warnings }, cache2 )
        )


addPath : Common.UnsafeName -> Message -> Message
addPath (Common.UnsafeName segment) { path, message, details } =
    { path = segment :: path
    , message = message
    , details = details
    }


withWarning : String -> CliMonad a -> CliMonad a
withWarning message (CliMonad f) =
    CliMonad
        (\input cache ->
            Result.map
                (\( res, output, cache2 ) ->
                    ( res
                    , { output | warnings = { path = [], message = message, details = [] } :: output.warnings }
                    , cache2
                    )
                )
                (f input cache)
        )


withExtendedWarning : { message : String, details : List String } -> CliMonad a -> CliMonad a
withExtendedWarning { message, details } (CliMonad f) =
    CliMonad
        (\input cache ->
            Result.map
                (\( res, output, cache2 ) ->
                    ( res
                    , { output | warnings = { path = [], message = message, details = details } :: output.warnings }
                    , cache2
                    )
                )
                (f input cache)
        )


todo : String -> CliMonad Elm.Expression
todo message =
    todoWithDefault (Gen.Debug.todo message) message


todoWithDefault : a -> String -> CliMonad a
todoWithDefault default message =
    CliMonad
        (\{ generateTodos } cache ->
            if generateTodos then
                Ok
                    ( default
                    , { emptyOutput | warnings = [ { path = [], message = message, details = [] } ] }
                    , cache
                    )

            else
                Err
                    { path = []
                    , message = "Todo: " ++ message
                    , details = []
                    }
        )


fail : String -> CliMonad a
fail message =
    CliMonad (\_ _ -> Err { path = [], message = message, details = [] })


succeed : a -> CliMonad a
succeed x =
    CliMonad (\_ cache -> Ok ( x, emptyOutput, cache ))


succeedWith : FastDict.Dict OneOfName (List Common.OneOfData) -> a -> CliMonad a
succeedWith oneOfs x =
    CliMonad (\_ cache -> Ok ( x, { emptyOutput | oneOfs = oneOfs }, cache ))


map : (a -> b) -> CliMonad a -> CliMonad b
map f (CliMonad x) =
    CliMonad
        (\input cache ->
            Result.map
                (\( xr, o, cache2 ) -> ( f xr, o, cache2 ))
                (x input cache)
        )


map2 : (a -> b -> c) -> CliMonad a -> CliMonad b -> CliMonad c
map2 f (CliMonad x) (CliMonad y) =
    CliMonad
        (\input cache ->
            case x input cache of
                Err e ->
                    Err e

                Ok ( xr, xo, cache2 ) ->
                    case y input cache2 of
                        Err e ->
                            Err e

                        Ok ( yr, yo, cache3 ) ->
                            Ok ( f xr yr, mergeOutput xo yo, cache3 )
        )


mergeOutput : Output -> Output -> Output
mergeOutput l r =
    { warnings = l.warnings ++ r.warnings
    , oneOfs = FastDict.union l.oneOfs r.oneOfs
    , requiredPackages = FastSet.union l.requiredPackages r.requiredPackages
    , sharedDeclarations = FastDict.union l.sharedDeclarations r.sharedDeclarations
    }


mergeOutputs : List Output -> Output
mergeOutputs list =
    List.foldl (\e acc -> mergeOutput acc e) emptyOutput list


map3 : (a -> b -> c -> d) -> CliMonad a -> CliMonad b -> CliMonad c -> CliMonad d
map3 f (CliMonad x) (CliMonad y) (CliMonad z) =
    CliMonad
        (\input cache ->
            case x input cache of
                Err e ->
                    Err e

                Ok ( xr, xo, cache2 ) ->
                    case y input cache2 of
                        Err e ->
                            Err e

                        Ok ( yr, yo, cache3 ) ->
                            case z input cache3 of
                                Err e ->
                                    Err e

                                Ok ( zr, zo, cache4 ) ->
                                    Ok ( f xr yr zr, mergeOutputs [ xo, yo, zo ], cache4 )
        )


map4 : (a -> b -> c -> d -> e) -> CliMonad a -> CliMonad b -> CliMonad c -> CliMonad d -> CliMonad e
map4 f (CliMonad x) (CliMonad y) (CliMonad z) (CliMonad w) =
    CliMonad
        (\input cache ->
            case x input cache of
                Err e ->
                    Err e

                Ok ( xr, xo, cache2 ) ->
                    case y input cache2 of
                        Err e ->
                            Err e

                        Ok ( yr, yo, cache3 ) ->
                            case z input cache3 of
                                Err e ->
                                    Err e

                                Ok ( zr, zo, cache4 ) ->
                                    case w input cache4 of
                                        Err e ->
                                            Err e

                                        Ok ( wr, wo, cache5 ) ->
                                            Ok ( f xr yr zr wr, mergeOutputs [ xo, yo, zo, wo ], cache5 )
        )


andThen : (a -> CliMonad b) -> CliMonad a -> CliMonad b
andThen f (CliMonad x) =
    CliMonad
        (\input cache ->
            case x input cache of
                Err e ->
                    Err e

                Ok ( y, yo, cache2 ) ->
                    let
                        (CliMonad z) =
                            f y
                    in
                    case z input cache2 of
                        Err e ->
                            Err e

                        Ok ( w, wo, cache3 ) ->
                            Ok ( w, mergeOutput yo wo, cache3 )
        )


join : CliMonad (CliMonad a) -> CliMonad a
join (CliMonad x) =
    CliMonad
        (\input cache ->
            case x input cache of
                Err e ->
                    Err e

                Ok ( CliMonad y, xo, cache2 ) ->
                    case y input cache2 of
                        Err e ->
                            Err e

                        Ok ( w, wo, cache3 ) ->
                            Ok ( w, mergeOutput xo wo, cache3 )
        )


andThen2 : (a -> b -> CliMonad c) -> CliMonad a -> CliMonad b -> CliMonad c
andThen2 f x y =
    map2 f x y
        |> join


andThen3 : (a -> b -> c -> CliMonad d) -> CliMonad a -> CliMonad b -> CliMonad c -> CliMonad d
andThen3 f x y z =
    map3 f x y z
        |> join


andThen4 : (a -> b -> c -> d -> CliMonad e) -> CliMonad a -> CliMonad b -> CliMonad c -> CliMonad d -> CliMonad e
andThen4 f x y z w =
    map4 f x y z w
        |> join


toInternalFormat : OpenApi.Config.Format -> ( InternalFormatName, InternalFormat )
toInternalFormat format =
    ( ( Common.basicTypeToString format.basicType, format.format )
    , { encode = format.encode
      , decoder = format.decoder
      , toParamString = format.toParamString
      , annotation = format.annotation
      , sharedDeclarations = format.sharedDeclarations
      , requiresPackages = format.requiresPackages
      , example = format.example
      }
    )


combineMap : (a -> CliMonad b) -> List a -> CliMonad (List b)
combineMap f ls =
    combine (List.map f ls)


combine : List (CliMonad a) -> CliMonad (List a)
combine =
    List.foldr (map2 (::)) (succeed [])


getApiSpec : CliMonad OpenApi
getApiSpec =
    CliMonad (\input cache -> Ok ( input.openApi, emptyOutput, cache ))


enums : CliMonad (FastDict.Dict (List String) { name : Common.UnsafeName, documentation : Maybe String })
enums =
    CliMonad (\input cache -> Ok ( input.enums, emptyOutput, cache ))


errorToWarning : CliMonad a -> CliMonad (Maybe a)
errorToWarning (CliMonad f) =
    CliMonad
        (\input cache ->
            case f input cache of
                Ok ( res, output, cache2 ) ->
                    Ok ( Just res, output, cache2 )

                Err { path, message } ->
                    ( Nothing
                    , { emptyOutput | warnings = [ { path = path, message = message, details = [] } ] }
                    , cache
                    )
                        |> Ok
        )


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


combineDict : Dict.Dict comparable (CliMonad a) -> CliMonad (Dict.Dict comparable a)
combineDict dict =
    dict
        |> Dict.foldr
            (\k vcm acc ->
                map2
                    (\v res ->
                        ( k, v ) :: res
                    )
                    vcm
                    acc
            )
            (succeed [])
        |> map Dict.fromList


foldl : (a -> b -> CliMonad b) -> CliMonad b -> List a -> CliMonad b
foldl f init list =
    List.foldl (\e acc -> andThen (f e) acc) init list


moduleToNamespace : Common.Module -> CliMonad (List String)
moduleToNamespace mod =
    CliMonad (\input cache -> Ok ( Common.moduleToNamespace input.namespace mod, emptyOutput, cache ))


enumName : List Common.UnsafeName -> CliMonad (Maybe Common.UnsafeName)
enumName variants =
    CliMonad
        (\input cache ->
            case FastDict.get (List.map Common.unwrapUnsafe variants) input.enums of
                Just { name } ->
                    Ok ( Just name, emptyOutput, cache )

                Nothing ->
                    if input.warnOnMissingEnums then
                        let
                            variantNames : List String
                            variantNames =
                                List.map
                                    (\variant ->
                                        variant
                                            |> Common.unwrapUnsafe
                                            |> escapeString
                                    )
                                    variants

                            message : String
                            message =
                                "No named enum found for [ "
                                    ++ String.join ", " variantNames
                                    ++ " ]. Define one to improve type safety"
                        in
                        ( Nothing
                        , { emptyOutput
                            | warnings =
                                [ { path = []
                                  , message = message
                                  , details = []
                                  }
                                ]
                          }
                        , cache
                        )
                            |> Ok

                    else
                        Ok ( Nothing, emptyOutput, cache )
        )


escapeString : String -> String
escapeString s =
    Json.Encode.encode 0 (Json.Encode.string s)


withFormat :
    Common.BasicType
    -> Maybe String
    ->
        ({ encode : Elm.Expression -> Elm.Expression
         , decoder : Elm.Expression
         , toParamString : Elm.Expression -> Elm.Expression
         , annotation : Elm.Annotation.Annotation
         , example : Json.Encode.Value
         }
         -> a
        )
    -> a
    -> CliMonad a
withFormat basicType maybeFormatName getter default =
    case maybeFormatName of
        Nothing ->
            succeed default

        Just formatName ->
            CliMonad
                (\input cache ->
                    let
                        basicTypeName : String
                        basicTypeName =
                            Common.basicTypeToString basicType
                    in
                    case
                        FastDict.get ( basicTypeName, formatName ) input.formats
                    of
                        Nothing ->
                            let
                                isSimple : Bool
                                isSimple =
                                    case ( basicType, formatName ) of
                                        -- These formats don't require special handling
                                        ( Common.Integer, "int32" ) ->
                                            True

                                        ( Common.Number, "int32" ) ->
                                            True

                                        ( Common.Number, "float" ) ->
                                            True

                                        ( Common.Number, "double" ) ->
                                            True

                                        ( Common.String, "password" ) ->
                                            True

                                        ( Common.String, "email" ) ->
                                            True

                                        _ ->
                                            False
                            in
                            ( default
                            , if isSimple then
                                emptyOutput

                              else
                                let
                                    firstLine : String
                                    firstLine =
                                        "Don't know how to handle format \""
                                            ++ formatName
                                            ++ "\" for type "
                                            ++ Common.basicTypeToString basicType
                                            ++ ", treating as the corresponding basic type."

                                    available : List String
                                    available =
                                        List.filterMap
                                            (\( b, f ) ->
                                                if b == basicTypeName then
                                                    Just f

                                                else
                                                    Nothing
                                            )
                                            (FastDict.keys input.formats)

                                    secondLine : String
                                    secondLine =
                                        if List.isEmpty available then
                                            "  No available formats."

                                        else
                                            "  Available formats: " ++ String.join ", " available ++ "."
                                in
                                { emptyOutput
                                    | warnings =
                                        [ { message = firstLine ++ "\n" ++ secondLine
                                          , path = [ "format" ]
                                          , details = []
                                          }
                                        ]
                                }
                            , cache
                            )
                                |> Ok

                        Just format ->
                            let
                                name : String
                                name =
                                    String.Extra.classify (Common.basicTypeToString basicType ++ "-" ++ formatName)

                                encodeAnnotation : Elm.Annotation.Annotation
                                encodeAnnotation =
                                    Elm.Annotation.function
                                        [ format.annotation ]
                                        Gen.Json.Encode.annotation_.value

                                toParamStringAnnotation : Elm.Annotation.Annotation
                                toParamStringAnnotation =
                                    Elm.Annotation.function
                                        [ format.annotation ]
                                        Elm.Annotation.string

                                decodeAnnotation : Elm.Annotation.Annotation
                                decodeAnnotation =
                                    Gen.Json.Decode.annotation_.decoder format.annotation

                                encoder : Elm.Expression
                                encoder =
                                    Elm.functionReduced "value" format.encode
                                        |> Elm.withType encodeAnnotation

                                decoder : Elm.Expression
                                decoder =
                                    format.decoder
                                        |> Elm.withType decodeAnnotation

                                toParamString : Elm.Expression
                                toParamString =
                                    Elm.functionReduced "value" format.toParamString
                                        |> Elm.withType toParamStringAnnotation
                            in
                            ( getter
                                { encode =
                                    \value ->
                                        Elm.apply
                                            (Elm.value
                                                { name = "encode" ++ name
                                                , annotation = Just encodeAnnotation
                                                , importFrom = Common.commonModuleName
                                                }
                                                |> Elm.withType encodeAnnotation
                                            )
                                            [ value ]
                                , decoder =
                                    Elm.value
                                        { name = "decode" ++ name
                                        , annotation = Just decodeAnnotation
                                        , importFrom = Common.commonModuleName
                                        }
                                        |> Elm.withType decodeAnnotation
                                , toParamString =
                                    \value ->
                                        Elm.apply
                                            (Elm.value
                                                { name = "toParamString" ++ name
                                                , annotation = Just toParamStringAnnotation
                                                , importFrom = Common.commonModuleName
                                                }
                                                |> Elm.withType toParamStringAnnotation
                                            )
                                            [ value ]
                                , annotation = format.annotation
                                , example = format.example
                                }
                            , { emptyOutput
                                | requiredPackages = FastSet.fromList format.requiresPackages
                                , sharedDeclarations =
                                    format.sharedDeclarations
                                        |> FastDict.fromList
                                        |> FastDict.insert ("encode" ++ name) { value = encoder, group = "Encoders" }
                                        |> FastDict.insert ("decode" ++ name) { value = decoder, group = "Decoders" }
                                        |> FastDict.insert ("toParamString" ++ name) { value = toParamString, group = "Encoders" }
                              }
                            , cache
                            )
                                |> Ok
                )


withRequiredPackage : String -> CliMonad a -> CliMonad a
withRequiredPackage package (CliMonad f) =
    CliMonad
        (\input cache ->
            Result.map
                (\( y, output, cache2 ) ->
                    ( y
                    , { output | requiredPackages = FastSet.insert package output.requiredPackages }
                    , cache2
                    )
                )
                (f input cache)
        )
