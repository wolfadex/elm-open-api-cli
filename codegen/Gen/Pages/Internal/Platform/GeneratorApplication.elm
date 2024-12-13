module Gen.Pages.Internal.Platform.GeneratorApplication exposing
    ( moduleName_, init, requestDecoder, update, app, annotation_
    , make_, caseOf_, call_, values_
    )

{-|
# Generated bindings for Pages.Internal.Platform.GeneratorApplication

@docs moduleName_, init, requestDecoder, update, app, annotation_
@docs make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Internal", "Platform", "GeneratorApplication" ]


{-| init: 
    BackendTask.BackendTask FatalError.FatalError ()
    -> Cli.Program.FlagsIncludingArgv Pages.Internal.Platform.GeneratorApplication.Flags
    -> ( Pages.Internal.Platform.GeneratorApplication.Model, Pages.Internal.Platform.Effect.Effect )
-}
init : Elm.Expression -> Elm.Expression -> Elm.Expression
init initArg_ initArg_0 =
    Elm.apply
        (Elm.value
             { importFrom =
                 [ "Pages", "Internal", "Platform", "GeneratorApplication" ]
             , name = "init"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.unit
                              ]
                          , Type.namedWith
                              [ "Cli", "Program" ]
                              "FlagsIncludingArgv"
                              [ Type.namedWith
                                    [ "Pages"
                                    , "Internal"
                                    , "Platform"
                                    , "GeneratorApplication"
                                    ]
                                    "Flags"
                                    []
                              ]
                          ]
                          (Type.tuple
                               (Type.namedWith
                                    [ "Pages"
                                    , "Internal"
                                    , "Platform"
                                    , "GeneratorApplication"
                                    ]
                                    "Model"
                                    []
                               )
                               (Type.namedWith
                                    [ "Pages"
                                    , "Internal"
                                    , "Platform"
                                    , "Effect"
                                    ]
                                    "Effect"
                                    []
                               )
                          )
                     )
             }
        )
        [ initArg_, initArg_0 ]


{-| requestDecoder: Json.Decode.Decoder Pages.StaticHttp.Request.Request -}
requestDecoder : Elm.Expression
requestDecoder =
    Elm.value
        { importFrom =
            [ "Pages", "Internal", "Platform", "GeneratorApplication" ]
        , name = "requestDecoder"
        , annotation =
            Just
                (Type.namedWith
                     [ "Json", "Decode" ]
                     "Decoder"
                     [ Type.namedWith
                         [ "Pages", "StaticHttp", "Request" ]
                         "Request"
                         []
                     ]
                )
        }


{-| update: 
    Pages.Internal.Platform.GeneratorApplication.Msg
    -> Pages.Internal.Platform.GeneratorApplication.Model
    -> ( Pages.Internal.Platform.GeneratorApplication.Model, Pages.Internal.Platform.Effect.Effect )
-}
update : Elm.Expression -> Elm.Expression -> Elm.Expression
update updateArg_ updateArg_0 =
    Elm.apply
        (Elm.value
             { importFrom =
                 [ "Pages", "Internal", "Platform", "GeneratorApplication" ]
             , name = "update"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages"
                              , "Internal"
                              , "Platform"
                              , "GeneratorApplication"
                              ]
                              "Msg"
                              []
                          , Type.namedWith
                              [ "Pages"
                              , "Internal"
                              , "Platform"
                              , "GeneratorApplication"
                              ]
                              "Model"
                              []
                          ]
                          (Type.tuple
                               (Type.namedWith
                                    [ "Pages"
                                    , "Internal"
                                    , "Platform"
                                    , "GeneratorApplication"
                                    ]
                                    "Model"
                                    []
                               )
                               (Type.namedWith
                                    [ "Pages"
                                    , "Internal"
                                    , "Platform"
                                    , "Effect"
                                    ]
                                    "Effect"
                                    []
                               )
                          )
                     )
             }
        )
        [ updateArg_, updateArg_0 ]


{-| app: 
    Pages.GeneratorProgramConfig.GeneratorProgramConfig
    -> Pages.Internal.Platform.GeneratorApplication.Program
-}
app : Elm.Expression -> Elm.Expression
app appArg_ =
    Elm.apply
        (Elm.value
             { importFrom =
                 [ "Pages", "Internal", "Platform", "GeneratorApplication" ]
             , name = "app"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "GeneratorProgramConfig" ]
                              "GeneratorProgramConfig"
                              []
                          ]
                          (Type.namedWith
                               [ "Pages"
                               , "Internal"
                               , "Platform"
                               , "GeneratorApplication"
                               ]
                               "Program"
                               []
                          )
                     )
             }
        )
        [ appArg_ ]


annotation_ :
    { program : Type.Annotation
    , flags : Type.Annotation
    , model : Type.Annotation
    , msg : Type.Annotation
    , jsonValue : Type.Annotation
    }
