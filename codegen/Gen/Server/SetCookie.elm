module Gen.Server.SetCookie exposing (annotation_, call_, caseOf_, makeVisibleToJavaScript, make_, moduleName_, nonSecure, options, setCookie, toString, values_, withDomain, withExpiration, withImmediateExpiration, withMaxAge, withPath, withSameSite, withoutPath)

{-| 
@docs moduleName_, setCookie, options, withSameSite, withImmediateExpiration, makeVisibleToJavaScript, nonSecure, withDomain, withExpiration, withMaxAge, withPath, withoutPath, toString, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Server", "SetCookie" ]


{-| Create a `SetCookie` record with the given name, value, and [`Options`](Options]. To add a `Set-Cookie` header, you can
pass this value with [`Server.Response.withSetCookieHeader`](Server-Response#withSetCookieHeader). Or for more low-level
uses you can stringify the value manually with [`toString`](#toString).

setCookie: String -> String -> Server.SetCookie.Options -> Server.SetCookie.SetCookie
-}
setCookie : String -> String -> Elm.Expression -> Elm.Expression
setCookie setCookieArg setCookieArg0 setCookieArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "SetCookie" ]
             , name = "setCookie"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.string
                          , Type.namedWith
                              [ "Server", "SetCookie" ]
                              "Options"
                              []
                          ]
                          (Type.namedWith
                               [ "Server", "SetCookie" ]
                               "SetCookie"
                               []
                          )
                     )
             }
        )
        [ Elm.string setCookieArg, Elm.string setCookieArg0, setCookieArg1 ]


{-| Initialize the default `SetCookie` `Options`. Can be configured directly through a record update, or with `withExpiration`, etc.

options: Server.SetCookie.Options
-}
options : Elm.Expression
options =
    Elm.value
        { importFrom = [ "Server", "SetCookie" ]
        , name = "options"
        , annotation =
            Just (Type.namedWith [ "Server", "SetCookie" ] "Options" [])
        }


{-| The default SameSite policy is Lax if one is not explicitly set. See the SameSite section in <https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie#attributes>.

withSameSite: 
    Server.SetCookie.SameSite
    -> Server.SetCookie.Options
    -> Server.SetCookie.Options
-}
withSameSite : Elm.Expression -> Elm.Expression -> Elm.Expression
withSameSite withSameSiteArg withSameSiteArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "SetCookie" ]
             , name = "withSameSite"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Server", "SetCookie" ]
                              "SameSite"
                              []
                          , Type.namedWith
                              [ "Server", "SetCookie" ]
                              "Options"
                              []
                          ]
                          (Type.namedWith [ "Server", "SetCookie" ] "Options" []
                          )
                     )
             }
        )
        [ withSameSiteArg, withSameSiteArg0 ]


{-| Sets [`Expires`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie#expiresdate) to `Time.millisToPosix 0`,
which effectively tells the browser to delete the cookie immediately (by giving it an expiration date in the past).

withImmediateExpiration: Server.SetCookie.Options -> Server.SetCookie.Options
-}
withImmediateExpiration : Elm.Expression -> Elm.Expression
withImmediateExpiration withImmediateExpirationArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "SetCookie" ]
             , name = "withImmediateExpiration"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Server", "SetCookie" ]
                              "Options"
                              []
                          ]
                          (Type.namedWith [ "Server", "SetCookie" ] "Options" []
                          )
                     )
             }
        )
        [ withImmediateExpirationArg ]


{-| The default option in this API is for HttpOnly cookies <https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie#httponly>.

Cookies can be exposed so you can read them from JavaScript using `Document.cookie`. When this is intended and understood
then there's nothing unsafe about that (for example, if you are setting a `darkMode` cookie and what to access that
dynamically). In this API you opt into exposing a cookie you set to JavaScript to ensure cookies aren't exposed to JS unintentionally.

In general if you can accomplish your goal using HttpOnly cookies (i.e. not using `makeVisibleToJavaScript`) then
it's a good practice. With server-rendered `elm-pages` applications you can often manage your session state by pulling
in session data from cookies in a `BackendTask` (which is resolved server-side before it ever reaches the browser).

makeVisibleToJavaScript: Server.SetCookie.Options -> Server.SetCookie.Options
-}
makeVisibleToJavaScript : Elm.Expression -> Elm.Expression
makeVisibleToJavaScript makeVisibleToJavaScriptArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "SetCookie" ]
             , name = "makeVisibleToJavaScript"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Server", "SetCookie" ]
                              "Options"
                              []
                          ]
                          (Type.namedWith [ "Server", "SetCookie" ] "Options" []
                          )
                     )
             }
        )
        [ makeVisibleToJavaScriptArg ]


