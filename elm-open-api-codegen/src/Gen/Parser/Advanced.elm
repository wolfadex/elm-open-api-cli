module Gen.Parser.Advanced exposing
    ( moduleName_, run, inContext, int, float, number
    , symbol, keyword, variable, end, succeed, lazy, andThen
    , problem, oneOf, map, backtrackable, commit, token, sequence
    , loop, spaces, lineComment, multiComment, getChompedString, chompIf, chompWhile
    , chompUntil, chompUntilEndOr, mapChompedString, withIndent, getIndent, getPosition, getRow
    , getCol, getOffset, getSource, annotation_, make_, caseOf_, call_
    , values_
    )

{-|
# Generated bindings for Parser.Advanced

@docs moduleName_, run, inContext, int, float, number
@docs symbol, keyword, variable, end, succeed, lazy
@docs andThen, problem, oneOf, map, backtrackable, commit
@docs token, sequence, loop, spaces, lineComment, multiComment
@docs getChompedString, chompIf, chompWhile, chompUntil, chompUntilEndOr, mapChompedString
@docs withIndent, getIndent, getPosition, getRow, getCol, getOffset
@docs getSource, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Parser", "Advanced" ]


{-| This works just like [`Parser.run`](/packages/elm/parser/latest/Parser#run).
The only difference is that when it fails, it has much more precise information
for each dead end.

run: 
    Parser.Advanced.Parser c x a
    -> String
    -> Result.Result (List (Parser.Advanced.DeadEnd c x)) a
-}
run : Elm.Expression -> String -> Elm.Expression
run runArg_ runArg_0 =
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
                              [ Type.var "c", Type.var "x", Type.var "a" ]
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
        [ runArg_, Elm.string runArg_0 ]


{-| This is how you mark that you are in a certain context. For example, here
is a rough outline of some code that uses `inContext` to mark when you are
parsing a specific definition:

    import Char
    import Parser.Advanced exposing (..)
    import Set

    type Context
      = Definition String
      | List

    definition : Parser Context Problem Expr
    definition =
      functionName
        |> andThen definitionBody

    definitionBody : String -> Parser Context Problem Expr
    definitionBody name =
      inContext (Definition name) <|
        succeed (Function name)
          |= arguments
          |. symbol (Token "=" ExpectingEquals)
          |= expression

    functionName : Parser c Problem String
    functionName =
      variable
        { start = Char.isLower
        , inner = Char.isAlphaNum
        , reserved = Set.fromList ["let","in"]
        , expecting = ExpectingFunctionName
        }

First we parse the function name, and then we parse the rest of the definition.
Importantly, we call `inContext` so that any dead end that occurs in
`definitionBody` will get this extra context information. That way you can say
things like, “I was expecting an equals sign in the `view` definition.” Context!

inContext: 
    context
    -> Parser.Advanced.Parser context x a
    -> Parser.Advanced.Parser context x a
-}
inContext : Elm.Expression -> Elm.Expression -> Elm.Expression
inContext inContextArg_ inContextArg_0 =
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
                              [ Type.var "context", Type.var "x", Type.var "a" ]
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


{-| Just like [`Parser.int`](Parser#int) where you have to handle negation
yourself. The only difference is that you provide a two potential problems:

    int : x -> x -> Parser c x Int
    int expecting invalid =
      number
        { int = Ok identity
        , hex = Err invalid
        , octal = Err invalid
        , binary = Err invalid
        , float = Err invalid
        , invalid = invalid
        , expecting = expecting
        }

You can use problems like `ExpectingInt` and `InvalidNumber`.

int: x -> x -> Parser.Advanced.Parser c x Int
-}
int : Elm.Expression -> Elm.Expression -> Elm.Expression
int intArg_ intArg_0 =
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


{-| Just like [`Parser.float`](Parser#float) where you have to handle negation
yourself. The only difference is that you provide a two potential problems:

    float : x -> x -> Parser c x Float
    float expecting invalid =
      number
        { int = Ok toFloat
        , hex = Err invalid
        , octal = Err invalid
        , binary = Err invalid
        , float = Ok identity
        , invalid = invalid
        , expecting = expecting
        }

You can use problems like `ExpectingFloat` and `InvalidNumber`.

float: x -> x -> Parser.Advanced.Parser c x Float
-}
float : Elm.Expression -> Elm.Expression -> Elm.Expression
float floatArg_ floatArg_0 =
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
                               [ Type.var "c", Type.var "x", Type.float ]
                          )
                     )
             }
        )
        [ floatArg_, floatArg_0 ]


