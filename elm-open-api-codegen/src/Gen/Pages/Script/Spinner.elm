module Gen.Pages.Script.Spinner exposing
    ( moduleName_, steps, withStep, withStepWithOptions, runSteps, options
    , withOnCompletion, runTask, runTaskWithOptions, showStep, runSpinnerWithTask, annotation_, make_
    , caseOf_, call_, values_
    )

{-|
# Generated bindings for Pages.Script.Spinner

@docs moduleName_, steps, withStep, withStepWithOptions, runSteps, options
@docs withOnCompletion, runTask, runTaskWithOptions, showStep, runSpinnerWithTask, annotation_
@docs make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Script", "Spinner" ]


{-| Initialize an empty series of `Steps`.

steps: Pages.Script.Spinner.Steps FatalError.FatalError ()
-}
steps : Elm.Expression
steps =
    Elm.value
        { importFrom = [ "Pages", "Script", "Spinner" ]
        , name = "steps"
        , annotation =
            Just
                (Type.namedWith
                     [ "Pages", "Script", "Spinner" ]
                     "Steps"
                     [ Type.namedWith [ "FatalError" ] "FatalError" []
                     , Type.unit
                     ]
                )
        }


{-| Add a `Step`. See [`withStepWithOptions`](#withStepWithOptions) to configure the step's spinner.

withStep: 
    String
    -> (oldValue -> BackendTask.BackendTask FatalError.FatalError newValue)
    -> Pages.Script.Spinner.Steps FatalError.FatalError oldValue
    -> Pages.Script.Spinner.Steps FatalError.FatalError newValue
-}
withStep :
    String
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
withStep withStepArg_ withStepArg_0 withStepArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script", "Spinner" ]
             , name = "withStep"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.function
                              [ Type.var "oldValue" ]
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.namedWith
                                       [ "FatalError" ]
                                       "FatalError"
                                       []
                                 , Type.var "newValue"
                                 ]
                              )
                          , Type.namedWith
                              [ "Pages", "Script", "Spinner" ]
                              "Steps"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.var "oldValue"
                              ]
                          ]
                          (Type.namedWith
                               [ "Pages", "Script", "Spinner" ]
                               "Steps"
                               [ Type.namedWith [ "FatalError" ] "FatalError" []
                               , Type.var "newValue"
                               ]
                          )
                     )
             }
        )
        [ Elm.string withStepArg_
        , Elm.functionReduced "withStepUnpack" withStepArg_0
        , withStepArg_1
        ]


{-| Add a step with custom [`Options`](#Options).

withStepWithOptions: 
    Pages.Script.Spinner.Options FatalError.FatalError newValue
    -> (oldValue -> BackendTask.BackendTask FatalError.FatalError newValue)
    -> Pages.Script.Spinner.Steps FatalError.FatalError oldValue
    -> Pages.Script.Spinner.Steps FatalError.FatalError newValue
-}
withStepWithOptions :
    Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
withStepWithOptions withStepWithOptionsArg_ withStepWithOptionsArg_0 withStepWithOptionsArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script", "Spinner" ]
             , name = "withStepWithOptions"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Script", "Spinner" ]
                              "Options"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.var "newValue"
                              ]
                          , Type.function
                              [ Type.var "oldValue" ]
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.namedWith
                                       [ "FatalError" ]
                                       "FatalError"
                                       []
                                 , Type.var "newValue"
                                 ]
                              )
                          , Type.namedWith
                              [ "Pages", "Script", "Spinner" ]
                              "Steps"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.var "oldValue"
                              ]
                          ]
                          (Type.namedWith
                               [ "Pages", "Script", "Spinner" ]
                               "Steps"
                               [ Type.namedWith [ "FatalError" ] "FatalError" []
                               , Type.var "newValue"
                               ]
                          )
                     )
             }
        )
        [ withStepWithOptionsArg_
        , Elm.functionReduced
            "withStepWithOptionsUnpack"
            withStepWithOptionsArg_0
        , withStepWithOptionsArg_1
        ]


