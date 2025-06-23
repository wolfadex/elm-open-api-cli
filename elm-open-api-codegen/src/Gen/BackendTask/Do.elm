module Gen.BackendTask.Do exposing
    ( moduleName_, do, allowFatal, noop, exec, command
    , glob, log, env, each, failIf, call_, values_
    )

{-|
# Generated bindings for BackendTask.Do

@docs moduleName_, do, allowFatal, noop, exec, command
@docs glob, log, env, each, failIf, call_
@docs values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "BackendTask", "Do" ]


{-| Use any `BackendTask` into a continuation-style task.

    example : BackendTask FatalError ()
    example =
        do
            (Script.question "What is your name? ")
        <|
            \name ->
                \() ->
                    Script.log ("Hello " ++ name ++ "!")

do: 
    BackendTask.BackendTask error a
    -> (a -> BackendTask.BackendTask error b)
    -> BackendTask.BackendTask error b
-}
do : Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
do doArg_ doArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Do" ]
             , name = "do"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "a" ]
                          , Type.function
                              [ Type.var "a" ]
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.var "error", Type.var "b" ]
                              )
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "b" ]
                          )
                     )
             }
        )
        [ doArg_, Elm.functionReduced "doUnpack" doArg_0 ]


{-| Same as [`do`](#do), but with a shorthand to call `BackendTask.allowFatal` on it.

    import BackendTask exposing (BackendTask)
    import FatalError exposing (FatalError)
    import BackendTask.File as BackendTask.File
    import BackendTask.Do exposing (allowFatal, do)

    example : BackendTask FatalError ()
    example =
        do (BackendTask.File.rawFile "post-1.md" |> BackendTask.allowFatal) <|
            \post1 ->
                allowFatal (BackendTask.File.rawFile "post-2.md") <|
                    \post2 ->
                        Script.log (post1 ++ "\n\n" ++ post2)

allowFatal: 
    BackendTask.BackendTask { error | fatal : FatalError.FatalError } data
    -> (data -> BackendTask.BackendTask FatalError.FatalError b)
    -> BackendTask.BackendTask FatalError.FatalError b
-}
allowFatal :
    Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
allowFatal allowFatalArg_ allowFatalArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Do" ]
             , name = "allowFatal"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.extensible
                                    "error"
                                    [ ( "fatal"
                                      , Type.namedWith
                                            [ "FatalError" ]
                                            "FatalError"
                                            []
                                      )
                                    ]
                              , Type.var "data"
                              ]
                          , Type.function
                              [ Type.var "data" ]
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.namedWith
                                       [ "FatalError" ]
                                       "FatalError"
                                       []
                                 , Type.var "b"
                                 ]
                              )
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.namedWith [ "FatalError" ] "FatalError" []
                               , Type.var "b"
                               ]
                          )
                     )
             }
        )
        [ allowFatalArg_
        , Elm.functionReduced "allowFatalUnpack" allowFatalArg_0
        ]


{-| A `BackendTask` that does nothing. Defined as `BackendTask.succeed ()`.

It's a useful shorthand for when you want to end a continuation chain.

    example : BackendTask FatalError ()
    example =
        exec "ls" [ "-l" ] <|
            \() ->
                log "Hello, world!" <|
                    \() ->
                        noop

noop: BackendTask.BackendTask error ()
-}
noop : Elm.Expression
noop =
    Elm.value
        { importFrom = [ "BackendTask", "Do" ]
        , name = "noop"
        , annotation =
            Just
                (Type.namedWith
                     [ "BackendTask" ]
                     "BackendTask"
                     [ Type.var "error", Type.unit ]
                )
        }


