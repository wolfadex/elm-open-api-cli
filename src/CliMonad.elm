module CliMonad exposing
    ( CliMonad, Message, OneOfName, Path
    , run, stepOrFail
    , succeed, succeedWith, fail
    , map, map2, map3, map4
    , andThen, andThen2, andThen3, combine, combineDict, combineMap, foldl
    , errorToWarning, fromApiSpec, enumName, moduleToNamespace
    , withPath, withWarning
    , todo, todoWithDefault
    , Format, withFormat
    )

{-|

@docs CliMonad, Message, OneOfName, Path
@docs run, stepOrFail
@docs succeed, succeedWith, fail
@docs map, map2, map3, map4
@docs andThen, andThen2, andThen3, combine, combineDict, combineMap, foldl
@docs errorToWarning, fromApiSpec, enumName, moduleToNamespace
@docs withPath, withWarning
@docs todo, todoWithDefault
@docs Format, withFormat

-}

import Common
import Dict
import Elm
import Elm.Annotation
import FastDict
import Gen.Debug
import OpenApi exposing (OpenApi)


type alias Message =
    { message : String
    , path : Path
    }


type alias Path =
    List String


type alias OneOfName =
    Common.TypeName


{-| The first String is the `type`, the second the `format`.
-}
type alias InternalFormatName =
    ( String, String )


type alias Format =
    { basicType : Common.BasicType
    , format : String
    , encode : Elm.Expression -> Elm.Expression
    , decoder : Elm.Expression
    , annotation : Elm.Annotation.Annotation
    , sharedDeclarations : List Elm.Declaration
    , requiresPackages : List String
    }


type alias InternalFormat =
    { encode : Elm.Expression -> Elm.Expression
    , decoder : Elm.Expression
    , annotation : Elm.Annotation.Annotation
    , sharedDeclarations : List Elm.Declaration
    , requiresPackages : List String
    }


type CliMonad a
    = CliMonad
        ({ openApi : OpenApi
         , generateTodos : Bool
         , enums : FastDict.Dict (List String) { name : Common.UnsafeName, documentation : Maybe String }
         , namespace : List String
         , formats : FastDict.Dict InternalFormatName InternalFormat
         }
         ->
            Result
                Message
                ( a
                , List Message
                , FastDict.Dict OneOfName Common.OneOfData
                )
        )


withPath : Common.UnsafeName -> CliMonad a -> CliMonad a
withPath segment (CliMonad f) =
    CliMonad
        (\inputs ->
            case f inputs of
                Err message ->
                    Err (addPath segment message)

                Ok ( res, warns, oneOfs ) ->
                    Ok ( res, List.map (addPath segment) warns, oneOfs )
        )


addPath : Common.UnsafeName -> Message -> Message
addPath (Common.UnsafeName segment) { path, message } =
    { path = segment :: path
    , message = message
    }


