module Gen.Head.Seo exposing (annotation_, article, audioPlayer, book, call_, make_, moduleName_, profile, song, summary, summaryLarge, values_, videoPlayer, website)

{-| 
@docs moduleName_, article, audioPlayer, book, profile, song, summary, summaryLarge, videoPlayer, website, annotation_, make_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Head", "Seo" ]


{-| See <https://ogp.me/#type_article>

article: 
    { tags : List String
    , section : Maybe String
    , publishedTime : Maybe DateOrDateTime.DateOrDateTime
    , modifiedTime : Maybe DateOrDateTime.DateOrDateTime
    , expirationTime : Maybe DateOrDateTime.DateOrDateTime
    }
    -> Head.Seo.Common
    -> List Head.Tag
-}
article :
    { tags : List String
    , section : Elm.Expression
    , publishedTime : Elm.Expression
    , modifiedTime : Elm.Expression
    , expirationTime : Elm.Expression
    }
    -> Elm.Expression
    -> Elm.Expression
article articleArg articleArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head", "Seo" ]
             , name = "article"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "tags", Type.list Type.string )
                              , ( "section", Type.maybe Type.string )
                              , ( "publishedTime"
                                , Type.maybe
                                    (Type.namedWith
                                       [ "DateOrDateTime" ]
                                       "DateOrDateTime"
                                       []
                                    )
                                )
                              , ( "modifiedTime"
                                , Type.maybe
                                    (Type.namedWith
                                       [ "DateOrDateTime" ]
                                       "DateOrDateTime"
                                       []
                                    )
                                )
                              , ( "expirationTime"
                                , Type.maybe
                                    (Type.namedWith
                                       [ "DateOrDateTime" ]
                                       "DateOrDateTime"
                                       []
                                    )
                                )
                              ]
                          , Type.namedWith [ "Head", "Seo" ] "Common" []
                          ]
                          (Type.list (Type.namedWith [ "Head" ] "Tag" []))
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "tags" (Elm.list (List.map Elm.string articleArg.tags))
            , Tuple.pair "section" articleArg.section
            , Tuple.pair "publishedTime" articleArg.publishedTime
            , Tuple.pair "modifiedTime" articleArg.modifiedTime
            , Tuple.pair "expirationTime" articleArg.expirationTime
            ]
        , articleArg0
        ]


{-| Will be displayed as a Player card in twitter
See: <https://developer.twitter.com/en/docs/tweets/optimize-with-cards/overview/player-card>

OpenGraph audio will also be included.
The options will also be used to build up the appropriate OpenGraph `<meta>` tags.

audioPlayer: 
    { canonicalUrlOverride : Maybe String
    , siteName : String
    , image : Head.Seo.Image
    , description : String
    , title : String
    , audio : Head.Seo.Audio
    , locale : Maybe Head.Seo.Locale
    }
    -> Head.Seo.Common
-}
audioPlayer :
    { canonicalUrlOverride : Elm.Expression
    , siteName : String
    , image : Elm.Expression
    , description : String
    , title : String
    , audio : Elm.Expression
    , locale : Elm.Expression
    }
    -> Elm.Expression
audioPlayer audioPlayerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head", "Seo" ]
             , name = "audioPlayer"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "canonicalUrlOverride"
                                , Type.maybe Type.string
                                )
                              , ( "siteName", Type.string )
                              , ( "image"
                                , Type.namedWith [ "Head", "Seo" ] "Image" []
                                )
                              , ( "description", Type.string )
                              , ( "title", Type.string )
                              , ( "audio"
                                , Type.namedWith [ "Head", "Seo" ] "Audio" []
                                )
                              , ( "locale"
                                , Type.maybe
                                    (Type.namedWith
                                       [ "Head", "Seo" ]
                                       "Locale"
                                       []
                                    )
                                )
                              ]
                          ]
                          (Type.namedWith [ "Head", "Seo" ] "Common" [])
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair
                  "canonicalUrlOverride"
                  audioPlayerArg.canonicalUrlOverride
            , Tuple.pair "siteName" (Elm.string audioPlayerArg.siteName)
            , Tuple.pair "image" audioPlayerArg.image
            , Tuple.pair "description" (Elm.string audioPlayerArg.description)
            , Tuple.pair "title" (Elm.string audioPlayerArg.title)
            , Tuple.pair "audio" audioPlayerArg.audio
            , Tuple.pair "locale" audioPlayerArg.locale
            ]
        ]


