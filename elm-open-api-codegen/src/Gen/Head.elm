module Gen.Head exposing
    ( moduleName_, metaName, metaProperty, metaRedirect, rssLink, sitemapLink
    , rootLanguage, manifestLink, nonLoadingNode, structuredData, currentPageFullUrl, urlAttribute, raw
    , appleTouchIcon, icon, toJson, canonicalLink, annotation_, call_, values_
    )

{-|
# Generated bindings for Head

@docs moduleName_, metaName, metaProperty, metaRedirect, rssLink, sitemapLink
@docs rootLanguage, manifestLink, nonLoadingNode, structuredData, currentPageFullUrl, urlAttribute
@docs raw, appleTouchIcon, icon, toJson, canonicalLink, annotation_
@docs call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Head" ]


{-| Example:

    Head.metaName "twitter:card" (Head.raw "summary_large_image")

Results in `<meta name="twitter:card" content="summary_large_image" />`

metaName: String -> Head.AttributeValue -> Head.Tag
-}
metaName : String -> Elm.Expression -> Elm.Expression
metaName metaNameArg_ metaNameArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head" ]
             , name = "metaName"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Head" ] "AttributeValue" []
                          ]
                          (Type.namedWith [ "Head" ] "Tag" [])
                     )
             }
        )
        [ Elm.string metaNameArg_, metaNameArg_0 ]


{-| Example:

    Head.metaProperty "fb:app_id" (Head.raw "123456789")

Results in `<meta property="fb:app_id" content="123456789" />`

metaProperty: String -> Head.AttributeValue -> Head.Tag
-}
metaProperty : String -> Elm.Expression -> Elm.Expression
metaProperty metaPropertyArg_ metaPropertyArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head" ]
             , name = "metaProperty"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Head" ] "AttributeValue" []
                          ]
                          (Type.namedWith [ "Head" ] "Tag" [])
                     )
             }
        )
        [ Elm.string metaPropertyArg_, metaPropertyArg_0 ]


{-| Example:

    metaRedirect (Raw "0; url=https://google.com")

Results in `<meta http-equiv="refresh" content="0; url=https://google.com" />`

metaRedirect: Head.AttributeValue -> Head.Tag
-}
metaRedirect : Elm.Expression -> Elm.Expression
metaRedirect metaRedirectArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head" ]
             , name = "metaRedirect"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Head" ] "AttributeValue" [] ]
                          (Type.namedWith [ "Head" ] "Tag" [])
                     )
             }
        )
        [ metaRedirectArg_ ]


{-| Add a link to the site's RSS feed.

Example:

    rssLink "/feed.xml"

```html
<link rel="alternate" type="application/rss+xml" href="/rss.xml">
```

rssLink: String -> Head.Tag
-}
rssLink : String -> Elm.Expression
rssLink rssLinkArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head" ]
             , name = "rssLink"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith [ "Head" ] "Tag" [])
                     )
             }
        )
        [ Elm.string rssLinkArg_ ]


{-| Add a link to the site's RSS feed.

Example:

    sitemapLink "/feed.xml"

```html
<link rel="sitemap" type="application/xml" href="/sitemap.xml">
```

sitemapLink: String -> Head.Tag
-}
sitemapLink : String -> Elm.Expression
sitemapLink sitemapLinkArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head" ]
             , name = "sitemapLink"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith [ "Head" ] "Tag" [])
                     )
             }
        )
        [ Elm.string sitemapLinkArg_ ]


{-| Set the language for a page.

<https://developer.mozilla.org/en-US/docs/Web/HTML/Global_attributes/lang>

    import Head
    import LanguageTag
    import LanguageTag.Language

    LanguageTag.Language.de -- sets the page's language to German
        |> LanguageTag.build LanguageTag.emptySubtags
        |> Head.rootLanguage

This results pre-rendered HTML with a global lang tag set.

```html
<html lang="no">
...
</html>
```

rootLanguage: LanguageTag.LanguageTag -> Head.Tag
-}
rootLanguage : Elm.Expression -> Elm.Expression
rootLanguage rootLanguageArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head" ]
             , name = "rootLanguage"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "LanguageTag" ] "LanguageTag" [] ]
                          (Type.namedWith [ "Head" ] "Tag" [])
                     )
             }
        )
        [ rootLanguageArg_ ]