withWarning : String -> CliMonad a -> CliMonad a
withWarning message (CliMonad f) =
    CliMonad
        (\inputs ->
            Result.map
                (\( res, warnings, oneOfs ) -> ( res, { path = [], message = message } :: warnings, oneOfs ))
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


succeedWith : FastDict.Dict OneOfName Common.OneOfData -> a -> CliMonad a
succeedWith oneOfs x =
    CliMonad (\_ -> Ok ( x, [], oneOfs ))


map : (a -> b) -> CliMonad a -> CliMonad b
map f (CliMonad x) =
    CliMonad (\input -> Result.map (\( xr, xw, xm ) -> ( f xr, xw, xm )) (x input))


map2 : (a -> b -> c) -> CliMonad a -> CliMonad b -> CliMonad c
map2 f (CliMonad x) (CliMonad y) =
    CliMonad (\input -> Result.map2 (\( xr, xw, xm ) ( yr, yw, ym ) -> ( f xr yr, xw ++ yw, FastDict.union xm ym )) (x input) (y input))


map3 : (a -> b -> c -> d) -> CliMonad a -> CliMonad b -> CliMonad c -> CliMonad d
map3 f (CliMonad x) (CliMonad y) (CliMonad z) =
    CliMonad (\input -> Result.map3 (\( xr, xw, xm ) ( yr, yw, ym ) ( zr, zw, zm ) -> ( f xr yr zr, xw ++ yw ++ zw, FastDict.union (FastDict.union xm ym) zm )) (x input) (y input) (z input))


map4 : (a -> b -> c -> d -> e) -> CliMonad a -> CliMonad b -> CliMonad c -> CliMonad d -> CliMonad e
map4 f (CliMonad x) (CliMonad y) (CliMonad z) (CliMonad w) =
    CliMonad (\input -> Result.map4 (\( xr, xw, xm ) ( yr, yw, ym ) ( zr, zw, zm ) ( wr, ww, wm ) -> ( f xr yr zr wr, xw ++ yw ++ zw ++ ww, FastDict.union (FastDict.union xm ym) (FastDict.union zm wm) )) (x input) (y input) (z input) (w input))


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
    map2 f x y
        |> andThen identity


andThen3 : (a -> b -> c -> CliMonad d) -> CliMonad a -> CliMonad b -> CliMonad c -> CliMonad d
andThen3 f x y z =
    map3 f x y z
        |> andThen identity


{-| Runs the transformation from OpenApi to declaration.

Automatically appends the needed `oneOf` declarations.

-}
run :
    (FastDict.Dict OneOfName Common.OneOfData -> CliMonad (List ( Common.Module, Elm.Declaration )))
    ->
        { openApi : OpenApi
        , generateTodos : Bool
        , enums : FastDict.Dict (List String) { name : Common.UnsafeName, documentation : Maybe String }
        , namespace : List String
        , formats : List Format
        }
    -> CliMonad (List ( Common.Module, Elm.Declaration ))
    -> Result Message ( List ( Common.Module, Elm.Declaration ), List Message )
run oneOfDeclarations input (CliMonad x) =
    let
        internalInput :
            { openApi : OpenApi
            , generateTodos : Bool
            , enums : FastDict.Dict (List String) { name : Common.UnsafeName, documentation : Maybe String }
            , namespace : List String
            , formats : FastDict.Dict InternalFormatName InternalFormat
            }
        internalInput =
            { openApi = input.openApi
            , generateTodos = input.generateTodos
            , enums = input.enums
            , namespace = input.namespace
            , formats =
                input.formats
                    |> List.map toInternalFormat
                    |> FastDict.fromList
            }
    in
    x internalInput
        |> Result.andThen
            (\( decls, warnings, oneOfs ) ->
                let
                    (CliMonad h) =
                        oneOfDeclarations oneOfs
                            |> withPath (Common.UnsafeName "While generating `oneOf`s")
                in
                h internalInput
                    |> Result.map
                        (\( oneOfDecls, oneOfWarnings, _ ) ->
                            ( decls ++ oneOfDecls
                            , (oneOfWarnings ++ warnings)
                                |> List.reverse
                            )
                        )
            )


toInternalFormat : Format -> ( InternalFormatName, InternalFormat )
toInternalFormat format =
    ( ( Common.basicTypeToString format.basicType, format.format )
    , { encode = format.encode
      , decoder = format.decoder
      , annotation = format.annotation
      , sharedDeclarations = format.sharedDeclarations
      , requiresPackages = format.requiresPackages
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


enums : CliMonad (FastDict.Dict (List String) { name : Common.UnsafeName, documentation : Maybe String })
enums =
    CliMonad (\input -> Ok ( input.enums, [], FastDict.empty ))


errorToWarning : CliMonad a -> CliMonad (Maybe a)
errorToWarning (CliMonad f) =
    CliMonad
        (\input ->
            case f input of
                Ok ( res, warns, oneOfs ) ->
                    Ok ( Just res, warns, oneOfs )

                Err { path, message } ->
                    Ok ( Nothing, [ { path = path, message = message } ], FastDict.empty )
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
    CliMonad (\input -> Ok ( Common.moduleToNamespace input.namespace mod, [], FastDict.empty ))


enumName : List Common.UnsafeName -> CliMonad (Maybe Common.UnsafeName)
enumName variants =
    map
        (\e ->
            FastDict.get (List.map Common.unwrapUnsafe variants) e
                |> Maybe.map .name
        )
        enums


withFormat :
    Common.BasicType
    -> Maybe String
    ->
        ({ encode : Elm.Expression -> Elm.Expression
         , decoder : Elm.Expression
         , annotation : Elm.Annotation.Annotation
         , sharedDeclarations : List Elm.Declaration
         , requiresPackages : List String
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
                (\{ formats } ->
                    ( FastDict.get ( Common.basicTypeToString basicType, formatName ) formats
                        |> Maybe.map getter
                        |> Maybe.withDefault default
                    , []
                    , FastDict.empty
                    )
                        |> Ok
                )