{-| See <https://ogp.me/#type_book>

book: 
    Head.Seo.Common
    -> { tags : List String
    , isbn : Maybe String
    , releaseDate : Maybe DateOrDateTime.DateOrDateTime
    }
    -> List Head.Tag
-}
book :
    Elm.Expression
    -> { tags : List String
    , isbn : Elm.Expression
    , releaseDate : Elm.Expression
    }
    -> Elm.Expression
book bookArg bookArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head", "Seo" ]
             , name = "book"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Head", "Seo" ] "Common" []
                          , Type.record
                              [ ( "tags", Type.list Type.string )
                              , ( "isbn", Type.maybe Type.string )
                              , ( "releaseDate"
                                , Type.maybe
                                    (Type.namedWith
                                       [ "DateOrDateTime" ]
                                       "DateOrDateTime"
                                       []
                                    )
                                )
                              ]
                          ]
                          (Type.list (Type.namedWith [ "Head" ] "Tag" []))
                     )
             }
        )
        [ bookArg
        , Elm.record
            [ Tuple.pair "tags" (Elm.list (List.map Elm.string bookArg0.tags))
            , Tuple.pair "isbn" bookArg0.isbn
            , Tuple.pair "releaseDate" bookArg0.releaseDate
            ]
        ]


{-| See <https://ogp.me/#type_profile>

profile: 
    { firstName : String, lastName : String, username : Maybe String }
    -> Head.Seo.Common
    -> List Head.Tag
-}
profile :
    { firstName : String, lastName : String, username : Elm.Expression }
    -> Elm.Expression
    -> Elm.Expression
profile profileArg profileArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head", "Seo" ]
             , name = "profile"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "firstName", Type.string )
                              , ( "lastName", Type.string )
                              , ( "username", Type.maybe Type.string )
                              ]
                          , Type.namedWith [ "Head", "Seo" ] "Common" []
                          ]
                          (Type.list (Type.namedWith [ "Head" ] "Tag" []))
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "firstName" (Elm.string profileArg.firstName)
            , Tuple.pair "lastName" (Elm.string profileArg.lastName)
            , Tuple.pair "username" profileArg.username
            ]
        , profileArg0
        ]


{-| See <https://ogp.me/#type_music.song>

song: 
    Head.Seo.Common
    -> { duration : Maybe Int
    , album : Maybe Int
    , disc : Maybe Int
    , track : Maybe Int
    }
    -> List Head.Tag
-}
song :
    Elm.Expression
    -> { duration : Elm.Expression
    , album : Elm.Expression
    , disc : Elm.Expression
    , track : Elm.Expression
    }
    -> Elm.Expression
song songArg songArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head", "Seo" ]
             , name = "song"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Head", "Seo" ] "Common" []
                          , Type.record
                              [ ( "duration", Type.maybe Type.int )
                              , ( "album", Type.maybe Type.int )
                              , ( "disc", Type.maybe Type.int )
                              , ( "track", Type.maybe Type.int )
                              ]
                          ]
                          (Type.list (Type.namedWith [ "Head" ] "Tag" []))
                     )
             }
        )
        [ songArg
        , Elm.record
            [ Tuple.pair "duration" songArg0.duration
            , Tuple.pair "album" songArg0.album
            , Tuple.pair "disc" songArg0.disc
            , Tuple.pair "track" songArg0.track
            ]
        ]


