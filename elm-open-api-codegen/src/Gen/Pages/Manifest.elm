module Gen.Pages.Manifest exposing
    ( moduleName_, init, withBackgroundColor, withCategories, withDisplayMode, withIarcRatingId
    , withLang, withOrientation, withShortName, withThemeColor, withField, generator, toJson
    , annotation_, make_, caseOf_, call_, values_
    )

{-|
# Generated bindings for Pages.Manifest

@docs moduleName_, init, withBackgroundColor, withCategories, withDisplayMode, withIarcRatingId
@docs withLang, withOrientation, withShortName, withThemeColor, withField, generator
@docs toJson, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Manifest" ]


{-| Setup a minimal Manifest.Config. You can then use the `with...` builder functions to set additional options.

init: 
    { description : String
    , name : String
    , startUrl : UrlPath.UrlPath
    , icons : List Pages.Manifest.Icon
    }
    -> Pages.Manifest.Config
-}
init :
    { description : String
    , name : String
    , startUrl : Elm.Expression
    , icons : List Elm.Expression
    }
    -> Elm.Expression
init initArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Manifest" ]
             , name = "init"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "description", Type.string )
                              , ( "name", Type.string )
                              , ( "startUrl"
                                , Type.namedWith [ "UrlPath" ] "UrlPath" []
                                )
                              , ( "icons"
                                , Type.list
                                    (Type.namedWith
                                       [ "Pages", "Manifest" ]
                                       "Icon"
                                       []
                                    )
                                )
                              ]
                          ]
                          (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "description" (Elm.string initArg_.description)
            , Tuple.pair "name" (Elm.string initArg_.name)
            , Tuple.pair "startUrl" initArg_.startUrl
            , Tuple.pair "icons" (Elm.list initArg_.icons)
            ]
        ]


{-| Set <https://developer.mozilla.org/en-US/docs/Web/Manifest/background_color>.

withBackgroundColor: Color.Color -> Pages.Manifest.Config -> Pages.Manifest.Config
-}
withBackgroundColor : Elm.Expression -> Elm.Expression -> Elm.Expression
withBackgroundColor withBackgroundColorArg_ withBackgroundColorArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Manifest" ]
             , name = "withBackgroundColor"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Color" ] "Color" []
                          , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                          ]
                          (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                     )
             }
        )
        [ withBackgroundColorArg_, withBackgroundColorArg_0 ]


{-| Set <https://developer.mozilla.org/en-US/docs/Web/Manifest/categories>.

withCategories: 
    List Pages.Manifest.Category.Category
    -> Pages.Manifest.Config
    -> Pages.Manifest.Config
-}
withCategories : List Elm.Expression -> Elm.Expression -> Elm.Expression
withCategories withCategoriesArg_ withCategoriesArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Manifest" ]
             , name = "withCategories"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "Pages", "Manifest", "Category" ]
                                 "Category"
                                 []
                              )
                          , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                          ]
                          (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                     )
             }
        )
        [ Elm.list withCategoriesArg_, withCategoriesArg_0 ]


{-| Set <https://developer.mozilla.org/en-US/docs/Web/Manifest/display>.

withDisplayMode: Pages.Manifest.DisplayMode -> Pages.Manifest.Config -> Pages.Manifest.Config
-}
withDisplayMode : Elm.Expression -> Elm.Expression -> Elm.Expression
withDisplayMode withDisplayModeArg_ withDisplayModeArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Manifest" ]
             , name = "withDisplayMode"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Manifest" ]
                              "DisplayMode"
                              []
                          , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                          ]
                          (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                     )
             }
        )
        [ withDisplayModeArg_, withDisplayModeArg_0 ]


{-| Set <https://developer.mozilla.org/en-US/docs/Web/Manifest/iarc_rating_id>.

withIarcRatingId: String -> Pages.Manifest.Config -> Pages.Manifest.Config
-}
withIarcRatingId : String -> Elm.Expression -> Elm.Expression
withIarcRatingId withIarcRatingIdArg_ withIarcRatingIdArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Manifest" ]
             , name = "withIarcRatingId"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                          ]
                          (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                     )
             }
        )
        [ Elm.string withIarcRatingIdArg_, withIarcRatingIdArg_0 ]


