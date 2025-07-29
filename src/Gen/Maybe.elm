module Gen.Maybe exposing
    ( withDefault, map
    , andThen, annotation_, make_, caseOf_
    )

{-|


# Generated bindings for Maybe

@docs withDefault, map
@docs andThen, annotation_, make_, caseOf_

-}

import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| Provide a default value, turning an optional value into a normal
value. This comes in handy when paired with functions like
[`Dict.get`](Dict#get) which gives back a `Maybe`.

    withDefault 100 (Just 42) -- 42

    withDefault 100 Nothing -- 100

    withDefault "unknown" (Dict.get "Tom" Dict.empty) -- "unknown"

**Note:** This can be overused! Many cases are better handled by a `case`
expression. And if you end up using `withDefault` a lot, it can be a good sign
that a [custom type][ct] will clean your code up quite a bit!

[ct]: https://guide.elm-lang.org/types/custom_types.html

withDefault: a -> Maybe a -> a

-}
withDefault : Elm.Expression -> Elm.Expression -> Elm.Expression
withDefault withDefaultArg_ withDefaultArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Maybe" ]
            , name = "withDefault"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a", Type.maybe (Type.var "a") ]
                        (Type.var "a")
                    )
            }
        )
        [ withDefaultArg_, withDefaultArg_0 ]


{-| Transform a `Maybe` value with a given function:

    map sqrt (Just 9) == Just 3

    map sqrt Nothing == Nothing

    map sqrt (String.toFloat "9") == Just 3

    map sqrt (String.toFloat "x") == Nothing

map: (a -> b) -> Maybe a -> Maybe b

-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg_ mapArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Maybe" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "b")
                        , Type.maybe (Type.var "a")
                        ]
                        (Type.maybe (Type.var "b"))
                    )
            }
        )
        [ Elm.functionReduced "mapUnpack" mapArg_, mapArg_0 ]


{-| Chain together many computations that may fail. It is helpful to see its
definition:

    andThen : (a -> Maybe b) -> Maybe a -> Maybe b
    andThen callback maybe =
        case maybe of
            Just value ->
                callback value

            Nothing ->
                Nothing

This means we only continue with the callback if things are going well. For
example, say you need to parse some user input as a month:

    parseMonth : String -> Maybe Int
    parseMonth userInput =
        String.toInt userInput
            |> andThen toValidMonth

    toValidMonth : Int -> Maybe Int
    toValidMonth month =
        if 1 <= month && month <= 12 then
            Just month

        else
            Nothing

In the `parseMonth` function, if `String.toInt` produces `Nothing` (because
the `userInput` was not an integer) this entire chain of operations will
short-circuit and result in `Nothing`. If `toValidMonth` results in `Nothing`,
again the chain of computations will result in `Nothing`.

andThen: (a -> Maybe b) -> Maybe a -> Maybe b

-}
andThen : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
andThen andThenArg_ andThenArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Maybe" ]
            , name = "andThen"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.maybe (Type.var "b"))
                        , Type.maybe (Type.var "a")
                        ]
                        (Type.maybe (Type.var "b"))
                    )
            }
        )
        [ Elm.functionReduced "andThenUnpack" andThenArg_, andThenArg_0 ]


annotation_ : { maybe : Type.Annotation -> Type.Annotation }
annotation_ =
    { maybe = \maybeArg0 -> Type.namedWith [] "Maybe" [ maybeArg0 ] }


make_ : { just : Elm.Expression -> Elm.Expression, nothing : Elm.Expression }
make_ =
    { just =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = []
                    , name = "Just"
                    , annotation =
                        Just (Type.namedWith [] "Maybe" [ Type.var "a" ])
                    }
                )
                [ ar0 ]
    , nothing =
        Elm.value
            { importFrom = []
            , name = "Nothing"
            , annotation = Just (Type.namedWith [] "Maybe" [ Type.var "a" ])
            }
    }


caseOf_ :
    { maybe :
        Elm.Expression
        -> { just : Elm.Expression -> Elm.Expression, nothing : Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { maybe =
        \maybeExpression maybeTags ->
            Elm.Case.custom
                maybeExpression
                (Type.namedWith [ "Maybe" ] "Maybe" [ Type.var "a" ])
                [ Elm.Case.branch
                    (Elm.Arg.customType "Just" maybeTags.just
                        |> Elm.Arg.item
                            (Elm.Arg.varWith
                                "a"
                                (Type.var
                                    "a"
                                )
                            )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Nothing" maybeTags.nothing)
                    Basics.identity
                ]
    }
