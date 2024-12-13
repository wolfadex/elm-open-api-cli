module Gen.Bytes.Decode exposing
    ( moduleName_, decode, signedInt8, signedInt16, signedInt32, unsignedInt8
    , unsignedInt16, unsignedInt32, float32, float64, bytes, string, map
    , map2, map3, map4, map5, andThen, succeed, fail
    , loop, annotation_, make_, caseOf_, call_, values_
    )

{-|
# Generated bindings for Bytes.Decode

@docs moduleName_, decode, signedInt8, signedInt16, signedInt32, unsignedInt8
@docs unsignedInt16, unsignedInt32, float32, float64, bytes, string
@docs map, map2, map3, map4, map5, andThen
@docs succeed, fail, loop, annotation_, make_, caseOf_
@docs call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Bytes", "Decode" ]


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


{-| Decode one byte into an integer from `-128` to `127`.

signedInt8: Bytes.Decode.Decoder Int
-}
signedInt8 : Elm.Expression
signedInt8 =
    Elm.value
        { importFrom = [ "Bytes", "Decode" ]
        , name = "signedInt8"
        , annotation =
            Just (Type.namedWith [ "Bytes", "Decode" ] "Decoder" [ Type.int ])
        }


{-| Decode two bytes into an integer from `-32768` to `32767`.

signedInt16: Bytes.Endianness -> Bytes.Decode.Decoder Int
-}
signedInt16 : Elm.Expression -> Elm.Expression
signedInt16 signedInt16Arg_ =
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


{-| Decode four bytes into an integer from `-2147483648` to `2147483647`.

signedInt32: Bytes.Endianness -> Bytes.Decode.Decoder Int
-}
signedInt32 : Elm.Expression -> Elm.Expression
signedInt32 signedInt32Arg_ =
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


{-| Decode one byte into an integer from `0` to `255`.

unsignedInt8: Bytes.Decode.Decoder Int
-}
unsignedInt8 : Elm.Expression
unsignedInt8 =
    Elm.value
        { importFrom = [ "Bytes", "Decode" ]
        , name = "unsignedInt8"
        , annotation =
            Just (Type.namedWith [ "Bytes", "Decode" ] "Decoder" [ Type.int ])
        }


{-| Decode two bytes into an integer from `0` to `65535`.

unsignedInt16: Bytes.Endianness -> Bytes.Decode.Decoder Int
-}
unsignedInt16 : Elm.Expression -> Elm.Expression
unsignedInt16 unsignedInt16Arg_ =
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


{-| Decode four bytes into an integer from `0` to `4294967295`.

unsignedInt32: Bytes.Endianness -> Bytes.Decode.Decoder Int
-}
unsignedInt32 : Elm.Expression -> Elm.Expression
unsignedInt32 unsignedInt32Arg_ =
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


{-| Decode four bytes into a floating point number.

float32: Bytes.Endianness -> Bytes.Decode.Decoder Float
-}
float32 : Elm.Expression -> Elm.Expression
float32 float32Arg_ =
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


{-| Decode eight bytes into a floating point number.

float64: Bytes.Endianness -> Bytes.Decode.Decoder Float
-}
float64 : Elm.Expression -> Elm.Expression
float64 float64Arg_ =
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


{-| Copy a given number of bytes into a new `Bytes` sequence.

bytes: Int -> Bytes.Decode.Decoder Bytes.Bytes
-}
bytes : Int -> Elm.Expression
bytes bytesArg_ =
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
        [ Elm.int bytesArg_ ]


{-| Decode a given number of UTF-8 bytes into a `String`.

Most protocols store the width of the string right before the content, so you
will probably write things like this:

    import Bytes exposing (Endianness(..))
    import Bytes.Decode as Decode

    sizedString : Decode.Decoder String
    sizedString =
      Decode.unsignedInt32 BE
        |> Decode.andThen Decode.string

In this case we read the width as a 32-bit unsigned integer, but you have the
leeway to read the width as a [Base 128 Varint][pb] for ProtoBuf, a
[Variable-Length Integer][sql] for SQLite, or whatever else they dream up.

[pb]: https://developers.google.com/protocol-buffers/docs/encoding#varints
[sql]: https://www.sqlite.org/src4/doc/trunk/www/varint.wiki

string: Int -> Bytes.Decode.Decoder String
-}
string : Int -> Elm.Expression
string stringArg_ =
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
        [ Elm.int stringArg_ ]


{-| Transform the value produced by a decoder. If you encode negative numbers
in a special way, you can say something like this:

    negativeInt8 : Decoder Int
    negativeInt8 =
      map negate unsignedInt8

In practice you may see something like ProtoBuf’s [ZigZag encoding][zz] which
decreases the size of small negative numbers.

[zz]: https://developers.google.com/protocol-buffers/docs/encoding#types

map: (a -> b) -> Bytes.Decode.Decoder a -> Bytes.Decode.Decoder b
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg_ mapArg_0 =
    Elm.apply
        (Elm.value
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
        )
        [ Elm.functionReduced "mapUnpack" mapArg_, mapArg_0 ]


{-| Combine two decoders.

    import Bytes exposing (Endiannness(..))
    import Bytes.Decode as Decode

    type alias Point = { x : Float, y : Float }

    decoder : Decode.Decoder Point
    decoder =
      Decode.map2 Point
        (Decode.float32 BE)
        (Decode.float32 BE)

map2: 
    (a -> b -> result)
    -> Bytes.Decode.Decoder a
    -> Bytes.Decode.Decoder b
    -> Bytes.Decode.Decoder result
-}
map2 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map2 map2Arg_ map2Arg_0 map2Arg_1 =
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
        [ Elm.functionReduced
            "map2Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced "unpack" (map2Arg_ functionReducedUnpack)
            )
        , map2Arg_0
        , map2Arg_1
        ]


{-| Combine three decoders.

map3: 
    (a -> b -> c -> result)
    -> Bytes.Decode.Decoder a
    -> Bytes.Decode.Decoder b
    -> Bytes.Decode.Decoder c
    -> Bytes.Decode.Decoder result
-}
map3 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map3 map3Arg_ map3Arg_0 map3Arg_1 map3Arg_2 =
    Elm.apply
        (Elm.value
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
        )
        [ Elm.functionReduced
            "map3Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            ((map3Arg_ functionReducedUnpack)
                                 functionReducedUnpack0
                            )
                   )
            )
        , map3Arg_0
        , map3Arg_1
        , map3Arg_2
        ]