{-| Set <https://developer.mozilla.org/en-US/docs/Web/Manifest/lang>.

withLang: LanguageTag.LanguageTag -> Pages.Manifest.Config -> Pages.Manifest.Config
-}
withLang : Elm.Expression -> Elm.Expression -> Elm.Expression
withLang withLangArg_ withLangArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Manifest" ]
             , name = "withLang"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "LanguageTag" ] "LanguageTag" []
                          , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                          ]
                          (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                     )
             }
        )
        [ withLangArg_, withLangArg_0 ]


{-| Set <https://developer.mozilla.org/en-US/docs/Web/Manifest/orientation>.

withOrientation: Pages.Manifest.Orientation -> Pages.Manifest.Config -> Pages.Manifest.Config
-}
withOrientation : Elm.Expression -> Elm.Expression -> Elm.Expression
withOrientation withOrientationArg_ withOrientationArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Manifest" ]
             , name = "withOrientation"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Manifest" ]
                              "Orientation"
                              []
                          , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                          ]
                          (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                     )
             }
        )
        [ withOrientationArg_, withOrientationArg_0 ]


{-| Set <https://developer.mozilla.org/en-US/docs/Web/Manifest/short_name>.

withShortName: String -> Pages.Manifest.Config -> Pages.Manifest.Config
-}
withShortName : String -> Elm.Expression -> Elm.Expression
withShortName withShortNameArg_ withShortNameArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Manifest" ]
             , name = "withShortName"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                          ]
                          (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                     )
             }
        )
        [ Elm.string withShortNameArg_, withShortNameArg_0 ]


{-| Set <https://developer.mozilla.org/en-US/docs/Web/Manifest/theme_color>.

withThemeColor: Color.Color -> Pages.Manifest.Config -> Pages.Manifest.Config
-}
withThemeColor : Elm.Expression -> Elm.Expression -> Elm.Expression
withThemeColor withThemeColorArg_ withThemeColorArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Manifest" ]
             , name = "withThemeColor"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Color" ] "Color" []
                          , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                          ]
                          (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                     )
             }
        )
        [ withThemeColorArg_, withThemeColorArg_0 ]


{-| Escape hatch for specifying fields that aren't exposed through this module otherwise. The possible supported properties
in a manifest file can change over time, so see [MDN manifest.json docs](https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/manifest.json)
for a full listing of the current supported properties.

withField: String -> Json.Encode.Value -> Pages.Manifest.Config -> Pages.Manifest.Config
-}
withField : String -> Elm.Expression -> Elm.Expression -> Elm.Expression
withField withFieldArg_ withFieldArg_0 withFieldArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Manifest" ]
             , name = "withField"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Json", "Encode" ] "Value" []
                          , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                          ]
                          (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                     )
             }
        )
        [ Elm.string withFieldArg_, withFieldArg_0, withFieldArg_1 ]


{-| A generator for `Api.elm` to include a manifest.json. The String argument is the canonical URL of the site.

    module Api exposing (routes)

    import ApiRoute
    import Pages.Manifest

    routes :
        BackendTask FatalError (List Route)
        -> (Maybe { indent : Int, newLines : Bool } -> Html Never -> String)
        -> List (ApiRoute.ApiRoute ApiRoute.Response)
    routes getStaticRoutes htmlToString =
        [ Pages.Manifest.generator
            Site.canonicalUrl
            Manifest.config
        ]

generator: 
    String
    -> BackendTask.BackendTask FatalError.FatalError Pages.Manifest.Config
    -> ApiRoute.ApiRoute ApiRoute.Response
-}
generator : String -> Elm.Expression -> Elm.Expression
generator generatorArg_ generatorArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Manifest" ]
             , name = "generator"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.namedWith
                                    [ "Pages", "Manifest" ]
                                    "Config"
                                    []
                              ]
                          ]
                          (Type.namedWith
                               [ "ApiRoute" ]
                               "ApiRoute"
                               [ Type.namedWith [ "ApiRoute" ] "Response" [] ]
                          )
                     )
             }
        )
        [ Elm.string generatorArg_, generatorArg_0 ]


