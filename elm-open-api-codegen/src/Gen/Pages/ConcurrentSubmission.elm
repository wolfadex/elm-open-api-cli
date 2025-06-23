module Gen.Pages.ConcurrentSubmission exposing
    ( moduleName_, map, annotation_, make_, caseOf_, call_
    , values_
    )

{-|
# Generated bindings for Pages.ConcurrentSubmission

@docs moduleName_, map, annotation_, make_, caseOf_, call_
@docs values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "ConcurrentSubmission" ]


{-| `map` a `ConcurrentSubmission`. Not needed for most high-level cases since this state is managed by the `elm-pages` framework for you.

map: 
    (a -> b)
    -> Pages.ConcurrentSubmission.ConcurrentSubmission a
    -> Pages.ConcurrentSubmission.ConcurrentSubmission b
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg_ mapArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "ConcurrentSubmission" ]
             , name = "map"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function [ Type.var "a" ] (Type.var "b")
                          , Type.namedWith
                              [ "Pages", "ConcurrentSubmission" ]
                              "ConcurrentSubmission"
                              [ Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "Pages", "ConcurrentSubmission" ]
                               "ConcurrentSubmission"
                               [ Type.var "b" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapUnpack" mapArg_, mapArg_0 ]


annotation_ :
    { concurrentSubmission : Type.Annotation -> Type.Annotation
    , status : Type.Annotation -> Type.Annotation
    }
annotation_ =
    { concurrentSubmission =
        \concurrentSubmissionArg0 ->
            Type.alias
                moduleName_
                "ConcurrentSubmission"
                [ concurrentSubmissionArg0 ]
                (Type.record
                     [ ( "status"
                       , Type.namedWith
                             [ "Pages", "ConcurrentSubmission" ]
                             "Status"
                             [ Type.var "actionData" ]
                       )
                     , ( "payload"
                       , Type.namedWith [ "Pages", "FormData" ] "FormData" []
                       )
                     , ( "initiatedAt", Type.namedWith [ "Time" ] "Posix" [] )
                     ]
                )
    , status =
        \statusArg0 ->
            Type.namedWith
                [ "Pages", "ConcurrentSubmission" ]
                "Status"
                [ statusArg0 ]
    }


make_ :
    { concurrentSubmission :
        { status : Elm.Expression
        , payload : Elm.Expression
        , initiatedAt : Elm.Expression
        }
        -> Elm.Expression
    , submitting : Elm.Expression
    , reloading : Elm.Expression -> Elm.Expression
    , complete : Elm.Expression -> Elm.Expression
    }
make_ =
    { concurrentSubmission =
        \concurrentSubmission_args ->
            Elm.withType
                (Type.alias
                     [ "Pages", "ConcurrentSubmission" ]
                     "ConcurrentSubmission"
                     [ Type.var "actionData" ]
                     (Type.record
                          [ ( "status"
                            , Type.namedWith
                                  [ "Pages", "ConcurrentSubmission" ]
                                  "Status"
                                  [ Type.var "actionData" ]
                            )
                          , ( "payload"
                            , Type.namedWith
                                  [ "Pages", "FormData" ]
                                  "FormData"
                                  []
                            )
                          , ( "initiatedAt"
                            , Type.namedWith [ "Time" ] "Posix" []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "status" concurrentSubmission_args.status
                     , Tuple.pair "payload" concurrentSubmission_args.payload
                     , Tuple.pair
                         "initiatedAt"
                         concurrentSubmission_args.initiatedAt
                     ]
                )
    , submitting =
        Elm.value
            { importFrom = [ "Pages", "ConcurrentSubmission" ]
            , name = "Submitting"
            , annotation =
                Just (Type.namedWith [] "Status" [ Type.var "actionData" ])
            }
    , reloading =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "ConcurrentSubmission" ]
                     , name = "Reloading"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Status"
                                  [ Type.var "actionData" ]
                             )
                     }
                )
                [ ar0 ]
    , complete =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "ConcurrentSubmission" ]
                     , name = "Complete"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Status"
                                  [ Type.var "actionData" ]
                             )
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { status :
        Elm.Expression
        -> { submitting : Elm.Expression
        , reloading : Elm.Expression -> Elm.Expression
        , complete : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { status =
        \statusExpression statusTags ->
            Elm.Case.custom
                statusExpression
                (Type.namedWith
                     [ "Pages", "ConcurrentSubmission" ]
                     "Status"
                     [ Type.var "actionData" ]
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType "Submitting" statusTags.submitting)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "Reloading"
                       statusTags.reloading |> Elm.Arg.item
                                                     (Elm.Arg.varWith
                                                            "actionData"
                                                            (Type.var
                                                                   "actionData"
                                                            )
                                                     )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "Complete"
                       statusTags.complete |> Elm.Arg.item
                                                    (Elm.Arg.varWith
                                                           "actionData"
                                                           (Type.var
                                                                  "actionData"
                                                           )
                                                    )
                    )
                    Basics.identity
                ]
    }


call_ : { map : Elm.Expression -> Elm.Expression -> Elm.Expression }
call_ =
    { map =
        \mapArg_ mapArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "ConcurrentSubmission" ]
                     , name = "map"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.var "b")
                                  , Type.namedWith
                                      [ "Pages", "ConcurrentSubmission" ]
                                      "ConcurrentSubmission"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "ConcurrentSubmission" ]
                                       "ConcurrentSubmission"
                                       [ Type.var "b" ]
                                  )
                             )
                     }
                )
                [ mapArg_, mapArg_0 ]
    }


values_ : { map : Elm.Expression }
values_ =
    { map =
        Elm.value
            { importFrom = [ "Pages", "ConcurrentSubmission" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.var "a" ] (Type.var "b")
                         , Type.namedWith
                             [ "Pages", "ConcurrentSubmission" ]
                             "ConcurrentSubmission"
                             [ Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "Pages", "ConcurrentSubmission" ]
                              "ConcurrentSubmission"
                              [ Type.var "b" ]
                         )
                    )
            }
    }