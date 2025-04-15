module Elm.Extra exposing (functionReduced)

import Elm
import Elm.ToString
import Gen.Basics


functionReduced : String -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
functionReduced argName f =
    if (f (Elm.val "YOLO") |> Elm.ToString.expression).body == "YOLO" then
        Gen.Basics.values_.identity

    else
        Elm.functionReduced argName f
