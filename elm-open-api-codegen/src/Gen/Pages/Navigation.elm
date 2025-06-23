module Gen.Pages.Navigation exposing ( moduleName_, annotation_, make_, caseOf_ )

{-|
# Generated bindings for Pages.Navigation

@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Navigation" ]


annotation_ : { navigation : Type.Annotation, loadingState : Type.Annotation }
annotation_ =
    { navigation = Type.namedWith [ "Pages", "Navigation" ] "Navigation" []
    , loadingState = Type.namedWith [ "Pages", "Navigation" ] "LoadingState" []
    }


make_ :
    { submitting : Elm.Expression -> Elm.Expression
    , loadAfterSubmit :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , loading : Elm.Expression -> Elm.Expression -> Elm.Expression
    , redirecting : Elm.Expression
    , load : Elm.Expression
    , actionRedirect : Elm.Expression
    }
make_ =
    { submitting =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Navigation" ]
                     , name = "Submitting"
                     , annotation = Just (Type.namedWith [] "Navigation" [])
                     }
                )
                [ ar0 ]
    , loadAfterSubmit =
        \ar0 ar1 ar2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Navigation" ]
                     , name = "LoadAfterSubmit"
                     , annotation = Just (Type.namedWith [] "Navigation" [])
                     }
                )
                [ ar0, ar1, ar2 ]
    , loading =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Navigation" ]
                     , name = "Loading"
                     , annotation = Just (Type.namedWith [] "Navigation" [])
                     }
                )
                [ ar0, ar1 ]
    , redirecting =
        Elm.value
            { importFrom = [ "Pages", "Navigation" ]
            , name = "Redirecting"
            , annotation = Just (Type.namedWith [] "LoadingState" [])
            }
    , load =
        Elm.value
            { importFrom = [ "Pages", "Navigation" ]
            , name = "Load"
            , annotation = Just (Type.namedWith [] "LoadingState" [])
            }
    , actionRedirect =
        Elm.value
            { importFrom = [ "Pages", "Navigation" ]
            , name = "ActionRedirect"
            , annotation = Just (Type.namedWith [] "LoadingState" [])
            }
    }


caseOf_ =
    { navigation =
        \navigationExpression navigationTags ->
            Elm.Case.custom
                navigationExpression
                (Type.namedWith [ "Pages", "Navigation" ] "Navigation" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "Submitting"
                       navigationTags.submitting |> Elm.Arg.item
                                                          (Elm.Arg.varWith
                                                                 "pagesFormDataFormData"
                                                                 (Type.namedWith
                                                                        [ "Pages"
                                                                        , "FormData"
                                                                        ]
                                                                        "FormData"
                                                                        []
                                                                 )
                                                          )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "LoadAfterSubmit"
                       navigationTags.loadAfterSubmit |> Elm.Arg.item
                                                               (Elm.Arg.varWith
                                                                      "pagesFormDataFormData"
                                                                      (Type.namedWith
                                                                             [ "Pages"
                                                                             , "FormData"
                                                                             ]
                                                                             "FormData"
                                                                             []
                                                                      )
                                                               ) |> Elm.Arg.item
                                                                          (Elm.Arg.varWith
                                                                                 "urlPathUrlPath"
                                                                                 (Type.namedWith
                                                                                        [ "UrlPath"
                                                                                        ]
                                                                                        "UrlPath"
                                                                                        []
                                                                                 )
                                                                          ) |> Elm.Arg.item
                                                                                     (Elm.Arg.varWith
                                                                                            "pagesNavigationLoadingState"
                                                                                            (Type.namedWith
                                                                                                   [ "Pages"
                                                                                                   , "Navigation"
                                                                                                   ]
                                                                                                   "LoadingState"
                                                                                                   []
                                                                                            )
                                                                                     )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "Loading"
                       navigationTags.loading |> Elm.Arg.item
                                                       (Elm.Arg.varWith
                                                              "urlPathUrlPath"
                                                              (Type.namedWith
                                                                     [ "UrlPath"
                                                                     ]
                                                                     "UrlPath"
                                                                     []
                                                              )
                                                       ) |> Elm.Arg.item
                                                                  (Elm.Arg.varWith
                                                                         "pagesNavigationLoadingState"
                                                                         (Type.namedWith
                                                                                [ "Pages"
                                                                                , "Navigation"
                                                                                ]
                                                                                "LoadingState"
                                                                                []
                                                                         )
                                                                  )
                    )
                    Basics.identity
                ]
    , loadingState =
        \loadingStateExpression loadingStateTags ->
            Elm.Case.custom
                loadingStateExpression
                (Type.namedWith [ "Pages", "Navigation" ] "LoadingState" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "Redirecting"
                       loadingStateTags.redirecting
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Load" loadingStateTags.load)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ActionRedirect"
                       loadingStateTags.actionRedirect
                    )
                    Basics.identity
                ]
    }