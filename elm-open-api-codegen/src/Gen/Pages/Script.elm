module Gen.Pages.Script exposing
    ( moduleName_, withCliOptions, withoutCliOptions, writeFile, command, exec
    , log, sleep, doThen, which, expectWhich, question, annotation_
    , make_, caseOf_, call_, values_
    )

{-|
# Generated bindings for Pages.Script

@docs moduleName_, withCliOptions, withoutCliOptions, writeFile, command, exec
@docs log, sleep, doThen, which, expectWhich, question
@docs annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Script" ]


{-| Same as [`withoutCliOptions`](#withoutCliOptions), but allows you to define a CLI Options Parser so the user can
pass in additional options for the script.

Uses <https://package.elm-lang.org/packages/dillonkearns/elm-cli-options-parser/latest/>.

Read more at <https://elm-pages.com/docs/elm-pages-scripts/#adding-command-line-options>.

withCliOptions: 
    Cli.Program.Config cliOptions
    -> (cliOptions -> BackendTask.BackendTask FatalError.FatalError ())
    -> Pages.Script.Script
-}
withCliOptions :
    Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
withCliOptions withCliOptionsArg_ withCliOptionsArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script" ]
             , name = "withCliOptions"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Cli", "Program" ]
                              "Config"
                              [ Type.var "cliOptions" ]
                          , Type.function
                              [ Type.var "cliOptions" ]
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.namedWith
                                       [ "FatalError" ]
                                       "FatalError"
                                       []
                                 , Type.unit
                                 ]
                              )
                          ]
                          (Type.namedWith [ "Pages", "Script" ] "Script" [])
                     )
             }
        )
        [ withCliOptionsArg_
        , Elm.functionReduced "withCliOptionsUnpack" withCliOptionsArg_0
        ]


{-| Define a simple Script (no CLI Options).

    module MyScript exposing (run)

    import BackendTask
    import Pages.Script as Script

    run =
        Script.withoutCliOptions
            (Script.log "Hello!"
                |> BackendTask.allowFatal
            )

withoutCliOptions: BackendTask.BackendTask FatalError.FatalError () -> Pages.Script.Script
-}
withoutCliOptions : Elm.Expression -> Elm.Expression
withoutCliOptions withoutCliOptionsArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script" ]
             , name = "withoutCliOptions"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.unit
                              ]
                          ]
                          (Type.namedWith [ "Pages", "Script" ] "Script" [])
                     )
             }
        )
        [ withoutCliOptionsArg_ ]


{-| Write a file to the file system.

File paths are relative to the root of your `elm-pages` project (next to the `elm.json` file and `src/` directory), or you can pass in absolute paths beginning with a `/`.

    module MyScript exposing (run)

    import BackendTask
    import Pages.Script as Script

    run =
        Script.withoutCliOptions
            (Script.writeFile
                { path = "hello.json"
                , body = """{ "message": "Hello, World!" }"""
                }
                |> BackendTask.allowFatal
            )

writeFile: 
    { path : String, body : String }
    -> BackendTask.BackendTask { fatal : FatalError.FatalError
    , recoverable : Pages.Script.Error
    } ()
-}
writeFile : { path : String, body : String } -> Elm.Expression
writeFile writeFileArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script" ]
             , name = "writeFile"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "path", Type.string )
                              , ( "body", Type.string )
                              ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.record
                                   [ ( "fatal"
                                     , Type.namedWith
                                         [ "FatalError" ]
                                         "FatalError"
                                         []
                                     )
                                   , ( "recoverable"
                                     , Type.namedWith
                                         [ "Pages", "Script" ]
                                         "Error"
                                         []
                                     )
                                   ]
                               , Type.unit
                               ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "path" (Elm.string writeFileArg_.path)
            , Tuple.pair "body" (Elm.string writeFileArg_.body)
            ]
        ]


{-| Run a single command and return stderr and stdout combined as a single String.

If you want to do more advanced things like piping together multiple commands in a pipeline, or piping in a file to a command, etc., see the [`Stream`](BackendTask-Stream) module.

    module MyScript exposing (run)

    import BackendTask
    import Pages.Script as Script exposing (Script)

    run : Script
    run =
        Script.withoutCliOptions
            (Script.command "ls" []
                |> BackendTask.andThen
                    (\files ->
                        Script.log ("Files: " ++ files)
                    )
            )

command: String -> List String -> BackendTask.BackendTask FatalError.FatalError String
-}
command : String -> List String -> Elm.Expression
command commandArg_ commandArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script" ]
             , name = "command"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string, Type.list Type.string ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.namedWith [ "FatalError" ] "FatalError" []
                               , Type.string
                               ]
                          )
                     )
             }
        )
        [ Elm.string commandArg_, Elm.list (List.map Elm.string commandArg_0) ]


