module Gen.Base64 exposing
    ( fromBytes
    , call_
    )

{-|


# Generated bindings for Base64

@docs fromBytes
@docs call_

-}

import Elm
import Elm.Annotation as Type


{-| Convert bytes to a Base64 string.
If you want more control over the process, you should use [`decoder`](#decoder).

This function should never return `Nothing`, but it uses
[`Bytes.Decode.decode`](https://package.elm-lang.org/packages/elm/bytes/latest/Bytes-Decode#decode),
which returns a `Maybe String`.

fromBytes: Bytes.Bytes -> Maybe String

-}
fromBytes : Elm.Expression -> Elm.Expression
fromBytes fromBytesArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Base64" ]
            , name = "fromBytes"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Bytes" [] ]
                        (Type.maybe Type.string)
                    )
            }
        )
        [ fromBytesArg_ ]


call_ :
    { fromBytes : Elm.Expression -> Elm.Expression
    , fromString : Elm.Expression -> Elm.Expression
    , toBytes : Elm.Expression -> Elm.Expression
    , toString : Elm.Expression -> Elm.Expression
    , encoder : Elm.Expression -> Elm.Expression
    , decoder : Elm.Expression -> Elm.Expression
    }
call_ =
    { fromBytes =
        \fromBytesArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Base64" ]
                    , name = "fromBytes"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Bytes" ] "Bytes" [] ]
                                (Type.maybe Type.string)
                            )
                    }
                )
                [ fromBytesArg_ ]
    , fromString =
        \fromStringArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Base64" ]
                    , name = "fromString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.maybe Type.string)
                            )
                    }
                )
                [ fromStringArg_ ]
    , toBytes =
        \toBytesArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Base64" ]
                    , name = "toBytes"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.maybe
                                    (Type.namedWith [ "Bytes" ] "Bytes" [])
                                )
                            )
                    }
                )
                [ toBytesArg_ ]
    , toString =
        \toStringArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Base64" ]
                    , name = "toString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.maybe Type.string)
                            )
                    }
                )
                [ toStringArg_ ]
    , encoder =
        \encoderArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Base64" ]
                    , name = "encoder"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.maybe
                                    (Type.namedWith
                                        [ "Bytes", "Encode" ]
                                        "Encoder"
                                        []
                                    )
                                )
                            )
                    }
                )
                [ encoderArg_ ]
    , decoder =
        \decoderArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Base64" ]
                    , name = "decoder"
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
                [ decoderArg_ ]
    }
