module Gen.Scaffold.Route exposing (addDeclarations, annotation_, buildNoState, buildWithLocalState, buildWithSharedState, call_, caseOf_, make_, moduleNameCliArg, moduleName_, preRender, serverRender, single, values_)

{-| 
@docs moduleName_, buildWithLocalState, buildWithSharedState, buildNoState, serverRender, preRender, single, addDeclarations, moduleNameCliArg, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Scaffold", "Route" ]


{-| buildWithLocalState: 
    { view :
        { shared : Elm.Expression, model : Elm.Expression, app : Elm.Expression }
        -> Elm.Expression
    , update :
        { shared : Elm.Expression
        , app : Elm.Expression
        , msg : Elm.Expression
        , model : Elm.Expression
        }
        -> Elm.Expression
    , init : { shared : Elm.Expression, app : Elm.Expression } -> Elm.Expression
    , subscriptions :
        { routeParams : Elm.Expression
        , path : Elm.Expression
        , shared : Elm.Expression
        , model : Elm.Expression
        }
        -> Elm.Expression
    , msg : Scaffold.Route.Type
    , model : Scaffold.Route.Type
    }
    -> Scaffold.Route.Builder
    -> { path : String, body : String }
-}
buildWithLocalState :
    { view : Elm.Expression -> Elm.Expression
    , update : Elm.Expression -> Elm.Expression
    , init : Elm.Expression -> Elm.Expression
    , subscriptions : Elm.Expression -> Elm.Expression
    , msg : Elm.Expression
    , model : Elm.Expression
    }
    -> Elm.Expression
    -> Elm.Expression
buildWithLocalState buildWithLocalStateArg buildWithLocalStateArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Scaffold", "Route" ]
             , name = "buildWithLocalState"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "view"
                                , Type.function
                                    [ Type.record
                                          [ ( "shared"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "model"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "app"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          ]
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                )
                              , ( "update"
                                , Type.function
                                    [ Type.record
                                          [ ( "shared"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "app"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "msg"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "model"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          ]
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                )
                              , ( "init"
                                , Type.function
                                    [ Type.record
                                          [ ( "shared"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "app"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          ]
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                )
                              , ( "subscriptions"
                                , Type.function
                                    [ Type.record
                                          [ ( "routeParams"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "path"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "shared"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "model"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          ]
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                )
                              , ( "msg"
                                , Type.namedWith
                                    [ "Scaffold", "Route" ]
                                    "Type"
                                    []
                                )
                              , ( "model"
                                , Type.namedWith
                                    [ "Scaffold", "Route" ]
                                    "Type"
                                    []
                                )
                              ]
                          , Type.namedWith [ "Scaffold", "Route" ] "Builder" []
                          ]
                          (Type.record
                               [ ( "path", Type.string )
                               , ( "body", Type.string )
                               ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair
                  "view"
                  (Elm.functionReduced
                       "buildWithLocalStateUnpack"
                       buildWithLocalStateArg.view
                  )
            , Tuple.pair
                  "update"
                  (Elm.functionReduced
                       "buildWithLocalStateUnpack"
                       buildWithLocalStateArg.update
                  )
            , Tuple.pair
                  "init"
                  (Elm.functionReduced
                       "buildWithLocalStateUnpack"
                       buildWithLocalStateArg.init
                  )
            , Tuple.pair
                  "subscriptions"
                  (Elm.functionReduced
                       "buildWithLocalStateUnpack"
                       buildWithLocalStateArg.subscriptions
                  )
            , Tuple.pair "msg" buildWithLocalStateArg.msg
            , Tuple.pair "model" buildWithLocalStateArg.model
            ]
        , buildWithLocalStateArg0
        ]


{-| buildWithSharedState: 
    { view :
        { shared : Elm.Expression, model : Elm.Expression, app : Elm.Expression }
        -> Elm.Expression
    , update :
        { shared : Elm.Expression
        , app : Elm.Expression
        , msg : Elm.Expression
        , model : Elm.Expression
        }
        -> Elm.Expression
    , init : { shared : Elm.Expression, app : Elm.Expression } -> Elm.Expression
    , subscriptions :
        { routeParams : Elm.Expression
        , path : Elm.Expression
        , shared : Elm.Expression
        , model : Elm.Expression
        }
        -> Elm.Expression
    , msg : Scaffold.Route.Type
    , model : Scaffold.Route.Type
    }
    -> Scaffold.Route.Builder
    -> { path : String, body : String }
-}
buildWithSharedState :
    { view : Elm.Expression -> Elm.Expression
    , update : Elm.Expression -> Elm.Expression
    , init : Elm.Expression -> Elm.Expression
    , subscriptions : Elm.Expression -> Elm.Expression
    , msg : Elm.Expression
    , model : Elm.Expression
    }
    -> Elm.Expression
    -> Elm.Expression
buildWithSharedState buildWithSharedStateArg buildWithSharedStateArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Scaffold", "Route" ]
             , name = "buildWithSharedState"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "view"
                                , Type.function
                                    [ Type.record
                                          [ ( "shared"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "model"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "app"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          ]
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                )
                              , ( "update"
                                , Type.function
                                    [ Type.record
                                          [ ( "shared"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "app"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "msg"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "model"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          ]
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                )
                              , ( "init"
                                , Type.function
                                    [ Type.record
                                          [ ( "shared"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "app"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          ]
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                )
                              , ( "subscriptions"
                                , Type.function
                                    [ Type.record
                                          [ ( "routeParams"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "path"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "shared"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "model"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          ]
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                )
                              , ( "msg"
                                , Type.namedWith
                                    [ "Scaffold", "Route" ]
                                    "Type"
                                    []
                                )
                              , ( "model"
                                , Type.namedWith
                                    [ "Scaffold", "Route" ]
                                    "Type"
                                    []
                                )
                              ]
                          , Type.namedWith [ "Scaffold", "Route" ] "Builder" []
                          ]
                          (Type.record
                               [ ( "path", Type.string )
                               , ( "body", Type.string )
                               ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair
                  "view"
                  (Elm.functionReduced
                       "buildWithSharedStateUnpack"
                       buildWithSharedStateArg.view
                  )
            , Tuple.pair
                  "update"
                  (Elm.functionReduced
                       "buildWithSharedStateUnpack"
                       buildWithSharedStateArg.update
                  )
            , Tuple.pair
                  "init"
                  (Elm.functionReduced
                       "buildWithSharedStateUnpack"
                       buildWithSharedStateArg.init
                  )
            , Tuple.pair
                  "subscriptions"
                  (Elm.functionReduced
                       "buildWithSharedStateUnpack"
                       buildWithSharedStateArg.subscriptions
                  )
            , Tuple.pair "msg" buildWithSharedStateArg.msg
            , Tuple.pair "model" buildWithSharedStateArg.model
            ]
        , buildWithSharedStateArg0
        ]


{-| buildNoState: 
    { view : { shared : Elm.Expression, app : Elm.Expression } -> Elm.Expression }
    -> Scaffold.Route.Builder
    -> { path : String, body : String }
-}
buildNoState :
    { view : Elm.Expression -> Elm.Expression }
    -> Elm.Expression
    -> Elm.Expression
buildNoState buildNoStateArg buildNoStateArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Scaffold", "Route" ]
             , name = "buildNoState"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "view"
                                , Type.function
                                    [ Type.record
                                          [ ( "shared"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          , ( "app"
                                            , Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            )
                                          ]
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                )
                              ]
                          , Type.namedWith [ "Scaffold", "Route" ] "Builder" []
                          ]
                          (Type.record
                               [ ( "path", Type.string )
                               , ( "body", Type.string )
                               ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair
                  "view"
                  (Elm.functionReduced "buildNoStateUnpack" buildNoStateArg.view
                  )
            ]
        , buildNoStateArg0
        ]


{-| serverRender: 
    { data :
        ( Scaffold.Route.Type, Elm.Expression -> Elm.Expression -> Elm.Expression )
    , action :
        ( Scaffold.Route.Type, Elm.Expression -> Elm.Expression -> Elm.Expression )
    , head : Elm.Expression -> Elm.Expression
    , moduleName : List String
    }
    -> Scaffold.Route.Builder
-}
serverRender :
    { data : Elm.Expression
    , action : Elm.Expression
    , head : Elm.Expression -> Elm.Expression
    , moduleName : List String
    }
    -> Elm.Expression
serverRender serverRenderArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Scaffold", "Route" ]
             , name = "serverRender"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "data"
                                , Type.tuple
                                    (Type.namedWith
                                       [ "Scaffold", "Route" ]
                                       "Type"
                                       []
                                    )
                                    (Type.function
                                       [ Type.namedWith
                                             [ "Elm" ]
                                             "Expression"
                                             []
                                       , Type.namedWith
                                             [ "Elm" ]
                                             "Expression"
                                             []
                                       ]
                                       (Type.namedWith [ "Elm" ] "Expression" []
                                       )
                                    )
                                )
                              , ( "action"
                                , Type.tuple
                                    (Type.namedWith
                                       [ "Scaffold", "Route" ]
                                       "Type"
                                       []
                                    )
                                    (Type.function
                                       [ Type.namedWith
                                             [ "Elm" ]
                                             "Expression"
                                             []
                                       , Type.namedWith
                                             [ "Elm" ]
                                             "Expression"
                                             []
                                       ]
                                       (Type.namedWith [ "Elm" ] "Expression" []
                                       )
                                    )
                                )
                              , ( "head"
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                )
                              , ( "moduleName", Type.list Type.string )
                              ]
                          ]
                          (Type.namedWith [ "Scaffold", "Route" ] "Builder" [])
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "data" serverRenderArg.data
            , Tuple.pair "action" serverRenderArg.action
            , Tuple.pair
                  "head"
                  (Elm.functionReduced "serverRenderUnpack" serverRenderArg.head
                  )
            , Tuple.pair
                  "moduleName"
                  (Elm.list (List.map Elm.string serverRenderArg.moduleName))
            ]
        ]


{-| Will scaffold using `RouteBuilder.preRender` if there are any dynamic segments (as in `Company.Team.Name_`),
or using `RouteBuilder.single` if there are no dynamic segments (as in `Company.AboutUs`).

When there are no dynamic segments, the `pages` field will be ignored as it is only relevant for Routes with dynamic segments.

For dynamic segments, the `routeParams` parameter in the `data` function will be an `Elm.Expression` with the `RouteParams` parameter in the `data` function.
For static segments, it will be a hardcoded empty record (`{}`).

preRender: 
    { data : ( Scaffold.Route.Type, Elm.Expression -> Elm.Expression )
    , pages : Elm.Expression
    , head : Elm.Expression -> Elm.Expression
    , moduleName : List String
    }
    -> Scaffold.Route.Builder
-}
preRender :
    { data : Elm.Expression
    , pages : Elm.Expression
    , head : Elm.Expression -> Elm.Expression
    , moduleName : List String
    }
    -> Elm.Expression
preRender preRenderArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Scaffold", "Route" ]
             , name = "preRender"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "data"
                                , Type.tuple
                                    (Type.namedWith
                                       [ "Scaffold", "Route" ]
                                       "Type"
                                       []
                                    )
                                    (Type.function
                                       [ Type.namedWith
                                             [ "Elm" ]
                                             "Expression"
                                             []
                                       ]
                                       (Type.namedWith [ "Elm" ] "Expression" []
                                       )
                                    )
                                )
                              , ( "pages"
                                , Type.namedWith [ "Elm" ] "Expression" []
                                )
                              , ( "head"
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                )
                              , ( "moduleName", Type.list Type.string )
                              ]
                          ]
                          (Type.namedWith [ "Scaffold", "Route" ] "Builder" [])
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "data" preRenderArg.data
            , Tuple.pair "pages" preRenderArg.pages
            , Tuple.pair
                  "head"
                  (Elm.functionReduced "preRenderUnpack" preRenderArg.head)
            , Tuple.pair
                  "moduleName"
                  (Elm.list (List.map Elm.string preRenderArg.moduleName))
            ]
        ]


