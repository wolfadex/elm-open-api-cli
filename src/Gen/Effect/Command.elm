module Gen.Effect.Command exposing (moduleName_, map, sendToJs, none, batch, annotation_, call_, values_)

{-|

@docs moduleName_, fromCmd, map, sendToJs, none, batch, annotation_, call_, values_

-}

import Elm
import Elm.Annotation as Type


{-| The name of this module.
-}
moduleName_ : List String
moduleName_ =
    [ "Effect", "Command" ]


{-| {-| Transform the messages produced by a command.
Very similar to [`Html.map`](/packages/elm/html/latest/Html#map).

This is very rarely useful in well-structured Elm code, so definitely read the
section on [structure] in the guide before reaching for this!

[structure]: https://guide.elm-lang.org/webapps/structure.html

-}

map:
(toBackendA -> toBackendB)
-> (frontendMsgA -> frontendMsgB)
-> Effect.Internal.Command restriction toBackendA frontendMsgA
-> Effect.Internal.Command restriction toBackendB frontendMsgB

-}
map :
    (Elm.Expression -> Elm.Expression)
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
map mapArg mapArg0 mapArg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Effect", "Command" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "toBackendA" ]
                            (Type.var "toBackendB")
                        , Type.function
                            [ Type.var "frontendMsgA" ]
                            (Type.var "frontendMsgB")
                        , Type.namedWith
                            [ "Effect", "Internal" ]
                            "Command"
                            [ Type.var "restriction"
                            , Type.var "toBackendA"
                            , Type.var "frontendMsgA"
                            ]
                        ]
                        (Type.namedWith
                            [ "Effect", "Internal" ]
                            "Command"
                            [ Type.var "restriction"
                            , Type.var "toBackendB"
                            , Type.var "frontendMsgB"
                            ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "mapUnpack" mapArg
        , Elm.functionReduced "mapUnpack" mapArg0
        , mapArg1
        ]


{-| {-| This function sends data to JS land. Below is an example of how to use it.

    import Command
    import Json.Encode

    port copyToClipboardPort : Cmd Json.Encode.Value -> msg

    copyToClipboard value =
        Command.sendToJs "copyToClipboardPort" copyToClipboardPort value

-}

sendToJs:
String
-> (Json.Encode.Value -> Effect.Command.Cmd msg)
-> Json.Encode.Value
-> Effect.Internal.Command Effect.Command.FrontendOnly toMsg msg

-}
sendToJs :
    String
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
sendToJs sendToJsArg sendToJsArg0 sendToJsArg1 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Effect", "Command" ]
            , name = "sendToJs"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.function
                            [ Type.namedWith [ "Json", "Encode" ] "Value" [] ]
                            (Type.namedWith
                                [ "Effect", "Command" ]
                                "Cmd"
                                [ Type.var "msg" ]
                            )
                        , Type.namedWith [ "Json", "Encode" ] "Value" []
                        ]
                        (Type.namedWith
                            [ "Effect", "Internal" ]
                            "Command"
                            [ Type.namedWith
                                [ "Effect", "Command" ]
                                "FrontendOnly"
                                []
                            , Type.var "toMsg"
                            , Type.var "msg"
                            ]
                        )
                    )
            }
        )
        [ Elm.string sendToJsArg
        , Elm.functionReduced "sendToJsUnpack" sendToJsArg0
        , sendToJsArg1
        ]


{-| {-| Tell the runtime that there are no commands.
-}

none: Effect.Internal.Command restriction toMsg msg

-}
none : Elm.Expression
none =
    Elm.value
        { importFrom = [ "Effect", "Command" ]
        , name = "none"
        , annotation =
            Just
                (Type.namedWith
                    [ "Effect", "Internal" ]
                    "Command"
                    [ Type.var "restriction"
                    , Type.var "toMsg"
                    , Type.var "msg"
                    ]
                )
        }


{-| {-| When you need the runtime system to perform a couple commands, you
can batch them together. Each is handed to the runtime at the same time,
and since each can perform arbitrary operations in the world, there are
no ordering guarantees about the results.

**Note:** `Cmd.none` and `Cmd.batch [ Cmd.none, Cmd.none ]` and `Cmd.batch []`
all do the same thing.

-}

batch:
List (Effect.Internal.Command restriction toMsg msg)
-> Effect.Internal.Command restriction toMsg msg

-}
batch : List Elm.Expression -> Elm.Expression
batch batchArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Effect", "Command" ]
            , name = "batch"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.namedWith
                                [ "Effect", "Internal" ]
                                "Command"
                                [ Type.var "restriction"
                                , Type.var "toMsg"
                                , Type.var "msg"
                                ]
                            )
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
        [ Elm.list batchArg ]


annotation_ :
    { command :
        Type.Annotation -> Type.Annotation -> Type.Annotation -> Type.Annotation
    , backendOnly : Type.Annotation
    , frontendOnly : Type.Annotation
    }
annotation_ =
    { command =
        \commandArg0 commandArg1 commandArg2 ->
            Type.alias
                moduleName_
                "Command"
                [ commandArg0, commandArg1, commandArg2 ]
                (Type.namedWith
                    [ "Effect", "Internal" ]
                    "Command"
                    [ Type.var "restriction"
                    , Type.var "toMsg"
                    , Type.var "msg"
                    ]
                )
    , backendOnly =
        Type.alias
            moduleName_
            "BackendOnly"
            []
            (Type.namedWith [ "Effect", "Internal" ] "BackendOnly" [])
    , frontendOnly =
        Type.alias
            moduleName_
            "FrontendOnly"
            []
            (Type.namedWith [ "Effect", "Internal" ] "FrontendOnly" [])
    }


