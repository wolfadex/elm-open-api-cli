module Gen.Pages.Fetcher exposing (annotation_, call_, caseOf_, make_, map, moduleName_, submit, values_)

{-| 
@docs moduleName_, submit, map, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Fetcher" ]


{-| submit: 
    Bytes.Decode.Decoder decoded
    -> { fields : List ( String, String ), headers : List ( String, String ) }
    -> Pages.Fetcher.Fetcher (Result.Result Http.Error decoded)
-}
submit :
    Elm.Expression
    -> { fields : List Elm.Expression, headers : List Elm.Expression }
    -> Elm.Expression
submit submitArg submitArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Fetcher" ]
             , name = "submit"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Bytes", "Decode" ]
                              "Decoder"
                              [ Type.var "decoded" ]
                          , Type.record
                              [ ( "fields"
                                , Type.list (Type.tuple Type.string Type.string)
                                )
                              , ( "headers"
                                , Type.list (Type.tuple Type.string Type.string)
                                )
                              ]
                          ]
                          (Type.namedWith
                               [ "Pages", "Fetcher" ]
                               "Fetcher"
                               [ Type.namedWith
                                   [ "Result" ]
                                   "Result"
                                   [ Type.namedWith [ "Http" ] "Error" []
                                   , Type.var "decoded"
                                   ]
                               ]
                          )
                     )
             }
        )
        [ submitArg
        , Elm.record
            [ Tuple.pair "fields" (Elm.list submitArg0.fields)
            , Tuple.pair "headers" (Elm.list submitArg0.headers)
            ]
        ]


{-| map: (a -> b) -> Pages.Fetcher.Fetcher a -> Pages.Fetcher.Fetcher b -}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg mapArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Fetcher" ]
             , name = "map"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function [ Type.var "a" ] (Type.var "b")
                          , Type.namedWith
                              [ "Pages", "Fetcher" ]
                              "Fetcher"
                              [ Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "Pages", "Fetcher" ]
                               "Fetcher"
                               [ Type.var "b" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapUnpack" mapArg, mapArg0 ]


annotation_ :
    { fetcher : Type.Annotation -> Type.Annotation
    , fetcherInfo : Type.Annotation -> Type.Annotation
    }
annotation_ =
    { fetcher =
        \fetcherArg0 ->
            Type.namedWith [ "Pages", "Fetcher" ] "Fetcher" [ fetcherArg0 ]
    , fetcherInfo =
        \fetcherInfoArg0 ->
            Type.alias
                moduleName_
                "FetcherInfo"
                [ fetcherInfoArg0 ]
                (Type.record
                     [ ( "decoder"
                       , Type.function
                             [ Type.namedWith
                                 [ "Result" ]
                                 "Result"
                                 [ Type.namedWith [ "Http" ] "Error" []
                                 , Type.namedWith [ "Bytes" ] "Bytes" []
                                 ]
                             ]
                             (Type.var "decoded")
                       )
                     , ( "fields"
                       , Type.list (Type.tuple Type.string Type.string)
                       )
                     , ( "headers"
                       , Type.list (Type.tuple Type.string Type.string)
                       )
                     , ( "url", Type.maybe Type.string )
                     ]
                )
    }


make_ :
    { fetcher : Elm.Expression -> Elm.Expression
    , fetcherInfo :
        { decoder : Elm.Expression
        , fields : Elm.Expression
        , headers : Elm.Expression
        , url : Elm.Expression
        }
        -> Elm.Expression
    }
make_ =
    { fetcher =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Fetcher" ]
                     , name = "Fetcher"
                     , annotation =
                         Just
                             (Type.namedWith [] "Fetcher" [ Type.var "decoded" ]
                             )
                     }
                )
                [ ar0 ]
    , fetcherInfo =
        \fetcherInfo_args ->
            Elm.withType
                (Type.alias
                     [ "Pages", "Fetcher" ]
                     "FetcherInfo"
                     [ Type.var "decoded" ]
                     (Type.record
                          [ ( "decoder"
                            , Type.function
                                  [ Type.namedWith
                                      [ "Result" ]
                                      "Result"
                                      [ Type.namedWith [ "Http" ] "Error" []
                                      , Type.namedWith [ "Bytes" ] "Bytes" []
                                      ]
                                  ]
                                  (Type.var "decoded")
                            )
                          , ( "fields"
                            , Type.list (Type.tuple Type.string Type.string)
                            )
                          , ( "headers"
                            , Type.list (Type.tuple Type.string Type.string)
                            )
                          , ( "url", Type.maybe Type.string )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "decoder" fetcherInfo_args.decoder
                     , Tuple.pair "fields" fetcherInfo_args.fields
                     , Tuple.pair "headers" fetcherInfo_args.headers
                     , Tuple.pair "url" fetcherInfo_args.url
                     ]
                )
    }