{-| Perform the `Steps` in sequence.

runSteps: 
    Pages.Script.Spinner.Steps FatalError.FatalError value
    -> BackendTask.BackendTask FatalError.FatalError value
-}
runSteps : Elm.Expression -> Elm.Expression
runSteps runStepsArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script", "Spinner" ]
             , name = "runSteps"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Script", "Spinner" ]
                              "Steps"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.var "value"
                              ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.namedWith [ "FatalError" ] "FatalError" []
                               , Type.var "value"
                               ]
                          )
                     )
             }
        )
        [ runStepsArg_ ]


{-| The default options for a spinner. The spinner `text` is a required argument and will be displayed as the step name.

    import Pages.Script.Spinner as Spinner

    example =
        Spinner.options "Compile Main.elm"

options: String -> Pages.Script.Spinner.Options error value
-}
options : String -> Elm.Expression
options optionsArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script", "Spinner" ]
             , name = "options"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "Pages", "Script", "Spinner" ]
                               "Options"
                               [ Type.var "error", Type.var "value" ]
                          )
                     )
             }
        )
        [ Elm.string optionsArg_ ]


{-| Set the completion icon and text based on the result of the task.

    import Pages.Script.Spinner as Spinner

    example =
        Spinner.options "Fetching data"
            |> Spinner.withOnCompletion
                (\result ->
                    case result of
                        Ok _ ->
                            ( Spinner.Succeed, "Fetched data!" )

                        Err _ ->
                            ( Spinner.Fail
                            , Just "Could not fetch data."
                            )
                )

withOnCompletion: 
    (Result.Result error value
    -> ( Pages.Script.Spinner.CompletionIcon, Maybe String ))
    -> Pages.Script.Spinner.Options error value
    -> Pages.Script.Spinner.Options error value
-}
withOnCompletion :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
withOnCompletion withOnCompletionArg_ withOnCompletionArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script", "Spinner" ]
             , name = "withOnCompletion"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "error", Type.var "value" ]
                              ]
                              (Type.tuple
                                 (Type.namedWith
                                    [ "Pages", "Script", "Spinner" ]
                                    "CompletionIcon"
                                    []
                                 )
                                 (Type.maybe Type.string)
                              )
                          , Type.namedWith
                              [ "Pages", "Script", "Spinner" ]
                              "Options"
                              [ Type.var "error", Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "Pages", "Script", "Spinner" ]
                               "Options"
                               [ Type.var "error", Type.var "value" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "withOnCompletionUnpack" withOnCompletionArg_
        , withOnCompletionArg_0
        ]


{-| Run a `BackendTask` with a spinner. The spinner will show a success icon if the task succeeds, and a failure icon if the task fails.

It's often easier to use [`steps`](#steps) when possible.

        module SequentialSteps exposing (run)

        import Pages.Script as Script exposing (Script, doThen, sleep)
        import Pages.Script.Spinner as Spinner


        run : Script
        run =
            Script.withoutCliOptions
                (sleep 3000
                    |> Spinner.runTask "Step 1..."
                    |> doThen
                        (sleep 3000
                            |> Spinner.runTask "Step 2..."
                            |> doThen
                                (sleep 3000
                                    |> Spinner.runTask "Step 3..."
                                )
                        )
                )

runTask: 
    String
    -> BackendTask.BackendTask error value
    -> BackendTask.BackendTask error value
-}
runTask : String -> Elm.Expression -> Elm.Expression
runTask runTaskArg_ runTaskArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script", "Spinner" ]
             , name = "runTask"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "value" ]
                          )
                     )
             }
        )
        [ Elm.string runTaskArg_, runTaskArg_0 ]


{-| runTaskWithOptions: 
    Pages.Script.Spinner.Options error value
    -> BackendTask.BackendTask error value
    -> BackendTask.BackendTask error value
-}
runTaskWithOptions : Elm.Expression -> Elm.Expression -> Elm.Expression
runTaskWithOptions runTaskWithOptionsArg_ runTaskWithOptionsArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script", "Spinner" ]
             , name = "runTaskWithOptions"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Script", "Spinner" ]
                              "Options"
                              [ Type.var "error", Type.var "value" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "value" ]
                          )
                     )
             }
        )
        [ runTaskWithOptionsArg_, runTaskWithOptionsArg_0 ]