{-| @depreacted. This is obsolete and will be removed in a future release. Use [`preRender`](#preRender) instead.

If you pass in only static route segments as the `moduleName` to `preRender` it will yield the same result as `single`.

single: 
    { data : ( Scaffold.Route.Type, Elm.Expression )
    , head : Elm.Expression -> Elm.Expression
    , moduleName : List String
    }
    -> Scaffold.Route.Builder
-}
single :
    { data : Elm.Expression
    , head : Elm.Expression -> Elm.Expression
    , moduleName : List String
    }
    -> Elm.Expression
single singleArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Scaffold", "Route" ]
             , name = "single"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "data"
                                , Type.tuple
                                    (Type.namedWith
                                       [ "Scaffold", "Route" ]
                                       "Type"
                                       []
                                    )
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                )
                              , ( "head"
                                , Type.function
                                    [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                )
                              , ( "moduleName", Type.list Type.string )
                              ]
                          ]
                          (Type.namedWith [ "Scaffold", "Route" ] "Builder" [])
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "data" singleArg.data
            , Tuple.pair
                  "head"
                  (Elm.functionReduced "singleUnpack" singleArg.head)
            , Tuple.pair
                  "moduleName"
                  (Elm.list (List.map Elm.string singleArg.moduleName))
            ]
        ]


