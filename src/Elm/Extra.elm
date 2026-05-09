module Elm.Extra exposing (functionReduced, withDocumentationMaybe)

import Elm
import Elm.ToString
import Gen.Basics


functionReduced : String -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
functionReduced argName f =
    if (f (Elm.val "YOLO") |> Elm.ToString.expression).body == "YOLO" then
        Gen.Basics.values_.identity

    else
        Elm.functionReduced argName f


withDocumentationMaybe : Maybe String -> Elm.Declaration -> Elm.Declaration
withDocumentationMaybe documentation declaration =
    case documentation of
        Nothing ->
            declaration

        Just doc ->
            Elm.withDocumentation doc declaration
