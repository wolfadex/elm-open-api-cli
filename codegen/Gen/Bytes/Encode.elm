module Gen.Bytes.Encode exposing (annotation_, bytes, call_, encode, float32, float64, getStringWidth, moduleName_, sequence, signedInt16, signedInt32, signedInt8, string, unsignedInt16, unsignedInt32, unsignedInt8, values_)

{-| 
@docs values_, call_, annotation_, getStringWidth, string, bytes, float64, float32, unsignedInt32, unsignedInt16, unsignedInt8, signedInt32, signedInt16, signedInt8, sequence, encode, moduleName_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Bytes", "Encode" ]


{-| Turn an `Encoder` into `Bytes`.

    encode (unsignedInt8     7) -- <07>
    encode (unsignedInt16 BE 7) -- <0007>
    encode (unsignedInt16 LE 7) -- <0700>

The `encode` function is designed to minimize allocation. It figures out the
exact width necessary to fit everything in `Bytes` and then generate that
value directly. This is valuable when you are encoding more elaborate data:

    import Bytes exposing (Endianness(..))
    import Bytes.Encode as Encode

    type alias Person =
      { age : Int
      , name : String
      }

    toEncoder : Person -> Encode.Encoder
    toEncoder person =
      Encode.sequence
        [ Encode.unsignedInt16 BE person.age
        , Encode.unsignedInt16 BE (Encode.getStringWidth person.name)
        , Encode.string person.name
        ]

    -- encode (toEncoder (Person 33 "Tom")) == <00210003546F6D>

Did you know it was going to be seven bytes? How about when you have a hundred
people to serialize? And when some have Japanese and Norwegian names? Having
this intermediate `Encoder` can help reduce allocation quite a lot!

encode: Bytes.Encode.Encoder -> Bytes.Bytes
-}
encode : Elm.Expression -> Elm.Expression
encode encodeArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "encode"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes", "Encode" ] "Encoder" [] ]
                        (Type.namedWith [ "Bytes" ] "Bytes" [])
                    )
            }
        )
        [ encodeArg ]


{-| Put together a bunch of builders. So if you wanted to encode three `Float`
values for the position of a ball in 3D space, you could say:

    import Bytes exposing (Endianness(..))
    import Bytes.Encode as Encode

    type alias Ball = { x : Float, y : Float, z : Float }

    ball : Ball -> Encode.Encoder
    ball {x,y,z} =
      Encode.sequence
        [ Encode.float32 BE x
        , Encode.float32 BE y
        , Encode.float32 BE z
        ]

sequence: List Bytes.Encode.Encoder -> Bytes.Encode.Encoder
-}
sequence : List Elm.Expression -> Elm.Expression
sequence sequenceArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "sequence"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                        ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
        )
        [ Elm.list sequenceArg ]


{-| Encode integers from `-128` to `127` in one byte.

signedInt8: Int -> Bytes.Encode.Encoder
-}
signedInt8 : Int -> Elm.Expression
signedInt8 signedInt8Arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "signedInt8"
            , annotation =
                Just
                    (Type.function
                        [ Type.int ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
        )
        [ Elm.int signedInt8Arg ]


{-| Encode integers from `-32768` to `32767` in two bytes.

signedInt16: Bytes.Endianness -> Int -> Bytes.Encode.Encoder
-}
signedInt16 : Elm.Expression -> Int -> Elm.Expression
signedInt16 signedInt16Arg signedInt16Arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "signedInt16"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" [], Type.int ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
        )
        [ signedInt16Arg, Elm.int signedInt16Arg0 ]


{-| Encode integers from `-2147483648` to `2147483647` in four bytes.

signedInt32: Bytes.Endianness -> Int -> Bytes.Encode.Encoder
-}
signedInt32 : Elm.Expression -> Int -> Elm.Expression
signedInt32 signedInt32Arg signedInt32Arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "signedInt32"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" [], Type.int ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
        )
        [ signedInt32Arg, Elm.int signedInt32Arg0 ]


