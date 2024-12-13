module Gen.OpenApi.Common exposing
    ( moduleName_, jsonDecodeAndMap, decodeOptionalField, bytesResolverCustomEffect, expectBytesCustomEffect, stringResolverCustomEffect
    , expectStringCustomEffect, jsonResolverCustomEffect, expectJsonCustomEffect, bytesResolverCustom, expectBytesCustom, stringResolverCustom, expectStringCustom
    , jsonResolverCustom, expectJsonCustom, annotation_, make_, caseOf_, call_, values_
    )

{-|
# Generated bindings for OpenApi.Common

@docs moduleName_, jsonDecodeAndMap, decodeOptionalField, bytesResolverCustomEffect, expectBytesCustomEffect, stringResolverCustomEffect
@docs expectStringCustomEffect, jsonResolverCustomEffect, expectJsonCustomEffect, bytesResolverCustom, expectBytesCustom, stringResolverCustom
@docs expectStringCustom, jsonResolverCustom, expectJsonCustom, annotation_, make_, caseOf_
@docs call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
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
jsonDecodeAndMap jsonDecodeAndMapArg_ jsonDecodeAndMapArg_0 =
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
        [ jsonDecodeAndMapArg_, jsonDecodeAndMapArg_0 ]


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
decodeOptionalField decodeOptionalFieldArg_ decodeOptionalFieldArg_0 =
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
        [ Elm.string decodeOptionalFieldArg_, decodeOptionalFieldArg_0 ]


{-| bytesResolverCustomEffect: 
    Dict.Dict String (Json.Decode.Decoder err)
    -> Effect.Http.Resolver restrictions (OpenApi.Common.Error err Bytes.Bytes) Bytes.Bytes
-}
bytesResolverCustomEffect : Elm.Expression -> Elm.Expression
bytesResolverCustomEffect bytesResolverCustomEffectArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "OpenApi", "Common" ]
             , name = "bytesResolverCustomEffect"
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
                          ]
                          (Type.namedWith
                               [ "Effect", "Http" ]
                               "Resolver"
                               [ Type.var "restrictions"
                               , Type.namedWith
                                   [ "OpenApi", "Common" ]
                                   "Error"
                                   [ Type.var "err"
                                   , Type.namedWith [ "Bytes" ] "Bytes" []
                                   ]
                               , Type.namedWith [ "Bytes" ] "Bytes" []
                               ]
                          )
                     )
             }
        )
        [ bytesResolverCustomEffectArg_ ]


{-| expectBytesCustomEffect: 
    (Result.Result (OpenApi.Common.Error err Bytes.Bytes) Bytes.Bytes -> msg)
    -> Dict.Dict String (Json.Decode.Decoder err)
    -> Effect.Http.Expect msg
-}
expectBytesCustomEffect :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
expectBytesCustomEffect expectBytesCustomEffectArg_ expectBytesCustomEffectArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "OpenApi", "Common" ]
             , name = "expectBytesCustomEffect"
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
                                        [ Type.var "err"
                                        , Type.namedWith [ "Bytes" ] "Bytes" []
                                        ]
                                    , Type.namedWith [ "Bytes" ] "Bytes" []
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
            "expectBytesCustomEffectUnpack"
            expectBytesCustomEffectArg_
        , expectBytesCustomEffectArg_0
        ]


{-| stringResolverCustomEffect: 
    Dict.Dict String (Json.Decode.Decoder err)
    -> Effect.Http.Resolver restrictions (OpenApi.Common.Error err String) String
-}
stringResolverCustomEffect : Elm.Expression -> Elm.Expression
stringResolverCustomEffect stringResolverCustomEffectArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "OpenApi", "Common" ]
             , name = "stringResolverCustomEffect"
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
                          ]
                          (Type.namedWith
                               [ "Effect", "Http" ]
                               "Resolver"
                               [ Type.var "restrictions"
                               , Type.namedWith
                                   [ "OpenApi", "Common" ]
                                   "Error"
                                   [ Type.var "err", Type.string ]
                               , Type.string
                               ]
                          )
                     )
             }
        )
        [ stringResolverCustomEffectArg_ ]


{-| expectStringCustomEffect: 
    (Result.Result (OpenApi.Common.Error err String) String -> msg)
    -> Dict.Dict String (Json.Decode.Decoder err)
    -> Effect.Http.Expect msg
-}
expectStringCustomEffect :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
expectStringCustomEffect expectStringCustomEffectArg_ expectStringCustomEffectArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "OpenApi", "Common" ]
             , name = "expectStringCustomEffect"
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
                                    , Type.string
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
            "expectStringCustomEffectUnpack"
            expectStringCustomEffectArg_
        , expectStringCustomEffectArg_0
        ]


