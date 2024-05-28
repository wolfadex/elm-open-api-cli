module Gen.Pages.Manifest.Category exposing (annotation_, books, business, call_, custom, education, entertainment, finance, fitness, food, games, government, health, kids, lifestyle, magazines, medical, moduleName_, music, navigation, news, personalization, photo, politics, productivity, security, shopping, social, sports, toString, travel, utilities, values_, weather)

{-| 
@docs moduleName_, toString, books, business, education, entertainment, finance, fitness, food, games, government, health, kids, lifestyle, magazines, medical, music, navigation, news, personalization, photo, politics, productivity, security, shopping, social, sports, travel, utilities, weather, custom, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Manifest", "Category" ]


{-| Turn a category into its official String representation, as seen
here: <https://github.com/w3c/manifest/wiki/Categories>.

toString: Pages.Manifest.Category.Category -> String
-}
toString : Elm.Expression -> Elm.Expression
toString toStringArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Manifest", "Category" ]
             , name = "toString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Manifest", "Category" ]
                              "Category"
                              []
                          ]
                          Type.string
                     )
             }
        )
        [ toStringArg ]


{-| Creates the described category.

books: Pages.Manifest.Category.Category
-}
books : Elm.Expression
books =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "books"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

business: Pages.Manifest.Category.Category
-}
business : Elm.Expression
business =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "business"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

education: Pages.Manifest.Category.Category
-}
education : Elm.Expression
education =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "education"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

entertainment: Pages.Manifest.Category.Category
-}
entertainment : Elm.Expression
entertainment =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "entertainment"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

finance: Pages.Manifest.Category.Category
-}
finance : Elm.Expression
finance =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "finance"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

fitness: Pages.Manifest.Category.Category
-}
fitness : Elm.Expression
fitness =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "fitness"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

food: Pages.Manifest.Category.Category
-}
food : Elm.Expression
food =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "food"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

games: Pages.Manifest.Category.Category
-}
games : Elm.Expression
games =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "games"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

government: Pages.Manifest.Category.Category
-}
government : Elm.Expression
government =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "government"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

health: Pages.Manifest.Category.Category
-}
health : Elm.Expression
health =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "health"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

kids: Pages.Manifest.Category.Category
-}
kids : Elm.Expression
kids =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "kids"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

lifestyle: Pages.Manifest.Category.Category
-}
lifestyle : Elm.Expression
lifestyle =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "lifestyle"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

magazines: Pages.Manifest.Category.Category
-}
magazines : Elm.Expression
magazines =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "magazines"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

medical: Pages.Manifest.Category.Category
-}
medical : Elm.Expression
medical =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "medical"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

music: Pages.Manifest.Category.Category
-}
music : Elm.Expression
music =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "music"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

navigation: Pages.Manifest.Category.Category
-}
navigation : Elm.Expression
navigation =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "navigation"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

news: Pages.Manifest.Category.Category
-}
news : Elm.Expression
news =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "news"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

personalization: Pages.Manifest.Category.Category
-}
personalization : Elm.Expression
personalization =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "personalization"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

photo: Pages.Manifest.Category.Category
-}
photo : Elm.Expression
photo =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "photo"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

politics: Pages.Manifest.Category.Category
-}
politics : Elm.Expression
politics =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "politics"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

productivity: Pages.Manifest.Category.Category
-}
productivity : Elm.Expression
productivity =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "productivity"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

security: Pages.Manifest.Category.Category
-}
security : Elm.Expression
security =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "security"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

shopping: Pages.Manifest.Category.Category
-}
shopping : Elm.Expression
shopping =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "shopping"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

social: Pages.Manifest.Category.Category
-}
social : Elm.Expression
social =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "social"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

sports: Pages.Manifest.Category.Category
-}
sports : Elm.Expression
sports =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "sports"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

travel: Pages.Manifest.Category.Category
-}
travel : Elm.Expression
travel =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "travel"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

