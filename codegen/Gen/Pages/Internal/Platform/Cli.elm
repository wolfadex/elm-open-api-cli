module Gen.Pages.Internal.Platform.Cli exposing
    ( moduleName_, cliApplication, init, requestDecoder, update, currentCompatibilityKey
    , annotation_, make_, caseOf_, call_, values_
    )

{-|
# Generated bindings for Pages.Internal.Platform.Cli

@docs moduleName_, cliApplication, init, requestDecoder, update, currentCompatibilityKey
@docs annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Internal", "Platform", "Cli" ]


{-| cliApplication: 
    Pages.ProgramConfig.ProgramConfig userMsg userModel (Maybe route) pageData actionData sharedData effect mappedMsg errorPage
    -> Pages.Internal.Platform.Cli.Program (Maybe route)
-}
cliApplication : Elm.Expression -> Elm.Expression
cliApplication cliApplicationArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "Platform", "Cli" ]
             , name = "cliApplication"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "ProgramConfig" ]
                              "ProgramConfig"
                              [ Type.var "userMsg"
                              , Type.var "userModel"
                              , Type.maybe (Type.var "route")
                              , Type.var "pageData"
                              , Type.var "actionData"
                              , Type.var "sharedData"
                              , Type.var "effect"
                              , Type.var "mappedMsg"
                              , Type.var "errorPage"
                              ]
                          ]
                          (Type.namedWith
                               [ "Pages", "Internal", "Platform", "Cli" ]
                               "Program"
                               [ Type.maybe (Type.var "route") ]
                          )
                     )
             }
        )
        [ cliApplicationArg_ ]


