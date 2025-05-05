module Elm.Op.Extra exposing (appends, pipeInto)

import Elm
import Elm.Op


pipeInto : String -> (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
pipeInto argName f x =
    Elm.Op.pipe (Elm.functionReduced argName f) x


appends : List Elm.Expression -> Elm.Expression
appends strings =
    case strings of
        [] ->
            Elm.string ""

        head :: tail ->
            List.foldl (\e acc -> Elm.Op.append acc e) head tail