{-| Will be displayed as a large card in twitter
See: <https://developer.twitter.com/en/docs/tweets/optimize-with-cards/overview/summary>

The options will also be used to build up the appropriate OpenGraph `<meta>` tags.

Note: You cannot include audio or video tags with summaries.
If you want one of those, use `audioPlayer` or `videoPlayer`

summary: 
    { canonicalUrlOverride : Maybe String
    , siteName : String
    , image : Head.Seo.Image
    , description : String
    , title : String
    , locale : Maybe Head.Seo.Locale
    }
    -> Head.Seo.Common
-}
summary :
    { canonicalUrlOverride : Elm.Expression
    , siteName : String
    , image : Elm.Expression
    , description : String
    , title : String
    , locale : Elm.Expression
    }
    -> Elm.Expression
summary summaryArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head", "Seo" ]
             , name = "summary"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "canonicalUrlOverride"
                                , Type.maybe Type.string
                                )
                              , ( "siteName", Type.string )
                              , ( "image"
                                , Type.namedWith [ "Head", "Seo" ] "Image" []
                                )
                              , ( "description", Type.string )
                              , ( "title", Type.string )
                              , ( "locale"
                                , Type.maybe
                                    (Type.namedWith
                                       [ "Head", "Seo" ]
                                       "Locale"
                                       []
                                    )
                                )
                              ]
                          ]
                          (Type.namedWith [ "Head", "Seo" ] "Common" [])
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "canonicalUrlOverride" summaryArg.canonicalUrlOverride
            , Tuple.pair "siteName" (Elm.string summaryArg.siteName)
            , Tuple.pair "image" summaryArg.image
            , Tuple.pair "description" (Elm.string summaryArg.description)
            , Tuple.pair "title" (Elm.string summaryArg.title)
            , Tuple.pair "locale" summaryArg.locale
            ]
        ]


{-| Will be displayed as a large card in twitter
See: <https://developer.twitter.com/en/docs/tweets/optimize-with-cards/overview/summary-card-with-large-image>

The options will also be used to build up the appropriate OpenGraph `<meta>` tags.

Note: You cannot include audio or video tags with summaries.
If you want one of those, use `audioPlayer` or `videoPlayer`

summaryLarge: 
    { canonicalUrlOverride : Maybe String
    , siteName : String
    , image : Head.Seo.Image
    , description : String
    , title : String
    , locale : Maybe Head.Seo.Locale
    }
    -> Head.Seo.Common
-}
summaryLarge :
    { canonicalUrlOverride : Elm.Expression
    , siteName : String
    , image : Elm.Expression
    , description : String
    , title : String
    , locale : Elm.Expression
    }
    -> Elm.Expression
summaryLarge summaryLargeArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head", "Seo" ]
             , name = "summaryLarge"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "canonicalUrlOverride"
                                , Type.maybe Type.string
                                )
                              , ( "siteName", Type.string )
                              , ( "image"
                                , Type.namedWith [ "Head", "Seo" ] "Image" []
                                )
                              , ( "description", Type.string )
                              , ( "title", Type.string )
                              , ( "locale"
                                , Type.maybe
                                    (Type.namedWith
                                       [ "Head", "Seo" ]
                                       "Locale"
                                       []
                                    )
                                )
                              ]
                          ]
                          (Type.namedWith [ "Head", "Seo" ] "Common" [])
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair
                  "canonicalUrlOverride"
                  summaryLargeArg.canonicalUrlOverride
            , Tuple.pair "siteName" (Elm.string summaryLargeArg.siteName)
            , Tuple.pair "image" summaryLargeArg.image
            , Tuple.pair "description" (Elm.string summaryLargeArg.description)
            , Tuple.pair "title" (Elm.string summaryLargeArg.title)
            , Tuple.pair "locale" summaryLargeArg.locale
            ]
        ]


{-| Will be displayed as a Player card in twitter
See: <https://developer.twitter.com/en/docs/tweets/optimize-with-cards/overview/player-card>

OpenGraph video will also be included.
The options will also be used to build up the appropriate OpenGraph `<meta>` tags.

videoPlayer: 
    { canonicalUrlOverride : Maybe String
    , siteName : String
    , image : Head.Seo.Image
    , description : String
    , title : String
    , video : Head.Seo.Video
    , locale : Maybe Head.Seo.Locale
    }
    -> Head.Seo.Common
-}
videoPlayer :
    { canonicalUrlOverride : Elm.Expression
    , siteName : String
    , image : Elm.Expression
    , description : String
    , title : String
    , video : Elm.Expression
    , locale : Elm.Expression
    }
    -> Elm.Expression
