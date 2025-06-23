module Gen.Url.Parser.Query exposing
    ( moduleName_, string, int, enum, custom, map
    , map2, map3, map4, map5, map6, map7, map8
    , annotation_, call_, values_
    )

{-|
# Generated bindings for Url.Parser.Query

@docs moduleName_, string, int, enum, custom, map
@docs map2, map3, map4, map5, map6, map7
@docs map8, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Url", "Parser", "Query" ]


{-| Handle `String` parameters.

    search : Parser (Maybe String)
    search =
      string "search"

    -- ?search=cats             == Just "cats"
    -- ?search=42               == Just "42"
    -- ?branch=left             == Nothing
    -- ?search=cats&search=dogs == Nothing

Check out [`custom`](#custom) if you need to handle multiple `search`
parameters for some reason.

string: String -> Url.Parser.Query.Parser (Maybe String)
-}
string : String -> Elm.Expression
string stringArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser", "Query" ]
             , name = "string"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "Url", "Parser", "Query" ]
                               "Parser"
                               [ Type.maybe Type.string ]
                          )
                     )
             }
        )
        [ Elm.string stringArg_ ]


{-| Handle `Int` parameters. Maybe you want to show paginated search results:

    page : Parser (Maybe Int)
    page =
      int "page"

    -- ?page=2        == Just 2
    -- ?page=17       == Just 17
    -- ?page=two      == Nothing
    -- ?sort=date     == Nothing
    -- ?page=2&page=3 == Nothing

Check out [`custom`](#custom) if you need to handle multiple `page` parameters
or something like that.

int: String -> Url.Parser.Query.Parser (Maybe Int)
-}
int : String -> Elm.Expression
int intArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser", "Query" ]
             , name = "int"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "Url", "Parser", "Query" ]
                               "Parser"
                               [ Type.maybe Type.int ]
                          )
                     )
             }
        )
        [ Elm.string intArg_ ]


{-| Handle enumerated parameters. Maybe you want a true-or-false parameter:

    import Dict

    debug : Parser (Maybe Bool)
    debug =
      enum "debug" (Dict.fromList [ ("true", True), ("false", False) ])

    -- ?debug=true            == Just True
    -- ?debug=false           == Just False
    -- ?debug=1               == Nothing
    -- ?debug=0               == Nothing
    -- ?true=true             == Nothing
    -- ?debug=true&debug=true == Nothing

You could add `0` and `1` to the dictionary if you want to handle those as
well. You can also use [`map`](#map) to say `map (Result.withDefault False) debug`
to get a parser of type `Parser Bool` that swallows any errors and defaults to
`False`.

**Note:** Parameters like `?debug` with no `=` are not supported by this library.

enum: String -> Dict.Dict String a -> Url.Parser.Query.Parser (Maybe a)
-}
enum : String -> Elm.Expression -> Elm.Expression
enum enumArg_ enumArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser", "Query" ]
             , name = "enum"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Dict" ]
                              "Dict"
                              [ Type.string, Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "Url", "Parser", "Query" ]
                               "Parser"
                               [ Type.maybe (Type.var "a") ]
                          )
                     )
             }
        )
        [ Elm.string enumArg_, enumArg_0 ]


{-| Create a custom query parser. The [`string`](#string), [`int`](#int), and
[`enum`](#enum) parsers are defined using this function. It can help you handle
anything though!

Say you are unlucky enough to need to handle `?post=2&post=7` to show a couple
posts on screen at once. You could say:

    posts : Parser (Maybe (List Int))
    posts =
      custom "post" (List.maybeMap String.toInt)

    -- ?post=2        == [2]
    -- ?post=2&post=7 == [2, 7]
    -- ?post=2&post=x == [2]
    -- ?hats=2        == []

custom: String -> (List String -> a) -> Url.Parser.Query.Parser a
-}
custom : String -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
custom customArg_ customArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser", "Query" ]
             , name = "custom"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.function
                              [ Type.list Type.string ]
                              (Type.var "a")
                          ]
                          (Type.namedWith
                               [ "Url", "Parser", "Query" ]
                               "Parser"
                               [ Type.var "a" ]
                          )
                     )
             }
        )
        [ Elm.string customArg_
        , Elm.functionReduced "customUnpack" customArg_0
        ]