{-| Let's you link to your manifest.json file, see <https://developer.mozilla.org/en-US/docs/Web/Manifest#deploying_a_manifest>.

manifestLink: String -> Head.Tag
-}
manifestLink : String -> Elm.Expression
manifestLink manifestLinkArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head" ]
             , name = "manifestLink"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith [ "Head" ] "Tag" [])
                     )
             }
        )
        [ Elm.string manifestLinkArg_ ]


{-| Escape hatch for any head tags that don't have high-level helpers. This lets you build arbitrary head nodes as long as they
are not loading or preloading directives.

Tags that do loading/pre-loading will not work from this function. `elm-pages` uses ViteJS for loading assets like
script tags, stylesheets, fonts, etc., and allows you to customize which assets to preload and how through the elm-pages.config.mjs file.
See the full discussion of the design in [#339](https://github.com/dillonkearns/elm-pages/discussions/339).

So for example the following tags would _not_ load if defined through `nonLoadingNode`, and would instead need to be registered through Vite:

  - `<script src="...">`
  - `<link href="/style.css">`
  - `<link rel="preload">`

The following tag would successfully render as it is a non-loading tag:

    Head.nonLoadingNode "link"
        [ ( "rel", Head.raw "alternate" )
        , ( "type", Head.raw "application/atom+xml" )
        , ( "title", Head.raw "News" )
        , ( "href", Head.raw "/news/atom" )
        ]

Renders the head tag:

`<link rel="alternate" type="application/atom+xml" title="News" href="/news/atom">`

nonLoadingNode: String -> List ( String, Head.AttributeValue ) -> Head.Tag
-}
nonLoadingNode : String -> List Elm.Expression -> Elm.Expression
nonLoadingNode nonLoadingNodeArg_ nonLoadingNodeArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head" ]
             , name = "nonLoadingNode"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.list
                              (Type.tuple
                                 Type.string
                                 (Type.namedWith [ "Head" ] "AttributeValue" [])
                              )
                          ]
                          (Type.namedWith [ "Head" ] "Tag" [])
                     )
             }
        )
        [ Elm.string nonLoadingNodeArg_, Elm.list nonLoadingNodeArg_0 ]


{-| You can learn more about structured data in [Google's intro to structured data](https://developers.google.com/search/docs/guides/intro-structured-data).

When you add a `structuredData` item to one of your pages in `elm-pages`, it will add `json-ld` data to your document that looks like this:

```html
<script type="application/ld+json">
{
   "@context":"http://schema.org/",
   "@type":"Article",
   "headline":"Extensible Markdown Parsing in Pure Elm",
   "description":"Introducing a new parser that extends your palette with no additional syntax",
   "image":"https://elm-pages.com/images/article-covers/extensible-markdown-parsing.jpg",
   "author":{
      "@type":"Person",
      "name":"Dillon Kearns"
   },
   "publisher":{
      "@type":"Person",
      "name":"Dillon Kearns"
   },
   "url":"https://elm-pages.com/blog/extensible-markdown-parsing-in-elm",
   "datePublished":"2019-10-08",
   "mainEntityOfPage":{
      "@type":"SoftwareSourceCode",
      "codeRepository":"https://github.com/dillonkearns/elm-pages",
      "description":"A statically typed site generator for Elm.",
      "author":"Dillon Kearns",
      "programmingLanguage":{
         "@type":"ComputerLanguage",
         "url":"http://elm-lang.org/",
         "name":"Elm",
         "image":"http://elm-lang.org/",
         "identifier":"http://elm-lang.org/"
      }
   }
}
</script>
```

To get that data, you would write this in your `elm-pages` head tags:

    import Json.Encode as Encode

    {-| <https://schema.org/Article>
    -}
    encodeArticle :
        { title : String
        , description : String
        , author : StructuredDataHelper { authorMemberOf | personOrOrganization : () } authorPossibleFields
        , publisher : StructuredDataHelper { publisherMemberOf | personOrOrganization : () } publisherPossibleFields
        , url : String
        , imageUrl : String
        , datePublished : String
        , mainEntityOfPage : Encode.Value
        }
        -> Head.Tag
    encodeArticle info =
        Encode.object
            [ ( "@context", Encode.string "http://schema.org/" )
            , ( "@type", Encode.string "Article" )
            , ( "headline", Encode.string info.title )
            , ( "description", Encode.string info.description )
            , ( "image", Encode.string info.imageUrl )
            , ( "author", encode info.author )
            , ( "publisher", encode info.publisher )
            , ( "url", Encode.string info.url )
            , ( "datePublished", Encode.string info.datePublished )
            , ( "mainEntityOfPage", info.mainEntityOfPage )
            ]
            |> Head.structuredData

Take a look at this [Google Search Gallery](https://developers.google.com/search/docs/guides/search-gallery)
to see some examples of how structured data can be used by search engines to give rich search results. It can help boost
your rankings, get better engagement for your content, and also make your content more accessible. For example,
voice assistant devices can make use of structured data. If you're hosting a conference and want to make the event
date and location easy for attendees to find, this can make that information more accessible.

For the current version of API, you'll need to make sure that the format is correct and contains the required and recommended
structure.

Check out <https://schema.org> for a comprehensive listing of possible data types and fields. And take a look at
Google's [Structured Data Testing Tool](https://search.google.com/structured-data/testing-tool)
too make sure that your structured data is valid and includes the recommended values.

In the future, `elm-pages` will likely support a typed API, but schema.org is a massive spec, and changes frequently.
And there are multiple sources of information on the possible and recommended structure. So it will take some time
for the right API design to evolve. In the meantime, this allows you to make use of this for SEO purposes.

structuredData: Json.Encode.Value -> Head.Tag
-}
structuredData : Elm.Expression -> Elm.Expression
structuredData structuredDataArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head" ]
             , name = "structuredData"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Json", "Encode" ] "Value" [] ]
                          (Type.namedWith [ "Head" ] "Tag" [])
                     )
             }
        )
        [ structuredDataArg_ ]


