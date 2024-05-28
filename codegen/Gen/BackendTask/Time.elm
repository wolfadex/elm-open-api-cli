module Gen.BackendTask.Time exposing (moduleName_, now, values_)

{-| 
@docs moduleName_, now, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "BackendTask", "Time" ]


{-| Gives a `Time.Posix` of when the `BackendTask` executes.

    type alias Data =
        { time : Time.Posix
        }

    data : BackendTask FatalError Data
    data =
        BackendTask.map Data
            BackendTask.Time.now

It's better to use [`Server.Request.requestTime`](Server-Request#requestTime) or `Pages.builtAt` when those are the semantics
you are looking for. `requestTime` gives you a single reliable and consistent time for when the incoming HTTP request was received in
a server-rendered Route or server-rendered API Route. `Pages.builtAt` gives a single reliable and consistent time when the
site was built.

`BackendTask.Time.now` gives you the time that it happened to execute, which might give you what you need, but be
aware that the time you get is dependent on how BackendTask's are scheduled and executed internally in elm-pages, and
its best to avoid depending on that variation when possible.

now: BackendTask.BackendTask error Time.Posix
-}
now : Elm.Expression
now =
    Elm.value
        { importFrom = [ "BackendTask", "Time" ]
        , name = "now"
        , annotation =
            Just
                (Type.namedWith
                     [ "BackendTask" ]
                     "BackendTask"
                     [ Type.var "error", Type.namedWith [ "Time" ] "Posix" [] ]
                )
        }


values_ : { now : Elm.Expression }
values_ =
    { now =
        Elm.value
            { importFrom = [ "BackendTask", "Time" ]
            , name = "now"
            , annotation =
                Just
                    (Type.namedWith
                         [ "BackendTask" ]
                         "BackendTask"
                         [ Type.var "error"
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                    )
            }
    }