{-| Just like [`Parser.number`](Parser#number) where you have to handle
negation yourself. The only difference is that you provide all the potential
problems.

number: 
    { int : Result.Result x (Int -> a)
    , hex : Result.Result x (Int -> a)
    , octal : Result.Result x (Int -> a)
    , binary : Result.Result x (Int -> a)
    , float : Result.Result x (Float -> a)
    , invalid : x
    , expecting : x
    }
    -> Parser.Advanced.Parser c x a
-}
number :
    { int : Elm.Expression
    , hex : Elm.Expression
    , octal : Elm.Expression
    , binary : Elm.Expression
    , float : Elm.Expression
    , invalid : Elm.Expression
    , expecting : Elm.Expression
    }
    -> Elm.Expression
number numberArg_ =
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
                                    , Type.function [ Type.int ] (Type.var "a")
                                    ]
                                )
                              , ( "hex"
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x"
                                    , Type.function [ Type.int ] (Type.var "a")
                                    ]
                                )
                              , ( "octal"
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x"
                                    , Type.function [ Type.int ] (Type.var "a")
                                    ]
                                )
                              , ( "binary"
                                , Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x"
                                    , Type.function [ Type.int ] (Type.var "a")
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
                               [ Type.var "c", Type.var "x", Type.var "a" ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "int" numberArg_.int
            , Tuple.pair "hex" numberArg_.hex
            , Tuple.pair "octal" numberArg_.octal
            , Tuple.pair "binary" numberArg_.binary
            , Tuple.pair "float" numberArg_.float
            , Tuple.pair "invalid" numberArg_.invalid
            , Tuple.pair "expecting" numberArg_.expecting
            ]
        ]


{-| Just like [`Parser.symbol`](Parser#symbol) except you provide a `Token` to
clearly indicate your custom type of problems:

    comma : Parser Context Problem ()
    comma =
      symbol (Token "," ExpectingComma)

symbol: Parser.Advanced.Token x -> Parser.Advanced.Parser c x ()
-}
symbol : Elm.Expression -> Elm.Expression
symbol symbolArg_ =
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


{-| Just like [`Parser.keyword`](Parser#keyword) except you provide a `Token`
to clearly indicate your custom type of problems:

    let_ : Parser Context Problem ()
    let_ =
      symbol (Token "let" ExpectingLet)

Note that this would fail to chomp `letter` because of the subsequent
characters. Use `token` if you do not want that last letter check.

keyword: Parser.Advanced.Token x -> Parser.Advanced.Parser c x ()
-}
keyword : Elm.Expression -> Elm.Expression
keyword keywordArg_ =
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


{-| Just like [`Parser.variable`](Parser#variable) except you specify the
problem yourself.

variable: 
    { start : Char.Char -> Bool
    , inner : Char.Char -> Bool
    , reserved : Set.Set String
    , expecting : x
    }
    -> Parser.Advanced.Parser c x String
-}
variable :
    { start : Elm.Expression -> Elm.Expression
    , inner : Elm.Expression -> Elm.Expression
    , reserved : Elm.Expression
    , expecting : Elm.Expression
    }
    -> Elm.Expression
variable variableArg_ =
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
                                , Type.namedWith [ "Set" ] "Set" [ Type.string ]
                                )
                              , ( "expecting", Type.var "x" )
                              ]
                          ]
                          (Type.namedWith
                               [ "Parser", "Advanced" ]
                               "Parser"
                               [ Type.var "c", Type.var "x", Type.string ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair
                  "start"
                  (Elm.functionReduced "variableUnpack" variableArg_.start)
            , Tuple.pair
                  "inner"
                  (Elm.functionReduced "variableUnpack" variableArg_.inner)
            , Tuple.pair "reserved" variableArg_.reserved
            , Tuple.pair "expecting" variableArg_.expecting
            ]
        ]


{-| Just like [`Parser.end`](Parser#end) except you provide the problem that
arises when the parser is not at the end of the input.

end: x -> Parser.Advanced.Parser c x ()
-}
end : Elm.Expression -> Elm.Expression
end endArg_ =
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


{-| Just like [`Parser.succeed`](Parser#succeed)

succeed: a -> Parser.Advanced.Parser c x a
-}
succeed : Elm.Expression -> Elm.Expression
succeed succeedArg_ =
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
                               [ Type.var "c", Type.var "x", Type.var "a" ]
                          )
                     )
             }
        )
        [ succeedArg_ ]