{-| jsonResolverCustomEffect: 
    Dict.Dict String (Json.Decode.Decoder err)
    -> Json.Decode.Decoder success
    -> Effect.Http.Resolver restrictions (OpenApi.Common.Error err String) success
-}
jsonResolverCustomEffect : Elm.Expression -> Elm.Expression -> Elm.Expression
jsonResolverCustomEffect jsonResolverCustomEffectArg_ jsonResolverCustomEffectArg_0 =
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
        [ jsonResolverCustomEffectArg_, jsonResolverCustomEffectArg_0 ]


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
expectJsonCustomEffect expectJsonCustomEffectArg_ expectJsonCustomEffectArg_0 expectJsonCustomEffectArg_1 =
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
            expectJsonCustomEffectArg_
        , expectJsonCustomEffectArg_0
        , expectJsonCustomEffectArg_1
        ]


{-| bytesResolverCustom: 
    Dict.Dict String (Json.Decode.Decoder err)
    -> Http.Resolver (OpenApi.Common.Error err Bytes.Bytes) Bytes.Bytes
-}
bytesResolverCustom : Elm.Expression -> Elm.Expression
bytesResolverCustom bytesResolverCustomArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "OpenApi", "Common" ]
             , name = "bytesResolverCustom"
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
                          ]
                          (Type.namedWith
                               [ "Http" ]
                               "Resolver"
                               [ Type.namedWith
                                   [ "OpenApi", "Common" ]
                                   "Error"
                                   [ Type.var "err"
                                   , Type.namedWith [ "Bytes" ] "Bytes" []
                                   ]
                               , Type.namedWith [ "Bytes" ] "Bytes" []
                               ]
                          )
                     )
             }
        )
        [ bytesResolverCustomArg_ ]


{-| expectBytesCustom: 
    (Result.Result (OpenApi.Common.Error err Bytes.Bytes) Bytes.Bytes -> msg)
    -> Dict.Dict String (Json.Decode.Decoder err)
    -> Http.Expect msg
-}
expectBytesCustom :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
expectBytesCustom expectBytesCustomArg_ expectBytesCustomArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "OpenApi", "Common" ]
             , name = "expectBytesCustom"
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
                                        [ Type.var "err"
                                        , Type.namedWith [ "Bytes" ] "Bytes" []
                                        ]
                                    , Type.namedWith [ "Bytes" ] "Bytes" []
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
                          ]
                          (Type.namedWith [ "Http" ] "Expect" [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "expectBytesCustomUnpack" expectBytesCustomArg_
        , expectBytesCustomArg_0
        ]


{-| stringResolverCustom: 
    Dict.Dict String (Json.Decode.Decoder err)
    -> Http.Resolver (OpenApi.Common.Error err String) String
-}
stringResolverCustom : Elm.Expression -> Elm.Expression
stringResolverCustom stringResolverCustomArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "OpenApi", "Common" ]
             , name = "stringResolverCustom"
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
                          ]
                          (Type.namedWith
                               [ "Http" ]
                               "Resolver"
                               [ Type.namedWith
                                   [ "OpenApi", "Common" ]
                                   "Error"
                                   [ Type.var "err", Type.string ]
                               , Type.string
                               ]
                          )
                     )
             }
        )
        [ stringResolverCustomArg_ ]


