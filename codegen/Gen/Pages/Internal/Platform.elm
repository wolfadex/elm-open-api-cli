module Gen.Pages.Internal.Platform exposing (annotation_, application, call_, caseOf_, init, make_, moduleName_, update, values_, view)

{-| 
@docs moduleName_, application, init, update, view, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Internal", "Platform" ]


{-| application: 
    Pages.ProgramConfig.ProgramConfig userMsg userModel route pageData actionData sharedData effect (Pages.Internal.Platform.Msg userMsg pageData actionData sharedData errorPage) errorPage
    -> Platform.Program Pages.Internal.Platform.Flags (Pages.Internal.Platform.Model userModel pageData actionData sharedData) (Pages.Internal.Platform.Msg userMsg pageData actionData sharedData errorPage)
-}
application : Elm.Expression -> Elm.Expression
application applicationArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "Platform" ]
             , name = "application"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "ProgramConfig" ]
                              "ProgramConfig"
                              [ Type.var "userMsg"
                              , Type.var "userModel"
                              , Type.var "route"
                              , Type.var "pageData"
                              , Type.var "actionData"
                              , Type.var "sharedData"
                              , Type.var "effect"
                              , Type.namedWith
                                    [ "Pages", "Internal", "Platform" ]
                                    "Msg"
                                    [ Type.var "userMsg"
                                    , Type.var "pageData"
                                    , Type.var "actionData"
                                    , Type.var "sharedData"
                                    , Type.var "errorPage"
                                    ]
                              , Type.var "errorPage"
                              ]
                          ]
                          (Type.namedWith
                               [ "Platform" ]
                               "Program"
                               [ Type.namedWith
                                   [ "Pages", "Internal", "Platform" ]
                                   "Flags"
                                   []
                               , Type.namedWith
                                   [ "Pages", "Internal", "Platform" ]
                                   "Model"
                                   [ Type.var "userModel"
                                   , Type.var "pageData"
                                   , Type.var "actionData"
                                   , Type.var "sharedData"
                                   ]
                               , Type.namedWith
                                   [ "Pages", "Internal", "Platform" ]
                                   "Msg"
                                   [ Type.var "userMsg"
                                   , Type.var "pageData"
                                   , Type.var "actionData"
                                   , Type.var "sharedData"
                                   , Type.var "errorPage"
                                   ]
                               ]
                          )
                     )
             }
        )
        [ applicationArg ]


{-| init: 
    Pages.ProgramConfig.ProgramConfig userMsg userModel route pageData actionData sharedData userEffect (Pages.Internal.Platform.Msg userMsg pageData actionData sharedData errorPage) errorPage
    -> Pages.Internal.Platform.Flags
    -> Url.Url
    -> Maybe Browser.Navigation.Key
    -> ( Pages.Internal.Platform.Model userModel pageData actionData sharedData, Pages.Internal.Platform.Effect userMsg pageData actionData sharedData userEffect errorPage )
-}
init :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
init initArg initArg0 initArg1 initArg2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "Platform" ]
             , name = "init"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "ProgramConfig" ]
                              "ProgramConfig"
                              [ Type.var "userMsg"
                              , Type.var "userModel"
                              , Type.var "route"
                              , Type.var "pageData"
                              , Type.var "actionData"
                              , Type.var "sharedData"
                              , Type.var "userEffect"
                              , Type.namedWith
                                    [ "Pages", "Internal", "Platform" ]
                                    "Msg"
                                    [ Type.var "userMsg"
                                    , Type.var "pageData"
                                    , Type.var "actionData"
                                    , Type.var "sharedData"
                                    , Type.var "errorPage"
                                    ]
                              , Type.var "errorPage"
                              ]
                          , Type.namedWith
                              [ "Pages", "Internal", "Platform" ]
                              "Flags"
                              []
                          , Type.namedWith [ "Url" ] "Url" []
                          , Type.maybe
                              (Type.namedWith
                                 [ "Browser", "Navigation" ]
                                 "Key"
                                 []
                              )
                          ]
                          (Type.tuple
                               (Type.namedWith
                                    [ "Pages", "Internal", "Platform" ]
                                    "Model"
                                    [ Type.var "userModel"
                                    , Type.var "pageData"
                                    , Type.var "actionData"
                                    , Type.var "sharedData"
                                    ]
                               )
                               (Type.namedWith
                                    [ "Pages", "Internal", "Platform" ]
                                    "Effect"
                                    [ Type.var "userMsg"
                                    , Type.var "pageData"
                                    , Type.var "actionData"
                                    , Type.var "sharedData"
                                    , Type.var "userEffect"
                                    , Type.var "errorPage"
                                    ]
                               )
                          )
                     )
             }
        )
        [ initArg, initArg0, initArg1, initArg2 ]