{-| Combine four decoders.

map4: 
    (a -> b -> c -> d -> result)
    -> Bytes.Decode.Decoder a
    -> Bytes.Decode.Decoder b
    -> Bytes.Decode.Decoder c
    -> Bytes.Decode.Decoder d
    -> Bytes.Decode.Decoder result
-}
map4 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map4 map4Arg_ map4Arg_0 map4Arg_1 map4Arg_2 map4Arg_3 =
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
        [ Elm.functionReduced
            "map4Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (((map4Arg_ functionReducedUnpack)
                                           functionReducedUnpack0
                                      )
                                          functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                     )
                            )
                   )
            )
        , map4Arg_0
        , map4Arg_1
        , map4Arg_2
        , map4Arg_3
        ]


{-| Combine five decoders. If you need to combine more things, it is possible
to define more of these with `map2` or `andThen`.

map5: 
    (a -> b -> c -> d -> e -> result)
    -> Bytes.Decode.Decoder a
    -> Bytes.Decode.Decoder b
    -> Bytes.Decode.Decoder c
    -> Bytes.Decode.Decoder d
    -> Bytes.Decode.Decoder e
    -> Bytes.Decode.Decoder result
-}
map5 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map5 map5Arg_ map5Arg_0 map5Arg_1 map5Arg_2 map5Arg_3 map5Arg_4 =
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
        [ Elm.functionReduced
            "map5Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (\functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0 ->
                                          Elm.functionReduced
                                              "unpack"
                                              ((((map5Arg_ functionReducedUnpack
                                                 )
                                                     functionReducedUnpack0
                                                )
                                                    functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                               )
                                                   functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0
                                              )
                                     )
                            )
                   )
            )
        , map5Arg_0
        , map5Arg_1
        , map5Arg_2
        , map5Arg_3
        , map5Arg_4
        ]


