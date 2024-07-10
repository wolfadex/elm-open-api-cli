module Gen.Effect.Task exposing (andThen, annotation_, attempt, call_, fail, map, map2, map3, map4, map5, mapError, moduleName_, onError, perform, sequence, succeed, values_)

{-| 
@docs moduleName_, onError, sequence, mapError, map5, map4, map3, map2, map, fail, succeed, andThen, attempt, perform, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Effect", "Task" ]


{-| {-| Recover from a failure in a task. If the given task fails, we use the
callback to recover.

    fail "file not found"
      |> onError (\msg -> succeed 42)
      -- succeed 42

    succeed 9
      |> onError (\msg -> succeed 42)
      -- succeed 9

-}

onError: 
    (x -> Effect.Internal.Task restriction y a)
    -> Effect.Internal.Task restriction x a
    -> Effect.Internal.Task restriction y a
-}
onError : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
onError onErrorArg onErrorArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Effect", "Task" ]
             , name = "onError"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "x" ]
                              (Type.namedWith
                                 [ "Effect", "Internal" ]
                                 "Task"
                                 [ Type.var "restriction"
                                 , Type.var "y"
                                 , Type.var "a"
                                 ]
                              )
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "a"
                              ]
                          ]
                          (Type.namedWith
                               [ "Effect", "Internal" ]
                               "Task"
                               [ Type.var "restriction"
                               , Type.var "y"
                               , Type.var "a"
                               ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "onErrorUnpack" onErrorArg, onErrorArg0 ]


{-| {-| Start with a list of tasks, and turn them into a single task that returns a
list. The tasks will be run in order one-by-one and if any task fails the whole
sequence fails.

    sequence [ succeed 1, succeed 2 ] == succeed [ 1, 2 ]

-}

sequence: 
    List (Effect.Internal.Task restriction x a)
    -> Effect.Internal.Task restriction x (List a)
-}
sequence : List Elm.Expression -> Elm.Expression
sequence sequenceArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Effect", "Task" ]
             , name = "sequence"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "Effect", "Internal" ]
                                 "Task"
                                 [ Type.var "restriction"
                                 , Type.var "x"
                                 , Type.var "a"
                                 ]
                              )
                          ]
                          (Type.namedWith
                               [ "Effect", "Internal" ]
                               "Task"
                               [ Type.var "restriction"
                               , Type.var "x"
                               , Type.list (Type.var "a")
                               ]
                          )
                     )
             }
        )
        [ Elm.list sequenceArg ]


{-| {-| Transform the error value. This can be useful if you need a bunch of error
types to match up.

    type Error
        = Http Http.Error
        | WebGL WebGL.Error

    getResources : Task Error Resource
    getResources =
        sequence
            [ mapError Http serverTask
            , mapError WebGL textureTask
            ]

-}

mapError: 
    (x -> y)
    -> Effect.Internal.Task restriction x a
    -> Effect.Internal.Task restriction y a
-}
mapError :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
mapError mapErrorArg mapErrorArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Effect", "Task" ]
             , name = "mapError"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function [ Type.var "x" ] (Type.var "y")
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "a"
                              ]
                          ]
                          (Type.namedWith
                               [ "Effect", "Internal" ]
                               "Task"
                               [ Type.var "restriction"
                               , Type.var "y"
                               , Type.var "a"
                               ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapErrorUnpack" mapErrorArg, mapErrorArg0 ]


{-| {-| -}

map5: 
    (a -> b -> c -> d -> e -> result)
    -> Effect.Internal.Task restriction x a
    -> Effect.Internal.Task restriction x b
    -> Effect.Internal.Task restriction x c
    -> Effect.Internal.Task restriction x d
    -> Effect.Internal.Task restriction x e
    -> Effect.Internal.Task restriction x result
-}
map5 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map5 map5Arg map5Arg0 map5Arg1 map5Arg2 map5Arg3 map5Arg4 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Effect", "Task" ]
             , name = "map5"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a"
                              , Type.var "b"
                              , Type.var "c"
                              , Type.var "d"
                              , Type.var "e"
                              ]
                              (Type.var "result")
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "a"
                              ]
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "b"
                              ]
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "c"
                              ]
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "d"
                              ]
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "e"
                              ]
                          ]
                          (Type.namedWith
                               [ "Effect", "Internal" ]
                               "Task"
                               [ Type.var "restriction"
                               , Type.var "x"
                               , Type.var "result"
                               ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map5Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (\functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0 ->
                                          Elm.functionReduced
                                              "unpack"
                                              ((((map5Arg functionReducedUnpack)
                                                     functionReducedUnpack0
                                                )
                                                    functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                               )
                                                   functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0
                                              )
                                     )
                            )
                   )
            )
        , map5Arg0
        , map5Arg1
        , map5Arg2
        , map5Arg3
        , map5Arg4
        ]