{-| init: 
    Pages.SiteConfig.SiteConfig
    -> RenderRequest.RenderRequest route
    -> Pages.ProgramConfig.ProgramConfig userMsg userModel route pageData actionData sharedData effect mappedMsg errorPage
    -> Json.Decode.Value
    -> ( Pages.Internal.Platform.Cli.Model route, Pages.Internal.Platform.Effect.Effect )
-}
init :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
init initArg_ initArg_0 initArg_1 initArg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "Platform", "Cli" ]
             , name = "init"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "SiteConfig" ]
                              "SiteConfig"
                              []
                          , Type.namedWith
                              [ "RenderRequest" ]
                              "RenderRequest"
                              [ Type.var "route" ]
                          , Type.namedWith
                              [ "Pages", "ProgramConfig" ]
                              "ProgramConfig"
                              [ Type.var "userMsg"
                              , Type.var "userModel"
                              , Type.var "route"
                              , Type.var "pageData"
                              , Type.var "actionData"
                              , Type.var "sharedData"
                              , Type.var "effect"
                              , Type.var "mappedMsg"
                              , Type.var "errorPage"
                              ]
                          , Type.namedWith [ "Json", "Decode" ] "Value" []
                          ]
                          (Type.tuple
                               (Type.namedWith
                                    [ "Pages", "Internal", "Platform", "Cli" ]
                                    "Model"
                                    [ Type.var "route" ]
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
        [ initArg_, initArg_0, initArg_1, initArg_2 ]


{-| requestDecoder: Json.Decode.Decoder Pages.StaticHttp.Request.Request -}
requestDecoder : Elm.Expression
requestDecoder =
    Elm.value
        { importFrom = [ "Pages", "Internal", "Platform", "Cli" ]
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
    Pages.Internal.Platform.Cli.Msg
    -> Pages.Internal.Platform.Cli.Model route
    -> ( Pages.Internal.Platform.Cli.Model route, Pages.Internal.Platform.Effect.Effect )
-}
update : Elm.Expression -> Elm.Expression -> Elm.Expression
update updateArg_ updateArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "Platform", "Cli" ]
             , name = "update"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Internal", "Platform", "Cli" ]
                              "Msg"
                              []
                          , Type.namedWith
                              [ "Pages", "Internal", "Platform", "Cli" ]
                              "Model"
                              [ Type.var "route" ]
                          ]
                          (Type.tuple
                               (Type.namedWith
                                    [ "Pages", "Internal", "Platform", "Cli" ]
                                    "Model"
                                    [ Type.var "route" ]
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


{-| currentCompatibilityKey: Int -}
currentCompatibilityKey : Elm.Expression
currentCompatibilityKey =
    Elm.value
        { importFrom = [ "Pages", "Internal", "Platform", "Cli" ]
        , name = "currentCompatibilityKey"
        , annotation = Just Type.int
        }


annotation_ :
    { flags : Type.Annotation
    , model : Type.Annotation -> Type.Annotation
    , msg : Type.Annotation
    , program : Type.Annotation -> Type.Annotation
    }
annotation_ =
    { flags =
        Type.alias
            moduleName_
            "Flags"
            []
            (Type.namedWith [ "Json", "Decode" ] "Value" [])
    , model =
        \modelArg0 ->
            Type.alias
                moduleName_
                "Model"
                [ modelArg0 ]
                (Type.record
                     [ ( "staticResponses"
                       , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.namedWith [ "FatalError" ] "FatalError" []
                             , Type.namedWith
                                 [ "Pages", "Internal", "Platform", "Effect" ]
                                 "Effect"
                                 []
                             ]
                       )
                     , ( "errors"
                       , Type.list
                             (Type.namedWith [ "BuildError" ] "BuildError" [])
                       )
                     , ( "maybeRequestJson"
                       , Type.namedWith
                             [ "RenderRequest" ]
                             "RenderRequest"
                             [ Type.var "route" ]
                       )
                     , ( "isDevServer", Type.bool )
                     ]
                )
    , msg = Type.namedWith [ "Pages", "Internal", "Platform", "Cli" ] "Msg" []
    , program =
        \programArg0 ->
            Type.alias
                moduleName_
                "Program"
                [ programArg0 ]
                (Type.namedWith
                     [ "Platform" ]
                     "Program"
                     [ Type.namedWith
                         [ "Pages", "Internal", "Platform", "Cli" ]
                         "Flags"
                         []
                     , Type.namedWith
                         [ "Pages", "Internal", "Platform", "Cli" ]
                         "Model"
                         [ Type.var "route" ]
                     , Type.namedWith
                         [ "Pages", "Internal", "Platform", "Cli" ]
                         "Msg"
                         []
                     ]
                )
    }


make_ :
    { model :
        { staticResponses : Elm.Expression
        , errors : Elm.Expression
        , maybeRequestJson : Elm.Expression
        , isDevServer : Elm.Expression
        }
        -> Elm.Expression
    , gotDataBatch : Elm.Expression -> Elm.Expression
    , gotBuildError : Elm.Expression -> Elm.Expression
    }
make_ =
    { model =
        \model_args ->
            Elm.withType
                (Type.alias
                     [ "Pages", "Internal", "Platform", "Cli" ]
                     "Model"
                     [ Type.var "route" ]
                     (Type.record
                          [ ( "staticResponses"
                            , Type.namedWith
                                  [ "BackendTask" ]
                                  "BackendTask"
                                  [ Type.namedWith
                                      [ "FatalError" ]
                                      "FatalError"
                                      []
                                  , Type.namedWith
                                      [ "Pages"
                                      , "Internal"
                                      , "Platform"
                                      , "Effect"
                                      ]
                                      "Effect"
                                      []
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
                          , ( "maybeRequestJson"
                            , Type.namedWith
                                  [ "RenderRequest" ]
                                  "RenderRequest"
                                  [ Type.var "route" ]
                            )
                          , ( "isDevServer", Type.bool )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "staticResponses" model_args.staticResponses
                     , Tuple.pair "errors" model_args.errors
                     , Tuple.pair "maybeRequestJson" model_args.maybeRequestJson
                     , Tuple.pair "isDevServer" model_args.isDevServer
                     ]
                )
    , gotDataBatch =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform", "Cli" ]
                     , name = "GotDataBatch"
                     , annotation = Just (Type.namedWith [] "Msg" [])
                     }
                )
                [ ar0 ]
    , gotBuildError =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform", "Cli" ]
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
                     [ "Pages", "Internal", "Platform", "Cli" ]
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
    { cliApplication : Elm.Expression -> Elm.Expression
    , init :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , update : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { cliApplication =
        \cliApplicationArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform", "Cli" ]
                     , name = "cliApplication"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "ProgramConfig" ]
                                      "ProgramConfig"
                                      [ Type.var "userMsg"
                                      , Type.var "userModel"
                                      , Type.maybe (Type.var "route")
                                      , Type.var "pageData"
                                      , Type.var "actionData"
                                      , Type.var "sharedData"
                                      , Type.var "effect"
                                      , Type.var "mappedMsg"
                                      , Type.var "errorPage"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Pages"
                                       , "Internal"
                                       , "Platform"
                                       , "Cli"
                                       ]
                                       "Program"
                                       [ Type.maybe (Type.var "route") ]
                                  )
                             )
                     }
                )
                [ cliApplicationArg_ ]
    , init =
        \initArg_ initArg_0 initArg_1 initArg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform", "Cli" ]
                     , name = "init"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "SiteConfig" ]
                                      "SiteConfig"
                                      []
                                  , Type.namedWith
                                      [ "RenderRequest" ]
                                      "RenderRequest"
                                      [ Type.var "route" ]
                                  , Type.namedWith
                                      [ "Pages", "ProgramConfig" ]
                                      "ProgramConfig"
                                      [ Type.var "userMsg"
                                      , Type.var "userModel"
                                      , Type.var "route"
                                      , Type.var "pageData"
                                      , Type.var "actionData"
                                      , Type.var "sharedData"
                                      , Type.var "effect"
                                      , Type.var "mappedMsg"
                                      , Type.var "errorPage"
                                      ]
                                  , Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Value"
                                      []
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Pages"
                                            , "Internal"
                                            , "Platform"
                                            , "Cli"
                                            ]
                                            "Model"
                                            [ Type.var "route" ]
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
                [ initArg_, initArg_0, initArg_1, initArg_2 ]
    , update =
        \updateArg_ updateArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform", "Cli" ]
                     , name = "update"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Internal", "Platform", "Cli" ]
                                      "Msg"
                                      []
                                  , Type.namedWith
                                      [ "Pages", "Internal", "Platform", "Cli" ]
                                      "Model"
                                      [ Type.var "route" ]
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Pages"
                                            , "Internal"
                                            , "Platform"
                                            , "Cli"
                                            ]
                                            "Model"
                                            [ Type.var "route" ]
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
    }


