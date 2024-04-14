module Gen.Url.Builder exposing (absolute, annotation_, call_, caseOf_, crossOrigin, custom, int, make_, moduleName_, relative, string, toQuery, values_)

{-| 
@docs moduleName_, absolute, relative, crossOrigin, custom, string, int, toQuery, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Url", "Builder" ]


{-| Create an absolute URL:

    absolute [] []
    -- "/"

    absolute [ "packages", "elm", "core" ] []
    -- "/packages/elm/core"

    absolute [ "blog", String.fromInt 42 ] []
    -- "/blog/42"

    absolute [ "products" ] [ string "search" "hat", int "page" 2 ]
    -- "/products?search=hat&page=2"

Notice that the URLs start with a slash!

absolute: List String -> List Url.Builder.QueryParameter -> String
-}
absolute : List String -> List Elm.Expression -> Elm.Expression
absolute absoluteArg absoluteArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Builder" ]
             , name = "absolute"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list Type.string
                          , Type.list
                              (Type.namedWith
                                 [ "Url", "Builder" ]
                                 "QueryParameter"
                                 []
                              )
                          ]
                          Type.string
                     )
             }
        )
        [ Elm.list (List.map Elm.string absoluteArg), Elm.list absoluteArg0 ]


{-| Create a relative URL:

    relative [] []
    -- ""

    relative [ "elm", "core" ] []
    -- "elm/core"

    relative [ "blog", String.fromInt 42 ] []
    -- "blog/42"

    relative [ "products" ] [ string "search" "hat", int "page" 2 ]
    -- "products?search=hat&page=2"

Notice that the URLs **do not** start with a slash!

relative: List String -> List Url.Builder.QueryParameter -> String
-}
relative : List String -> List Elm.Expression -> Elm.Expression
relative relativeArg relativeArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Builder" ]
             , name = "relative"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list Type.string
                          , Type.list
                              (Type.namedWith
                                 [ "Url", "Builder" ]
                                 "QueryParameter"
                                 []
                              )
                          ]
                          Type.string
                     )
             }
        )
        [ Elm.list (List.map Elm.string relativeArg), Elm.list relativeArg0 ]


{-| Create a cross-origin URL.

    crossOrigin "https://example.com" [ "products" ] []
    -- "https://example.com/products"

    crossOrigin "https://example.com" [] []
    -- "https://example.com/"

    crossOrigin
      "https://example.com:8042"
      [ "over", "there" ]
      [ string "name" "ferret" ]
    -- "https://example.com:8042/over/there?name=ferret"

**Note:** Cross-origin requests are slightly restricted for security.
For example, the [same-origin policy][sop] applies when sending HTTP requests,
so the appropriate `Access-Control-Allow-Origin` header must be enabled on the
*server* to get things working. Read more about the security rules [here][cors].

[sop]: https://developer.mozilla.org/en-US/docs/Web/Security/Same-origin_policy
[cors]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Access_control_CORS

crossOrigin: String -> List String -> List Url.Builder.QueryParameter -> String
-}
crossOrigin : String -> List String -> List Elm.Expression -> Elm.Expression
crossOrigin crossOriginArg crossOriginArg0 crossOriginArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Builder" ]
             , name = "crossOrigin"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.list Type.string
                          , Type.list
                              (Type.namedWith
                                 [ "Url", "Builder" ]
                                 "QueryParameter"
                                 []
                              )
                          ]
                          Type.string
                     )
             }
        )
        [ Elm.string crossOriginArg
        , Elm.list (List.map Elm.string crossOriginArg0)
        , Elm.list crossOriginArg1
        ]


{-| Create custom URLs that may have a hash on the end:

    custom Absolute
      [ "packages", "elm", "core", "latest", "String" ]
      []
      (Just "length")
    -- "/packages/elm/core/latest/String#length"

    custom Relative [ "there" ] [ string "name" "ferret" ] Nothing
    -- "there?name=ferret"

    custom
      (CrossOrigin "https://example.com:8042")
      [ "over", "there" ]
      [ string "name" "ferret" ]
      (Just "nose")
    -- "https://example.com:8042/over/there?name=ferret#nose"

custom: 
    Url.Builder.Root
    -> List String
    -> List Url.Builder.QueryParameter
    -> Maybe String
    -> String
-}
custom :
    Elm.Expression
    -> List String
    -> List Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
custom customArg customArg0 customArg1 customArg2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Builder" ]
             , name = "custom"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Url", "Builder" ] "Root" []
                          , Type.list Type.string
                          , Type.list
                              (Type.namedWith
                                 [ "Url", "Builder" ]
                                 "QueryParameter"
                                 []
                              )
                          , Type.maybe Type.string
                          ]
                          Type.string
                     )
             }
        )
        [ customArg
        , Elm.list (List.map Elm.string customArg0)
        , Elm.list customArg1
        , customArg2
        ]