{-| Like [`command`](#command), but prints stderr and stdout to the console as the command runs instead of capturing them.

    module MyScript exposing (run)

    import BackendTask
    import Pages.Script as Script exposing (Script)

    run : Script
    run =
        Script.withoutCliOptions
            (Script.exec "ls" [])

exec: String -> List String -> BackendTask.BackendTask FatalError.FatalError ()
-}
exec : String -> List String -> Elm.Expression
exec execArg_ execArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script" ]
             , name = "exec"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string, Type.list Type.string ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.namedWith [ "FatalError" ] "FatalError" []
                               , Type.unit
                               ]
                          )
                     )
             }
        )
        [ Elm.string execArg_, Elm.list (List.map Elm.string execArg_0) ]


{-| Log to stdout.

    module MyScript exposing (run)

    import BackendTask
    import Pages.Script as Script

    run =
        Script.withoutCliOptions
            (Script.log "Hello!"
                |> BackendTask.allowFatal
            )

log: String -> BackendTask.BackendTask error ()
-}
log : String -> Elm.Expression
log logArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script" ]
             , name = "log"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.unit ]
                          )
                     )
             }
        )
        [ Elm.string logArg_ ]


{-| Sleep for a number of milliseconds.

    module MyScript exposing (run)

    import BackendTask
    import Pages.Script as Script

    run =
        Script.withoutCliOptions
            (Script.log "Hello..."
                |> Script.doThen
                    (Script.sleep 1000)
                |> Script.doThen
                    (Script.log "World!")
            )

sleep: Int -> BackendTask.BackendTask error ()
-}
sleep : Int -> Elm.Expression
sleep sleepArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script" ]
             , name = "sleep"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.unit ]
                          )
                     )
             }
        )
        [ Elm.int sleepArg_ ]


{-| Run a command with no output, then run another command.

    module MyScript exposing (run)

    import BackendTask
    import Pages.Script as Script

    run =
        Script.withoutCliOptions
            (Script.log "Hello!"
                |> Script.doThen
                    (Script.log "World!")
            )

doThen: 
    BackendTask.BackendTask error value
    -> BackendTask.BackendTask error ()
    -> BackendTask.BackendTask error value
-}
doThen : Elm.Expression -> Elm.Expression -> Elm.Expression
doThen doThenArg_ doThenArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script" ]
             , name = "doThen"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.unit ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "value" ]
                          )
                     )
             }
        )
        [ doThenArg_, doThenArg_0 ]


{-| Same as [`expectWhich`](#expectWhich), but returns `Nothing` if the command is not found instead of failing with a [`FatalError`](FatalError).

which: String -> BackendTask.BackendTask error (Maybe String)
-}
which : String -> Elm.Expression
which whichArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script" ]
             , name = "which"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.maybe Type.string ]
                          )
                     )
             }
        )
        [ Elm.string whichArg_ ]


{-| Check if a command is available on the system. If it is, return the full path to the command, otherwise fail with a [`FatalError`](FatalError).

    module MyScript exposing (run)

    import BackendTask
    import Pages.Script as Script

    run : Script
    run =
        Script.withoutCliOptions
            (Script.expectWhich "elm-review"
                |> BackendTask.andThen
                    (\path ->
                        Script.log ("The path to `elm-review` is: " ++ path)
                    )
            )

If you run it with a command that is not available, you will see an error like this:

    Script.expectWhich "hype-script"

```shell
-- COMMAND NOT FOUND ---------------
I expected to find `hype-script`, but it was not on your PATH. Make sure it is installed and included in your PATH.
```

expectWhich: String -> BackendTask.BackendTask FatalError.FatalError String
-}
expectWhich : String -> Elm.Expression
expectWhich expectWhichArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script" ]
             , name = "expectWhich"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.namedWith [ "FatalError" ] "FatalError" []
                               , Type.string
                               ]
                          )
                     )
             }
        )
        [ Elm.string expectWhichArg_ ]


