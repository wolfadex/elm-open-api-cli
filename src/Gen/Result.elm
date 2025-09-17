module Gen.Result exposing
    ( make_, caseOf_, values_
    , fromMaybe
    )

{-|


# Generated bindings for Result

@docs map
@docs fromMaybeError
@docs make_, caseOf_, values_

-}

import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| Convert from a simple `Maybe` to interact with some code that primarily
uses `Results`.

    parseInt : String -> Maybe Int

    resultParseInt : String -> Result String Int
    resultParseInt string =
        fromMaybe ("error parsing string: " ++ toString string) (parseInt string)

fromMaybe: x -> Maybe a -> Result.Result x a

-}
fromMaybe : Elm.Expression -> Elm.Expression -> Elm.Expression
fromMaybe fromMaybeArg_ fromMaybeArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Result" ]
            , name = "fromMaybe"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "x", Type.maybe (Type.var "a") ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        )
                    )
            }
        )
        [ fromMaybeArg_, fromMaybeArg_0 ]


make_ :
    { ok : Elm.Expression -> Elm.Expression
    , err : Elm.Expression -> Elm.Expression
    }
make_ =
    { ok =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Result" ]
                    , name = "Ok"
                    , annotation =
                        Just
                            (Type.namedWith
                                []
                                "Result"
                                [ Type.var "error", Type.var "value" ]
                            )
                    }
                )
                [ ar0 ]
    , err =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Result" ]
                    , name = "Err"
                    , annotation =
                        Just
                            (Type.namedWith
                                []
                                "Result"
                                [ Type.var "error", Type.var "value" ]
                            )
                    }
                )
                [ ar0 ]
    }


caseOf_ :
    { result :
        Elm.Expression
        ->
            { ok : Elm.Expression -> Elm.Expression
            , err : Elm.Expression -> Elm.Expression
            }
        -> Elm.Expression
    }
caseOf_ =
    { result =
        \resultExpression resultTags ->
            Elm.Case.custom
                resultExpression
                (Type.namedWith
                    [ "Result" ]
                    "Result"
                    [ Type.var "error", Type.var "value" ]
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType "Ok" resultTags.ok
                        |> Elm.Arg.item
                            (Elm.Arg.varWith
                                "value"
                                (Type.var
                                    "value"
                                )
                            )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Err" resultTags.err
                        |> Elm.Arg.item
                            (Elm.Arg.varWith
                                "error"
                                (Type.var
                                    "error"
                                )
                            )
                    )
                    Basics.identity
                ]
    }


values_ :
    { map : Elm.Expression
    , map2 : Elm.Expression
    , map3 : Elm.Expression
    , map4 : Elm.Expression
    , map5 : Elm.Expression
    , andThen : Elm.Expression
    , withDefault : Elm.Expression
    , toMaybe : Elm.Expression
    , fromMaybe : Elm.Expression
    , mapError : Elm.Expression
    }
values_ =
    { map =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "value")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "value" ]
                        )
                    )
            }
    , map2 =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "map2"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "b" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "value" ]
                        )
                    )
            }
    , map3 =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "map3"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b", Type.var "c" ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "b" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "c" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "value" ]
                        )
                    )
            }
    , map4 =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "map4"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a"
                            , Type.var "b"
                            , Type.var "c"
                            , Type.var "d"
                            ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "b" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "c" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "d" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "value" ]
                        )
                    )
            }
    , map5 =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "map5"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a"
                            , Type.var "b"
                            , Type.var "c"
                            , Type.var "d"
                            , Type.var "e"
                            ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "b" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "c" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "d" ]
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "e" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "value" ]
                        )
                    )
            }
    , andThen =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "andThen"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.var "x", Type.var "b" ]
                            )
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "b" ]
                        )
                    )
            }
    , withDefault =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "withDefault"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a"
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.var "a")
                    )
            }
    , toMaybe =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "toMaybe"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.maybe (Type.var "a"))
                    )
            }
    , fromMaybe =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "fromMaybe"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "x", Type.maybe (Type.var "a") ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        )
                    )
            }
    , mapError =
        Elm.value
            { importFrom = [ "Result" ]
            , name = "mapError"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "x" ] (Type.var "y")
                        , Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "x", Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.var "y", Type.var "a" ]
                        )
                    )
            }
    }
