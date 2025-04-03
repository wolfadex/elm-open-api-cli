module Gen.Base64 exposing
    ( moduleName_, fromBytes, fromString, toBytes, toString, encoder
    , decoder, call_, values_
    )

{-|
# Generated bindings for Base64

@docs moduleName_, fromBytes, fromString, toBytes, toString, encoder
@docs decoder, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Base64" ]


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


{-| Encode a string into a Base64 string.
This function is a wrapper around [`fromBytes`](#fromBytes).

Similarly, it should never return `Nothing`, but alas, [`Bytes.Decode.decode`](https://package.elm-lang.org/packages/elm/bytes/latest/Bytes-Decode#decode),
which [`fromBytes`](#fromBytes) uses, returns a `Maybe String`.

fromString: String -> Maybe String
-}
fromString : String -> Elm.Expression
fromString fromStringArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Base64" ]
             , name = "fromString"
             , annotation =
                 Just (Type.function [ Type.string ] (Type.maybe Type.string))
             }
        )
        [ Elm.string fromStringArg_ ]


{-| Convert a Base64 string to bytes.
If you want more control over the process, you should use [`encoder`](#encoder).

This function fails (returns `Nothing`) if you give it an invalid Base64 sequence.

toBytes: String -> Maybe Bytes.Bytes
-}
toBytes : String -> Elm.Expression
toBytes toBytesArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Base64" ]
             , name = "toBytes"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.maybe (Type.namedWith [ "Bytes" ] "Bytes" []))
                     )
             }
        )
        [ Elm.string toBytesArg_ ]


{-| Decode a Base64 string into a string.
This function is a wrapper around [`toBytes`](#toBytes).

It will fail (return `Nothing`) if you give it an invalid Base64 sequence.

toString: String -> Maybe String
-}
toString : String -> Elm.Expression
toString toStringArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Base64" ]
             , name = "toString"
             , annotation =
                 Just (Type.function [ Type.string ] (Type.maybe Type.string))
             }
        )
        [ Elm.string toStringArg_ ]


{-| `encoder` returns a bytes encoder. It fails if the string that is passed
to it is not a valid Base64 sequence.

It's used in [`toBytes`](#toBytes):

    toBytes : String -> Maybe Bytes
    toBytes string =
        Maybe.map Bytes.Encode.encode (encoder string)

encoder: String -> Maybe Bytes.Encode.Encoder
-}
encoder : String -> Elm.Expression
encoder encoderArg_ =
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
        [ Elm.string encoderArg_ ]


{-| `decoder width` is a bytes decoder that will convert `width` bytes into a
Base64 string.

It's used in [`fromBytes`](#fromBytes):

    fromBytes : Bytes -> Maybe String
    fromBytes bytes =
        Bytes.Decode.decode (decoder (Bytes.width bytes)) bytes

decoder: Int -> Bytes.Decode.Decoder String
-}
decoder : Int -> Elm.Expression
decoder decoderArg_ =
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
        [ Elm.int decoderArg_ ]


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


values_ :
    { fromBytes : Elm.Expression
    , fromString : Elm.Expression
    , toBytes : Elm.Expression
    , toString : Elm.Expression
    , encoder : Elm.Expression
    , decoder : Elm.Expression
    }
values_ =
    { fromBytes =
        Elm.value
            { importFrom = [ "Base64" ]
            , name = "fromBytes"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Bytes" ] "Bytes" [] ]
                         (Type.maybe Type.string)
                    )
            }
    , fromString =
        Elm.value
            { importFrom = [ "Base64" ]
            , name = "fromString"
            , annotation =
                Just (Type.function [ Type.string ] (Type.maybe Type.string))
            }
    , toBytes =
        Elm.value
            { importFrom = [ "Base64" ]
            , name = "toBytes"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.maybe (Type.namedWith [ "Bytes" ] "Bytes" []))
                    )
            }
    , toString =
        Elm.value
            { importFrom = [ "Base64" ]
            , name = "toString"
            , annotation =
                Just (Type.function [ Type.string ] (Type.maybe Type.string))
            }
    , encoder =
        Elm.value
            { importFrom = [ "Base64" ]
            , name = "encoder"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.maybe
                              (Type.namedWith [ "Bytes", "Encode" ] "Encoder" []
                              )
                         )
                    )
            }
    , decoder =
        Elm.value
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
    }