videoPlayer videoPlayerArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head", "Seo" ]
             , name = "videoPlayer"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "canonicalUrlOverride"
                                , Type.maybe Type.string
                                )
                              , ( "siteName", Type.string )
                              , ( "image"
                                , Type.namedWith [ "Head", "Seo" ] "Image" []
                                )
                              , ( "description", Type.string )
                              , ( "title", Type.string )
                              , ( "video"
                                , Type.namedWith [ "Head", "Seo" ] "Video" []
                                )
                              , ( "locale"
                                , Type.maybe
                                    (Type.namedWith
                                       [ "Head", "Seo" ]
                                       "Locale"
                                       []
                                    )
                                )
                              ]
                          ]
                          (Type.namedWith [ "Head", "Seo" ] "Common" [])
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair
                  "canonicalUrlOverride"
                  videoPlayerArg.canonicalUrlOverride
            , Tuple.pair "siteName" (Elm.string videoPlayerArg.siteName)
            , Tuple.pair "image" videoPlayerArg.image
            , Tuple.pair "description" (Elm.string videoPlayerArg.description)
            , Tuple.pair "title" (Elm.string videoPlayerArg.title)
            , Tuple.pair "video" videoPlayerArg.video
            , Tuple.pair "locale" videoPlayerArg.locale
            ]
        ]


{-| <https://ogp.me/#type_website>

website: Head.Seo.Common -> List Head.Tag
-}
website : Elm.Expression -> Elm.Expression
website websiteArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Head", "Seo" ]
             , name = "website"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Head", "Seo" ] "Common" [] ]
                          (Type.list (Type.namedWith [ "Head" ] "Tag" []))
                     )
             }
        )
        [ websiteArg ]


annotation_ : { common : Type.Annotation, image : Type.Annotation }
annotation_ =
    { common =
        Type.alias
            moduleName_
            "Common"
            []
            (Type.record
                 [ ( "title", Type.string )
                 , ( "image", Type.namedWith [ "Head", "Seo" ] "Image" [] )
                 , ( "canonicalUrlOverride", Type.maybe Type.string )
                 , ( "description", Type.string )
                 , ( "siteName", Type.string )
                 , ( "audio"
                   , Type.maybe (Type.namedWith [ "Head", "Seo" ] "Audio" [])
                   )
                 , ( "video"
                   , Type.maybe (Type.namedWith [ "Head", "Seo" ] "Video" [])
                   )
                 , ( "locale"
                   , Type.maybe (Type.namedWith [ "Head", "Seo" ] "Locale" [])
                   )
                 , ( "alternateLocales"
                   , Type.list (Type.namedWith [ "Head", "Seo" ] "Locale" [])
                   )
                 , ( "twitterCard"
                   , Type.namedWith [ "Head", "Twitter" ] "TwitterCard" []
                   )
                 ]
            )
    , image =
        Type.alias
            moduleName_
            "Image"
            []
            (Type.record
                 [ ( "url", Type.namedWith [ "Pages", "Url" ] "Url" [] )
                 , ( "alt", Type.string )
                 , ( "dimensions"
                   , Type.maybe
                         (Type.record
                              [ ( "width", Type.int ), ( "height", Type.int ) ]
                         )
                   )
                 , ( "mimeType"
                   , Type.maybe (Type.namedWith [ "MimeType" ] "MimeType" [])
                   )
                 ]
            )
    }


make_ :
    { common :
        { title : Elm.Expression
        , image : Elm.Expression
        , canonicalUrlOverride : Elm.Expression
        , description : Elm.Expression
        , siteName : Elm.Expression
        , audio : Elm.Expression
        , video : Elm.Expression
        , locale : Elm.Expression
        , alternateLocales : Elm.Expression
        , twitterCard : Elm.Expression
        }
        -> Elm.Expression
    , image :
        { url : Elm.Expression
        , alt : Elm.Expression
        , dimensions : Elm.Expression
        , mimeType : Elm.Expression
        }
        -> Elm.Expression
    }
