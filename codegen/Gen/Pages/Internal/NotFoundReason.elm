module Gen.Pages.Internal.NotFoundReason exposing (annotation_, call_, caseOf_, document, make_, moduleName_, values_)

{-| 
@docs moduleName_, document, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Internal", "NotFoundReason" ]


{-| document: 
    List Pages.Internal.RoutePattern.RoutePattern
    -> Pages.Internal.NotFoundReason.Payload
    -> { title : String, body : List (Html.Html msg) }
-}
document : List Elm.Expression -> Elm.Expression -> Elm.Expression
document documentArg documentArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "NotFoundReason" ]
             , name = "document"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "Pages", "Internal", "RoutePattern" ]
                                 "RoutePattern"
                                 []
                              )
                          , Type.namedWith
                              [ "Pages", "Internal", "NotFoundReason" ]
                              "Payload"
                              []
                          ]
                          (Type.record
                               [ ( "title", Type.string )
                               , ( "body"
                                 , Type.list
                                       (Type.namedWith
                                            [ "Html" ]
                                            "Html"
                                            [ Type.var "msg" ]
                                       )
                                 )
                               ]
                          )
                     )
             }
        )
        [ Elm.list documentArg, documentArg0 ]


annotation_ :
    { moduleContext : Type.Annotation
    , notFoundReason : Type.Annotation
    , payload : Type.Annotation
    , record : Type.Annotation
    }
annotation_ =
    { moduleContext =
        Type.alias
            moduleName_
            "ModuleContext"
            []
            (Type.record
                 [ ( "moduleName", Type.list Type.string )
                 , ( "routePattern"
                   , Type.namedWith
                         [ "Pages", "Internal", "RoutePattern" ]
                         "RoutePattern"
                         []
                   )
                 , ( "matchedRouteParams"
                   , Type.namedWith
                         [ "Pages", "Internal", "NotFoundReason" ]
                         "Record"
                         []
                   )
                 ]
            )
    , notFoundReason =
        Type.namedWith
            [ "Pages", "Internal", "NotFoundReason" ]
            "NotFoundReason"
            []
    , payload =
        Type.alias
            moduleName_
            "Payload"
            []
            (Type.record
                 [ ( "path", Type.namedWith [ "UrlPath" ] "UrlPath" [] )
                 , ( "reason"
                   , Type.namedWith
                         [ "Pages", "Internal", "NotFoundReason" ]
                         "NotFoundReason"
                         []
                   )
                 ]
            )
    , record =
        Type.alias
            moduleName_
            "Record"
            []
            (Type.list (Type.tuple Type.string Type.string))
    }


make_ :
    { moduleContext :
        { moduleName : Elm.Expression
        , routePattern : Elm.Expression
        , matchedRouteParams : Elm.Expression
        }
        -> Elm.Expression
    , noMatchingRoute : Elm.Expression
    , notPrerendered : Elm.Expression -> Elm.Expression -> Elm.Expression
    , notPrerenderedOrHandledByFallback :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , unhandledServerRoute : Elm.Expression -> Elm.Expression
    , payload :
        { path : Elm.Expression, reason : Elm.Expression } -> Elm.Expression
    }
