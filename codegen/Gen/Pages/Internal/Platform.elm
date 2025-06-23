module Gen.Pages.Internal.Platform exposing
    ( moduleName_, application, init, update, view, annotation_
    , make_, caseOf_, call_, values_
    )

{-|
# Generated bindings for Pages.Internal.Platform

@docs moduleName_, application, init, update, view, annotation_
@docs make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Internal", "Platform" ]


{-| application: 
    Pages.Internal.Platform.ProgramConfig userMsg userModel route pageData actionData sharedData effect (Pages.Internal.Platform.Msg userMsg pageData actionData sharedData errorPage) errorPage
    -> Platform.Program Pages.Internal.Platform.Flags (Pages.Internal.Platform.Model userModel pageData actionData sharedData) (Pages.Internal.Platform.Msg userMsg pageData actionData sharedData errorPage)
-}
application : Elm.Expression -> Elm.Expression
application applicationArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "Platform" ]
             , name = "application"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Internal", "Platform" ]
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
        [ applicationArg_ ]


{-| init: 
    Pages.Internal.Platform.ProgramConfig userMsg userModel route pageData actionData sharedData userEffect (Pages.Internal.Platform.Msg userMsg pageData actionData sharedData errorPage) errorPage
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
init initArg_ initArg_0 initArg_1 initArg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "Platform" ]
             , name = "init"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Internal", "Platform" ]
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
        [ initArg_, initArg_0, initArg_1, initArg_2 ]


{-| update: 
    Pages.Internal.Platform.ProgramConfig userMsg userModel route pageData actionData sharedData userEffect (Pages.Internal.Platform.Msg userMsg pageData actionData sharedData errorPage) errorPage
    -> Pages.Internal.Platform.Msg userMsg pageData actionData sharedData errorPage
    -> Pages.Internal.Platform.Model userModel pageData actionData sharedData
    -> ( Pages.Internal.Platform.Model userModel pageData actionData sharedData, Pages.Internal.Platform.Effect userMsg pageData actionData sharedData userEffect errorPage )
-}
update : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
update updateArg_ updateArg_0 updateArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "Platform" ]
             , name = "update"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Internal", "Platform" ]
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
        [ updateArg_, updateArg_0, updateArg_1 ]


