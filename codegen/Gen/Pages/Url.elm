module Gen.Pages.Url exposing
    ( moduleName_, external, fromPath, toAbsoluteUrl, toString, annotation_
    , call_, values_
    )

{-|
# Generated bindings for Pages.Url

@docs moduleName_, external, fromPath, toAbsoluteUrl, toString, annotation_
@docs call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Url" ]


{-| external: String -> Pages.Url.Url -}
external : String -> Elm.Expression
external externalArg_ =
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
        [ Elm.string externalArg_ ]


{-| fromPath: UrlPath.UrlPath -> Pages.Url.Url -}
fromPath : Elm.Expression -> Elm.Expression
fromPath fromPathArg_ =
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
        [ fromPathArg_ ]


{-| toAbsoluteUrl: String -> Pages.Url.Url -> String -}
toAbsoluteUrl : String -> Elm.Expression -> Elm.Expression
toAbsoluteUrl toAbsoluteUrlArg_ toAbsoluteUrlArg_0 =
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
        [ Elm.string toAbsoluteUrlArg_, toAbsoluteUrlArg_0 ]


{-| toString: Pages.Url.Url -> String -}
toString : Elm.Expression -> Elm.Expression
toString toStringArg_ =
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
        [ toStringArg_ ]


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
        \externalArg_ ->
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
                [ externalArg_ ]
    , fromPath =
        \fromPathArg_ ->
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
                [ fromPathArg_ ]
    , toAbsoluteUrl =
        \toAbsoluteUrlArg_ toAbsoluteUrlArg_0 ->
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
                [ toAbsoluteUrlArg_, toAbsoluteUrlArg_0 ]
    , toString =
        \toStringArg_ ->
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
                [ toStringArg_ ]
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