{-| Feel free to use this, but in 99% of cases you won't need it. The generated
code will run this for you to generate your `manifest.json` file automatically!

toJson: String -> Pages.Manifest.Config -> Json.Encode.Value
-}
toJson : String -> Elm.Expression -> Elm.Expression
toJson toJsonArg_ toJsonArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Manifest" ]
             , name = "toJson"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                          ]
                          (Type.namedWith [ "Json", "Encode" ] "Value" [])
                     )
             }
        )
        [ Elm.string toJsonArg_, toJsonArg_0 ]


annotation_ :
    { config : Type.Annotation
    , icon : Type.Annotation
    , displayMode : Type.Annotation
    , orientation : Type.Annotation
    , iconPurpose : Type.Annotation
    }
annotation_ =
    { config =
        Type.alias
            moduleName_
            "Config"
            []
            (Type.record
                 [ ( "backgroundColor"
                   , Type.maybe (Type.namedWith [ "Color" ] "Color" [])
                   )
                 , ( "categories"
                   , Type.list
                         (Type.namedWith
                              [ "Pages", "Manifest", "Category" ]
                              "Category"
                              []
                         )
                   )
                 , ( "displayMode"
                   , Type.namedWith [ "Pages", "Manifest" ] "DisplayMode" []
                   )
                 , ( "orientation"
                   , Type.namedWith [ "Pages", "Manifest" ] "Orientation" []
                   )
                 , ( "description", Type.string )
                 , ( "iarcRatingId", Type.maybe Type.string )
                 , ( "name", Type.string )
                 , ( "themeColor"
                   , Type.maybe (Type.namedWith [ "Color" ] "Color" [])
                   )
                 , ( "startUrl", Type.namedWith [ "UrlPath" ] "UrlPath" [] )
                 , ( "shortName", Type.maybe Type.string )
                 , ( "icons"
                   , Type.list
                         (Type.namedWith [ "Pages", "Manifest" ] "Icon" [])
                   )
                 , ( "lang", Type.namedWith [ "LanguageTag" ] "LanguageTag" [] )
                 , ( "otherFields"
                   , Type.namedWith
                         [ "Dict" ]
                         "Dict"
                         [ Type.string
                         , Type.namedWith [ "Json", "Encode" ] "Value" []
                         ]
                   )
                 ]
            )
    , icon =
        Type.alias
            moduleName_
            "Icon"
            []
            (Type.record
                 [ ( "src", Type.namedWith [ "Pages", "Url" ] "Url" [] )
                 , ( "sizes", Type.list (Type.tuple Type.int Type.int) )
                 , ( "mimeType"
                   , Type.maybe (Type.namedWith [ "MimeType" ] "MimeImage" [])
                   )
                 , ( "purposes"
                   , Type.list
                         (Type.namedWith
                              [ "Pages", "Manifest" ]
                              "IconPurpose"
                              []
                         )
                   )
                 ]
            )
    , displayMode = Type.namedWith [ "Pages", "Manifest" ] "DisplayMode" []
    , orientation = Type.namedWith [ "Pages", "Manifest" ] "Orientation" []
    , iconPurpose = Type.namedWith [ "Pages", "Manifest" ] "IconPurpose" []
    }


make_ :
    { config :
        { backgroundColor : Elm.Expression
        , categories : Elm.Expression
        , displayMode : Elm.Expression
        , orientation : Elm.Expression
        , description : Elm.Expression
        , iarcRatingId : Elm.Expression
        , name : Elm.Expression
        , themeColor : Elm.Expression
        , startUrl : Elm.Expression
        , shortName : Elm.Expression
        , icons : Elm.Expression
        , lang : Elm.Expression
        , otherFields : Elm.Expression
        }
        -> Elm.Expression
    , icon :
        { src : Elm.Expression
        , sizes : Elm.Expression
        , mimeType : Elm.Expression
        , purposes : Elm.Expression
        }
        -> Elm.Expression
    , fullscreen : Elm.Expression
    , standalone : Elm.Expression
    , minimalUi : Elm.Expression
    , browser : Elm.Expression
    , any : Elm.Expression
    , natural : Elm.Expression
    , landscape : Elm.Expression
    , landscapePrimary : Elm.Expression
    , landscapeSecondary : Elm.Expression
    , portrait : Elm.Expression
    , portraitPrimary : Elm.Expression
    , portraitSecondary : Elm.Expression
    , iconPurposeMonochrome : Elm.Expression
    , iconPurposeMaskable : Elm.Expression
    , iconPurposeAny : Elm.Expression
    }