{-| Just like [`Parser.lazy`](Parser#lazy)

lazy: (() -> Parser.Advanced.Parser c x a) -> Parser.Advanced.Parser c x a
-}
lazy : (Elm.Expression -> Elm.Expression) -> Elm.Expression
lazy lazyArg_ =
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
                                 [ Type.var "c", Type.var "x", Type.var "a" ]
                              )
                          ]
                          (Type.namedWith
                               [ "Parser", "Advanced" ]
                               "Parser"
                               [ Type.var "c", Type.var "x", Type.var "a" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "lazyUnpack" lazyArg_ ]


{-| Just like [`Parser.andThen`](Parser#andThen)

andThen: 
    (a -> Parser.Advanced.Parser c x b)
    -> Parser.Advanced.Parser c x a
    -> Parser.Advanced.Parser c x b
-}
andThen : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
andThen andThenArg_ andThenArg_0 =
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
                                 [ Type.var "c", Type.var "x", Type.var "b" ]
                              )
                          , Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "Parser", "Advanced" ]
                               "Parser"
                               [ Type.var "c", Type.var "x", Type.var "b" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "andThenUnpack" andThenArg_, andThenArg_0 ]


{-| Just like [`Parser.problem`](Parser#problem) except you provide a custom
type for your problem.

problem: x -> Parser.Advanced.Parser c x a
-}
problem : Elm.Expression -> Elm.Expression
problem problemArg_ =
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
                               [ Type.var "c", Type.var "x", Type.var "a" ]
                          )
                     )
             }
        )
        [ problemArg_ ]


{-| Just like [`Parser.oneOf`](Parser#oneOf)

oneOf: List (Parser.Advanced.Parser c x a) -> Parser.Advanced.Parser c x a
-}
oneOf : List Elm.Expression -> Elm.Expression
oneOf oneOfArg_ =
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
                                 [ Type.var "c", Type.var "x", Type.var "a" ]
                              )
                          ]
                          (Type.namedWith
                               [ "Parser", "Advanced" ]
                               "Parser"
                               [ Type.var "c", Type.var "x", Type.var "a" ]
                          )
                     )
             }
        )
        [ Elm.list oneOfArg_ ]


{-| Just like [`Parser.map`](Parser#map)

map: (a -> b) -> Parser.Advanced.Parser c x a -> Parser.Advanced.Parser c x b
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg_ mapArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Parser", "Advanced" ]
             , name = "map"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function [ Type.var "a" ] (Type.var "b")
                          , Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "Parser", "Advanced" ]
                               "Parser"
                               [ Type.var "c", Type.var "x", Type.var "b" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapUnpack" mapArg_, mapArg_0 ]


{-| Just like [`Parser.backtrackable`](Parser#backtrackable)

backtrackable: Parser.Advanced.Parser c x a -> Parser.Advanced.Parser c x a
-}
backtrackable : Elm.Expression -> Elm.Expression
backtrackable backtrackableArg_ =
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
                              [ Type.var "c", Type.var "x", Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "Parser", "Advanced" ]
                               "Parser"
                               [ Type.var "c", Type.var "x", Type.var "a" ]
                          )
                     )
             }
        )
        [ backtrackableArg_ ]


{-| Just like [`Parser.commit`](Parser#commit)

commit: a -> Parser.Advanced.Parser c x a
-}
commit : Elm.Expression -> Elm.Expression
commit commitArg_ =
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
                               [ Type.var "c", Type.var "x", Type.var "a" ]
                          )
                     )
             }
        )
        [ commitArg_ ]


