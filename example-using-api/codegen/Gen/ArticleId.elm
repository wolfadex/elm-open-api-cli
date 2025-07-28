module Gen.ArticleId exposing
    ( moduleName_, encode, decode, parse, toString, annotation_
    , call_, values_
    )

{-|
# Generated bindings for ArticleId

@docs moduleName_, encode, decode, parse, toString, annotation_
@docs call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "ArticleId" ]


{-| encode: ArticleId.ArticleId -> Json.Encode.Value -}
encode : Elm.Expression -> Elm.Expression
encode encodeArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "ArticleId" ]
             , name = "encode"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "ArticleId" ] "ArticleId" [] ]
                          (Type.namedWith [ "Json", "Encode" ] "Value" [])
                     )
             }
        )
        [ encodeArg_ ]


{-| decode: Json.Decode.Decoder ArticleId.ArticleId -}
decode : Elm.Expression
decode =
    Elm.value
        { importFrom = [ "ArticleId" ]
        , name = "decode"
        , annotation =
            Just
                (Type.namedWith
                     [ "Json", "Decode" ]
                     "Decoder"
                     [ Type.namedWith [ "ArticleId" ] "ArticleId" [] ]
                )
        }


{-| parse: String -> Result.Result String ArticleId.ArticleId -}
parse : String -> Elm.Expression
parse parseArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "ArticleId" ]
             , name = "parse"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "Result" ]
                               "Result"
                               [ Type.string
                               , Type.namedWith [ "ArticleId" ] "ArticleId" []
                               ]
                          )
                     )
             }
        )
        [ Elm.string parseArg_ ]


{-| toString: ArticleId.ArticleId -> String -}
toString : Elm.Expression -> Elm.Expression
toString toStringArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "ArticleId" ]
             , name = "toString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "ArticleId" ] "ArticleId" [] ]
                          Type.string
                     )
             }
        )
        [ toStringArg_ ]


annotation_ : { articleId : Type.Annotation }
annotation_ =
    { articleId = Type.namedWith [ "ArticleId" ] "ArticleId" [] }


call_ :
    { encode : Elm.Expression -> Elm.Expression
    , parse : Elm.Expression -> Elm.Expression
    , toString : Elm.Expression -> Elm.Expression
    }
call_ =
    { encode =
        \encodeArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "ArticleId" ]
                     , name = "encode"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "ArticleId" ]
                                      "ArticleId"
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
                [ encodeArg_ ]
    , parse =
        \parseArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "ArticleId" ]
                     , name = "parse"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Result" ]
                                       "Result"
                                       [ Type.string
                                       , Type.namedWith
                                           [ "ArticleId" ]
                                           "ArticleId"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ parseArg_ ]
    , toString =
        \toStringArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "ArticleId" ]
                     , name = "toString"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "ArticleId" ]
                                      "ArticleId"
                                      []
                                  ]
                                  Type.string
                             )
                     }
                )
                [ toStringArg_ ]
    }


values_ :
    { encode : Elm.Expression
    , decode : Elm.Expression
    , parse : Elm.Expression
    , toString : Elm.Expression
    }
values_ =
    { encode =
        Elm.value
            { importFrom = [ "ArticleId" ]
            , name = "encode"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "ArticleId" ] "ArticleId" [] ]
                         (Type.namedWith [ "Json", "Encode" ] "Value" [])
                    )
            }
    , decode =
        Elm.value
            { importFrom = [ "ArticleId" ]
            , name = "decode"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Json", "Decode" ]
                         "Decoder"
                         [ Type.namedWith [ "ArticleId" ] "ArticleId" [] ]
                    )
            }
    , parse =
        Elm.value
            { importFrom = [ "ArticleId" ]
            , name = "parse"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "Result" ]
                              "Result"
                              [ Type.string
                              , Type.namedWith [ "ArticleId" ] "ArticleId" []
                              ]
                         )
                    )
            }
    , toString =
        Elm.value
            { importFrom = [ "ArticleId" ]
            , name = "toString"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "ArticleId" ] "ArticleId" [] ]
                         Type.string
                    )
            }
    }