{-| update: 
    Pages.ProgramConfig.ProgramConfig userMsg userModel route pageData actionData sharedData userEffect (Pages.Internal.Platform.Msg userMsg pageData actionData sharedData errorPage) errorPage
    -> Pages.Internal.Platform.Msg userMsg pageData actionData sharedData errorPage
    -> Pages.Internal.Platform.Model userModel pageData actionData sharedData
    -> ( Pages.Internal.Platform.Model userModel pageData actionData sharedData, Pages.Internal.Platform.Effect userMsg pageData actionData sharedData userEffect errorPage )
-}
update : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
update updateArg updateArg0 updateArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "Platform" ]
             , name = "update"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "ProgramConfig" ]
                              "ProgramConfig"
                              [ Type.var "userMsg"
                              , Type.var "userModel"
                              , Type.var "route"
                              , Type.var "pageData"
                              , Type.var "actionData"
                              , Type.var "sharedData"
                              , Type.var "userEffect"
                              , Type.namedWith
                                    [ "Pages", "Internal", "Platform" ]
                                    "Msg"
                                    [ Type.var "userMsg"
                                    , Type.var "pageData"
                                    , Type.var "actionData"
                                    , Type.var "sharedData"
                                    , Type.var "errorPage"
                                    ]
                              , Type.var "errorPage"
                              ]
                          , Type.namedWith
                              [ "Pages", "Internal", "Platform" ]
                              "Msg"
                              [ Type.var "userMsg"
                              , Type.var "pageData"
                              , Type.var "actionData"
                              , Type.var "sharedData"
                              , Type.var "errorPage"
                              ]
                          , Type.namedWith
                              [ "Pages", "Internal", "Platform" ]
                              "Model"
                              [ Type.var "userModel"
                              , Type.var "pageData"
                              , Type.var "actionData"
                              , Type.var "sharedData"
                              ]
                          ]
                          (Type.tuple
                               (Type.namedWith
                                    [ "Pages", "Internal", "Platform" ]
                                    "Model"
                                    [ Type.var "userModel"
                                    , Type.var "pageData"
                                    , Type.var "actionData"
                                    , Type.var "sharedData"
                                    ]
                               )
                               (Type.namedWith
                                    [ "Pages", "Internal", "Platform" ]
                                    "Effect"
                                    [ Type.var "userMsg"
                                    , Type.var "pageData"
                                    , Type.var "actionData"
                                    , Type.var "sharedData"
                                    , Type.var "userEffect"
                                    , Type.var "errorPage"
                                    ]
                               )
                          )
                     )
             }
        )
        [ updateArg, updateArg0, updateArg1 ]


{-| view: 
    Pages.ProgramConfig.ProgramConfig userMsg userModel route pageData actionData sharedData effect (Pages.Internal.Platform.Msg userMsg pageData actionData sharedData errorPage) errorPage
    -> Pages.Internal.Platform.Model userModel pageData actionData sharedData
    -> Browser.Document (Pages.Internal.Platform.Msg userMsg pageData actionData sharedData errorPage)
-}
view : Elm.Expression -> Elm.Expression -> Elm.Expression
view viewArg viewArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "Platform" ]
             , name = "view"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "ProgramConfig" ]
                              "ProgramConfig"
                              [ Type.var "userMsg"
                              , Type.var "userModel"
                              , Type.var "route"
                              , Type.var "pageData"
                              , Type.var "actionData"
                              , Type.var "sharedData"
                              , Type.var "effect"
                              , Type.namedWith
                                    [ "Pages", "Internal", "Platform" ]
                                    "Msg"
                                    [ Type.var "userMsg"
                                    , Type.var "pageData"
                                    , Type.var "actionData"
                                    , Type.var "sharedData"
                                    , Type.var "errorPage"
                                    ]
                              , Type.var "errorPage"
                              ]
                          , Type.namedWith
                              [ "Pages", "Internal", "Platform" ]
                              "Model"
                              [ Type.var "userModel"
                              , Type.var "pageData"
                              , Type.var "actionData"
                              , Type.var "sharedData"
                              ]
                          ]
                          (Type.namedWith
                               [ "Browser" ]
                               "Document"
                               [ Type.namedWith
                                   [ "Pages", "Internal", "Platform" ]
                                   "Msg"
                                   [ Type.var "userMsg"
                                   , Type.var "pageData"
                                   , Type.var "actionData"
                                   , Type.var "sharedData"
                                   , Type.var "errorPage"
                                   ]
                               ]
                          )
                     )
             }
        )
        [ viewArg, viewArg0 ]


annotation_ :
    { flags : Type.Annotation
    , model :
        Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
    , msg :
        Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
    , program :
        Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
    , effect :
        Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
    , requestInfo : Type.Annotation
    }
annotation_ =
    { flags =
        Type.alias
            moduleName_
            "Flags"
            []
            (Type.namedWith [ "Json", "Decode" ] "Value" [])
    , model =
        \modelArg0 modelArg1 modelArg2 modelArg3 ->
            Type.alias
                moduleName_
                "Model"
                [ modelArg0, modelArg1, modelArg2, modelArg3 ]
                (Type.record
                     [ ( "key"
                       , Type.maybe
                             (Type.namedWith
                                  [ "Browser", "Navigation" ]
                                  "Key"
                                  []
                             )
                       )
                     , ( "url", Type.namedWith [ "Url" ] "Url" [] )
                     , ( "currentPath", Type.string )
                     , ( "ariaNavigationAnnouncement", Type.string )
                     , ( "pageData"
                       , Type.namedWith
                             [ "Result" ]
                             "Result"
                             [ Type.string
                             , Type.record
                                 [ ( "userModel", Type.var "userModel" )
                                 , ( "pageData", Type.var "pageData" )
                                 , ( "sharedData", Type.var "sharedData" )
                                 , ( "actionData"
                                   , Type.maybe (Type.var "actionData")
                                   )
                                 ]
                             ]
                       )
                     , ( "notFound"
                       , Type.maybe
                             (Type.record
                                  [ ( "reason"
                                    , Type.namedWith
                                          [ "Pages"
                                          , "Internal"
                                          , "NotFoundReason"
                                          ]
                                          "NotFoundReason"
                                          []
                                    )
                                  , ( "path"
                                    , Type.namedWith [ "UrlPath" ] "UrlPath" []
                                    )
                                  ]
                             )
                       )
                     , ( "userFlags"
                       , Type.namedWith [ "Json", "Decode" ] "Value" []
                       )
                     , ( "transition"
                       , Type.maybe
                             (Type.tuple
                                  Type.int
                                  (Type.namedWith
                                       [ "Pages", "Navigation" ]
                                       "Navigation"
                                       []
                                  )
                             )
                       )
                     , ( "nextTransitionKey", Type.int )
                     , ( "inFlightFetchers"
                       , Type.namedWith
                             [ "Dict" ]
                             "Dict"
                             [ Type.string
                             , Type.tuple
                                 Type.int
                                 (Type.namedWith
                                    [ "Pages", "ConcurrentSubmission" ]
                                    "ConcurrentSubmission"
                                    [ Type.var "actionData" ]
                                 )
                             ]
                       )
                     , ( "pageFormState", Type.namedWith [ "Form" ] "Model" [] )
                     , ( "pendingRedirect", Type.bool )
                     , ( "pendingData"
                       , Type.maybe
                             (Type.triple
                                  (Type.var "pageData")
                                  (Type.var "sharedData")
                                  (Type.maybe (Type.var "actionData"))
                             )
                       )
                     ]
                )
    , msg =
        \msgArg0 msgArg1 msgArg2 msgArg3 msgArg4 ->
            Type.namedWith
                [ "Pages", "Internal", "Platform" ]
                "Msg"
                [ msgArg0, msgArg1, msgArg2, msgArg3, msgArg4 ]
    , program =
        \programArg0 programArg1 programArg2 programArg3 programArg4 programArg5 ->
            Type.alias
                moduleName_
                "Program"
                [ programArg0
                , programArg1
                , programArg2
                , programArg3
                , programArg4
                , programArg5
                ]
                (Type.namedWith
                     [ "Platform" ]
                     "Program"
                     [ Type.namedWith
                         [ "Pages", "Internal", "Platform" ]
                         "Flags"
                         []
                     , Type.namedWith
                         [ "Pages", "Internal", "Platform" ]
                         "Model"
                         [ Type.var "userModel"
                         , Type.var "pageData"
                         , Type.var "actionData"
                         , Type.var "sharedData"
                         ]
                     , Type.namedWith
                         [ "Pages", "Internal", "Platform" ]
                         "Msg"
                         [ Type.var "userMsg"
                         , Type.var "pageData"
                         , Type.var "actionData"
                         , Type.var "sharedData"
                         , Type.var "errorPage"
                         ]
                     ]
                )
    , effect =
        \effectArg0 effectArg1 effectArg2 effectArg3 effectArg4 effectArg5 ->
            Type.namedWith
                [ "Pages", "Internal", "Platform" ]
                "Effect"
                [ effectArg0
                , effectArg1
                , effectArg2
                , effectArg3
                , effectArg4
                , effectArg5
                ]
    , requestInfo =
        Type.alias
            moduleName_
            "RequestInfo"
            []
            (Type.record
                 [ ( "contentType", Type.string ), ( "body", Type.string ) ]
            )
    }


