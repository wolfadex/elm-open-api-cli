module Gen.Uuid exposing
    ( toString
    , annotation_, call_
    )

{-|


# Generated bindings for Uuid

@docs toString
@docs annotation_, call_

-}

import Elm
import Elm.Annotation as Type


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