make_ =
    { config =
        \config_args ->
            Elm.withType
                (Type.alias
                     [ "Pages", "Manifest" ]
                     "Config"
                     []
                     (Type.record
                          [ ( "backgroundColor"
                            , Type.maybe (Type.namedWith [ "Color" ] "Color" [])
                            )
                          , ( "categories"
                            , Type.list
                                  (Type.namedWith
                                       [ "Pages", "Manifest", "Category" ]
                                       "Category"
                                       []
                                  )
                            )
                          , ( "displayMode"
                            , Type.namedWith
                                  [ "Pages", "Manifest" ]
                                  "DisplayMode"
                                  []
                            )
                          , ( "orientation"
                            , Type.namedWith
                                  [ "Pages", "Manifest" ]
                                  "Orientation"
                                  []
                            )
                          , ( "description", Type.string )
                          , ( "iarcRatingId", Type.maybe Type.string )
                          , ( "name", Type.string )
                          , ( "themeColor"
                            , Type.maybe (Type.namedWith [ "Color" ] "Color" [])
                            )
                          , ( "startUrl"
                            , Type.namedWith [ "UrlPath" ] "UrlPath" []
                            )
                          , ( "shortName", Type.maybe Type.string )
                          , ( "icons"
                            , Type.list
                                  (Type.namedWith
                                       [ "Pages", "Manifest" ]
                                       "Icon"
                                       []
                                  )
                            )
                          , ( "lang"
                            , Type.namedWith [ "LanguageTag" ] "LanguageTag" []
                            )
                          , ( "otherFields"
                            , Type.namedWith
                                  [ "Dict" ]
                                  "Dict"
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Json", "Encode" ]
                                      "Value"
                                      []
                                  ]
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "backgroundColor" config_args.backgroundColor
                     , Tuple.pair "categories" config_args.categories
                     , Tuple.pair "displayMode" config_args.displayMode
                     , Tuple.pair "orientation" config_args.orientation
                     , Tuple.pair "description" config_args.description
                     , Tuple.pair "iarcRatingId" config_args.iarcRatingId
                     , Tuple.pair "name" config_args.name
                     , Tuple.pair "themeColor" config_args.themeColor
                     , Tuple.pair "startUrl" config_args.startUrl
                     , Tuple.pair "shortName" config_args.shortName
                     , Tuple.pair "icons" config_args.icons
                     , Tuple.pair "lang" config_args.lang
                     , Tuple.pair "otherFields" config_args.otherFields
                     ]
                )
    , icon =
        \icon_args ->
            Elm.withType
                (Type.alias
                     [ "Pages", "Manifest" ]
                     "Icon"
                     []
                     (Type.record
                          [ ( "src"
                            , Type.namedWith [ "Pages", "Url" ] "Url" []
                            )
                          , ( "sizes"
                            , Type.list (Type.tuple Type.int Type.int)
                            )
                          , ( "mimeType"
                            , Type.maybe
                                  (Type.namedWith [ "MimeType" ] "MimeImage" [])
                            )
                          , ( "purposes"
                            , Type.list
                                  (Type.namedWith
                                       [ "Pages", "Manifest" ]
                                       "IconPurpose"
                                       []
                                  )
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "src" icon_args.src
                     , Tuple.pair "sizes" icon_args.sizes
                     , Tuple.pair "mimeType" icon_args.mimeType
                     , Tuple.pair "purposes" icon_args.purposes
                     ]
                )
    , fullscreen =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "Fullscreen"
            , annotation = Just (Type.namedWith [] "DisplayMode" [])
            }
    , standalone =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "Standalone"
            , annotation = Just (Type.namedWith [] "DisplayMode" [])
            }
    , minimalUi =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "MinimalUi"
            , annotation = Just (Type.namedWith [] "DisplayMode" [])
            }
    , browser =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "Browser"
            , annotation = Just (Type.namedWith [] "DisplayMode" [])
            }
    , any =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "Any"
            , annotation = Just (Type.namedWith [] "Orientation" [])
            }
    , natural =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "Natural"
            , annotation = Just (Type.namedWith [] "Orientation" [])
            }
    , landscape =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "Landscape"
            , annotation = Just (Type.namedWith [] "Orientation" [])
            }
    , landscapePrimary =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "LandscapePrimary"
            , annotation = Just (Type.namedWith [] "Orientation" [])
            }
    , landscapeSecondary =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "LandscapeSecondary"
            , annotation = Just (Type.namedWith [] "Orientation" [])
            }
    , portrait =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "Portrait"
            , annotation = Just (Type.namedWith [] "Orientation" [])
            }
    , portraitPrimary =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "PortraitPrimary"
            , annotation = Just (Type.namedWith [] "Orientation" [])
            }
    , portraitSecondary =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "PortraitSecondary"
            , annotation = Just (Type.namedWith [] "Orientation" [])
            }
    , iconPurposeMonochrome =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "IconPurposeMonochrome"
            , annotation = Just (Type.namedWith [] "IconPurpose" [])
            }
    , iconPurposeMaskable =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "IconPurposeMaskable"
            , annotation = Just (Type.namedWith [] "IconPurpose" [])
            }
    , iconPurposeAny =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "IconPurposeAny"
            , annotation = Just (Type.namedWith [] "IconPurpose" [])
            }
    }