{-| Secure (only sent over https, or localhost on http) is the default. This overrides that and
removes the `Secure` attribute from the cookie.

nonSecure: Server.SetCookie.Options -> Server.SetCookie.Options
-}
nonSecure : Elm.Expression -> Elm.Expression
nonSecure nonSecureArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "SetCookie" ]
             , name = "nonSecure"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Server", "SetCookie" ]
                              "Options"
                              []
                          ]
                          (Type.namedWith [ "Server", "SetCookie" ] "Options" []
                          )
                     )
             }
        )
        [ nonSecureArg ]


{-| Sets the `Set-Cookie`'s [`Domain`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie#domaindomain-value).

withDomain: String -> Server.SetCookie.Options -> Server.SetCookie.Options
-}
withDomain : String -> Elm.Expression -> Elm.Expression
withDomain withDomainArg withDomainArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "SetCookie" ]
             , name = "withDomain"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Server", "SetCookie" ]
                              "Options"
                              []
                          ]
                          (Type.namedWith [ "Server", "SetCookie" ] "Options" []
                          )
                     )
             }
        )
        [ Elm.string withDomainArg, withDomainArg0 ]


{-| withExpiration: Time.Posix -> Server.SetCookie.Options -> Server.SetCookie.Options -}
withExpiration : Elm.Expression -> Elm.Expression -> Elm.Expression
withExpiration withExpirationArg withExpirationArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "SetCookie" ]
             , name = "withExpiration"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Time" ] "Posix" []
                          , Type.namedWith
                              [ "Server", "SetCookie" ]
                              "Options"
                              []
                          ]
                          (Type.namedWith [ "Server", "SetCookie" ] "Options" []
                          )
                     )
             }
        )
        [ withExpirationArg, withExpirationArg0 ]


{-| Sets the `Set-Cookie`'s [`Max-Age`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie#max-agenumber).

withMaxAge: Int -> Server.SetCookie.Options -> Server.SetCookie.Options
-}
withMaxAge : Int -> Elm.Expression -> Elm.Expression
withMaxAge withMaxAgeArg withMaxAgeArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "SetCookie" ]
             , name = "withMaxAge"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.namedWith
                              [ "Server", "SetCookie" ]
                              "Options"
                              []
                          ]
                          (Type.namedWith [ "Server", "SetCookie" ] "Options" []
                          )
                     )
             }
        )
        [ Elm.int withMaxAgeArg, withMaxAgeArg0 ]