{-| Decode something **and then** use that information to decode something
else. This is most common with strings or sequences where you need to read
how long the value is going to be:

    import Bytes exposing (Endianness(..))
    import Bytes.Decode as Decode

    string : Decoder String
    string =
      Decode.unsignedInt32 BE
        |> Decode.andThen Decode.string

Check out the docs for [`succeed`](#succeed), [`fail`](#fail), and
[`loop`](#loop) to see `andThen` used in more ways!

andThen: 
    (a -> Bytes.Decode.Decoder b)
    -> Bytes.Decode.Decoder a
    -> Bytes.Decode.Decoder b
-}
andThen : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
andThen andThenArg_ andThenArg_0 =
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
        [ Elm.functionReduced "andThenUnpack" andThenArg_, andThenArg_0 ]


{-| A decoder that always succeeds with a certain value. Maybe we are making
a `Maybe` decoder:

    import Bytes.Decode as Decode exposing (Decoder)

    maybe : Decoder a -> Decoder (Maybe a)
    maybe decoder =
      let
        helper n =
          if n == 0 then
            Decode.succeed Nothing
          else
            Decode.map Just decoder
      in
      Decode.unsignedInt8
        |> Decode.andThen helper

If the first byte is `00000000` then it is `Nothing`, otherwise we start
decoding the value and put it in a `Just`.

succeed: a -> Bytes.Decode.Decoder a
-}
succeed : Elm.Expression -> Elm.Expression
succeed succeedArg_ =
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


{-| A decoder that always fails. This can be useful when using `andThen` to
decode custom types:

    import Bytes exposing (Endianness(..))
    import Bytes.Encode as Encode
    import Bytes.Decode as Decode

    type Distance = Yards Float | Meters Float

    toEncoder : Distance -> Encode.Encoder
    toEncoder distance =
      case distance of
        Yards n -> Encode.sequence [ Encode.unsignedInt8 0, Encode.float32 BE n ]
        Meters n -> Encode.sequence [ Encode.unsignedInt8 1, Encode.float32 BE n ]

    decoder : Decode.Decoder Distance
    decoder =
      Decode.unsignedInt8
        |> Decode.andThen pickDecoder

    pickDecoder : Int -> Decode.Decoder Distance
    pickDecoder tag =
      case tag of
        0 -> Decode.map Yards (Decode.float32 BE)
        1 -> Decode.map Meters (Decode.float32 BE)
        _ -> Decode.fail

The encoding chosen here uses an 8-bit unsigned integer to indicate which
variant we are working with. If we are working with yards do this, if we are
working with meters do that, and otherwise something went wrong!

fail: Bytes.Decode.Decoder a
-}
fail : Elm.Expression
fail =
    Elm.value
        { importFrom = [ "Bytes", "Decode" ]
        , name = "fail"
        , annotation =
            Just
                (Type.namedWith [ "Bytes", "Decode" ] "Decoder" [ Type.var "a" ]
                )
        }


{-| A decoder that can loop indefinitely. This can be helpful when parsing
repeated structures, like a list:

    import Bytes exposing (Endianness(..))
    import Bytes.Decode as Decode exposing (..)

    list : Decoder a -> Decoder (List a)
    list decoder =
      unsignedInt32 BE
        |> andThen (\len -> loop (len, []) (listStep decoder))

    listStep : Decoder a -> (Int, List a) -> Decoder (Step (Int, List a) (List a))
    listStep decoder (n, xs) =
      if n <= 0 then
        succeed (Done xs)
      else
        map (\x -> Loop (n - 1, x :: xs)) decoder

The `list` decoder first reads a 32-bit unsigned integer. That determines how
many items will be decoded. From there we use [`loop`](#loop) to track all the
items we have parsed so far and figure out when to stop.

loop: 
    state
    -> (state -> Bytes.Decode.Decoder (Bytes.Decode.Step state a))
    -> Bytes.Decode.Decoder a
-}
loop : Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
loop loopArg_ loopArg_0 =
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
        )
        [ loopArg_, Elm.functionReduced "loopUnpack" loopArg_0 ]


annotation_ :
    { decoder : Type.Annotation -> Type.Annotation
    , step : Type.Annotation -> Type.Annotation -> Type.Annotation
    }
annotation_ =
    { decoder =
        \decoderArg0 ->
            Type.namedWith [ "Bytes", "Decode" ] "Decoder" [ decoderArg0 ]
    , step =
        \stepArg0 stepArg1 ->
            Type.namedWith [ "Bytes", "Decode" ] "Step" [ stepArg0, stepArg1 ]
    }


make_ :
    { loop : Elm.Expression -> Elm.Expression
    , done : Elm.Expression -> Elm.Expression
    }
make_ =
    { loop =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Bytes", "Decode" ]
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
                     { importFrom = [ "Bytes", "Decode" ]
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
    }


caseOf_ :
    { step :
        Elm.Expression
        -> { loop : Elm.Expression -> Elm.Expression
        , done : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { step =
        \stepExpression stepTags ->
            Elm.Case.custom
                stepExpression
                (Type.namedWith
                     [ "Bytes", "Decode" ]
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
    }


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
                    (Type.namedWith [ "Bytes", "Decode" ] "Decoder" [ Type.int ]
                    )
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
                    (Type.namedWith [ "Bytes", "Decode" ] "Decoder" [ Type.int ]
                    )
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