caseOf_ :
    { displayMode :
        Elm.Expression
        -> { fullscreen : Elm.Expression
        , standalone : Elm.Expression
        , minimalUi : Elm.Expression
        , browser : Elm.Expression
        }
        -> Elm.Expression
    , orientation :
        Elm.Expression
        -> { any : Elm.Expression
        , natural : Elm.Expression
        , landscape : Elm.Expression
        , landscapePrimary : Elm.Expression
        , landscapeSecondary : Elm.Expression
        , portrait : Elm.Expression
        , portraitPrimary : Elm.Expression
        , portraitSecondary : Elm.Expression
        }
        -> Elm.Expression
    , iconPurpose :
        Elm.Expression
        -> { iconPurposeMonochrome : Elm.Expression
        , iconPurposeMaskable : Elm.Expression
        , iconPurposeAny : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { displayMode =
        \displayModeExpression displayModeTags ->
            Elm.Case.custom
                displayModeExpression
                (Type.namedWith [ "Pages", "Manifest" ] "DisplayMode" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType "Fullscreen" displayModeTags.fullscreen)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Standalone" displayModeTags.standalone)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "MinimalUi" displayModeTags.minimalUi)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Browser" displayModeTags.browser)
                    Basics.identity
                ]
    , orientation =
        \orientationExpression orientationTags ->
            Elm.Case.custom
                orientationExpression
                (Type.namedWith [ "Pages", "Manifest" ] "Orientation" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType "Any" orientationTags.any)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Natural" orientationTags.natural)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Landscape" orientationTags.landscape)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "LandscapePrimary"
                       orientationTags.landscapePrimary
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "LandscapeSecondary"
                       orientationTags.landscapeSecondary
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Portrait" orientationTags.portrait)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "PortraitPrimary"
                       orientationTags.portraitPrimary
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "PortraitSecondary"
                       orientationTags.portraitSecondary
                    )
                    Basics.identity
                ]
    , iconPurpose =
        \iconPurposeExpression iconPurposeTags ->
            Elm.Case.custom
                iconPurposeExpression
                (Type.namedWith [ "Pages", "Manifest" ] "IconPurpose" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "IconPurposeMonochrome"
                       iconPurposeTags.iconPurposeMonochrome
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "IconPurposeMaskable"
                       iconPurposeTags.iconPurposeMaskable
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "IconPurposeAny"
                       iconPurposeTags.iconPurposeAny
                    )
                    Basics.identity
                ]
    }