{-| `showStep` gives you a `Spinner` reference which you can use to start the spinner later with `runSpinnerWithTask`.

Most use cases can be achieved more easily using more high-level helpers, like [`runTask`](#runTask) or [`steps`](#steps).
`showStep` can be useful if you have more dynamic steps that you want to reveal over time.

    module ShowStepDemo exposing (run)

    import BackendTask exposing (BackendTask)
    import Pages.Script as Script exposing (Script, doThen, sleep)
    import Pages.Script.Spinner as Spinner

    run : Script
    run =
        Script.withoutCliOptions
            (BackendTask.succeed
                (\spinner1 spinner2 spinner3 ->
                    sleep 3000
                        |> Spinner.runSpinnerWithTask spinner1
                        |> doThen
                            (sleep 3000
                                |> Spinner.runSpinnerWithTask spinner2
                                |> doThen
                                    (sleep 3000
                                        |> Spinner.runSpinnerWithTask spinner3
                                    )
                            )
                )
                |> BackendTask.andMap
                    (Spinner.options "Step 1" |> Spinner.showStep)
                |> BackendTask.andMap
                    (Spinner.options "Step 2" |> Spinner.showStep)
                |> BackendTask.andMap
                    (Spinner.options "Step 3" |> Spinner.showStep)
                |> BackendTask.andThen identity
            )

showStep: 
    Pages.Script.Spinner.Options error value
    -> BackendTask.BackendTask error (Pages.Script.Spinner.Spinner error value)
-}
showStep : Elm.Expression -> Elm.Expression
showStep showStepArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script", "Spinner" ]
             , name = "showStep"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Script", "Spinner" ]
                              "Options"
                              [ Type.var "error", Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error"
                               , Type.namedWith
                                   [ "Pages", "Script", "Spinner" ]
                                   "Spinner"
                                   [ Type.var "error", Type.var "value" ]
                               ]
                          )
                     )
             }
        )
        [ showStepArg_ ]


{-| After calling `showStep` to get a reference to a `Spinner`, use `runSpinnerWithTask` to run a `BackendTask` and show a failure or success
completion status once it is done.

runSpinnerWithTask: 
    Pages.Script.Spinner.Spinner error value
    -> BackendTask.BackendTask error value
    -> BackendTask.BackendTask error value
-}
runSpinnerWithTask : Elm.Expression -> Elm.Expression -> Elm.Expression
runSpinnerWithTask runSpinnerWithTaskArg_ runSpinnerWithTaskArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script", "Spinner" ]
             , name = "runSpinnerWithTask"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Script", "Spinner" ]
                              "Spinner"
                              [ Type.var "error", Type.var "value" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "value" ]
                          )
                     )
             }
        )
        [ runSpinnerWithTaskArg_, runSpinnerWithTaskArg_0 ]


annotation_ :
    { steps : Type.Annotation -> Type.Annotation -> Type.Annotation
    , options : Type.Annotation -> Type.Annotation -> Type.Annotation
    , completionIcon : Type.Annotation
    , spinner : Type.Annotation -> Type.Annotation -> Type.Annotation
    }
annotation_ =
    { steps =
        \stepsArg0 stepsArg1 ->
            Type.namedWith
                [ "Pages", "Script", "Spinner" ]
                "Steps"
                [ stepsArg0, stepsArg1 ]
    , options =
        \optionsArg0 optionsArg1 ->
            Type.namedWith
                [ "Pages", "Script", "Spinner" ]
                "Options"
                [ optionsArg0, optionsArg1 ]
    , completionIcon =
        Type.namedWith [ "Pages", "Script", "Spinner" ] "CompletionIcon" []
    , spinner =
        \spinnerArg0 spinnerArg1 ->
            Type.namedWith
                [ "Pages", "Script", "Spinner" ]
                "Spinner"
                [ spinnerArg0, spinnerArg1 ]
    }


make_ :
    { steps : Elm.Expression -> Elm.Expression
    , succeed : Elm.Expression
    , fail : Elm.Expression
    , warn : Elm.Expression
    , info : Elm.Expression
    }
