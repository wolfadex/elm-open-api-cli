module Gen.Data.Id exposing
    ( moduleName_, test_fromString, encode, parse, decode, toString
    , annotation_, call_, values_
    )

{-|
# Generated bindings for Data.Id

@docs moduleName_, test_fromString, encode, parse, decode, toString
@docs annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Data", "Id" ]


{-| test_fromString: String -> Data.Id.Id kind -}
test_fromString : String -> Elm.Expression
test_fromString test_fromStringArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Data", "Id" ]
             , name = "test_fromString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "Data", "Id" ]
                               "Id"
                               [ Type.var "kind" ]
                          )
                     )
             }
        )
        [ Elm.string test_fromStringArg_ ]


{-| encode: Data.Id.Id kind -> Json.Encode.Value -}
encode : Elm.Expression -> Elm.Expression
encode encodeArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Data", "Id" ]
             , name = "encode"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Data", "Id" ]
                              "Id"
                              [ Type.var "kind" ]
                          ]
                          (Type.namedWith [ "Json", "Encode" ] "Value" [])
                     )
             }
        )
        [ encodeArg_ ]


{-| parse: String -> Result.Result String (Data.Id.Id kind) -}
parse : String -> Elm.Expression
parse parseArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Data", "Id" ]
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
                                   [ "Data", "Id" ]
                                   "Id"
                                   [ Type.var "kind" ]
                               ]
                          )
                     )
             }
        )
        [ Elm.string parseArg_ ]


{-| decode: Json.Decode.Decoder (Data.Id.Id kind) -}
decode : Elm.Expression
decode =
    Elm.value
        { importFrom = [ "Data", "Id" ]
        , name = "decode"
        , annotation =
            Just
                (Type.namedWith
                     [ "Json", "Decode" ]
                     "Decoder"
                     [ Type.namedWith [ "Data", "Id" ] "Id" [ Type.var "kind" ]
                     ]
                )
        }


{-| toString: Data.Id.Id kind -> String -}
toString : Elm.Expression -> Elm.Expression
toString toStringArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Data", "Id" ]
             , name = "toString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Data", "Id" ]
                              "Id"
                              [ Type.var "kind" ]
                          ]
                          Type.string
                     )
             }
        )
        [ toStringArg_ ]


annotation_ :
    { userId : Type.Annotation
    , threadId : Type.Annotation
    , messageId : Type.Annotation
    , id : Type.Annotation -> Type.Annotation
    }
annotation_ =
    { userId =
        Type.alias
            moduleName_
            "UserId"
            []
            (Type.namedWith
                 [ "Data", "Id" ]
                 "Id"
                 [ Type.namedWith [ "Data", "Id", "Internal" ] "UserTag" [] ]
            )
    , threadId =
        Type.alias
            moduleName_
            "ThreadId"
            []
            (Type.namedWith
                 [ "Data", "Id" ]
                 "Id"
                 [ Type.namedWith [ "Data", "Id", "Internal" ] "ThreadTag" [] ]
            )
    , messageId =
        Type.alias
            moduleName_
            "MessageId"
            []
            (Type.namedWith
                 [ "Data", "Id" ]
                 "Id"
                 [ Type.namedWith [ "Data", "Id", "Internal" ] "MessageTag" [] ]
            )
    , id = \idArg0 -> Type.namedWith [ "Data", "Id" ] "Id" [ idArg0 ]
    }


call_ :
    { test_fromString : Elm.Expression -> Elm.Expression
    , encode : Elm.Expression -> Elm.Expression
    , parse : Elm.Expression -> Elm.Expression
    , toString : Elm.Expression -> Elm.Expression
    }
call_ =
    { test_fromString =
        \test_fromStringArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Data", "Id" ]
                     , name = "test_fromString"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Data", "Id" ]
                                       "Id"
                                       [ Type.var "kind" ]
                                  )
                             )
                     }
                )
                [ test_fromStringArg_ ]
    , encode =
        \encodeArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Data", "Id" ]
                     , name = "encode"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Data", "Id" ]
                                      "Id"
                                      [ Type.var "kind" ]
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
                     { importFrom = [ "Data", "Id" ]
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
                                           [ "Data", "Id" ]
                                           "Id"
                                           [ Type.var "kind" ]
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
                     { importFrom = [ "Data", "Id" ]
                     , name = "toString"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Data", "Id" ]
                                      "Id"
                                      [ Type.var "kind" ]
                                  ]
                                  Type.string
                             )
                     }
                )
                [ toStringArg_ ]
    }


values_ :
    { test_fromString : Elm.Expression
    , encode : Elm.Expression
    , parse : Elm.Expression
    , decode : Elm.Expression
    , toString : Elm.Expression
    }
values_ =
    { test_fromString =
        Elm.value
            { importFrom = [ "Data", "Id" ]
            , name = "test_fromString"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "Data", "Id" ]
                              "Id"
                              [ Type.var "kind" ]
                         )
                    )
            }
    , encode =
        Elm.value
            { importFrom = [ "Data", "Id" ]
            , name = "encode"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Data", "Id" ]
                             "Id"
                             [ Type.var "kind" ]
                         ]
                         (Type.namedWith [ "Json", "Encode" ] "Value" [])
                    )
            }
    , parse =
        Elm.value
            { importFrom = [ "Data", "Id" ]
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
                                  [ "Data", "Id" ]
                                  "Id"
                                  [ Type.var "kind" ]
                              ]
                         )
                    )
            }
    , decode =
        Elm.value
            { importFrom = [ "Data", "Id" ]
            , name = "decode"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Json", "Decode" ]
                         "Decoder"
                         [ Type.namedWith
                             [ "Data", "Id" ]
                             "Id"
                             [ Type.var "kind" ]
                         ]
                    )
            }
    , toString =
        Elm.value
            { importFrom = [ "Data", "Id" ]
            , name = "toString"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Data", "Id" ]
                             "Id"
                             [ Type.var "kind" ]
                         ]
                         Type.string
                    )
            }
    }