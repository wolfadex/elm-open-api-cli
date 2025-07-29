module Gen.Basics exposing
    ( identity
    , values_
    )

{-|


# Generated bindings for Basics

@docs identity
@docs values_

-}

import Elm
import Elm.Annotation as Type


{-| Given a value, returns exactly the same value. This is called
[the identity function](https://en.wikipedia.org/wiki/Identity_function).

identity: a -> a

-}
identity : Elm.Expression -> Elm.Expression
identity identityArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Basics" ]
            , name = "identity"
            , annotation = Just (Type.function [ Type.var "a" ] (Type.var "a"))
            }
        )
        [ identityArg_ ]


values_ :
    { toFloat : Elm.Expression
    , round : Elm.Expression
    , floor : Elm.Expression
    , ceiling : Elm.Expression
    , truncate : Elm.Expression
    , max : Elm.Expression
    , min : Elm.Expression
    , compare : Elm.Expression
    , not : Elm.Expression
    , xor : Elm.Expression
    , modBy : Elm.Expression
    , remainderBy : Elm.Expression
    , negate : Elm.Expression
    , abs : Elm.Expression
    , clamp : Elm.Expression
    , sqrt : Elm.Expression
    , logBase : Elm.Expression
    , e : Elm.Expression
    , degrees : Elm.Expression
    , radians : Elm.Expression
    , turns : Elm.Expression
    , pi : Elm.Expression
    , cos : Elm.Expression
    , sin : Elm.Expression
    , tan : Elm.Expression
    , acos : Elm.Expression
    , asin : Elm.Expression
    , atan : Elm.Expression
    , atan2 : Elm.Expression
    , toPolar : Elm.Expression
    , fromPolar : Elm.Expression
    , isNaN : Elm.Expression
    , isInfinite : Elm.Expression
    , identity : Elm.Expression
    , always : Elm.Expression
    , never : Elm.Expression
    }
values_ =
    { toFloat =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "toFloat"
            , annotation = Just (Type.function [ Type.int ] Type.float)
            }
    , round =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "round"
            , annotation = Just (Type.function [ Type.float ] Type.int)
            }
    , floor =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "floor"
            , annotation = Just (Type.function [ Type.float ] Type.int)
            }
    , ceiling =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "ceiling"
            , annotation = Just (Type.function [ Type.float ] Type.int)
            }
    , truncate =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "truncate"
            , annotation = Just (Type.function [ Type.float ] Type.int)
            }
    , max =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "max"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable", Type.var "comparable" ]
                        (Type.var "comparable")
                    )
            }
    , min =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "min"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable", Type.var "comparable" ]
                        (Type.var "comparable")
                    )
            }
    , compare =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "compare"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable", Type.var "comparable" ]
                        (Type.namedWith [ "Basics" ] "Order" [])
                    )
            }
    , not =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "not"
            , annotation = Just (Type.function [ Type.bool ] Type.bool)
            }
    , xor =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "xor"
            , annotation =
                Just (Type.function [ Type.bool, Type.bool ] Type.bool)
            }
    , modBy =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "modBy"
            , annotation = Just (Type.function [ Type.int, Type.int ] Type.int)
            }
    , remainderBy =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "remainderBy"
            , annotation = Just (Type.function [ Type.int, Type.int ] Type.int)
            }
    , negate =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "negate"
            , annotation =
                Just (Type.function [ Type.var "number" ] (Type.var "number"))
            }
    , abs =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "abs"
            , annotation =
                Just (Type.function [ Type.var "number" ] (Type.var "number"))
            }
    , clamp =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "clamp"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "number"
                        , Type.var "number"
                        , Type.var "number"
                        ]
                        (Type.var "number")
                    )
            }
    , sqrt =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "sqrt"
            , annotation = Just (Type.function [ Type.float ] Type.float)
            }
    , logBase =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "logBase"
            , annotation =
                Just (Type.function [ Type.float, Type.float ] Type.float)
            }
    , e =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "e"
            , annotation = Just Type.float
            }
    , degrees =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "degrees"
            , annotation = Just (Type.function [ Type.float ] Type.float)
            }
    , radians =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "radians"
            , annotation = Just (Type.function [ Type.float ] Type.float)
            }
    , turns =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "turns"
            , annotation = Just (Type.function [ Type.float ] Type.float)
            }
    , pi =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "pi"
            , annotation = Just Type.float
            }
    , cos =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "cos"
            , annotation = Just (Type.function [ Type.float ] Type.float)
            }
    , sin =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "sin"
            , annotation = Just (Type.function [ Type.float ] Type.float)
            }
    , tan =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "tan"
            , annotation = Just (Type.function [ Type.float ] Type.float)
            }
    , acos =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "acos"
            , annotation = Just (Type.function [ Type.float ] Type.float)
            }
    , asin =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "asin"
            , annotation = Just (Type.function [ Type.float ] Type.float)
            }
    , atan =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "atan"
            , annotation = Just (Type.function [ Type.float ] Type.float)
            }
    , atan2 =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "atan2"
            , annotation =
                Just (Type.function [ Type.float, Type.float ] Type.float)
            }
    , toPolar =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "toPolar"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple Type.float Type.float ]
                        (Type.tuple Type.float Type.float)
                    )
            }
    , fromPolar =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "fromPolar"
            , annotation =
                Just
                    (Type.function
                        [ Type.tuple Type.float Type.float ]
                        (Type.tuple Type.float Type.float)
                    )
            }
    , isNaN =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "isNaN"
            , annotation = Just (Type.function [ Type.float ] Type.bool)
            }
    , isInfinite =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "isInfinite"
            , annotation = Just (Type.function [ Type.float ] Type.bool)
            }
    , identity =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "identity"
            , annotation = Just (Type.function [ Type.var "a" ] (Type.var "a"))
            }
    , always =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "always"
            , annotation =
                Just
                    (Type.function [ Type.var "a", Type.var "b" ] (Type.var "a"))
            }
    , never =
        Elm.value
            { importFrom = [ "Basics" ]
            , name = "never"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Basics" ] "Never" [] ]
                        (Type.var "a")
                    )
            }
    }
