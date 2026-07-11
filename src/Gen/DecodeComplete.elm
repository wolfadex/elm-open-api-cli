module Gen.DecodeComplete exposing
    ( object, required, omissible
    , complete
    )

{-|


# Generated bindings for DecodeComplete

@docs object, required, omissible, discard
@docs completeRest

-}

import Elm
import Elm.Annotation as Type


{-| Start decoding a JSON object.

object: a -> DecodeComplete.ObjectDecoder a

-}
object : Elm.Expression -> Elm.Expression
object objectArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "DecodeComplete" ]
            , name = "object"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a" ]
                        (Type.namedWith
                            [ "DecodeComplete" ]
                            "ObjectDecoder"
                            [ Type.var "a" ]
                        )
                    )
            }
        )
        [ objectArg_ ]


{-| Decode the field given by the `String` parameter using the given (regular) `Decoder`. If the field is missing, the decoder fails.

required:
String
-> Json.Decode.Decoder a
-> DecodeComplete.ObjectDecoder (a -> b)
-> DecodeComplete.ObjectDecoder b

-}
required : String -> Elm.Expression -> Elm.Expression -> Elm.Expression
required requiredArg_ requiredArg_0 requiredArg_1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "DecodeComplete" ]
            , name = "required"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "DecodeComplete" ]
                            "ObjectDecoder"
                            [ Type.function [ Type.var "a" ] (Type.var "b") ]
                        ]
                        (Type.namedWith
                            [ "DecodeComplete" ]
                            "ObjectDecoder"
                            [ Type.var "b" ]
                        )
                    )
            }
        )
        [ Elm.string requiredArg_, requiredArg_0, requiredArg_1 ]


{-| Decode the field given by the `String` parameter using the given (regular) `Decoder`. If the field is missing use the provided default value instead. If the field decoder fails, the object decoder will fail.

If you want to ignore field decoding failures, use `optional`.

omissible:
String
-> Json.Decode.Decoder a
-> a
-> DecodeComplete.ObjectDecoder (a -> b)
-> DecodeComplete.ObjectDecoder b

-}
omissible :
    String
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
omissible omissibleArg_ omissibleArg_0 omissibleArg_1 omissibleArg_2 =
    Elm.apply
        (Elm.value
            { importFrom = [ "DecodeComplete" ]
            , name = "omissible"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        , Type.var "a"
                        , Type.namedWith
                            [ "DecodeComplete" ]
                            "ObjectDecoder"
                            [ Type.function [ Type.var "a" ] (Type.var "b") ]
                        ]
                        (Type.namedWith
                            [ "DecodeComplete" ]
                            "ObjectDecoder"
                            [ Type.var "b" ]
                        )
                    )
            }
        )
        [ Elm.string omissibleArg_
        , omissibleArg_0
        , omissibleArg_1
        , omissibleArg_2
        ]


{-| Close the `ObjectDecoder`, turning it into a regular `Decoder`. If unhandled fields in the JSON remain, this decoder will fail.

complete: DecodeComplete.ObjectDecoder a -> Json.Decode.Decoder a

-}
complete : Elm.Expression -> Elm.Expression
complete completeArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "DecodeComplete" ]
            , name = "complete"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "DecodeComplete" ]
                            "ObjectDecoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        )
                    )
            }
        )
        [ completeArg_ ]