make_ :
    { model :
        { key : Elm.Expression
        , url : Elm.Expression
        , currentPath : Elm.Expression
        , ariaNavigationAnnouncement : Elm.Expression
        , pageData : Elm.Expression
        , notFound : Elm.Expression
        , userFlags : Elm.Expression
        , transition : Elm.Expression
        , nextTransitionKey : Elm.Expression
        , inFlightFetchers : Elm.Expression
        , pageFormState : Elm.Expression
        , pendingRedirect : Elm.Expression
        , pendingData : Elm.Expression
        }
        -> Elm.Expression
    , linkClicked : Elm.Expression -> Elm.Expression
    , urlChanged : Elm.Expression -> Elm.Expression
    , userMsg : Elm.Expression -> Elm.Expression
    , formMsg : Elm.Expression -> Elm.Expression
    , updateCacheAndUrlNew :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , fetcherComplete :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , fetcherStarted :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , pageScrollComplete : Elm.Expression
    , hotReloadCompleteNew : Elm.Expression -> Elm.Expression
    , processFetchResponse :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , scrollToTop : Elm.Expression
    , noEffect : Elm.Expression
    , browserLoadUrl : Elm.Expression -> Elm.Expression
    , browserPushUrl : Elm.Expression -> Elm.Expression
    , browserReplaceUrl : Elm.Expression -> Elm.Expression
    , fetchPageData :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , submit : Elm.Expression -> Elm.Expression
    , submitFetcher :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , batch : Elm.Expression -> Elm.Expression
    , userCmd : Elm.Expression -> Elm.Expression
    , cancelRequest : Elm.Expression -> Elm.Expression
    , runCmd : Elm.Expression -> Elm.Expression
    , requestInfo :
        { contentType : Elm.Expression, body : Elm.Expression }
        -> Elm.Expression
    }