{-| {-| -}

map4: 
    (a -> b -> c -> d -> result)
    -> Effect.Internal.Task restriction x a
    -> Effect.Internal.Task restriction x b
    -> Effect.Internal.Task restriction x c
    -> Effect.Internal.Task restriction x d
    -> Effect.Internal.Task restriction x result
-}
map4 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map4 map4Arg map4Arg0 map4Arg1 map4Arg2 map4Arg3 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Effect", "Task" ]
             , name = "map4"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a"
                              , Type.var "b"
                              , Type.var "c"
                              , Type.var "d"
                              ]
                              (Type.var "result")
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "a"
                              ]
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "b"
                              ]
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "c"
                              ]
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "d"
                              ]
                          ]
                          (Type.namedWith
                               [ "Effect", "Internal" ]
                               "Task"
                               [ Type.var "restriction"
                               , Type.var "x"
                               , Type.var "result"
                               ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map4Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (((map4Arg functionReducedUnpack)
                                           functionReducedUnpack0
                                      )
                                          functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                     )
                            )
                   )
            )
        , map4Arg0
        , map4Arg1
        , map4Arg2
        , map4Arg3
        ]


{-| {-| -}

map3: 
    (a -> b -> c -> result)
    -> Effect.Internal.Task restriction x a
    -> Effect.Internal.Task restriction x b
    -> Effect.Internal.Task restriction x c
    -> Effect.Internal.Task restriction x result
-}
map3 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map3 map3Arg map3Arg0 map3Arg1 map3Arg2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Effect", "Task" ]
             , name = "map3"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a", Type.var "b", Type.var "c" ]
                              (Type.var "result")
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "a"
                              ]
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "b"
                              ]
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "c"
                              ]
                          ]
                          (Type.namedWith
                               [ "Effect", "Internal" ]
                               "Task"
                               [ Type.var "restriction"
                               , Type.var "x"
                               , Type.var "result"
                               ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map3Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            ((map3Arg functionReducedUnpack)
                                 functionReducedUnpack0
                            )
                   )
            )
        , map3Arg0
        , map3Arg1
        , map3Arg2
        ]


{-| {-| Put the results of two tasks together. For example, if we wanted to know
the current month, we could use [`elm/time`][time] to ask:

    import Task exposing (Task)
    import Time


    -- elm install elm/time
    getMonth : Task x Int
    getMonth =
        Task.map2 Time.toMonth Time.here Time.now

**Note:** Say we were doing HTTP requests instead. `map2` does each task in
order, so it would try the first request and only continue after it succeeds.
If it fails, the whole thing fails!

[time]: /packages/elm/time/latest/

-}

map2: 
    (a -> b -> result)
    -> Effect.Internal.Task restriction x a
    -> Effect.Internal.Task restriction x b
    -> Effect.Internal.Task restriction x result
-}
map2 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map2 map2Arg map2Arg0 map2Arg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Effect", "Task" ]
             , name = "map2"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a", Type.var "b" ]
                              (Type.var "result")
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "a"
                              ]
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "b"
                              ]
                          ]
                          (Type.namedWith
                               [ "Effect", "Internal" ]
                               "Task"
                               [ Type.var "restriction"
                               , Type.var "x"
                               , Type.var "result"
                               ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map2Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced "unpack" (map2Arg functionReducedUnpack)
            )
        , map2Arg0
        , map2Arg1
        ]