{-| expectStringCustom: 
    (Result.Result (OpenApi.Common.Error err String) String -> msg)
    -> Dict.Dict String (Json.Decode.Decoder err)
    -> Http.Expect msg
-}
expectStringCustom :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
expectStringCustom expectStringCustomArg_ expectStringCustomArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "OpenApi", "Common" ]
             , name = "expectStringCustom"
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
                                    , Type.string
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
                          ]
                          (Type.namedWith [ "Http" ] "Expect" [ Type.var "msg" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "expectStringCustomUnpack" expectStringCustomArg_
        , expectStringCustomArg_0
        ]


{-| jsonResolverCustom: 
    Dict.Dict String (Json.Decode.Decoder err)
    -> Json.Decode.Decoder success
    -> Http.Resolver (OpenApi.Common.Error err String) success
-}
jsonResolverCustom : Elm.Expression -> Elm.Expression -> Elm.Expression
jsonResolverCustom jsonResolverCustomArg_ jsonResolverCustomArg_0 =
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
        [ jsonResolverCustomArg_, jsonResolverCustomArg_0 ]


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
expectJsonCustom expectJsonCustomArg_ expectJsonCustomArg_0 expectJsonCustomArg_1 =
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
        [ Elm.functionReduced "expectJsonCustomUnpack" expectJsonCustomArg_
        , expectJsonCustomArg_0
        , expectJsonCustomArg_1
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
                [ Elm.Case.branch
                    (Elm.Arg.customType "Null" nullableTags.null)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "Present"
                       nullableTags.present |> Elm.Arg.item
                                                     (Elm.Arg.varWith
                                                            "value"
                                                            (Type.var "value")
                                                     )
                    )
                    Basics.identity
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
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "BadUrl"
                       errorTags.badUrl |> Elm.Arg.item
                                                 (Elm.Arg.varWith
                                                        "arg_0"
                                                        Type.string
                                                 )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Timeout" errorTags.timeout)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "NetworkError" errorTags.networkError)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "KnownBadStatus"
                       errorTags.knownBadStatus |> Elm.Arg.item
                                                         (Elm.Arg.varWith
                                                                "arg_0"
                                                                Type.int
                                                         ) |> Elm.Arg.item
                                                                    (Elm.Arg.varWith
                                                                           "err"
                                                                           (Type.var
                                                                                  "err"
                                                                           )
                                                                    )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "UnknownBadStatus"
                       errorTags.unknownBadStatus |> Elm.Arg.item
                                                           (Elm.Arg.varWith
                                                                  "httpMetadata"
                                                                  (Type.namedWith
                                                                         [ "Http"
                                                                         ]
                                                                         "Metadata"
                                                                         []
                                                                  )
                                                           ) |> Elm.Arg.item
                                                                      (Elm.Arg.varWith
                                                                             "body"
                                                                             (Type.var
                                                                                    "body"
                                                                             )
                                                                      )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "BadErrorBody"
                       errorTags.badErrorBody |> Elm.Arg.item
                                                       (Elm.Arg.varWith
                                                              "httpMetadata"
                                                              (Type.namedWith
                                                                     [ "Http" ]
                                                                     "Metadata"
                                                                     []
                                                              )
                                                       ) |> Elm.Arg.item
                                                                  (Elm.Arg.varWith
                                                                         "body"
                                                                         (Type.var
                                                                                "body"
                                                                         )
                                                                  )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "BadBody"
                       errorTags.badBody |> Elm.Arg.item
                                                  (Elm.Arg.varWith
                                                         "httpMetadata"
                                                         (Type.namedWith
                                                                [ "Http" ]
                                                                "Metadata"
                                                                []
                                                         )
                                                  ) |> Elm.Arg.item
                                                             (Elm.Arg.varWith
                                                                    "body"
                                                                    (Type.var
                                                                           "body"
                                                                    )
                                                             )
                    )
                    Basics.identity
                ]
    }