annotation_ =
    { program =
        Type.alias
            moduleName_
            "Program"
            []
            (Type.namedWith
                 [ "Cli", "Program" ]
                 "StatefulProgram"
                 [ Type.namedWith
                     [ "Pages", "Internal", "Platform", "GeneratorApplication" ]
                     "Model"
                     []
                 , Type.namedWith
                     [ "Pages", "Internal", "Platform", "GeneratorApplication" ]
                     "Msg"
                     []
                 , Type.namedWith
                     [ "BackendTask" ]
                     "BackendTask"
                     [ Type.namedWith [ "FatalError" ] "FatalError" []
                     , Type.unit
                     ]
                 , Type.namedWith
                     [ "Pages", "Internal", "Platform", "GeneratorApplication" ]
                     "Flags"
                     []
                 ]
            )
    , flags =
        Type.alias
            moduleName_
            "Flags"
            []
            (Type.record [ ( "compatibilityKey", Type.int ) ])
    , model =
        Type.alias
            moduleName_
            "Model"
            []
            (Type.record
                 [ ( "staticResponses"
                   , Type.namedWith
                         [ "BackendTask" ]
                         "BackendTask"
                         [ Type.namedWith [ "FatalError" ] "FatalError" []
                         , Type.unit
                         ]
                   )
                 , ( "errors"
                   , Type.list (Type.namedWith [ "BuildError" ] "BuildError" [])
                   )
                 ]
            )
    , msg =
        Type.namedWith
            [ "Pages", "Internal", "Platform", "GeneratorApplication" ]
            "Msg"
            []
    , jsonValue =
        Type.alias
            moduleName_
            "JsonValue"
            []
            (Type.namedWith [ "Json", "Decode" ] "Value" [])
    }


make_ :
    { flags : { compatibilityKey : Elm.Expression } -> Elm.Expression
    , model :
        { staticResponses : Elm.Expression, errors : Elm.Expression }
        -> Elm.Expression
    , gotDataBatch : Elm.Expression -> Elm.Expression
    , gotBuildError : Elm.Expression -> Elm.Expression
    }
make_ =
    { flags =
        \flags_args ->
            Elm.withType
                (Type.alias
                     [ "Pages", "Internal", "Platform", "GeneratorApplication" ]
                     "Flags"
                     []
                     (Type.record [ ( "compatibilityKey", Type.int ) ])
                )
                (Elm.record
                     [ Tuple.pair "compatibilityKey" flags_args.compatibilityKey
                     ]
                )
    , model =
        \model_args ->
            Elm.withType
                (Type.alias
                     [ "Pages", "Internal", "Platform", "GeneratorApplication" ]
                     "Model"
                     []
                     (Type.record
                          [ ( "staticResponses"
                            , Type.namedWith
                                  [ "BackendTask" ]
                                  "BackendTask"
                                  [ Type.namedWith
                                      [ "FatalError" ]
                                      "FatalError"
                                      []
                                  , Type.unit
                                  ]
                            )
                          , ( "errors"
                            , Type.list
                                  (Type.namedWith
                                       [ "BuildError" ]
                                       "BuildError"
                                       []
                                  )
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "staticResponses" model_args.staticResponses
                     , Tuple.pair "errors" model_args.errors
                     ]
                )
    , gotDataBatch =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom =
                         [ "Pages"
                         , "Internal"
                         , "Platform"
                         , "GeneratorApplication"
                         ]
                     , name = "GotDataBatch"
                     , annotation = Just (Type.namedWith [] "Msg" [])
                     }
                )
                [ ar0 ]
    , gotBuildError =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom =
                         [ "Pages"
                         , "Internal"
                         , "Platform"
                         , "GeneratorApplication"
                         ]
                     , name = "GotBuildError"
                     , annotation = Just (Type.namedWith [] "Msg" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ =
    { msg =
        \msgExpression msgTags ->
            Elm.Case.custom
                msgExpression
                (Type.namedWith
                     [ "Pages", "Internal", "Platform", "GeneratorApplication" ]
                     "Msg"
                     []
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "GotDataBatch"
                       msgTags.gotDataBatch |> Elm.Arg.item
                                                     (Elm.Arg.varWith
                                                            "jsonDecodeValue"
                                                            (Type.namedWith
                                                                   [ "Json"
                                                                   , "Decode"
                                                                   ]
                                                                   "Value"
                                                                   []
                                                            )
                                                     )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "GotBuildError"
                       msgTags.gotBuildError |> Elm.Arg.item
                                                      (Elm.Arg.varWith
                                                             "buildErrorBuildError"
                                                             (Type.namedWith
                                                                    [ "BuildError"
                                                                    ]
                                                                    "BuildError"
                                                                    []
                                                             )
                                                      )
                    )
                    Basics.identity
                ]
    }


call_ :
    { init : Elm.Expression -> Elm.Expression -> Elm.Expression
    , update : Elm.Expression -> Elm.Expression -> Elm.Expression
    , app : Elm.Expression -> Elm.Expression
    }
call_ =
    { init =
        \initArg_ initArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom =
                         [ "Pages"
                         , "Internal"
                         , "Platform"
                         , "GeneratorApplication"
                         ]
                     , name = "init"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.namedWith
                                            [ "FatalError" ]
                                            "FatalError"
                                            []
                                      , Type.unit
                                      ]
                                  , Type.namedWith
                                      [ "Cli", "Program" ]
                                      "FlagsIncludingArgv"
                                      [ Type.namedWith
                                            [ "Pages"
                                            , "Internal"
                                            , "Platform"
                                            , "GeneratorApplication"
                                            ]
                                            "Flags"
                                            []
                                      ]
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Pages"
                                            , "Internal"
                                            , "Platform"
                                            , "GeneratorApplication"
                                            ]
                                            "Model"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Pages"
                                            , "Internal"
                                            , "Platform"
                                            , "Effect"
                                            ]
                                            "Effect"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ initArg_, initArg_0 ]
    , update =
        \updateArg_ updateArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom =
                         [ "Pages"
                         , "Internal"
                         , "Platform"
                         , "GeneratorApplication"
                         ]
                     , name = "update"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages"
                                      , "Internal"
                                      , "Platform"
                                      , "GeneratorApplication"
                                      ]
                                      "Msg"
                                      []
                                  , Type.namedWith
                                      [ "Pages"
                                      , "Internal"
                                      , "Platform"
                                      , "GeneratorApplication"
                                      ]
                                      "Model"
                                      []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Pages"
                                            , "Internal"
                                            , "Platform"
                                            , "GeneratorApplication"
                                            ]
                                            "Model"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Pages"
                                            , "Internal"
                                            , "Platform"
                                            , "Effect"
                                            ]
                                            "Effect"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ updateArg_, updateArg_0 ]
    , app =
        \appArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom =
                         [ "Pages"
                         , "Internal"
                         , "Platform"
                         , "GeneratorApplication"
                         ]
                     , name = "app"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "GeneratorProgramConfig" ]
                                      "GeneratorProgramConfig"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Pages"
                                       , "Internal"
                                       , "Platform"
                                       , "GeneratorApplication"
                                       ]
                                       "Program"
                                       []
                                  )
                             )
                     }
                )
                [ appArg_ ]
    }


