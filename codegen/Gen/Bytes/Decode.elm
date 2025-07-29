module Gen.Bytes.Decode exposing
    ( decode
    , call_, values_
    )

{-|


# Generated bindings for Bytes.Decode

@docs decode
@docs call_, values_

-}

import Elm
import Elm.Annotation as Type


{-| Turn a sequence of bytes into a nice Elm value.

    -- decode (unsignedInt16 BE) <0007> == Just 7
    -- decode (unsignedInt16 LE) <0700> == Just 7
    -- decode (unsignedInt16 BE) <0700> == Just 1792
    -- decode (unsignedInt32 BE) <0700> == Nothing



The `Decoder` specifies exactly how this should happen. This process may fail
if the sequence of bytes is corrupted or unexpected somehow. The examples above
show a case where there are not enough bytes.

decode: Bytes.Decode.Decoder a -> Bytes.Bytes -> Maybe a

-}
decode : Elm.Expression -> Elm.Expression -> Elm.Expression
decode decodeArg_ decodeArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "decode"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        , Type.namedWith [ "Bytes" ] "Bytes" []
                        ]
                        (Type.maybe (Type.var "a"))
                    )
            }
        )
        [ decodeArg_, decodeArg_0 ]


call_ :
    { decode : Elm.Expression -> Elm.Expression -> Elm.Expression
    , signedInt16 : Elm.Expression -> Elm.Expression
    , signedInt32 : Elm.Expression -> Elm.Expression
    , unsignedInt16 : Elm.Expression -> Elm.Expression
    , unsignedInt32 : Elm.Expression -> Elm.Expression
    , float32 : Elm.Expression -> Elm.Expression
    , float64 : Elm.Expression -> Elm.Expression
    , bytes : Elm.Expression -> Elm.Expression
    , string : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
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
    , andThen : Elm.Expression -> Elm.Expression -> Elm.Expression
    , succeed : Elm.Expression -> Elm.Expression
    , loop : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { decode =
        \decodeArg_ decodeArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Decode" ]
                    , name = "decode"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                , Type.namedWith [ "Bytes" ] "Bytes" []
                                ]
                                (Type.maybe (Type.var "a"))
                            )
                    }
                )
                [ decodeArg_, decodeArg_0 ]
    , signedInt16 =
        \signedInt16Arg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Decode" ]
                    , name = "signedInt16"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Bytes" ] "Endianness" [] ]
                                (Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.int ]
                                )
                            )
                    }
                )
                [ signedInt16Arg_ ]
    , signedInt32 =
        \signedInt32Arg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Decode" ]
                    , name = "signedInt32"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Bytes" ] "Endianness" [] ]
                                (Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.int ]
                                )
                            )
                    }
                )
                [ signedInt32Arg_ ]
    , unsignedInt16 =
        \unsignedInt16Arg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Decode" ]
                    , name = "unsignedInt16"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Bytes" ] "Endianness" [] ]
                                (Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.int ]
                                )
                            )
                    }
                )
                [ unsignedInt16Arg_ ]
    , unsignedInt32 =
        \unsignedInt32Arg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Decode" ]
                    , name = "unsignedInt32"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Bytes" ] "Endianness" [] ]
                                (Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.int ]
                                )
                            )
                    }
                )
                [ unsignedInt32Arg_ ]
    , float32 =
        \float32Arg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Decode" ]
                    , name = "float32"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Bytes" ] "Endianness" [] ]
                                (Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.float ]
                                )
                            )
                    }
                )
                [ float32Arg_ ]
    , float64 =
        \float64Arg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Decode" ]
                    , name = "float64"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Bytes" ] "Endianness" [] ]
                                (Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.float ]
                                )
                            )
                    }
                )
                [ float64Arg_ ]
    , bytes =
        \bytesArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Decode" ]
                    , name = "bytes"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int ]
                                (Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.namedWith [ "Bytes" ] "Bytes" [] ]
                                )
                            )
                    }
                )
                [ bytesArg_ ]
    , string =
        \stringArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Decode" ]
                    , name = "string"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int ]
                                (Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.string ]
                                )
                            )
                    }
                )
                [ stringArg_ ]
    , map =
        \mapArg_ mapArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Decode" ]
                    , name = "map"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.var "b")
                                , Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "b" ]
                                )
                            )
                    }
                )
                [ mapArg_, mapArg_0 ]
    , map2 =
        \map2Arg_ map2Arg_0 map2Arg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Decode" ]
                    , name = "map2"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "b" ]
                                    (Type.var "result")
                                , Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                , Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "b" ]
                                ]
                                (Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "result" ]
                                )
                            )
                    }
                )
                [ map2Arg_, map2Arg_0, map2Arg_1 ]
    , map3 =
        \map3Arg_ map3Arg_0 map3Arg_1 map3Arg_2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Decode" ]
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
                                , Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                , Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "b" ]
                                , Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "c" ]
                                ]
                                (Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "result" ]
                                )
                            )
                    }
                )
                [ map3Arg_, map3Arg_0, map3Arg_1, map3Arg_2 ]
    , map4 =
        \map4Arg_ map4Arg_0 map4Arg_1 map4Arg_2 map4Arg_3 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Decode" ]
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
                                , Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                , Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "b" ]
                                , Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "c" ]
                                , Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "d" ]
                                ]
                                (Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "result" ]
                                )
                            )
                    }
                )
                [ map4Arg_, map4Arg_0, map4Arg_1, map4Arg_2, map4Arg_3 ]
    , map5 =
        \map5Arg_ map5Arg_0 map5Arg_1 map5Arg_2 map5Arg_3 map5Arg_4 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Decode" ]
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
                                , Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                , Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "b" ]
                                , Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "c" ]
                                , Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "d" ]
                                , Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "e" ]
                                ]
                                (Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "result" ]
                                )
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
    , andThen =
        \andThenArg_ andThenArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Decode" ]
                    , name = "andThen"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.namedWith
                                        [ "Bytes", "Decode" ]
                                        "Decoder"
                                        [ Type.var "b" ]
                                    )
                                , Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "b" ]
                                )
                            )
                    }
                )
                [ andThenArg_, andThenArg_0 ]
    , succeed =
        \succeedArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Decode" ]
                    , name = "succeed"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "a" ]
                                (Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ succeedArg_ ]
    , loop =
        \loopArg_ loopArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Decode" ]
                    , name = "loop"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "state"
                                , Type.function
                                    [ Type.var "state" ]
                                    (Type.namedWith
                                        [ "Bytes", "Decode" ]
                                        "Decoder"
                                        [ Type.namedWith
                                            [ "Bytes", "Decode" ]
                                            "Step"
                                            [ Type.var "state"
                                            , Type.var "a"
                                            ]
                                        ]
                                    )
                                ]
                                (Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ loopArg_, loopArg_0 ]
    }


