module Elm.Op.Extra exposing (pipeInto)

import Elm
import Elm.Op


pipeInto : String -> (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
pipeInto argName f x =
    Elm.Op.pipe (Elm.functionReduced argName f) x