{-| Transform a parser in some way. Maybe you want your `page` query parser to
default to `1` if there is any problem?

    page : Parser Int
    page =
      map (Result.withDefault 1) (int "page")

map: (a -> b) -> Url.Parser.Query.Parser a -> Url.Parser.Query.Parser b
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg_ mapArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser", "Query" ]
             , name = "map"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function [ Type.var "a" ] (Type.var "b")
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "Url", "Parser", "Query" ]
                               "Parser"
                               [ Type.var "b" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapUnpack" mapArg_, mapArg_0 ]


{-| Combine two parsers. A query like `?search=hats&page=2` could be parsed
with something like this:

    type alias Query =
      { search : Maybe String
      , page : Maybe Int
      }

    query : Parser Query
    query =
      map2 Query (string "search") (int "page")

map2: 
    (a -> b -> result)
    -> Url.Parser.Query.Parser a
    -> Url.Parser.Query.Parser b
    -> Url.Parser.Query.Parser result
-}
map2 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map2 map2Arg_ map2Arg_0 map2Arg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser", "Query" ]
             , name = "map2"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a", Type.var "b" ]
                              (Type.var "result")
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "a" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "b" ]
                          ]
                          (Type.namedWith
                               [ "Url", "Parser", "Query" ]
                               "Parser"
                               [ Type.var "result" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map2Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced "unpack" (map2Arg_ functionReducedUnpack)
            )
        , map2Arg_0
        , map2Arg_1
        ]


{-| Combine three parsers. A query like `?search=hats&page=2&sort=ascending`
could be parsed with something like this:

    import Dict

    type alias Query =
      { search : Maybe String
      , page : Maybe Int
      , sort : Maybe Order
      }

    type Order = Ascending | Descending

    query : Parser Query
    query =
      map3 Query (string "search") (int "page") (enum "sort" order)

    order : Dict.Dict String Order
    order =
      Dict.fromList
        [ ( "ascending", Ascending )
        , ( "descending", Descending )
        ]

map3: 
    (a -> b -> c -> result)
    -> Url.Parser.Query.Parser a
    -> Url.Parser.Query.Parser b
    -> Url.Parser.Query.Parser c
    -> Url.Parser.Query.Parser result
-}
map3 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map3 map3Arg_ map3Arg_0 map3Arg_1 map3Arg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser", "Query" ]
             , name = "map3"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a", Type.var "b", Type.var "c" ]
                              (Type.var "result")
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "a" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "b" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "c" ]
                          ]
                          (Type.namedWith
                               [ "Url", "Parser", "Query" ]
                               "Parser"
                               [ Type.var "result" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map3Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            ((map3Arg_ functionReducedUnpack)
                                 functionReducedUnpack0
                            )
                   )
            )
        , map3Arg_0
        , map3Arg_1
        , map3Arg_2
        ]


{-| map4: 
    (a -> b -> c -> d -> result)
    -> Url.Parser.Query.Parser a
    -> Url.Parser.Query.Parser b
    -> Url.Parser.Query.Parser c
    -> Url.Parser.Query.Parser d
    -> Url.Parser.Query.Parser result
-}
map4 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map4 map4Arg_ map4Arg_0 map4Arg_1 map4Arg_2 map4Arg_3 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser", "Query" ]
             , name = "map4"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a"
                              , Type.var "b"
                              , Type.var "c"
                              , Type.var "d"
                              ]
                              (Type.var "result")
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "a" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "b" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "c" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "d" ]
                          ]
                          (Type.namedWith
                               [ "Url", "Parser", "Query" ]
                               "Parser"
                               [ Type.var "result" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map4Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (((map4Arg_ functionReducedUnpack)
                                           functionReducedUnpack0
                                      )
                                          functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                     )
                            )
                   )
            )
        , map4Arg_0
        , map4Arg_1
        , map4Arg_2
        , map4Arg_3
        ]


