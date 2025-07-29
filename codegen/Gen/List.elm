module Gen.List exposing
    ( filterMap
    , call_, values_
    )

{-|


# Generated bindings for List

@docs map
@docs filterMap
@docs map34
@docs call_, values_

-}

import Elm
import Elm.Annotation as Type


{-| Filter out certain values. For example, maybe you have a bunch of strings
from an untrusted source and you want to turn them into numbers:


    numbers : List Int
    numbers =
        filterMap String.toInt [ "3", "hi", "12", "4th", "May" ]

    -- numbers == [3, 12]

filterMap: (a -> Maybe b) -> List a -> List b

-}
filterMap : (Elm.Expression -> Elm.Expression) -> List Elm.Expression -> Elm.Expression
filterMap filterMapArg_ filterMapArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "List" ]
            , name = "filterMap"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.maybe (Type.var "b"))
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "b"))
                    )
            }
        )
        [ Elm.functionReduced "filterMapUnpack" filterMapArg_
        , Elm.list filterMapArg_0
        ]


call_ :
    { singleton : Elm.Expression -> Elm.Expression
    , repeat : Elm.Expression -> Elm.Expression -> Elm.Expression
    , range : Elm.Expression -> Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , indexedMap : Elm.Expression -> Elm.Expression -> Elm.Expression
    , foldl :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , foldr :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , filter : Elm.Expression -> Elm.Expression -> Elm.Expression
    , filterMap : Elm.Expression -> Elm.Expression -> Elm.Expression
    , length : Elm.Expression -> Elm.Expression
    , reverse : Elm.Expression -> Elm.Expression
    , member : Elm.Expression -> Elm.Expression -> Elm.Expression
    , all : Elm.Expression -> Elm.Expression -> Elm.Expression
    , any : Elm.Expression -> Elm.Expression -> Elm.Expression
    , maximum : Elm.Expression -> Elm.Expression
    , minimum : Elm.Expression -> Elm.Expression
    , sum : Elm.Expression -> Elm.Expression
    , product : Elm.Expression -> Elm.Expression
    , append : Elm.Expression -> Elm.Expression -> Elm.Expression
    , concat : Elm.Expression -> Elm.Expression
    , concatMap : Elm.Expression -> Elm.Expression -> Elm.Expression
    , intersperse : Elm.Expression -> Elm.Expression -> Elm.Expression
    , map2 :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , map3 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map4 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map5 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , sort : Elm.Expression -> Elm.Expression
    , sortBy : Elm.Expression -> Elm.Expression -> Elm.Expression
    , sortWith : Elm.Expression -> Elm.Expression -> Elm.Expression
    , isEmpty : Elm.Expression -> Elm.Expression
    , head : Elm.Expression -> Elm.Expression
    , tail : Elm.Expression -> Elm.Expression
    , take : Elm.Expression -> Elm.Expression -> Elm.Expression
    , drop : Elm.Expression -> Elm.Expression -> Elm.Expression
    , partition : Elm.Expression -> Elm.Expression -> Elm.Expression
    , unzip : Elm.Expression -> Elm.Expression
    }
