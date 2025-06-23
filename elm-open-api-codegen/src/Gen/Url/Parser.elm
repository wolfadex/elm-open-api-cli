module Gen.Url.Parser exposing
    ( moduleName_, string, int, s, map, oneOf
    , top, custom, query, fragment, parse, annotation_, call_
    , values_
    )

{-|
# Generated bindings for Url.Parser

@docs moduleName_, string, int, s, map, oneOf
@docs top, custom, query, fragment, parse, annotation_
@docs call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Url", "Parser" ]


{-| Parse a segment of the path as a `String`.

    -- /alice/  ==>  Just "alice"
    -- /bob     ==>  Just "bob"
    -- /42/     ==>  Just "42"
    -- /        ==>  Nothing

string: Url.Parser.Parser (String -> a) a
-}
string : Elm.Expression
string =
    Elm.value
        { importFrom = [ "Url", "Parser" ]
        , name = "string"
        , annotation =
            Just
                (Type.namedWith
                     [ "Url", "Parser" ]
                     "Parser"
                     [ Type.function [ Type.string ] (Type.var "a")
                     , Type.var "a"
                     ]
                )
        }


{-| Parse a segment of the path as an `Int`.

    -- /alice/  ==>  Nothing
    -- /bob     ==>  Nothing
    -- /42/     ==>  Just 42
    -- /        ==>  Nothing

int: Url.Parser.Parser (Int -> a) a
-}
int : Elm.Expression
int =
    Elm.value
        { importFrom = [ "Url", "Parser" ]
        , name = "int"
        , annotation =
            Just
                (Type.namedWith
                     [ "Url", "Parser" ]
                     "Parser"
                     [ Type.function [ Type.int ] (Type.var "a"), Type.var "a" ]
                )
        }


{-| Parse a segment of the path if it matches a given string. It is almost
always used with [`</>`](#</>) or [`oneOf`](#oneOf). For example:

    blog : Parser (Int -> a) a
    blog =
      s "blog" </> int

    -- /blog/42  ==>  Just 42
    -- /tree/42  ==>  Nothing

The path segment must be an exact match!

s: String -> Url.Parser.Parser a a
-}
s : String -> Elm.Expression
s sArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser" ]
             , name = "s"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "Url", "Parser" ]
                               "Parser"
                               [ Type.var "a", Type.var "a" ]
                          )
                     )
             }
        )
        [ Elm.string sArg_ ]


{-| Transform a path parser.

    type alias Comment = { user : String, id : Int }

    userAndId : Parser (String -> Int -> a) a
    userAndId =
      s "user" </> string </> s "comment" </> int

    comment : Parser (Comment -> a) a
    comment =
      map Comment userAndId

    -- /user/bob/comment/42  ==>  Just { user = "bob", id = 42 }
    -- /user/tom/comment/35  ==>  Just { user = "tom", id = 35 }
    -- /user/sam/             ==>  Nothing

map: a -> Url.Parser.Parser a b -> Url.Parser.Parser (b -> c) c
-}
map : Elm.Expression -> Elm.Expression -> Elm.Expression
map mapArg_ mapArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser" ]
             , name = "map"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "a"
                          , Type.namedWith
                              [ "Url", "Parser" ]
                              "Parser"
                              [ Type.var "a", Type.var "b" ]
                          ]
                          (Type.namedWith
                               [ "Url", "Parser" ]
                               "Parser"
                               [ Type.function [ Type.var "b" ] (Type.var "c")
                               , Type.var "c"
                               ]
                          )
                     )
             }
        )
        [ mapArg_, mapArg_0 ]


{-| Try a bunch of different path parsers.

    type Route
      = Topic String
      | Blog Int
      | User String
      | Comment String Int

    route : Parser (Route -> a) a
    route =
      oneOf
        [ map Topic   (s "topic" </> string)
        , map Blog    (s "blog" </> int)
        , map User    (s "user" </> string)
        , map Comment (s "user" </> string </> s "comment" </> int)
        ]

    -- /topic/wolf           ==>  Just (Topic "wolf")
    -- /topic/               ==>  Nothing

    -- /blog/42               ==>  Just (Blog 42)
    -- /blog/wolf             ==>  Nothing

    -- /user/sam/             ==>  Just (User "sam")
    -- /user/bob/comment/42  ==>  Just (Comment "bob" 42)
    -- /user/tom/comment/35  ==>  Just (Comment "tom" 35)
    -- /user/                 ==>  Nothing

If there are multiple parsers that could succeed, the first one wins.

oneOf: List (Url.Parser.Parser a b) -> Url.Parser.Parser a b
-}
oneOf : List Elm.Expression -> Elm.Expression
oneOf oneOfArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser" ]
             , name = "oneOf"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "Url", "Parser" ]
                                 "Parser"
                                 [ Type.var "a", Type.var "b" ]
                              )
                          ]
                          (Type.namedWith
                               [ "Url", "Parser" ]
                               "Parser"
                               [ Type.var "a", Type.var "b" ]
                          )
                     )
             }
        )
        [ Elm.list oneOfArg_ ]


