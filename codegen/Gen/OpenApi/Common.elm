module Gen.OpenApi.Common exposing (annotation_, call_, caseOf_, decodeOptionalField, expectJsonCustom, expectJsonCustomEffect, jsonDecodeAndMap, jsonResolverCustom, jsonResolverCustomEffect, make_, moduleName_, values_)

{-| 
@docs moduleName_, jsonDecodeAndMap, decodeOptionalField, jsonResolverCustomEffect, expectJsonCustomEffect, jsonResolverCustom, expectJsonCustom, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "OpenApi", "Common" ]


{-| {-| Chain JSON decoders, when `Json.Decode.map8` isn't enough.
-}

jsonDecodeAndMap: 
    Json.Decode.Decoder a
    -> Json.Decode.Decoder (a -> value)
    -> Json.Decode.Decoder value
-}
jsonDecodeAndMap : Elm.Expression -> Elm.Expression -> Elm.Expression
jsonDecodeAndMap jsonDecodeAndMapArg jsonDecodeAndMapArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "OpenApi", "Common" ]
             , name = "jsonDecodeAndMap"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.var "a" ]
                          , Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.function
                                    [ Type.var "a" ]
                                    (Type.var "value")
                              ]
                          ]
                          (Type.namedWith
                               [ "Json", "Decode" ]
                               "Decoder"
                               [ Type.var "value" ]
                          )
                     )
             }
        )
        [ jsonDecodeAndMapArg, jsonDecodeAndMapArg0 ]


{-| {-| Decode an optional field

    decodeString (decodeOptionalField "x" int) "{ "x": 3 }"
    --> Ok (Just 3)

    decodeString (decodeOptionalField "x" int) "{ "x": true }"
    --> Err ...

    decodeString (decodeOptionalField "x" int) "{ "y": 4 }"
    --> Ok Nothing

-}

decodeOptionalField: String -> Json.Decode.Decoder t -> Json.Decode.Decoder (Maybe t)
-}
decodeOptionalField : String -> Elm.Expression -> Elm.Expression
decodeOptionalField decodeOptionalFieldArg decodeOptionalFieldArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "OpenApi", "Common" ]
             , name = "decodeOptionalField"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.var "t" ]
                          ]
                          (Type.namedWith
                               [ "Json", "Decode" ]
                               "Decoder"
                               [ Type.maybe (Type.var "t") ]
                          )
                     )
             }
        )
        [ Elm.string decodeOptionalFieldArg, decodeOptionalFieldArg0 ]


{-| jsonResolverCustomEffect: 
    Dict.Dict String (Json.Decode.Decoder err)
    -> Json.Decode.Decoder success
    -> Effect.Http.Resolver restrictions (OpenApi.Common.Error err String) success
-}
jsonResolverCustomEffect : Elm.Expression -> Elm.Expression -> Elm.Expression
jsonResolverCustomEffect jsonResolverCustomEffectArg jsonResolverCustomEffectArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "OpenApi", "Common" ]
             , name = "jsonResolverCustomEffect"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Dict" ]
                              "Dict"
                              [ Type.string
                              , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "err" ]
                              ]
                          , Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.var "success" ]
                          ]
                          (Type.namedWith
                               [ "Effect", "Http" ]
                               "Resolver"
                               [ Type.var "restrictions"
                               , Type.namedWith
                                   [ "OpenApi", "Common" ]
                                   "Error"
                                   [ Type.var "err", Type.string ]
                               , Type.var "success"
                               ]
                          )
                     )
             }
        )
        [ jsonResolverCustomEffectArg, jsonResolverCustomEffectArg0 ]