make_ =
    { moduleContext =
        \moduleContext_args ->
            Elm.withType
                (Type.alias
                     [ "Pages", "Internal", "NotFoundReason" ]
                     "ModuleContext"
                     []
                     (Type.record
                          [ ( "moduleName", Type.list Type.string )
                          , ( "routePattern"
                            , Type.namedWith
                                  [ "Pages", "Internal", "RoutePattern" ]
                                  "RoutePattern"
                                  []
                            )
                          , ( "matchedRouteParams"
                            , Type.namedWith
                                  [ "Pages", "Internal", "NotFoundReason" ]
                                  "Record"
                                  []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "moduleName" moduleContext_args.moduleName
                     , Tuple.pair "routePattern" moduleContext_args.routePattern
                     , Tuple.pair
                         "matchedRouteParams"
                         moduleContext_args.matchedRouteParams
                     ]
                )
    , noMatchingRoute =
        Elm.value
            { importFrom = [ "Pages", "Internal", "NotFoundReason" ]
            , name = "NoMatchingRoute"
            , annotation = Just (Type.namedWith [] "NotFoundReason" [])
            }
    , notPrerendered =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "NotFoundReason" ]
                     , name = "NotPrerendered"
                     , annotation = Just (Type.namedWith [] "NotFoundReason" [])
                     }
                )
                [ ar0, ar1 ]
    , notPrerenderedOrHandledByFallback =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "NotFoundReason" ]
                     , name = "NotPrerenderedOrHandledByFallback"
                     , annotation = Just (Type.namedWith [] "NotFoundReason" [])
                     }
                )
                [ ar0, ar1 ]
    , unhandledServerRoute =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "NotFoundReason" ]
                     , name = "UnhandledServerRoute"
                     , annotation = Just (Type.namedWith [] "NotFoundReason" [])
                     }
                )
                [ ar0 ]
    , payload =
        \payload_args ->
            Elm.withType
                (Type.alias
                     [ "Pages", "Internal", "NotFoundReason" ]
                     "Payload"
                     []
                     (Type.record
                          [ ( "path"
                            , Type.namedWith [ "UrlPath" ] "UrlPath" []
                            )
                          , ( "reason"
                            , Type.namedWith
                                  [ "Pages", "Internal", "NotFoundReason" ]
                                  "NotFoundReason"
                                  []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "path" payload_args.path
                     , Tuple.pair "reason" payload_args.reason
                     ]
                )
    }


caseOf_ :
    { notFoundReason :
        Elm.Expression
        -> { notFoundReasonTags_0_0
            | noMatchingRoute : Elm.Expression
            , notPrerendered :
                Elm.Expression -> Elm.Expression -> Elm.Expression
            , notPrerenderedOrHandledByFallback :
                Elm.Expression -> Elm.Expression -> Elm.Expression
            , unhandledServerRoute : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { notFoundReason =
        \notFoundReasonExpression notFoundReasonTags ->
            Elm.Case.custom
                notFoundReasonExpression
                (Type.namedWith
                     [ "Pages", "Internal", "NotFoundReason" ]
                     "NotFoundReason"
                     []
                )
                [ Elm.Case.branch0
                    "NoMatchingRoute"
                    notFoundReasonTags.noMatchingRoute
                , Elm.Case.branch2
                    "NotPrerendered"
                    ( "pagesInternalNotFoundReasonModuleContext"
                    , Type.namedWith
                          [ "Pages", "Internal", "NotFoundReason" ]
                          "ModuleContext"
                          []
                    )
                    ( "listList"
                    , Type.list
                          (Type.namedWith
                               [ "Pages", "Internal", "NotFoundReason" ]
                               "Record"
                               []
                          )
                    )
                    notFoundReasonTags.notPrerendered
                , Elm.Case.branch2
                    "NotPrerenderedOrHandledByFallback"
                    ( "pagesInternalNotFoundReasonModuleContext"
                    , Type.namedWith
                          [ "Pages", "Internal", "NotFoundReason" ]
                          "ModuleContext"
                          []
                    )
                    ( "listList"
                    , Type.list
                          (Type.namedWith
                               [ "Pages", "Internal", "NotFoundReason" ]
                               "Record"
                               []
                          )
                    )
                    notFoundReasonTags.notPrerenderedOrHandledByFallback
                , Elm.Case.branch1
                    "UnhandledServerRoute"
                    ( "pagesInternalNotFoundReasonModuleContext"
                    , Type.namedWith
                          [ "Pages", "Internal", "NotFoundReason" ]
                          "ModuleContext"
                          []
                    )
                    notFoundReasonTags.unhandledServerRoute
                ]
    }


call_ : { document : Elm.Expression -> Elm.Expression -> Elm.Expression }
call_ =
    { document =
        \documentArg documentArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "NotFoundReason" ]
                     , name = "document"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "Pages", "Internal", "RoutePattern" ]
                                         "RoutePattern"
                                         []
                                      )
                                  , Type.namedWith
                                      [ "Pages", "Internal", "NotFoundReason" ]
                                      "Payload"
                                      []
                                  ]
                                  (Type.record
                                       [ ( "title", Type.string )
                                       , ( "body"
                                         , Type.list
                                               (Type.namedWith
                                                    [ "Html" ]
                                                    "Html"
                                                    [ Type.var "msg" ]
                                               )
                                         )
                                       ]
                                  )
                             )
                     }
                )
                [ documentArg, documentArg0 ]
    }


values_ : { document : Elm.Expression }
values_ =
    { document =
        Elm.value
            { importFrom = [ "Pages", "Internal", "NotFoundReason" ]
            , name = "document"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "Pages", "Internal", "RoutePattern" ]
                                "RoutePattern"
                                []
                             )
                         , Type.namedWith
                             [ "Pages", "Internal", "NotFoundReason" ]
                             "Payload"
                             []
                         ]
                         (Type.record
                              [ ( "title", Type.string )
                              , ( "body"
                                , Type.list
                                      (Type.namedWith
                                           [ "Html" ]
                                           "Html"
                                           [ Type.var "msg" ]
                                      )
                                )
                              ]
                         )
                    )
            }
    }