{-| Just like [`Parser.token`](Parser#token) except you provide a `Token`
specifying your custom type of problems.

token: Parser.Advanced.Token x -> Parser.Advanced.Parser c x ()
-}
token : Elm.Expression -> Elm.Expression
token tokenArg_ =
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


{-| Just like [`Parser.sequence`](Parser#sequence) except with a `Token` for
the start, separator, and end. That way you can specify your custom type of
problem for when something is not found.

sequence: 
    { start : Parser.Advanced.Token x
    , separator : Parser.Advanced.Token x
    , end : Parser.Advanced.Token x
    , spaces : Parser.Advanced.Parser c x ()
    , item : Parser.Advanced.Parser c x a
    , trailing : Parser.Advanced.Trailing
    }
    -> Parser.Advanced.Parser c x (List a)
-}
sequence :
    { start : Elm.Expression
    , separator : Elm.Expression
    , end : Elm.Expression
    , spaces : Elm.Expression
    , item : Elm.Expression
    , trailing : Elm.Expression
    }
    -> Elm.Expression
sequence sequenceArg_ =
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
                                    [ Type.var "c", Type.var "x", Type.unit ]
                                )
                              , ( "item"
                                , Type.namedWith
                                    [ "Parser", "Advanced" ]
                                    "Parser"
                                    [ Type.var "c", Type.var "x", Type.var "a" ]
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
        [ Elm.record
            [ Tuple.pair "start" sequenceArg_.start
            , Tuple.pair "separator" sequenceArg_.separator
            , Tuple.pair "end" sequenceArg_.end
            , Tuple.pair "spaces" sequenceArg_.spaces
            , Tuple.pair "item" sequenceArg_.item
            , Tuple.pair "trailing" sequenceArg_.trailing
            ]
        ]


{-| Just like [`Parser.loop`](Parser#loop)

loop: 
    state
    -> (state -> Parser.Advanced.Parser c x (Parser.Advanced.Step state a))
    -> Parser.Advanced.Parser c x a
-}
loop : Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
loop loopArg_ loopArg_0 =
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
                                       [ Type.var "state", Type.var "a" ]
                                 ]
                              )
                          ]
                          (Type.namedWith
                               [ "Parser", "Advanced" ]
                               "Parser"
                               [ Type.var "c", Type.var "x", Type.var "a" ]
                          )
                     )
             }
        )
        [ loopArg_, Elm.functionReduced "loopUnpack" loopArg_0 ]


{-| Just like [`Parser.spaces`](Parser#spaces)

spaces: Parser.Advanced.Parser c x ()
-}
spaces : Elm.Expression
spaces =
    Elm.value
        { importFrom = [ "Parser", "Advanced" ]
        , name = "spaces"
        , annotation =
            Just
                (Type.namedWith
                     [ "Parser", "Advanced" ]
                     "Parser"
                     [ Type.var "c", Type.var "x", Type.unit ]
                )
        }


{-| Just like [`Parser.lineComment`](Parser#lineComment) except you provide a
`Token` describing the starting symbol.

lineComment: Parser.Advanced.Token x -> Parser.Advanced.Parser c x ()
-}
lineComment : Elm.Expression -> Elm.Expression
lineComment lineCommentArg_ =
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


{-| Just like [`Parser.multiComment`](Parser#multiComment) except with a
`Token` for the open and close symbols.

multiComment: 
    Parser.Advanced.Token x
    -> Parser.Advanced.Token x
    -> Parser.Advanced.Nestable
    -> Parser.Advanced.Parser c x ()
-}
multiComment :
    Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
multiComment multiCommentArg_ multiCommentArg_0 multiCommentArg_1 =
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


{-| Just like [`Parser.getChompedString`](Parser#getChompedString)

getChompedString: Parser.Advanced.Parser c x a -> Parser.Advanced.Parser c x String
-}
getChompedString : Elm.Expression -> Elm.Expression
getChompedString getChompedStringArg_ =
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
                              [ Type.var "c", Type.var "x", Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "Parser", "Advanced" ]
                               "Parser"
                               [ Type.var "c", Type.var "x", Type.string ]
                          )
                     )
             }
        )
        [ getChompedStringArg_ ]