{-| expectJsonCustomEffect: 
    (Result.Result (OpenApi.Common.Error err String) success -> msg)
    -> Dict.Dict String (Json.Decode.Decoder err)
    -> Json.Decode.Decoder success
    -> Effect.Http.Expect msg
-}
expectJsonCustomEffect :
    (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
expectJsonCustomEffect expectJsonCustomEffectArg expectJsonCustomEffectArg0 expectJsonCustomEffectArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "OpenApi", "Common" ]
             , name = "expectJsonCustomEffect"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.namedWith
                                        [ "OpenApi", "Common" ]
                                        "Error"
                                        [ Type.var "err", Type.string ]
                                    , Type.var "success"
                                    ]
                              ]
                              (Type.var "msg")
                          , Type.namedWith
                              [ "Dict" ]
                              "Dict"
                              [ Type.string
                              , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "err" ]
                              ]
                          , Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.var "success" ]
                          ]
                          (Type.namedWith
                               [ "Effect", "Http" ]
                               "Expect"
                               [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "expectJsonCustomEffectUnpack"
            expectJsonCustomEffectArg
        , expectJsonCustomEffectArg0
        , expectJsonCustomEffectArg1
        ]


{-| jsonResolverCustom: 
    Dict.Dict String (Json.Decode.Decoder err)
    -> Json.Decode.Decoder success
    -> Http.Resolver (OpenApi.Common.Error err String) success
-}
jsonResolverCustom : Elm.Expression -> Elm.Expression -> Elm.Expression
jsonResolverCustom jsonResolverCustomArg jsonResolverCustomArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "OpenApi", "Common" ]
             , name = "jsonResolverCustom"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Dict" ]
                              "Dict"
                              [ Type.string
                              , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "err" ]
                              ]
                          , Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.var "success" ]
                          ]
                          (Type.namedWith
                               [ "Http" ]
                               "Resolver"
                               [ Type.namedWith
                                   [ "OpenApi", "Common" ]
                                   "Error"
                                   [ Type.var "err", Type.string ]
                               , Type.var "success"
                               ]
                          )
                     )
             }
        )
        [ jsonResolverCustomArg, jsonResolverCustomArg0 ]


{-| expectJsonCustom: 
    (Result.Result (OpenApi.Common.Error err String) success -> msg)
    -> Dict.Dict String (Json.Decode.Decoder err)
    -> Json.Decode.Decoder success
    -> Http.Expect msg
-}
expectJsonCustom :
    (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
expectJsonCustom expectJsonCustomArg expectJsonCustomArg0 expectJsonCustomArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "OpenApi", "Common" ]
             , name = "expectJsonCustom"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.namedWith
                                        [ "OpenApi", "Common" ]
                                        "Error"
                                        [ Type.var "err", Type.string ]
                                    , Type.var "success"
                                    ]
                              ]
                              (Type.var "msg")
                          , Type.namedWith
                              [ "Dict" ]
                              "Dict"
                              [ Type.string
                              , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "err" ]
                              ]
                          , Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.var "success" ]
                          ]
                          (Type.namedWith [ "Http" ] "Expect" [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "expectJsonCustomUnpack" expectJsonCustomArg
        , expectJsonCustomArg0
        , expectJsonCustomArg1
        ]


annotation_ :
    { nullable : Type.Annotation -> Type.Annotation
    , error : Type.Annotation -> Type.Annotation -> Type.Annotation
    }
annotation_ =
    { nullable =
        \nullableArg0 ->
            Type.namedWith [ "OpenApi", "Common" ] "Nullable" [ nullableArg0 ]
    , error =
        \errorArg0 errorArg1 ->
            Type.namedWith
                [ "OpenApi", "Common" ]
                "Error"
                [ errorArg0, errorArg1 ]
    }


make_ :
    { null : Elm.Expression
    , present : Elm.Expression -> Elm.Expression
    , badUrl : Elm.Expression -> Elm.Expression
    , timeout : Elm.Expression
    , networkError : Elm.Expression
    , knownBadStatus : Elm.Expression -> Elm.Expression -> Elm.Expression
    , unknownBadStatus : Elm.Expression -> Elm.Expression -> Elm.Expression
    , badErrorBody : Elm.Expression -> Elm.Expression -> Elm.Expression
    , badBody : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
make_ =
    { null =
        Elm.value
            { importFrom = [ "OpenApi", "Common" ]
            , name = "Null"
            , annotation =
                Just (Type.namedWith [] "Nullable" [ Type.var "value" ])
            }
    , present =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "Present"
                     , annotation =
                         Just
                             (Type.namedWith [] "Nullable" [ Type.var "value" ])
                     }
                )
                [ ar0 ]
    , badUrl =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "BadUrl"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Error"
                                  [ Type.var "err", Type.var "body" ]
                             )
                     }
                )
                [ ar0 ]
    , timeout =
        Elm.value
            { importFrom = [ "OpenApi", "Common" ]
            , name = "Timeout"
            , annotation =
                Just
                    (Type.namedWith
                         []
                         "Error"
                         [ Type.var "err", Type.var "body" ]
                    )
            }
    , networkError =
        Elm.value
            { importFrom = [ "OpenApi", "Common" ]
            , name = "NetworkError"
            , annotation =
                Just
                    (Type.namedWith
                         []
                         "Error"
                         [ Type.var "err", Type.var "body" ]
                    )
            }
    , knownBadStatus =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "KnownBadStatus"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Error"
                                  [ Type.var "err", Type.var "body" ]
                             )
                     }
                )
                [ ar0, ar1 ]
    , unknownBadStatus =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "UnknownBadStatus"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Error"
                                  [ Type.var "err", Type.var "body" ]
                             )
                     }
                )
                [ ar0, ar1 ]
    , badErrorBody =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "BadErrorBody"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Error"
                                  [ Type.var "err", Type.var "body" ]
                             )
                     }
                )
                [ ar0, ar1 ]
    , badBody =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "BadBody"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Error"
                                  [ Type.var "err", Type.var "body" ]
                             )
                     }
                )
                [ ar0, ar1 ]
    }