{-| Encode integers from `0` to `255` in one byte.

unsignedInt8: Int -> Bytes.Encode.Encoder
-}
unsignedInt8 : Int -> Elm.Expression
unsignedInt8 unsignedInt8Arg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "unsignedInt8"
            , annotation =
                Just
                    (Type.function
                        [ Type.int ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
        )
        [ Elm.int unsignedInt8Arg ]


{-| Encode integers from `0` to `65535` in two bytes.

unsignedInt16: Bytes.Endianness -> Int -> Bytes.Encode.Encoder
-}
unsignedInt16 : Elm.Expression -> Int -> Elm.Expression
unsignedInt16 unsignedInt16Arg unsignedInt16Arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "unsignedInt16"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" [], Type.int ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
        )
        [ unsignedInt16Arg, Elm.int unsignedInt16Arg0 ]


{-| Encode integers from `0` to `4294967295` in four bytes.

unsignedInt32: Bytes.Endianness -> Int -> Bytes.Encode.Encoder
-}
unsignedInt32 : Elm.Expression -> Int -> Elm.Expression
unsignedInt32 unsignedInt32Arg unsignedInt32Arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "unsignedInt32"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" [], Type.int ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
        )
        [ unsignedInt32Arg, Elm.int unsignedInt32Arg0 ]


{-| Encode 32-bit floating point numbers in four bytes.

float32: Bytes.Endianness -> Float -> Bytes.Encode.Encoder
-}
float32 : Elm.Expression -> Float -> Elm.Expression
float32 float32Arg float32Arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "float32"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" []
                        , Type.float
                        ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
        )
        [ float32Arg, Elm.float float32Arg0 ]


{-| Encode 64-bit floating point numbers in eight bytes.

float64: Bytes.Endianness -> Float -> Bytes.Encode.Encoder
-}
float64 : Elm.Expression -> Float -> Elm.Expression
float64 float64Arg float64Arg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "float64"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" []
                        , Type.float
                        ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
        )
        [ float64Arg, Elm.float float64Arg0 ]


{-| Copy bytes directly into the new `Bytes` sequence. This does not record the
width though! You usually want to say something like this:

    import Bytes exposing (Bytes, Endianness(..))
    import Bytes.Encode as Encode

    png : Bytes -> Encode.Encoder
    png imageData =
      Encode.sequence
        [ Encode.unsignedInt32 BE (Bytes.width imageData)
        , Encode.bytes imageData
        ]

This allows you to represent the width however is necessary for your protocol.
For example, you can use [Base 128 Varints][pb] for ProtoBuf,
[Variable-Length Integers][sql] for SQLite, or whatever else they dream up.

[pb]: https://developers.google.com/protocol-buffers/docs/encoding#varints
[sql]: https://www.sqlite.org/src4/doc/trunk/www/varint.wiki

bytes: Bytes.Bytes -> Bytes.Encode.Encoder
-}
bytes : Elm.Expression -> Elm.Expression
bytes bytesArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "bytes"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Bytes" [] ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
        )
        [ bytesArg ]