call_ :
    { init : Elm.Expression -> Elm.Expression
    , withBackgroundColor : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withCategories : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withDisplayMode : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withIarcRatingId : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withLang : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withOrientation : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withShortName : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withThemeColor : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withField :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , generator : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toJson : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { init =
        \initArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Manifest" ]
                     , name = "init"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "description", Type.string )
                                      , ( "name", Type.string )
                                      , ( "startUrl"
                                        , Type.namedWith
                                            [ "UrlPath" ]
                                            "UrlPath"
                                            []
                                        )
                                      , ( "icons"
                                        , Type.list
                                            (Type.namedWith
                                               [ "Pages", "Manifest" ]
                                               "Icon"
                                               []
                                            )
                                        )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Manifest" ]
                                       "Config"
                                       []
                                  )
                             )
                     }
                )
                [ initArg_ ]
    , withBackgroundColor =
        \withBackgroundColorArg_ withBackgroundColorArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Manifest" ]
                     , name = "withBackgroundColor"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Color" ] "Color" []
                                  , Type.namedWith
                                      [ "Pages", "Manifest" ]
                                      "Config"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Manifest" ]
                                       "Config"
                                       []
                                  )
                             )
                     }
                )
                [ withBackgroundColorArg_, withBackgroundColorArg_0 ]
    , withCategories =
        \withCategoriesArg_ withCategoriesArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Manifest" ]
                     , name = "withCategories"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "Pages", "Manifest", "Category" ]
                                         "Category"
                                         []
                                      )
                                  , Type.namedWith
                                      [ "Pages", "Manifest" ]
                                      "Config"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Manifest" ]
                                       "Config"
                                       []
                                  )
                             )
                     }
                )
                [ withCategoriesArg_, withCategoriesArg_0 ]
    , withDisplayMode =
        \withDisplayModeArg_ withDisplayModeArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Manifest" ]
                     , name = "withDisplayMode"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Manifest" ]
                                      "DisplayMode"
                                      []
                                  , Type.namedWith
                                      [ "Pages", "Manifest" ]
                                      "Config"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Manifest" ]
                                       "Config"
                                       []
                                  )
                             )
                     }
                )
                [ withDisplayModeArg_, withDisplayModeArg_0 ]
    , withIarcRatingId =
        \withIarcRatingIdArg_ withIarcRatingIdArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Manifest" ]
                     , name = "withIarcRatingId"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Pages", "Manifest" ]
                                      "Config"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Manifest" ]
                                       "Config"
                                       []
                                  )
                             )
                     }
                )
                [ withIarcRatingIdArg_, withIarcRatingIdArg_0 ]
    , withLang =
        \withLangArg_ withLangArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Manifest" ]
                     , name = "withLang"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "LanguageTag" ]
                                      "LanguageTag"
                                      []
                                  , Type.namedWith
                                      [ "Pages", "Manifest" ]
                                      "Config"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Manifest" ]
                                       "Config"
                                       []
                                  )
                             )
                     }
                )
                [ withLangArg_, withLangArg_0 ]
    , withOrientation =
        \withOrientationArg_ withOrientationArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Manifest" ]
                     , name = "withOrientation"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Manifest" ]
                                      "Orientation"
                                      []
                                  , Type.namedWith
                                      [ "Pages", "Manifest" ]
                                      "Config"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Manifest" ]
                                       "Config"
                                       []
                                  )
                             )
                     }
                )
                [ withOrientationArg_, withOrientationArg_0 ]
    , withShortName =
        \withShortNameArg_ withShortNameArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Manifest" ]
                     , name = "withShortName"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Pages", "Manifest" ]
                                      "Config"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Manifest" ]
                                       "Config"
                                       []
                                  )
                             )
                     }
                )
                [ withShortNameArg_, withShortNameArg_0 ]
    , withThemeColor =
        \withThemeColorArg_ withThemeColorArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Manifest" ]
                     , name = "withThemeColor"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Color" ] "Color" []
                                  , Type.namedWith
                                      [ "Pages", "Manifest" ]
                                      "Config"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Manifest" ]
                                       "Config"
                                       []
                                  )
                             )
                     }
                )
                [ withThemeColorArg_, withThemeColorArg_0 ]
    , withField =
        \withFieldArg_ withFieldArg_0 withFieldArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Manifest" ]
                     , name = "withField"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Json", "Encode" ]
                                      "Value"
                                      []
                                  , Type.namedWith
                                      [ "Pages", "Manifest" ]
                                      "Config"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Manifest" ]
                                       "Config"
                                       []
                                  )
                             )
                     }
                )
                [ withFieldArg_, withFieldArg_0, withFieldArg_1 ]
    , generator =
        \generatorArg_ generatorArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Manifest" ]
                     , name = "generator"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.namedWith
                                            [ "FatalError" ]
                                            "FatalError"
                                            []
                                      , Type.namedWith
                                            [ "Pages", "Manifest" ]
                                            "Config"
                                            []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "ApiRoute" ]
                                       "ApiRoute"
                                       [ Type.namedWith
                                           [ "ApiRoute" ]
                                           "Response"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ generatorArg_, generatorArg_0 ]
    , toJson =
        \toJsonArg_ toJsonArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Manifest" ]
                     , name = "toJson"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Pages", "Manifest" ]
                                      "Config"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Json", "Encode" ]
                                       "Value"
                                       []
                                  )
                             )
                     }
                )
                [ toJsonArg_, toJsonArg_0 ]
    }