caseOf_ :
    { fetcher :
        Elm.Expression
        -> { fetcherTags_0_0 | fetcher : Elm.Expression -> Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { fetcher =
        \fetcherExpression fetcherTags ->
            Elm.Case.custom
                fetcherExpression
                (Type.namedWith
                     [ "Pages", "Fetcher" ]
                     "Fetcher"
                     [ Type.var "decoded" ]
                )
                [ Elm.Case.branch1
                    "Fetcher"
                    ( "pagesFetcherFetcherInfo"
                    , Type.namedWith
                          [ "Pages", "Fetcher" ]
                          "FetcherInfo"
                          [ Type.var "decoded" ]
                    )
                    fetcherTags.fetcher
                ]
    }


call_ :
    { submit : Elm.Expression -> Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { submit =
        \submitArg submitArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Fetcher" ]
                     , name = "submit"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Bytes", "Decode" ]
                                      "Decoder"
                                      [ Type.var "decoded" ]
                                  , Type.record
                                      [ ( "fields"
                                        , Type.list
                                            (Type.tuple Type.string Type.string)
                                        )
                                      , ( "headers"
                                        , Type.list
                                            (Type.tuple Type.string Type.string)
                                        )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Fetcher" ]
                                       "Fetcher"
                                       [ Type.namedWith
                                           [ "Result" ]
                                           "Result"
                                           [ Type.namedWith
                                                 [ "Http" ]
                                                 "Error"
                                                 []
                                           , Type.var "decoded"
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ submitArg, submitArg0 ]
    , map =
        \mapArg mapArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Fetcher" ]
                     , name = "map"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.var "b")
                                  , Type.namedWith
                                      [ "Pages", "Fetcher" ]
                                      "Fetcher"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Fetcher" ]
                                       "Fetcher"
                                       [ Type.var "b" ]
                                  )
                             )
                     }
                )
                [ mapArg, mapArg0 ]
    }


values_ : { submit : Elm.Expression, map : Elm.Expression }
values_ =
    { submit =
        Elm.value
            { importFrom = [ "Pages", "Fetcher" ]
            , name = "submit"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Bytes", "Decode" ]
                             "Decoder"
                             [ Type.var "decoded" ]
                         , Type.record
                             [ ( "fields"
                               , Type.list (Type.tuple Type.string Type.string)
                               )
                             , ( "headers"
                               , Type.list (Type.tuple Type.string Type.string)
                               )
                             ]
                         ]
                         (Type.namedWith
                              [ "Pages", "Fetcher" ]
                              "Fetcher"
                              [ Type.namedWith
                                  [ "Result" ]
                                  "Result"
                                  [ Type.namedWith [ "Http" ] "Error" []
                                  , Type.var "decoded"
                                  ]
                              ]
                         )
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "Pages", "Fetcher" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.var "a" ] (Type.var "b")
                         , Type.namedWith
                             [ "Pages", "Fetcher" ]
                             "Fetcher"
                             [ Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "Pages", "Fetcher" ]
                              "Fetcher"
                              [ Type.var "b" ]
                         )
                    )
            }
    }