{-| module QuestionDemo exposing (run)

    import BackendTask

    run : Script
    run =
        Script.withoutCliOptions
            (Script.question "What is your name? "
                |> BackendTask.andThen
                    (\name ->
                        Script.log ("Hello, " ++ name ++ "!")
                    )
            )

question: String -> BackendTask.BackendTask error String
-}
question : String -> Elm.Expression
question questionArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Script" ]
             , name = "question"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.string ]
                          )
                     )
             }
        )
        [ Elm.string questionArg_ ]


annotation_ : { script : Type.Annotation, error : Type.Annotation }
annotation_ =
    { script =
        Type.alias
            moduleName_
            "Script"
            []
            (Type.namedWith [ "Pages", "Internal", "Script" ] "Script" [])
    , error = Type.namedWith [ "Pages", "Script" ] "Error" []
    }


make_ : { fileWriteError : Elm.Expression }
make_ =
    { fileWriteError =
        Elm.value
            { importFrom = [ "Pages", "Script" ]
            , name = "FileWriteError"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    }


caseOf_ :
    { error :
        Elm.Expression -> { fileWriteError : Elm.Expression } -> Elm.Expression
    }
caseOf_ =
    { error =
        \errorExpression errorTags ->
            Elm.Case.custom
                errorExpression
                (Type.namedWith [ "Pages", "Script" ] "Error" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "FileWriteError"
                       errorTags.fileWriteError
                    )
                    Basics.identity
                ]
    }


call_ :
    { withCliOptions : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withoutCliOptions : Elm.Expression -> Elm.Expression
    , writeFile : Elm.Expression -> Elm.Expression
    , command : Elm.Expression -> Elm.Expression -> Elm.Expression
    , exec : Elm.Expression -> Elm.Expression -> Elm.Expression
    , log : Elm.Expression -> Elm.Expression
    , sleep : Elm.Expression -> Elm.Expression
    , doThen : Elm.Expression -> Elm.Expression -> Elm.Expression
    , which : Elm.Expression -> Elm.Expression
    , expectWhich : Elm.Expression -> Elm.Expression
    , question : Elm.Expression -> Elm.Expression
    }
call_ =
    { withCliOptions =
        \withCliOptionsArg_ withCliOptionsArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script" ]
                     , name = "withCliOptions"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Cli", "Program" ]
                                      "Config"
                                      [ Type.var "cliOptions" ]
                                  , Type.function
                                      [ Type.var "cliOptions" ]
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.namedWith
                                               [ "FatalError" ]
                                               "FatalError"
                                               []
                                         , Type.unit
                                         ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Script" ]
                                       "Script"
                                       []
                                  )
                             )
                     }
                )
                [ withCliOptionsArg_, withCliOptionsArg_0 ]
    , withoutCliOptions =
        \withoutCliOptionsArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script" ]
                     , name = "withoutCliOptions"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.namedWith
                                            [ "FatalError" ]
                                            "FatalError"
                                            []
                                      , Type.unit
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Script" ]
                                       "Script"
                                       []
                                  )
                             )
                     }
                )
                [ withoutCliOptionsArg_ ]
    , writeFile =
        \writeFileArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script" ]
                     , name = "writeFile"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "path", Type.string )
                                      , ( "body", Type.string )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.record
                                           [ ( "fatal"
                                             , Type.namedWith
                                                 [ "FatalError" ]
                                                 "FatalError"
                                                 []
                                             )
                                           , ( "recoverable"
                                             , Type.namedWith
                                                 [ "Pages", "Script" ]
                                                 "Error"
                                                 []
                                             )
                                           ]
                                       , Type.unit
                                       ]
                                  )
                             )
                     }
                )
                [ writeFileArg_ ]
    , command =
        \commandArg_ commandArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script" ]
                     , name = "command"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string, Type.list Type.string ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.namedWith
                                           [ "FatalError" ]
                                           "FatalError"
                                           []
                                       , Type.string
                                       ]
                                  )
                             )
                     }
                )
                [ commandArg_, commandArg_0 ]
    , exec =
        \execArg_ execArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script" ]
                     , name = "exec"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string, Type.list Type.string ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.namedWith
                                           [ "FatalError" ]
                                           "FatalError"
                                           []
                                       , Type.unit
                                       ]
                                  )
                             )
                     }
                )
                [ execArg_, execArg_0 ]
    , log =
        \logArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script" ]
                     , name = "log"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.unit ]
                                  )
                             )
                     }
                )
                [ logArg_ ]
    , sleep =
        \sleepArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script" ]
                     , name = "sleep"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.unit ]
                                  )
                             )
                     }
                )
                [ sleepArg_ ]
    , doThen =
        \doThenArg_ doThenArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script" ]
                     , name = "doThen"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.unit ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.var "value" ]
                                  )
                             )
                     }
                )
                [ doThenArg_, doThenArg_0 ]
    , which =
        \whichArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script" ]
                     , name = "which"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.maybe Type.string
                                       ]
                                  )
                             )
                     }
                )
                [ whichArg_ ]
    , expectWhich =
        \expectWhichArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script" ]
                     , name = "expectWhich"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.namedWith
                                           [ "FatalError" ]
                                           "FatalError"
                                           []
                                       , Type.string
                                       ]
                                  )
                             )
                     }
                )
                [ expectWhichArg_ ]
    , question =
        \questionArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Script" ]
                     , name = "question"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.string ]
                                  )
                             )
                     }
                )
                [ questionArg_ ]
    }