make_ =
    { common =
        \common_args ->
            Elm.withType
                (Type.alias
                     [ "Head", "Seo" ]
                     "Common"
                     []
                     (Type.record
                          [ ( "title", Type.string )
                          , ( "image"
                            , Type.namedWith [ "Head", "Seo" ] "Image" []
                            )
                          , ( "canonicalUrlOverride", Type.maybe Type.string )
                          , ( "description", Type.string )
                          , ( "siteName", Type.string )
                          , ( "audio"
                            , Type.maybe
                                  (Type.namedWith [ "Head", "Seo" ] "Audio" [])
                            )
                          , ( "video"
                            , Type.maybe
                                  (Type.namedWith [ "Head", "Seo" ] "Video" [])
                            )
                          , ( "locale"
                            , Type.maybe
                                  (Type.namedWith [ "Head", "Seo" ] "Locale" [])
                            )
                          , ( "alternateLocales"
                            , Type.list
                                  (Type.namedWith [ "Head", "Seo" ] "Locale" [])
                            )
                          , ( "twitterCard"
                            , Type.namedWith
                                  [ "Head", "Twitter" ]
                                  "TwitterCard"
                                  []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "title" common_args.title
                     , Tuple.pair "image" common_args.image
                     , Tuple.pair
                         "canonicalUrlOverride"
                         common_args.canonicalUrlOverride
                     , Tuple.pair "description" common_args.description
                     , Tuple.pair "siteName" common_args.siteName
                     , Tuple.pair "audio" common_args.audio
                     , Tuple.pair "video" common_args.video
                     , Tuple.pair "locale" common_args.locale
                     , Tuple.pair
                         "alternateLocales"
                         common_args.alternateLocales
                     , Tuple.pair "twitterCard" common_args.twitterCard
                     ]
                )
    , image =
        \image_args ->
            Elm.withType
                (Type.alias
                     [ "Head", "Seo" ]
                     "Image"
                     []
                     (Type.record
                          [ ( "url"
                            , Type.namedWith [ "Pages", "Url" ] "Url" []
                            )
                          , ( "alt", Type.string )
                          , ( "dimensions"
                            , Type.maybe
                                  (Type.record
                                       [ ( "width", Type.int )
                                       , ( "height", Type.int )
                                       ]
                                  )
                            )
                          , ( "mimeType"
                            , Type.maybe
                                  (Type.namedWith [ "MimeType" ] "MimeType" [])
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "url" image_args.url
                     , Tuple.pair "alt" image_args.alt
                     , Tuple.pair "dimensions" image_args.dimensions
                     , Tuple.pair "mimeType" image_args.mimeType
                     ]
                )
    }


call_ :
    { article : Elm.Expression -> Elm.Expression -> Elm.Expression
    , audioPlayer : Elm.Expression -> Elm.Expression
    , book : Elm.Expression -> Elm.Expression -> Elm.Expression
    , profile : Elm.Expression -> Elm.Expression -> Elm.Expression
    , song : Elm.Expression -> Elm.Expression -> Elm.Expression
    , summary : Elm.Expression -> Elm.Expression
    , summaryLarge : Elm.Expression -> Elm.Expression
    , videoPlayer : Elm.Expression -> Elm.Expression
    , website : Elm.Expression -> Elm.Expression
    }
call_ =
    { article =
        \articleArg articleArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head", "Seo" ]
                     , name = "article"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "tags", Type.list Type.string )
                                      , ( "section", Type.maybe Type.string )
                                      , ( "publishedTime"
                                        , Type.maybe
                                            (Type.namedWith
                                               [ "DateOrDateTime" ]
                                               "DateOrDateTime"
                                               []
                                            )
                                        )
                                      , ( "modifiedTime"
                                        , Type.maybe
                                            (Type.namedWith
                                               [ "DateOrDateTime" ]
                                               "DateOrDateTime"
                                               []
                                            )
                                        )
                                      , ( "expirationTime"
                                        , Type.maybe
                                            (Type.namedWith
                                               [ "DateOrDateTime" ]
                                               "DateOrDateTime"
                                               []
                                            )
                                        )
                                      ]
                                  , Type.namedWith [ "Head", "Seo" ] "Common" []
                                  ]
                                  (Type.list
                                       (Type.namedWith [ "Head" ] "Tag" [])
                                  )
                             )
                     }
                )
                [ articleArg, articleArg0 ]
    , audioPlayer =
        \audioPlayerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head", "Seo" ]
                     , name = "audioPlayer"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "canonicalUrlOverride"
                                        , Type.maybe Type.string
                                        )
                                      , ( "siteName", Type.string )
                                      , ( "image"
                                        , Type.namedWith
                                            [ "Head", "Seo" ]
                                            "Image"
                                            []
                                        )
                                      , ( "description", Type.string )
                                      , ( "title", Type.string )
                                      , ( "audio"
                                        , Type.namedWith
                                            [ "Head", "Seo" ]
                                            "Audio"
                                            []
                                        )
                                      , ( "locale"
                                        , Type.maybe
                                            (Type.namedWith
                                               [ "Head", "Seo" ]
                                               "Locale"
                                               []
                                            )
                                        )
                                      ]
                                  ]
                                  (Type.namedWith [ "Head", "Seo" ] "Common" [])
                             )
                     }
                )
                [ audioPlayerArg ]
    , book =
        \bookArg bookArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head", "Seo" ]
                     , name = "book"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Head", "Seo" ] "Common" []
                                  , Type.record
                                      [ ( "tags", Type.list Type.string )
                                      , ( "isbn", Type.maybe Type.string )
                                      , ( "releaseDate"
                                        , Type.maybe
                                            (Type.namedWith
                                               [ "DateOrDateTime" ]
                                               "DateOrDateTime"
                                               []
                                            )
                                        )
                                      ]
                                  ]
                                  (Type.list
                                       (Type.namedWith [ "Head" ] "Tag" [])
                                  )
                             )
                     }
                )
                [ bookArg, bookArg0 ]
    , profile =
        \profileArg profileArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head", "Seo" ]
                     , name = "profile"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "firstName", Type.string )
                                      , ( "lastName", Type.string )
                                      , ( "username", Type.maybe Type.string )
                                      ]
                                  , Type.namedWith [ "Head", "Seo" ] "Common" []
                                  ]
                                  (Type.list
                                       (Type.namedWith [ "Head" ] "Tag" [])
                                  )
                             )
                     }
                )
                [ profileArg, profileArg0 ]
    , song =
        \songArg songArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head", "Seo" ]
                     , name = "song"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Head", "Seo" ] "Common" []
                                  , Type.record
                                      [ ( "duration", Type.maybe Type.int )
                                      , ( "album", Type.maybe Type.int )
                                      , ( "disc", Type.maybe Type.int )
                                      , ( "track", Type.maybe Type.int )
                                      ]
                                  ]
                                  (Type.list
                                       (Type.namedWith [ "Head" ] "Tag" [])
                                  )
                             )
                     }
                )
                [ songArg, songArg0 ]
    , summary =
        \summaryArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head", "Seo" ]
                     , name = "summary"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "canonicalUrlOverride"
                                        , Type.maybe Type.string
                                        )
                                      , ( "siteName", Type.string )
                                      , ( "image"
                                        , Type.namedWith
                                            [ "Head", "Seo" ]
                                            "Image"
                                            []
                                        )
                                      , ( "description", Type.string )
                                      , ( "title", Type.string )
                                      , ( "locale"
                                        , Type.maybe
                                            (Type.namedWith
                                               [ "Head", "Seo" ]
                                               "Locale"
                                               []
                                            )
                                        )
                                      ]
                                  ]
                                  (Type.namedWith [ "Head", "Seo" ] "Common" [])
                             )
                     }
                )
                [ summaryArg ]
    , summaryLarge =
        \summaryLargeArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head", "Seo" ]
                     , name = "summaryLarge"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "canonicalUrlOverride"
                                        , Type.maybe Type.string
                                        )
                                      , ( "siteName", Type.string )
                                      , ( "image"
                                        , Type.namedWith
                                            [ "Head", "Seo" ]
                                            "Image"
                                            []
                                        )
                                      , ( "description", Type.string )
                                      , ( "title", Type.string )
                                      , ( "locale"
                                        , Type.maybe
                                            (Type.namedWith
                                               [ "Head", "Seo" ]
                                               "Locale"
                                               []
                                            )
                                        )
                                      ]
                                  ]
                                  (Type.namedWith [ "Head", "Seo" ] "Common" [])
                             )
                     }
                )
                [ summaryLargeArg ]
    , videoPlayer =
        \videoPlayerArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head", "Seo" ]
                     , name = "videoPlayer"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "canonicalUrlOverride"
                                        , Type.maybe Type.string
                                        )
                                      , ( "siteName", Type.string )
                                      , ( "image"
                                        , Type.namedWith
                                            [ "Head", "Seo" ]
                                            "Image"
                                            []
                                        )
                                      , ( "description", Type.string )
                                      , ( "title", Type.string )
                                      , ( "video"
                                        , Type.namedWith
                                            [ "Head", "Seo" ]
                                            "Video"
                                            []
                                        )
                                      , ( "locale"
                                        , Type.maybe
                                            (Type.namedWith
                                               [ "Head", "Seo" ]
                                               "Locale"
                                               []
                                            )
                                        )
                                      ]
                                  ]
                                  (Type.namedWith [ "Head", "Seo" ] "Common" [])
                             )
                     }
                )
                [ videoPlayerArg ]
    , website =
        \websiteArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Head", "Seo" ]
                     , name = "website"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Head", "Seo" ] "Common" []
                                  ]
                                  (Type.list
                                       (Type.namedWith [ "Head" ] "Tag" [])
                                  )
                             )
                     }
                )
                [ websiteArg ]
    }