values_ :
    { init : Elm.Expression
    , requestDecoder : Elm.Expression
    , update : Elm.Expression
    , app : Elm.Expression
    }
values_ =
    { init =
        Elm.value
            { importFrom =
                [ "Pages", "Internal", "Platform", "GeneratorApplication" ]
            , name = "init"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.namedWith [ "FatalError" ] "FatalError" []
                             , Type.unit
                             ]
                         , Type.namedWith
                             [ "Cli", "Program" ]
                             "FlagsIncludingArgv"
                             [ Type.namedWith
                                   [ "Pages"
                                   , "Internal"
                                   , "Platform"
                                   , "GeneratorApplication"
                                   ]
                                   "Flags"
                                   []
                             ]
                         ]
                         (Type.tuple
                              (Type.namedWith
                                   [ "Pages"
                                   , "Internal"
                                   , "Platform"
                                   , "GeneratorApplication"
                                   ]
                                   "Model"
                                   []
                              )
                              (Type.namedWith
                                   [ "Pages", "Internal", "Platform", "Effect" ]
                                   "Effect"
                                   []
                              )
                         )
                    )
            }
    , requestDecoder =
        Elm.value
            { importFrom =
                [ "Pages", "Internal", "Platform", "GeneratorApplication" ]
            , name = "requestDecoder"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Json", "Decode" ]
                         "Decoder"
                         [ Type.namedWith
                             [ "Pages", "StaticHttp", "Request" ]
                             "Request"
                             []
                         ]
                    )
            }
    , update =
        Elm.value
            { importFrom =
                [ "Pages", "Internal", "Platform", "GeneratorApplication" ]
            , name = "update"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages"
                             , "Internal"
                             , "Platform"
                             , "GeneratorApplication"
                             ]
                             "Msg"
                             []
                         , Type.namedWith
                             [ "Pages"
                             , "Internal"
                             , "Platform"
                             , "GeneratorApplication"
                             ]
                             "Model"
                             []
                         ]
                         (Type.tuple
                              (Type.namedWith
                                   [ "Pages"
                                   , "Internal"
                                   , "Platform"
                                   , "GeneratorApplication"
                                   ]
                                   "Model"
                                   []
                              )
                              (Type.namedWith
                                   [ "Pages", "Internal", "Platform", "Effect" ]
                                   "Effect"
                                   []
                              )
                         )
                    )
            }
    , app =
        Elm.value
            { importFrom =
                [ "Pages", "Internal", "Platform", "GeneratorApplication" ]
            , name = "app"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "GeneratorProgramConfig" ]
                             "GeneratorProgramConfig"
                             []
                         ]
                         (Type.namedWith
                              [ "Pages"
                              , "Internal"
                              , "Platform"
                              , "GeneratorApplication"
                              ]
                              "Program"
                              []
                         )
                    )
            }
    }