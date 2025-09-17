module Gen.Dict exposing
    ( get
    , toList
    , annotation_
    , call_
    )

{-|


# Generated bindings for Dict

@docs get, values
@docs toList
@docs annotation_
@docs call__

-}

import Elm
import Elm.Annotation as Type


{-| Get the value associated with a key. If the key is not found, return
`Nothing`. This is useful when you are not sure if a key will be in the
dictionary.

    animals = fromList [ ("Tom", Cat), ("Jerry", Mouse) ]

    get "Tom"   animals == Just Cat
    get "Jerry" animals == Just Mouse
    get "Spike" animals == Nothing

get: comparable -> Dict.Dict comparable v -> Maybe v

-}
get : Elm.Expression -> Elm.Expression -> Elm.Expression
get getArg_ getArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "get"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "comparable"
                        , Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "comparable", Type.var "v" ]
                        ]
                        (Type.maybe (Type.var "v"))
                    )
            }
        )
        [ getArg_, getArg_0 ]


{-| Convert a dictionary into an association list of key-value pairs, sorted by keys.

toList: Dict.Dict k v -> List ( k, v )

-}
toList : Elm.Expression -> Elm.Expression
toList toListArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Dict" ]
            , name = "toList"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Dict" ]
                            "Dict"
                            [ Type.var "k", Type.var "v" ]
                        ]
                        (Type.list (Type.tuple (Type.var "k") (Type.var "v")))
                    )
            }
        )
        [ toListArg_ ]


annotation_ : { dict : Type.Annotation -> Type.Annotation -> Type.Annotation }
annotation_ =
    { dict =
        \dictArg0 dictArg1 ->
            Type.namedWith [ "Dict" ] "Dict" [ dictArg0, dictArg1 ]
    }


call_ :
    { singleton : Elm.Expression -> Elm.Expression -> Elm.Expression
    , insert :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , update :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , remove : Elm.Expression -> Elm.Expression -> Elm.Expression
    , isEmpty : Elm.Expression -> Elm.Expression
    , member : Elm.Expression -> Elm.Expression -> Elm.Expression
    , get : Elm.Expression -> Elm.Expression -> Elm.Expression
    , size : Elm.Expression -> Elm.Expression
    , keys : Elm.Expression -> Elm.Expression
    , values : Elm.Expression -> Elm.Expression
    , toList : Elm.Expression -> Elm.Expression
    , fromList : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , foldl :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , foldr :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , filter : Elm.Expression -> Elm.Expression -> Elm.Expression
    , partition : Elm.Expression -> Elm.Expression -> Elm.Expression
    , union : Elm.Expression -> Elm.Expression -> Elm.Expression
    , intersect : Elm.Expression -> Elm.Expression -> Elm.Expression
    , diff : Elm.Expression -> Elm.Expression -> Elm.Expression
    , merge :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    }