{-| map5: 
    (a -> b -> c -> d -> e -> result)
    -> Url.Parser.Query.Parser a
    -> Url.Parser.Query.Parser b
    -> Url.Parser.Query.Parser c
    -> Url.Parser.Query.Parser d
    -> Url.Parser.Query.Parser e
    -> Url.Parser.Query.Parser result
-}
map5 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map5 map5Arg_ map5Arg_0 map5Arg_1 map5Arg_2 map5Arg_3 map5Arg_4 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser", "Query" ]
             , name = "map5"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a"
                              , Type.var "b"
                              , Type.var "c"
                              , Type.var "d"
                              , Type.var "e"
                              ]
                              (Type.var "result")
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "a" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "b" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "c" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "d" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "e" ]
                          ]
                          (Type.namedWith
                               [ "Url", "Parser", "Query" ]
                               "Parser"
                               [ Type.var "result" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map5Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (\functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0 ->
                                          Elm.functionReduced
                                              "unpack"
                                              ((((map5Arg_ functionReducedUnpack
                                                 )
                                                     functionReducedUnpack0
                                                )
                                                    functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                               )
                                                   functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0
                                              )
                                     )
                            )
                   )
            )
        , map5Arg_0
        , map5Arg_1
        , map5Arg_2
        , map5Arg_3
        , map5Arg_4
        ]


{-| map6: 
    (a -> b -> c -> d -> e -> f -> result)
    -> Url.Parser.Query.Parser a
    -> Url.Parser.Query.Parser b
    -> Url.Parser.Query.Parser c
    -> Url.Parser.Query.Parser d
    -> Url.Parser.Query.Parser e
    -> Url.Parser.Query.Parser f
    -> Url.Parser.Query.Parser result
-}
map6 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map6 map6Arg_ map6Arg_0 map6Arg_1 map6Arg_2 map6Arg_3 map6Arg_4 map6Arg_5 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser", "Query" ]
             , name = "map6"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a"
                              , Type.var "b"
                              , Type.var "c"
                              , Type.var "d"
                              , Type.var "e"
                              , Type.var "f"
                              ]
                              (Type.var "result")
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "a" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "b" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "c" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "d" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "e" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "f" ]
                          ]
                          (Type.namedWith
                               [ "Url", "Parser", "Query" ]
                               "Parser"
                               [ Type.var "result" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map6Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (\functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0 ->
                                          Elm.functionReduced
                                              "unpack"
                                              (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                   Elm.functionReduced
                                                       "unpack"
                                                       (((((map6Arg_
                                                                functionReducedUnpack
                                                           )
                                                               functionReducedUnpack0
                                                          )
                                                              functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                                         )
                                                             functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0
                                                        )
                                                            functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                       )
                                              )
                                     )
                            )
                   )
            )
        , map6Arg_0
        , map6Arg_1
        , map6Arg_2
        , map6Arg_3
        , map6Arg_4
        , map6Arg_5
        ]