make_ =
    { steps =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script", "Spinner" ]
                     , name = "Steps"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Steps"
                                  [ Type.var "error", Type.var "value" ]
                             )
                     }
                )
                [ ar0 ]
    , succeed =
        Elm.value
            { importFrom = [ "Pages", "Script", "Spinner" ]
            , name = "Succeed"
            , annotation = Just (Type.namedWith [] "CompletionIcon" [])
            }
    , fail =
        Elm.value
            { importFrom = [ "Pages", "Script", "Spinner" ]
            , name = "Fail"
            , annotation = Just (Type.namedWith [] "CompletionIcon" [])
            }
    , warn =
        Elm.value
            { importFrom = [ "Pages", "Script", "Spinner" ]
            , name = "Warn"
            , annotation = Just (Type.namedWith [] "CompletionIcon" [])
            }
    , info =
        Elm.value
            { importFrom = [ "Pages", "Script", "Spinner" ]
            , name = "Info"
            , annotation = Just (Type.namedWith [] "CompletionIcon" [])
            }
    }


caseOf_ :
    { steps :
        Elm.Expression
        -> { steps : Elm.Expression -> Elm.Expression }
        -> Elm.Expression
    , completionIcon :
        Elm.Expression
        -> { succeed : Elm.Expression
        , fail : Elm.Expression
        , warn : Elm.Expression
        , info : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { steps =
        \stepsExpression stepsTags ->
            Elm.Case.custom
                stepsExpression
                (Type.namedWith
                     [ "Pages", "Script", "Spinner" ]
                     "Steps"
                     [ Type.var "error", Type.var "value" ]
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType "Steps" stepsTags.steps |> Elm.Arg.item
                                                                         (Elm.Arg.varWith
                                                                                "backendTaskBackendTask"
                                                                                (Type.namedWith
                                                                                       [ "BackendTask"
                                                                                       ]
                                                                                       "BackendTask"
                                                                                       [ Type.var
                                                                                             "error"
                                                                                       , Type.var
                                                                                             "value"
                                                                                       ]
                                                                                )
                                                                         )
                    )
                    Basics.identity
                ]
    , completionIcon =
        \completionIconExpression completionIconTags ->
            Elm.Case.custom
                completionIconExpression
                (Type.namedWith
                     [ "Pages", "Script", "Spinner" ]
                     "CompletionIcon"
                     []
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType "Succeed" completionIconTags.succeed)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Fail" completionIconTags.fail)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Warn" completionIconTags.warn)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Info" completionIconTags.info)
                    Basics.identity
                ]
    }


