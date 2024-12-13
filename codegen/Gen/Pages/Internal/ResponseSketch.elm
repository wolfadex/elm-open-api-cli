module Gen.Pages.Internal.ResponseSketch exposing ( moduleName_, annotation_, make_, caseOf_ )

{-|
# Generated bindings for Pages.Internal.ResponseSketch

@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
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
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "RenderPage"
                       responseSketchTags.renderPage |> Elm.Arg.item
                                                              (Elm.Arg.varWith
                                                                     "data"
                                                                     (Type.var
                                                                            "data"
                                                                     )
                                                              ) |> Elm.Arg.item
                                                                         (Elm.Arg.varWith
                                                                                "maybeMaybe"
                                                                                (Type.maybe
                                                                                       (Type.var
                                                                                              "action"
                                                                                       )
                                                                                )
                                                                         )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "HotUpdate"
                       responseSketchTags.hotUpdate |> Elm.Arg.item
                                                             (Elm.Arg.varWith
                                                                    "data"
                                                                    (Type.var
                                                                           "data"
                                                                    )
                                                             ) |> Elm.Arg.item
                                                                        (Elm.Arg.varWith
                                                                               "shared"
                                                                               (Type.var
                                                                                      "shared"
                                                                               )
                                                                        ) |> Elm.Arg.item
                                                                                   (Elm.Arg.varWith
                                                                                          "maybeMaybe"
                                                                                          (Type.maybe
                                                                                                 (Type.var
                                                                                                        "action"
                                                                                                 )
                                                                                          )
                                                                                   )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "Redirect"
                       responseSketchTags.redirect |> Elm.Arg.item
                                                            (Elm.Arg.varWith
                                                                   "arg_0"
                                                                   Type.string
                                                            )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "NotFound"
                       responseSketchTags.notFound |> Elm.Arg.item
                                                            (Elm.Arg.varWith
                                                                   "arg_0"
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
                                                                                [ "UrlPath"
                                                                                ]
                                                                                "UrlPath"
                                                                                []
                                                                            )
                                                                          ]
                                                                   )
                                                            )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "Action"
                       responseSketchTags.action |> Elm.Arg.item
                                                          (Elm.Arg.varWith
                                                                 "action"
                                                                 (Type.var
                                                                        "action"
                                                                 )
                                                          )
                    )
                    Basics.identity
                ]
    }