call_ :
    { jsonDecodeAndMap : Elm.Expression -> Elm.Expression -> Elm.Expression
    , decodeOptionalField : Elm.Expression -> Elm.Expression -> Elm.Expression
    , bytesResolverCustomEffect : Elm.Expression -> Elm.Expression
    , expectBytesCustomEffect :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , stringResolverCustomEffect : Elm.Expression -> Elm.Expression
    , expectStringCustomEffect :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , jsonResolverCustomEffect :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectJsonCustomEffect :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , bytesResolverCustom : Elm.Expression -> Elm.Expression
    , expectBytesCustom : Elm.Expression -> Elm.Expression -> Elm.Expression
    , stringResolverCustom : Elm.Expression -> Elm.Expression
    , expectStringCustom : Elm.Expression -> Elm.Expression -> Elm.Expression
    , jsonResolverCustom : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectJsonCustom :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { jsonDecodeAndMap =
        \jsonDecodeAndMapArg_ jsonDecodeAndMapArg_0 ->
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
                [ jsonDecodeAndMapArg_, jsonDecodeAndMapArg_0 ]
    , decodeOptionalField =
        \decodeOptionalFieldArg_ decodeOptionalFieldArg_0 ->
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
                [ decodeOptionalFieldArg_, decodeOptionalFieldArg_0 ]
    , bytesResolverCustomEffect =
        \bytesResolverCustomEffectArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "bytesResolverCustomEffect"
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
                                  ]
                                  (Type.namedWith
                                       [ "Effect", "Http" ]
                                       "Resolver"
                                       [ Type.var "restrictions"
                                       , Type.namedWith
                                           [ "OpenApi", "Common" ]
                                           "Error"
                                           [ Type.var "err"
                                           , Type.namedWith
                                                 [ "Bytes" ]
                                                 "Bytes"
                                                 []
                                           ]
                                       , Type.namedWith [ "Bytes" ] "Bytes" []
                                       ]
                                  )
                             )
                     }
                )
                [ bytesResolverCustomEffectArg_ ]
    , expectBytesCustomEffect =
        \expectBytesCustomEffectArg_ expectBytesCustomEffectArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "expectBytesCustomEffect"
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
                                                [ Type.var "err"
                                                , Type.namedWith
                                                      [ "Bytes" ]
                                                      "Bytes"
                                                      []
                                                ]
                                            , Type.namedWith
                                                [ "Bytes" ]
                                                "Bytes"
                                                []
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
                                  ]
                                  (Type.namedWith
                                       [ "Effect", "Http" ]
                                       "Expect"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ expectBytesCustomEffectArg_, expectBytesCustomEffectArg_0 ]
    , stringResolverCustomEffect =
        \stringResolverCustomEffectArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "stringResolverCustomEffect"
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
                                  ]
                                  (Type.namedWith
                                       [ "Effect", "Http" ]
                                       "Resolver"
                                       [ Type.var "restrictions"
                                       , Type.namedWith
                                           [ "OpenApi", "Common" ]
                                           "Error"
                                           [ Type.var "err", Type.string ]
                                       , Type.string
                                       ]
                                  )
                             )
                     }
                )
                [ stringResolverCustomEffectArg_ ]
    , expectStringCustomEffect =
        \expectStringCustomEffectArg_ expectStringCustomEffectArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "expectStringCustomEffect"
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
                                            , Type.string
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
                                  ]
                                  (Type.namedWith
                                       [ "Effect", "Http" ]
                                       "Expect"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ expectStringCustomEffectArg_, expectStringCustomEffectArg_0 ]
    , jsonResolverCustomEffect =
        \jsonResolverCustomEffectArg_ jsonResolverCustomEffectArg_0 ->
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
                [ jsonResolverCustomEffectArg_, jsonResolverCustomEffectArg_0 ]
    , expectJsonCustomEffect =
        \expectJsonCustomEffectArg_ expectJsonCustomEffectArg_0 expectJsonCustomEffectArg_1 ->
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
                [ expectJsonCustomEffectArg_
                , expectJsonCustomEffectArg_0
                , expectJsonCustomEffectArg_1
                ]
    , bytesResolverCustom =
        \bytesResolverCustomArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "bytesResolverCustom"
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
                                  ]
                                  (Type.namedWith
                                       [ "Http" ]
                                       "Resolver"
                                       [ Type.namedWith
                                           [ "OpenApi", "Common" ]
                                           "Error"
                                           [ Type.var "err"
                                           , Type.namedWith
                                                 [ "Bytes" ]
                                                 "Bytes"
                                                 []
                                           ]
                                       , Type.namedWith [ "Bytes" ] "Bytes" []
                                       ]
                                  )
                             )
                     }
                )
                [ bytesResolverCustomArg_ ]
    , expectBytesCustom =
        \expectBytesCustomArg_ expectBytesCustomArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "expectBytesCustom"
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
                                                [ Type.var "err"
                                                , Type.namedWith
                                                      [ "Bytes" ]
                                                      "Bytes"
                                                      []
                                                ]
                                            , Type.namedWith
                                                [ "Bytes" ]
                                                "Bytes"
                                                []
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
                                  ]
                                  (Type.namedWith
                                       [ "Http" ]
                                       "Expect"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ expectBytesCustomArg_, expectBytesCustomArg_0 ]
    , stringResolverCustom =
        \stringResolverCustomArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "stringResolverCustom"
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
                                  ]
                                  (Type.namedWith
                                       [ "Http" ]
                                       "Resolver"
                                       [ Type.namedWith
                                           [ "OpenApi", "Common" ]
                                           "Error"
                                           [ Type.var "err", Type.string ]
                                       , Type.string
                                       ]
                                  )
                             )
                     }
                )
                [ stringResolverCustomArg_ ]
    , expectStringCustom =
        \expectStringCustomArg_ expectStringCustomArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "OpenApi", "Common" ]
                     , name = "expectStringCustom"
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
                                            , Type.string
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
                                  ]
                                  (Type.namedWith
                                       [ "Http" ]
                                       "Expect"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ expectStringCustomArg_, expectStringCustomArg_0 ]
    , jsonResolverCustom =
        \jsonResolverCustomArg_ jsonResolverCustomArg_0 ->
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
                [ jsonResolverCustomArg_, jsonResolverCustomArg_0 ]
    , expectJsonCustom =
        \expectJsonCustomArg_ expectJsonCustomArg_0 expectJsonCustomArg_1 ->
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
                [ expectJsonCustomArg_
                , expectJsonCustomArg_0
                , expectJsonCustomArg_1
                ]
    }