call_ =
    { singleton =
        \singletonArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "singleton"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "a" ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ singletonArg_ ]
    , repeat =
        \repeatArg_ repeatArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "repeat"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.var "a" ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ repeatArg_, repeatArg_0 ]
    , range =
        \rangeArg_ rangeArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "range"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.int ]
                                (Type.list Type.int)
                            )
                    }
                )
                [ rangeArg_, rangeArg_0 ]
    , map =
        \mapArg_ mapArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "map"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.var "b")
                                , Type.list (Type.var "a")
                                ]
                                (Type.list (Type.var "b"))
                            )
                    }
                )
                [ mapArg_, mapArg_0 ]
    , indexedMap =
        \indexedMapArg_ indexedMapArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "indexedMap"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.int, Type.var "a" ]
                                    (Type.var "b")
                                , Type.list (Type.var "a")
                                ]
                                (Type.list (Type.var "b"))
                            )
                    }
                )
                [ indexedMapArg_, indexedMapArg_0 ]
    , foldl =
        \foldlArg_ foldlArg_0 foldlArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "foldl"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "b" ]
                                    (Type.var "b")
                                , Type.var "b"
                                , Type.list (Type.var "a")
                                ]
                                (Type.var "b")
                            )
                    }
                )
                [ foldlArg_, foldlArg_0, foldlArg_1 ]
    , foldr =
        \foldrArg_ foldrArg_0 foldrArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "foldr"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "b" ]
                                    (Type.var "b")
                                , Type.var "b"
                                , Type.list (Type.var "a")
                                ]
                                (Type.var "b")
                            )
                    }
                )
                [ foldrArg_, foldrArg_0, foldrArg_1 ]
    , filter =
        \filterArg_ filterArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "filter"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "a" ] Type.bool
                                , Type.list (Type.var "a")
                                ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ filterArg_, filterArg_0 ]
    , filterMap =
        \filterMapArg_ filterMapArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "filterMap"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.maybe (Type.var "b"))
                                , Type.list (Type.var "a")
                                ]
                                (Type.list (Type.var "b"))
                            )
                    }
                )
                [ filterMapArg_, filterMapArg_0 ]
    , length =
        \lengthArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "length"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "a") ]
                                Type.int
                            )
                    }
                )
                [ lengthArg_ ]
    , reverse =
        \reverseArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "reverse"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "a") ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ reverseArg_ ]
    , member =
        \memberArg_ memberArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "member"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "a", Type.list (Type.var "a") ]
                                Type.bool
                            )
                    }
                )
                [ memberArg_, memberArg_0 ]
    , all =
        \allArg_ allArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "all"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "a" ] Type.bool
                                , Type.list (Type.var "a")
                                ]
                                Type.bool
                            )
                    }
                )
                [ allArg_, allArg_0 ]
    , any =
        \anyArg_ anyArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "any"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "a" ] Type.bool
                                , Type.list (Type.var "a")
                                ]
                                Type.bool
                            )
                    }
                )
                [ anyArg_, anyArg_0 ]
    , maximum =
        \maximumArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "maximum"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "comparable") ]
                                (Type.maybe (Type.var "comparable"))
                            )
                    }
                )
                [ maximumArg_ ]
    , minimum =
        \minimumArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "minimum"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "comparable") ]
                                (Type.maybe (Type.var "comparable"))
                            )
                    }
                )
                [ minimumArg_ ]
    , sum =
        \sumArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "sum"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "number") ]
                                (Type.var "number")
                            )
                    }
                )
                [ sumArg_ ]
    , product =
        \productArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "product"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "number") ]
                                (Type.var "number")
                            )
                    }
                )
                [ productArg_ ]
    , append =
        \appendArg_ appendArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "append"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "a")
                                , Type.list (Type.var "a")
                                ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ appendArg_, appendArg_0 ]
    , concat =
        \concatArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "concat"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.list (Type.var "a")) ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ concatArg_ ]
    , concatMap =
        \concatMapArg_ concatMapArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "concatMap"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.list (Type.var "b"))
                                , Type.list (Type.var "a")
                                ]
                                (Type.list (Type.var "b"))
                            )
                    }
                )
                [ concatMapArg_, concatMapArg_0 ]
    , intersperse =
        \intersperseArg_ intersperseArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "intersperse"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "a", Type.list (Type.var "a") ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ intersperseArg_, intersperseArg_0 ]
    , map2 =
        \map2Arg_ map2Arg_0 map2Arg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "map2"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "b" ]
                                    (Type.var "result")
                                , Type.list (Type.var "a")
                                , Type.list (Type.var "b")
                                ]
                                (Type.list (Type.var "result"))
                            )
                    }
                )
                [ map2Arg_, map2Arg_0, map2Arg_1 ]
    , map3 =
        \map3Arg_ map3Arg_0 map3Arg_1 map3Arg_2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "map3"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a"
                                    , Type.var "b"
                                    , Type.var "c"
                                    ]
                                    (Type.var "result")
                                , Type.list (Type.var "a")
                                , Type.list (Type.var "b")
                                , Type.list (Type.var "c")
                                ]
                                (Type.list (Type.var "result"))
                            )
                    }
                )
                [ map3Arg_, map3Arg_0, map3Arg_1, map3Arg_2 ]
    , map4 =
        \map4Arg_ map4Arg_0 map4Arg_1 map4Arg_2 map4Arg_3 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
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
                                    (Type.var "result")
                                , Type.list (Type.var "a")
                                , Type.list (Type.var "b")
                                , Type.list (Type.var "c")
                                , Type.list (Type.var "d")
                                ]
                                (Type.list (Type.var "result"))
                            )
                    }
                )
                [ map4Arg_, map4Arg_0, map4Arg_1, map4Arg_2, map4Arg_3 ]
    , map5 =
        \map5Arg_ map5Arg_0 map5Arg_1 map5Arg_2 map5Arg_3 map5Arg_4 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
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
                                    (Type.var "result")
                                , Type.list (Type.var "a")
                                , Type.list (Type.var "b")
                                , Type.list (Type.var "c")
                                , Type.list (Type.var "d")
                                , Type.list (Type.var "e")
                                ]
                                (Type.list (Type.var "result"))
                            )
                    }
                )
                [ map5Arg_
                , map5Arg_0
                , map5Arg_1
                , map5Arg_2
                , map5Arg_3
                , map5Arg_4
                ]
    , sort =
        \sortArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "sort"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "comparable") ]
                                (Type.list (Type.var "comparable"))
                            )
                    }
                )
                [ sortArg_ ]
    , sortBy =
        \sortByArg_ sortByArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "sortBy"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.var "comparable")
                                , Type.list (Type.var "a")
                                ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ sortByArg_, sortByArg_0 ]
    , sortWith =
        \sortWithArg_ sortWithArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "sortWith"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "a" ]
                                    (Type.namedWith [ "Basics" ] "Order" [])
                                , Type.list (Type.var "a")
                                ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ sortWithArg_, sortWithArg_0 ]
    , isEmpty =
        \isEmptyArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "isEmpty"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "a") ]
                                Type.bool
                            )
                    }
                )
                [ isEmptyArg_ ]
    , head =
        \headArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "head"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "a") ]
                                (Type.maybe (Type.var "a"))
                            )
                    }
                )
                [ headArg_ ]
    , tail =
        \tailArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "tail"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list (Type.var "a") ]
                                (Type.maybe (Type.list (Type.var "a")))
                            )
                    }
                )
                [ tailArg_ ]
    , take =
        \takeArg_ takeArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "take"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.list (Type.var "a") ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ takeArg_, takeArg_0 ]
    , drop =
        \dropArg_ dropArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "drop"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.list (Type.var "a") ]
                                (Type.list (Type.var "a"))
                            )
                    }
                )
                [ dropArg_, dropArg_0 ]
    , partition =
        \partitionArg_ partitionArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "partition"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "a" ] Type.bool
                                , Type.list (Type.var "a")
                                ]
                                (Type.tuple
                                    (Type.list (Type.var "a"))
                                    (Type.list (Type.var "a"))
                                )
                            )
                    }
                )
                [ partitionArg_, partitionArg_0 ]
    , unzip =
        \unzipArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "List" ]
                    , name = "unzip"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.tuple (Type.var "a") (Type.var "b"))
                                ]
                                (Type.tuple
                                    (Type.list (Type.var "a"))
                                    (Type.list (Type.var "b"))
                                )
                            )
                    }
                )
                [ unzipArg_ ]
    }