values_ :
    { withCliOptions : Elm.Expression
    , withoutCliOptions : Elm.Expression
    , writeFile : Elm.Expression
    , command : Elm.Expression
    , exec : Elm.Expression
    , log : Elm.Expression
    , sleep : Elm.Expression
    , doThen : Elm.Expression
    , which : Elm.Expression
    , expectWhich : Elm.Expression
    , question : Elm.Expression
    }
values_ =
    { withCliOptions =
        Elm.value
            { importFrom = [ "Pages", "Script" ]
            , name = "withCliOptions"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Cli", "Program" ]
                             "Config"
                             [ Type.var "cliOptions" ]
                         , Type.function
                             [ Type.var "cliOptions" ]
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                      [ "FatalError" ]
                                      "FatalError"
                                      []
                                , Type.unit
                                ]
                             )
                         ]
                         (Type.namedWith [ "Pages", "Script" ] "Script" [])
                    )
            }
    , withoutCliOptions =
        Elm.value
            { importFrom = [ "Pages", "Script" ]
            , name = "withoutCliOptions"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.namedWith [ "FatalError" ] "FatalError" []
                             , Type.unit
                             ]
                         ]
                         (Type.namedWith [ "Pages", "Script" ] "Script" [])
                    )
            }
    , writeFile =
        Elm.value
            { importFrom = [ "Pages", "Script" ]
            , name = "writeFile"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "path", Type.string )
                             , ( "body", Type.string )
                             ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.record
                                  [ ( "fatal"
                                    , Type.namedWith
                                        [ "FatalError" ]
                                        "FatalError"
                                        []
                                    )
                                  , ( "recoverable"
                                    , Type.namedWith
                                        [ "Pages", "Script" ]
                                        "Error"
                                        []
                                    )
                                  ]
                              , Type.unit
                              ]
                         )
                    )
            }
    , command =
        Elm.value
            { importFrom = [ "Pages", "Script" ]
            , name = "command"
            , annotation =
                Just
                    (Type.function
                         [ Type.string, Type.list Type.string ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.string
                              ]
                         )
                    )
            }
    , exec =
        Elm.value
            { importFrom = [ "Pages", "Script" ]
            , name = "exec"
            , annotation =
                Just
                    (Type.function
                         [ Type.string, Type.list Type.string ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.unit
                              ]
                         )
                    )
            }
    , log =
        Elm.value
            { importFrom = [ "Pages", "Script" ]
            , name = "log"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.unit ]
                         )
                    )
            }
    , sleep =
        Elm.value
            { importFrom = [ "Pages", "Script" ]
            , name = "sleep"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.unit ]
                         )
                    )
            }
    , doThen =
        Elm.value
            { importFrom = [ "Pages", "Script" ]
            , name = "doThen"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.unit ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                         )
                    )
            }
    , which =
        Elm.value
            { importFrom = [ "Pages", "Script" ]
            , name = "which"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.maybe Type.string ]
                         )
                    )
            }
    , expectWhich =
        Elm.value
            { importFrom = [ "Pages", "Script" ]
            , name = "expectWhich"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.string
                              ]
                         )
                    )
            }
    , question =
        Elm.value
            { importFrom = [ "Pages", "Script" ]
            , name = "question"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.string ]
                         )
                    )
            }
    }