{-| map7: 
    (a -> b -> c -> d -> e -> f -> g -> result)
    -> Url.Parser.Query.Parser a
    -> Url.Parser.Query.Parser b
    -> Url.Parser.Query.Parser c
    -> Url.Parser.Query.Parser d
    -> Url.Parser.Query.Parser e
    -> Url.Parser.Query.Parser f
    -> Url.Parser.Query.Parser g
    -> Url.Parser.Query.Parser result
-}
map7 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map7 map7Arg_ map7Arg_0 map7Arg_1 map7Arg_2 map7Arg_3 map7Arg_4 map7Arg_5 map7Arg_6 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser", "Query" ]
             , name = "map7"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a"
                              , Type.var "b"
                              , Type.var "c"
                              , Type.var "d"
                              , Type.var "e"
                              , Type.var "f"
                              , Type.var "g"
                              ]
                              (Type.var "result")
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "a" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "b" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "c" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "d" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "e" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "f" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "g" ]
                          ]
                          (Type.namedWith
                               [ "Url", "Parser", "Query" ]
                               "Parser"
                               [ Type.var "result" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map7Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (\functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0 ->
                                          Elm.functionReduced
                                              "unpack"
                                              (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                   Elm.functionReduced
                                                       "unpack"
                                                       (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                            Elm.functionReduced
                                                                "unpack"
                                                                ((((((map7Arg_
                                                                          functionReducedUnpack
                                                                     )
                                                                         functionReducedUnpack0
                                                                    )
                                                                        functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                                                   )
                                                                       functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0
                                                                  )
                                                                      functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                 )
                                                                     functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                )
                                                       )
                                              )
                                     )
                            )
                   )
            )
        , map7Arg_0
        , map7Arg_1
        , map7Arg_2
        , map7Arg_3
        , map7Arg_4
        , map7Arg_5
        , map7Arg_6
        ]


{-| If you need higher than eight, you can define a function like this:

    apply : Parser a -> Parser (a -> b) -> Parser b
    apply argParser funcParser =
      map2 (<|) funcParser argParser

And then you can chain it to do as many of these as you would like:

    map func (string "search")
      |> apply (int "page")
      |> apply (int "per-page")

map8: 
    (a -> b -> c -> d -> e -> f -> g -> h -> result)
    -> Url.Parser.Query.Parser a
    -> Url.Parser.Query.Parser b
    -> Url.Parser.Query.Parser c
    -> Url.Parser.Query.Parser d
    -> Url.Parser.Query.Parser e
    -> Url.Parser.Query.Parser f
    -> Url.Parser.Query.Parser g
    -> Url.Parser.Query.Parser h
    -> Url.Parser.Query.Parser result
-}
map8 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map8 map8Arg_ map8Arg_0 map8Arg_1 map8Arg_2 map8Arg_3 map8Arg_4 map8Arg_5 map8Arg_6 map8Arg_7 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Parser", "Query" ]
             , name = "map8"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a"
                              , Type.var "b"
                              , Type.var "c"
                              , Type.var "d"
                              , Type.var "e"
                              , Type.var "f"
                              , Type.var "g"
                              , Type.var "h"
                              ]
                              (Type.var "result")
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "a" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "b" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "c" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "d" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "e" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "f" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "g" ]
                          , Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "h" ]
                          ]
                          (Type.namedWith
                               [ "Url", "Parser", "Query" ]
                               "Parser"
                               [ Type.var "result" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map8Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (\functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0 ->
                                          Elm.functionReduced
                                              "unpack"
                                              (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                   Elm.functionReduced
                                                       "unpack"
                                                       (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                            Elm.functionReduced
                                                                "unpack"
                                                                (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                                     Elm.functionReduced
                                                                         "unpack"
                                                                         (((((((map8Arg_
                                                                                    functionReducedUnpack
                                                                               )
                                                                                   functionReducedUnpack0
                                                                              )
                                                                                  functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                                                             )
                                                                                 functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0
                                                                            )
                                                                                functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                           )
                                                                               functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                          )
                                                                              functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                         )
                                                                )
                                                       )
                                              )
                                     )
                            )
                   )
            )
        , map8Arg_0
        , map8Arg_1
        , map8Arg_2
        , map8Arg_3
        , map8Arg_4
        , map8Arg_5
        , map8Arg_6
        , map8Arg_7
        ]


annotation_ : { parser : Type.Annotation -> Type.Annotation }
annotation_ =
    { parser =
        \parserArg0 ->
            Type.alias
                moduleName_
                "Parser"
                [ parserArg0 ]
                (Type.namedWith
                     [ "Url", "Parser", "Internal" ]
                     "QueryParser"
                     [ Type.var "a" ]
                )
    }


