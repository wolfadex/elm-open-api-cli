module CliMonad exposing (CliMonad, Warning, andThen, combine, combineMap, enumAnnotation, errorToWarning, fail, fromApiSpec, map, map2, map3, run, succeed, todo, todoWithDefault, withPath, withWarning)

import Common exposing (TypeName(..), intToWord, toValueName, typifyName)
import Elm
import Elm.Annotation
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


type CliMonad a
    = CliMonad ({ openApi : OpenApi, generateTodos : Bool } -> Result Message ( a, List Message ))


withPath : String -> CliMonad a -> CliMonad a
withPath segment (CliMonad f) =
    CliMonad
        (\inputs ->
            case f inputs of
                Err message ->
                    Err (addPath segment message)

                Ok ( res, warns ) ->
                    Ok ( res, List.map (addPath segment) warns )
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
                (\( res, warnings ) -> ( res, { path = [], message = message } :: warnings ))
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
                Ok ( default, [ { path = [], message = message } ] )

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
    CliMonad (\_ -> Ok ( x, [] ))


map : (a -> b) -> CliMonad a -> CliMonad b
map f (CliMonad x) =
    CliMonad (\input -> Result.map (\( xr, xw ) -> ( f xr, xw )) (x input))


map2 : (a -> b -> c) -> CliMonad a -> CliMonad b -> CliMonad c
map2 f (CliMonad x) (CliMonad y) =
    CliMonad (\input -> Result.map2 (\( xr, xw ) ( yr, yw ) -> ( f xr yr, xw ++ yw )) (x input) (y input))


map3 : (a -> b -> c -> d) -> CliMonad a -> CliMonad b -> CliMonad c -> CliMonad d
map3 f (CliMonad x) (CliMonad y) (CliMonad z) =
    CliMonad (\input -> Result.map3 (\( xr, xw ) ( yr, yw ) ( zr, zw ) -> ( f xr yr zr, xw ++ yw ++ zw )) (x input) (y input) (z input))


andThen : (a -> CliMonad b) -> CliMonad a -> CliMonad b
andThen f (CliMonad x) =
    CliMonad
        (\input ->
            Result.andThen
                (\( y, yw ) ->
                    let
                        (CliMonad z) =
                            f y
                    in
                    z input
                        |> Result.map (\( w, ww ) -> ( w, yw ++ ww ))
                )
                (x input)
        )


{-| Runs the transformation from OpenApi to declaration.

Automatically appends the needed `enum` declarations.

-}
run : { openApi : OpenApi, generateTodos : Bool } -> CliMonad (List Elm.Declaration) -> Result String ( List Elm.Declaration, List Warning )
run input m =
    let
        (CliMonad x) =
            map2 (++) m (fromResult helperDeclarations)
    in
    case x input of
        Err message ->
            Err <| messageToString message

        Ok ( res, warnings ) ->
            Ok ( res, List.reverse warnings |> List.map messageToString )


helperDeclarations : Result String (List Elm.Declaration)
helperDeclarations =
    Result.Extra.combineMap
        enumDeclaration
        -- The max value here should match with the max value supported by `intToWord`
        (List.range 1 99)


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
    CliMonad (\input -> Ok ( f input.openApi, [] ))


fromResult : Result String a -> CliMonad a
fromResult res =
    CliMonad
        (\_ ->
            case res of
                Err message ->
                    Err { path = [], message = message }

                Ok r ->
                    Ok ( r, [] )
        )


errorToWarning : CliMonad a -> CliMonad (Maybe a)
errorToWarning (CliMonad f) =
    CliMonad
        (\input ->
            case f input of
                Ok ( res, warns ) ->
                    Ok ( Just res, warns )

                Err { path, message } ->
                    Ok ( Nothing, [ { path = path, message = message } ] )
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
                map
                    (\intWord ->
                        let
                            (TypeName typeName) =
                                typifyName ("enum_" ++ intWord)
                        in
                        Elm.Annotation.namedWith [] typeName anns
                    )
                    (fromResult <| intToWord (List.length anns))
            )
