module CliMonad exposing
    ( CliMonad, Message, OneOfName, Path, Declaration, Input
    , run, stepOrFail
    , succeed, succeedWith, fail
    , map, map2, map3
    , andThen, andThen2, andThen3, andThen4, combine, combineDict, combineMap, foldl
    , errorToWarning, getApiSpec, enumName, moduleToNamespace
    , withPath, withWarning, withExtendedWarning, withRequiredPackage
    , todo, todoWithDefault
    , withFormat
    )

{-|

@docs CliMonad, Message, OneOfName, Path, Declaration, Input
@docs run, stepOrFail
@docs succeed, succeedWith, fail
@docs map, map2, map3
@docs andThen, andThen2, andThen3, andThen4, combine, combineDict, combineMap, foldl
@docs errorToWarning, getApiSpec, enumName, moduleToNamespace
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


type Input
    = Input
        { openApi : OpenApi
        , generateTodos : Bool
        , enums : FastDict.Dict (List String) { name : Common.UnsafeName, documentation : Maybe String }
        , namespace : List String
        , formats : FastDict.Dict InternalFormatName InternalFormat
        , warnOnMissingEnums : Bool
        }


type CliMonad a
    = CliMonad (Result Message ( a, Output ))


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
    (Input -> FastDict.Dict OneOfName (List Common.OneOfData) -> CliMonad (List Declaration))
    ->
        { openApi : OpenApi
        , generateTodos : Bool
        , enums : FastDict.Dict (List String) { name : Common.UnsafeName, documentation : Maybe String }
        , namespace : List String
        , formats : List OpenApi.Config.Format
        , warnOnMissingEnums : Bool
        }
    -> (Input -> CliMonad (List Declaration))
    ->
        Result
            Message
            { declarations : List Declaration
            , warnings : List Message
            , requiredPackages : FastSet.Set String
            }
run oneOfDeclarations input x =
    let
        internalInput : Input
        internalInput =
            Input
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

        (CliMonad res) =
            x internalInput
    in
    res
        |> Result.andThen
            (\( decls, output ) ->
                let
                    (CliMonad h) =
                        oneOfDeclarations internalInput output.oneOfs
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
                h
                    |> Result.map
                        (\( oneOfDecls, oneOfOutput ) ->
                            { declarations = decls ++ oneOfDecls ++ declarationsForFormats output ++ declarationsForFormats oneOfOutput
                            , warnings =
                                (oneOfOutput.warnings ++ output.warnings)
                                    |> List.reverse
                            , requiredPackages = FastSet.union output.requiredPackages oneOfOutput.requiredPackages
                            }
                        )
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
        (case f of
            Err message ->
                Err (addPath segment message)

            Ok ( res, output ) ->
                Ok ( res, { output | warnings = List.map (addPath segment) output.warnings } )
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
        (Result.map
            (\( res, output ) ->
                ( res
                , { output | warnings = { path = [], message = message, details = [] } :: output.warnings }
                )
            )
            f
        )


withExtendedWarning : { message : String, details : List String } -> CliMonad a -> CliMonad a
withExtendedWarning { message, details } (CliMonad f) =
    CliMonad
        (Result.map
            (\( res, output ) ->
                ( res
                , { output | warnings = { path = [], message = message, details = details } :: output.warnings }
                )
            )
            f
        )


todo : Input -> String -> CliMonad Elm.Expression
todo input message =
    todoWithDefault input (Gen.Debug.todo message) message


todoWithDefault : Input -> a -> String -> CliMonad a
todoWithDefault (Input { generateTodos }) default message =
    CliMonad
        (if generateTodos then
            Ok ( default, { emptyOutput | warnings = [ { path = [], message = message, details = [] } ] } )

         else
            Err
                { path = []
                , message = "Todo: " ++ message
                , details = []
                }
        )


fail : String -> CliMonad a
fail message =
    CliMonad (Err { path = [], message = message, details = [] })


succeed : a -> CliMonad a
succeed x =
    CliMonad (Ok ( x, emptyOutput ))


succeedWith : FastDict.Dict OneOfName (List Common.OneOfData) -> a -> CliMonad a
succeedWith oneOfs x =
    CliMonad (Ok ( x, { emptyOutput | oneOfs = oneOfs } ))


map : (a -> b) -> CliMonad a -> CliMonad b
map f (CliMonad x) =
    CliMonad (Result.map (\( xr, o ) -> ( f xr, o )) x)


map2 : (a -> b -> c) -> CliMonad a -> CliMonad b -> CliMonad c
map2 f (CliMonad x) (CliMonad y) =
    CliMonad
        (Result.map2
            (\( xr, xo ) ( yr, yo ) ->
                ( f xr yr, mergeOutput xo yo )
            )
            x
            y
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
        (Result.map3
            (\( xr, xo ) ( yr, yo ) ( zr, zo ) ->
                ( f xr yr zr, mergeOutputs [ xo, yo, zo ] )
            )
            x
            y
            z
        )


map4 : (a -> b -> c -> d -> e) -> CliMonad a -> CliMonad b -> CliMonad c -> CliMonad d -> CliMonad e
map4 f (CliMonad x) (CliMonad y) (CliMonad z) (CliMonad w) =
    CliMonad
        (Result.map4
            (\( xr, xo ) ( yr, yo ) ( zr, zo ) ( wr, wo ) ->
                ( f xr yr zr wr, mergeOutputs [ xo, yo, zo, wo ] )
            )
            x
            y
            z
            w
        )


andThen : (a -> CliMonad b) -> CliMonad a -> CliMonad b
andThen f (CliMonad x) =
    CliMonad
        (case x of
            Err e ->
                Err e

            Ok ( y, yo ) ->
                let
                    (CliMonad z) =
                        f y
                in
                case z of
                    Err e ->
                        Err e

                    Ok ( w, wo ) ->
                        Ok ( w, mergeOutput yo wo )
        )


andThen2 : (a -> b -> CliMonad c) -> CliMonad a -> CliMonad b -> CliMonad c
andThen2 f x y =
    map2 f x y
        |> andThen identity


andThen3 : (a -> b -> c -> CliMonad d) -> CliMonad a -> CliMonad b -> CliMonad c -> CliMonad d
andThen3 f x y z =
    map3 f x y z
        |> andThen identity


andThen4 : (a -> b -> c -> d -> CliMonad e) -> CliMonad a -> CliMonad b -> CliMonad c -> CliMonad d -> CliMonad e
andThen4 f x y z w =
    map4 f x y z w
        |> andThen identity


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


getApiSpec : Input -> OpenApi
getApiSpec (Input input) =
    input.openApi


enums : Input -> FastDict.Dict (List String) { name : Common.UnsafeName, documentation : Maybe String }
enums (Input input) =
    input.enums


errorToWarning : CliMonad a -> CliMonad (Maybe a)
errorToWarning (CliMonad f) =
    CliMonad
        (case f of
            Ok ( res, output ) ->
                Ok ( Just res, output )

            Err { path, message } ->
                Ok ( Nothing, { emptyOutput | warnings = [ { path = path, message = message, details = [] } ] } )
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


moduleToNamespace : Input -> Common.Module -> List String
moduleToNamespace (Input input) mod =
    Common.moduleToNamespace input.namespace mod


enumName : Input -> List Common.UnsafeName -> CliMonad (Maybe Common.UnsafeName)
enumName ((Input { warnOnMissingEnums }) as input) variants =
    case FastDict.get (List.map Common.unwrapUnsafe variants) (enums input) of
        Just { name } ->
            succeed (Just name)

        Nothing ->
            CliMonad
                (if warnOnMissingEnums then
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
                    )
                        |> Ok

                 else
                    Ok ( Nothing, emptyOutput )
                )


escapeString : String -> String
escapeString s =
    Json.Encode.encode 0 (Json.Encode.string s)


withFormat :
    Input
    -> Common.BasicType
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
withFormat (Input { formats }) basicType maybeFormatName getter default =
    case maybeFormatName of
        Nothing ->
            succeed default

        Just formatName ->
            CliMonad
                (let
                    basicTypeName : String
                    basicTypeName =
                        Common.basicTypeToString basicType
                 in
                 case
                    FastDict.get ( basicTypeName, formatName ) formats
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
                                        (FastDict.keys formats)

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
                        )
                            |> Ok
                )


withRequiredPackage : String -> CliMonad a -> CliMonad a
withRequiredPackage package (CliMonad f) =
    CliMonad
        (Result.map
            (\( y, output ) ->
                ( y
                , { output | requiredPackages = FastSet.insert package output.requiredPackages }
                )
            )
            f
        )
