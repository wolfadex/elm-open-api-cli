module OpenApi.Generate.Common exposing (Module, NullableDeclaration, module_, nullableType)

import Elm
import Elm.Annotation
import Elm.Declare


type alias Module =
    { nullable :
        { annotation : Elm.Annotation.Annotation
        , make_ : NullableDeclaration
        , case_ : Elm.Expression -> NullableDeclaration -> Elm.Expression
        }
    }


module_ : Elm.Declare.Module Module
module_ =
    Elm.Declare.module_ [ "OpenApi", "Common" ] Module
        |> Elm.Declare.with nullableType


type alias NullableDeclaration =
    { null : Elm.Expression
    , present : Elm.Expression -> Elm.Expression
    }


nullableType : Elm.Declare.CustomType NullableDeclaration
nullableType =
    Elm.Declare.customTypeAdvanced "Nullable" { exposeConstructor = True } NullableDeclaration
        |> Elm.Declare.variant0 "Null" .null
        |> Elm.Declare.variant1 "Present" (Elm.Annotation.var "value") .present
        |> Elm.Declare.finishCustomType
