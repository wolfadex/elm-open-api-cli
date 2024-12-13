module Gen.FatalError exposing
    ( moduleName_, build, fromString, recoverable, annotation_, call_
    , values_
    )

{-|
# Generated bindings for FatalError

@docs moduleName_, build, fromString, recoverable, annotation_, call_
@docs values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "FatalError" ]


{-| Create a FatalError with a title and body.

build: { title : String, body : String } -> FatalError.FatalError
-}
build : { title : String, body : String } -> Elm.Expression
build buildArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "FatalError" ]
             , name = "build"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "title", Type.string )
                              , ( "body", Type.string )
                              ]
                          ]
                          (Type.namedWith [ "FatalError" ] "FatalError" [])
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "title" (Elm.string buildArg_.title)
            , Tuple.pair "body" (Elm.string buildArg_.body)
            ]
        ]


{-| fromString: String -> FatalError.FatalError -}
fromString : String -> Elm.Expression
fromString fromStringArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "FatalError" ]
             , name = "fromString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith [ "FatalError" ] "FatalError" [])
                     )
             }
        )
        [ Elm.string fromStringArg_ ]


{-| recoverable: 
    { title : String, body : String }
    -> error
    -> { fatal : FatalError.FatalError, recoverable : error }
-}
recoverable :
    { title : String, body : String } -> Elm.Expression -> Elm.Expression
recoverable recoverableArg_ recoverableArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "FatalError" ]
             , name = "recoverable"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "title", Type.string )
                              , ( "body", Type.string )
                              ]
                          , Type.var "error"
                          ]
                          (Type.record
                               [ ( "fatal"
                                 , Type.namedWith
                                       [ "FatalError" ]
                                       "FatalError"
                                       []
                                 )
                               , ( "recoverable", Type.var "error" )
                               ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "title" (Elm.string recoverableArg_.title)
            , Tuple.pair "body" (Elm.string recoverableArg_.body)
            ]
        , recoverableArg_0
        ]


annotation_ : { fatalError : Type.Annotation }
annotation_ =
    { fatalError =
        Type.alias
            moduleName_
            "FatalError"
            []
            (Type.namedWith
                 [ "Pages", "Internal", "FatalError" ]
                 "FatalError"
                 []
            )
    }


call_ :
    { build : Elm.Expression -> Elm.Expression
    , fromString : Elm.Expression -> Elm.Expression
    , recoverable : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { build =
        \buildArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "FatalError" ]
                     , name = "build"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "title", Type.string )
                                      , ( "body", Type.string )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "FatalError" ]
                                       "FatalError"
                                       []
                                  )
                             )
                     }
                )
                [ buildArg_ ]
    , fromString =
        \fromStringArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "FatalError" ]
                     , name = "fromString"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "FatalError" ]
                                       "FatalError"
                                       []
                                  )
                             )
                     }
                )
                [ fromStringArg_ ]
    , recoverable =
        \recoverableArg_ recoverableArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "FatalError" ]
                     , name = "recoverable"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "title", Type.string )
                                      , ( "body", Type.string )
                                      ]
                                  , Type.var "error"
                                  ]
                                  (Type.record
                                       [ ( "fatal"
                                         , Type.namedWith
                                               [ "FatalError" ]
                                               "FatalError"
                                               []
                                         )
                                       , ( "recoverable", Type.var "error" )
                                       ]
                                  )
                             )
                     }
                )
                [ recoverableArg_, recoverableArg_0 ]
    }


values_ :
    { build : Elm.Expression
    , fromString : Elm.Expression
    , recoverable : Elm.Expression
    }
values_ =
    { build =
        Elm.value
            { importFrom = [ "FatalError" ]
            , name = "build"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "title", Type.string )
                             , ( "body", Type.string )
                             ]
                         ]
                         (Type.namedWith [ "FatalError" ] "FatalError" [])
                    )
            }
    , fromString =
        Elm.value
            { importFrom = [ "FatalError" ]
            , name = "fromString"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith [ "FatalError" ] "FatalError" [])
                    )
            }
    , recoverable =
        Elm.value
            { importFrom = [ "FatalError" ]
            , name = "recoverable"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "title", Type.string )
                             , ( "body", Type.string )
                             ]
                         , Type.var "error"
                         ]
                         (Type.record
                              [ ( "fatal"
                                , Type.namedWith
                                      [ "FatalError" ]
                                      "FatalError"
                                      []
                                )
                              , ( "recoverable", Type.var "error" )
                              ]
                         )
                    )
            }
    }