values_ :
    { singleton : Elm.Expression
    , repeat : Elm.Expression
    , range : Elm.Expression
    , map : Elm.Expression
    , indexedMap : Elm.Expression
    , foldl : Elm.Expression
    , foldr : Elm.Expression
    , filter : Elm.Expression
    , filterMap : Elm.Expression
    , length : Elm.Expression
    , reverse : Elm.Expression
    , member : Elm.Expression
    , all : Elm.Expression
    , any : Elm.Expression
    , maximum : Elm.Expression
    , minimum : Elm.Expression
    , sum : Elm.Expression
    , product : Elm.Expression
    , append : Elm.Expression
    , concat : Elm.Expression
    , concatMap : Elm.Expression
    , intersperse : Elm.Expression
    , map2 : Elm.Expression
    , map3 : Elm.Expression
    , map4 : Elm.Expression
    , map5 : Elm.Expression
    , sort : Elm.Expression
    , sortBy : Elm.Expression
    , sortWith : Elm.Expression
    , isEmpty : Elm.Expression
    , head : Elm.Expression
    , tail : Elm.Expression
    , take : Elm.Expression
    , drop : Elm.Expression
    , partition : Elm.Expression
    , unzip : Elm.Expression
    }
values_ =
    { singleton =
        Elm.value
            { importFrom = [ "List" ]
            , name = "singleton"
            , annotation =
                Just (Type.function [ Type.var "a" ] (Type.list (Type.var "a")))
            }
    , repeat =
        Elm.value
            { importFrom = [ "List" ]
            , name = "repeat"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.var "a" ]
                        (Type.list (Type.var "a"))
                    )
            }
    , range =
        Elm.value
            { importFrom = [ "List" ]
            , name = "range"
            , annotation =
                Just (Type.function [ Type.int, Type.int ] (Type.list Type.int))
            }
    , map =
        Elm.value
            { importFrom = [ "List" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "b")
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "b"))
                    )
            }
    , indexedMap =
        Elm.value
            { importFrom = [ "List" ]
            , name = "indexedMap"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.int, Type.var "a" ]
                            (Type.var "b")
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "b"))
                    )
            }
    , foldl =
        Elm.value
            { importFrom = [ "List" ]
            , name = "foldl"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.list (Type.var "a")
                        ]
                        (Type.var "b")
                    )
            }
    , foldr =
        Elm.value
            { importFrom = [ "List" ]
            , name = "foldr"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "b")
                        , Type.var "b"
                        , Type.list (Type.var "a")
                        ]
                        (Type.var "b")
                    )
            }
    , filter =
        Elm.value
            { importFrom = [ "List" ]
            , name = "filter"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] Type.bool
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "a"))
                    )
            }
    , filterMap =
        Elm.value
            { importFrom = [ "List" ]
            , name = "filterMap"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.maybe (Type.var "b"))
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "b"))
                    )
            }
    , length =
        Elm.value
            { importFrom = [ "List" ]
            , name = "length"
            , annotation =
                Just (Type.function [ Type.list (Type.var "a") ] Type.int)
            }
    , reverse =
        Elm.value
            { importFrom = [ "List" ]
            , name = "reverse"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "a") ]
                        (Type.list (Type.var "a"))
                    )
            }
    , member =
        Elm.value
            { importFrom = [ "List" ]
            , name = "member"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a", Type.list (Type.var "a") ]
                        Type.bool
                    )
            }
    , all =
        Elm.value
            { importFrom = [ "List" ]
            , name = "all"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] Type.bool
                        , Type.list (Type.var "a")
                        ]
                        Type.bool
                    )
            }
    , any =
        Elm.value
            { importFrom = [ "List" ]
            , name = "any"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] Type.bool
                        , Type.list (Type.var "a")
                        ]
                        Type.bool
                    )
            }
    , maximum =
        Elm.value
            { importFrom = [ "List" ]
            , name = "maximum"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "comparable") ]
                        (Type.maybe (Type.var "comparable"))
                    )
            }
    , minimum =
        Elm.value
            { importFrom = [ "List" ]
            , name = "minimum"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "comparable") ]
                        (Type.maybe (Type.var "comparable"))
                    )
            }
    , sum =
        Elm.value
            { importFrom = [ "List" ]
            , name = "sum"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "number") ]
                        (Type.var "number")
                    )
            }
    , product =
        Elm.value
            { importFrom = [ "List" ]
            , name = "product"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "number") ]
                        (Type.var "number")
                    )
            }
    , append =
        Elm.value
            { importFrom = [ "List" ]
            , name = "append"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "a"), Type.list (Type.var "a") ]
                        (Type.list (Type.var "a"))
                    )
            }
    , concat =
        Elm.value
            { importFrom = [ "List" ]
            , name = "concat"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.list (Type.var "a")) ]
                        (Type.list (Type.var "a"))
                    )
            }
    , concatMap =
        Elm.value
            { importFrom = [ "List" ]
            , name = "concatMap"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.list (Type.var "b"))
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "b"))
                    )
            }
    , intersperse =
        Elm.value
            { importFrom = [ "List" ]
            , name = "intersperse"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a", Type.list (Type.var "a") ]
                        (Type.list (Type.var "a"))
                    )
            }
    , map2 =
        Elm.value
            { importFrom = [ "List" ]
            , name = "map2"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "result")
                        , Type.list (Type.var "a")
                        , Type.list (Type.var "b")
                        ]
                        (Type.list (Type.var "result"))
                    )
            }
    , map3 =
        Elm.value
            { importFrom = [ "List" ]
            , name = "map3"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b", Type.var "c" ]
                            (Type.var "result")
                        , Type.list (Type.var "a")
                        , Type.list (Type.var "b")
                        , Type.list (Type.var "c")
                        ]
                        (Type.list (Type.var "result"))
                    )
            }
    , map4 =
        Elm.value
            { importFrom = [ "List" ]
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
                            (Type.var "result")
                        , Type.list (Type.var "a")
                        , Type.list (Type.var "b")
                        , Type.list (Type.var "c")
                        , Type.list (Type.var "d")
                        ]
                        (Type.list (Type.var "result"))
                    )
            }
    , map5 =
        Elm.value
            { importFrom = [ "List" ]
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
                            (Type.var "result")
                        , Type.list (Type.var "a")
                        , Type.list (Type.var "b")
                        , Type.list (Type.var "c")
                        , Type.list (Type.var "d")
                        , Type.list (Type.var "e")
                        ]
                        (Type.list (Type.var "result"))
                    )
            }
    , sort =
        Elm.value
            { importFrom = [ "List" ]
            , name = "sort"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "comparable") ]
                        (Type.list (Type.var "comparable"))
                    )
            }
    , sortBy =
        Elm.value
            { importFrom = [ "List" ]
            , name = "sortBy"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.var "comparable")
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "a"))
                    )
            }
    , sortWith =
        Elm.value
            { importFrom = [ "List" ]
            , name = "sortWith"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "a" ]
                            (Type.namedWith [ "Basics" ] "Order" [])
                        , Type.list (Type.var "a")
                        ]
                        (Type.list (Type.var "a"))
                    )
            }
    , isEmpty =
        Elm.value
            { importFrom = [ "List" ]
            , name = "isEmpty"
            , annotation =
                Just (Type.function [ Type.list (Type.var "a") ] Type.bool)
            }
    , head =
        Elm.value
            { importFrom = [ "List" ]
            , name = "head"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "a") ]
                        (Type.maybe (Type.var "a"))
                    )
            }
    , tail =
        Elm.value
            { importFrom = [ "List" ]
            , name = "tail"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.var "a") ]
                        (Type.maybe (Type.list (Type.var "a")))
                    )
            }
    , take =
        Elm.value
            { importFrom = [ "List" ]
            , name = "take"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.list (Type.var "a") ]
                        (Type.list (Type.var "a"))
                    )
            }
    , drop =
        Elm.value
            { importFrom = [ "List" ]
            , name = "drop"
            , annotation =
                Just
                    (Type.function
                        [ Type.int, Type.list (Type.var "a") ]
                        (Type.list (Type.var "a"))
                    )
            }
    , partition =
        Elm.value
            { importFrom = [ "List" ]
            , name = "partition"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] Type.bool
                        , Type.list (Type.var "a")
                        ]
                        (Type.tuple
                            (Type.list (Type.var "a"))
                            (Type.list (Type.var "a"))
                        )
                    )
            }
    , unzip =
        Elm.value
            { importFrom = [ "List" ]
            , name = "unzip"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.tuple (Type.var "a") (Type.var "b"))
                        ]
                        (Type.tuple
                            (Type.list (Type.var "a"))
                            (Type.list (Type.var "b"))
                        )
                    )
            }
    }