{-| A do-style helper for [`Script.exec`](Pages-Script#exec).

exec: 
    String
    -> List String
    -> (() -> BackendTask.BackendTask FatalError.FatalError b)
    -> BackendTask.BackendTask FatalError.FatalError b
-}
exec :
    String
    -> List String
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
exec execArg_ execArg_0 execArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Do" ]
             , name = "exec"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.list Type.string
                          , Type.function
                              [ Type.unit ]
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.namedWith
                                       [ "FatalError" ]
                                       "FatalError"
                                       []
                                 , Type.var "b"
                                 ]
                              )
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.namedWith [ "FatalError" ] "FatalError" []
                               , Type.var "b"
                               ]
                          )
                     )
             }
        )
        [ Elm.string execArg_
        , Elm.list (List.map Elm.string execArg_0)
        , Elm.functionReduced "execUnpack" execArg_1
        ]


{-| A do-style helper for [`Script.command`](Pages-Script#command).

command: 
    String
    -> List String
    -> (String -> BackendTask.BackendTask FatalError.FatalError b)
    -> BackendTask.BackendTask FatalError.FatalError b
-}
command :
    String
    -> List String
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
command commandArg_ commandArg_0 commandArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Do" ]
             , name = "command"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.list Type.string
                          , Type.function
                              [ Type.string ]
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.namedWith
                                       [ "FatalError" ]
                                       "FatalError"
                                       []
                                 , Type.var "b"
                                 ]
                              )
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.namedWith [ "FatalError" ] "FatalError" []
                               , Type.var "b"
                               ]
                          )
                     )
             }
        )
        [ Elm.string commandArg_
        , Elm.list (List.map Elm.string commandArg_0)
        , Elm.functionReduced "commandUnpack" commandArg_1
        ]


{-| A continuation-style helper for [`Glob.fromString`](BackendTask-Glob#fromString).

In a shell script, you can think of this as a stand-in for globbing files directly within a command. The [`BackendTask.Stream.command`](BackendTask-Stream#command)
which lets you run shell commands sanitizes and escapes all arguments passed, and does not do glob expansion, so this is helpful for translating
a shell script to Elm.

This example passes a list of matching file paths along to an `rm -f` command.

    example : BackendTask FatalError ()
    example =
        glob "src/**/*.elm" <|
            \elmFiles ->
                log ("Going to delete " ++ String.fromInt (List.length elmFiles) ++ " Elm files") <|
                    \() ->
                        exec "rm" ("-f" :: elmFiles) <|
                            \() ->
                                noop

glob: 
    String
    -> (List String -> BackendTask.BackendTask FatalError.FatalError a)
    -> BackendTask.BackendTask FatalError.FatalError a
-}
glob : String -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
glob globArg_ globArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Do" ]
             , name = "glob"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.function
                              [ Type.list Type.string ]
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.namedWith
                                       [ "FatalError" ]
                                       "FatalError"
                                       []
                                 , Type.var "a"
                                 ]
                              )
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.namedWith [ "FatalError" ] "FatalError" []
                               , Type.var "a"
                               ]
                          )
                     )
             }
        )
        [ Elm.string globArg_, Elm.functionReduced "globUnpack" globArg_0 ]


{-| A do-style helper for [`Script.log`](Pages-Script#log).

    example : BackendTask FatalError ()
    example =
        log "Starting script..." <|
            \() ->
                -- ...
                log "Done!" <|
                    \() ->
                        noop

log: 
    String
    -> (() -> BackendTask.BackendTask error b)
    -> BackendTask.BackendTask error b
-}
log : String -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
log logArg_ logArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Do" ]
             , name = "log"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.function
                              [ Type.unit ]
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.var "error", Type.var "b" ]
                              )
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "b" ]
                          )
                     )
             }
        )
        [ Elm.string logArg_, Elm.functionReduced "logUnpack" logArg_0 ]