make_ =
    { model =
        \model_args ->
            Elm.withType
                (Type.alias
                     [ "Pages", "Internal", "Platform" ]
                     "Model"
                     [ Type.var "userModel"
                     , Type.var "pageData"
                     , Type.var "actionData"
                     , Type.var "sharedData"
                     ]
                     (Type.record
                          [ ( "key"
                            , Type.maybe
                                  (Type.namedWith
                                       [ "Browser", "Navigation" ]
                                       "Key"
                                       []
                                  )
                            )
                          , ( "url", Type.namedWith [ "Url" ] "Url" [] )
                          , ( "currentPath", Type.string )
                          , ( "ariaNavigationAnnouncement", Type.string )
                          , ( "pageData"
                            , Type.namedWith
                                  [ "Result" ]
                                  "Result"
                                  [ Type.string
                                  , Type.record
                                      [ ( "userModel", Type.var "userModel" )
                                      , ( "pageData", Type.var "pageData" )
                                      , ( "sharedData", Type.var "sharedData" )
                                      , ( "actionData"
                                        , Type.maybe (Type.var "actionData")
                                        )
                                      ]
                                  ]
                            )
                          , ( "notFound"
                            , Type.maybe
                                  (Type.record
                                       [ ( "reason"
                                         , Type.namedWith
                                               [ "Pages"
                                               , "Internal"
                                               , "NotFoundReason"
                                               ]
                                               "NotFoundReason"
                                               []
                                         )
                                       , ( "path"
                                         , Type.namedWith
                                               [ "UrlPath" ]
                                               "UrlPath"
                                               []
                                         )
                                       ]
                                  )
                            )
                          , ( "userFlags"
                            , Type.namedWith [ "Json", "Decode" ] "Value" []
                            )
                          , ( "transition"
                            , Type.maybe
                                  (Type.tuple
                                       Type.int
                                       (Type.namedWith
                                            [ "Pages", "Navigation" ]
                                            "Navigation"
                                            []
                                       )
                                  )
                            )
                          , ( "nextTransitionKey", Type.int )
                          , ( "inFlightFetchers"
                            , Type.namedWith
                                  [ "Dict" ]
                                  "Dict"
                                  [ Type.string
                                  , Type.tuple
                                      Type.int
                                      (Type.namedWith
                                         [ "Pages", "ConcurrentSubmission" ]
                                         "ConcurrentSubmission"
                                         [ Type.var "actionData" ]
                                      )
                                  ]
                            )
                          , ( "pageFormState"
                            , Type.namedWith [ "Form" ] "Model" []
                            )
                          , ( "pendingRedirect", Type.bool )
                          , ( "pendingData"
                            , Type.maybe
                                  (Type.triple
                                       (Type.var "pageData")
                                       (Type.var "sharedData")
                                       (Type.maybe (Type.var "actionData"))
                                  )
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "key" model_args.key
                     , Tuple.pair "url" model_args.url
                     , Tuple.pair "currentPath" model_args.currentPath
                     , Tuple.pair
                         "ariaNavigationAnnouncement"
                         model_args.ariaNavigationAnnouncement
                     , Tuple.pair "pageData" model_args.pageData
                     , Tuple.pair "notFound" model_args.notFound
                     , Tuple.pair "userFlags" model_args.userFlags
                     , Tuple.pair "transition" model_args.transition
                     , Tuple.pair
                         "nextTransitionKey"
                         model_args.nextTransitionKey
                     , Tuple.pair "inFlightFetchers" model_args.inFlightFetchers
                     , Tuple.pair "pageFormState" model_args.pageFormState
                     , Tuple.pair "pendingRedirect" model_args.pendingRedirect
                     , Tuple.pair "pendingData" model_args.pendingData
                     ]
                )
    , linkClicked =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "LinkClicked"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Msg"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0 ]
    , urlChanged =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "UrlChanged"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Msg"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0 ]
    , userMsg =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "UserMsg"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Msg"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0 ]
    , formMsg =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "FormMsg"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Msg"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0 ]
    , updateCacheAndUrlNew =
        \ar0 ar1 ar2 ar3 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "UpdateCacheAndUrlNew"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Msg"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0, ar1, ar2, ar3 ]
    , fetcherComplete =
        \ar0 ar1 ar2 ar3 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "FetcherComplete"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Msg"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0, ar1, ar2, ar3 ]
    , fetcherStarted =
        \ar0 ar1 ar2 ar3 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "FetcherStarted"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Msg"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0, ar1, ar2, ar3 ]
    , pageScrollComplete =
        Elm.value
            { importFrom = [ "Pages", "Internal", "Platform" ]
            , name = "PageScrollComplete"
            , annotation =
                Just
                    (Type.namedWith
                         []
                         "Msg"
                         [ Type.var "userMsg"
                         , Type.var "pageData"
                         , Type.var "actionData"
                         , Type.var "sharedData"
                         , Type.var "errorPage"
                         ]
                    )
            }
    , hotReloadCompleteNew =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "HotReloadCompleteNew"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Msg"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0 ]
    , processFetchResponse =
        \ar0 ar1 ar2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "ProcessFetchResponse"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Msg"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0, ar1, ar2 ]
    , scrollToTop =
        Elm.value
            { importFrom = [ "Pages", "Internal", "Platform" ]
            , name = "ScrollToTop"
            , annotation =
                Just
                    (Type.namedWith
                         []
                         "Effect"
                         [ Type.var "userMsg"
                         , Type.var "pageData"
                         , Type.var "actionData"
                         , Type.var "sharedData"
                         , Type.var "userEffect"
                         , Type.var "errorPage"
                         ]
                    )
            }
    , noEffect =
        Elm.value
            { importFrom = [ "Pages", "Internal", "Platform" ]
            , name = "NoEffect"
            , annotation =
                Just
                    (Type.namedWith
                         []
                         "Effect"
                         [ Type.var "userMsg"
                         , Type.var "pageData"
                         , Type.var "actionData"
                         , Type.var "sharedData"
                         , Type.var "userEffect"
                         , Type.var "errorPage"
                         ]
                    )
            }
    , browserLoadUrl =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "BrowserLoadUrl"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Effect"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "userEffect"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0 ]
    , browserPushUrl =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "BrowserPushUrl"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Effect"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "userEffect"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0 ]
    , browserReplaceUrl =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "BrowserReplaceUrl"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Effect"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "userEffect"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0 ]
    , fetchPageData =
        \ar0 ar1 ar2 ar3 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "FetchPageData"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Effect"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "userEffect"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0, ar1, ar2, ar3 ]
    , submit =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "Submit"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Effect"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "userEffect"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0 ]
    , submitFetcher =
        \ar0 ar1 ar2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "SubmitFetcher"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Effect"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "userEffect"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0, ar1, ar2 ]
    , batch =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "Batch"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Effect"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "userEffect"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0 ]
    , userCmd =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "UserCmd"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Effect"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "userEffect"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0 ]
    , cancelRequest =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "CancelRequest"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Effect"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "userEffect"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0 ]
    , runCmd =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "RunCmd"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Effect"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "userEffect"
                                  , Type.var "errorPage"
                                  ]
                             )
                     }
                )
                [ ar0 ]
    , requestInfo =
        \requestInfo_args ->
            Elm.withType
                (Type.alias
                     [ "Pages", "Internal", "Platform" ]
                     "RequestInfo"
                     []
                     (Type.record
                          [ ( "contentType", Type.string )
                          , ( "body", Type.string )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "contentType" requestInfo_args.contentType
                     , Tuple.pair "body" requestInfo_args.body
                     ]
                )
    }