{-| Just like [`Parser.chompIf`](Parser#chompIf) except you provide a problem
in case a character cannot be chomped.

chompIf: (Char.Char -> Bool) -> x -> Parser.Advanced.Parser c x ()
-}
chompIf : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
chompIf chompIfArg_ chompIfArg_0 =
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
        [ Elm.functionReduced "chompIfUnpack" chompIfArg_, chompIfArg_0 ]


{-| Just like [`Parser.chompWhile`](Parser#chompWhile)

chompWhile: (Char.Char -> Bool) -> Parser.Advanced.Parser c x ()
-}
chompWhile : (Elm.Expression -> Elm.Expression) -> Elm.Expression
chompWhile chompWhileArg_ =
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
        [ Elm.functionReduced "chompWhileUnpack" chompWhileArg_ ]


{-| Just like [`Parser.chompUntil`](Parser#chompUntil) except you provide a
`Token` in case you chomp all the way to the end of the input without finding
what you need.

chompUntil: Parser.Advanced.Token x -> Parser.Advanced.Parser c x ()
-}
chompUntil : Elm.Expression -> Elm.Expression
chompUntil chompUntilArg_ =
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


{-| Just like [`Parser.chompUntilEndOr`](Parser#chompUntilEndOr)

chompUntilEndOr: String -> Parser.Advanced.Parser c x ()
-}
chompUntilEndOr : String -> Elm.Expression
chompUntilEndOr chompUntilEndOrArg_ =
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
        [ Elm.string chompUntilEndOrArg_ ]


{-| Just like [`Parser.mapChompedString`](Parser#mapChompedString)

mapChompedString: 
    (String -> a -> b)
    -> Parser.Advanced.Parser c x a
    -> Parser.Advanced.Parser c x b
-}
mapChompedString :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
mapChompedString mapChompedStringArg_ mapChompedStringArg_0 =
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
                              [ Type.var "c", Type.var "x", Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "Parser", "Advanced" ]
                               "Parser"
                               [ Type.var "c", Type.var "x", Type.var "b" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "mapChompedStringUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (mapChompedStringArg_ functionReducedUnpack)
            )
        , mapChompedStringArg_0
        ]


{-| Just like [`Parser.withIndent`](Parser#withIndent)

withIndent: Int -> Parser.Advanced.Parser c x a -> Parser.Advanced.Parser c x a
-}
withIndent : Int -> Elm.Expression -> Elm.Expression
withIndent withIndentArg_ withIndentArg_0 =
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
                              [ Type.var "c", Type.var "x", Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "Parser", "Advanced" ]
                               "Parser"
                               [ Type.var "c", Type.var "x", Type.var "a" ]
                          )
                     )
             }
        )
        [ Elm.int withIndentArg_, withIndentArg_0 ]


{-| Just like [`Parser.getIndent`](Parser#getIndent)

getIndent: Parser.Advanced.Parser c x Int
-}
getIndent : Elm.Expression
getIndent =
    Elm.value
        { importFrom = [ "Parser", "Advanced" ]
        , name = "getIndent"
        , annotation =
            Just
                (Type.namedWith
                     [ "Parser", "Advanced" ]
                     "Parser"
                     [ Type.var "c", Type.var "x", Type.int ]
                )
        }


{-| Just like [`Parser.getPosition`](Parser#getPosition)

getPosition: Parser.Advanced.Parser c x ( Int, Int )
-}
getPosition : Elm.Expression
getPosition =
    Elm.value
        { importFrom = [ "Parser", "Advanced" ]
        , name = "getPosition"
        , annotation =
            Just
                (Type.namedWith
                     [ "Parser", "Advanced" ]
                     "Parser"
                     [ Type.var "c"
                     , Type.var "x"
                     , Type.tuple Type.int Type.int
                     ]
                )
        }


{-| Just like [`Parser.getRow`](Parser#getRow)

getRow: Parser.Advanced.Parser c x Int
-}
getRow : Elm.Expression
getRow =
    Elm.value
        { importFrom = [ "Parser", "Advanced" ]
        , name = "getRow"
        , annotation =
            Just
                (Type.namedWith
                     [ "Parser", "Advanced" ]
                     "Parser"
                     [ Type.var "c", Type.var "x", Type.int ]
                )
        }


{-| Just like [`Parser.getCol`](Parser#getCol)

getCol: Parser.Advanced.Parser c x Int
-}
getCol : Elm.Expression
getCol =
    Elm.value
        { importFrom = [ "Parser", "Advanced" ]
        , name = "getCol"
        , annotation =
            Just
                (Type.namedWith
                     [ "Parser", "Advanced" ]
                     "Parser"
                     [ Type.var "c", Type.var "x", Type.int ]
                )
        }


{-| Just like [`Parser.getOffset`](Parser#getOffset)

getOffset: Parser.Advanced.Parser c x Int
-}
getOffset : Elm.Expression
getOffset =
    Elm.value
        { importFrom = [ "Parser", "Advanced" ]
        , name = "getOffset"
        , annotation =
            Just
                (Type.namedWith
                     [ "Parser", "Advanced" ]
                     "Parser"
                     [ Type.var "c", Type.var "x", Type.int ]
                )
        }


{-| Just like [`Parser.getSource`](Parser#getSource)

getSource: Parser.Advanced.Parser c x String
-}
getSource : Elm.Expression
getSource =
    Elm.value
        { importFrom = [ "Parser", "Advanced" ]
        , name = "getSource"
        , annotation =
            Just
                (Type.namedWith
                     [ "Parser", "Advanced" ]
                     "Parser"
                     [ Type.var "c", Type.var "x", Type.string ]
                )
        }


annotation_ :
    { parser :
        Type.Annotation -> Type.Annotation -> Type.Annotation -> Type.Annotation
    , deadEnd : Type.Annotation -> Type.Annotation -> Type.Annotation
    , token : Type.Annotation -> Type.Annotation
    , trailing : Type.Annotation
    , step : Type.Annotation -> Type.Annotation -> Type.Annotation
    , nestable : Type.Annotation
    }
annotation_ =
    { parser =
        \parserArg0 parserArg1 parserArg2 ->
            Type.namedWith
                [ "Parser", "Advanced" ]
                "Parser"
                [ parserArg0, parserArg1, parserArg2 ]
    , deadEnd =
        \deadEndArg0 deadEndArg1 ->
            Type.alias
                moduleName_
                "DeadEnd"
                [ deadEndArg0, deadEndArg1 ]
                (Type.record
                     [ ( "row", Type.int )
                     , ( "col", Type.int )
                     , ( "problem", Type.var "problem" )
                     , ( "contextStack"
                       , Type.list
                             (Type.record
                                  [ ( "row", Type.int )
                                  , ( "col", Type.int )
                                  , ( "context", Type.var "context" )
                                  ]
                             )
                       )
                     ]
                )
    , token =
        \tokenArg0 ->
            Type.namedWith [ "Parser", "Advanced" ] "Token" [ tokenArg0 ]
    , trailing = Type.namedWith [ "Parser", "Advanced" ] "Trailing" []
    , step =
        \stepArg0 stepArg1 ->
            Type.namedWith
                [ "Parser", "Advanced" ]
                "Step"
                [ stepArg0, stepArg1 ]
    , nestable = Type.namedWith [ "Parser", "Advanced" ] "Nestable" []
    }


make_ :
    { deadEnd :
        { row : Elm.Expression
        , col : Elm.Expression
        , problem : Elm.Expression
        , contextStack : Elm.Expression
        }
        -> Elm.Expression
    , token : Elm.Expression -> Elm.Expression -> Elm.Expression
    , forbidden : Elm.Expression
    , optional : Elm.Expression
    , mandatory : Elm.Expression
    , loop : Elm.Expression -> Elm.Expression
    , done : Elm.Expression -> Elm.Expression
    , notNestable : Elm.Expression
    , nestable : Elm.Expression
    }
make_ =
    { deadEnd =
        \deadEnd_args ->
            Elm.withType
                (Type.alias
                     [ "Parser", "Advanced" ]
                     "DeadEnd"
                     [ Type.var "context", Type.var "problem" ]
                     (Type.record
                          [ ( "row", Type.int )
                          , ( "col", Type.int )
                          , ( "problem", Type.var "problem" )
                          , ( "contextStack"
                            , Type.list
                                  (Type.record
                                       [ ( "row", Type.int )
                                       , ( "col", Type.int )
                                       , ( "context", Type.var "context" )
                                       ]
                                  )
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "row" deadEnd_args.row
                     , Tuple.pair "col" deadEnd_args.col
                     , Tuple.pair "problem" deadEnd_args.problem
                     , Tuple.pair "contextStack" deadEnd_args.contextStack
                     ]
                )
    , token =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Parser", "Advanced" ]
                     , name = "Token"
                     , annotation =
                         Just (Type.namedWith [] "Token" [ Type.var "x" ])
                     }
                )
                [ ar0, ar1 ]
    , forbidden =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "Forbidden"
            , annotation = Just (Type.namedWith [] "Trailing" [])
            }
    , optional =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "Optional"
            , annotation = Just (Type.namedWith [] "Trailing" [])
            }
    , mandatory =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "Mandatory"
            , annotation = Just (Type.namedWith [] "Trailing" [])
            }
    , loop =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Parser", "Advanced" ]
                     , name = "Loop"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Step"
                                  [ Type.var "state", Type.var "a" ]
                             )
                     }
                )
                [ ar0 ]
    , done =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Parser", "Advanced" ]
                     , name = "Done"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Step"
                                  [ Type.var "state", Type.var "a" ]
                             )
                     }
                )
                [ ar0 ]
    , notNestable =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "NotNestable"
            , annotation = Just (Type.namedWith [] "Nestable" [])
            }
    , nestable =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "Nestable"
            , annotation = Just (Type.namedWith [] "Nestable" [])
            }
    }