caseOf_ :
    { nullable :
        Elm.Expression
        -> { nullableTags_0_0
            | null : Elm.Expression
            , present : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , error :
        Elm.Expression
        -> { errorTags_1_0
            | badUrl : Elm.Expression -> Elm.Expression
            , timeout : Elm.Expression
            , networkError : Elm.Expression
            , knownBadStatus :
                Elm.Expression -> Elm.Expression -> Elm.Expression
            , unknownBadStatus :
                Elm.Expression -> Elm.Expression -> Elm.Expression
            , badErrorBody : Elm.Expression -> Elm.Expression -> Elm.Expression
            , badBody : Elm.Expression -> Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { nullable =
        \nullableExpression nullableTags ->
            Elm.Case.custom
                nullableExpression
                (Type.namedWith
                     [ "OpenApi", "Common" ]
                     "Nullable"
                     [ Type.var "value" ]
                )
                [ Elm.Case.branch0 "Null" nullableTags.null
                , Elm.Case.branch1
                    "Present"
                    ( "value", Type.var "value" )
                    nullableTags.present
                ]
    , error =
        \errorExpression errorTags ->
            Elm.Case.custom
                errorExpression
                (Type.namedWith
                     [ "OpenApi", "Common" ]
                     "Error"
                     [ Type.var "err", Type.var "body" ]
                )
                [ Elm.Case.branch1
                    "BadUrl"
                    ( "stringString", Type.string )
                    errorTags.badUrl
                , Elm.Case.branch0 "Timeout" errorTags.timeout
                , Elm.Case.branch0 "NetworkError" errorTags.networkError
                , Elm.Case.branch2
                    "KnownBadStatus"
                    ( "basicsInt", Type.int )
                    ( "err", Type.var "err" )
                    errorTags.knownBadStatus
                , Elm.Case.branch2
                    "UnknownBadStatus"
                    ( "httpMetadata", Type.namedWith [ "Http" ] "Metadata" [] )
                    ( "body", Type.var "body" )
                    errorTags.unknownBadStatus
                , Elm.Case.branch2
                    "BadErrorBody"
                    ( "httpMetadata", Type.namedWith [ "Http" ] "Metadata" [] )
                    ( "body", Type.var "body" )
                    errorTags.badErrorBody
                , Elm.Case.branch2
                    "BadBody"
                    ( "httpMetadata", Type.namedWith [ "Http" ] "Metadata" [] )
                    ( "body", Type.var "body" )
                    errorTags.badBody
                ]
    }


call_ :
    { jsonDecodeAndMap : Elm.Expression -> Elm.Expression -> Elm.Expression
    , decodeOptionalField : Elm.Expression -> Elm.Expression -> Elm.Expression
    , jsonResolverCustomEffect :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectJsonCustomEffect :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , jsonResolverCustom : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectJsonCustom :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { jsonDecodeAndMap =
        \jsonDecodeAndMapArg jsonDecodeAndMapArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "jsonDecodeAndMap"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Decoder"
                                      [ Type.var "a" ]
                                  , Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Decoder"
                                      [ Type.function
                                            [ Type.var "a" ]
                                            (Type.var "value")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Json", "Decode" ]
                                       "Decoder"
                                       [ Type.var "value" ]
                                  )
                             )
                     }
                )
                [ jsonDecodeAndMapArg, jsonDecodeAndMapArg0 ]
    , decodeOptionalField =
        \decodeOptionalFieldArg decodeOptionalFieldArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "decodeOptionalField"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Decoder"
                                      [ Type.var "t" ]
                                  ]
                                  (Type.namedWith
                                       [ "Json", "Decode" ]
                                       "Decoder"
                                       [ Type.maybe (Type.var "t") ]
                                  )
                             )
                     }
                )
                [ decodeOptionalFieldArg, decodeOptionalFieldArg0 ]
    , jsonResolverCustomEffect =
        \jsonResolverCustomEffectArg jsonResolverCustomEffectArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "jsonResolverCustomEffect"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Dict" ]
                                      "Dict"
                                      [ Type.string
                                      , Type.namedWith
                                            [ "Json", "Decode" ]
                                            "Decoder"
                                            [ Type.var "err" ]
                                      ]
                                  , Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Decoder"
                                      [ Type.var "success" ]
                                  ]
                                  (Type.namedWith
                                       [ "Effect", "Http" ]
                                       "Resolver"
                                       [ Type.var "restrictions"
                                       , Type.namedWith
                                           [ "OpenApi", "Common" ]
                                           "Error"
                                           [ Type.var "err", Type.string ]
                                       , Type.var "success"
                                       ]
                                  )
                             )
                     }
                )
                [ jsonResolverCustomEffectArg, jsonResolverCustomEffectArg0 ]
    , expectJsonCustomEffect =
        \expectJsonCustomEffectArg expectJsonCustomEffectArg0 expectJsonCustomEffectArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "expectJsonCustomEffect"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.namedWith
                                            [ "Result" ]
                                            "Result"
                                            [ Type.namedWith
                                                [ "OpenApi", "Common" ]
                                                "Error"
                                                [ Type.var "err", Type.string ]
                                            , Type.var "success"
                                            ]
                                      ]
                                      (Type.var "msg")
                                  , Type.namedWith
                                      [ "Dict" ]
                                      "Dict"
                                      [ Type.string
                                      , Type.namedWith
                                            [ "Json", "Decode" ]
                                            "Decoder"
                                            [ Type.var "err" ]
                                      ]
                                  , Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Decoder"
                                      [ Type.var "success" ]
                                  ]
                                  (Type.namedWith
                                       [ "Effect", "Http" ]
                                       "Expect"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ expectJsonCustomEffectArg
                , expectJsonCustomEffectArg0
                , expectJsonCustomEffectArg1
                ]
    , jsonResolverCustom =
        \jsonResolverCustomArg jsonResolverCustomArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "jsonResolverCustom"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Dict" ]
                                      "Dict"
                                      [ Type.string
                                      , Type.namedWith
                                            [ "Json", "Decode" ]
                                            "Decoder"
                                            [ Type.var "err" ]
                                      ]
                                  , Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Decoder"
                                      [ Type.var "success" ]
                                  ]
                                  (Type.namedWith
                                       [ "Http" ]
                                       "Resolver"
                                       [ Type.namedWith
                                           [ "OpenApi", "Common" ]
                                           "Error"
                                           [ Type.var "err", Type.string ]
                                       , Type.var "success"
                                       ]
                                  )
                             )
                     }
                )
                [ jsonResolverCustomArg, jsonResolverCustomArg0 ]
    , expectJsonCustom =
        \expectJsonCustomArg expectJsonCustomArg0 expectJsonCustomArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "expectJsonCustom"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.namedWith
                                            [ "Result" ]
                                            "Result"
                                            [ Type.namedWith
                                                [ "OpenApi", "Common" ]
                                                "Error"
                                                [ Type.var "err", Type.string ]
                                            , Type.var "success"
                                            ]
                                      ]
                                      (Type.var "msg")
                                  , Type.namedWith
                                      [ "Dict" ]
                                      "Dict"
                                      [ Type.string
                                      , Type.namedWith
                                            [ "Json", "Decode" ]
                                            "Decoder"
                                            [ Type.var "err" ]
                                      ]
                                  , Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Decoder"
                                      [ Type.var "success" ]
                                  ]
                                  (Type.namedWith
                                       [ "Http" ]
                                       "Expect"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ expectJsonCustomArg
                , expectJsonCustomArg0
                , expectJsonCustomArg1
                ]
    }