{-| Sets the `Set-Cookie`'s [`Path`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Set-Cookie#pathpath-value).

The default value is `/`, which will match any sub-directories or the root directory. See also [\`withoutPath](#withoutPath)

withPath: String -> Server.SetCookie.Options -> Server.SetCookie.Options
-}
withPath : String -> Elm.Expression -> Elm.Expression
withPath withPathArg withPathArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "SetCookie" ]
             , name = "withPath"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Server", "SetCookie" ]
                              "Options"
                              []
                          ]
                          (Type.namedWith [ "Server", "SetCookie" ] "Options" []
                          )
                     )
             }
        )
        [ Elm.string withPathArg, withPathArg0 ]


{-| > If the server omits the Path attribute, the user agent will use the "directory" of the request-uri's path component as the default value.

Source: <https://www.rfc-editor.org/rfc/rfc6265>. See <https://stackoverflow.com/a/43336097>.

withoutPath: Server.SetCookie.Options -> Server.SetCookie.Options
-}
withoutPath : Elm.Expression -> Elm.Expression
withoutPath withoutPathArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "SetCookie" ]
             , name = "withoutPath"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Server", "SetCookie" ]
                              "Options"
                              []
                          ]
                          (Type.namedWith [ "Server", "SetCookie" ] "Options" []
                          )
                     )
             }
        )
        [ withoutPathArg ]


{-| Usually you'll want to use [`Server.Response.withSetCookieHeader`](Server-Response#withSetCookieHeader) instead.

This is a low-level helper that's there in case you want it but most users will never need this.

toString: Server.SetCookie.SetCookie -> String
-}
toString : Elm.Expression -> Elm.Expression
toString toStringArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "SetCookie" ]
             , name = "toString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Server", "SetCookie" ]
                              "SetCookie"
                              []
                          ]
                          Type.string
                     )
             }
        )
        [ toStringArg ]


annotation_ :
    { setCookie : Type.Annotation
    , options : Type.Annotation
    , sameSite : Type.Annotation
    }
annotation_ =
    { setCookie =
        Type.alias
            moduleName_
            "SetCookie"
            []
            (Type.record
                 [ ( "name", Type.string )
                 , ( "value", Type.string )
                 , ( "options"
                   , Type.namedWith [ "Server", "SetCookie" ] "Options" []
                   )
                 ]
            )
    , options =
        Type.alias
            moduleName_
            "Options"
            []
            (Type.record
                 [ ( "expiration"
                   , Type.maybe (Type.namedWith [ "Time" ] "Posix" [])
                   )
                 , ( "visibleToJavaScript", Type.bool )
                 , ( "maxAge", Type.maybe Type.int )
                 , ( "path", Type.maybe Type.string )
                 , ( "domain", Type.maybe Type.string )
                 , ( "secure", Type.bool )
                 , ( "sameSite"
                   , Type.maybe
                         (Type.namedWith [ "Server", "SetCookie" ] "SameSite" []
                         )
                   )
                 ]
            )
    , sameSite = Type.namedWith [ "Server", "SetCookie" ] "SameSite" []
    }


make_ :
    { setCookie :
        { name : Elm.Expression
        , value : Elm.Expression
        , options : Elm.Expression
        }
        -> Elm.Expression
    , options :
        { expiration : Elm.Expression
        , visibleToJavaScript : Elm.Expression
        , maxAge : Elm.Expression
        , path : Elm.Expression
        , domain : Elm.Expression
        , secure : Elm.Expression
        , sameSite : Elm.Expression
        }
        -> Elm.Expression
    , strict : Elm.Expression
    , lax : Elm.Expression
    , none : Elm.Expression
    }
make_ =
    { setCookie =
        \setCookie_args ->
            Elm.withType
                (Type.alias
                     [ "Server", "SetCookie" ]
                     "SetCookie"
                     []
                     (Type.record
                          [ ( "name", Type.string )
                          , ( "value", Type.string )
                          , ( "options"
                            , Type.namedWith
                                  [ "Server", "SetCookie" ]
                                  "Options"
                                  []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "name" setCookie_args.name
                     , Tuple.pair "value" setCookie_args.value
                     , Tuple.pair "options" setCookie_args.options
                     ]
                )
    , options =
        \options_args ->
            Elm.withType
                (Type.alias
                     [ "Server", "SetCookie" ]
                     "Options"
                     []
                     (Type.record
                          [ ( "expiration"
                            , Type.maybe (Type.namedWith [ "Time" ] "Posix" [])
                            )
                          , ( "visibleToJavaScript", Type.bool )
                          , ( "maxAge", Type.maybe Type.int )
                          , ( "path", Type.maybe Type.string )
                          , ( "domain", Type.maybe Type.string )
                          , ( "secure", Type.bool )
                          , ( "sameSite"
                            , Type.maybe
                                  (Type.namedWith
                                       [ "Server", "SetCookie" ]
                                       "SameSite"
                                       []
                                  )
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "expiration" options_args.expiration
                     , Tuple.pair
                         "visibleToJavaScript"
                         options_args.visibleToJavaScript
                     , Tuple.pair "maxAge" options_args.maxAge
                     , Tuple.pair "path" options_args.path
                     , Tuple.pair "domain" options_args.domain
                     , Tuple.pair "secure" options_args.secure
                     , Tuple.pair "sameSite" options_args.sameSite
                     ]
                )
    , strict =
        Elm.value
            { importFrom = [ "Server", "SetCookie" ]
            , name = "Strict"
            , annotation = Just (Type.namedWith [] "SameSite" [])
            }
    , lax =
        Elm.value
            { importFrom = [ "Server", "SetCookie" ]
            , name = "Lax"
            , annotation = Just (Type.namedWith [] "SameSite" [])
            }
    , none =
        Elm.value
            { importFrom = [ "Server", "SetCookie" ]
            , name = "None"
            , annotation = Just (Type.namedWith [] "SameSite" [])
            }
    }


caseOf_ :
    { sameSite :
        Elm.Expression
        -> { sameSiteTags_0_0
            | strict : Elm.Expression
            , lax : Elm.Expression
            , none : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { sameSite =
        \sameSiteExpression sameSiteTags ->
            Elm.Case.custom
                sameSiteExpression
                (Type.namedWith [ "Server", "SetCookie" ] "SameSite" [])
                [ Elm.Case.branch0 "Strict" sameSiteTags.strict
                , Elm.Case.branch0 "Lax" sameSiteTags.lax
                , Elm.Case.branch0 "None" sameSiteTags.none
                ]
    }


call_ :
    { setCookie :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , withSameSite : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withImmediateExpiration : Elm.Expression -> Elm.Expression
    , makeVisibleToJavaScript : Elm.Expression -> Elm.Expression
    , nonSecure : Elm.Expression -> Elm.Expression
    , withDomain : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withExpiration : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withMaxAge : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withPath : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withoutPath : Elm.Expression -> Elm.Expression
    , toString : Elm.Expression -> Elm.Expression
    }
call_ =
    { setCookie =
        \setCookieArg setCookieArg0 setCookieArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "SetCookie" ]
                     , name = "setCookie"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.string
                                  , Type.namedWith
                                      [ "Server", "SetCookie" ]
                                      "Options"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Server", "SetCookie" ]
                                       "SetCookie"
                                       []
                                  )
                             )
                     }
                )
                [ setCookieArg, setCookieArg0, setCookieArg1 ]
    , withSameSite =
        \withSameSiteArg withSameSiteArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "SetCookie" ]
                     , name = "withSameSite"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Server", "SetCookie" ]
                                      "SameSite"
                                      []
                                  , Type.namedWith
                                      [ "Server", "SetCookie" ]
                                      "Options"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Server", "SetCookie" ]
                                       "Options"
                                       []
                                  )
                             )
                     }
                )
                [ withSameSiteArg, withSameSiteArg0 ]
    , withImmediateExpiration =
        \withImmediateExpirationArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "SetCookie" ]
                     , name = "withImmediateExpiration"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Server", "SetCookie" ]
                                      "Options"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Server", "SetCookie" ]
                                       "Options"
                                       []
                                  )
                             )
                     }
                )
                [ withImmediateExpirationArg ]
    , makeVisibleToJavaScript =
        \makeVisibleToJavaScriptArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "SetCookie" ]
                     , name = "makeVisibleToJavaScript"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Server", "SetCookie" ]
                                      "Options"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Server", "SetCookie" ]
                                       "Options"
                                       []
                                  )
                             )
                     }
                )
                [ makeVisibleToJavaScriptArg ]
    , nonSecure =
        \nonSecureArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "SetCookie" ]
                     , name = "nonSecure"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Server", "SetCookie" ]
                                      "Options"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Server", "SetCookie" ]
                                       "Options"
                                       []
                                  )
                             )
                     }
                )
                [ nonSecureArg ]
    , withDomain =
        \withDomainArg withDomainArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "SetCookie" ]
                     , name = "withDomain"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Server", "SetCookie" ]
                                      "Options"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Server", "SetCookie" ]
                                       "Options"
                                       []
                                  )
                             )
                     }
                )
                [ withDomainArg, withDomainArg0 ]
    , withExpiration =
        \withExpirationArg withExpirationArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "SetCookie" ]
                     , name = "withExpiration"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Time" ] "Posix" []
                                  , Type.namedWith
                                      [ "Server", "SetCookie" ]
                                      "Options"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Server", "SetCookie" ]
                                       "Options"
                                       []
                                  )
                             )
                     }
                )
                [ withExpirationArg, withExpirationArg0 ]
    , withMaxAge =
        \withMaxAgeArg withMaxAgeArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "SetCookie" ]
                     , name = "withMaxAge"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.namedWith
                                      [ "Server", "SetCookie" ]
                                      "Options"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Server", "SetCookie" ]
                                       "Options"
                                       []
                                  )
                             )
                     }
                )
                [ withMaxAgeArg, withMaxAgeArg0 ]
    , withPath =
        \withPathArg withPathArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "SetCookie" ]
                     , name = "withPath"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Server", "SetCookie" ]
                                      "Options"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Server", "SetCookie" ]
                                       "Options"
                                       []
                                  )
                             )
                     }
                )
                [ withPathArg, withPathArg0 ]
    , withoutPath =
        \withoutPathArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "SetCookie" ]
                     , name = "withoutPath"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Server", "SetCookie" ]
                                      "Options"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Server", "SetCookie" ]
                                       "Options"
                                       []
                                  )
                             )
                     }
                )
                [ withoutPathArg ]
    , toString =
        \toStringArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "SetCookie" ]
                     , name = "toString"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Server", "SetCookie" ]
                                      "SetCookie"
                                      []
                                  ]
                                  Type.string
                             )
                     }
                )
                [ toStringArg ]
    }


values_ :
    { setCookie : Elm.Expression
    , options : Elm.Expression
    , withSameSite : Elm.Expression
    , withImmediateExpiration : Elm.Expression
    , makeVisibleToJavaScript : Elm.Expression
    , nonSecure : Elm.Expression
    , withDomain : Elm.Expression
    , withExpiration : Elm.Expression
    , withMaxAge : Elm.Expression
    , withPath : Elm.Expression
    , withoutPath : Elm.Expression
    , toString : Elm.Expression
    }
values_ =
    { setCookie =
        Elm.value
            { importFrom = [ "Server", "SetCookie" ]
            , name = "setCookie"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.string
                         , Type.namedWith [ "Server", "SetCookie" ] "Options" []
                         ]
                         (Type.namedWith
                              [ "Server", "SetCookie" ]
                              "SetCookie"
                              []
                         )
                    )
            }
    , options =
        Elm.value
            { importFrom = [ "Server", "SetCookie" ]
            , name = "options"
            , annotation =
                Just (Type.namedWith [ "Server", "SetCookie" ] "Options" [])
            }
    , withSameSite =
        Elm.value
            { importFrom = [ "Server", "SetCookie" ]
            , name = "withSameSite"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Server", "SetCookie" ]
                             "SameSite"
                             []
                         , Type.namedWith [ "Server", "SetCookie" ] "Options" []
                         ]
                         (Type.namedWith [ "Server", "SetCookie" ] "Options" [])
                    )
            }
    , withImmediateExpiration =
        Elm.value
            { importFrom = [ "Server", "SetCookie" ]
            , name = "withImmediateExpiration"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Server", "SetCookie" ] "Options" []
                         ]
                         (Type.namedWith [ "Server", "SetCookie" ] "Options" [])
                    )
            }
    , makeVisibleToJavaScript =
        Elm.value
            { importFrom = [ "Server", "SetCookie" ]
            , name = "makeVisibleToJavaScript"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Server", "SetCookie" ] "Options" []
                         ]
                         (Type.namedWith [ "Server", "SetCookie" ] "Options" [])
                    )
            }
    , nonSecure =
        Elm.value
            { importFrom = [ "Server", "SetCookie" ]
            , name = "nonSecure"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Server", "SetCookie" ] "Options" []
                         ]
                         (Type.namedWith [ "Server", "SetCookie" ] "Options" [])
                    )
            }
    , withDomain =
        Elm.value
            { importFrom = [ "Server", "SetCookie" ]
            , name = "withDomain"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Server", "SetCookie" ] "Options" []
                         ]
                         (Type.namedWith [ "Server", "SetCookie" ] "Options" [])
                    )
            }
    , withExpiration =
        Elm.value
            { importFrom = [ "Server", "SetCookie" ]
            , name = "withExpiration"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time" ] "Posix" []
                         , Type.namedWith [ "Server", "SetCookie" ] "Options" []
                         ]
                         (Type.namedWith [ "Server", "SetCookie" ] "Options" [])
                    )
            }
    , withMaxAge =
        Elm.value
            { importFrom = [ "Server", "SetCookie" ]
            , name = "withMaxAge"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.namedWith [ "Server", "SetCookie" ] "Options" []
                         ]
                         (Type.namedWith [ "Server", "SetCookie" ] "Options" [])
                    )
            }
    , withPath =
        Elm.value
            { importFrom = [ "Server", "SetCookie" ]
            , name = "withPath"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Server", "SetCookie" ] "Options" []
                         ]
                         (Type.namedWith [ "Server", "SetCookie" ] "Options" [])
                    )
            }
    , withoutPath =
        Elm.value
            { importFrom = [ "Server", "SetCookie" ]
            , name = "withoutPath"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Server", "SetCookie" ] "Options" []
                         ]
                         (Type.namedWith [ "Server", "SetCookie" ] "Options" [])
                    )
            }
    , toString =
        Elm.value
            { importFrom = [ "Server", "SetCookie" ]
            , name = "toString"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Server", "SetCookie" ]
                             "SetCookie"
                             []
                         ]
                         Type.string
                    )
            }
    }