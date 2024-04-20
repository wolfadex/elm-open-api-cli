module Util.Debug exposing (..)


mapLog : String -> (a -> b) -> a -> a
mapLog tag mapFn a =
    let
        _ =
            Debug.log tag (mapFn a)
    in
    a