values_ :
    { jsonDecodeAndMap : Elm.Expression
    , decodeOptionalField : Elm.Expression
    , bytesResolverCustomEffect : Elm.Expression
    , expectBytesCustomEffect : Elm.Expression
    , stringResolverCustomEffect : Elm.Expression
    , expectStringCustomEffect : Elm.Expression
    , jsonResolverCustomEffect : Elm.Expression
    , expectJsonCustomEffect : Elm.Expression
    , bytesResolverCustom : Elm.Expression
    , expectBytesCustom : Elm.Expression
    , stringResolverCustom : Elm.Expression
    , expectStringCustom : Elm.Expression
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
    , bytesResolverCustomEffect =
        Elm.value
            { importFrom = [ "OpenApi", "Common" ]
            , name = "bytesResolverCustomEffect"
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
                         ]
                         (Type.namedWith
                              [ "Effect", "Http" ]
                              "Resolver"
                              [ Type.var "restrictions"
                              , Type.namedWith
                                  [ "OpenApi", "Common" ]
                                  "Error"
                                  [ Type.var "err"
                                  , Type.namedWith [ "Bytes" ] "Bytes" []
                                  ]
                              , Type.namedWith [ "Bytes" ] "Bytes" []
                              ]
                         )
                    )
            }
    , expectBytesCustomEffect =
        Elm.value
            { importFrom = [ "OpenApi", "Common" ]
            , name = "expectBytesCustomEffect"
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
                                       [ Type.var "err"
                                       , Type.namedWith [ "Bytes" ] "Bytes" []
                                       ]
                                   , Type.namedWith [ "Bytes" ] "Bytes" []
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
                         ]
                         (Type.namedWith
                              [ "Effect", "Http" ]
                              "Expect"
                              [ Type.var "msg" ]
                         )
                    )
            }
    , stringResolverCustomEffect =
        Elm.value
            { importFrom = [ "OpenApi", "Common" ]
            , name = "stringResolverCustomEffect"
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
                         ]
                         (Type.namedWith
                              [ "Effect", "Http" ]
                              "Resolver"
                              [ Type.var "restrictions"
                              , Type.namedWith
                                  [ "OpenApi", "Common" ]
                                  "Error"
                                  [ Type.var "err", Type.string ]
                              , Type.string
                              ]
                         )
                    )
            }
    , expectStringCustomEffect =
        Elm.value
            { importFrom = [ "OpenApi", "Common" ]
            , name = "expectStringCustomEffect"
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
                                   , Type.string
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
                         ]
                         (Type.namedWith
                              [ "Effect", "Http" ]
                              "Expect"
                              [ Type.var "msg" ]
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
    , bytesResolverCustom =
        Elm.value
            { importFrom = [ "OpenApi", "Common" ]
            , name = "bytesResolverCustom"
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
                         ]
                         (Type.namedWith
                              [ "Http" ]
                              "Resolver"
                              [ Type.namedWith
                                  [ "OpenApi", "Common" ]
                                  "Error"
                                  [ Type.var "err"
                                  , Type.namedWith [ "Bytes" ] "Bytes" []
                                  ]
                              , Type.namedWith [ "Bytes" ] "Bytes" []
                              ]
                         )
                    )
            }
    , expectBytesCustom =
        Elm.value
            { importFrom = [ "OpenApi", "Common" ]
            , name = "expectBytesCustom"
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
                                       [ Type.var "err"
                                       , Type.namedWith [ "Bytes" ] "Bytes" []
                                       ]
                                   , Type.namedWith [ "Bytes" ] "Bytes" []
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
                         ]
                         (Type.namedWith [ "Http" ] "Expect" [ Type.var "msg" ])
                    )
            }
    , stringResolverCustom =
        Elm.value
            { importFrom = [ "OpenApi", "Common" ]
            , name = "stringResolverCustom"
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
                         ]
                         (Type.namedWith
                              [ "Http" ]
                              "Resolver"
                              [ Type.namedWith
                                  [ "OpenApi", "Common" ]
                                  "Error"
                                  [ Type.var "err", Type.string ]
                              , Type.string
                              ]
                         )
                    )
            }
    , expectStringCustom =
        Elm.value
            { importFrom = [ "OpenApi", "Common" ]
            , name = "expectStringCustom"
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
                                   , Type.string
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
                         ]
                         (Type.namedWith [ "Http" ] "Expect" [ Type.var "msg" ])
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