call_ =
    { singleton =
        \singletonArg_ singletonArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "singleton"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "comparable", Type.var "v" ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                )
                            )
                    }
                )
                [ singletonArg_, singletonArg_0 ]
    , insert =
        \insertArg_ insertArg_0 insertArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "insert"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "comparable"
                                , Type.var "v"
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                )
                            )
                    }
                )
                [ insertArg_, insertArg_0, insertArg_1 ]
    , update =
        \updateArg_ updateArg_0 updateArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "update"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "comparable"
                                , Type.function
                                    [ Type.maybe (Type.var "v") ]
                                    (Type.maybe (Type.var "v"))
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                )
                            )
                    }
                )
                [ updateArg_, updateArg_0, updateArg_1 ]
    , remove =
        \removeArg_ removeArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "remove"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "comparable"
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                )
                            )
                    }
                )
                [ removeArg_, removeArg_0 ]
    , isEmpty =
        \isEmptyArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "isEmpty"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "v" ]
                                ]
                                Type.bool
                            )
                    }
                )
                [ isEmptyArg_ ]
    , member =
        \memberArg_ memberArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "member"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "comparable"
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                Type.bool
                            )
                    }
                )
                [ memberArg_, memberArg_0 ]
    , get =
        \getArg_ getArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "get"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "comparable"
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                (Type.maybe (Type.var "v"))
                            )
                    }
                )
                [ getArg_, getArg_0 ]
    , size =
        \sizeArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "size"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "v" ]
                                ]
                                Type.int
                            )
                    }
                )
                [ sizeArg_ ]
    , keys =
        \keysArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "keys"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "v" ]
                                ]
                                (Type.list (Type.var "k"))
                            )
                    }
                )
                [ keysArg_ ]
    , values =
        \valuesArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "values"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "v" ]
                                ]
                                (Type.list (Type.var "v"))
                            )
                    }
                )
                [ valuesArg_ ]
    , toList =
        \toListArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "toList"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "v" ]
                                ]
                                (Type.list
                                    (Type.tuple (Type.var "k") (Type.var "v"))
                                )
                            )
                    }
                )
                [ toListArg_ ]
    , fromList =
        \fromListArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "fromList"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.tuple
                                        (Type.var "comparable")
                                        (Type.var "v")
                                    )
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                )
                            )
                    }
                )
                [ fromListArg_ ]
    , map =
        \mapArg_ mapArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "map"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "k", Type.var "a" ]
                                    (Type.var "b")
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "b" ]
                                )
                            )
                    }
                )
                [ mapArg_, mapArg_0 ]
    , foldl =
        \foldlArg_ foldlArg_0 foldlArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "foldl"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "k"
                                    , Type.var "v"
                                    , Type.var "b"
                                    ]
                                    (Type.var "b")
                                , Type.var "b"
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "v" ]
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
                    { importFrom = [ "Dict" ]
                    , name = "foldr"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "k"
                                    , Type.var "v"
                                    , Type.var "b"
                                    ]
                                    (Type.var "b")
                                , Type.var "b"
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "v" ]
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
                    { importFrom = [ "Dict" ]
                    , name = "filter"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "comparable", Type.var "v" ]
                                    Type.bool
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                )
                            )
                    }
                )
                [ filterArg_, filterArg_0 ]
    , partition =
        \partitionArg_ partitionArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "partition"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "comparable", Type.var "v" ]
                                    Type.bool
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                (Type.tuple
                                    (Type.namedWith
                                        [ "Dict" ]
                                        "Dict"
                                        [ Type.var "comparable"
                                        , Type.var "v"
                                        ]
                                    )
                                    (Type.namedWith
                                        [ "Dict" ]
                                        "Dict"
                                        [ Type.var "comparable"
                                        , Type.var "v"
                                        ]
                                    )
                                )
                            )
                    }
                )
                [ partitionArg_, partitionArg_0 ]
    , union =
        \unionArg_ unionArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "union"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                )
                            )
                    }
                )
                [ unionArg_, unionArg_0 ]
    , intersect =
        \intersectArg_ intersectArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "intersect"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "v" ]
                                )
                            )
                    }
                )
                [ intersectArg_, intersectArg_0 ]
    , diff =
        \diffArg_ diffArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "diff"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "a" ]
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "b" ]
                                ]
                                (Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "a" ]
                                )
                            )
                    }
                )
                [ diffArg_, diffArg_0 ]
    , merge =
        \mergeArg_ mergeArg_0 mergeArg_1 mergeArg_2 mergeArg_3 mergeArg_4 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Dict" ]
                    , name = "merge"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "comparable"
                                    , Type.var "a"
                                    , Type.var "result"
                                    ]
                                    (Type.var "result")
                                , Type.function
                                    [ Type.var "comparable"
                                    , Type.var "a"
                                    , Type.var "b"
                                    , Type.var "result"
                                    ]
                                    (Type.var "result")
                                , Type.function
                                    [ Type.var "comparable"
                                    , Type.var "b"
                                    , Type.var "result"
                                    ]
                                    (Type.var "result")
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "a" ]
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "comparable", Type.var "b" ]
                                , Type.var "result"
                                ]
                                (Type.var "result")
                            )
                    }
                )
                [ mergeArg_
                , mergeArg_0
                , mergeArg_1
                , mergeArg_2
                , mergeArg_3
                , mergeArg_4
                ]
    }