{-| Create a percent-encoded query parameter.

    absolute ["products"] [ string "search" "hat" ]
    -- "/products?search=hat"

    absolute ["products"] [ string "search" "coffee table" ]
    -- "/products?search=coffee%20table"

string: String -> String -> Url.Builder.QueryParameter
-}
string : String -> String -> Elm.Expression
string stringArg stringArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Builder" ]
             , name = "string"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string, Type.string ]
                          (Type.namedWith
                               [ "Url", "Builder" ]
                               "QueryParameter"
                               []
                          )
                     )
             }
        )
        [ Elm.string stringArg, Elm.string stringArg0 ]


{-| Create a percent-encoded query parameter.

    absolute ["products"] [ string "search" "hat", int "page" 2 ]
    -- "/products?search=hat&page=2"

Writing `int key n` is the same as writing `string key (String.fromInt n)`.
So this is just a convenience function, making your code a bit shorter!

int: String -> Int -> Url.Builder.QueryParameter
-}
int : String -> Int -> Elm.Expression
int intArg intArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Builder" ]
             , name = "int"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string, Type.int ]
                          (Type.namedWith
                               [ "Url", "Builder" ]
                               "QueryParameter"
                               []
                          )
                     )
             }
        )
        [ Elm.string intArg, Elm.int intArg0 ]


{-| Convert a list of query parameters to a percent-encoded query. This
function is used by `absolute`, `relative`, etc.

    toQuery [ string "search" "hat" ]
    -- "?search=hat"

    toQuery [ string "search" "coffee table" ]
    -- "?search=coffee%20table"

    toQuery [ string "search" "hat", int "page" 2 ]
    -- "?search=hat&page=2"

    toQuery []
    -- ""

toQuery: List Url.Builder.QueryParameter -> String
-}
toQuery : List Elm.Expression -> Elm.Expression
toQuery toQueryArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Url", "Builder" ]
             , name = "toQuery"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "Url", "Builder" ]
                                 "QueryParameter"
                                 []
                              )
                          ]
                          Type.string
                     )
             }
        )
        [ Elm.list toQueryArg ]


annotation_ : { root : Type.Annotation, queryParameter : Type.Annotation }
annotation_ =
    { root = Type.namedWith [ "Url", "Builder" ] "Root" []
    , queryParameter = Type.namedWith [ "Url", "Builder" ] "QueryParameter" []
    }


make_ :
    { absolute : Elm.Expression
    , relative : Elm.Expression
    , crossOrigin : Elm.Expression -> Elm.Expression
    }
