module Gen.Parser.Advanced exposing (call_)

{-|


# Generated bindings for Parser.Advanced

@docs call_

-}

import Elm
import Elm.Annotation as Type


call_ :
    { run : Elm.Expression -> Elm.Expression -> Elm.Expression
    , inContext : Elm.Expression -> Elm.Expression -> Elm.Expression
    , int : Elm.Expression -> Elm.Expression -> Elm.Expression
    , float : Elm.Expression -> Elm.Expression -> Elm.Expression
    , number : Elm.Expression -> Elm.Expression
    , symbol : Elm.Expression -> Elm.Expression
    , keyword : Elm.Expression -> Elm.Expression
    , variable : Elm.Expression -> Elm.Expression
    , end : Elm.Expression -> Elm.Expression
    , succeed : Elm.Expression -> Elm.Expression
    , lazy : Elm.Expression -> Elm.Expression
    , andThen : Elm.Expression -> Elm.Expression -> Elm.Expression
    , problem : Elm.Expression -> Elm.Expression
    , oneOf : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , backtrackable : Elm.Expression -> Elm.Expression
    , commit : Elm.Expression -> Elm.Expression
    , token : Elm.Expression -> Elm.Expression
    , sequence : Elm.Expression -> Elm.Expression
    , loop : Elm.Expression -> Elm.Expression -> Elm.Expression
    , lineComment : Elm.Expression -> Elm.Expression
    , multiComment :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , getChompedString : Elm.Expression -> Elm.Expression
    , chompIf : Elm.Expression -> Elm.Expression -> Elm.Expression
    , chompWhile : Elm.Expression -> Elm.Expression
    , chompUntil : Elm.Expression -> Elm.Expression
    , chompUntilEndOr : Elm.Expression -> Elm.Expression
    , mapChompedString : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withIndent : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { run =
        \runArg_ runArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "run"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                , Type.string
                                ]
                                (Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.list
                                        (Type.namedWith
                                            [ "Parser", "Advanced" ]
                                            "DeadEnd"
                                            [ Type.var "c", Type.var "x" ]
                                        )
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ runArg_, runArg_0 ]
    , inContext =
        \inContextArg_ inContextArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "inContext"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "context"
                                , Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "context"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "context"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ inContextArg_, inContextArg_0 ]
    , int =
        \intArg_ intArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "int"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "x", Type.var "x" ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c", Type.var "x", Type.int ]
                                )
                            )
                    }
                )
                [ intArg_, intArg_0 ]
    , float =
        \floatArg_ floatArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "float"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "x", Type.var "x" ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.float
                                    ]
                                )
                            )
                    }
                )
                [ floatArg_, floatArg_0 ]
    , number =
        \numberArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "number"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "int"
                                      , Type.namedWith
                                            [ "Result" ]
                                            "Result"
                                            [ Type.var "x"
                                            , Type.function
                                                [ Type.int ]
                                                (Type.var "a")
                                            ]
                                      )
                                    , ( "hex"
                                      , Type.namedWith
                                            [ "Result" ]
                                            "Result"
                                            [ Type.var "x"
                                            , Type.function
                                                [ Type.int ]
                                                (Type.var "a")
                                            ]
                                      )
                                    , ( "octal"
                                      , Type.namedWith
                                            [ "Result" ]
                                            "Result"
                                            [ Type.var "x"
                                            , Type.function
                                                [ Type.int ]
                                                (Type.var "a")
                                            ]
                                      )
                                    , ( "binary"
                                      , Type.namedWith
                                            [ "Result" ]
                                            "Result"
                                            [ Type.var "x"
                                            , Type.function
                                                [ Type.int ]
                                                (Type.var "a")
                                            ]
                                      )
                                    , ( "float"
                                      , Type.namedWith
                                            [ "Result" ]
                                            "Result"
                                            [ Type.var "x"
                                            , Type.function
                                                [ Type.float ]
                                                (Type.var "a")
                                            ]
                                      )
                                    , ( "invalid", Type.var "x" )
                                    , ( "expecting", Type.var "x" )
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ numberArg_ ]
    , symbol =
        \symbolArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "symbol"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Token"
                                    [ Type.var "x" ]
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c", Type.var "x", Type.unit ]
                                )
                            )
                    }
                )
                [ symbolArg_ ]
    , keyword =
        \keywordArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "keyword"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Token"
                                    [ Type.var "x" ]
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c", Type.var "x", Type.unit ]
                                )
                            )
                    }
                )
                [ keywordArg_ ]
    , variable =
        \variableArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "variable"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "start"
                                      , Type.function [ Type.char ] Type.bool
                                      )
                                    , ( "inner"
                                      , Type.function [ Type.char ] Type.bool
                                      )
                                    , ( "reserved"
                                      , Type.namedWith
                                            [ "Set" ]
                                            "Set"
                                            [ Type.string ]
                                      )
                                    , ( "expecting", Type.var "x" )
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.string
                                    ]
                                )
                            )
                    }
                )
                [ variableArg_ ]
    , end =
        \endArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "end"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "x" ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c", Type.var "x", Type.unit ]
                                )
                            )
                    }
                )
                [ endArg_ ]
    , succeed =
        \succeedArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "succeed"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "a" ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ succeedArg_ ]
    , lazy =
        \lazyArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "lazy"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.unit ]
                                    (Type.namedWith
                                        [ "Parser", "Advanced" ]
                                        "Parser"
                                        [ Type.var "c"
                                        , Type.var "x"
                                        , Type.var "a"
                                        ]
                                    )
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ lazyArg_ ]
    , andThen =
        \andThenArg_ andThenArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "andThen"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.namedWith
                                        [ "Parser", "Advanced" ]
                                        "Parser"
                                        [ Type.var "c"
                                        , Type.var "x"
                                        , Type.var "b"
                                        ]
                                    )
                                , Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "b"
                                    ]
                                )
                            )
                    }
                )
                [ andThenArg_, andThenArg_0 ]
    , problem =
        \problemArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "problem"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "x" ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ problemArg_ ]
    , oneOf =
        \oneOfArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "oneOf"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.namedWith
                                        [ "Parser", "Advanced" ]
                                        "Parser"
                                        [ Type.var "c"
                                        , Type.var "x"
                                        , Type.var "a"
                                        ]
                                    )
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ oneOfArg_ ]
    , map =
        \mapArg_ mapArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "map"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.var "b")
                                , Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "b"
                                    ]
                                )
                            )
                    }
                )
                [ mapArg_, mapArg_0 ]
    , backtrackable =
        \backtrackableArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "backtrackable"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ backtrackableArg_ ]
    , commit =
        \commitArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "commit"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "a" ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ commitArg_ ]
    , token =
        \tokenArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "token"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Token"
                                    [ Type.var "x" ]
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c", Type.var "x", Type.unit ]
                                )
                            )
                    }
                )
                [ tokenArg_ ]
    , sequence =
        \sequenceArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "sequence"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "start"
                                      , Type.namedWith
                                            [ "Parser", "Advanced" ]
                                            "Token"
                                            [ Type.var "x" ]
                                      )
                                    , ( "separator"
                                      , Type.namedWith
                                            [ "Parser", "Advanced" ]
                                            "Token"
                                            [ Type.var "x" ]
                                      )
                                    , ( "end"
                                      , Type.namedWith
                                            [ "Parser", "Advanced" ]
                                            "Token"
                                            [ Type.var "x" ]
                                      )
                                    , ( "spaces"
                                      , Type.namedWith
                                            [ "Parser", "Advanced" ]
                                            "Parser"
                                            [ Type.var "c"
                                            , Type.var "x"
                                            , Type.unit
                                            ]
                                      )
                                    , ( "item"
                                      , Type.namedWith
                                            [ "Parser", "Advanced" ]
                                            "Parser"
                                            [ Type.var "c"
                                            , Type.var "x"
                                            , Type.var "a"
                                            ]
                                      )
                                    , ( "trailing"
                                      , Type.namedWith
                                            [ "Parser", "Advanced" ]
                                            "Trailing"
                                            []
                                      )
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.list (Type.var "a")
                                    ]
                                )
                            )
                    }
                )
                [ sequenceArg_ ]
    , loop =
        \loopArg_ loopArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "loop"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "state"
                                , Type.function
                                    [ Type.var "state" ]
                                    (Type.namedWith
                                        [ "Parser", "Advanced" ]
                                        "Parser"
                                        [ Type.var "c"
                                        , Type.var "x"
                                        , Type.namedWith
                                            [ "Parser", "Advanced" ]
                                            "Step"
                                            [ Type.var "state"
                                            , Type.var "a"
                                            ]
                                        ]
                                    )
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ loopArg_, loopArg_0 ]
    , lineComment =
        \lineCommentArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "lineComment"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Token"
                                    [ Type.var "x" ]
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c", Type.var "x", Type.unit ]
                                )
                            )
                    }
                )
                [ lineCommentArg_ ]
    , multiComment =
        \multiCommentArg_ multiCommentArg_0 multiCommentArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "multiComment"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Token"
                                    [ Type.var "x" ]
                                , Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Token"
                                    [ Type.var "x" ]
                                , Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Nestable"
                                    []
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c", Type.var "x", Type.unit ]
                                )
                            )
                    }
                )
                [ multiCommentArg_, multiCommentArg_0, multiCommentArg_1 ]
    , getChompedString =
        \getChompedStringArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "getChompedString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.string
                                    ]
                                )
                            )
                    }
                )
                [ getChompedStringArg_ ]
    , chompIf =
        \chompIfArg_ chompIfArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "chompIf"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.char ] Type.bool
                                , Type.var "x"
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c", Type.var "x", Type.unit ]
                                )
                            )
                    }
                )
                [ chompIfArg_, chompIfArg_0 ]
    , chompWhile =
        \chompWhileArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "chompWhile"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.char ] Type.bool ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c", Type.var "x", Type.unit ]
                                )
                            )
                    }
                )
                [ chompWhileArg_ ]
    , chompUntil =
        \chompUntilArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "chompUntil"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Token"
                                    [ Type.var "x" ]
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c", Type.var "x", Type.unit ]
                                )
                            )
                    }
                )
                [ chompUntilArg_ ]
    , chompUntilEndOr =
        \chompUntilEndOrArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "chompUntilEndOr"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c", Type.var "x", Type.unit ]
                                )
                            )
                    }
                )
                [ chompUntilEndOrArg_ ]
    , mapChompedString =
        \mapChompedStringArg_ mapChompedStringArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "mapChompedString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.string, Type.var "a" ]
                                    (Type.var "b")
                                , Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "b"
                                    ]
                                )
                            )
                    }
                )
                [ mapChompedStringArg_, mapChompedStringArg_0 ]
    , withIndent =
        \withIndentArg_ withIndentArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Parser", "Advanced" ]
                    , name = "withIndent"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int
                                , Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ withIndentArg_, withIndentArg_0 ]
    }
