module CliMonad exposing (CliMonad, Warning, andThen, combine, combineMap, fail, fromApiSpec, fromResult, map, map2, map3, run, succeed, todo, todoWithDefault, withPath, withWarning)

import Elm
import Gen.Debug
import OpenApi exposing (OpenApi)


type alias Path =
    List String


type alias Warning =
    String


type CliMonad a
    = CliMonad ({ openApi : OpenApi, generateTodos : Bool } -> Result ( Path, String ) ( a, List Warning ))


withPath : String -> CliMonad a -> CliMonad a
withPath segment (CliMonad f) =
    CliMonad
        (\inputs ->
            Result.mapError
                (\( path, msg ) -> ( segment :: path, msg ))
                (f inputs)
        )


withWarning : Warning -> CliMonad a -> CliMonad a
withWarning warning (CliMonad f) =
    CliMonad
        (\inputs ->
            Result.map
                (\( res, warnings ) -> ( res, warning :: warnings ))
                (f inputs)
        )


todo : String -> CliMonad Elm.Expression
todo msg =
    todoWithDefault (Gen.Debug.todo msg) msg


todoWithDefault : a -> String -> CliMonad a
todoWithDefault default msg =
    CliMonad
        (\{ generateTodos } ->
            if generateTodos then
                Ok ( default, [ msg ] )

            else
                Err ( [], "Todo: " ++ msg )
        )


fail : String -> CliMonad a
fail msg =
    CliMonad (\_ -> Err ( [], msg ))


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


run : { openApi : OpenApi, generateTodos : Bool } -> CliMonad a -> Result String ( a, List Warning )
run input (CliMonad x) =
    case x input of
        Err ( path, msg ) ->
            Err <| "Error! " ++ msg ++ "\n  Path: " ++ String.join " -> " path

        Ok ( res, warnings ) ->
            Ok ( res, List.reverse warnings )


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
                Err msg ->
                    Err ( [], msg )

                Ok r ->
                    Ok ( r, [] )
        )