caseOf_ =
    { token =
        \tokenExpression tokenTags ->
            Elm.Case.custom
                tokenExpression
                (Type.namedWith
                     [ "Parser", "Advanced" ]
                     "Token"
                     [ Type.var "x" ]
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType "Token" tokenTags.token |> Elm.Arg.item
                                                                         (Elm.Arg.varWith
                                                                                "arg_0"
                                                                                Type.string
                                                                         ) |> Elm.Arg.item
                                                                                    (Elm.Arg.varWith
                                                                                           "x"
                                                                                           (Type.var
                                                                                                  "x"
                                                                                           )
                                                                                    )
                    )
                    Basics.identity
                ]
    , trailing =
        \trailingExpression trailingTags ->
            Elm.Case.custom
                trailingExpression
                (Type.namedWith [ "Parser", "Advanced" ] "Trailing" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType "Forbidden" trailingTags.forbidden)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Optional" trailingTags.optional)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Mandatory" trailingTags.mandatory)
                    Basics.identity
                ]
    , step =
        \stepExpression stepTags ->
            Elm.Case.custom
                stepExpression
                (Type.namedWith
                     [ "Parser", "Advanced" ]
                     "Step"
                     [ Type.var "state", Type.var "a" ]
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType "Loop" stepTags.loop |> Elm.Arg.item
                                                                      (Elm.Arg.varWith
                                                                             "state"
                                                                             (Type.var
                                                                                    "state"
                                                                             )
                                                                      )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Done" stepTags.done |> Elm.Arg.item
                                                                      (Elm.Arg.varWith
                                                                             "a"
                                                                             (Type.var
                                                                                    "a"
                                                                             )
                                                                      )
                    )
                    Basics.identity
                ]
    , nestable =
        \nestableExpression nestableTags ->
            Elm.Case.custom
                nestableExpression
                (Type.namedWith [ "Parser", "Advanced" ] "Nestable" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType "NotNestable" nestableTags.notNestable)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Nestable" nestableTags.nestable)
                    Basics.identity
                ]
    }


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