{-| A do-style helper for [`Env.expect`](BackendTask-Env#expect).

    example : BackendTask FatalError ()
    example =
        env "API_KEY" <|
            \apiKey ->
                allowFatal (apiRequest apiKey) <|
                    \() ->
                        noop

env: 
    String
    -> (String -> BackendTask.BackendTask FatalError.FatalError b)
    -> BackendTask.BackendTask FatalError.FatalError b
-}
env : String -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
env envArg_ envArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Do" ]
             , name = "env"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.function
                              [ Type.string ]
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.namedWith
                                       [ "FatalError" ]
                                       "FatalError"
                                       []
                                 , Type.var "b"
                                 ]
                              )
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.namedWith [ "FatalError" ] "FatalError" []
                               , Type.var "b"
                               ]
                          )
                     )
             }
        )
        [ Elm.string envArg_, Elm.functionReduced "envUnpack" envArg_0 ]


{-| checkCompilationInDir : String -> BackendTask FatalError ()
    checkCompilationInDir dir =
        glob (dir ++ "/**/*.elm") <|
            \elmFiles ->
                each elmFiles
                    (\elmFile ->
                        Shell.sh "elm" [ "make", elmFile, "--output", "/dev/null" ]
                            |> BackendTask.quiet
                    )
                <|
                    \_ ->
                        noop

each: 
    List a
    -> (a -> BackendTask.BackendTask error b)
    -> (List b -> BackendTask.BackendTask error c)
    -> BackendTask.BackendTask error c
-}
each :
    List Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
each eachArg_ eachArg_0 eachArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Do" ]
             , name = "each"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list (Type.var "a")
                          , Type.function
                              [ Type.var "a" ]
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.var "error", Type.var "b" ]
                              )
                          , Type.function
                              [ Type.list (Type.var "b") ]
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.var "error", Type.var "c" ]
                              )
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "c" ]
                          )
                     )
             }
        )
        [ Elm.list eachArg_
        , Elm.functionReduced "eachUnpack" eachArg_0
        , Elm.functionReduced "eachUnpack" eachArg_1
        ]


{-| A do-style helper for [`BackendTask.failIf`](BackendTask#failIf).

failIf: 
    Bool
    -> FatalError.FatalError
    -> (() -> BackendTask.BackendTask FatalError.FatalError b)
    -> BackendTask.BackendTask FatalError.FatalError b
-}
failIf :
    Bool
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
failIf failIfArg_ failIfArg_0 failIfArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Do" ]
             , name = "failIf"
             , annotation =
                 Just
                     (Type.function
                          [ Type.bool
                          , Type.namedWith [ "FatalError" ] "FatalError" []
                          , Type.function
                              [ Type.unit ]
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.namedWith
                                       [ "FatalError" ]
                                       "FatalError"
                                       []
                                 , Type.var "b"
                                 ]
                              )
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.namedWith [ "FatalError" ] "FatalError" []
                               , Type.var "b"
                               ]
                          )
                     )
             }
        )
        [ Elm.bool failIfArg_
        , failIfArg_0
        , Elm.functionReduced "failIfUnpack" failIfArg_1
        ]


