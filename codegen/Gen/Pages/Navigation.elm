module Gen.Pages.Navigation exposing (annotation_, caseOf_, make_, moduleName_)

{-| 
@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
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


caseOf_ :
    { navigation :
        Elm.Expression
        -> { navigationTags_0_0
            | submitting : Elm.Expression -> Elm.Expression
            , loadAfterSubmit :
                Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
            , loading : Elm.Expression -> Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , loadingState :
        Elm.Expression
        -> { loadingStateTags_1_0
            | redirecting : Elm.Expression
            , load : Elm.Expression
            , actionRedirect : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { navigation =
        \navigationExpression navigationTags ->
            Elm.Case.custom
                navigationExpression
                (Type.namedWith [ "Pages", "Navigation" ] "Navigation" [])
                [ Elm.Case.branch1
                    "Submitting"
                    ( "pagesFormDataFormData"
                    , Type.namedWith [ "Pages", "FormData" ] "FormData" []
                    )
                    navigationTags.submitting
                , Elm.Case.branch3
                    "LoadAfterSubmit"
                    ( "pagesFormDataFormData"
                    , Type.namedWith [ "Pages", "FormData" ] "FormData" []
                    )
                    ( "urlPathUrlPath"
                    , Type.namedWith [ "UrlPath" ] "UrlPath" []
                    )
                    ( "pagesNavigationLoadingState"
                    , Type.namedWith [ "Pages", "Navigation" ] "LoadingState" []
                    )
                    navigationTags.loadAfterSubmit
                , Elm.Case.branch2
                    "Loading"
                    ( "urlPathUrlPath"
                    , Type.namedWith [ "UrlPath" ] "UrlPath" []
                    )
                    ( "pagesNavigationLoadingState"
                    , Type.namedWith [ "Pages", "Navigation" ] "LoadingState" []
                    )
                    navigationTags.loading
                ]
    , loadingState =
        \loadingStateExpression loadingStateTags ->
            Elm.Case.custom
                loadingStateExpression
                (Type.namedWith [ "Pages", "Navigation" ] "LoadingState" [])
                [ Elm.Case.branch0 "Redirecting" loadingStateTags.redirecting
                , Elm.Case.branch0 "Load" loadingStateTags.load
                , Elm.Case.branch0
                    "ActionRedirect"
                    loadingStateTags.actionRedirect
                ]
    }