values_ :
    { jsonDecodeAndMap : Elm.Expression
    , decodeOptionalField : Elm.Expression
    , jsonResolverCustomEffect : Elm.Expression
    , expectJsonCustomEffect : Elm.Expression
    , jsonResolverCustom : Elm.Expression
    , expectJsonCustom : Elm.Expression
    }
values_ =
    { jsonDecodeAndMap =
        Elm.value
            { importFrom = [ "OpenApi", "Common" ]
            , name = "jsonDecodeAndMap"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Json", "Decode" ]
                             "Decoder"
                             [ Type.var "a" ]
                         , Type.namedWith
                             [ "Json", "Decode" ]
                             "Decoder"
                             [ Type.function [ Type.var "a" ] (Type.var "value")
                             ]
                         ]
                         (Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.var "value" ]
                         )
                    )
            }
    , decodeOptionalField =
        Elm.value
            { importFrom = [ "OpenApi", "Common" ]
            , name = "decodeOptionalField"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "Json", "Decode" ]
                             "Decoder"
                             [ Type.var "t" ]
                         ]
                         (Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.maybe (Type.var "t") ]
                         )
                    )
            }
    , jsonResolverCustomEffect =
        Elm.value
            { importFrom = [ "OpenApi", "Common" ]
            , name = "jsonResolverCustomEffect"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Dict" ]
                             "Dict"
                             [ Type.string
                             , Type.namedWith
                                   [ "Json", "Decode" ]
                                   "Decoder"
                                   [ Type.var "err" ]
                             ]
                         , Type.namedWith
                             [ "Json", "Decode" ]
                             "Decoder"
                             [ Type.var "success" ]
                         ]
                         (Type.namedWith
                              [ "Effect", "Http" ]
                              "Resolver"
                              [ Type.var "restrictions"
                              , Type.namedWith
                                  [ "OpenApi", "Common" ]
                                  "Error"
                                  [ Type.var "err", Type.string ]
                              , Type.var "success"
                              ]
                         )
                    )
            }
    , expectJsonCustomEffect =
        Elm.value
            { importFrom = [ "OpenApi", "Common" ]
            , name = "expectJsonCustomEffect"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.namedWith
                                   [ "Result" ]
                                   "Result"
                                   [ Type.namedWith
                                       [ "OpenApi", "Common" ]
                                       "Error"
                                       [ Type.var "err", Type.string ]
                                   , Type.var "success"
                                   ]
                             ]
                             (Type.var "msg")
                         , Type.namedWith
                             [ "Dict" ]
                             "Dict"
                             [ Type.string
                             , Type.namedWith
                                   [ "Json", "Decode" ]
                                   "Decoder"
                                   [ Type.var "err" ]
                             ]
                         , Type.namedWith
                             [ "Json", "Decode" ]
                             "Decoder"
                             [ Type.var "success" ]
                         ]
                         (Type.namedWith
                              [ "Effect", "Http" ]
                              "Expect"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , jsonResolverCustom =
        Elm.value
            { importFrom = [ "OpenApi", "Common" ]
            , name = "jsonResolverCustom"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Dict" ]
                             "Dict"
                             [ Type.string
                             , Type.namedWith
                                   [ "Json", "Decode" ]
                                   "Decoder"
                                   [ Type.var "err" ]
                             ]
                         , Type.namedWith
                             [ "Json", "Decode" ]
                             "Decoder"
                             [ Type.var "success" ]
                         ]
                         (Type.namedWith
                              [ "Http" ]
                              "Resolver"
                              [ Type.namedWith
                                  [ "OpenApi", "Common" ]
                                  "Error"
                                  [ Type.var "err", Type.string ]
                              , Type.var "success"
                              ]
                         )
                    )
            }
    , expectJsonCustom =
        Elm.value
            { importFrom = [ "OpenApi", "Common" ]
            , name = "expectJsonCustom"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.namedWith
                                   [ "Result" ]
                                   "Result"
                                   [ Type.namedWith
                                       [ "OpenApi", "Common" ]
                                       "Error"
                                       [ Type.var "err", Type.string ]
                                   , Type.var "success"
                                   ]
                             ]
                             (Type.var "msg")
                         , Type.namedWith
                             [ "Dict" ]
                             "Dict"
                             [ Type.string
                             , Type.namedWith
                                   [ "Json", "Decode" ]
                                   "Decoder"
                                   [ Type.var "err" ]
                             ]
                         , Type.namedWith
                             [ "Json", "Decode" ]
                             "Decoder"
                             [ Type.var "success" ]
                         ]
                         (Type.namedWith [ "Http" ] "Expect" [ Type.var "msg" ])
                    )
            }
    }