{-| Create an `AttributeValue` representing the current page's full url.

currentPageFullUrl: Head.AttributeValue
-}
currentPageFullUrl : Elm.Expression
currentPageFullUrl =
    Elm.value
        { importFrom = [ "Head" ]
        , name = "currentPageFullUrl"
        , annotation = Just (Type.namedWith [ "Head" ] "AttributeValue" [])
        }


{-| Create an `AttributeValue` from an `ImagePath`.

urlAttribute: Pages.Url.Url -> Head.AttributeValue
-}
urlAttribute : Elm.Expression -> Elm.Expression
urlAttribute urlAttributeArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head" ]
             , name = "urlAttribute"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Pages", "Url" ] "Url" [] ]
                          (Type.namedWith [ "Head" ] "AttributeValue" [])
                     )
             }
        )
        [ urlAttributeArg_ ]


{-| Create a raw `AttributeValue` (as opposed to some kind of absolute URL).

raw: String -> Head.AttributeValue
-}
raw : String -> Elm.Expression
raw rawArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head" ]
             , name = "raw"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith [ "Head" ] "AttributeValue" [])
                     )
             }
        )
        [ Elm.string rawArg_ ]


{-| Note: the type must be png.
See <https://developer.apple.com/library/archive/documentation/AppleApplications/Reference/SafariWebContent/ConfiguringWebApplications/ConfiguringWebApplications.html>.

If a size is provided, it will be turned into square dimensions as per the recommendations here: <https://developers.google.com/web/fundamentals/design-and-ux/browser-customization/#safari>

Images must be png's, and non-transparent images are recommended. Current recommended dimensions are 180px and 192px.

appleTouchIcon: Maybe Int -> Pages.Url.Url -> Head.Tag
-}
appleTouchIcon : Elm.Expression -> Elm.Expression -> Elm.Expression
appleTouchIcon appleTouchIconArg_ appleTouchIconArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head" ]
             , name = "appleTouchIcon"
             , annotation =
                 Just
                     (Type.function
                          [ Type.maybe Type.int
                          , Type.namedWith [ "Pages", "Url" ] "Url" []
                          ]
                          (Type.namedWith [ "Head" ] "Tag" [])
                     )
             }
        )
        [ appleTouchIconArg_, appleTouchIconArg_0 ]