values_ :
    { init : Elm.Expression
    , withBackgroundColor : Elm.Expression
    , withCategories : Elm.Expression
    , withDisplayMode : Elm.Expression
    , withIarcRatingId : Elm.Expression
    , withLang : Elm.Expression
    , withOrientation : Elm.Expression
    , withShortName : Elm.Expression
    , withThemeColor : Elm.Expression
    , withField : Elm.Expression
    , generator : Elm.Expression
    , toJson : Elm.Expression
    }
values_ =
    { init =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "init"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "description", Type.string )
                             , ( "name", Type.string )
                             , ( "startUrl"
                               , Type.namedWith [ "UrlPath" ] "UrlPath" []
                               )
                             , ( "icons"
                               , Type.list
                                   (Type.namedWith
                                      [ "Pages", "Manifest" ]
                                      "Icon"
                                      []
                                   )
                               )
                             ]
                         ]
                         (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                    )
            }
    , withBackgroundColor =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "withBackgroundColor"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Color" ] "Color" []
                         , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                         ]
                         (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                    )
            }
    , withCategories =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "withCategories"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "Pages", "Manifest", "Category" ]
                                "Category"
                                []
                             )
                         , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                         ]
                         (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                    )
            }
    , withDisplayMode =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "withDisplayMode"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Manifest" ]
                             "DisplayMode"
                             []
                         , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                         ]
                         (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                    )
            }
    , withIarcRatingId =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "withIarcRatingId"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                         ]
                         (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                    )
            }
    , withLang =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "withLang"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "LanguageTag" ] "LanguageTag" []
                         , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                         ]
                         (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                    )
            }
    , withOrientation =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "withOrientation"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Manifest" ]
                             "Orientation"
                             []
                         , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                         ]
                         (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                    )
            }
    , withShortName =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "withShortName"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                         ]
                         (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                    )
            }
    , withThemeColor =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "withThemeColor"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Color" ] "Color" []
                         , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                         ]
                         (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                    )
            }
    , withField =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "withField"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Json", "Encode" ] "Value" []
                         , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                         ]
                         (Type.namedWith [ "Pages", "Manifest" ] "Config" [])
                    )
            }
    , generator =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "generator"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.namedWith [ "FatalError" ] "FatalError" []
                             , Type.namedWith
                                   [ "Pages", "Manifest" ]
                                   "Config"
                                   []
                             ]
                         ]
                         (Type.namedWith
                              [ "ApiRoute" ]
                              "ApiRoute"
                              [ Type.namedWith [ "ApiRoute" ] "Response" [] ]
                         )
                    )
            }
    , toJson =
        Elm.value
            { importFrom = [ "Pages", "Manifest" ]
            , name = "toJson"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Pages", "Manifest" ] "Config" []
                         ]
                         (Type.namedWith [ "Json", "Encode" ] "Value" [])
                    )
            }
    }