{-| The helpers in this module help you generate a Route module file with the core boilerplate abstracted away.

You can also define additional top-level declarations in the generated Route module using this helper.

addDeclarations: List Elm.Declaration -> Scaffold.Route.Builder -> Scaffold.Route.Builder
-}
addDeclarations : List Elm.Expression -> Elm.Expression -> Elm.Expression
addDeclarations addDeclarationsArg addDeclarationsArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Scaffold", "Route" ]
             , name = "addDeclarations"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith [ "Elm" ] "Declaration" [])
                          , Type.namedWith [ "Scaffold", "Route" ] "Builder" []
                          ]
                          (Type.namedWith [ "Scaffold", "Route" ] "Builder" [])
                     )
             }
        )
        [ Elm.list addDeclarationsArg, addDeclarationsArg0 ]


{-| A positional argument for elm-cli-options-parser that does a Regex validation to check that the module name is a valid Elm Route module name.

moduleNameCliArg: 
    Cli.Option.Option from String builderState
    -> Cli.Option.Option from (List String) builderState
-}
moduleNameCliArg : Elm.Expression -> Elm.Expression
moduleNameCliArg moduleNameCliArgArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Scaffold", "Route" ]
             , name = "moduleNameCliArg"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Cli", "Option" ]
                              "Option"
                              [ Type.var "from"
                              , Type.string
                              , Type.var "builderState"
                              ]
                          ]
                          (Type.namedWith
                               [ "Cli", "Option" ]
                               "Option"
                               [ Type.var "from"
                               , Type.list Type.string
                               , Type.var "builderState"
                               ]
                          )
                     )
             }
        )
        [ moduleNameCliArgArg ]


