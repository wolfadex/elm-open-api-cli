module CliMonad exposing (CliMonad, andThen, combine, combineMap, fail, fromApiSpec, fromResult, map, map2, run, succeed, todo, unsupported, withPath)

import Elm
import Gen.Debug
import OpenApi exposing (OpenApi)


type alias Path =
    List String


type CliMonad a
    = CliMonad ({ openApi : OpenApi, generateTodos : Bool } -> Result ( Path, String ) a)


withPath : String -> CliMonad a -> CliMonad a
withPath segment (CliMonad f) =
    CliMonad
        (\inputs ->
            Result.mapError
                (\( path, msg ) -> ( segment :: path, msg ))
                (f inputs)
        )


todo : String -> CliMonad Elm.Expression
todo msg =
    CliMonad
        (\{ generateTodos } ->
            if generateTodos then
                Ok (Gen.Debug.todo msg)

            else
                Err ( [], "Todo: " ++ msg )
        )


unsupported : String -> CliMonad a
unsupported msg =
    fail ("Unsupported: " ++ msg)


fail : String -> CliMonad a
fail msg =
    CliMonad (\_ -> Err ( [], msg ))


succeed : a -> CliMonad a
succeed x =
    CliMonad (\_ -> Ok x)


map : (a -> b) -> CliMonad a -> CliMonad b
map f (CliMonad x) =
    CliMonad (\input -> Result.map f (x input))


map2 : (a -> b -> c) -> CliMonad a -> CliMonad b -> CliMonad c
map2 f (CliMonad x) (CliMonad y) =
    CliMonad (\input -> Result.map2 f (x input) (y input))


andThen : (a -> CliMonad b) -> CliMonad a -> CliMonad b
andThen f (CliMonad x) =
    CliMonad
        (\input ->
            Result.andThen
                (\y ->
                    let
                        (CliMonad z) =
                            f y
                    in
                    z input
                )
                (x input)
        )


run : { openApi : OpenApi, generateTodos : Bool } -> CliMonad a -> Result String a
run input (CliMonad x) =
    x input
        |> Result.mapError
            (\( path, msg ) ->
                "Error\n  Message - " ++ msg ++ "\n  Path " ++ String.join "." path
            )


combineMap : (a -> CliMonad b) -> List a -> CliMonad (List b)
combineMap f ls =
    combine (List.map f ls)


combine : List (CliMonad a) -> CliMonad (List a)
combine =
    List.foldr (map2 (::)) (succeed [])


fromApiSpec : (OpenApi -> a) -> CliMonad a
fromApiSpec f =
    CliMonad (\input -> Ok <| f input.openApi)


fromResult : Result String a -> CliMonad a
fromResult res =
    CliMonad (\_ -> Result.mapError (\msg -> ( [], msg )) res)
