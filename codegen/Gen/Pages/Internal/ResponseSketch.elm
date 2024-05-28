module Gen.Pages.Internal.ResponseSketch exposing (annotation_, caseOf_, make_, moduleName_)

{-| 
@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Internal", "ResponseSketch" ]


annotation_ :
    { responseSketch :
        Type.Annotation -> Type.Annotation -> Type.Annotation -> Type.Annotation
    }
annotation_ =
    { responseSketch =
        \responseSketchArg0 responseSketchArg1 responseSketchArg2 ->
            Type.namedWith
                [ "Pages", "Internal", "ResponseSketch" ]
                "ResponseSketch"
                [ responseSketchArg0, responseSketchArg1, responseSketchArg2 ]
    }


make_ :
    { renderPage : Elm.Expression -> Elm.Expression -> Elm.Expression
    , hotUpdate :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , redirect : Elm.Expression -> Elm.Expression
    , notFound : Elm.Expression -> Elm.Expression
    , action : Elm.Expression -> Elm.Expression
    }
make_ =
    { renderPage =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "ResponseSketch" ]
                     , name = "RenderPage"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "ResponseSketch"
                                  [ Type.var "data"
                                  , Type.var "action"
                                  , Type.var "shared"
                                  ]
                             )
                     }
                )
                [ ar0, ar1 ]
    , hotUpdate =
        \ar0 ar1 ar2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "ResponseSketch" ]
                     , name = "HotUpdate"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "ResponseSketch"
                                  [ Type.var "data"
                                  , Type.var "action"
                                  , Type.var "shared"
                                  ]
                             )
                     }
                )
                [ ar0, ar1, ar2 ]
    , redirect =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "ResponseSketch" ]
                     , name = "Redirect"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "ResponseSketch"
                                  [ Type.var "data"
                                  , Type.var "action"
                                  , Type.var "shared"
                                  ]
                             )
                     }
                )
                [ ar0 ]
    , notFound =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "ResponseSketch" ]
                     , name = "NotFound"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "ResponseSketch"
                                  [ Type.var "data"
                                  , Type.var "action"
                                  , Type.var "shared"
                                  ]
                             )
                     }
                )
                [ ar0 ]
    , action =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "ResponseSketch" ]
                     , name = "Action"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "ResponseSketch"
                                  [ Type.var "data"
                                  , Type.var "action"
                                  , Type.var "shared"
                                  ]
                             )
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { responseSketch :
        Elm.Expression
        -> { responseSketchTags_0_0
            | renderPage : Elm.Expression -> Elm.Expression -> Elm.Expression
            , hotUpdate :
                Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
                -> Elm.Expression
            , redirect : Elm.Expression -> Elm.Expression
            , notFound : Elm.Expression -> Elm.Expression
            , action : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { responseSketch =
        \responseSketchExpression responseSketchTags ->
            Elm.Case.custom
                responseSketchExpression
                (Type.namedWith
                     [ "Pages", "Internal", "ResponseSketch" ]
                     "ResponseSketch"
                     [ Type.var "data", Type.var "action", Type.var "shared" ]
                )
                [ Elm.Case.branch2
                    "RenderPage"
                    ( "data", Type.var "data" )
                    ( "maybeMaybe", Type.maybe (Type.var "action") )
                    responseSketchTags.renderPage
                , Elm.Case.branch3
                    "HotUpdate"
                    ( "data", Type.var "data" )
                    ( "shared", Type.var "shared" )
                    ( "maybeMaybe", Type.maybe (Type.var "action") )
                    responseSketchTags.hotUpdate
                , Elm.Case.branch1
                    "Redirect"
                    ( "stringString", Type.string )
                    responseSketchTags.redirect
                , Elm.Case.branch1
                    "NotFound"
                    ( "one"
                    , Type.record
                          [ ( "reason"
                            , Type.namedWith
                                  [ "Pages", "Internal", "NotFoundReason" ]
                                  "NotFoundReason"
                                  []
                            )
                          , ( "path"
                            , Type.namedWith [ "UrlPath" ] "UrlPath" []
                            )
                          ]
                    )
                    responseSketchTags.notFound
                , Elm.Case.branch1
                    "Action"
                    ( "action", Type.var "action" )
                    responseSketchTags.action
                ]
    }