values_ :
    { run : Elm.Expression
    , inContext : Elm.Expression
    , int : Elm.Expression
    , float : Elm.Expression
    , number : Elm.Expression
    , symbol : Elm.Expression
    , keyword : Elm.Expression
    , variable : Elm.Expression
    , end : Elm.Expression
    , succeed : Elm.Expression
    , lazy : Elm.Expression
    , andThen : Elm.Expression
    , problem : Elm.Expression
    , oneOf : Elm.Expression
    , map : Elm.Expression
    , backtrackable : Elm.Expression
    , commit : Elm.Expression
    , token : Elm.Expression
    , sequence : Elm.Expression
    , loop : Elm.Expression
    , spaces : Elm.Expression
    , lineComment : Elm.Expression
    , multiComment : Elm.Expression
    , getChompedString : Elm.Expression
    , chompIf : Elm.Expression
    , chompWhile : Elm.Expression
    , chompUntil : Elm.Expression
    , chompUntilEndOr : Elm.Expression
    , mapChompedString : Elm.Expression
    , withIndent : Elm.Expression
    , getIndent : Elm.Expression
    , getPosition : Elm.Expression
    , getRow : Elm.Expression
    , getCol : Elm.Expression
    , getOffset : Elm.Expression
    , getSource : Elm.Expression
    }