values_ :
    { article : Elm.Expression
    , audioPlayer : Elm.Expression
    , book : Elm.Expression
    , profile : Elm.Expression
    , song : Elm.Expression
    , summary : Elm.Expression
    , summaryLarge : Elm.Expression
    , videoPlayer : Elm.Expression
    , website : Elm.Expression
    }
values_ =
    { article =
        Elm.value
            { importFrom = [ "Head", "Seo" ]
            , name = "article"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "tags", Type.list Type.string )
                             , ( "section", Type.maybe Type.string )
                             , ( "publishedTime"
                               , Type.maybe
                                   (Type.namedWith
                                      [ "DateOrDateTime" ]
                                      "DateOrDateTime"
                                      []
                                   )
                               )
                             , ( "modifiedTime"
                               , Type.maybe
                                   (Type.namedWith
                                      [ "DateOrDateTime" ]
                                      "DateOrDateTime"
                                      []
                                   )
                               )
                             , ( "expirationTime"
                               , Type.maybe
                                   (Type.namedWith
                                      [ "DateOrDateTime" ]
                                      "DateOrDateTime"
                                      []
                                   )
                               )
                             ]
                         , Type.namedWith [ "Head", "Seo" ] "Common" []
                         ]
                         (Type.list (Type.namedWith [ "Head" ] "Tag" []))
                    )
            }
    , audioPlayer =
        Elm.value
            { importFrom = [ "Head", "Seo" ]
            , name = "audioPlayer"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "canonicalUrlOverride"
                               , Type.maybe Type.string
                               )
                             , ( "siteName", Type.string )
                             , ( "image"
                               , Type.namedWith [ "Head", "Seo" ] "Image" []
                               )
                             , ( "description", Type.string )
                             , ( "title", Type.string )
                             , ( "audio"
                               , Type.namedWith [ "Head", "Seo" ] "Audio" []
                               )
                             , ( "locale"
                               , Type.maybe
                                   (Type.namedWith [ "Head", "Seo" ] "Locale" []
                                   )
                               )
                             ]
                         ]
                         (Type.namedWith [ "Head", "Seo" ] "Common" [])
                    )
            }
    , book =
        Elm.value
            { importFrom = [ "Head", "Seo" ]
            , name = "book"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Head", "Seo" ] "Common" []
                         , Type.record
                             [ ( "tags", Type.list Type.string )
                             , ( "isbn", Type.maybe Type.string )
                             , ( "releaseDate"
                               , Type.maybe
                                   (Type.namedWith
                                      [ "DateOrDateTime" ]
                                      "DateOrDateTime"
                                      []
                                   )
                               )
                             ]
                         ]
                         (Type.list (Type.namedWith [ "Head" ] "Tag" []))
                    )
            }
    , profile =
        Elm.value
            { importFrom = [ "Head", "Seo" ]
            , name = "profile"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "firstName", Type.string )
                             , ( "lastName", Type.string )
                             , ( "username", Type.maybe Type.string )
                             ]
                         , Type.namedWith [ "Head", "Seo" ] "Common" []
                         ]
                         (Type.list (Type.namedWith [ "Head" ] "Tag" []))
                    )
            }
    , song =
        Elm.value
            { importFrom = [ "Head", "Seo" ]
            , name = "song"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Head", "Seo" ] "Common" []
                         , Type.record
                             [ ( "duration", Type.maybe Type.int )
                             , ( "album", Type.maybe Type.int )
                             , ( "disc", Type.maybe Type.int )
                             , ( "track", Type.maybe Type.int )
                             ]
                         ]
                         (Type.list (Type.namedWith [ "Head" ] "Tag" []))
                    )
            }
    , summary =
        Elm.value
            { importFrom = [ "Head", "Seo" ]
            , name = "summary"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "canonicalUrlOverride"
                               , Type.maybe Type.string
                               )
                             , ( "siteName", Type.string )
                             , ( "image"
                               , Type.namedWith [ "Head", "Seo" ] "Image" []
                               )
                             , ( "description", Type.string )
                             , ( "title", Type.string )
                             , ( "locale"
                               , Type.maybe
                                   (Type.namedWith [ "Head", "Seo" ] "Locale" []
                                   )
                               )
                             ]
                         ]
                         (Type.namedWith [ "Head", "Seo" ] "Common" [])
                    )
            }
    , summaryLarge =
        Elm.value
            { importFrom = [ "Head", "Seo" ]
            , name = "summaryLarge"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "canonicalUrlOverride"
                               , Type.maybe Type.string
                               )
                             , ( "siteName", Type.string )
                             , ( "image"
                               , Type.namedWith [ "Head", "Seo" ] "Image" []
                               )
                             , ( "description", Type.string )
                             , ( "title", Type.string )
                             , ( "locale"
                               , Type.maybe
                                   (Type.namedWith [ "Head", "Seo" ] "Locale" []
                                   )
                               )
                             ]
                         ]
                         (Type.namedWith [ "Head", "Seo" ] "Common" [])
                    )
            }
    , videoPlayer =
        Elm.value
            { importFrom = [ "Head", "Seo" ]
            , name = "videoPlayer"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "canonicalUrlOverride"
                               , Type.maybe Type.string
                               )
                             , ( "siteName", Type.string )
                             , ( "image"
                               , Type.namedWith [ "Head", "Seo" ] "Image" []
                               )
                             , ( "description", Type.string )
                             , ( "title", Type.string )
                             , ( "video"
                               , Type.namedWith [ "Head", "Seo" ] "Video" []
                               )
                             , ( "locale"
                               , Type.maybe
                                   (Type.namedWith [ "Head", "Seo" ] "Locale" []
                                   )
                               )
                             ]
                         ]
                         (Type.namedWith [ "Head", "Seo" ] "Common" [])
                    )
            }
    , website =
        Elm.value
            { importFrom = [ "Head", "Seo" ]
            , name = "website"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Head", "Seo" ] "Common" [] ]
                         (Type.list (Type.namedWith [ "Head" ] "Tag" []))
                    )
            }
    }