{-| icon: List ( Int, Int ) -> MimeType.MimeImage -> Pages.Url.Url -> Head.Tag -}
icon : List Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
icon iconArg_ iconArg_0 iconArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head" ]
             , name = "icon"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list (Type.tuple Type.int Type.int)
                          , Type.namedWith [ "MimeType" ] "MimeImage" []
                          , Type.namedWith [ "Pages", "Url" ] "Url" []
                          ]
                          (Type.namedWith [ "Head" ] "Tag" [])
                     )
             }
        )
        [ Elm.list iconArg_, iconArg_0, iconArg_1 ]


{-| Feel free to use this, but in 99% of cases you won't need it. The generated
code will run this for you to generate your `manifest.json` file automatically!

toJson: String -> String -> Head.Tag -> Json.Encode.Value
-}
toJson : String -> String -> Elm.Expression -> Elm.Expression
toJson toJsonArg_ toJsonArg_0 toJsonArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head" ]
             , name = "toJson"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.string
                          , Type.namedWith [ "Head" ] "Tag" []
                          ]
                          (Type.namedWith [ "Json", "Encode" ] "Value" [])
                     )
             }
        )
        [ Elm.string toJsonArg_, Elm.string toJsonArg_0, toJsonArg_1 ]


{-| It's recommended that you use the `Seo` module helpers, which will provide this
for you, rather than directly using this.

Example:

    Head.canonicalLink "https://elm-pages.com"

canonicalLink: Maybe String -> Head.Tag
-}
canonicalLink : Elm.Expression -> Elm.Expression
canonicalLink canonicalLinkArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head" ]
             , name = "canonicalLink"
             , annotation =
                 Just
                     (Type.function
                          [ Type.maybe Type.string ]
                          (Type.namedWith [ "Head" ] "Tag" [])
                     )
             }
        )
        [ canonicalLinkArg_ ]


annotation_ : { tag : Type.Annotation, attributeValue : Type.Annotation }
annotation_ =
    { tag = Type.namedWith [ "Head" ] "Tag" []
    , attributeValue = Type.namedWith [ "Head" ] "AttributeValue" []
    }


call_ :
    { metaName : Elm.Expression -> Elm.Expression -> Elm.Expression
    , metaProperty : Elm.Expression -> Elm.Expression -> Elm.Expression
    , metaRedirect : Elm.Expression -> Elm.Expression
    , rssLink : Elm.Expression -> Elm.Expression
    , sitemapLink : Elm.Expression -> Elm.Expression
    , rootLanguage : Elm.Expression -> Elm.Expression
    , manifestLink : Elm.Expression -> Elm.Expression
    , nonLoadingNode : Elm.Expression -> Elm.Expression -> Elm.Expression
    , structuredData : Elm.Expression -> Elm.Expression
    , urlAttribute : Elm.Expression -> Elm.Expression
    , raw : Elm.Expression -> Elm.Expression
    , appleTouchIcon : Elm.Expression -> Elm.Expression -> Elm.Expression
    , icon :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , toJson :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , canonicalLink : Elm.Expression -> Elm.Expression
    }