utilities: Pages.Manifest.Category.Category
-}
utilities : Elm.Expression
utilities =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "utilities"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| Creates the described category.

weather: Pages.Manifest.Category.Category
-}
weather : Elm.Expression
weather =
    Elm.value
        { importFrom = [ "Pages", "Manifest", "Category" ]
        , name = "weather"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Manifest", "Category" ]
                     "Category"
                     []
                )
        }


{-| It's best to use the pre-defined categories to ensure that clients (Android, iOS,
Chrome, Windows app store, etc.) are aware of it and can handle it appropriately.
But, if you're confident about using a custom one, you can do so with `Pages.Manifest.custom`.

custom: String -> Pages.Manifest.Category.Category
-}
custom : String -> Elm.Expression
custom customArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Manifest", "Category" ]
             , name = "custom"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "Pages", "Manifest", "Category" ]
                               "Category"
                               []
                          )
                     )
             }
        )
        [ Elm.string customArg ]


annotation_ : { category : Type.Annotation }
annotation_ =
    { category =
        Type.namedWith [ "Pages", "Manifest", "Category" ] "Category" []
    }


call_ :
    { toString : Elm.Expression -> Elm.Expression
    , custom : Elm.Expression -> Elm.Expression
    }
call_ =
    { toString =
        \toStringArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Manifest", "Category" ]
                     , name = "toString"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Manifest", "Category" ]
                                      "Category"
                                      []
                                  ]
                                  Type.string
                             )
                     }
                )
                [ toStringArg ]
    , custom =
        \customArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Manifest", "Category" ]
                     , name = "custom"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Pages", "Manifest", "Category" ]
                                       "Category"
                                       []
                                  )
                             )
                     }
                )
                [ customArg ]
    }


values_ :
    { toString : Elm.Expression
    , books : Elm.Expression
    , business : Elm.Expression
    , education : Elm.Expression
    , entertainment : Elm.Expression
    , finance : Elm.Expression
    , fitness : Elm.Expression
    , food : Elm.Expression
    , games : Elm.Expression
    , government : Elm.Expression
    , health : Elm.Expression
    , kids : Elm.Expression
    , lifestyle : Elm.Expression
    , magazines : Elm.Expression
    , medical : Elm.Expression
    , music : Elm.Expression
    , navigation : Elm.Expression
    , news : Elm.Expression
    , personalization : Elm.Expression
    , photo : Elm.Expression
    , politics : Elm.Expression
    , productivity : Elm.Expression
    , security : Elm.Expression
    , shopping : Elm.Expression
    , social : Elm.Expression
    , sports : Elm.Expression
    , travel : Elm.Expression
    , utilities : Elm.Expression
    , weather : Elm.Expression
    , custom : Elm.Expression
    }
values_ =
    { toString =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "toString"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Manifest", "Category" ]
                             "Category"
                             []
                         ]
                         Type.string
                    )
            }
    , books =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "books"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , business =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "business"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , education =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "education"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , entertainment =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "entertainment"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , finance =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "finance"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , fitness =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "fitness"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , food =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "food"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , games =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "games"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , government =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "government"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , health =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "health"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , kids =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "kids"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , lifestyle =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "lifestyle"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , magazines =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "magazines"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , medical =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "medical"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , music =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "music"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , navigation =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "navigation"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , news =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "news"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , personalization =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "personalization"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , photo =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "photo"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , politics =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "politics"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , productivity =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "productivity"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , security =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "security"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , shopping =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "shopping"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , social =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "social"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , sports =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "sports"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , travel =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "travel"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , utilities =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "utilities"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , weather =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "weather"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Manifest", "Category" ]
                         "Category"
                         []
                    )
            }
    , custom =
        Elm.value
            { importFrom = [ "Pages", "Manifest", "Category" ]
            , name = "custom"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "Pages", "Manifest", "Category" ]
                              "Category"
                              []
                         )
                    )
            }
    }