call_ :
    { string : Elm.Expression -> Elm.Expression
    , int : Elm.Expression -> Elm.Expression
    , enum : Elm.Expression -> Elm.Expression -> Elm.Expression
    , custom : Elm.Expression -> Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , map2 :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , map3 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map4 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map5 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map6 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map7 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map8 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    }
call_ =
    { string =
        \stringArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser", "Query" ]
                     , name = "string"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Url", "Parser", "Query" ]
                                       "Parser"
                                       [ Type.maybe Type.string ]
                                  )
                             )
                     }
                )
                [ stringArg_ ]
    , int =
        \intArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser", "Query" ]
                     , name = "int"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Url", "Parser", "Query" ]
                                       "Parser"
                                       [ Type.maybe Type.int ]
                                  )
                             )
                     }
                )
                [ intArg_ ]
    , enum =
        \enumArg_ enumArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser", "Query" ]
                     , name = "enum"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Dict" ]
                                      "Dict"
                                      [ Type.string, Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "Url", "Parser", "Query" ]
                                       "Parser"
                                       [ Type.maybe (Type.var "a") ]
                                  )
                             )
                     }
                )
                [ enumArg_, enumArg_0 ]
    , custom =
        \customArg_ customArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser", "Query" ]
                     , name = "custom"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.function
                                      [ Type.list Type.string ]
                                      (Type.var "a")
                                  ]
                                  (Type.namedWith
                                       [ "Url", "Parser", "Query" ]
                                       "Parser"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ customArg_, customArg_0 ]
    , map =
        \mapArg_ mapArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser", "Query" ]
                     , name = "map"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.var "b")
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "Url", "Parser", "Query" ]
                                       "Parser"
                                       [ Type.var "b" ]
                                  )
                             )
                     }
                )
                [ mapArg_, mapArg_0 ]
    , map2 =
        \map2Arg_ map2Arg_0 map2Arg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser", "Query" ]
                     , name = "map2"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a", Type.var "b" ]
                                      (Type.var "result")
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "a" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "b" ]
                                  ]
                                  (Type.namedWith
                                       [ "Url", "Parser", "Query" ]
                                       "Parser"
                                       [ Type.var "result" ]
                                  )
                             )
                     }
                )
                [ map2Arg_, map2Arg_0, map2Arg_1 ]
    , map3 =
        \map3Arg_ map3Arg_0 map3Arg_1 map3Arg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser", "Query" ]
                     , name = "map3"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a"
                                      , Type.var "b"
                                      , Type.var "c"
                                      ]
                                      (Type.var "result")
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "a" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "b" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "c" ]
                                  ]
                                  (Type.namedWith
                                       [ "Url", "Parser", "Query" ]
                                       "Parser"
                                       [ Type.var "result" ]
                                  )
                             )
                     }
                )
                [ map3Arg_, map3Arg_0, map3Arg_1, map3Arg_2 ]
    , map4 =
        \map4Arg_ map4Arg_0 map4Arg_1 map4Arg_2 map4Arg_3 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser", "Query" ]
                     , name = "map4"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a"
                                      , Type.var "b"
                                      , Type.var "c"
                                      , Type.var "d"
                                      ]
                                      (Type.var "result")
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "a" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "b" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "c" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "d" ]
                                  ]
                                  (Type.namedWith
                                       [ "Url", "Parser", "Query" ]
                                       "Parser"
                                       [ Type.var "result" ]
                                  )
                             )
                     }
                )
                [ map4Arg_, map4Arg_0, map4Arg_1, map4Arg_2, map4Arg_3 ]
    , map5 =
        \map5Arg_ map5Arg_0 map5Arg_1 map5Arg_2 map5Arg_3 map5Arg_4 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser", "Query" ]
                     , name = "map5"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a"
                                      , Type.var "b"
                                      , Type.var "c"
                                      , Type.var "d"
                                      , Type.var "e"
                                      ]
                                      (Type.var "result")
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "a" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "b" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "c" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "d" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "e" ]
                                  ]
                                  (Type.namedWith
                                       [ "Url", "Parser", "Query" ]
                                       "Parser"
                                       [ Type.var "result" ]
                                  )
                             )
                     }
                )
                [ map5Arg_
                , map5Arg_0
                , map5Arg_1
                , map5Arg_2
                , map5Arg_3
                , map5Arg_4
                ]
    , map6 =
        \map6Arg_ map6Arg_0 map6Arg_1 map6Arg_2 map6Arg_3 map6Arg_4 map6Arg_5 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser", "Query" ]
                     , name = "map6"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a"
                                      , Type.var "b"
                                      , Type.var "c"
                                      , Type.var "d"
                                      , Type.var "e"
                                      , Type.var "f"
                                      ]
                                      (Type.var "result")
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "a" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "b" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "c" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "d" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "e" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "f" ]
                                  ]
                                  (Type.namedWith
                                       [ "Url", "Parser", "Query" ]
                                       "Parser"
                                       [ Type.var "result" ]
                                  )
                             )
                     }
                )
                [ map6Arg_
                , map6Arg_0
                , map6Arg_1
                , map6Arg_2
                , map6Arg_3
                , map6Arg_4
                , map6Arg_5
                ]
    , map7 =
        \map7Arg_ map7Arg_0 map7Arg_1 map7Arg_2 map7Arg_3 map7Arg_4 map7Arg_5 map7Arg_6 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser", "Query" ]
                     , name = "map7"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a"
                                      , Type.var "b"
                                      , Type.var "c"
                                      , Type.var "d"
                                      , Type.var "e"
                                      , Type.var "f"
                                      , Type.var "g"
                                      ]
                                      (Type.var "result")
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "a" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "b" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "c" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "d" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "e" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "f" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "g" ]
                                  ]
                                  (Type.namedWith
                                       [ "Url", "Parser", "Query" ]
                                       "Parser"
                                       [ Type.var "result" ]
                                  )
                             )
                     }
                )
                [ map7Arg_
                , map7Arg_0
                , map7Arg_1
                , map7Arg_2
                , map7Arg_3
                , map7Arg_4
                , map7Arg_5
                , map7Arg_6
                ]
    , map8 =
        \map8Arg_ map8Arg_0 map8Arg_1 map8Arg_2 map8Arg_3 map8Arg_4 map8Arg_5 map8Arg_6 map8Arg_7 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Parser", "Query" ]
                     , name = "map8"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a"
                                      , Type.var "b"
                                      , Type.var "c"
                                      , Type.var "d"
                                      , Type.var "e"
                                      , Type.var "f"
                                      , Type.var "g"
                                      , Type.var "h"
                                      ]
                                      (Type.var "result")
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "a" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "b" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "c" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "d" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "e" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "f" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "g" ]
                                  , Type.namedWith
                                      [ "Url", "Parser", "Query" ]
                                      "Parser"
                                      [ Type.var "h" ]
                                  ]
                                  (Type.namedWith
                                       [ "Url", "Parser", "Query" ]
                                       "Parser"
                                       [ Type.var "result" ]
                                  )
                             )
                     }
                )
                [ map8Arg_
                , map8Arg_0
                , map8Arg_1
                , map8Arg_2
                , map8Arg_3
                , map8Arg_4
                , map8Arg_5
                , map8Arg_6
                , map8Arg_7
                ]
    }