{-| Encode a `String` as a bunch of UTF-8 bytes.

    encode (string "$20")   -- <24 32 30>
    encode (string "£20")   -- <C2A3 32 30>
    encode (string "€20")   -- <E282AC 32 30>
    encode (string "bread") -- <62 72 65 61 64>
    encode (string "brød")  -- <62 72 C3B8 64>

Some characters take one byte, while others can take up to four. Read more
about [UTF-8](https://en.wikipedia.org/wiki/UTF-8) to learn the details!

But if you just encode UTF-8 directly, how can you know when you get to the end
of the string when you are decoding? So most protocols have an integer saying
how many bytes follow, like this:

    sizedString : String -> Encoder
    sizedString str =
      sequence
        [ unsignedInt32 BE (getStringWidth str)
        , string str
        ]

You can choose whatever representation you want for the width, which is helpful
because many protocols use different integer representations to save space. For
example:

- ProtoBuf uses [Base 128 Varints](https://developers.google.com/protocol-buffers/docs/encoding#varints)
- SQLite uses [Variable-Length Integers](https://www.sqlite.org/src4/doc/trunk/www/varint.wiki)

In both cases, small numbers can fit just one byte, saving some space. (The
SQLite encoding has the benefit that the first byte tells you how long the
number is, making it faster to decode.) In both cases, it is sort of tricky
to make negative numbers small.

string: String -> Bytes.Encode.Encoder
-}
string : String -> Elm.Expression
string stringArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "string"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
        )
        [ Elm.string stringArg ]


{-| Get the width of a `String` in UTF-8 bytes.

    getStringWidth "$20"   == 3
    getStringWidth "£20"   == 4
    getStringWidth "€20"   == 5
    getStringWidth "bread" == 5
    getStringWidth "brød"  == 5

Most protocols need this number to come directly before a chunk of UTF-8 bytes
as a way to know where the string ends!

Read more about how UTF-8 works [here](https://en.wikipedia.org/wiki/UTF-8).

getStringWidth: String -> Int
-}
getStringWidth : String -> Elm.Expression
getStringWidth getStringWidthArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "getStringWidth"
            , annotation = Just (Type.function [ Type.string ] Type.int)
            }
        )
        [ Elm.string getStringWidthArg ]


annotation_ : { encoder : Type.Annotation }
annotation_ =
    { encoder = Type.namedWith [ "Bytes", "Encode" ] "Encoder" [] }


call_ :
    { encode : Elm.Expression -> Elm.Expression
    , sequence : Elm.Expression -> Elm.Expression
    , signedInt8 : Elm.Expression -> Elm.Expression
    , signedInt16 : Elm.Expression -> Elm.Expression -> Elm.Expression
    , signedInt32 : Elm.Expression -> Elm.Expression -> Elm.Expression
    , unsignedInt8 : Elm.Expression -> Elm.Expression
    , unsignedInt16 : Elm.Expression -> Elm.Expression -> Elm.Expression
    , unsignedInt32 : Elm.Expression -> Elm.Expression -> Elm.Expression
    , float32 : Elm.Expression -> Elm.Expression -> Elm.Expression
    , float64 : Elm.Expression -> Elm.Expression -> Elm.Expression
    , bytes : Elm.Expression -> Elm.Expression
    , string : Elm.Expression -> Elm.Expression
    , getStringWidth : Elm.Expression -> Elm.Expression
    }
call_ =
    { encode =
        \encodeArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Encode" ]
                    , name = "encode"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Bytes", "Encode" ]
                                    "Encoder"
                                    []
                                ]
                                (Type.namedWith [ "Bytes" ] "Bytes" [])
                            )
                    }
                )
                [ encodeArg ]
    , sequence =
        \sequenceArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Encode" ]
                    , name = "sequence"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.namedWith
                                        [ "Bytes", "Encode" ]
                                        "Encoder"
                                        []
                                    )
                                ]
                                (Type.namedWith
                                    [ "Bytes", "Encode" ]
                                    "Encoder"
                                    []
                                )
                            )
                    }
                )
                [ sequenceArg ]
    , signedInt8 =
        \signedInt8Arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Encode" ]
                    , name = "signedInt8"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int ]
                                (Type.namedWith
                                    [ "Bytes", "Encode" ]
                                    "Encoder"
                                    []
                                )
                            )
                    }
                )
                [ signedInt8Arg ]
    , signedInt16 =
        \signedInt16Arg signedInt16Arg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Encode" ]
                    , name = "signedInt16"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Bytes" ] "Endianness" []
                                , Type.int
                                ]
                                (Type.namedWith
                                    [ "Bytes", "Encode" ]
                                    "Encoder"
                                    []
                                )
                            )
                    }
                )
                [ signedInt16Arg, signedInt16Arg0 ]
    , signedInt32 =
        \signedInt32Arg signedInt32Arg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Encode" ]
                    , name = "signedInt32"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Bytes" ] "Endianness" []
                                , Type.int
                                ]
                                (Type.namedWith
                                    [ "Bytes", "Encode" ]
                                    "Encoder"
                                    []
                                )
                            )
                    }
                )
                [ signedInt32Arg, signedInt32Arg0 ]
    , unsignedInt8 =
        \unsignedInt8Arg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Encode" ]
                    , name = "unsignedInt8"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int ]
                                (Type.namedWith
                                    [ "Bytes", "Encode" ]
                                    "Encoder"
                                    []
                                )
                            )
                    }
                )
                [ unsignedInt8Arg ]
    , unsignedInt16 =
        \unsignedInt16Arg unsignedInt16Arg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Encode" ]
                    , name = "unsignedInt16"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Bytes" ] "Endianness" []
                                , Type.int
                                ]
                                (Type.namedWith
                                    [ "Bytes", "Encode" ]
                                    "Encoder"
                                    []
                                )
                            )
                    }
                )
                [ unsignedInt16Arg, unsignedInt16Arg0 ]
    , unsignedInt32 =
        \unsignedInt32Arg unsignedInt32Arg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Encode" ]
                    , name = "unsignedInt32"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Bytes" ] "Endianness" []
                                , Type.int
                                ]
                                (Type.namedWith
                                    [ "Bytes", "Encode" ]
                                    "Encoder"
                                    []
                                )
                            )
                    }
                )
                [ unsignedInt32Arg, unsignedInt32Arg0 ]
    , float32 =
        \float32Arg float32Arg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Encode" ]
                    , name = "float32"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Bytes" ] "Endianness" []
                                , Type.float
                                ]
                                (Type.namedWith
                                    [ "Bytes", "Encode" ]
                                    "Encoder"
                                    []
                                )
                            )
                    }
                )
                [ float32Arg, float32Arg0 ]
    , float64 =
        \float64Arg float64Arg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Encode" ]
                    , name = "float64"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Bytes" ] "Endianness" []
                                , Type.float
                                ]
                                (Type.namedWith
                                    [ "Bytes", "Encode" ]
                                    "Encoder"
                                    []
                                )
                            )
                    }
                )
                [ float64Arg, float64Arg0 ]
    , bytes =
        \bytesArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Encode" ]
                    , name = "bytes"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Bytes" ] "Bytes" [] ]
                                (Type.namedWith
                                    [ "Bytes", "Encode" ]
                                    "Encoder"
                                    []
                                )
                            )
                    }
                )
                [ bytesArg ]
    , string =
        \stringArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Encode" ]
                    , name = "string"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith
                                    [ "Bytes", "Encode" ]
                                    "Encoder"
                                    []
                                )
                            )
                    }
                )
                [ stringArg ]
    , getStringWidth =
        \getStringWidthArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes", "Encode" ]
                    , name = "getStringWidth"
                    , annotation = Just (Type.function [ Type.string ] Type.int)
                    }
                )
                [ getStringWidthArg ]
    }