call_ :
    { withStep :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , withStepWithOptions :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , runSteps : Elm.Expression -> Elm.Expression
    , options : Elm.Expression -> Elm.Expression
    , withOnCompletion : Elm.Expression -> Elm.Expression -> Elm.Expression
    , runTask : Elm.Expression -> Elm.Expression -> Elm.Expression
    , runTaskWithOptions : Elm.Expression -> Elm.Expression -> Elm.Expression
    , showStep : Elm.Expression -> Elm.Expression
    , runSpinnerWithTask : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { withStep =
        \withStepArg_ withStepArg_0 withStepArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script", "Spinner" ]
                     , name = "withStep"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.function
                                      [ Type.var "oldValue" ]
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.namedWith
                                               [ "FatalError" ]
                                               "FatalError"
                                               []
                                         , Type.var "newValue"
                                         ]
                                      )
                                  , Type.namedWith
                                      [ "Pages", "Script", "Spinner" ]
                                      "Steps"
                                      [ Type.namedWith
                                            [ "FatalError" ]
                                            "FatalError"
                                            []
                                      , Type.var "oldValue"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Script", "Spinner" ]
                                       "Steps"
                                       [ Type.namedWith
                                           [ "FatalError" ]
                                           "FatalError"
                                           []
                                       , Type.var "newValue"
                                       ]
                                  )
                             )
                     }
                )
                [ withStepArg_, withStepArg_0, withStepArg_1 ]
    , withStepWithOptions =
        \withStepWithOptionsArg_ withStepWithOptionsArg_0 withStepWithOptionsArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script", "Spinner" ]
                     , name = "withStepWithOptions"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Script", "Spinner" ]
                                      "Options"
                                      [ Type.namedWith
                                            [ "FatalError" ]
                                            "FatalError"
                                            []
                                      , Type.var "newValue"
                                      ]
                                  , Type.function
                                      [ Type.var "oldValue" ]
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.namedWith
                                               [ "FatalError" ]
                                               "FatalError"
                                               []
                                         , Type.var "newValue"
                                         ]
                                      )
                                  , Type.namedWith
                                      [ "Pages", "Script", "Spinner" ]
                                      "Steps"
                                      [ Type.namedWith
                                            [ "FatalError" ]
                                            "FatalError"
                                            []
                                      , Type.var "oldValue"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Script", "Spinner" ]
                                       "Steps"
                                       [ Type.namedWith
                                           [ "FatalError" ]
                                           "FatalError"
                                           []
                                       , Type.var "newValue"
                                       ]
                                  )
                             )
                     }
                )
                [ withStepWithOptionsArg_
                , withStepWithOptionsArg_0
                , withStepWithOptionsArg_1
                ]
    , runSteps =
        \runStepsArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script", "Spinner" ]
                     , name = "runSteps"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Script", "Spinner" ]
                                      "Steps"
                                      [ Type.namedWith
                                            [ "FatalError" ]
                                            "FatalError"
                                            []
                                      , Type.var "value"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.namedWith
                                           [ "FatalError" ]
                                           "FatalError"
                                           []
                                       , Type.var "value"
                                       ]
                                  )
                             )
                     }
                )
                [ runStepsArg_ ]
    , options =
        \optionsArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script", "Spinner" ]
                     , name = "options"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Pages", "Script", "Spinner" ]
                                       "Options"
                                       [ Type.var "error", Type.var "value" ]
                                  )
                             )
                     }
                )
                [ optionsArg_ ]
    , withOnCompletion =
        \withOnCompletionArg_ withOnCompletionArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script", "Spinner" ]
                     , name = "withOnCompletion"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.namedWith
                                            [ "Result" ]
                                            "Result"
                                            [ Type.var "error"
                                            , Type.var "value"
                                            ]
                                      ]
                                      (Type.tuple
                                         (Type.namedWith
                                            [ "Pages", "Script", "Spinner" ]
                                            "CompletionIcon"
                                            []
                                         )
                                         (Type.maybe Type.string)
                                      )
                                  , Type.namedWith
                                      [ "Pages", "Script", "Spinner" ]
                                      "Options"
                                      [ Type.var "error", Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Script", "Spinner" ]
                                       "Options"
                                       [ Type.var "error", Type.var "value" ]
                                  )
                             )
                     }
                )
                [ withOnCompletionArg_, withOnCompletionArg_0 ]
    , runTask =
        \runTaskArg_ runTaskArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script", "Spinner" ]
                     , name = "runTask"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.var "value" ]
                                  )
                             )
                     }
                )
                [ runTaskArg_, runTaskArg_0 ]
    , runTaskWithOptions =
        \runTaskWithOptionsArg_ runTaskWithOptionsArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script", "Spinner" ]
                     , name = "runTaskWithOptions"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Script", "Spinner" ]
                                      "Options"
                                      [ Type.var "error", Type.var "value" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.var "value" ]
                                  )
                             )
                     }
                )
                [ runTaskWithOptionsArg_, runTaskWithOptionsArg_0 ]
    , showStep =
        \showStepArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script", "Spinner" ]
                     , name = "showStep"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Script", "Spinner" ]
                                      "Options"
                                      [ Type.var "error", Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.namedWith
                                           [ "Pages", "Script", "Spinner" ]
                                           "Spinner"
                                           [ Type.var "error"
                                           , Type.var "value"
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ showStepArg_ ]
    , runSpinnerWithTask =
        \runSpinnerWithTaskArg_ runSpinnerWithTaskArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script", "Spinner" ]
                     , name = "runSpinnerWithTask"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Script", "Spinner" ]
                                      "Spinner"
                                      [ Type.var "error", Type.var "value" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.var "value" ]
                                  )
                             )
                     }
                )
                [ runSpinnerWithTaskArg_, runSpinnerWithTaskArg_0 ]
    }


values_ :
    { steps : Elm.Expression
    , withStep : Elm.Expression
    , withStepWithOptions : Elm.Expression
    , runSteps : Elm.Expression
    , options : Elm.Expression
    , withOnCompletion : Elm.Expression
    , runTask : Elm.Expression
    , runTaskWithOptions : Elm.Expression
    , showStep : Elm.Expression
    , runSpinnerWithTask : Elm.Expression
    }
