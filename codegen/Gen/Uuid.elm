module Gen.Uuid exposing
    ( moduleName_, generator, fromString, toString, encode, decoder
    , stringGenerator, isValidUuid, annotation_, call_, values_
    )

{-|
# Generated bindings for Uuid

@docs moduleName_, generator, fromString, toString, encode, decoder
@docs stringGenerator, isValidUuid, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Uuid" ]


{-| Random.Pcg.Extended generator for Uuids.

To provide enough randomness, you should seed this generator with at least 4 32-bit integers
that are aquired from JavaScript via `crypto.getRandomValues(...)`.
See the examples on how to do this properly.

generator: Random.Pcg.Extended.Generator Uuid.Uuid
-}
generator : Elm.Expression
generator =
    Elm.value
        { importFrom = [ "Uuid" ]
        , name = "generator"
        , annotation =
            Just
                (Type.namedWith
                     [ "Random", "Pcg", "Extended" ]
                     "Generator"
                     [ Type.namedWith [ "Uuid" ] "Uuid" [] ]
                )
        }


{-| Create a Uuid from a String in the canonical form (e.g.
"63B9AAA2-6AAF-473E-B37E-22EB66E66B76"). Note that this module supports
canonical Uuids, Versions 1-5 and 7, and will refuse to parse other Uuid variants.

fromString: String -> Maybe Uuid.Uuid
-}
fromString : String -> Elm.Expression
fromString fromStringArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Uuid" ]
             , name = "fromString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.maybe (Type.namedWith [ "Uuid" ] "Uuid" []))
                     )
             }
        )
        [ Elm.string fromStringArg_ ]


{-| Create a string representation from a Uuid in the canonical 8-4-4-4-12 form, i.e.
"63B9AAA2-6AAF-473E-B37E-22EB66E66B76"

toString: Uuid.Uuid -> String
-}
toString : Elm.Expression -> Elm.Expression
toString toStringArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Uuid" ]
             , name = "toString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Uuid" ] "Uuid" [] ]
                          Type.string
                     )
             }
        )
        [ toStringArg_ ]


{-| Encode Uuid to Json

encode: Uuid.Uuid -> Json.Encode.Value
-}
encode : Elm.Expression -> Elm.Expression
encode encodeArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Uuid" ]
             , name = "encode"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Uuid" ] "Uuid" [] ]
                          (Type.namedWith [ "Json", "Encode" ] "Value" [])
                     )
             }
        )
        [ encodeArg_ ]


{-| Decoder for getting Uuid out of Json

decoder: Json.Decode.Decoder Uuid.Uuid
-}
decoder : Elm.Expression
decoder =
    Elm.value
        { importFrom = [ "Uuid" ]
        , name = "decoder"
        , annotation =
            Just
                (Type.namedWith
                     [ "Json", "Decode" ]
                     "Decoder"
                     [ Type.namedWith [ "Uuid" ] "Uuid" [] ]
                )
        }


{-| Random.Pcg.Extended generator for Uuid Strings.

stringGenerator: Random.Pcg.Extended.Generator String
-}
stringGenerator : Elm.Expression
stringGenerator =
    Elm.value
        { importFrom = [ "Uuid" ]
        , name = "stringGenerator"
        , annotation =
            Just
                (Type.namedWith
                     [ "Random", "Pcg", "Extended" ]
                     "Generator"
                     [ Type.string ]
                )
        }


{-| Check if the given string is a valid UUID

isValidUuid: String -> Bool
-}
isValidUuid : String -> Elm.Expression
isValidUuid isValidUuidArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Uuid" ]
             , name = "isValidUuid"
             , annotation = Just (Type.function [ Type.string ] Type.bool)
             }
        )
        [ Elm.string isValidUuidArg_ ]


annotation_ : { uuid : Type.Annotation }
annotation_ =
    { uuid = Type.namedWith [ "Uuid" ] "Uuid" [] }


call_ :
    { fromString : Elm.Expression -> Elm.Expression
    , toString : Elm.Expression -> Elm.Expression
    , encode : Elm.Expression -> Elm.Expression
    , isValidUuid : Elm.Expression -> Elm.Expression
    }
call_ =
    { fromString =
        \fromStringArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Uuid" ]
                     , name = "fromString"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.maybe
                                       (Type.namedWith [ "Uuid" ] "Uuid" [])
                                  )
                             )
                     }
                )
                [ fromStringArg_ ]
    , toString =
        \toStringArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Uuid" ]
                     , name = "toString"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Uuid" ] "Uuid" [] ]
                                  Type.string
                             )
                     }
                )
                [ toStringArg_ ]
    , encode =
        \encodeArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Uuid" ]
                     , name = "encode"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Uuid" ] "Uuid" [] ]
                                  (Type.namedWith
                                       [ "Json", "Encode" ]
                                       "Value"
                                       []
                                  )
                             )
                     }
                )
                [ encodeArg_ ]
    , isValidUuid =
        \isValidUuidArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Uuid" ]
                     , name = "isValidUuid"
                     , annotation =
                         Just (Type.function [ Type.string ] Type.bool)
                     }
                )
                [ isValidUuidArg_ ]
    }


values_ :
    { generator : Elm.Expression
    , fromString : Elm.Expression
    , toString : Elm.Expression
    , encode : Elm.Expression
    , decoder : Elm.Expression
    , stringGenerator : Elm.Expression
    , isValidUuid : Elm.Expression
    }
values_ =
    { generator =
        Elm.value
            { importFrom = [ "Uuid" ]
            , name = "generator"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Random", "Pcg", "Extended" ]
                         "Generator"
                         [ Type.namedWith [ "Uuid" ] "Uuid" [] ]
                    )
            }
    , fromString =
        Elm.value
            { importFrom = [ "Uuid" ]
            , name = "fromString"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.maybe (Type.namedWith [ "Uuid" ] "Uuid" []))
                    )
            }
    , toString =
        Elm.value
            { importFrom = [ "Uuid" ]
            , name = "toString"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Uuid" ] "Uuid" [] ]
                         Type.string
                    )
            }
    , encode =
        Elm.value
            { importFrom = [ "Uuid" ]
            , name = "encode"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Uuid" ] "Uuid" [] ]
                         (Type.namedWith [ "Json", "Encode" ] "Value" [])
                    )
            }
    , decoder =
        Elm.value
            { importFrom = [ "Uuid" ]
            , name = "decoder"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Json", "Decode" ]
                         "Decoder"
                         [ Type.namedWith [ "Uuid" ] "Uuid" [] ]
                    )
            }
    , stringGenerator =
        Elm.value
            { importFrom = [ "Uuid" ]
            , name = "stringGenerator"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Random", "Pcg", "Extended" ]
                         "Generator"
                         [ Type.string ]
                    )
            }
    , isValidUuid =
        Elm.value
            { importFrom = [ "Uuid" ]
            , name = "isValidUuid"
            , annotation = Just (Type.function [ Type.string ] Type.bool)
            }
    }