{-| A parser that does not consume any path segments.

    type Route = Overview | Post Int

    blog : Parser (BlogRoute -> a) a
    blog =
      s "blog" </>
        oneOf
          [ map Overview top
          , map Post (s "post" </> int)
          ]

    -- /blog/         ==>  Just Overview
    -- /blog/post/42  ==>  Just (Post 42)

top: Url.Parser.Parser a a
-}
top : Elm.Expression
top =
    Elm.value
        { importFrom = [ "Url", "Parser" ]
        , name = "top"
        , annotation =
            Just
                (Type.namedWith
                     [ "Url", "Parser" ]
                     "Parser"
                     [ Type.var "a", Type.var "a" ]
                )
        }


{-| Create a custom path segment parser. Here is how it is used to define the
`int` parser:

    int : Parser (Int -> a) a
    int =
      custom "NUMBER" String.toInt

You can use it to define something like “only CSS files” like this:

    css : Parser (String -> a) a
    css =
      custom "CSS_FILE" <| \segment ->
        if String.endsWith ".css" segment then
          Just segment
        else
          Nothing

custom: String -> (String -> Maybe a) -> Url.Parser.Parser (a -> b) b
-}
custom : String -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
custom customArg_ customArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser" ]
             , name = "custom"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.function
                              [ Type.string ]
                              (Type.maybe (Type.var "a"))
                          ]
                          (Type.namedWith
                               [ "Url", "Parser" ]
                               "Parser"
                               [ Type.function [ Type.var "a" ] (Type.var "b")
                               , Type.var "b"
                               ]
                          )
                     )
             }
        )
        [ Elm.string customArg_
        , Elm.functionReduced "customUnpack" customArg_0
        ]


{-| The [`Url.Parser.Query`](Url-Parser-Query) module defines its own
[`Parser`](Url-Parser-Query#Parser) type. This function is a helper to convert
those into normal parsers.

    import Url.Parser.Query as Query

    -- the following expressions are both the same!
    --
    -- s "blog" <?> Query.string "search"
    -- s "blog" </> query (Query.string "search")

This may be handy if you need query parameters but are not parsing any path
segments.

query: Url.Parser.Query.Parser query -> Url.Parser.Parser (query -> a) a
-}
query : Elm.Expression -> Elm.Expression
query queryArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser" ]
             , name = "query"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "query" ]
                          ]
                          (Type.namedWith
                               [ "Url", "Parser" ]
                               "Parser"
                               [ Type.function
                                   [ Type.var "query" ]
                                   (Type.var "a")
                               , Type.var "a"
                               ]
                          )
                     )
             }
        )
        [ queryArg_ ]