{-| {-| Transform a task. Maybe you want to use [`elm/time`][time] to figure
out what time it will be in one hour:

    import Task exposing (Task)
    import Time


    -- elm install elm/time
    timeInOneHour : Task x Time.Posix
    timeInOneHour =
        Task.map addAnHour Time.now

    addAnHour : Time.Posix -> Time.Posix
    addAnHour time =
        Time.millisToPosix (Time.posixToMillis time + 60 * 60 * 1000)

[time]: /packages/elm/time/latest/

-}

map: 
    (a -> b)
    -> Effect.Internal.Task restriction x a
    -> Effect.Internal.Task restriction x b
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg mapArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Effect", "Task" ]
             , name = "map"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function [ Type.var "a" ] (Type.var "b")
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "a"
                              ]
                          ]
                          (Type.namedWith
                               [ "Effect", "Internal" ]
                               "Task"
                               [ Type.var "restriction"
                               , Type.var "x"
                               , Type.var "b"
                               ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapUnpack" mapArg, mapArg0 ]


{-| {-| A task that fails immediately when run. Like with `succeed`, this can be
used with `andThen` to check on the outcome of another task.

    type Error
        = NotFound

    notFound : Task Error a
    notFound =
        fail NotFound

-}

fail: x -> Effect.Internal.Task restriction x a
-}
fail : Elm.Expression -> Elm.Expression
fail failArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Effect", "Task" ]
             , name = "fail"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "x" ]
                          (Type.namedWith
                               [ "Effect", "Internal" ]
                               "Task"
                               [ Type.var "restriction"
                               , Type.var "x"
                               , Type.var "a"
                               ]
                          )
                     )
             }
        )
        [ failArg ]


{-| {-| A task that succeeds immediately when run. It is usually used with
[`andThen`](#andThen). You can use it like `map` if you want:

    import Time


    -- elm install elm/time
    timeInMillis : Task x Int
    timeInMillis =
        Time.now
            |> andThen (\t -> succeed (Time.posixToMillis t))

-}

succeed: a -> Effect.Internal.Task restriction x a
-}
succeed : Elm.Expression -> Elm.Expression
succeed succeedArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Effect", "Task" ]
             , name = "succeed"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "a" ]
                          (Type.namedWith
                               [ "Effect", "Internal" ]
                               "Task"
                               [ Type.var "restriction"
                               , Type.var "x"
                               , Type.var "a"
                               ]
                          )
                     )
             }
        )
        [ succeedArg ]


