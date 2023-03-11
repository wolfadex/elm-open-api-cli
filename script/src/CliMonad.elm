module CliMonad exposing (CliMonad, Warning, andThen, combine, combineMap, enumAnnotation, errorToWarning, fail, fromApiSpec, map, map2, map3, run, succeed, todo, todoWithDefault, withPath, withWarning)

import Common exposing (TypeName(..), intToWord, toValueName, typifyName)
import Elm
import Elm.Annotation
import FastDict
import Gen.Debug
import OpenApi exposing (OpenApi)
import Result.Extra


type alias Message =
    { message : String
    , path : Path
    }


type alias Path =
    List String


type alias Warning =
    String


type alias FastSet k =
    FastDict.Dict k ()


type CliMonad a
    = CliMonad ({ openApi : OpenApi, generateTodos : Bool } -> Result Message ( a, List Message, FastSet Int ))


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


{-| Runs the transformation from OpenApi to declaration.

Automatically appends the needed `enum` declarations.

-}
run : { openApi : OpenApi, generateTodos : Bool } -> CliMonad (List Elm.Declaration) -> Result String ( List Elm.Declaration, List Warning )
run input (CliMonad x) =
    case x input of
        Err message ->
            Err <| messageToString message

        Ok ( decls, warnings, enums ) ->
            case helperDeclarations enums of
                Err message ->
                    messageToString
                        { message = message
                        , path = [ "While generating enums" ]
                        }
                        |> Err

                Ok enumDecls ->
                    Ok
                        ( decls ++ enumDecls
                        , List.reverse warnings |> List.map messageToString
                        )


helperDeclarations : FastSet Int -> Result String (List Elm.Declaration)
helperDeclarations enums =
    Result.Extra.combineMap
        enumDeclaration
        (FastDict.keys enums)


enumDeclaration : Int -> Result String Elm.Declaration
enumDeclaration i =
    intToWord i
        |> Result.andThen
            (\iWord ->
                let
                    (TypeName typeName) =
                        typifyName ("enum_" ++ iWord)

                    variantDeclaration j =
                        Result.map
                            (\jWord ->
                                let
                                    (TypeName variantName) =
                                        typifyName ("enum_" ++ iWord ++ "_" ++ jWord)
                                in
                                Elm.variantWith variantName [ Elm.Annotation.var (toValueName jWord) ]
                            )
                            (intToWord j)
                in
                List.range 1 i
                    |> Result.Extra.combineMap variantDeclaration
                    |> Result.map (Elm.customType typeName)
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


fromResult : Result String a -> CliMonad a
fromResult res =
    CliMonad
        (\_ ->
            case res of
                Err message ->
                    Err { path = [], message = message }

                Ok r ->
                    Ok ( r, [], FastDict.empty )
        )


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


messageToString : Message -> String
messageToString { path, message } =
    if List.isEmpty path then
        "Error! " ++ message

    else
        "Error! " ++ message ++ "\n  Path: " ++ String.join " -> " path


enumAnnotation : CliMonad (List Elm.Annotation.Annotation) -> CliMonad Elm.Annotation.Annotation
enumAnnotation annotations =
    annotations
        |> andThen
            (\anns ->
                map2
                    (\intWord _ ->
                        let
                            (TypeName typeName) =
                                typifyName ("enum_" ++ intWord)
                        in
                        Elm.Annotation.namedWith [] typeName anns
                    )
                    (fromResult <| intToWord (List.length anns))
                    (requiresEnum (List.length anns))
            )


requiresEnum : Int -> CliMonad ()
requiresEnum size =
    CliMonad (\_ -> Ok ( (), [], FastDict.singleton size () ))
