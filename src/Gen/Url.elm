module Gen.Url exposing
    ( toString, annotation_
    , call_
    )

{-|


# Generated bindings for Url

@docs toString, annotation_
@docs call_

-}

import Elm
import Elm.Annotation as Type


{-| The name of this module.
-}
moduleName_ : List String
moduleName_ =
    [ "Url" ]


{-| Turn a [`Url`](#Url) into a `String`.

toString: Url.Url -> String

-}
toString : Elm.Expression -> Elm.Expression
toString toStringArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Url" ]
            , name = "toString"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Url" ] "Url" [] ]
                        Type.string
                    )
            }
        )
        [ toStringArg_ ]


annotation_ : { url : Type.Annotation, protocol : Type.Annotation }
annotation_ =
    { url =
        Type.alias
            moduleName_
            "Url"
            []
            (Type.record
                [ ( "protocol", Type.namedWith [ "Url" ] "Protocol" [] )
                , ( "host", Type.string )
                , ( "port_", Type.maybe Type.int )
                , ( "path", Type.string )
                , ( "query", Type.maybe Type.string )
                , ( "fragment", Type.maybe Type.string )
                ]
            )
    , protocol = Type.namedWith [ "Url" ] "Protocol" []
    }


call_ :
    { toString : Elm.Expression -> Elm.Expression
    , fromString : Elm.Expression -> Elm.Expression
    , percentEncode : Elm.Expression -> Elm.Expression
    , percentDecode : Elm.Expression -> Elm.Expression
    }
call_ =
    { toString =
        \toStringArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Url" ]
                    , name = "toString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Url" ] "Url" [] ]
                                Type.string
                            )
                    }
                )
                [ toStringArg_ ]
    , fromString =
        \fromStringArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Url" ]
                    , name = "fromString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.maybe
                                    (Type.namedWith [ "Url" ] "Url" [])
                                )
                            )
                    }
                )
                [ fromStringArg_ ]
    , percentEncode =
        \percentEncodeArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Url" ]
                    , name = "percentEncode"
                    , annotation =
                        Just (Type.function [ Type.string ] Type.string)
                    }
                )
                [ percentEncodeArg_ ]
    , percentDecode =
        \percentDecodeArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Url" ]
                    , name = "percentDecode"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.maybe Type.string)
                            )
                    }
                )
                [ percentDecodeArg_ ]
    }