values_ =
    { steps =
        Elm.value
            { importFrom = [ "Pages", "Script", "Spinner" ]
            , name = "steps"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Pages", "Script", "Spinner" ]
                         "Steps"
                         [ Type.namedWith [ "FatalError" ] "FatalError" []
                         , Type.unit
                         ]
                    )
            }
    , withStep =
        Elm.value
            { importFrom = [ "Pages", "Script", "Spinner" ]
            , name = "withStep"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.function
                             [ Type.var "oldValue" ]
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                      [ "FatalError" ]
                                      "FatalError"
                                      []
                                , Type.var "newValue"
                                ]
                             )
                         , Type.namedWith
                             [ "Pages", "Script", "Spinner" ]
                             "Steps"
                             [ Type.namedWith [ "FatalError" ] "FatalError" []
                             , Type.var "oldValue"
                             ]
                         ]
                         (Type.namedWith
                              [ "Pages", "Script", "Spinner" ]
                              "Steps"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.var "newValue"
                              ]
                         )
                    )
            }
    , withStepWithOptions =
        Elm.value
            { importFrom = [ "Pages", "Script", "Spinner" ]
            , name = "withStepWithOptions"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Script", "Spinner" ]
                             "Options"
                             [ Type.namedWith [ "FatalError" ] "FatalError" []
                             , Type.var "newValue"
                             ]
                         , Type.function
                             [ Type.var "oldValue" ]
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                      [ "FatalError" ]
                                      "FatalError"
                                      []
                                , Type.var "newValue"
                                ]
                             )
                         , Type.namedWith
                             [ "Pages", "Script", "Spinner" ]
                             "Steps"
                             [ Type.namedWith [ "FatalError" ] "FatalError" []
                             , Type.var "oldValue"
                             ]
                         ]
                         (Type.namedWith
                              [ "Pages", "Script", "Spinner" ]
                              "Steps"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.var "newValue"
                              ]
                         )
                    )
            }
    , runSteps =
        Elm.value
            { importFrom = [ "Pages", "Script", "Spinner" ]
            , name = "runSteps"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Script", "Spinner" ]
                             "Steps"
                             [ Type.namedWith [ "FatalError" ] "FatalError" []
                             , Type.var "value"
                             ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.var "value"
                              ]
                         )
                    )
            }
    , options =
        Elm.value
            { importFrom = [ "Pages", "Script", "Spinner" ]
            , name = "options"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "Pages", "Script", "Spinner" ]
                              "Options"
                              [ Type.var "error", Type.var "value" ]
                         )
                    )
            }
    , withOnCompletion =
        Elm.value
            { importFrom = [ "Pages", "Script", "Spinner" ]
            , name = "withOnCompletion"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.namedWith
                                   [ "Result" ]
                                   "Result"
                                   [ Type.var "error", Type.var "value" ]
                             ]
                             (Type.tuple
                                (Type.namedWith
                                   [ "Pages", "Script", "Spinner" ]
                                   "CompletionIcon"
                                   []
                                )
                                (Type.maybe Type.string)
                             )
                         , Type.namedWith
                             [ "Pages", "Script", "Spinner" ]
                             "Options"
                             [ Type.var "error", Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "Pages", "Script", "Spinner" ]
                              "Options"
                              [ Type.var "error", Type.var "value" ]
                         )
                    )
            }
    , runTask =
        Elm.value
            { importFrom = [ "Pages", "Script", "Spinner" ]
            , name = "runTask"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                         )
                    )
            }
    , runTaskWithOptions =
        Elm.value
            { importFrom = [ "Pages", "Script", "Spinner" ]
            , name = "runTaskWithOptions"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Script", "Spinner" ]
                             "Options"
                             [ Type.var "error", Type.var "value" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                         )
                    )
            }
    , showStep =
        Elm.value
            { importFrom = [ "Pages", "Script", "Spinner" ]
            , name = "showStep"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Script", "Spinner" ]
                             "Options"
                             [ Type.var "error", Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error"
                              , Type.namedWith
                                  [ "Pages", "Script", "Spinner" ]
                                  "Spinner"
                                  [ Type.var "error", Type.var "value" ]
                              ]
                         )
                    )
            }
    , runSpinnerWithTask =
        Elm.value
            { importFrom = [ "Pages", "Script", "Spinner" ]
            , name = "runSpinnerWithTask"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Script", "Spinner" ]
                             "Spinner"
                             [ Type.var "error", Type.var "value" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                         )
                    )
            }
    }