{-| Create a parser for the URL fragment, the stuff after the `#`. This can
be handy for handling links to DOM elements within a page. Pages like this one!

    type alias Docs =
      (String, Maybe String)

    docs : Parser (Docs -> a) a
    docs =
      map Tuple.pair (string </> fragment identity)

    -- /List/map   ==>  Nothing
    -- /List/#map  ==>  Just ("List", Just "map")
    -- /List#map   ==>  Just ("List", Just "map")
    -- /List#      ==>  Just ("List", Just "")
    -- /List       ==>  Just ("List", Nothing)
    -- /           ==>  Nothing

fragment: (Maybe String -> fragment) -> Url.Parser.Parser (fragment -> a) a
-}
fragment : (Elm.Expression -> Elm.Expression) -> Elm.Expression
fragment fragmentArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser" ]
             , name = "fragment"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.maybe Type.string ]
                              (Type.var "fragment")
                          ]
                          (Type.namedWith
                               [ "Url", "Parser" ]
                               "Parser"
                               [ Type.function
                                   [ Type.var "fragment" ]
                                   (Type.var "a")
                               , Type.var "a"
                               ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "fragmentUnpack" fragmentArg_ ]


{-| Actually run a parser! You provide some [`Url`](Url#Url) that
represent a valid URL. From there `parse` runs your parser on the path, query
parameters, and fragment.

    import Url
    import Url.Parser exposing (Parser, parse, int, map, oneOf, s, top)

    type Route = Home | Blog Int | NotFound

    route : Parser (Route -> a) a
    route =
      oneOf
        [ map Home top
        , map Blog (s "blog" </> int)
        ]

    toRoute : String -> Route
    toRoute string =
      case Url.fromString string of
        Nothing ->
          NotFound

        Just url ->
          Maybe.withDefault NotFound (parse route url)

    -- toRoute "/blog/42"                            ==  NotFound
    -- toRoute "https://example.com/"                ==  Home
    -- toRoute "https://example.com/blog"            ==  NotFound
    -- toRoute "https://example.com/blog/42"         ==  Blog 42
    -- toRoute "https://example.com/blog/42/"        ==  Blog 42
    -- toRoute "https://example.com/blog/42#wolf"    ==  Blog 42
    -- toRoute "https://example.com/blog/42?q=wolf"  ==  Blog 42
    -- toRoute "https://example.com/settings"        ==  NotFound

Functions like `toRoute` are useful when creating single-page apps with
[`Browser.fullscreen`][fs]. I use them in `init` and `onNavigation` to handle
the initial URL and any changes.

[fs]: /packages/elm/browser/latest/Browser#fullscreen

parse: Url.Parser.Parser (a -> a) a -> Url.Url -> Maybe a
-}
parse : Elm.Expression -> Elm.Expression -> Elm.Expression
parse parseArg_ parseArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser" ]
             , name = "parse"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Url", "Parser" ]
                              "Parser"
                              [ Type.function [ Type.var "a" ] (Type.var "a")
                              , Type.var "a"
                              ]
                          , Type.namedWith [ "Url" ] "Url" []
                          ]
                          (Type.maybe (Type.var "a"))
                     )
             }
        )
        [ parseArg_, parseArg_0 ]


annotation_ : { parser : Type.Annotation -> Type.Annotation -> Type.Annotation }
annotation_ =
    { parser =
        \parserArg0 parserArg1 ->
            Type.namedWith
                [ "Url", "Parser" ]
                "Parser"
                [ parserArg0, parserArg1 ]
    }


call_ :
    { s : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , oneOf : Elm.Expression -> Elm.Expression
    , custom : Elm.Expression -> Elm.Expression -> Elm.Expression
    , query : Elm.Expression -> Elm.Expression
    , fragment : Elm.Expression -> Elm.Expression
    , parse : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { s =
        \sArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser" ]
                     , name = "s"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Url", "Parser" ]
                                       "Parser"
                                       [ Type.var "a", Type.var "a" ]
                                  )
                             )
                     }
                )
                [ sArg_ ]
    , map =
        \mapArg_ mapArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser" ]
                     , name = "map"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "a"
                                  , Type.namedWith
                                      [ "Url", "Parser" ]
                                      "Parser"
                                      [ Type.var "a", Type.var "b" ]
                                  ]
                                  (Type.namedWith
                                       [ "Url", "Parser" ]
                                       "Parser"
                                       [ Type.function
                                           [ Type.var "b" ]
                                           (Type.var "c")
                                       , Type.var "c"
                                       ]
                                  )
                             )
                     }
                )
                [ mapArg_, mapArg_0 ]
    , oneOf =
        \oneOfArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser" ]
                     , name = "oneOf"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "Url", "Parser" ]
                                         "Parser"
                                         [ Type.var "a", Type.var "b" ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "Url", "Parser" ]
                                       "Parser"
                                       [ Type.var "a", Type.var "b" ]
                                  )
                             )
                     }
                )
                [ oneOfArg_ ]
    , custom =
        \customArg_ customArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser" ]
                     , name = "custom"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.function
                                      [ Type.string ]
                                      (Type.maybe (Type.var "a"))
                                  ]
                                  (Type.namedWith
                                       [ "Url", "Parser" ]
                                       "Parser"
                                       [ Type.function
                                           [ Type.var "a" ]
                                           (Type.var "b")
                                       , Type.var "b"
                                       ]
                                  )
                             )
                     }
                )
                [ customArg_, customArg_0 ]
    , query =
        \queryArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser" ]
                     , name = "query"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "query" ]
                                  ]
                                  (Type.namedWith
                                       [ "Url", "Parser" ]
                                       "Parser"
                                       [ Type.function
                                           [ Type.var "query" ]
                                           (Type.var "a")
                                       , Type.var "a"
                                       ]
                                  )
                             )
                     }
                )
                [ queryArg_ ]
    , fragment =
        \fragmentArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser" ]
                     , name = "fragment"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.maybe Type.string ]
                                      (Type.var "fragment")
                                  ]
                                  (Type.namedWith
                                       [ "Url", "Parser" ]
                                       "Parser"
                                       [ Type.function
                                           [ Type.var "fragment" ]
                                           (Type.var "a")
                                       , Type.var "a"
                                       ]
                                  )
                             )
                     }
                )
                [ fragmentArg_ ]
    , parse =
        \parseArg_ parseArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser" ]
                     , name = "parse"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Url", "Parser" ]
                                      "Parser"
                                      [ Type.function
                                            [ Type.var "a" ]
                                            (Type.var "a")
                                      , Type.var "a"
                                      ]
                                  , Type.namedWith [ "Url" ] "Url" []
                                  ]
                                  (Type.maybe (Type.var "a"))
                             )
                     }
                )
                [ parseArg_, parseArg_0 ]
    }