call_ =
    { metaName =
        \metaNameArg_ metaNameArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head" ]
                     , name = "metaName"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Head" ]
                                      "AttributeValue"
                                      []
                                  ]
                                  (Type.namedWith [ "Head" ] "Tag" [])
                             )
                     }
                )
                [ metaNameArg_, metaNameArg_0 ]
    , metaProperty =
        \metaPropertyArg_ metaPropertyArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head" ]
                     , name = "metaProperty"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Head" ]
                                      "AttributeValue"
                                      []
                                  ]
                                  (Type.namedWith [ "Head" ] "Tag" [])
                             )
                     }
                )
                [ metaPropertyArg_, metaPropertyArg_0 ]
    , metaRedirect =
        \metaRedirectArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head" ]
                     , name = "metaRedirect"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Head" ]
                                      "AttributeValue"
                                      []
                                  ]
                                  (Type.namedWith [ "Head" ] "Tag" [])
                             )
                     }
                )
                [ metaRedirectArg_ ]
    , rssLink =
        \rssLinkArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head" ]
                     , name = "rssLink"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith [ "Head" ] "Tag" [])
                             )
                     }
                )
                [ rssLinkArg_ ]
    , sitemapLink =
        \sitemapLinkArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head" ]
                     , name = "sitemapLink"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith [ "Head" ] "Tag" [])
                             )
                     }
                )
                [ sitemapLinkArg_ ]
    , rootLanguage =
        \rootLanguageArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head" ]
                     , name = "rootLanguage"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "LanguageTag" ]
                                      "LanguageTag"
                                      []
                                  ]
                                  (Type.namedWith [ "Head" ] "Tag" [])
                             )
                     }
                )
                [ rootLanguageArg_ ]
    , manifestLink =
        \manifestLinkArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head" ]
                     , name = "manifestLink"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith [ "Head" ] "Tag" [])
                             )
                     }
                )
                [ manifestLinkArg_ ]
    , nonLoadingNode =
        \nonLoadingNodeArg_ nonLoadingNodeArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head" ]
                     , name = "nonLoadingNode"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.list
                                      (Type.tuple
                                         Type.string
                                         (Type.namedWith
                                            [ "Head" ]
                                            "AttributeValue"
                                            []
                                         )
                                      )
                                  ]
                                  (Type.namedWith [ "Head" ] "Tag" [])
                             )
                     }
                )
                [ nonLoadingNodeArg_, nonLoadingNodeArg_0 ]
    , structuredData =
        \structuredDataArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head" ]
                     , name = "structuredData"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Json", "Encode" ]
                                      "Value"
                                      []
                                  ]
                                  (Type.namedWith [ "Head" ] "Tag" [])
                             )
                     }
                )
                [ structuredDataArg_ ]
    , urlAttribute =
        \urlAttributeArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head" ]
                     , name = "urlAttribute"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Pages", "Url" ] "Url" [] ]
                                  (Type.namedWith [ "Head" ] "AttributeValue" []
                                  )
                             )
                     }
                )
                [ urlAttributeArg_ ]
    , raw =
        \rawArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head" ]
                     , name = "raw"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith [ "Head" ] "AttributeValue" []
                                  )
                             )
                     }
                )
                [ rawArg_ ]
    , appleTouchIcon =
        \appleTouchIconArg_ appleTouchIconArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head" ]
                     , name = "appleTouchIcon"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.maybe Type.int
                                  , Type.namedWith [ "Pages", "Url" ] "Url" []
                                  ]
                                  (Type.namedWith [ "Head" ] "Tag" [])
                             )
                     }
                )
                [ appleTouchIconArg_, appleTouchIconArg_0 ]
    , icon =
        \iconArg_ iconArg_0 iconArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head" ]
                     , name = "icon"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list (Type.tuple Type.int Type.int)
                                  , Type.namedWith [ "MimeType" ] "MimeImage" []
                                  , Type.namedWith [ "Pages", "Url" ] "Url" []
                                  ]
                                  (Type.namedWith [ "Head" ] "Tag" [])
                             )
                     }
                )
                [ iconArg_, iconArg_0, iconArg_1 ]
    , toJson =
        \toJsonArg_ toJsonArg_0 toJsonArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head" ]
                     , name = "toJson"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.string
                                  , Type.namedWith [ "Head" ] "Tag" []
                                  ]
                                  (Type.namedWith
                                       [ "Json", "Encode" ]
                                       "Value"
                                       []
                                  )
                             )
                     }
                )
                [ toJsonArg_, toJsonArg_0, toJsonArg_1 ]
    , canonicalLink =
        \canonicalLinkArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head" ]
                     , name = "canonicalLink"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.maybe Type.string ]
                                  (Type.namedWith [ "Head" ] "Tag" [])
                             )
                     }
                )
                [ canonicalLinkArg_ ]
    }


values_ :
    { metaName : Elm.Expression
    , metaProperty : Elm.Expression
    , metaRedirect : Elm.Expression
    , rssLink : Elm.Expression
    , sitemapLink : Elm.Expression
    , rootLanguage : Elm.Expression
    , manifestLink : Elm.Expression
    , nonLoadingNode : Elm.Expression
    , structuredData : Elm.Expression
    , currentPageFullUrl : Elm.Expression
    , urlAttribute : Elm.Expression
    , raw : Elm.Expression
    , appleTouchIcon : Elm.Expression
    , icon : Elm.Expression
    , toJson : Elm.Expression
    , canonicalLink : Elm.Expression
    }