make_ =
    { absolute =
        Elm.value
            { importFrom = [ "Url", "Builder" ]
            , name = "Absolute"
            , annotation = Just (Type.namedWith [] "Root" [])
            }
    , relative =
        Elm.value
            { importFrom = [ "Url", "Builder" ]
            , name = "Relative"
            , annotation = Just (Type.namedWith [] "Root" [])
            }
    , crossOrigin =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Builder" ]
                     , name = "CrossOrigin"
                     , annotation = Just (Type.namedWith [] "Root" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { root :
        Elm.Expression
        -> { rootTags_0_0
            | absolute : Elm.Expression
            , relative : Elm.Expression
            , crossOrigin : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { root =
        \rootExpression rootTags ->
            Elm.Case.custom
                rootExpression
                (Type.namedWith [ "Url", "Builder" ] "Root" [])
                [ Elm.Case.branch0 "Absolute" rootTags.absolute
                , Elm.Case.branch0 "Relative" rootTags.relative
                , Elm.Case.branch1
                    "CrossOrigin"
                    ( "stringString", Type.string )
                    rootTags.crossOrigin
                ]
    }


call_ :
    { absolute : Elm.Expression -> Elm.Expression -> Elm.Expression
    , relative : Elm.Expression -> Elm.Expression -> Elm.Expression
    , crossOrigin :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , custom :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , string : Elm.Expression -> Elm.Expression -> Elm.Expression
    , int : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toQuery : Elm.Expression -> Elm.Expression
    }
call_ =
    { absolute =
        \absoluteArg absoluteArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Builder" ]
                     , name = "absolute"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list Type.string
                                  , Type.list
                                      (Type.namedWith
                                         [ "Url", "Builder" ]
                                         "QueryParameter"
                                         []
                                      )
                                  ]
                                  Type.string
                             )
                     }
                )
                [ absoluteArg, absoluteArg0 ]
    , relative =
        \relativeArg relativeArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Builder" ]
                     , name = "relative"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list Type.string
                                  , Type.list
                                      (Type.namedWith
                                         [ "Url", "Builder" ]
                                         "QueryParameter"
                                         []
                                      )
                                  ]
                                  Type.string
                             )
                     }
                )
                [ relativeArg, relativeArg0 ]
    , crossOrigin =
        \crossOriginArg crossOriginArg0 crossOriginArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Builder" ]
                     , name = "crossOrigin"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.list Type.string
                                  , Type.list
                                      (Type.namedWith
                                         [ "Url", "Builder" ]
                                         "QueryParameter"
                                         []
                                      )
                                  ]
                                  Type.string
                             )
                     }
                )
                [ crossOriginArg, crossOriginArg0, crossOriginArg1 ]
    , custom =
        \customArg customArg0 customArg1 customArg2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Builder" ]
                     , name = "custom"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Url", "Builder" ]
                                      "Root"
                                      []
                                  , Type.list Type.string
                                  , Type.list
                                      (Type.namedWith
                                         [ "Url", "Builder" ]
                                         "QueryParameter"
                                         []
                                      )
                                  , Type.maybe Type.string
                                  ]
                                  Type.string
                             )
                     }
                )
                [ customArg, customArg0, customArg1, customArg2 ]
    , string =
        \stringArg stringArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Builder" ]
                     , name = "string"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string, Type.string ]
                                  (Type.namedWith
                                       [ "Url", "Builder" ]
                                       "QueryParameter"
                                       []
                                  )
                             )
                     }
                )
                [ stringArg, stringArg0 ]
    , int =
        \intArg intArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Builder" ]
                     , name = "int"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string, Type.int ]
                                  (Type.namedWith
                                       [ "Url", "Builder" ]
                                       "QueryParameter"
                                       []
                                  )
                             )
                     }
                )
                [ intArg, intArg0 ]
    , toQuery =
        \toQueryArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Url", "Builder" ]
                     , name = "toQuery"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "Url", "Builder" ]
                                         "QueryParameter"
                                         []
                                      )
                                  ]
                                  Type.string
                             )
                     }
                )
                [ toQueryArg ]
    }


values_ :
    { absolute : Elm.Expression
    , relative : Elm.Expression
    , crossOrigin : Elm.Expression
    , custom : Elm.Expression
    , string : Elm.Expression
    , int : Elm.Expression
    , toQuery : Elm.Expression
    }
values_ =
    { absolute =
        Elm.value
            { importFrom = [ "Url", "Builder" ]
            , name = "absolute"
            , annotation =
                Just
                    (Type.function
                         [ Type.list Type.string
                         , Type.list
                             (Type.namedWith
                                [ "Url", "Builder" ]
                                "QueryParameter"
                                []
                             )
                         ]
                         Type.string
                    )
            }
    , relative =
        Elm.value
            { importFrom = [ "Url", "Builder" ]
            , name = "relative"
            , annotation =
                Just
                    (Type.function
                         [ Type.list Type.string
                         , Type.list
                             (Type.namedWith
                                [ "Url", "Builder" ]
                                "QueryParameter"
                                []
                             )
                         ]
                         Type.string
                    )
            }
    , crossOrigin =
        Elm.value
            { importFrom = [ "Url", "Builder" ]
            , name = "crossOrigin"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.list Type.string
                         , Type.list
                             (Type.namedWith
                                [ "Url", "Builder" ]
                                "QueryParameter"
                                []
                             )
                         ]
                         Type.string
                    )
            }
    , custom =
        Elm.value
            { importFrom = [ "Url", "Builder" ]
            , name = "custom"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Url", "Builder" ] "Root" []
                         , Type.list Type.string
                         , Type.list
                             (Type.namedWith
                                [ "Url", "Builder" ]
                                "QueryParameter"
                                []
                             )
                         , Type.maybe Type.string
                         ]
                         Type.string
                    )
            }
    , string =
        Elm.value
            { importFrom = [ "Url", "Builder" ]
            , name = "string"
            , annotation =
                Just
                    (Type.function
                         [ Type.string, Type.string ]
                         (Type.namedWith
                              [ "Url", "Builder" ]
                              "QueryParameter"
                              []
                         )
                    )
            }
    , int =
        Elm.value
            { importFrom = [ "Url", "Builder" ]
            , name = "int"
            , annotation =
                Just
                    (Type.function
                         [ Type.string, Type.int ]
                         (Type.namedWith
                              [ "Url", "Builder" ]
                              "QueryParameter"
                              []
                         )
                    )
            }
    , toQuery =
        Elm.value
            { importFrom = [ "Url", "Builder" ]
            , name = "toQuery"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "Url", "Builder" ]
                                "QueryParameter"
                                []
                             )
                         ]
                         Type.string
                    )
            }
    }