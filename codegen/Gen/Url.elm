module Gen.Url exposing (annotation_, call_, caseOf_, fromString, make_, moduleName_, percentDecode, percentEncode, toString, values_)

{-| 
@docs moduleName_, toString, fromString, percentEncode, percentDecode, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Url" ]


{-| Turn a [`Url`](#Url) into a `String`.

toString: Url.Url -> String
-}
toString : Elm.Expression -> Elm.Expression
toString toStringArg =
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
        [ toStringArg ]


{-| Attempt to break a URL up into [`Url`](#Url). This is useful in
single-page apps when you want to parse certain chunks of a URL to figure out
what to show on screen.

    fromString "https://example.com:443"
    -- Just
    --   { protocol = Https
    --   , host = "example.com"
    --   , port_ = Just 443
    --   , path = "/"
    --   , query = Nothing
    --   , fragment = Nothing
    --   }

    fromString "https://example.com/hats?q=top%20hat"
    -- Just
    --   { protocol = Https
    --   , host = "example.com"
    --   , port_ = Nothing
    --   , path = "/hats"
    --   , query = Just "q=top%20hat"
    --   , fragment = Nothing
    --   }

    fromString "http://example.com/core/List/#map"
    -- Just
    --   { protocol = Http
    --   , host = "example.com"
    --   , port_ = Nothing
    --   , path = "/core/List/"
    --   , query = Nothing
    --   , fragment = Just "map"
    --   }

The conversion to segments can fail in some cases as well:

    fromString "example.com:443"        == Nothing  -- no protocol
    fromString "http://tom@example.com" == Nothing  -- userinfo disallowed
    fromString "http://#cats"           == Nothing  -- no host

**Note:** This function does not use [`percentDecode`](#percentDecode) anything.
It just splits things up. [`Url.Parser`](Url-Parser) actually _needs_ the raw
`query` string to parse it properly. Otherwise it could get confused about `=`
and `&` characters!

fromString: String -> Maybe Url.Url
-}
fromString : String -> Elm.Expression
fromString fromStringArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url" ]
             , name = "fromString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.maybe (Type.namedWith [ "Url" ] "Url" []))
                     )
             }
        )
        [ Elm.string fromStringArg ]


{-| **Use [Url.Builder](Url-Builder) instead!** Functions like `absolute`,
`relative`, and `crossOrigin` already do this automatically! `percentEncode`
is only available so that extremely custom cases are possible, if needed.

Percent-encoding is how [the official URI spec][uri] “escapes” special
characters. You can still represent a `?` even though it is reserved for
queries.

This function exists in case you want to do something extra custom. Here are
some examples:

    -- standard ASCII encoding
    percentEncode "hat"   == "hat"
    percentEncode "to be" == "to%20be"
    percentEncode "99%"   == "99%25"

    -- non-standard, but widely accepted, UTF-8 encoding
    percentEncode "$" == "%24"
    percentEncode "¢" == "%C2%A2"
    percentEncode "€" == "%E2%82%AC"

This is the same behavior as JavaScript's [`encodeURIComponent`][js] function,
and the rules are described in more detail officially [here][s2] and with some
notes about Unicode [here][wiki].

[js]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/encodeURIComponent
[uri]: https://tools.ietf.org/html/rfc3986
[s2]: https://tools.ietf.org/html/rfc3986#section-2.1
[wiki]: https://en.wikipedia.org/wiki/Percent-encoding

percentEncode: String -> String
-}
percentEncode : String -> Elm.Expression
percentEncode percentEncodeArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url" ]
             , name = "percentEncode"
             , annotation = Just (Type.function [ Type.string ] Type.string)
             }
        )
        [ Elm.string percentEncodeArg ]