caseOf_ :
    { msg :
        Elm.Expression
        -> { msgTags_0_0
            | linkClicked : Elm.Expression -> Elm.Expression
            , urlChanged : Elm.Expression -> Elm.Expression
            , userMsg : Elm.Expression -> Elm.Expression
            , formMsg : Elm.Expression -> Elm.Expression
            , updateCacheAndUrlNew :
                Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
            , fetcherComplete :
                Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
            , fetcherStarted :
                Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
            , pageScrollComplete : Elm.Expression
            , hotReloadCompleteNew : Elm.Expression -> Elm.Expression
            , processFetchResponse :
                Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
        }
        -> Elm.Expression
    , effect :
        Elm.Expression
        -> { effectTags_1_0
            | scrollToTop : Elm.Expression
            , noEffect : Elm.Expression
            , browserLoadUrl : Elm.Expression -> Elm.Expression
            , browserPushUrl : Elm.Expression -> Elm.Expression
            , browserReplaceUrl : Elm.Expression -> Elm.Expression
            , fetchPageData :
                Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
            , submit : Elm.Expression -> Elm.Expression
            , submitFetcher :
                Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
            , batch : Elm.Expression -> Elm.Expression
            , userCmd : Elm.Expression -> Elm.Expression
            , cancelRequest : Elm.Expression -> Elm.Expression
            , runCmd : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { msg =
        \msgExpression msgTags ->
            Elm.Case.custom
                msgExpression
                (Type.namedWith
                     [ "Pages", "Internal", "Platform" ]
                     "Msg"
                     [ Type.var "userMsg"
                     , Type.var "pageData"
                     , Type.var "actionData"
                     , Type.var "sharedData"
                     , Type.var "errorPage"
                     ]
                )
                [ Elm.Case.branch1
                    "LinkClicked"
                    ( "browserUrlRequest"
                    , Type.namedWith [ "Browser" ] "UrlRequest" []
                    )
                    msgTags.linkClicked
                , Elm.Case.branch1
                    "UrlChanged"
                    ( "urlUrl", Type.namedWith [ "Url" ] "Url" [] )
                    msgTags.urlChanged
                , Elm.Case.branch1
                    "UserMsg"
                    ( "pagesMsgPagesMsg"
                    , Type.namedWith
                          [ "PagesMsg" ]
                          "PagesMsg"
                          [ Type.var "userMsg" ]
                    )
                    msgTags.userMsg
                , Elm.Case.branch1
                    "FormMsg"
                    ( "formMsg"
                    , Type.namedWith
                          [ "Form" ]
                          "Msg"
                          [ Type.namedWith
                              [ "Pages", "Internal", "Platform" ]
                              "Msg"
                              [ Type.var "userMsg"
                              , Type.var "pageData"
                              , Type.var "actionData"
                              , Type.var "sharedData"
                              , Type.var "errorPage"
                              ]
                          ]
                    )
                    msgTags.formMsg
                , Elm.Case.branch4
                    "UpdateCacheAndUrlNew"
                    ( "basicsBool", Type.bool )
                    ( "urlUrl", Type.namedWith [ "Url" ] "Url" [] )
                    ( "maybeMaybe", Type.maybe (Type.var "userMsg") )
                    ( "resultResult"
                    , Type.namedWith
                          [ "Result" ]
                          "Result"
                          [ Type.namedWith [ "Http" ] "Error" []
                          , Type.tuple
                              (Type.namedWith [ "Url" ] "Url" [])
                              (Type.namedWith
                                 [ "Pages", "Internal", "ResponseSketch" ]
                                 "ResponseSketch"
                                 [ Type.var "pageData"
                                 , Type.var "actionData"
                                 , Type.var "sharedData"
                                 ]
                              )
                          ]
                    )
                    msgTags.updateCacheAndUrlNew
                , Elm.Case.branch4
                    "FetcherComplete"
                    ( "basicsBool", Type.bool )
                    ( "stringString", Type.string )
                    ( "basicsInt", Type.int )
                    ( "resultResult"
                    , Type.namedWith
                          [ "Result" ]
                          "Result"
                          [ Type.namedWith [ "Http" ] "Error" []
                          , Type.tuple
                              (Type.maybe (Type.var "userMsg"))
                              (Type.namedWith
                                 [ "Pages", "Internal", "Platform" ]
                                 "ActionDataOrRedirect"
                                 [ Type.var "actionData" ]
                              )
                          ]
                    )
                    msgTags.fetcherComplete
                , Elm.Case.branch4
                    "FetcherStarted"
                    ( "stringString", Type.string )
                    ( "basicsInt", Type.int )
                    ( "pagesInternalPlatformFormData"
                    , Type.namedWith
                          [ "Pages", "Internal", "Platform" ]
                          "FormData"
                          []
                    )
                    ( "timePosix", Type.namedWith [ "Time" ] "Posix" [] )
                    msgTags.fetcherStarted
                , Elm.Case.branch0
                    "PageScrollComplete"
                    msgTags.pageScrollComplete
                , Elm.Case.branch1
                    "HotReloadCompleteNew"
                    ( "bytesBytes", Type.namedWith [ "Bytes" ] "Bytes" [] )
                    msgTags.hotReloadCompleteNew
                , Elm.Case.branch3
                    "ProcessFetchResponse"
                    ( "basicsInt", Type.int )
                    ( "resultResult"
                    , Type.namedWith
                          [ "Result" ]
                          "Result"
                          [ Type.namedWith [ "Http" ] "Error" []
                          , Type.tuple
                              (Type.namedWith [ "Url" ] "Url" [])
                              (Type.namedWith
                                 [ "Pages", "Internal", "ResponseSketch" ]
                                 "ResponseSketch"
                                 [ Type.var "pageData"
                                 , Type.var "actionData"
                                 , Type.var "sharedData"
                                 ]
                              )
                          ]
                    )
                    ( "three"
                    , Type.function
                          [ Type.namedWith
                              [ "Result" ]
                              "Result"
                              [ Type.namedWith [ "Http" ] "Error" []
                              , Type.tuple
                                    (Type.namedWith [ "Url" ] "Url" [])
                                    (Type.namedWith
                                         [ "Pages"
                                         , "Internal"
                                         , "ResponseSketch"
                                         ]
                                         "ResponseSketch"
                                         [ Type.var "pageData"
                                         , Type.var "actionData"
                                         , Type.var "sharedData"
                                         ]
                                    )
                              ]
                          ]
                          (Type.namedWith
                               [ "Pages", "Internal", "Platform" ]
                               "Msg"
                               [ Type.var "userMsg"
                               , Type.var "pageData"
                               , Type.var "actionData"
                               , Type.var "sharedData"
                               , Type.var "errorPage"
                               ]
                          )
                    )
                    msgTags.processFetchResponse
                ]
    , effect =
        \effectExpression effectTags ->
            Elm.Case.custom
                effectExpression
                (Type.namedWith
                     [ "Pages", "Internal", "Platform" ]
                     "Effect"
                     [ Type.var "userMsg"
                     , Type.var "pageData"
                     , Type.var "actionData"
                     , Type.var "sharedData"
                     , Type.var "userEffect"
                     , Type.var "errorPage"
                     ]
                )
                [ Elm.Case.branch0 "ScrollToTop" effectTags.scrollToTop
                , Elm.Case.branch0 "NoEffect" effectTags.noEffect
                , Elm.Case.branch1
                    "BrowserLoadUrl"
                    ( "stringString", Type.string )
                    effectTags.browserLoadUrl
                , Elm.Case.branch1
                    "BrowserPushUrl"
                    ( "stringString", Type.string )
                    effectTags.browserPushUrl
                , Elm.Case.branch1
                    "BrowserReplaceUrl"
                    ( "stringString", Type.string )
                    effectTags.browserReplaceUrl
                , Elm.Case.branch4
                    "FetchPageData"
                    ( "basicsInt", Type.int )
                    ( "maybeMaybe"
                    , Type.maybe
                          (Type.namedWith
                               [ "Pages", "Internal", "Platform" ]
                               "FormData"
                               []
                          )
                    )
                    ( "urlUrl", Type.namedWith [ "Url" ] "Url" [] )
                    ( "four"
                    , Type.function
                          [ Type.namedWith
                              [ "Result" ]
                              "Result"
                              [ Type.namedWith [ "Http" ] "Error" []
                              , Type.tuple
                                    (Type.namedWith [ "Url" ] "Url" [])
                                    (Type.namedWith
                                         [ "Pages"
                                         , "Internal"
                                         , "ResponseSketch"
                                         ]
                                         "ResponseSketch"
                                         [ Type.var "pageData"
                                         , Type.var "actionData"
                                         , Type.var "sharedData"
                                         ]
                                    )
                              ]
                          ]
                          (Type.namedWith
                               [ "Pages", "Internal", "Platform" ]
                               "Msg"
                               [ Type.var "userMsg"
                               , Type.var "pageData"
                               , Type.var "actionData"
                               , Type.var "sharedData"
                               , Type.var "errorPage"
                               ]
                          )
                    )
                    effectTags.fetchPageData
                , Elm.Case.branch1
                    "Submit"
                    ( "pagesInternalPlatformFormData"
                    , Type.namedWith
                          [ "Pages", "Internal", "Platform" ]
                          "FormData"
                          []
                    )
                    effectTags.submit
                , Elm.Case.branch3
                    "SubmitFetcher"
                    ( "stringString", Type.string )
                    ( "basicsInt", Type.int )
                    ( "pagesInternalPlatformFormData"
                    , Type.namedWith
                          [ "Pages", "Internal", "Platform" ]
                          "FormData"
                          []
                    )
                    effectTags.submitFetcher
                , Elm.Case.branch1
                    "Batch"
                    ( "listList"
                    , Type.list
                          (Type.namedWith
                               [ "Pages", "Internal", "Platform" ]
                               "Effect"
                               [ Type.var "userMsg"
                               , Type.var "pageData"
                               , Type.var "actionData"
                               , Type.var "sharedData"
                               , Type.var "userEffect"
                               , Type.var "errorPage"
                               ]
                          )
                    )
                    effectTags.batch
                , Elm.Case.branch1
                    "UserCmd"
                    ( "userEffect", Type.var "userEffect" )
                    effectTags.userCmd
                , Elm.Case.branch1
                    "CancelRequest"
                    ( "basicsInt", Type.int )
                    effectTags.cancelRequest
                , Elm.Case.branch1
                    "RunCmd"
                    ( "platformCmdCmd"
                    , Type.namedWith
                          []
                          "Cmd"
                          [ Type.namedWith
                              [ "Pages", "Internal", "Platform" ]
                              "Msg"
                              [ Type.var "userMsg"
                              , Type.var "pageData"
                              , Type.var "actionData"
                              , Type.var "sharedData"
                              , Type.var "errorPage"
                              ]
                          ]
                    )
                    effectTags.runCmd
                ]
    }


call_ :
    { application : Elm.Expression -> Elm.Expression
    , init :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , update :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , view : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { application =
        \applicationArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "application"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "ProgramConfig" ]
                                      "ProgramConfig"
                                      [ Type.var "userMsg"
                                      , Type.var "userModel"
                                      , Type.var "route"
                                      , Type.var "pageData"
                                      , Type.var "actionData"
                                      , Type.var "sharedData"
                                      , Type.var "effect"
                                      , Type.namedWith
                                            [ "Pages", "Internal", "Platform" ]
                                            "Msg"
                                            [ Type.var "userMsg"
                                            , Type.var "pageData"
                                            , Type.var "actionData"
                                            , Type.var "sharedData"
                                            , Type.var "errorPage"
                                            ]
                                      , Type.var "errorPage"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Platform" ]
                                       "Program"
                                       [ Type.namedWith
                                           [ "Pages", "Internal", "Platform" ]
                                           "Flags"
                                           []
                                       , Type.namedWith
                                           [ "Pages", "Internal", "Platform" ]
                                           "Model"
                                           [ Type.var "userModel"
                                           , Type.var "pageData"
                                           , Type.var "actionData"
                                           , Type.var "sharedData"
                                           ]
                                       , Type.namedWith
                                           [ "Pages", "Internal", "Platform" ]
                                           "Msg"
                                           [ Type.var "userMsg"
                                           , Type.var "pageData"
                                           , Type.var "actionData"
                                           , Type.var "sharedData"
                                           , Type.var "errorPage"
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ applicationArg ]
    , init =
        \initArg initArg0 initArg1 initArg2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "init"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "ProgramConfig" ]
                                      "ProgramConfig"
                                      [ Type.var "userMsg"
                                      , Type.var "userModel"
                                      , Type.var "route"
                                      , Type.var "pageData"
                                      , Type.var "actionData"
                                      , Type.var "sharedData"
                                      , Type.var "userEffect"
                                      , Type.namedWith
                                            [ "Pages", "Internal", "Platform" ]
                                            "Msg"
                                            [ Type.var "userMsg"
                                            , Type.var "pageData"
                                            , Type.var "actionData"
                                            , Type.var "sharedData"
                                            , Type.var "errorPage"
                                            ]
                                      , Type.var "errorPage"
                                      ]
                                  , Type.namedWith
                                      [ "Pages", "Internal", "Platform" ]
                                      "Flags"
                                      []
                                  , Type.namedWith [ "Url" ] "Url" []
                                  , Type.maybe
                                      (Type.namedWith
                                         [ "Browser", "Navigation" ]
                                         "Key"
                                         []
                                      )
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Pages", "Internal", "Platform" ]
                                            "Model"
                                            [ Type.var "userModel"
                                            , Type.var "pageData"
                                            , Type.var "actionData"
                                            , Type.var "sharedData"
                                            ]
                                       )
                                       (Type.namedWith
                                            [ "Pages", "Internal", "Platform" ]
                                            "Effect"
                                            [ Type.var "userMsg"
                                            , Type.var "pageData"
                                            , Type.var "actionData"
                                            , Type.var "sharedData"
                                            , Type.var "userEffect"
                                            , Type.var "errorPage"
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ initArg, initArg0, initArg1, initArg2 ]
    , update =
        \updateArg updateArg0 updateArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "update"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "ProgramConfig" ]
                                      "ProgramConfig"
                                      [ Type.var "userMsg"
                                      , Type.var "userModel"
                                      , Type.var "route"
                                      , Type.var "pageData"
                                      , Type.var "actionData"
                                      , Type.var "sharedData"
                                      , Type.var "userEffect"
                                      , Type.namedWith
                                            [ "Pages", "Internal", "Platform" ]
                                            "Msg"
                                            [ Type.var "userMsg"
                                            , Type.var "pageData"
                                            , Type.var "actionData"
                                            , Type.var "sharedData"
                                            , Type.var "errorPage"
                                            ]
                                      , Type.var "errorPage"
                                      ]
                                  , Type.namedWith
                                      [ "Pages", "Internal", "Platform" ]
                                      "Msg"
                                      [ Type.var "userMsg"
                                      , Type.var "pageData"
                                      , Type.var "actionData"
                                      , Type.var "sharedData"
                                      , Type.var "errorPage"
                                      ]
                                  , Type.namedWith
                                      [ "Pages", "Internal", "Platform" ]
                                      "Model"
                                      [ Type.var "userModel"
                                      , Type.var "pageData"
                                      , Type.var "actionData"
                                      , Type.var "sharedData"
                                      ]
                                  ]
                                  (Type.tuple
                                       (Type.namedWith
                                            [ "Pages", "Internal", "Platform" ]
                                            "Model"
                                            [ Type.var "userModel"
                                            , Type.var "pageData"
                                            , Type.var "actionData"
                                            , Type.var "sharedData"
                                            ]
                                       )
                                       (Type.namedWith
                                            [ "Pages", "Internal", "Platform" ]
                                            "Effect"
                                            [ Type.var "userMsg"
                                            , Type.var "pageData"
                                            , Type.var "actionData"
                                            , Type.var "sharedData"
                                            , Type.var "userEffect"
                                            , Type.var "errorPage"
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ updateArg, updateArg0, updateArg1 ]
    , view =
        \viewArg viewArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "view"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "ProgramConfig" ]
                                      "ProgramConfig"
                                      [ Type.var "userMsg"
                                      , Type.var "userModel"
                                      , Type.var "route"
                                      , Type.var "pageData"
                                      , Type.var "actionData"
                                      , Type.var "sharedData"
                                      , Type.var "effect"
                                      , Type.namedWith
                                            [ "Pages", "Internal", "Platform" ]
                                            "Msg"
                                            [ Type.var "userMsg"
                                            , Type.var "pageData"
                                            , Type.var "actionData"
                                            , Type.var "sharedData"
                                            , Type.var "errorPage"
                                            ]
                                      , Type.var "errorPage"
                                      ]
                                  , Type.namedWith
                                      [ "Pages", "Internal", "Platform" ]
                                      "Model"
                                      [ Type.var "userModel"
                                      , Type.var "pageData"
                                      , Type.var "actionData"
                                      , Type.var "sharedData"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Browser" ]
                                       "Document"
                                       [ Type.namedWith
                                           [ "Pages", "Internal", "Platform" ]
                                           "Msg"
                                           [ Type.var "userMsg"
                                           , Type.var "pageData"
                                           , Type.var "actionData"
                                           , Type.var "sharedData"
                                           , Type.var "errorPage"
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ viewArg, viewArg0 ]
    }


values_ :
    { application : Elm.Expression
    , init : Elm.Expression
    , update : Elm.Expression
    , view : Elm.Expression
    }
values_ =
    { application =
        Elm.value
            { importFrom = [ "Pages", "Internal", "Platform" ]
            , name = "application"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "ProgramConfig" ]
                             "ProgramConfig"
                             [ Type.var "userMsg"
                             , Type.var "userModel"
                             , Type.var "route"
                             , Type.var "pageData"
                             , Type.var "actionData"
                             , Type.var "sharedData"
                             , Type.var "effect"
                             , Type.namedWith
                                   [ "Pages", "Internal", "Platform" ]
                                   "Msg"
                                   [ Type.var "userMsg"
                                   , Type.var "pageData"
                                   , Type.var "actionData"
                                   , Type.var "sharedData"
                                   , Type.var "errorPage"
                                   ]
                             , Type.var "errorPage"
                             ]
                         ]
                         (Type.namedWith
                              [ "Platform" ]
                              "Program"
                              [ Type.namedWith
                                  [ "Pages", "Internal", "Platform" ]
                                  "Flags"
                                  []
                              , Type.namedWith
                                  [ "Pages", "Internal", "Platform" ]
                                  "Model"
                                  [ Type.var "userModel"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  ]
                              , Type.namedWith
                                  [ "Pages", "Internal", "Platform" ]
                                  "Msg"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "errorPage"
                                  ]
                              ]
                         )
                    )
            }
    , init =
        Elm.value
            { importFrom = [ "Pages", "Internal", "Platform" ]
            , name = "init"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "ProgramConfig" ]
                             "ProgramConfig"
                             [ Type.var "userMsg"
                             , Type.var "userModel"
                             , Type.var "route"
                             , Type.var "pageData"
                             , Type.var "actionData"
                             , Type.var "sharedData"
                             , Type.var "userEffect"
                             , Type.namedWith
                                   [ "Pages", "Internal", "Platform" ]
                                   "Msg"
                                   [ Type.var "userMsg"
                                   , Type.var "pageData"
                                   , Type.var "actionData"
                                   , Type.var "sharedData"
                                   , Type.var "errorPage"
                                   ]
                             , Type.var "errorPage"
                             ]
                         , Type.namedWith
                             [ "Pages", "Internal", "Platform" ]
                             "Flags"
                             []
                         , Type.namedWith [ "Url" ] "Url" []
                         , Type.maybe
                             (Type.namedWith
                                [ "Browser", "Navigation" ]
                                "Key"
                                []
                             )
                         ]
                         (Type.tuple
                              (Type.namedWith
                                   [ "Pages", "Internal", "Platform" ]
                                   "Model"
                                   [ Type.var "userModel"
                                   , Type.var "pageData"
                                   , Type.var "actionData"
                                   , Type.var "sharedData"
                                   ]
                              )
                              (Type.namedWith
                                   [ "Pages", "Internal", "Platform" ]
                                   "Effect"
                                   [ Type.var "userMsg"
                                   , Type.var "pageData"
                                   , Type.var "actionData"
                                   , Type.var "sharedData"
                                   , Type.var "userEffect"
                                   , Type.var "errorPage"
                                   ]
                              )
                         )
                    )
            }
    , update =
        Elm.value
            { importFrom = [ "Pages", "Internal", "Platform" ]
            , name = "update"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "ProgramConfig" ]
                             "ProgramConfig"
                             [ Type.var "userMsg"
                             , Type.var "userModel"
                             , Type.var "route"
                             , Type.var "pageData"
                             , Type.var "actionData"
                             , Type.var "sharedData"
                             , Type.var "userEffect"
                             , Type.namedWith
                                   [ "Pages", "Internal", "Platform" ]
                                   "Msg"
                                   [ Type.var "userMsg"
                                   , Type.var "pageData"
                                   , Type.var "actionData"
                                   , Type.var "sharedData"
                                   , Type.var "errorPage"
                                   ]
                             , Type.var "errorPage"
                             ]
                         , Type.namedWith
                             [ "Pages", "Internal", "Platform" ]
                             "Msg"
                             [ Type.var "userMsg"
                             , Type.var "pageData"
                             , Type.var "actionData"
                             , Type.var "sharedData"
                             , Type.var "errorPage"
                             ]
                         , Type.namedWith
                             [ "Pages", "Internal", "Platform" ]
                             "Model"
                             [ Type.var "userModel"
                             , Type.var "pageData"
                             , Type.var "actionData"
                             , Type.var "sharedData"
                             ]
                         ]
                         (Type.tuple
                              (Type.namedWith
                                   [ "Pages", "Internal", "Platform" ]
                                   "Model"
                                   [ Type.var "userModel"
                                   , Type.var "pageData"
                                   , Type.var "actionData"
                                   , Type.var "sharedData"
                                   ]
                              )
                              (Type.namedWith
                                   [ "Pages", "Internal", "Platform" ]
                                   "Effect"
                                   [ Type.var "userMsg"
                                   , Type.var "pageData"
                                   , Type.var "actionData"
                                   , Type.var "sharedData"
                                   , Type.var "userEffect"
                                   , Type.var "errorPage"
                                   ]
                              )
                         )
                    )
            }
    , view =
        Elm.value
            { importFrom = [ "Pages", "Internal", "Platform" ]
            , name = "view"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "ProgramConfig" ]
                             "ProgramConfig"
                             [ Type.var "userMsg"
                             , Type.var "userModel"
                             , Type.var "route"
                             , Type.var "pageData"
                             , Type.var "actionData"
                             , Type.var "sharedData"
                             , Type.var "effect"
                             , Type.namedWith
                                   [ "Pages", "Internal", "Platform" ]
                                   "Msg"
                                   [ Type.var "userMsg"
                                   , Type.var "pageData"
                                   , Type.var "actionData"
                                   , Type.var "sharedData"
                                   , Type.var "errorPage"
                                   ]
                             , Type.var "errorPage"
                             ]
                         , Type.namedWith
                             [ "Pages", "Internal", "Platform" ]
                             "Model"
                             [ Type.var "userModel"
                             , Type.var "pageData"
                             , Type.var "actionData"
                             , Type.var "sharedData"
                             ]
                         ]
                         (Type.namedWith
                              [ "Browser" ]
                              "Document"
                              [ Type.namedWith
                                  [ "Pages", "Internal", "Platform" ]
                                  "Msg"
                                  [ Type.var "userMsg"
                                  , Type.var "pageData"
                                  , Type.var "actionData"
                                  , Type.var "sharedData"
                                  , Type.var "errorPage"
                                  ]
                              ]
                         )
                    )
            }
    }