values_ :
    { encode : Elm.Expression
    , sequence : Elm.Expression
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
    , getStringWidth : Elm.Expression
    }
values_ =
    { encode =
        Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "encode"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes", "Encode" ] "Encoder" [] ]
                        (Type.namedWith [ "Bytes" ] "Bytes" [])
                    )
            }
    , sequence =
        Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "sequence"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                        ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
    , signedInt8 =
        Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "signedInt8"
            , annotation =
                Just
                    (Type.function
                        [ Type.int ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
    , signedInt16 =
        Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "signedInt16"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" [], Type.int ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
    , signedInt32 =
        Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "signedInt32"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" [], Type.int ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
    , unsignedInt8 =
        Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "unsignedInt8"
            , annotation =
                Just
                    (Type.function
                        [ Type.int ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
    , unsignedInt16 =
        Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "unsignedInt16"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" [], Type.int ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
    , unsignedInt32 =
        Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "unsignedInt32"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" [], Type.int ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
    , float32 =
        Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "float32"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" []
                        , Type.float
                        ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
    , float64 =
        Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "float64"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Endianness" []
                        , Type.float
                        ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
    , bytes =
        Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "bytes"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Bytes" [] ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
    , string =
        Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "string"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [ "Bytes", "Encode" ] "Encoder" [])
                    )
            }
    , getStringWidth =
        Elm.value
            { importFrom = [ "Bytes", "Encode" ]
            , name = "getStringWidth"
            , annotation = Just (Type.function [ Type.string ] Type.int)
            }
    }