{-| {-| Chain together a task and a callback. The first task will run, and if it is
successful, you give the result to the callback resulting in another task. This
task then gets run. We could use this to make a task that resolves an hour from
now:

    -- elm install elm/time


    import Process
    import Time

    timeInOneHour : Task x Time.Posix
    timeInOneHour =
        Process.sleep (60 * 60 * 1000)
            |> andThen (\_ -> Time.now)

First the process sleeps for an hour **and then** it tells us what time it is.

-}

andThen: 
    (a -> Effect.Internal.Task restriction x b)
    -> Effect.Internal.Task restriction x a
    -> Effect.Internal.Task restriction x b
-}
andThen : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
andThen andThenArg andThenArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Effect", "Task" ]
             , name = "andThen"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a" ]
                              (Type.namedWith
                                 [ "Effect", "Internal" ]
                                 "Task"
                                 [ Type.var "restriction"
                                 , Type.var "x"
                                 , Type.var "b"
                                 ]
                              )
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "a"
                              ]
                          ]
                          (Type.namedWith
                               [ "Effect", "Internal" ]
                               "Task"
                               [ Type.var "restriction"
                               , Type.var "x"
                               , Type.var "b"
                               ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "andThenUnpack" andThenArg, andThenArg0 ]


{-| {-| This is very similar to [`perform`](#perform) except it can handle failures!
So we could _attempt_ to focus on a certain DOM node like this:

    -- elm install elm/browser


    import Browser.Dom
    import Task

    type Msg
        = Click
        | Search String
        | Focus (Result Browser.DomError ())

    focus : Cmd Msg
    focus =
        Task.attempt Focus (Browser.Dom.focus "my-app-search-box")

So the task is "focus on this DOM node" and we are turning it into the command
"Hey Elm, attempt to focus on this DOM node and give me a `Msg` about whether
you succeeded or failed."

**Note:** Definitely work through [`guide.elm-lang.org`][guide] to get a
feeling for how commands fit into The Elm Architecture.

[guide]: https://guide.elm-lang.org/

-}

attempt: 
    (Result.Result x a -> msg)
    -> Effect.Internal.Task restriction x a
    -> Effect.Internal.Command restriction toMsg msg
-}
attempt : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
attempt attemptArg attemptArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Effect", "Task" ]
             , name = "attempt"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.var "x", Type.var "a" ]
                              ]
                              (Type.var "msg")
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "a"
                              ]
                          ]
                          (Type.namedWith
                               [ "Effect", "Internal" ]
                               "Command"
                               [ Type.var "restriction"
                               , Type.var "toMsg"
                               , Type.var "msg"
                               ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "attemptUnpack" attemptArg, attemptArg0 ]


{-| {-| Like I was saying in the [`Task`](#Task) documentation, just having a
`Task` does not mean it is done. We must command Elm to `perform` the task:

    -- elm install elm/time


    import Task
    import Time

    type Msg
        = Click
        | Search String
        | NewTime Time.Posix

    getNewTime : Cmd Msg
    getNewTime =
        Task.perform NewTime Time.now

If you have worked through [`guide.elm-lang.org`][guide] (highly recommended!)
you will recognize `Cmd` from the section on The Elm Architecture. So we have
changed a task like "make delicious lasagna" into a command like "Hey Elm, make
delicious lasagna and give it to my `update` function as a `Msg` value."

[guide]: https://guide.elm-lang.org/

-}

perform: 
    (a -> msg)
    -> Effect.Internal.Task restriction Basics.Never a
    -> Effect.Internal.Command restriction toMsg msg
-}
perform : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
perform performArg performArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Effect", "Task" ]
             , name = "perform"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function [ Type.var "a" ] (Type.var "msg")
                          , Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.namedWith [ "Basics" ] "Never" []
                              , Type.var "a"
                              ]
                          ]
                          (Type.namedWith
                               [ "Effect", "Internal" ]
                               "Command"
                               [ Type.var "restriction"
                               , Type.var "toMsg"
                               , Type.var "msg"
                               ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "performUnpack" performArg, performArg0 ]


annotation_ :
    { task :
        Type.Annotation -> Type.Annotation -> Type.Annotation -> Type.Annotation
    }
annotation_ =
    { task =
        \taskArg0 taskArg1 taskArg2 ->
            Type.alias
                moduleName_
                "Task"
                [ taskArg0, taskArg1, taskArg2 ]
                (Type.namedWith
                     [ "Effect", "Internal" ]
                     "Task"
                     [ Type.var "restriction", Type.var "x", Type.var "a" ]
                )
    }


call_ :
    { onError : Elm.Expression -> Elm.Expression -> Elm.Expression
    , sequence : Elm.Expression -> Elm.Expression
    , mapError : Elm.Expression -> Elm.Expression -> Elm.Expression
    , map5 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map4 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map3 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map2 :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fail : Elm.Expression -> Elm.Expression
    , succeed : Elm.Expression -> Elm.Expression
    , andThen : Elm.Expression -> Elm.Expression -> Elm.Expression
    , attempt : Elm.Expression -> Elm.Expression -> Elm.Expression
    , perform : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { onError =
        \onErrorArg onErrorArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Effect", "Task" ]
                     , name = "onError"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "x" ]
                                      (Type.namedWith
                                         [ "Effect", "Internal" ]
                                         "Task"
                                         [ Type.var "restriction"
                                         , Type.var "y"
                                         , Type.var "a"
                                         ]
                                      )
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "a"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Effect", "Internal" ]
                                       "Task"
                                       [ Type.var "restriction"
                                       , Type.var "y"
                                       , Type.var "a"
                                       ]
                                  )
                             )
                     }
                )
                [ onErrorArg, onErrorArg0 ]
    , sequence =
        \sequenceArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Effect", "Task" ]
                     , name = "sequence"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "Effect", "Internal" ]
                                         "Task"
                                         [ Type.var "restriction"
                                         , Type.var "x"
                                         , Type.var "a"
                                         ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "Effect", "Internal" ]
                                       "Task"
                                       [ Type.var "restriction"
                                       , Type.var "x"
                                       , Type.list (Type.var "a")
                                       ]
                                  )
                             )
                     }
                )
                [ sequenceArg ]
    , mapError =
        \mapErrorArg mapErrorArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Effect", "Task" ]
                     , name = "mapError"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "x" ]
                                      (Type.var "y")
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "a"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Effect", "Internal" ]
                                       "Task"
                                       [ Type.var "restriction"
                                       , Type.var "y"
                                       , Type.var "a"
                                       ]
                                  )
                             )
                     }
                )
                [ mapErrorArg, mapErrorArg0 ]
    , map5 =
        \map5Arg map5Arg0 map5Arg1 map5Arg2 map5Arg3 map5Arg4 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Effect", "Task" ]
                     , name = "map5"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a"
                                      , Type.var "b"
                                      , Type.var "c"
                                      , Type.var "d"
                                      , Type.var "e"
                                      ]
                                      (Type.var "result")
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "a"
                                      ]
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "b"
                                      ]
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "c"
                                      ]
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "d"
                                      ]
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "e"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Effect", "Internal" ]
                                       "Task"
                                       [ Type.var "restriction"
                                       , Type.var "x"
                                       , Type.var "result"
                                       ]
                                  )
                             )
                     }
                )
                [ map5Arg, map5Arg0, map5Arg1, map5Arg2, map5Arg3, map5Arg4 ]
    , map4 =
        \map4Arg map4Arg0 map4Arg1 map4Arg2 map4Arg3 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Effect", "Task" ]
                     , name = "map4"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a"
                                      , Type.var "b"
                                      , Type.var "c"
                                      , Type.var "d"
                                      ]
                                      (Type.var "result")
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "a"
                                      ]
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "b"
                                      ]
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "c"
                                      ]
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "d"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Effect", "Internal" ]
                                       "Task"
                                       [ Type.var "restriction"
                                       , Type.var "x"
                                       , Type.var "result"
                                       ]
                                  )
                             )
                     }
                )
                [ map4Arg, map4Arg0, map4Arg1, map4Arg2, map4Arg3 ]
    , map3 =
        \map3Arg map3Arg0 map3Arg1 map3Arg2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Effect", "Task" ]
                     , name = "map3"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a"
                                      , Type.var "b"
                                      , Type.var "c"
                                      ]
                                      (Type.var "result")
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "a"
                                      ]
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "b"
                                      ]
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "c"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Effect", "Internal" ]
                                       "Task"
                                       [ Type.var "restriction"
                                       , Type.var "x"
                                       , Type.var "result"
                                       ]
                                  )
                             )
                     }
                )
                [ map3Arg, map3Arg0, map3Arg1, map3Arg2 ]
    , map2 =
        \map2Arg map2Arg0 map2Arg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Effect", "Task" ]
                     , name = "map2"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a", Type.var "b" ]
                                      (Type.var "result")
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "a"
                                      ]
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "b"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Effect", "Internal" ]
                                       "Task"
                                       [ Type.var "restriction"
                                       , Type.var "x"
                                       , Type.var "result"
                                       ]
                                  )
                             )
                     }
                )
                [ map2Arg, map2Arg0, map2Arg1 ]
    , map =
        \mapArg mapArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Effect", "Task" ]
                     , name = "map"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.var "b")
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "a"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Effect", "Internal" ]
                                       "Task"
                                       [ Type.var "restriction"
                                       , Type.var "x"
                                       , Type.var "b"
                                       ]
                                  )
                             )
                     }
                )
                [ mapArg, mapArg0 ]
    , fail =
        \failArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Effect", "Task" ]
                     , name = "fail"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "x" ]
                                  (Type.namedWith
                                       [ "Effect", "Internal" ]
                                       "Task"
                                       [ Type.var "restriction"
                                       , Type.var "x"
                                       , Type.var "a"
                                       ]
                                  )
                             )
                     }
                )
                [ failArg ]
    , succeed =
        \succeedArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Effect", "Task" ]
                     , name = "succeed"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "a" ]
                                  (Type.namedWith
                                       [ "Effect", "Internal" ]
                                       "Task"
                                       [ Type.var "restriction"
                                       , Type.var "x"
                                       , Type.var "a"
                                       ]
                                  )
                             )
                     }
                )
                [ succeedArg ]
    , andThen =
        \andThenArg andThenArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Effect", "Task" ]
                     , name = "andThen"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.namedWith
                                         [ "Effect", "Internal" ]
                                         "Task"
                                         [ Type.var "restriction"
                                         , Type.var "x"
                                         , Type.var "b"
                                         ]
                                      )
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "a"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Effect", "Internal" ]
                                       "Task"
                                       [ Type.var "restriction"
                                       , Type.var "x"
                                       , Type.var "b"
                                       ]
                                  )
                             )
                     }
                )
                [ andThenArg, andThenArg0 ]
    , attempt =
        \attemptArg attemptArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Effect", "Task" ]
                     , name = "attempt"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.namedWith
                                            [ "Result" ]
                                            "Result"
                                            [ Type.var "x", Type.var "a" ]
                                      ]
                                      (Type.var "msg")
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.var "x"
                                      , Type.var "a"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Effect", "Internal" ]
                                       "Command"
                                       [ Type.var "restriction"
                                       , Type.var "toMsg"
                                       , Type.var "msg"
                                       ]
                                  )
                             )
                     }
                )
                [ attemptArg, attemptArg0 ]
    , perform =
        \performArg performArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Effect", "Task" ]
                     , name = "perform"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.var "msg")
                                  , Type.namedWith
                                      [ "Effect", "Internal" ]
                                      "Task"
                                      [ Type.var "restriction"
                                      , Type.namedWith [ "Basics" ] "Never" []
                                      , Type.var "a"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Effect", "Internal" ]
                                       "Command"
                                       [ Type.var "restriction"
                                       , Type.var "toMsg"
                                       , Type.var "msg"
                                       ]
                                  )
                             )
                     }
                )
                [ performArg, performArg0 ]
    }


