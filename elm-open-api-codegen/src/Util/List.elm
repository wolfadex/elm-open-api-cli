module Util.List exposing (mapFirst)


mapFirst : (a -> a) -> List a -> List a
mapFirst fn list =
    case list of
        [] ->
            []

        x :: xs ->
            fn x :: xs