values_ :
    { string : Elm.Expression
    , int : Elm.Expression
    , s : Elm.Expression
    , map : Elm.Expression
    , oneOf : Elm.Expression
    , top : Elm.Expression
    , custom : Elm.Expression
    , query : Elm.Expression
    , fragment : Elm.Expression
    , parse : Elm.Expression
    }
values_ =
    { string =
        Elm.value
            { importFrom = [ "Url", "Parser" ]
            , name = "string"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Url", "Parser" ]
                         "Parser"
                         [ Type.function [ Type.string ] (Type.var "a")
                         , Type.var "a"
                         ]
                    )
            }
    , int =
        Elm.value
            { importFrom = [ "Url", "Parser" ]
            , name = "int"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Url", "Parser" ]
                         "Parser"
                         [ Type.function [ Type.int ] (Type.var "a")
                         , Type.var "a"
                         ]
                    )
            }
    , s =
        Elm.value
            { importFrom = [ "Url", "Parser" ]
            , name = "s"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "Url", "Parser" ]
                              "Parser"
                              [ Type.var "a", Type.var "a" ]
                         )
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "Url", "Parser" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "a"
                         , Type.namedWith
                             [ "Url", "Parser" ]
                             "Parser"
                             [ Type.var "a", Type.var "b" ]
                         ]
                         (Type.namedWith
                              [ "Url", "Parser" ]
                              "Parser"
                              [ Type.function [ Type.var "b" ] (Type.var "c")
                              , Type.var "c"
                              ]
                         )
                    )
            }
    , oneOf =
        Elm.value
            { importFrom = [ "Url", "Parser" ]
            , name = "oneOf"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "Url", "Parser" ]
                                "Parser"
                                [ Type.var "a", Type.var "b" ]
                             )
                         ]
                         (Type.namedWith
                              [ "Url", "Parser" ]
                              "Parser"
                              [ Type.var "a", Type.var "b" ]
                         )
                    )
            }
    , top =
        Elm.value
            { importFrom = [ "Url", "Parser" ]
            , name = "top"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Url", "Parser" ]
                         "Parser"
                         [ Type.var "a", Type.var "a" ]
                    )
            }
    , custom =
        Elm.value
            { importFrom = [ "Url", "Parser" ]
            , name = "custom"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.function
                             [ Type.string ]
                             (Type.maybe (Type.var "a"))
                         ]
                         (Type.namedWith
                              [ "Url", "Parser" ]
                              "Parser"
                              [ Type.function [ Type.var "a" ] (Type.var "b")
                              , Type.var "b"
                              ]
                         )
                    )
            }
    , query =
        Elm.value
            { importFrom = [ "Url", "Parser" ]
            , name = "query"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "query" ]
                         ]
                         (Type.namedWith
                              [ "Url", "Parser" ]
                              "Parser"
                              [ Type.function
                                  [ Type.var "query" ]
                                  (Type.var "a")
                              , Type.var "a"
                              ]
                         )
                    )
            }
    , fragment =
        Elm.value
            { importFrom = [ "Url", "Parser" ]
            , name = "fragment"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.maybe Type.string ]
                             (Type.var "fragment")
                         ]
                         (Type.namedWith
                              [ "Url", "Parser" ]
                              "Parser"
                              [ Type.function
                                  [ Type.var "fragment" ]
                                  (Type.var "a")
                              , Type.var "a"
                              ]
                         )
                    )
            }
    , parse =
        Elm.value
            { importFrom = [ "Url", "Parser" ]
            , name = "parse"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Url", "Parser" ]
                             "Parser"
                             [ Type.function [ Type.var "a" ] (Type.var "a")
                             , Type.var "a"
                             ]
                         , Type.namedWith [ "Url" ] "Url" []
                         ]
                         (Type.maybe (Type.var "a"))
                    )
            }
    }