{-| **Use [Url.Parser](Url-Parser) instead!** It will decode query
parameters appropriately already! `percentDecode` is only available so that
extremely custom cases are possible, if needed.

Check out the `percentEncode` function to learn about percent-encoding.
This function does the opposite! Here are the reverse examples:

    -- ASCII
    percentDecode "99%25"     == Just "hat"
    percentDecode "to%20be"   == Just "to be"
    percentDecode "hat"       == Just "99%"

    -- UTF-8
    percentDecode "%24"       == Just "$"
    percentDecode "%C2%A2"    == Just "¢"
    percentDecode "%E2%82%AC" == Just "€"

Why is it a `Maybe` though? Well, these strings come from strangers on the
internet as a bunch of bits and may have encoding problems. For example:

    percentDecode "%"   == Nothing  -- not followed by two hex digits
    percentDecode "%XY" == Nothing  -- not followed by two HEX digits
    percentDecode "%C2" == Nothing  -- half of the "¢" encoding "%C2%A2"

This is the same behavior as JavaScript's [`decodeURIComponent`][js] function.

[js]: https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/decodeURIComponent

percentDecode: String -> Maybe String
-}
percentDecode : String -> Elm.Expression
percentDecode percentDecodeArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url" ]
             , name = "percentDecode"
             , annotation =
                 Just (Type.function [ Type.string ] (Type.maybe Type.string))
             }
        )
        [ Elm.string percentDecodeArg ]


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


make_ :
    { url :
        { protocol : Elm.Expression
        , host : Elm.Expression
        , port_ : Elm.Expression
        , path : Elm.Expression
        , query : Elm.Expression
        , fragment : Elm.Expression
        }
        -> Elm.Expression
    , http : Elm.Expression
    , https : Elm.Expression
    }
make_ =
    { url =
        \url_args ->
            Elm.withType
                (Type.alias
                     [ "Url" ]
                     "Url"
                     []
                     (Type.record
                          [ ( "protocol"
                            , Type.namedWith [ "Url" ] "Protocol" []
                            )
                          , ( "host", Type.string )
                          , ( "port_", Type.maybe Type.int )
                          , ( "path", Type.string )
                          , ( "query", Type.maybe Type.string )
                          , ( "fragment", Type.maybe Type.string )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "protocol" url_args.protocol
                     , Tuple.pair "host" url_args.host
                     , Tuple.pair "port_" url_args.port_
                     , Tuple.pair "path" url_args.path
                     , Tuple.pair "query" url_args.query
                     , Tuple.pair "fragment" url_args.fragment
                     ]
                )
    , http =
        Elm.value
            { importFrom = [ "Url" ]
            , name = "Http"
            , annotation = Just (Type.namedWith [] "Protocol" [])
            }
    , https =
        Elm.value
            { importFrom = [ "Url" ]
            , name = "Https"
            , annotation = Just (Type.namedWith [] "Protocol" [])
            }
    }


caseOf_ :
    { protocol :
        Elm.Expression
        -> { protocolTags_0_0 | http : Elm.Expression, https : Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { protocol =
        \protocolExpression protocolTags ->
            Elm.Case.custom
                protocolExpression
                (Type.namedWith [ "Url" ] "Protocol" [])
                [ Elm.Case.branch0 "Http" protocolTags.http
                , Elm.Case.branch0 "Https" protocolTags.https
                ]
    }


call_ :
    { toString : Elm.Expression -> Elm.Expression
    , fromString : Elm.Expression -> Elm.Expression
    , percentEncode : Elm.Expression -> Elm.Expression
    , percentDecode : Elm.Expression -> Elm.Expression
    }
call_ =
    { toString =
        \toStringArg ->
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
                [ toStringArg ]
    , fromString =
        \fromStringArg ->
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
                [ fromStringArg ]
    , percentEncode =
        \percentEncodeArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url" ]
                     , name = "percentEncode"
                     , annotation =
                         Just (Type.function [ Type.string ] Type.string)
                     }
                )
                [ percentEncodeArg ]
    , percentDecode =
        \percentDecodeArg ->
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
                [ percentDecodeArg ]
    }


values_ :
    { toString : Elm.Expression
    , fromString : Elm.Expression
    , percentEncode : Elm.Expression
    , percentDecode : Elm.Expression
    }
values_ =
    { toString =
        Elm.value
            { importFrom = [ "Url" ]
            , name = "toString"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Url" ] "Url" [] ]
                         Type.string
                    )
            }
    , fromString =
        Elm.value
            { importFrom = [ "Url" ]
            , name = "fromString"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.maybe (Type.namedWith [ "Url" ] "Url" []))
                    )
            }
    , percentEncode =
        Elm.value
            { importFrom = [ "Url" ]
            , name = "percentEncode"
            , annotation = Just (Type.function [ Type.string ] Type.string)
            }
    , percentDecode =
        Elm.value
            { importFrom = [ "Url" ]
            , name = "percentDecode"
            , annotation =
                Just (Type.function [ Type.string ] (Type.maybe Type.string))
            }
    }