call_ :
    { do : Elm.Expression -> Elm.Expression -> Elm.Expression
    , allowFatal : Elm.Expression -> Elm.Expression -> Elm.Expression
    , exec :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , command :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , glob : Elm.Expression -> Elm.Expression -> Elm.Expression
    , log : Elm.Expression -> Elm.Expression -> Elm.Expression
    , env : Elm.Expression -> Elm.Expression -> Elm.Expression
    , each :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , failIf :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { do =
        \doArg_ doArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Do" ]
                     , name = "do"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "a" ]
                                  , Type.function
                                      [ Type.var "a" ]
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.var "error", Type.var "b" ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.var "b" ]
                                  )
                             )
                     }
                )
                [ doArg_, doArg_0 ]
    , allowFatal =
        \allowFatalArg_ allowFatalArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Do" ]
                     , name = "allowFatal"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.extensible
                                            "error"
                                            [ ( "fatal"
                                              , Type.namedWith
                                                    [ "FatalError" ]
                                                    "FatalError"
                                                    []
                                              )
                                            ]
                                      , Type.var "data"
                                      ]
                                  , Type.function
                                      [ Type.var "data" ]
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.namedWith
                                               [ "FatalError" ]
                                               "FatalError"
                                               []
                                         , Type.var "b"
                                         ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.namedWith
                                           [ "FatalError" ]
                                           "FatalError"
                                           []
                                       , Type.var "b"
                                       ]
                                  )
                             )
                     }
                )
                [ allowFatalArg_, allowFatalArg_0 ]
    , exec =
        \execArg_ execArg_0 execArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Do" ]
                     , name = "exec"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.list Type.string
                                  , Type.function
                                      [ Type.unit ]
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.namedWith
                                               [ "FatalError" ]
                                               "FatalError"
                                               []
                                         , Type.var "b"
                                         ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.namedWith
                                           [ "FatalError" ]
                                           "FatalError"
                                           []
                                       , Type.var "b"
                                       ]
                                  )
                             )
                     }
                )
                [ execArg_, execArg_0, execArg_1 ]
    , command =
        \commandArg_ commandArg_0 commandArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Do" ]
                     , name = "command"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.list Type.string
                                  , Type.function
                                      [ Type.string ]
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.namedWith
                                               [ "FatalError" ]
                                               "FatalError"
                                               []
                                         , Type.var "b"
                                         ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.namedWith
                                           [ "FatalError" ]
                                           "FatalError"
                                           []
                                       , Type.var "b"
                                       ]
                                  )
                             )
                     }
                )
                [ commandArg_, commandArg_0, commandArg_1 ]
    , glob =
        \globArg_ globArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Do" ]
                     , name = "glob"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.function
                                      [ Type.list Type.string ]
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.namedWith
                                               [ "FatalError" ]
                                               "FatalError"
                                               []
                                         , Type.var "a"
                                         ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.namedWith
                                           [ "FatalError" ]
                                           "FatalError"
                                           []
                                       , Type.var "a"
                                       ]
                                  )
                             )
                     }
                )
                [ globArg_, globArg_0 ]
    , log =
        \logArg_ logArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Do" ]
                     , name = "log"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.function
                                      [ Type.unit ]
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.var "error", Type.var "b" ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.var "b" ]
                                  )
                             )
                     }
                )
                [ logArg_, logArg_0 ]
    , env =
        \envArg_ envArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Do" ]
                     , name = "env"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.function
                                      [ Type.string ]
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.namedWith
                                               [ "FatalError" ]
                                               "FatalError"
                                               []
                                         , Type.var "b"
                                         ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.namedWith
                                           [ "FatalError" ]
                                           "FatalError"
                                           []
                                       , Type.var "b"
                                       ]
                                  )
                             )
                     }
                )
                [ envArg_, envArg_0 ]
    , each =
        \eachArg_ eachArg_0 eachArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Do" ]
                     , name = "each"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list (Type.var "a")
                                  , Type.function
                                      [ Type.var "a" ]
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.var "error", Type.var "b" ]
                                      )
                                  , Type.function
                                      [ Type.list (Type.var "b") ]
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.var "error", Type.var "c" ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.var "c" ]
                                  )
                             )
                     }
                )
                [ eachArg_, eachArg_0, eachArg_1 ]
    , failIf =
        \failIfArg_ failIfArg_0 failIfArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Do" ]
                     , name = "failIf"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.bool
                                  , Type.namedWith
                                      [ "FatalError" ]
                                      "FatalError"
                                      []
                                  , Type.function
                                      [ Type.unit ]
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.namedWith
                                               [ "FatalError" ]
                                               "FatalError"
                                               []
                                         , Type.var "b"
                                         ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.namedWith
                                           [ "FatalError" ]
                                           "FatalError"
                                           []
                                       , Type.var "b"
                                       ]
                                  )
                             )
                     }
                )
                [ failIfArg_, failIfArg_0, failIfArg_1 ]
    }


values_ :
    { do : Elm.Expression
    , allowFatal : Elm.Expression
    , noop : Elm.Expression
    , exec : Elm.Expression
    , command : Elm.Expression
    , glob : Elm.Expression
    , log : Elm.Expression
    , env : Elm.Expression
    , each : Elm.Expression
    , failIf : Elm.Expression
    }