values_ =
    { metaName =
        Elm.value
            { importFrom = [ "Head" ]
            , name = "metaName"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Head" ] "AttributeValue" []
                         ]
                         (Type.namedWith [ "Head" ] "Tag" [])
                    )
            }
    , metaProperty =
        Elm.value
            { importFrom = [ "Head" ]
            , name = "metaProperty"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Head" ] "AttributeValue" []
                         ]
                         (Type.namedWith [ "Head" ] "Tag" [])
                    )
            }
    , metaRedirect =
        Elm.value
            { importFrom = [ "Head" ]
            , name = "metaRedirect"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Head" ] "AttributeValue" [] ]
                         (Type.namedWith [ "Head" ] "Tag" [])
                    )
            }
    , rssLink =
        Elm.value
            { importFrom = [ "Head" ]
            , name = "rssLink"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith [ "Head" ] "Tag" [])
                    )
            }
    , sitemapLink =
        Elm.value
            { importFrom = [ "Head" ]
            , name = "sitemapLink"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith [ "Head" ] "Tag" [])
                    )
            }
    , rootLanguage =
        Elm.value
            { importFrom = [ "Head" ]
            , name = "rootLanguage"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "LanguageTag" ] "LanguageTag" [] ]
                         (Type.namedWith [ "Head" ] "Tag" [])
                    )
            }
    , manifestLink =
        Elm.value
            { importFrom = [ "Head" ]
            , name = "manifestLink"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith [ "Head" ] "Tag" [])
                    )
            }
    , nonLoadingNode =
        Elm.value
            { importFrom = [ "Head" ]
            , name = "nonLoadingNode"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.list
                             (Type.tuple
                                Type.string
                                (Type.namedWith [ "Head" ] "AttributeValue" [])
                             )
                         ]
                         (Type.namedWith [ "Head" ] "Tag" [])
                    )
            }
    , structuredData =
        Elm.value
            { importFrom = [ "Head" ]
            , name = "structuredData"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Json", "Encode" ] "Value" [] ]
                         (Type.namedWith [ "Head" ] "Tag" [])
                    )
            }
    , currentPageFullUrl =
        Elm.value
            { importFrom = [ "Head" ]
            , name = "currentPageFullUrl"
            , annotation = Just (Type.namedWith [ "Head" ] "AttributeValue" [])
            }
    , urlAttribute =
        Elm.value
            { importFrom = [ "Head" ]
            , name = "urlAttribute"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Pages", "Url" ] "Url" [] ]
                         (Type.namedWith [ "Head" ] "AttributeValue" [])
                    )
            }
    , raw =
        Elm.value
            { importFrom = [ "Head" ]
            , name = "raw"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith [ "Head" ] "AttributeValue" [])
                    )
            }
    , appleTouchIcon =
        Elm.value
            { importFrom = [ "Head" ]
            , name = "appleTouchIcon"
            , annotation =
                Just
                    (Type.function
                         [ Type.maybe Type.int
                         , Type.namedWith [ "Pages", "Url" ] "Url" []
                         ]
                         (Type.namedWith [ "Head" ] "Tag" [])
                    )
            }
    , icon =
        Elm.value
            { importFrom = [ "Head" ]
            , name = "icon"
            , annotation =
                Just
                    (Type.function
                         [ Type.list (Type.tuple Type.int Type.int)
                         , Type.namedWith [ "MimeType" ] "MimeImage" []
                         , Type.namedWith [ "Pages", "Url" ] "Url" []
                         ]
                         (Type.namedWith [ "Head" ] "Tag" [])
                    )
            }
    , toJson =
        Elm.value
            { importFrom = [ "Head" ]
            , name = "toJson"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.string
                         , Type.namedWith [ "Head" ] "Tag" []
                         ]
                         (Type.namedWith [ "Json", "Encode" ] "Value" [])
                    )
            }
    , canonicalLink =
        Elm.value
            { importFrom = [ "Head" ]
            , name = "canonicalLink"
            , annotation =
                Just
                    (Type.function
                         [ Type.maybe Type.string ]
                         (Type.namedWith [ "Head" ] "Tag" [])
                    )
            }
    }