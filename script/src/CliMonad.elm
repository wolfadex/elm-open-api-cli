module CliMonad exposing (CliMonad, andThen, combine, combineMap, fail, fromApiSpec, fromResult, getApiSpec, map, map2, run, succeed, todo, withPath)

import OpenApi exposing (OpenApi)


type alias Path =
    List String


type CliMonad a
    = CliMonad (OpenApi -> Result ( Path, String ) a)


withPath : String -> CliMonad a -> CliMonad a
withPath segment (CliMonad f) =
    CliMonad
        (\openApi ->
            Result.mapError
                (\( path, msg ) -> ( segment :: path, msg ))
                (f openApi)
        )


todo : String -> CliMonad a
todo msg =
    fail ("Todo: " ++ msg)


fail : String -> CliMonad a
fail msg =
    CliMonad (\_ -> Err ( [], msg ))


succeed : a -> CliMonad a
succeed x =
    CliMonad (\_ -> Ok x)


map : (a -> b) -> CliMonad a -> CliMonad b
map f (CliMonad x) =
    CliMonad (\openApi -> Result.map f (x openApi))


map2 : (a -> b -> c) -> CliMonad a -> CliMonad b -> CliMonad c
map2 f (CliMonad x) (CliMonad y) =
    CliMonad (\openApi -> Result.map2 f (x openApi) (y openApi))


andThen : (a -> CliMonad b) -> CliMonad a -> CliMonad b
andThen f (CliMonad x) =
    CliMonad
        (\openApi ->
            Result.andThen
                (\y ->
                    let
                        (CliMonad z) =
                            f y
                    in
                    z openApi
                )
                (x openApi)
        )


run : OpenApi -> CliMonad a -> Result String a
run openApi (CliMonad x) =
    x openApi
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


getApiSpec : CliMonad OpenApi
getApiSpec =
    CliMonad Ok


fromApiSpec : (OpenApi -> a) -> CliMonad a
fromApiSpec f =
    CliMonad (\openApi -> Ok <| f openApi)


fromResult : Result String a -> CliMonad a
fromResult res =
    CliMonad (\_ -> Result.mapError (\msg -> ( [], msg )) res)