annotation_ : { builder : Type.Annotation, type_ : Type.Annotation }
annotation_ =
    { builder = Type.namedWith [ "Scaffold", "Route" ] "Builder" []
    , type_ = Type.namedWith [ "Scaffold", "Route" ] "Type" []
    }


make_ :
    { alias : Elm.Expression -> Elm.Expression
    , custom : Elm.Expression -> Elm.Expression
    }
make_ =
    { alias =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Scaffold", "Route" ]
                     , name = "Alias"
                     , annotation = Just (Type.namedWith [] "Type" [])
                     }
                )
                [ ar0 ]
    , custom =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Scaffold", "Route" ]
                     , name = "Custom"
                     , annotation = Just (Type.namedWith [] "Type" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { type_ :
        Elm.Expression
        -> { typeTags_0_0
            | alias : Elm.Expression -> Elm.Expression
            , custom : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { type_ =
        \typeExpression typeTags ->
            Elm.Case.custom
                typeExpression
                (Type.namedWith [ "Scaffold", "Route" ] "Type" [])
                [ Elm.Case.branch1
                    "Alias"
                    ( "elmAnnotationAnnotation"
                    , Type.namedWith [ "Elm", "Annotation" ] "Annotation" []
                    )
                    typeTags.alias
                , Elm.Case.branch1
                    "Custom"
                    ( "listList"
                    , Type.list (Type.namedWith [ "Elm" ] "Variant" [])
                    )
                    typeTags.custom
                ]
    }


call_ :
    { buildWithLocalState : Elm.Expression -> Elm.Expression -> Elm.Expression
    , buildWithSharedState : Elm.Expression -> Elm.Expression -> Elm.Expression
    , buildNoState : Elm.Expression -> Elm.Expression -> Elm.Expression
    , serverRender : Elm.Expression -> Elm.Expression
    , preRender : Elm.Expression -> Elm.Expression
    , single : Elm.Expression -> Elm.Expression
    , addDeclarations : Elm.Expression -> Elm.Expression -> Elm.Expression
    , moduleNameCliArg : Elm.Expression -> Elm.Expression
    }
call_ =
    { buildWithLocalState =
        \buildWithLocalStateArg buildWithLocalStateArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Scaffold", "Route" ]
                     , name = "buildWithLocalState"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "view"
                                        , Type.function
                                            [ Type.record
                                                  [ ( "shared"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "model"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "app"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  ]
                                            ]
                                            (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                            )
                                        )
                                      , ( "update"
                                        , Type.function
                                            [ Type.record
                                                  [ ( "shared"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "app"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "msg"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "model"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  ]
                                            ]
                                            (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                            )
                                        )
                                      , ( "init"
                                        , Type.function
                                            [ Type.record
                                                  [ ( "shared"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "app"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  ]
                                            ]
                                            (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                            )
                                        )
                                      , ( "subscriptions"
                                        , Type.function
                                            [ Type.record
                                                  [ ( "routeParams"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "path"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "shared"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "model"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  ]
                                            ]
                                            (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                            )
                                        )
                                      , ( "msg"
                                        , Type.namedWith
                                            [ "Scaffold", "Route" ]
                                            "Type"
                                            []
                                        )
                                      , ( "model"
                                        , Type.namedWith
                                            [ "Scaffold", "Route" ]
                                            "Type"
                                            []
                                        )
                                      ]
                                  , Type.namedWith
                                      [ "Scaffold", "Route" ]
                                      "Builder"
                                      []
                                  ]
                                  (Type.record
                                       [ ( "path", Type.string )
                                       , ( "body", Type.string )
                                       ]
                                  )
                             )
                     }
                )
                [ buildWithLocalStateArg, buildWithLocalStateArg0 ]
    , buildWithSharedState =
        \buildWithSharedStateArg buildWithSharedStateArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Scaffold", "Route" ]
                     , name = "buildWithSharedState"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "view"
                                        , Type.function
                                            [ Type.record
                                                  [ ( "shared"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "model"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "app"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  ]
                                            ]
                                            (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                            )
                                        )
                                      , ( "update"
                                        , Type.function
                                            [ Type.record
                                                  [ ( "shared"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "app"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "msg"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "model"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  ]
                                            ]
                                            (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                            )
                                        )
                                      , ( "init"
                                        , Type.function
                                            [ Type.record
                                                  [ ( "shared"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "app"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  ]
                                            ]
                                            (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                            )
                                        )
                                      , ( "subscriptions"
                                        , Type.function
                                            [ Type.record
                                                  [ ( "routeParams"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "path"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "shared"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "model"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  ]
                                            ]
                                            (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                            )
                                        )
                                      , ( "msg"
                                        , Type.namedWith
                                            [ "Scaffold", "Route" ]
                                            "Type"
                                            []
                                        )
                                      , ( "model"
                                        , Type.namedWith
                                            [ "Scaffold", "Route" ]
                                            "Type"
                                            []
                                        )
                                      ]
                                  , Type.namedWith
                                      [ "Scaffold", "Route" ]
                                      "Builder"
                                      []
                                  ]
                                  (Type.record
                                       [ ( "path", Type.string )
                                       , ( "body", Type.string )
                                       ]
                                  )
                             )
                     }
                )
                [ buildWithSharedStateArg, buildWithSharedStateArg0 ]
    , buildNoState =
        \buildNoStateArg buildNoStateArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Scaffold", "Route" ]
                     , name = "buildNoState"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "view"
                                        , Type.function
                                            [ Type.record
                                                  [ ( "shared"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  , ( "app"
                                                    , Type.namedWith
                                                          [ "Elm" ]
                                                          "Expression"
                                                          []
                                                    )
                                                  ]
                                            ]
                                            (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                            )
                                        )
                                      ]
                                  , Type.namedWith
                                      [ "Scaffold", "Route" ]
                                      "Builder"
                                      []
                                  ]
                                  (Type.record
                                       [ ( "path", Type.string )
                                       , ( "body", Type.string )
                                       ]
                                  )
                             )
                     }
                )
                [ buildNoStateArg, buildNoStateArg0 ]
    , serverRender =
        \serverRenderArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Scaffold", "Route" ]
                     , name = "serverRender"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "data"
                                        , Type.tuple
                                            (Type.namedWith
                                               [ "Scaffold", "Route" ]
                                               "Type"
                                               []
                                            )
                                            (Type.function
                                               [ Type.namedWith
                                                     [ "Elm" ]
                                                     "Expression"
                                                     []
                                               , Type.namedWith
                                                     [ "Elm" ]
                                                     "Expression"
                                                     []
                                               ]
                                               (Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                               )
                                            )
                                        )
                                      , ( "action"
                                        , Type.tuple
                                            (Type.namedWith
                                               [ "Scaffold", "Route" ]
                                               "Type"
                                               []
                                            )
                                            (Type.function
                                               [ Type.namedWith
                                                     [ "Elm" ]
                                                     "Expression"
                                                     []
                                               , Type.namedWith
                                                     [ "Elm" ]
                                                     "Expression"
                                                     []
                                               ]
                                               (Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                               )
                                            )
                                        )
                                      , ( "head"
                                        , Type.function
                                            [ Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            ]
                                            (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                            )
                                        )
                                      , ( "moduleName", Type.list Type.string )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Scaffold", "Route" ]
                                       "Builder"
                                       []
                                  )
                             )
                     }
                )
                [ serverRenderArg ]
    , preRender =
        \preRenderArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Scaffold", "Route" ]
                     , name = "preRender"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "data"
                                        , Type.tuple
                                            (Type.namedWith
                                               [ "Scaffold", "Route" ]
                                               "Type"
                                               []
                                            )
                                            (Type.function
                                               [ Type.namedWith
                                                     [ "Elm" ]
                                                     "Expression"
                                                     []
                                               ]
                                               (Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                               )
                                            )
                                        )
                                      , ( "pages"
                                        , Type.namedWith
                                            [ "Elm" ]
                                            "Expression"
                                            []
                                        )
                                      , ( "head"
                                        , Type.function
                                            [ Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            ]
                                            (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                            )
                                        )
                                      , ( "moduleName", Type.list Type.string )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Scaffold", "Route" ]
                                       "Builder"
                                       []
                                  )
                             )
                     }
                )
                [ preRenderArg ]
    , single =
        \singleArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Scaffold", "Route" ]
                     , name = "single"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "data"
                                        , Type.tuple
                                            (Type.namedWith
                                               [ "Scaffold", "Route" ]
                                               "Type"
                                               []
                                            )
                                            (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                            )
                                        )
                                      , ( "head"
                                        , Type.function
                                            [ Type.namedWith
                                                  [ "Elm" ]
                                                  "Expression"
                                                  []
                                            ]
                                            (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                            )
                                        )
                                      , ( "moduleName", Type.list Type.string )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Scaffold", "Route" ]
                                       "Builder"
                                       []
                                  )
                             )
                     }
                )
                [ singleArg ]
    , addDeclarations =
        \addDeclarationsArg addDeclarationsArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Scaffold", "Route" ]
                     , name = "addDeclarations"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith [ "Elm" ] "Declaration" []
                                      )
                                  , Type.namedWith
                                      [ "Scaffold", "Route" ]
                                      "Builder"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Scaffold", "Route" ]
                                       "Builder"
                                       []
                                  )
                             )
                     }
                )
                [ addDeclarationsArg, addDeclarationsArg0 ]
    , moduleNameCliArg =
        \moduleNameCliArgArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Scaffold", "Route" ]
                     , name = "moduleNameCliArg"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Cli", "Option" ]
                                      "Option"
                                      [ Type.var "from"
                                      , Type.string
                                      , Type.var "builderState"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Cli", "Option" ]
                                       "Option"
                                       [ Type.var "from"
                                       , Type.list Type.string
                                       , Type.var "builderState"
                                       ]
                                  )
                             )
                     }
                )
                [ moduleNameCliArgArg ]
    }