{-| view: 
    Pages.Internal.Platform.ProgramConfig userMsg userModel route pageData actionData sharedData effect (Pages.Internal.Platform.Msg userMsg pageData actionData sharedData errorPage) errorPage
    -> Pages.Internal.Platform.Model userModel pageData actionData sharedData
    -> Browser.Document (Pages.Internal.Platform.Msg userMsg pageData actionData sharedData errorPage)
-}
view : Elm.Expression -> Elm.Expression -> Elm.Expression
view viewArg_ viewArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "Platform" ]
             , name = "view"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Internal", "Platform" ]
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
        [ viewArg_, viewArg_0 ]


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
    , programConfig :
        Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
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
    , programConfig =
        \programConfigArg0 programConfigArg1 programConfigArg2 programConfigArg3 programConfigArg4 programConfigArg5 programConfigArg6 programConfigArg7 programConfigArg8 ->
            Type.alias
                moduleName_
                "ProgramConfig"
                [ programConfigArg0
                , programConfigArg1
                , programConfigArg2
                , programConfigArg3
                , programConfigArg4
                , programConfigArg5
                , programConfigArg6
                , programConfigArg7
                , programConfigArg8
                ]
                (Type.namedWith
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
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "LinkClicked"
                       msgTags.linkClicked |> Elm.Arg.item
                                                    (Elm.Arg.varWith
                                                           "browserUrlRequest"
                                                           (Type.namedWith
                                                                  [ "Browser" ]
                                                                  "UrlRequest"
                                                                  []
                                                           )
                                                    )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "UrlChanged"
                       msgTags.urlChanged |> Elm.Arg.item
                                                   (Elm.Arg.varWith
                                                          "urlUrl"
                                                          (Type.namedWith
                                                                 [ "Url" ]
                                                                 "Url"
                                                                 []
                                                          )
                                                   )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "UserMsg"
                       msgTags.userMsg |> Elm.Arg.item
                                                (Elm.Arg.varWith
                                                       "pagesMsgPagesMsg"
                                                       (Type.namedWith
                                                              [ "PagesMsg" ]
                                                              "PagesMsg"
                                                              [ Type.var
                                                                    "userMsg"
                                                              ]
                                                       )
                                                )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "FormMsg"
                       msgTags.formMsg |> Elm.Arg.item
                                                (Elm.Arg.varWith
                                                       "formMsg"
                                                       (Type.namedWith
                                                              [ "Form" ]
                                                              "Msg"
                                                              [ Type.namedWith
                                                                    [ "Pages"
                                                                    , "Internal"
                                                                    , "Platform"
                                                                    ]
                                                                    "Msg"
                                                                    [ Type.var
                                                                        "userMsg"
                                                                    , Type.var
                                                                        "pageData"
                                                                    , Type.var
                                                                        "actionData"
                                                                    , Type.var
                                                                        "sharedData"
                                                                    , Type.var
                                                                        "errorPage"
                                                                    ]
                                                              ]
                                                       )
                                                )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "UpdateCacheAndUrlNew"
                       msgTags.updateCacheAndUrlNew |> Elm.Arg.item
                                                             (Elm.Arg.varWith
                                                                    "arg_0"
                                                                    Type.bool
                                                             ) |> Elm.Arg.item
                                                                        (Elm.Arg.varWith
                                                                               "urlUrl"
                                                                               (Type.namedWith
                                                                                      [ "Url"
                                                                                      ]
                                                                                      "Url"
                                                                                      []
                                                                               )
                                                                        ) |> Elm.Arg.item
                                                                                   (Elm.Arg.varWith
                                                                                          "maybeMaybe"
                                                                                          (Type.maybe
                                                                                                 (Type.var
                                                                                                        "userMsg"
                                                                                                 )
                                                                                          )
                                                                                   ) |> Elm.Arg.item
                                                                                              (Elm.Arg.varWith
                                                                                                     "resultResult"
                                                                                                     (Type.namedWith
                                                                                                            [ "Result"
                                                                                                            ]
                                                                                                            "Result"
                                                                                                            [ Type.namedWith
                                                                                                                  [ "Http"
                                                                                                                  ]
                                                                                                                  "Error"
                                                                                                                  []
                                                                                                            , Type.tuple
                                                                                                                  (Type.namedWith
                                                                                                                       [ "Url"
                                                                                                                       ]
                                                                                                                       "Url"
                                                                                                                       []
                                                                                                                  )
                                                                                                                  (Type.namedWith
                                                                                                                       [ "Pages"
                                                                                                                       , "Internal"
                                                                                                                       , "ResponseSketch"
                                                                                                                       ]
                                                                                                                       "ResponseSketch"
                                                                                                                       [ Type.var
                                                                                                                           "pageData"
                                                                                                                       , Type.var
                                                                                                                           "actionData"
                                                                                                                       , Type.var
                                                                                                                           "sharedData"
                                                                                                                       ]
                                                                                                                  )
                                                                                                            ]
                                                                                                     )
                                                                                              )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "FetcherComplete"
                       msgTags.fetcherComplete |> Elm.Arg.item
                                                        (Elm.Arg.varWith
                                                               "arg_0"
                                                               Type.bool
                                                        ) |> Elm.Arg.item
                                                                   (Elm.Arg.varWith
                                                                          "arg_1"
                                                                          Type.string
                                                                   ) |> Elm.Arg.item
                                                                              (Elm.Arg.varWith
                                                                                     "arg_2"
                                                                                     Type.int
                                                                              ) |> Elm.Arg.item
                                                                                         (Elm.Arg.varWith
                                                                                                "resultResult"
                                                                                                (Type.namedWith
                                                                                                       [ "Result"
                                                                                                       ]
                                                                                                       "Result"
                                                                                                       [ Type.namedWith
                                                                                                             [ "Http"
                                                                                                             ]
                                                                                                             "Error"
                                                                                                             []
                                                                                                       , Type.tuple
                                                                                                             (Type.maybe
                                                                                                                  (Type.var
                                                                                                                       "userMsg"
                                                                                                                  )
                                                                                                             )
                                                                                                             (Type.namedWith
                                                                                                                  [ "Pages"
                                                                                                                  , "Internal"
                                                                                                                  , "Platform"
                                                                                                                  ]
                                                                                                                  "ActionDataOrRedirect"
                                                                                                                  [ Type.var
                                                                                                                      "actionData"
                                                                                                                  ]
                                                                                                             )
                                                                                                       ]
                                                                                                )
                                                                                         )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "FetcherStarted"
                       msgTags.fetcherStarted |> Elm.Arg.item
                                                       (Elm.Arg.varWith
                                                              "arg_0"
                                                              Type.string
                                                       ) |> Elm.Arg.item
                                                                  (Elm.Arg.varWith
                                                                         "arg_1"
                                                                         Type.int
                                                                  ) |> Elm.Arg.item
                                                                             (Elm.Arg.varWith
                                                                                    "pagesInternalPlatformFormData"
                                                                                    (Type.namedWith
                                                                                           [ "Pages"
                                                                                           , "Internal"
                                                                                           , "Platform"
                                                                                           ]
                                                                                           "FormData"
                                                                                           []
                                                                                    )
                                                                             ) |> Elm.Arg.item
                                                                                        (Elm.Arg.varWith
                                                                                               "timePosix"
                                                                                               (Type.namedWith
                                                                                                      [ "Time"
                                                                                                      ]
                                                                                                      "Posix"
                                                                                                      []
                                                                                               )
                                                                                        )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "PageScrollComplete"
                       msgTags.pageScrollComplete
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "HotReloadCompleteNew"
                       msgTags.hotReloadCompleteNew |> Elm.Arg.item
                                                             (Elm.Arg.varWith
                                                                    "bytesBytes"
                                                                    (Type.namedWith
                                                                           [ "Bytes"
                                                                           ]
                                                                           "Bytes"
                                                                           []
                                                                    )
                                                             )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ProcessFetchResponse"
                       msgTags.processFetchResponse |> Elm.Arg.item
                                                             (Elm.Arg.varWith
                                                                    "arg_0"
                                                                    Type.int
                                                             ) |> Elm.Arg.item
                                                                        (Elm.Arg.varWith
                                                                               "resultResult"
                                                                               (Type.namedWith
                                                                                      [ "Result"
                                                                                      ]
                                                                                      "Result"
                                                                                      [ Type.namedWith
                                                                                            [ "Http"
                                                                                            ]
                                                                                            "Error"
                                                                                            []
                                                                                      , Type.tuple
                                                                                            (Type.namedWith
                                                                                                 [ "Url"
                                                                                                 ]
                                                                                                 "Url"
                                                                                                 []
                                                                                            )
                                                                                            (Type.namedWith
                                                                                                 [ "Pages"
                                                                                                 , "Internal"
                                                                                                 , "ResponseSketch"
                                                                                                 ]
                                                                                                 "ResponseSketch"
                                                                                                 [ Type.var
                                                                                                     "pageData"
                                                                                                 , Type.var
                                                                                                     "actionData"
                                                                                                 , Type.var
                                                                                                     "sharedData"
                                                                                                 ]
                                                                                            )
                                                                                      ]
                                                                               )
                                                                        ) |> Elm.Arg.item
                                                                                   (Elm.Arg.varWith
                                                                                          "arg_2"
                                                                                          (Type.function
                                                                                                 [ Type.namedWith
                                                                                                       [ "Result"
                                                                                                       ]
                                                                                                       "Result"
                                                                                                       [ Type.namedWith
                                                                                                           [ "Http"
                                                                                                           ]
                                                                                                           "Error"
                                                                                                           []
                                                                                                       , Type.tuple
                                                                                                           (Type.namedWith
                                                                                                              [ "Url"
                                                                                                              ]
                                                                                                              "Url"
                                                                                                              []
                                                                                                           )
                                                                                                           (Type.namedWith
                                                                                                              [ "Pages"
                                                                                                              , "Internal"
                                                                                                              , "ResponseSketch"
                                                                                                              ]
                                                                                                              "ResponseSketch"
                                                                                                              [ Type.var
                                                                                                                    "pageData"
                                                                                                              , Type.var
                                                                                                                    "actionData"
                                                                                                              , Type.var
                                                                                                                    "sharedData"
                                                                                                              ]
                                                                                                           )
                                                                                                       ]
                                                                                                 ]
                                                                                                 (Type.namedWith
                                                                                                        [ "Pages"
                                                                                                        , "Internal"
                                                                                                        , "Platform"
                                                                                                        ]
                                                                                                        "Msg"
                                                                                                        [ Type.var
                                                                                                              "userMsg"
                                                                                                        , Type.var
                                                                                                              "pageData"
                                                                                                        , Type.var
                                                                                                              "actionData"
                                                                                                        , Type.var
                                                                                                              "sharedData"
                                                                                                        , Type.var
                                                                                                              "errorPage"
                                                                                                        ]
                                                                                                 )
                                                                                          )
                                                                                   )
                    )
                    Basics.identity
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
                [ Elm.Case.branch
                    (Elm.Arg.customType "ScrollToTop" effectTags.scrollToTop)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "NoEffect" effectTags.noEffect)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "BrowserLoadUrl"
                       effectTags.browserLoadUrl |> Elm.Arg.item
                                                          (Elm.Arg.varWith
                                                                 "arg_0"
                                                                 Type.string
                                                          )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "BrowserPushUrl"
                       effectTags.browserPushUrl |> Elm.Arg.item
                                                          (Elm.Arg.varWith
                                                                 "arg_0"
                                                                 Type.string
                                                          )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "BrowserReplaceUrl"
                       effectTags.browserReplaceUrl |> Elm.Arg.item
                                                             (Elm.Arg.varWith
                                                                    "arg_0"
                                                                    Type.string
                                                             )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "FetchPageData"
                       effectTags.fetchPageData |> Elm.Arg.item
                                                         (Elm.Arg.varWith
                                                                "arg_0"
                                                                Type.int
                                                         ) |> Elm.Arg.item
                                                                    (Elm.Arg.varWith
                                                                           "maybeMaybe"
                                                                           (Type.maybe
                                                                                  (Type.namedWith
                                                                                         [ "Pages"
                                                                                         , "Internal"
                                                                                         , "Platform"
                                                                                         ]
                                                                                         "FormData"
                                                                                         []
                                                                                  )
                                                                           )
                                                                    ) |> Elm.Arg.item
                                                                               (Elm.Arg.varWith
                                                                                      "urlUrl"
                                                                                      (Type.namedWith
                                                                                             [ "Url"
                                                                                             ]
                                                                                             "Url"
                                                                                             []
                                                                                      )
                                                                               ) |> Elm.Arg.item
                                                                                          (Elm.Arg.varWith
                                                                                                 "arg_3"
                                                                                                 (Type.function
                                                                                                        [ Type.namedWith
                                                                                                              [ "Result"
                                                                                                              ]
                                                                                                              "Result"
                                                                                                              [ Type.namedWith
                                                                                                                  [ "Http"
                                                                                                                  ]
                                                                                                                  "Error"
                                                                                                                  []
                                                                                                              , Type.tuple
                                                                                                                  (Type.namedWith
                                                                                                                     [ "Url"
                                                                                                                     ]
                                                                                                                     "Url"
                                                                                                                     []
                                                                                                                  )
                                                                                                                  (Type.namedWith
                                                                                                                     [ "Pages"
                                                                                                                     , "Internal"
                                                                                                                     , "ResponseSketch"
                                                                                                                     ]
                                                                                                                     "ResponseSketch"
                                                                                                                     [ Type.var
                                                                                                                           "pageData"
                                                                                                                     , Type.var
                                                                                                                           "actionData"
                                                                                                                     , Type.var
                                                                                                                           "sharedData"
                                                                                                                     ]
                                                                                                                  )
                                                                                                              ]
                                                                                                        ]
                                                                                                        (Type.namedWith
                                                                                                               [ "Pages"
                                                                                                               , "Internal"
                                                                                                               , "Platform"
                                                                                                               ]
                                                                                                               "Msg"
                                                                                                               [ Type.var
                                                                                                                     "userMsg"
                                                                                                               , Type.var
                                                                                                                     "pageData"
                                                                                                               , Type.var
                                                                                                                     "actionData"
                                                                                                               , Type.var
                                                                                                                     "sharedData"
                                                                                                               , Type.var
                                                                                                                     "errorPage"
                                                                                                               ]
                                                                                                        )
                                                                                                 )
                                                                                          )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "Submit"
                       effectTags.submit |> Elm.Arg.item
                                                  (Elm.Arg.varWith
                                                         "pagesInternalPlatformFormData"
                                                         (Type.namedWith
                                                                [ "Pages"
                                                                , "Internal"
                                                                , "Platform"
                                                                ]
                                                                "FormData"
                                                                []
                                                         )
                                                  )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "SubmitFetcher"
                       effectTags.submitFetcher |> Elm.Arg.item
                                                         (Elm.Arg.varWith
                                                                "arg_0"
                                                                Type.string
                                                         ) |> Elm.Arg.item
                                                                    (Elm.Arg.varWith
                                                                           "arg_1"
                                                                           Type.int
                                                                    ) |> Elm.Arg.item
                                                                               (Elm.Arg.varWith
                                                                                      "pagesInternalPlatformFormData"
                                                                                      (Type.namedWith
                                                                                             [ "Pages"
                                                                                             , "Internal"
                                                                                             , "Platform"
                                                                                             ]
                                                                                             "FormData"
                                                                                             []
                                                                                      )
                                                                               )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Batch" effectTags.batch |> Elm.Arg.item
                                                                          (Elm.Arg.varWith
                                                                                 "arg_0"
                                                                                 (Type.list
                                                                                        (Type.namedWith
                                                                                               [ "Pages"
                                                                                               , "Internal"
                                                                                               , "Platform"
                                                                                               ]
                                                                                               "Effect"
                                                                                               [ Type.var
                                                                                                     "userMsg"
                                                                                               , Type.var
                                                                                                     "pageData"
                                                                                               , Type.var
                                                                                                     "actionData"
                                                                                               , Type.var
                                                                                                     "sharedData"
                                                                                               , Type.var
                                                                                                     "userEffect"
                                                                                               , Type.var
                                                                                                     "errorPage"
                                                                                               ]
                                                                                        )
                                                                                 )
                                                                          )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "UserCmd"
                       effectTags.userCmd |> Elm.Arg.item
                                                   (Elm.Arg.varWith
                                                          "userEffect"
                                                          (Type.var "userEffect"
                                                          )
                                                   )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "CancelRequest"
                       effectTags.cancelRequest |> Elm.Arg.item
                                                         (Elm.Arg.varWith
                                                                "arg_0"
                                                                Type.int
                                                         )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "RunCmd"
                       effectTags.runCmd |> Elm.Arg.item
                                                  (Elm.Arg.varWith
                                                         "platformCmdCmd"
                                                         (Type.namedWith
                                                                []
                                                                "Cmd"
                                                                [ Type.namedWith
                                                                      [ "Pages"
                                                                      , "Internal"
                                                                      , "Platform"
                                                                      ]
                                                                      "Msg"
                                                                      [ Type.var
                                                                          "userMsg"
                                                                      , Type.var
                                                                          "pageData"
                                                                      , Type.var
                                                                          "actionData"
                                                                      , Type.var
                                                                          "sharedData"
                                                                      , Type.var
                                                                          "errorPage"
                                                                      ]
                                                                ]
                                                         )
                                                  )
                    )
                    Basics.identity
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
        \applicationArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "application"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Internal", "Platform" ]
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
                [ applicationArg_ ]
    , init =
        \initArg_ initArg_0 initArg_1 initArg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "init"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Internal", "Platform" ]
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
                [ initArg_, initArg_0, initArg_1, initArg_2 ]
    , update =
        \updateArg_ updateArg_0 updateArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "update"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Internal", "Platform" ]
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
                [ updateArg_, updateArg_0, updateArg_1 ]
    , view =
        \viewArg_ viewArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Platform" ]
                     , name = "view"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Internal", "Platform" ]
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
                [ viewArg_, viewArg_0 ]
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
                             [ "Pages", "Internal", "Platform" ]
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
                             [ "Pages", "Internal", "Platform" ]
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
                             [ "Pages", "Internal", "Platform" ]
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
                             [ "Pages", "Internal", "Platform" ]
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