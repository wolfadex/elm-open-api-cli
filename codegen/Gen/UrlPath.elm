module Gen.UrlPath exposing (annotation_, call_, fromString, join, moduleName_, toAbsolute, toRelative, toSegments, values_)

{-| 
@docs moduleName_, join, fromString, toAbsolute, toRelative, toSegments, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "UrlPath" ]


{-| Turn a Path to a relative URL.

join: UrlPath.UrlPath -> UrlPath.UrlPath
-}
join : Elm.Expression -> Elm.Expression
join joinArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "UrlPath" ]
             , name = "join"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "UrlPath" ] "UrlPath" [] ]
                          (Type.namedWith [ "UrlPath" ] "UrlPath" [])
                     )
             }
        )
        [ joinArg ]


{-| Create a UrlPath from a path String.

    UrlPath.fromString "blog/post-1/"
        |> UrlPath.toAbsolute
        |> Expect.equal "/blog/post-1"

fromString: String -> UrlPath.UrlPath
-}
fromString : String -> Elm.Expression
fromString fromStringArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "UrlPath" ]
             , name = "fromString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith [ "UrlPath" ] "UrlPath" [])
                     )
             }
        )
        [ Elm.string fromStringArg ]


{-| Turn a UrlPath to an absolute URL (with no trailing slash).

toAbsolute: UrlPath.UrlPath -> String
-}
toAbsolute : Elm.Expression -> Elm.Expression
toAbsolute toAbsoluteArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "UrlPath" ]
             , name = "toAbsolute"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "UrlPath" ] "UrlPath" [] ]
                          Type.string
                     )
             }
        )
        [ toAbsoluteArg ]


{-| Turn a UrlPath to a relative URL.

toRelative: UrlPath.UrlPath -> String
-}
toRelative : Elm.Expression -> Elm.Expression
toRelative toRelativeArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "UrlPath" ]
             , name = "toRelative"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "UrlPath" ] "UrlPath" [] ]
                          Type.string
                     )
             }
        )
        [ toRelativeArg ]


{-| toSegments: String -> List String -}
toSegments : String -> Elm.Expression
toSegments toSegmentsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "UrlPath" ]
             , name = "toSegments"
             , annotation =
                 Just (Type.function [ Type.string ] (Type.list Type.string))
             }
        )
        [ Elm.string toSegmentsArg ]


annotation_ : { urlPath : Type.Annotation }
annotation_ =
    { urlPath = Type.alias moduleName_ "UrlPath" [] (Type.list Type.string) }


call_ :
    { join : Elm.Expression -> Elm.Expression
    , fromString : Elm.Expression -> Elm.Expression
    , toAbsolute : Elm.Expression -> Elm.Expression
    , toRelative : Elm.Expression -> Elm.Expression
    , toSegments : Elm.Expression -> Elm.Expression
    }
call_ =
    { join =
        \joinArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "UrlPath" ]
                     , name = "join"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "UrlPath" ] "UrlPath" [] ]
                                  (Type.namedWith [ "UrlPath" ] "UrlPath" [])
                             )
                     }
                )
                [ joinArg ]
    , fromString =
        \fromStringArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "UrlPath" ]
                     , name = "fromString"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith [ "UrlPath" ] "UrlPath" [])
                             )
                     }
                )
                [ fromStringArg ]
    , toAbsolute =
        \toAbsoluteArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "UrlPath" ]
                     , name = "toAbsolute"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "UrlPath" ] "UrlPath" [] ]
                                  Type.string
                             )
                     }
                )
                [ toAbsoluteArg ]
    , toRelative =
        \toRelativeArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "UrlPath" ]
                     , name = "toRelative"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "UrlPath" ] "UrlPath" [] ]
                                  Type.string
                             )
                     }
                )
                [ toRelativeArg ]
    , toSegments =
        \toSegmentsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "UrlPath" ]
                     , name = "toSegments"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.list Type.string)
                             )
                     }
                )
                [ toSegmentsArg ]
    }


values_ :
    { join : Elm.Expression
    , fromString : Elm.Expression
    , toAbsolute : Elm.Expression
    , toRelative : Elm.Expression
    , toSegments : Elm.Expression
    }
values_ =
    { join =
        Elm.value
            { importFrom = [ "UrlPath" ]
            , name = "join"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "UrlPath" ] "UrlPath" [] ]
                         (Type.namedWith [ "UrlPath" ] "UrlPath" [])
                    )
            }
    , fromString =
        Elm.value
            { importFrom = [ "UrlPath" ]
            , name = "fromString"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith [ "UrlPath" ] "UrlPath" [])
                    )
            }
    , toAbsolute =
        Elm.value
            { importFrom = [ "UrlPath" ]
            , name = "toAbsolute"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "UrlPath" ] "UrlPath" [] ]
                         Type.string
                    )
            }
    , toRelative =
        Elm.value
            { importFrom = [ "UrlPath" ]
            , name = "toRelative"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "UrlPath" ] "UrlPath" [] ]
                         Type.string
                    )
            }
    , toSegments =
        Elm.value
            { importFrom = [ "UrlPath" ]
            , name = "toSegments"
            , annotation =
                Just (Type.function [ Type.string ] (Type.list Type.string))
            }
    }