call_ :
    { fromCmd : Elm.Expression -> Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , sendToJs :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , batch : Elm.Expression -> Elm.Expression
    }
call_ =
    { fromCmd =
        \fromCmdArg fromCmdArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Command" ]
                    , name = "fromCmd"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "Effect", "Command" ]
                                    "Cmd"
                                    [ Type.var "msg" ]
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
                [ fromCmdArg, fromCmdArg0 ]
    , map =
        \mapArg mapArg0 mapArg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Command" ]
                    , name = "map"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "toBackendA" ]
                                    (Type.var "toBackendB")
                                , Type.function
                                    [ Type.var "frontendMsgA" ]
                                    (Type.var "frontendMsgB")
                                , Type.namedWith
                                    [ "Effect", "Internal" ]
                                    "Command"
                                    [ Type.var "restriction"
                                    , Type.var "toBackendA"
                                    , Type.var "frontendMsgA"
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Effect", "Internal" ]
                                    "Command"
                                    [ Type.var "restriction"
                                    , Type.var "toBackendB"
                                    , Type.var "frontendMsgB"
                                    ]
                                )
                            )
                    }
                )
                [ mapArg, mapArg0, mapArg1 ]
    , sendToJs =
        \sendToJsArg sendToJsArg0 sendToJsArg1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Command" ]
                    , name = "sendToJs"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.function
                                    [ Type.namedWith
                                        [ "Json", "Encode" ]
                                        "Value"
                                        []
                                    ]
                                    (Type.namedWith
                                        [ "Effect", "Command" ]
                                        "Cmd"
                                        [ Type.var "msg" ]
                                    )
                                , Type.namedWith
                                    [ "Json", "Encode" ]
                                    "Value"
                                    []
                                ]
                                (Type.namedWith
                                    [ "Effect", "Internal" ]
                                    "Command"
                                    [ Type.namedWith
                                        [ "Effect", "Command" ]
                                        "FrontendOnly"
                                        []
                                    , Type.var "toMsg"
                                    , Type.var "msg"
                                    ]
                                )
                            )
                    }
                )
                [ sendToJsArg, sendToJsArg0, sendToJsArg1 ]
    , batch =
        \batchArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Command" ]
                    , name = "batch"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.namedWith
                                        [ "Effect", "Internal" ]
                                        "Command"
                                        [ Type.var "restriction"
                                        , Type.var "toMsg"
                                        , Type.var "msg"
                                        ]
                                    )
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
                [ batchArg ]
    }


values_ :
    { fromCmd : Elm.Expression
    , map : Elm.Expression
    , sendToJs : Elm.Expression
    , none : Elm.Expression
    , batch : Elm.Expression
    }
values_ =
    { fromCmd =
        Elm.value
            { importFrom = [ "Effect", "Command" ]
            , name = "fromCmd"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Effect", "Command" ]
                            "Cmd"
                            [ Type.var "msg" ]
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
    , map =
        Elm.value
            { importFrom = [ "Effect", "Command" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "toBackendA" ]
                            (Type.var "toBackendB")
                        , Type.function
                            [ Type.var "frontendMsgA" ]
                            (Type.var "frontendMsgB")
                        , Type.namedWith
                            [ "Effect", "Internal" ]
                            "Command"
                            [ Type.var "restriction"
                            , Type.var "toBackendA"
                            , Type.var "frontendMsgA"
                            ]
                        ]
                        (Type.namedWith
                            [ "Effect", "Internal" ]
                            "Command"
                            [ Type.var "restriction"
                            , Type.var "toBackendB"
                            , Type.var "frontendMsgB"
                            ]
                        )
                    )
            }
    , sendToJs =
        Elm.value
            { importFrom = [ "Effect", "Command" ]
            , name = "sendToJs"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.function
                            [ Type.namedWith [ "Json", "Encode" ] "Value" [] ]
                            (Type.namedWith
                                [ "Effect", "Command" ]
                                "Cmd"
                                [ Type.var "msg" ]
                            )
                        , Type.namedWith [ "Json", "Encode" ] "Value" []
                        ]
                        (Type.namedWith
                            [ "Effect", "Internal" ]
                            "Command"
                            [ Type.namedWith
                                [ "Effect", "Command" ]
                                "FrontendOnly"
                                []
                            , Type.var "toMsg"
                            , Type.var "msg"
                            ]
                        )
                    )
            }
    , none =
        Elm.value
            { importFrom = [ "Effect", "Command" ]
            , name = "none"
            , annotation =
                Just
                    (Type.namedWith
                        [ "Effect", "Internal" ]
                        "Command"
                        [ Type.var "restriction"
                        , Type.var "toMsg"
                        , Type.var "msg"
                        ]
                    )
            }
    , batch =
        Elm.value
            { importFrom = [ "Effect", "Command" ]
            , name = "batch"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.namedWith
                                [ "Effect", "Internal" ]
                                "Command"
                                [ Type.var "restriction"
                                , Type.var "toMsg"
                                , Type.var "msg"
                                ]
                            )
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