values_ :
    { buildWithLocalState : Elm.Expression
    , buildWithSharedState : Elm.Expression
    , buildNoState : Elm.Expression
    , serverRender : Elm.Expression
    , preRender : Elm.Expression
    , single : Elm.Expression
    , addDeclarations : Elm.Expression
    , moduleNameCliArg : Elm.Expression
    }
values_ =
    { buildWithLocalState =
        Elm.value
            { importFrom = [ "Scaffold", "Route" ]
            , name = "buildWithLocalState"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "view"
                               , Type.function
                                   [ Type.record
                                         [ ( "shared"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "model"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "app"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         ]
                                   ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               )
                             , ( "update"
                               , Type.function
                                   [ Type.record
                                         [ ( "shared"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "app"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "msg"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "model"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         ]
                                   ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               )
                             , ( "init"
                               , Type.function
                                   [ Type.record
                                         [ ( "shared"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "app"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         ]
                                   ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               )
                             , ( "subscriptions"
                               , Type.function
                                   [ Type.record
                                         [ ( "routeParams"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "path"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "shared"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "model"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         ]
                                   ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               )
                             , ( "msg"
                               , Type.namedWith
                                   [ "Scaffold", "Route" ]
                                   "Type"
                                   []
                               )
                             , ( "model"
                               , Type.namedWith
                                   [ "Scaffold", "Route" ]
                                   "Type"
                                   []
                               )
                             ]
                         , Type.namedWith [ "Scaffold", "Route" ] "Builder" []
                         ]
                         (Type.record
                              [ ( "path", Type.string )
                              , ( "body", Type.string )
                              ]
                         )
                    )
            }
    , buildWithSharedState =
        Elm.value
            { importFrom = [ "Scaffold", "Route" ]
            , name = "buildWithSharedState"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "view"
                               , Type.function
                                   [ Type.record
                                         [ ( "shared"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "model"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "app"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         ]
                                   ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               )
                             , ( "update"
                               , Type.function
                                   [ Type.record
                                         [ ( "shared"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "app"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "msg"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "model"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         ]
                                   ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               )
                             , ( "init"
                               , Type.function
                                   [ Type.record
                                         [ ( "shared"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "app"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         ]
                                   ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               )
                             , ( "subscriptions"
                               , Type.function
                                   [ Type.record
                                         [ ( "routeParams"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "path"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "shared"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "model"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         ]
                                   ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               )
                             , ( "msg"
                               , Type.namedWith
                                   [ "Scaffold", "Route" ]
                                   "Type"
                                   []
                               )
                             , ( "model"
                               , Type.namedWith
                                   [ "Scaffold", "Route" ]
                                   "Type"
                                   []
                               )
                             ]
                         , Type.namedWith [ "Scaffold", "Route" ] "Builder" []
                         ]
                         (Type.record
                              [ ( "path", Type.string )
                              , ( "body", Type.string )
                              ]
                         )
                    )
            }
    , buildNoState =
        Elm.value
            { importFrom = [ "Scaffold", "Route" ]
            , name = "buildNoState"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "view"
                               , Type.function
                                   [ Type.record
                                         [ ( "shared"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         , ( "app"
                                           , Type.namedWith
                                                 [ "Elm" ]
                                                 "Expression"
                                                 []
                                           )
                                         ]
                                   ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               )
                             ]
                         , Type.namedWith [ "Scaffold", "Route" ] "Builder" []
                         ]
                         (Type.record
                              [ ( "path", Type.string )
                              , ( "body", Type.string )
                              ]
                         )
                    )
            }
    , serverRender =
        Elm.value
            { importFrom = [ "Scaffold", "Route" ]
            , name = "serverRender"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "data"
                               , Type.tuple
                                   (Type.namedWith
                                      [ "Scaffold", "Route" ]
                                      "Type"
                                      []
                                   )
                                   (Type.function
                                      [ Type.namedWith [ "Elm" ] "Expression" []
                                      , Type.namedWith [ "Elm" ] "Expression" []
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                   )
                               )
                             , ( "action"
                               , Type.tuple
                                   (Type.namedWith
                                      [ "Scaffold", "Route" ]
                                      "Type"
                                      []
                                   )
                                   (Type.function
                                      [ Type.namedWith [ "Elm" ] "Expression" []
                                      , Type.namedWith [ "Elm" ] "Expression" []
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                   )
                               )
                             , ( "head"
                               , Type.function
                                   [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               )
                             , ( "moduleName", Type.list Type.string )
                             ]
                         ]
                         (Type.namedWith [ "Scaffold", "Route" ] "Builder" [])
                    )
            }
    , preRender =
        Elm.value
            { importFrom = [ "Scaffold", "Route" ]
            , name = "preRender"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "data"
                               , Type.tuple
                                   (Type.namedWith
                                      [ "Scaffold", "Route" ]
                                      "Type"
                                      []
                                   )
                                   (Type.function
                                      [ Type.namedWith [ "Elm" ] "Expression" []
                                      ]
                                      (Type.namedWith [ "Elm" ] "Expression" [])
                                   )
                               )
                             , ( "pages"
                               , Type.namedWith [ "Elm" ] "Expression" []
                               )
                             , ( "head"
                               , Type.function
                                   [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               )
                             , ( "moduleName", Type.list Type.string )
                             ]
                         ]
                         (Type.namedWith [ "Scaffold", "Route" ] "Builder" [])
                    )
            }
    , single =
        Elm.value
            { importFrom = [ "Scaffold", "Route" ]
            , name = "single"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "data"
                               , Type.tuple
                                   (Type.namedWith
                                      [ "Scaffold", "Route" ]
                                      "Type"
                                      []
                                   )
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               )
                             , ( "head"
                               , Type.function
                                   [ Type.namedWith [ "Elm" ] "Expression" [] ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               )
                             , ( "moduleName", Type.list Type.string )
                             ]
                         ]
                         (Type.namedWith [ "Scaffold", "Route" ] "Builder" [])
                    )
            }
    , addDeclarations =
        Elm.value
            { importFrom = [ "Scaffold", "Route" ]
            , name = "addDeclarations"
            , annotation =
                Just
                    (Type.function
                         [ Type.list (Type.namedWith [ "Elm" ] "Declaration" [])
                         , Type.namedWith [ "Scaffold", "Route" ] "Builder" []
                         ]
                         (Type.namedWith [ "Scaffold", "Route" ] "Builder" [])
                    )
            }
    , moduleNameCliArg =
        Elm.value
            { importFrom = [ "Scaffold", "Route" ]
            , name = "moduleNameCliArg"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Cli", "Option" ]
                             "Option"
                             [ Type.var "from"
                             , Type.string
                             , Type.var "builderState"
                             ]
                         ]
                         (Type.namedWith
                              [ "Cli", "Option" ]
                              "Option"
                              [ Type.var "from"
                              , Type.list Type.string
                              , Type.var "builderState"
                              ]
                         )
                    )
            }
    }