values_ =
    { run =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "run"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Parser", "Advanced" ]
                             "Parser"
                             [ Type.var "c", Type.var "x", Type.var "a" ]
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
    , inContext =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "inContext"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "context"
                         , Type.namedWith
                             [ "Parser", "Advanced" ]
                             "Parser"
                             [ Type.var "context", Type.var "x", Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "context", Type.var "x", Type.var "a" ]
                         )
                    )
            }
    , int =
        Elm.value
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
    , float =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "float"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "x", Type.var "x" ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.float ]
                         )
                    )
            }
    , number =
        Elm.value
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
                                   , Type.function [ Type.int ] (Type.var "a")
                                   ]
                               )
                             , ( "hex"
                               , Type.namedWith
                                   [ "Result" ]
                                   "Result"
                                   [ Type.var "x"
                                   , Type.function [ Type.int ] (Type.var "a")
                                   ]
                               )
                             , ( "octal"
                               , Type.namedWith
                                   [ "Result" ]
                                   "Result"
                                   [ Type.var "x"
                                   , Type.function [ Type.int ] (Type.var "a")
                                   ]
                               )
                             , ( "binary"
                               , Type.namedWith
                                   [ "Result" ]
                                   "Result"
                                   [ Type.var "x"
                                   , Type.function [ Type.int ] (Type.var "a")
                                   ]
                               )
                             , ( "float"
                               , Type.namedWith
                                   [ "Result" ]
                                   "Result"
                                   [ Type.var "x"
                                   , Type.function [ Type.float ] (Type.var "a")
                                   ]
                               )
                             , ( "invalid", Type.var "x" )
                             , ( "expecting", Type.var "x" )
                             ]
                         ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.var "a" ]
                         )
                    )
            }
    , symbol =
        Elm.value
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
    , keyword =
        Elm.value
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
    , variable =
        Elm.value
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
                               , Type.namedWith [ "Set" ] "Set" [ Type.string ]
                               )
                             , ( "expecting", Type.var "x" )
                             ]
                         ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.string ]
                         )
                    )
            }
    , end =
        Elm.value
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
    , succeed =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "succeed"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "a" ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.var "a" ]
                         )
                    )
            }
    , lazy =
        Elm.value
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
                                [ Type.var "c", Type.var "x", Type.var "a" ]
                             )
                         ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.var "a" ]
                         )
                    )
            }
    , andThen =
        Elm.value
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
                                [ Type.var "c", Type.var "x", Type.var "b" ]
                             )
                         , Type.namedWith
                             [ "Parser", "Advanced" ]
                             "Parser"
                             [ Type.var "c", Type.var "x", Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.var "b" ]
                         )
                    )
            }
    , problem =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "problem"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "x" ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.var "a" ]
                         )
                    )
            }
    , oneOf =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "oneOf"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "Parser", "Advanced" ]
                                "Parser"
                                [ Type.var "c", Type.var "x", Type.var "a" ]
                             )
                         ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.var "a" ]
                         )
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.var "a" ] (Type.var "b")
                         , Type.namedWith
                             [ "Parser", "Advanced" ]
                             "Parser"
                             [ Type.var "c", Type.var "x", Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.var "b" ]
                         )
                    )
            }
    , backtrackable =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "backtrackable"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Parser", "Advanced" ]
                             "Parser"
                             [ Type.var "c", Type.var "x", Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.var "a" ]
                         )
                    )
            }
    , commit =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "commit"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "a" ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.var "a" ]
                         )
                    )
            }
    , token =
        Elm.value
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
    , sequence =
        Elm.value
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
                                   [ Type.var "c", Type.var "x", Type.unit ]
                               )
                             , ( "item"
                               , Type.namedWith
                                   [ "Parser", "Advanced" ]
                                   "Parser"
                                   [ Type.var "c", Type.var "x", Type.var "a" ]
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
    , loop =
        Elm.value
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
                                      [ Type.var "state", Type.var "a" ]
                                ]
                             )
                         ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.var "a" ]
                         )
                    )
            }
    , spaces =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "spaces"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Parser", "Advanced" ]
                         "Parser"
                         [ Type.var "c", Type.var "x", Type.unit ]
                    )
            }
    , lineComment =
        Elm.value
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
    , multiComment =
        Elm.value
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
                         , Type.namedWith [ "Parser", "Advanced" ] "Nestable" []
                         ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.unit ]
                         )
                    )
            }
    , getChompedString =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "getChompedString"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Parser", "Advanced" ]
                             "Parser"
                             [ Type.var "c", Type.var "x", Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.string ]
                         )
                    )
            }
    , chompIf =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "chompIf"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.char ] Type.bool, Type.var "x" ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.unit ]
                         )
                    )
            }
    , chompWhile =
        Elm.value
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
    , chompUntil =
        Elm.value
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
    , chompUntilEndOr =
        Elm.value
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
    , mapChompedString =
        Elm.value
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
                             [ Type.var "c", Type.var "x", Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.var "b" ]
                         )
                    )
            }
    , withIndent =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "withIndent"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.namedWith
                             [ "Parser", "Advanced" ]
                             "Parser"
                             [ Type.var "c", Type.var "x", Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "Parser", "Advanced" ]
                              "Parser"
                              [ Type.var "c", Type.var "x", Type.var "a" ]
                         )
                    )
            }
    , getIndent =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "getIndent"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Parser", "Advanced" ]
                         "Parser"
                         [ Type.var "c", Type.var "x", Type.int ]
                    )
            }
    , getPosition =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "getPosition"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Parser", "Advanced" ]
                         "Parser"
                         [ Type.var "c"
                         , Type.var "x"
                         , Type.tuple Type.int Type.int
                         ]
                    )
            }
    , getRow =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "getRow"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Parser", "Advanced" ]
                         "Parser"
                         [ Type.var "c", Type.var "x", Type.int ]
                    )
            }
    , getCol =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "getCol"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Parser", "Advanced" ]
                         "Parser"
                         [ Type.var "c", Type.var "x", Type.int ]
                    )
            }
    , getOffset =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "getOffset"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Parser", "Advanced" ]
                         "Parser"
                         [ Type.var "c", Type.var "x", Type.int ]
                    )
            }
    , getSource =
        Elm.value
            { importFrom = [ "Parser", "Advanced" ]
            , name = "getSource"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Parser", "Advanced" ]
                         "Parser"
                         [ Type.var "c", Type.var "x", Type.string ]
                    )
            }
    }