values_ =
    { do =
        Elm.value
            { importFrom = [ "BackendTask", "Do" ]
            , name = "do"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "a" ]
                         , Type.function
                             [ Type.var "a" ]
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.var "error", Type.var "b" ]
                             )
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "b" ]
                         )
                    )
            }
    , allowFatal =
        Elm.value
            { importFrom = [ "BackendTask", "Do" ]
            , name = "allowFatal"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.extensible
                                   "error"
                                   [ ( "fatal"
                                     , Type.namedWith
                                           [ "FatalError" ]
                                           "FatalError"
                                           []
                                     )
                                   ]
                             , Type.var "data"
                             ]
                         , Type.function
                             [ Type.var "data" ]
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                      [ "FatalError" ]
                                      "FatalError"
                                      []
                                , Type.var "b"
                                ]
                             )
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.var "b"
                              ]
                         )
                    )
            }
    , noop =
        Elm.value
            { importFrom = [ "BackendTask", "Do" ]
            , name = "noop"
            , annotation =
                Just
                    (Type.namedWith
                         [ "BackendTask" ]
                         "BackendTask"
                         [ Type.var "error", Type.unit ]
                    )
            }
    , exec =
        Elm.value
            { importFrom = [ "BackendTask", "Do" ]
            , name = "exec"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.list Type.string
                         , Type.function
                             [ Type.unit ]
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                      [ "FatalError" ]
                                      "FatalError"
                                      []
                                , Type.var "b"
                                ]
                             )
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.var "b"
                              ]
                         )
                    )
            }
    , command =
        Elm.value
            { importFrom = [ "BackendTask", "Do" ]
            , name = "command"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.list Type.string
                         , Type.function
                             [ Type.string ]
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                      [ "FatalError" ]
                                      "FatalError"
                                      []
                                , Type.var "b"
                                ]
                             )
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.var "b"
                              ]
                         )
                    )
            }
    , glob =
        Elm.value
            { importFrom = [ "BackendTask", "Do" ]
            , name = "glob"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.function
                             [ Type.list Type.string ]
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                      [ "FatalError" ]
                                      "FatalError"
                                      []
                                , Type.var "a"
                                ]
                             )
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.var "a"
                              ]
                         )
                    )
            }
    , log =
        Elm.value
            { importFrom = [ "BackendTask", "Do" ]
            , name = "log"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.function
                             [ Type.unit ]
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.var "error", Type.var "b" ]
                             )
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "b" ]
                         )
                    )
            }
    , env =
        Elm.value
            { importFrom = [ "BackendTask", "Do" ]
            , name = "env"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.function
                             [ Type.string ]
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                      [ "FatalError" ]
                                      "FatalError"
                                      []
                                , Type.var "b"
                                ]
                             )
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.var "b"
                              ]
                         )
                    )
            }
    , each =
        Elm.value
            { importFrom = [ "BackendTask", "Do" ]
            , name = "each"
            , annotation =
                Just
                    (Type.function
                         [ Type.list (Type.var "a")
                         , Type.function
                             [ Type.var "a" ]
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.var "error", Type.var "b" ]
                             )
                         , Type.function
                             [ Type.list (Type.var "b") ]
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.var "error", Type.var "c" ]
                             )
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "c" ]
                         )
                    )
            }
    , failIf =
        Elm.value
            { importFrom = [ "BackendTask", "Do" ]
            , name = "failIf"
            , annotation =
                Just
                    (Type.function
                         [ Type.bool
                         , Type.namedWith [ "FatalError" ] "FatalError" []
                         , Type.function
                             [ Type.unit ]
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.namedWith
                                      [ "FatalError" ]
                                      "FatalError"
                                      []
                                , Type.var "b"
                                ]
                             )
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.var "b"
                              ]
                         )
                    )
            }
    }