values_ :
    { decode : Elm.Expression
    , signedInt8 : Elm.Expression
    , signedInt16 : Elm.Expression
    , signedInt32 : Elm.Expression
    , unsignedInt8 : Elm.Expression
    , unsignedInt16 : Elm.Expression
    , unsignedInt32 : Elm.Expression
    , float32 : Elm.Expression
    , float64 : Elm.Expression
    , bytes : Elm.Expression
    , string : Elm.Expression
    , map : Elm.Expression
    , map2 : Elm.Expression
    , map3 : Elm.Expression
    , map4 : Elm.Expression
    , map5 : Elm.Expression
    , andThen : Elm.Expression
    , succeed : Elm.Expression
    , fail : Elm.Expression
    , loop : Elm.Expression
    }
values_ =
    { decode =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "decode"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        , Type.namedWith [ "Bytes" ] "Bytes" []
                        ]
                        (Type.maybe (Type.var "a"))
                    )
            }
    , signedInt8 =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "signedInt8"
            , annotation =
                Just
                    (Type.namedWith [ "Bytes", "Decode" ] "Decoder" [ Type.int ])
            }
    , signedInt16 =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "signedInt16"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" [] ]
                        (Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.int ]
                        )
                    )
            }
    , signedInt32 =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "signedInt32"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" [] ]
                        (Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.int ]
                        )
                    )
            }
    , unsignedInt8 =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "unsignedInt8"
            , annotation =
                Just
                    (Type.namedWith [ "Bytes", "Decode" ] "Decoder" [ Type.int ])
            }
    , unsignedInt16 =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "unsignedInt16"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" [] ]
                        (Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.int ]
                        )
                    )
            }
    , unsignedInt32 =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "unsignedInt32"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" [] ]
                        (Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.int ]
                        )
                    )
            }
    , float32 =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "float32"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" [] ]
                        (Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.float ]
                        )
                    )
            }
    , float64 =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "float64"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" [] ]
                        (Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.float ]
                        )
                    )
            }
    , bytes =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "bytes"
            , annotation =
                Just
                    (Type.function
                        [ Type.int ]
                        (Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.namedWith [ "Bytes" ] "Bytes" [] ]
                        )
                    )
            }
    , string =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "string"
            , annotation =
                Just
                    (Type.function
                        [ Type.int ]
                        (Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.string ]
                        )
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "b")
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "b" ]
                        )
                    )
            }
    , map2 =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "map2"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "result")
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "b" ]
                        ]
                        (Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "result" ]
                        )
                    )
            }
    , map3 =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "map3"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b", Type.var "c" ]
                            (Type.var "result")
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "b" ]
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "c" ]
                        ]
                        (Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "result" ]
                        )
                    )
            }
    , map4 =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
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
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "b" ]
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "c" ]
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "d" ]
                        ]
                        (Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "result" ]
                        )
                    )
            }
    , map5 =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
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
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "b" ]
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "c" ]
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "d" ]
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "e" ]
                        ]
                        (Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "result" ]
                        )
                    )
            }
    , andThen =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "andThen"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.namedWith
                                [ "Bytes", "Decode" ]
                                "Decoder"
                                [ Type.var "b" ]
                            )
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "b" ]
                        )
                    )
            }
    , succeed =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "succeed"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a" ]
                        (Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        )
                    )
            }
    , fail =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "fail"
            , annotation =
                Just
                    (Type.namedWith
                        [ "Bytes", "Decode" ]
                        "Decoder"
                        [ Type.var "a" ]
                    )
            }
    , loop =
        Elm.value
            { importFrom = [ "Bytes", "Decode" ]
            , name = "loop"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "state"
                        , Type.function
                            [ Type.var "state" ]
                            (Type.namedWith
                                [ "Bytes", "Decode" ]
                                "Decoder"
                                [ Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Step"
                                    [ Type.var "state", Type.var "a" ]
                                ]
                            )
                        ]
                        (Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        )
                    )
            }
    }
