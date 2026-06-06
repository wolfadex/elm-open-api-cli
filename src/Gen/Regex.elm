module Gen.Regex exposing
    ( fromString, never
    , call_
    )

{-|


# Generated bindings for Regex

@docs fromString, never
@docs call_

-}

import Elm
import Elm.Annotation as Type


{-| Try to create a `Regex`. Not all strings are valid though, so you get a
\`Maybe' back. This means you can safely accept input from users.

    import Regex

    lowerCase : Regex.Regex
    lowerCase =
        Maybe.withDefault Regex.never <|
            Regex.fromString "[a-z]+"

**Note:** There are some [shorthand character classes][short] like `\w` for
word characters, `\s` for whitespace characters, and `\d` for digits. **Make
sure they are properly escaped!** If you specify them directly in your code,
they would look like `"\\w\\s\\d"`.

[short]: https://www.regular-expressions.info/shorthand.html

fromString: String -> Maybe Regex.Regex

-}
fromString : String -> Elm.Expression
fromString fromStringArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Regex" ]
            , name = "fromString"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.maybe (Type.namedWith [ "Regex" ] "Regex" []))
                    )
            }
        )
        [ Elm.string fromStringArg_ ]


{-| A regular expression that never matches any string.

never: Regex.Regex

-}
never : Elm.Expression
never =
    Elm.value
        { importFrom = [ "Regex" ]
        , name = "never"
        , annotation = Just (Type.namedWith [ "Regex" ] "Regex" [])
        }


call_ :
    { fromString : Elm.Expression -> Elm.Expression
    , fromStringWith : Elm.Expression -> Elm.Expression -> Elm.Expression
    , contains : Elm.Expression -> Elm.Expression -> Elm.Expression
    , split : Elm.Expression -> Elm.Expression -> Elm.Expression
    , find : Elm.Expression -> Elm.Expression -> Elm.Expression
    , replace :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , splitAtMost :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , findAtMost :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , replaceAtMost :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    }
call_ =
    { fromString =
        \fromStringArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Regex" ]
                    , name = "fromString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.maybe
                                    (Type.namedWith [ "Regex" ] "Regex" [])
                                )
                            )
                    }
                )
                [ fromStringArg_ ]
    , fromStringWith =
        \fromStringWithArg_ fromStringWithArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Regex" ]
                    , name = "fromStringWith"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Regex" ] "Options" []
                                , Type.string
                                ]
                                (Type.maybe
                                    (Type.namedWith [ "Regex" ] "Regex" [])
                                )
                            )
                    }
                )
                [ fromStringWithArg_, fromStringWithArg_0 ]
    , contains =
        \containsArg_ containsArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Regex" ]
                    , name = "contains"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Regex" ] "Regex" []
                                , Type.string
                                ]
                                Type.bool
                            )
                    }
                )
                [ containsArg_, containsArg_0 ]
    , split =
        \splitArg_ splitArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Regex" ]
                    , name = "split"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Regex" ] "Regex" []
                                , Type.string
                                ]
                                (Type.list Type.string)
                            )
                    }
                )
                [ splitArg_, splitArg_0 ]
    , find =
        \findArg_ findArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Regex" ]
                    , name = "find"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Regex" ] "Regex" []
                                , Type.string
                                ]
                                (Type.list
                                    (Type.namedWith [ "Regex" ] "Match" [])
                                )
                            )
                    }
                )
                [ findArg_, findArg_0 ]
    , replace =
        \replaceArg_ replaceArg_0 replaceArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Regex" ]
                    , name = "replace"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Regex" ] "Regex" []
                                , Type.function
                                    [ Type.namedWith [ "Regex" ] "Match" [] ]
                                    Type.string
                                , Type.string
                                ]
                                Type.string
                            )
                    }
                )
                [ replaceArg_, replaceArg_0, replaceArg_1 ]
    , splitAtMost =
        \splitAtMostArg_ splitAtMostArg_0 splitAtMostArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Regex" ]
                    , name = "splitAtMost"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int
                                , Type.namedWith [ "Regex" ] "Regex" []
                                , Type.string
                                ]
                                (Type.list Type.string)
                            )
                    }
                )
                [ splitAtMostArg_, splitAtMostArg_0, splitAtMostArg_1 ]
    , findAtMost =
        \findAtMostArg_ findAtMostArg_0 findAtMostArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Regex" ]
                    , name = "findAtMost"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int
                                , Type.namedWith [ "Regex" ] "Regex" []
                                , Type.string
                                ]
                                (Type.list
                                    (Type.namedWith [ "Regex" ] "Match" [])
                                )
                            )
                    }
                )
                [ findAtMostArg_, findAtMostArg_0, findAtMostArg_1 ]
    , replaceAtMost =
        \replaceAtMostArg_ replaceAtMostArg_0 replaceAtMostArg_1 replaceAtMostArg_2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Regex" ]
                    , name = "replaceAtMost"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int
                                , Type.namedWith [ "Regex" ] "Regex" []
                                , Type.function
                                    [ Type.namedWith [ "Regex" ] "Match" [] ]
                                    Type.string
                                , Type.string
                                ]
                                Type.string
                            )
                    }
                )
                [ replaceAtMostArg_
                , replaceAtMostArg_0
                , replaceAtMostArg_1
                , replaceAtMostArg_2
                ]
    }