values_ :
    { string : Elm.Expression
    , int : Elm.Expression
    , enum : Elm.Expression
    , custom : Elm.Expression
    , map : Elm.Expression
    , map2 : Elm.Expression
    , map3 : Elm.Expression
    , map4 : Elm.Expression
    , map5 : Elm.Expression
    , map6 : Elm.Expression
    , map7 : Elm.Expression
    , map8 : Elm.Expression
    }
values_ =
    { string =
        Elm.value
            { importFrom = [ "Url", "Parser", "Query" ]
            , name = "string"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.maybe Type.string ]
                         )
                    )
            }
    , int =
        Elm.value
            { importFrom = [ "Url", "Parser", "Query" ]
            , name = "int"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.maybe Type.int ]
                         )
                    )
            }
    , enum =
        Elm.value
            { importFrom = [ "Url", "Parser", "Query" ]
            , name = "enum"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "Dict" ]
                             "Dict"
                             [ Type.string, Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.maybe (Type.var "a") ]
                         )
                    )
            }
    , custom =
        Elm.value
            { importFrom = [ "Url", "Parser", "Query" ]
            , name = "custom"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.function
                             [ Type.list Type.string ]
                             (Type.var "a")
                         ]
                         (Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "a" ]
                         )
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "Url", "Parser", "Query" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.var "a" ] (Type.var "b")
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "b" ]
                         )
                    )
            }
    , map2 =
        Elm.value
            { importFrom = [ "Url", "Parser", "Query" ]
            , name = "map2"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a", Type.var "b" ]
                             (Type.var "result")
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "a" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "b" ]
                         ]
                         (Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "result" ]
                         )
                    )
            }
    , map3 =
        Elm.value
            { importFrom = [ "Url", "Parser", "Query" ]
            , name = "map3"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a", Type.var "b", Type.var "c" ]
                             (Type.var "result")
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "a" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "b" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "c" ]
                         ]
                         (Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "result" ]
                         )
                    )
            }
    , map4 =
        Elm.value
            { importFrom = [ "Url", "Parser", "Query" ]
            , name = "map4"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a"
                             , Type.var "b"
                             , Type.var "c"
                             , Type.var "d"
                             ]
                             (Type.var "result")
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "a" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "b" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "c" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "d" ]
                         ]
                         (Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "result" ]
                         )
                    )
            }
    , map5 =
        Elm.value
            { importFrom = [ "Url", "Parser", "Query" ]
            , name = "map5"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a"
                             , Type.var "b"
                             , Type.var "c"
                             , Type.var "d"
                             , Type.var "e"
                             ]
                             (Type.var "result")
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "a" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "b" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "c" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "d" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "e" ]
                         ]
                         (Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "result" ]
                         )
                    )
            }
    , map6 =
        Elm.value
            { importFrom = [ "Url", "Parser", "Query" ]
            , name = "map6"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a"
                             , Type.var "b"
                             , Type.var "c"
                             , Type.var "d"
                             , Type.var "e"
                             , Type.var "f"
                             ]
                             (Type.var "result")
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "a" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "b" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "c" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "d" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "e" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "f" ]
                         ]
                         (Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "result" ]
                         )
                    )
            }
    , map7 =
        Elm.value
            { importFrom = [ "Url", "Parser", "Query" ]
            , name = "map7"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a"
                             , Type.var "b"
                             , Type.var "c"
                             , Type.var "d"
                             , Type.var "e"
                             , Type.var "f"
                             , Type.var "g"
                             ]
                             (Type.var "result")
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "a" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "b" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "c" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "d" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "e" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "f" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "g" ]
                         ]
                         (Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "result" ]
                         )
                    )
            }
    , map8 =
        Elm.value
            { importFrom = [ "Url", "Parser", "Query" ]
            , name = "map8"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a"
                             , Type.var "b"
                             , Type.var "c"
                             , Type.var "d"
                             , Type.var "e"
                             , Type.var "f"
                             , Type.var "g"
                             , Type.var "h"
                             ]
                             (Type.var "result")
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "a" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "b" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "c" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "d" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "e" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "f" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "g" ]
                         , Type.namedWith
                             [ "Url", "Parser", "Query" ]
                             "Parser"
                             [ Type.var "h" ]
                         ]
                         (Type.namedWith
                              [ "Url", "Parser", "Query" ]
                              "Parser"
                              [ Type.var "result" ]
                         )
                    )
            }
    }