values_ :
    { onError : Elm.Expression
    , sequence : Elm.Expression
    , mapError : Elm.Expression
    , map5 : Elm.Expression
    , map4 : Elm.Expression
    , map3 : Elm.Expression
    , map2 : Elm.Expression
    , map : Elm.Expression
    , fail : Elm.Expression
    , succeed : Elm.Expression
    , andThen : Elm.Expression
    , attempt : Elm.Expression
    , perform : Elm.Expression
    }
values_ =
    { onError =
        Elm.value
            { importFrom = [ "Effect", "Task" ]
            , name = "onError"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "x" ]
                             (Type.namedWith
                                [ "Effect", "Internal" ]
                                "Task"
                                [ Type.var "restriction"
                                , Type.var "y"
                                , Type.var "a"
                                ]
                             )
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "a"
                             ]
                         ]
                         (Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "y"
                              , Type.var "a"
                              ]
                         )
                    )
            }
    , sequence =
        Elm.value
            { importFrom = [ "Effect", "Task" ]
            , name = "sequence"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "Effect", "Internal" ]
                                "Task"
                                [ Type.var "restriction"
                                , Type.var "x"
                                , Type.var "a"
                                ]
                             )
                         ]
                         (Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.list (Type.var "a")
                              ]
                         )
                    )
            }
    , mapError =
        Elm.value
            { importFrom = [ "Effect", "Task" ]
            , name = "mapError"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.var "x" ] (Type.var "y")
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "a"
                             ]
                         ]
                         (Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "y"
                              , Type.var "a"
                              ]
                         )
                    )
            }
    , map5 =
        Elm.value
            { importFrom = [ "Effect", "Task" ]
            , name = "map5"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a"
                             , Type.var "b"
                             , Type.var "c"
                             , Type.var "d"
                             , Type.var "e"
                             ]
                             (Type.var "result")
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "a"
                             ]
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "b"
                             ]
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "c"
                             ]
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "d"
                             ]
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "e"
                             ]
                         ]
                         (Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "result"
                              ]
                         )
                    )
            }
    , map4 =
        Elm.value
            { importFrom = [ "Effect", "Task" ]
            , name = "map4"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a"
                             , Type.var "b"
                             , Type.var "c"
                             , Type.var "d"
                             ]
                             (Type.var "result")
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "a"
                             ]
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "b"
                             ]
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "c"
                             ]
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "d"
                             ]
                         ]
                         (Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "result"
                              ]
                         )
                    )
            }
    , map3 =
        Elm.value
            { importFrom = [ "Effect", "Task" ]
            , name = "map3"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a", Type.var "b", Type.var "c" ]
                             (Type.var "result")
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "a"
                             ]
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "b"
                             ]
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "c"
                             ]
                         ]
                         (Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "result"
                              ]
                         )
                    )
            }
    , map2 =
        Elm.value
            { importFrom = [ "Effect", "Task" ]
            , name = "map2"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a", Type.var "b" ]
                             (Type.var "result")
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "a"
                             ]
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "b"
                             ]
                         ]
                         (Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "result"
                              ]
                         )
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "Effect", "Task" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.var "a" ] (Type.var "b")
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "a"
                             ]
                         ]
                         (Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "b"
                              ]
                         )
                    )
            }
    , fail =
        Elm.value
            { importFrom = [ "Effect", "Task" ]
            , name = "fail"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "x" ]
                         (Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "a"
                              ]
                         )
                    )
            }
    , succeed =
        Elm.value
            { importFrom = [ "Effect", "Task" ]
            , name = "succeed"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "a" ]
                         (Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "a"
                              ]
                         )
                    )
            }
    , andThen =
        Elm.value
            { importFrom = [ "Effect", "Task" ]
            , name = "andThen"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a" ]
                             (Type.namedWith
                                [ "Effect", "Internal" ]
                                "Task"
                                [ Type.var "restriction"
                                , Type.var "x"
                                , Type.var "b"
                                ]
                             )
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "a"
                             ]
                         ]
                         (Type.namedWith
                              [ "Effect", "Internal" ]
                              "Task"
                              [ Type.var "restriction"
                              , Type.var "x"
                              , Type.var "b"
                              ]
                         )
                    )
            }
    , attempt =
        Elm.value
            { importFrom = [ "Effect", "Task" ]
            , name = "attempt"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.namedWith
                                   [ "Result" ]
                                   "Result"
                                   [ Type.var "x", Type.var "a" ]
                             ]
                             (Type.var "msg")
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.var "x"
                             , Type.var "a"
                             ]
                         ]
                         (Type.namedWith
                              [ "Effect", "Internal" ]
                              "Command"
                              [ Type.var "restriction"
                              , Type.var "toMsg"
                              , Type.var "msg"
                              ]
                         )
                    )
            }
    , perform =
        Elm.value
            { importFrom = [ "Effect", "Task" ]
            , name = "perform"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.var "a" ] (Type.var "msg")
                         , Type.namedWith
                             [ "Effect", "Internal" ]
                             "Task"
                             [ Type.var "restriction"
                             , Type.namedWith [ "Basics" ] "Never" []
                             , Type.var "a"
                             ]
                         ]
                         (Type.namedWith
                              [ "Effect", "Internal" ]
                              "Command"
                              [ Type.var "restriction"
                              , Type.var "toMsg"
                              , Type.var "msg"
                              ]
                         )
                    )
            }
    }