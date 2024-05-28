module Gen.Pages.Url exposing (annotation_, call_, external, fromPath, moduleName_, toAbsoluteUrl, toString, values_)

{-| 
@docs moduleName_, external, fromPath, toAbsoluteUrl, toString, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Url" ]


{-| external: String -> Pages.Url.Url -}
external : String -> Elm.Expression
external externalArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Url" ]
             , name = "external"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith [ "Pages", "Url" ] "Url" [])
                     )
             }
        )
        [ Elm.string externalArg ]


{-| fromPath: UrlPath.UrlPath -> Pages.Url.Url -}
fromPath : Elm.Expression -> Elm.Expression
fromPath fromPathArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Url" ]
             , name = "fromPath"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "UrlPath" ] "UrlPath" [] ]
                          (Type.namedWith [ "Pages", "Url" ] "Url" [])
                     )
             }
        )
        [ fromPathArg ]


{-| toAbsoluteUrl: String -> Pages.Url.Url -> String -}
toAbsoluteUrl : String -> Elm.Expression -> Elm.Expression
toAbsoluteUrl toAbsoluteUrlArg toAbsoluteUrlArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Url" ]
             , name = "toAbsoluteUrl"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Pages", "Url" ] "Url" []
                          ]
                          Type.string
                     )
             }
        )
        [ Elm.string toAbsoluteUrlArg, toAbsoluteUrlArg0 ]


{-| toString: Pages.Url.Url -> String -}
toString : Elm.Expression -> Elm.Expression
toString toStringArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Url" ]
             , name = "toString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Pages", "Url" ] "Url" [] ]
                          Type.string
                     )
             }
        )
        [ toStringArg ]


annotation_ : { url : Type.Annotation }
annotation_ =
    { url = Type.namedWith [ "Pages", "Url" ] "Url" [] }


call_ :
    { external : Elm.Expression -> Elm.Expression
    , fromPath : Elm.Expression -> Elm.Expression
    , toAbsoluteUrl : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toString : Elm.Expression -> Elm.Expression
    }
call_ =
    { external =
        \externalArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Url" ]
                     , name = "external"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith [ "Pages", "Url" ] "Url" [])
                             )
                     }
                )
                [ externalArg ]
    , fromPath =
        \fromPathArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Url" ]
                     , name = "fromPath"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "UrlPath" ] "UrlPath" [] ]
                                  (Type.namedWith [ "Pages", "Url" ] "Url" [])
                             )
                     }
                )
                [ fromPathArg ]
    , toAbsoluteUrl =
        \toAbsoluteUrlArg toAbsoluteUrlArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Url" ]
                     , name = "toAbsoluteUrl"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith [ "Pages", "Url" ] "Url" []
                                  ]
                                  Type.string
                             )
                     }
                )
                [ toAbsoluteUrlArg, toAbsoluteUrlArg0 ]
    , toString =
        \toStringArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Url" ]
                     , name = "toString"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Pages", "Url" ] "Url" [] ]
                                  Type.string
                             )
                     }
                )
                [ toStringArg ]
    }


values_ :
    { external : Elm.Expression
    , fromPath : Elm.Expression
    , toAbsoluteUrl : Elm.Expression
    , toString : Elm.Expression
    }
values_ =
    { external =
        Elm.value
            { importFrom = [ "Pages", "Url" ]
            , name = "external"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith [ "Pages", "Url" ] "Url" [])
                    )
            }
    , fromPath =
        Elm.value
            { importFrom = [ "Pages", "Url" ]
            , name = "fromPath"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "UrlPath" ] "UrlPath" [] ]
                         (Type.namedWith [ "Pages", "Url" ] "Url" [])
                    )
            }
    , toAbsoluteUrl =
        Elm.value
            { importFrom = [ "Pages", "Url" ]
            , name = "toAbsoluteUrl"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Pages", "Url" ] "Url" []
                         ]
                         Type.string
                    )
            }
    , toString =
        Elm.value
            { importFrom = [ "Pages", "Url" ]
            , name = "toString"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Pages", "Url" ] "Url" [] ]
                         Type.string
                    )
            }
    }