values_ :
    { cliApplication : Elm.Expression
    , init : Elm.Expression
    , requestDecoder : Elm.Expression
    , update : Elm.Expression
    , currentCompatibilityKey : Elm.Expression
    }
values_ =
    { cliApplication =
        Elm.value
            { importFrom = [ "Pages", "Internal", "Platform", "Cli" ]
            , name = "cliApplication"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "ProgramConfig" ]
                             "ProgramConfig"
                             [ Type.var "userMsg"
                             , Type.var "userModel"
                             , Type.maybe (Type.var "route")
                             , Type.var "pageData"
                             , Type.var "actionData"
                             , Type.var "sharedData"
                             , Type.var "effect"
                             , Type.var "mappedMsg"
                             , Type.var "errorPage"
                             ]
                         ]
                         (Type.namedWith
                              [ "Pages", "Internal", "Platform", "Cli" ]
                              "Program"
                              [ Type.maybe (Type.var "route") ]
                         )
                    )
            }
    , init =
        Elm.value
            { importFrom = [ "Pages", "Internal", "Platform", "Cli" ]
            , name = "init"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "SiteConfig" ]
                             "SiteConfig"
                             []
                         , Type.namedWith
                             [ "RenderRequest" ]
                             "RenderRequest"
                             [ Type.var "route" ]
                         , Type.namedWith
                             [ "Pages", "ProgramConfig" ]
                             "ProgramConfig"
                             [ Type.var "userMsg"
                             , Type.var "userModel"
                             , Type.var "route"
                             , Type.var "pageData"
                             , Type.var "actionData"
                             , Type.var "sharedData"
                             , Type.var "effect"
                             , Type.var "mappedMsg"
                             , Type.var "errorPage"
                             ]
                         , Type.namedWith [ "Json", "Decode" ] "Value" []
                         ]
                         (Type.tuple
                              (Type.namedWith
                                   [ "Pages", "Internal", "Platform", "Cli" ]
                                   "Model"
                                   [ Type.var "route" ]
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
            { importFrom = [ "Pages", "Internal", "Platform", "Cli" ]
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
            { importFrom = [ "Pages", "Internal", "Platform", "Cli" ]
            , name = "update"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Internal", "Platform", "Cli" ]
                             "Msg"
                             []
                         , Type.namedWith
                             [ "Pages", "Internal", "Platform", "Cli" ]
                             "Model"
                             [ Type.var "route" ]
                         ]
                         (Type.tuple
                              (Type.namedWith
                                   [ "Pages", "Internal", "Platform", "Cli" ]
                                   "Model"
                                   [ Type.var "route" ]
                              )
                              (Type.namedWith
                                   [ "Pages", "Internal", "Platform", "Effect" ]
                                   "Effect"
                                   []
                              )
                         )
                    )
            }
    , currentCompatibilityKey =
        Elm.value
            { importFrom = [ "Pages", "Internal", "Platform", "Cli" ]
            , name = "currentCompatibilityKey"
            , annotation = Just Type.int
            }
    }