module Gen.Server.Session exposing
    ( moduleName_, withSession, withSessionResult, empty, get, insert
    , remove, update, withFlash, annotation_, make_, caseOf_, call_
    , values_
    )

{-|
# Generated bindings for Server.Session

@docs moduleName_, withSession, withSessionResult, empty, get, insert
@docs remove, update, withFlash, annotation_, make_, caseOf_
@docs call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Server", "Session" ]


{-| The main function for using sessions. If you need more fine-grained control over cases where a session can't be loaded, see
[`withSessionResult`](#withSessionResult).

withSession: 
    { name : String
    , secrets : BackendTask.BackendTask error (List String)
    , options : Maybe Server.SetCookie.Options
    }
    -> (Server.Session.Session
    -> BackendTask.BackendTask error ( Server.Session.Session, Server.Response.Response data errorPage ))
    -> Server.Request.Request
    -> BackendTask.BackendTask error (Server.Response.Response data errorPage)
-}
withSession :
    { name : String, secrets : Elm.Expression, options : Elm.Expression }
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
withSession withSessionArg_ withSessionArg_0 withSessionArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Session" ]
             , name = "withSession"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "name", Type.string )
                              , ( "secrets"
                                , Type.namedWith
                                    [ "BackendTask" ]
                                    "BackendTask"
                                    [ Type.var "error", Type.list Type.string ]
                                )
                              , ( "options"
                                , Type.maybe
                                    (Type.namedWith
                                       [ "Server", "SetCookie" ]
                                       "Options"
                                       []
                                    )
                                )
                              ]
                          , Type.function
                              [ Type.namedWith
                                    [ "Server", "Session" ]
                                    "Session"
                                    []
                              ]
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.var "error"
                                 , Type.tuple
                                       (Type.namedWith
                                            [ "Server", "Session" ]
                                            "Session"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Server", "Response" ]
                                            "Response"
                                            [ Type.var "data"
                                            , Type.var "errorPage"
                                            ]
                                       )
                                 ]
                              )
                          , Type.namedWith [ "Server", "Request" ] "Request" []
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error"
                               , Type.namedWith
                                   [ "Server", "Response" ]
                                   "Response"
                                   [ Type.var "data", Type.var "errorPage" ]
                               ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "name" (Elm.string withSessionArg_.name)
            , Tuple.pair "secrets" withSessionArg_.secrets
            , Tuple.pair "options" withSessionArg_.options
            ]
        , Elm.functionReduced "withSessionUnpack" withSessionArg_0
        , withSessionArg_1
        ]


{-| Same as `withSession`, but gives you an `Err` with the reason why the Session couldn't be loaded instead of
using `Session.empty` as a default in the cases where there is an error loading the session.

A session won't load if there is no session, or if it cannot be unsigned with your secrets. This could be because the cookie was tampered with
or otherwise corrupted, or because the cookie was signed with a secret that is no longer in the rotation.

withSessionResult: 
    { name : String
    , secrets : BackendTask.BackendTask error (List String)
    , options : Maybe Server.SetCookie.Options
    }
    -> (Result.Result Server.Session.NotLoadedReason Server.Session.Session
    -> BackendTask.BackendTask error ( Server.Session.Session, Server.Response.Response data errorPage ))
    -> Server.Request.Request
    -> BackendTask.BackendTask error (Server.Response.Response data errorPage)
-}
withSessionResult :
    { name : String, secrets : Elm.Expression, options : Elm.Expression }
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
withSessionResult withSessionResultArg_ withSessionResultArg_0 withSessionResultArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Session" ]
             , name = "withSessionResult"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "name", Type.string )
                              , ( "secrets"
                                , Type.namedWith
                                    [ "BackendTask" ]
                                    "BackendTask"
                                    [ Type.var "error", Type.list Type.string ]
                                )
                              , ( "options"
                                , Type.maybe
                                    (Type.namedWith
                                       [ "Server", "SetCookie" ]
                                       "Options"
                                       []
                                    )
                                )
                              ]
                          , Type.function
                              [ Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.namedWith
                                        [ "Server", "Session" ]
                                        "NotLoadedReason"
                                        []
                                    , Type.namedWith
                                        [ "Server", "Session" ]
                                        "Session"
                                        []
                                    ]
                              ]
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.var "error"
                                 , Type.tuple
                                       (Type.namedWith
                                            [ "Server", "Session" ]
                                            "Session"
                                            []
                                       )
                                       (Type.namedWith
                                            [ "Server", "Response" ]
                                            "Response"
                                            [ Type.var "data"
                                            , Type.var "errorPage"
                                            ]
                                       )
                                 ]
                              )
                          , Type.namedWith [ "Server", "Request" ] "Request" []
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error"
                               , Type.namedWith
                                   [ "Server", "Response" ]
                                   "Response"
                                   [ Type.var "data", Type.var "errorPage" ]
                               ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "name" (Elm.string withSessionResultArg_.name)
            , Tuple.pair "secrets" withSessionResultArg_.secrets
            , Tuple.pair "options" withSessionResultArg_.options
            ]
        , Elm.functionReduced "withSessionResultUnpack" withSessionResultArg_0
        , withSessionResultArg_1
        ]


{-| An empty `Session` with no key-value pairs.

empty: Server.Session.Session
-}
empty : Elm.Expression
empty =
    Elm.value
        { importFrom = [ "Server", "Session" ]
        , name = "empty"
        , annotation =
            Just (Type.namedWith [ "Server", "Session" ] "Session" [])
        }


{-| Retrieve a String value from the session for the given key (or `Nothing` if the key is not present).

    (session
        |> Session.get "mode"
        |> Maybe.withDefault "light"
    )
        == "dark"

get: String -> Server.Session.Session -> Maybe String
-}
get : String -> Elm.Expression -> Elm.Expression
get getArg_ getArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Session" ]
             , name = "get"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Server", "Session" ] "Session" []
                          ]
                          (Type.maybe Type.string)
                     )
             }
        )
        [ Elm.string getArg_, getArg_0 ]


{-| Insert a value under the given key in the `Session`.

    session
        |> Session.insert "mode" "dark"

insert: String -> String -> Server.Session.Session -> Server.Session.Session
-}
insert : String -> String -> Elm.Expression -> Elm.Expression
insert insertArg_ insertArg_0 insertArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Session" ]
             , name = "insert"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.string
                          , Type.namedWith [ "Server", "Session" ] "Session" []
                          ]
                          (Type.namedWith [ "Server", "Session" ] "Session" [])
                     )
             }
        )
        [ Elm.string insertArg_, Elm.string insertArg_0, insertArg_1 ]


{-| Remove a key from the `Session`.

remove: String -> Server.Session.Session -> Server.Session.Session
-}
remove : String -> Elm.Expression -> Elm.Expression
remove removeArg_ removeArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Session" ]
             , name = "remove"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Server", "Session" ] "Session" []
                          ]
                          (Type.namedWith [ "Server", "Session" ] "Session" [])
                     )
             }
        )
        [ Elm.string removeArg_, removeArg_0 ]


{-| Update the `Session`, given a `Maybe String` of the current value for the given key, and returning a `Maybe String`.

If you return `Nothing`, the key-value pair will be removed from the `Session` (or left out if it didn't exist in the first place).

    session
        |> Session.update "mode"
            (\mode ->
                case mode of
                    Just "dark" ->
                        Just "light"

                    Just "light" ->
                        Just "dark"

                    Nothing ->
                        Just "dark"
            )

update: 
    String
    -> (Maybe String -> Maybe String)
    -> Server.Session.Session
    -> Server.Session.Session
-}
update :
    String
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
update updateArg_ updateArg_0 updateArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Session" ]
             , name = "update"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.function
                              [ Type.maybe Type.string ]
                              (Type.maybe Type.string)
                          , Type.namedWith [ "Server", "Session" ] "Session" []
                          ]
                          (Type.namedWith [ "Server", "Session" ] "Session" [])
                     )
             }
        )
        [ Elm.string updateArg_
        , Elm.functionReduced "updateUnpack" updateArg_0
        , updateArg_1
        ]


{-| Flash session values are values that are only available for the next request.

    session
        |> Session.withFlash "message" "Your payment was successful!"

withFlash: String -> String -> Server.Session.Session -> Server.Session.Session
-}
withFlash : String -> String -> Elm.Expression -> Elm.Expression
withFlash withFlashArg_ withFlashArg_0 withFlashArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Session" ]
             , name = "withFlash"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.string
                          , Type.namedWith [ "Server", "Session" ] "Session" []
                          ]
                          (Type.namedWith [ "Server", "Session" ] "Session" [])
                     )
             }
        )
        [ Elm.string withFlashArg_, Elm.string withFlashArg_0, withFlashArg_1 ]


annotation_ : { notLoadedReason : Type.Annotation, session : Type.Annotation }
annotation_ =
    { notLoadedReason =
        Type.namedWith [ "Server", "Session" ] "NotLoadedReason" []
    , session = Type.namedWith [ "Server", "Session" ] "Session" []
    }


make_ :
    { noSessionCookie : Elm.Expression, invalidSessionCookie : Elm.Expression }
make_ =
    { noSessionCookie =
        Elm.value
            { importFrom = [ "Server", "Session" ]
            , name = "NoSessionCookie"
            , annotation = Just (Type.namedWith [] "NotLoadedReason" [])
            }
    , invalidSessionCookie =
        Elm.value
            { importFrom = [ "Server", "Session" ]
            , name = "InvalidSessionCookie"
            , annotation = Just (Type.namedWith [] "NotLoadedReason" [])
            }
    }


caseOf_ :
    { notLoadedReason :
        Elm.Expression
        -> { noSessionCookie : Elm.Expression
        , invalidSessionCookie : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { notLoadedReason =
        \notLoadedReasonExpression notLoadedReasonTags ->
            Elm.Case.custom
                notLoadedReasonExpression
                (Type.namedWith [ "Server", "Session" ] "NotLoadedReason" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "NoSessionCookie"
                       notLoadedReasonTags.noSessionCookie
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "InvalidSessionCookie"
                       notLoadedReasonTags.invalidSessionCookie
                    )
                    Basics.identity
                ]
    }


call_ :
    { withSession :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , withSessionResult :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , get : Elm.Expression -> Elm.Expression -> Elm.Expression
    , insert :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , remove : Elm.Expression -> Elm.Expression -> Elm.Expression
    , update :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , withFlash :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { withSession =
        \withSessionArg_ withSessionArg_0 withSessionArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Session" ]
                     , name = "withSession"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "name", Type.string )
                                      , ( "secrets"
                                        , Type.namedWith
                                            [ "BackendTask" ]
                                            "BackendTask"
                                            [ Type.var "error"
                                            , Type.list Type.string
                                            ]
                                        )
                                      , ( "options"
                                        , Type.maybe
                                            (Type.namedWith
                                               [ "Server", "SetCookie" ]
                                               "Options"
                                               []
                                            )
                                        )
                                      ]
                                  , Type.function
                                      [ Type.namedWith
                                            [ "Server", "Session" ]
                                            "Session"
                                            []
                                      ]
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.var "error"
                                         , Type.tuple
                                               (Type.namedWith
                                                    [ "Server", "Session" ]
                                                    "Session"
                                                    []
                                               )
                                               (Type.namedWith
                                                    [ "Server", "Response" ]
                                                    "Response"
                                                    [ Type.var "data"
                                                    , Type.var "errorPage"
                                                    ]
                                               )
                                         ]
                                      )
                                  , Type.namedWith
                                      [ "Server", "Request" ]
                                      "Request"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.namedWith
                                           [ "Server", "Response" ]
                                           "Response"
                                           [ Type.var "data"
                                           , Type.var "errorPage"
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ withSessionArg_, withSessionArg_0, withSessionArg_1 ]
    , withSessionResult =
        \withSessionResultArg_ withSessionResultArg_0 withSessionResultArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Session" ]
                     , name = "withSessionResult"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "name", Type.string )
                                      , ( "secrets"
                                        , Type.namedWith
                                            [ "BackendTask" ]
                                            "BackendTask"
                                            [ Type.var "error"
                                            , Type.list Type.string
                                            ]
                                        )
                                      , ( "options"
                                        , Type.maybe
                                            (Type.namedWith
                                               [ "Server", "SetCookie" ]
                                               "Options"
                                               []
                                            )
                                        )
                                      ]
                                  , Type.function
                                      [ Type.namedWith
                                            [ "Result" ]
                                            "Result"
                                            [ Type.namedWith
                                                [ "Server", "Session" ]
                                                "NotLoadedReason"
                                                []
                                            , Type.namedWith
                                                [ "Server", "Session" ]
                                                "Session"
                                                []
                                            ]
                                      ]
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.var "error"
                                         , Type.tuple
                                               (Type.namedWith
                                                    [ "Server", "Session" ]
                                                    "Session"
                                                    []
                                               )
                                               (Type.namedWith
                                                    [ "Server", "Response" ]
                                                    "Response"
                                                    [ Type.var "data"
                                                    , Type.var "errorPage"
                                                    ]
                                               )
                                         ]
                                      )
                                  , Type.namedWith
                                      [ "Server", "Request" ]
                                      "Request"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.namedWith
                                           [ "Server", "Response" ]
                                           "Response"
                                           [ Type.var "data"
                                           , Type.var "errorPage"
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ withSessionResultArg_
                , withSessionResultArg_0
                , withSessionResultArg_1
                ]
    , get =
        \getArg_ getArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Session" ]
                     , name = "get"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Server", "Session" ]
                                      "Session"
                                      []
                                  ]
                                  (Type.maybe Type.string)
                             )
                     }
                )
                [ getArg_, getArg_0 ]
    , insert =
        \insertArg_ insertArg_0 insertArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Session" ]
                     , name = "insert"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.string
                                  , Type.namedWith
                                      [ "Server", "Session" ]
                                      "Session"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Server", "Session" ]
                                       "Session"
                                       []
                                  )
                             )
                     }
                )
                [ insertArg_, insertArg_0, insertArg_1 ]
    , remove =
        \removeArg_ removeArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Session" ]
                     , name = "remove"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Server", "Session" ]
                                      "Session"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Server", "Session" ]
                                       "Session"
                                       []
                                  )
                             )
                     }
                )
                [ removeArg_, removeArg_0 ]
    , update =
        \updateArg_ updateArg_0 updateArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Session" ]
                     , name = "update"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.function
                                      [ Type.maybe Type.string ]
                                      (Type.maybe Type.string)
                                  , Type.namedWith
                                      [ "Server", "Session" ]
                                      "Session"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Server", "Session" ]
                                       "Session"
                                       []
                                  )
                             )
                     }
                )
                [ updateArg_, updateArg_0, updateArg_1 ]
    , withFlash =
        \withFlashArg_ withFlashArg_0 withFlashArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Session" ]
                     , name = "withFlash"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.string
                                  , Type.namedWith
                                      [ "Server", "Session" ]
                                      "Session"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Server", "Session" ]
                                       "Session"
                                       []
                                  )
                             )
                     }
                )
                [ withFlashArg_, withFlashArg_0, withFlashArg_1 ]
    }


values_ :
    { withSession : Elm.Expression
    , withSessionResult : Elm.Expression
    , empty : Elm.Expression
    , get : Elm.Expression
    , insert : Elm.Expression
    , remove : Elm.Expression
    , update : Elm.Expression
    , withFlash : Elm.Expression
    }
values_ =
    { withSession =
        Elm.value
            { importFrom = [ "Server", "Session" ]
            , name = "withSession"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "name", Type.string )
                             , ( "secrets"
                               , Type.namedWith
                                   [ "BackendTask" ]
                                   "BackendTask"
                                   [ Type.var "error", Type.list Type.string ]
                               )
                             , ( "options"
                               , Type.maybe
                                   (Type.namedWith
                                      [ "Server", "SetCookie" ]
                                      "Options"
                                      []
                                   )
                               )
                             ]
                         , Type.function
                             [ Type.namedWith
                                   [ "Server", "Session" ]
                                   "Session"
                                   []
                             ]
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.var "error"
                                , Type.tuple
                                      (Type.namedWith
                                           [ "Server", "Session" ]
                                           "Session"
                                           []
                                      )
                                      (Type.namedWith
                                           [ "Server", "Response" ]
                                           "Response"
                                           [ Type.var "data"
                                           , Type.var "errorPage"
                                           ]
                                      )
                                ]
                             )
                         , Type.namedWith [ "Server", "Request" ] "Request" []
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error"
                              , Type.namedWith
                                  [ "Server", "Response" ]
                                  "Response"
                                  [ Type.var "data", Type.var "errorPage" ]
                              ]
                         )
                    )
            }
    , withSessionResult =
        Elm.value
            { importFrom = [ "Server", "Session" ]
            , name = "withSessionResult"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "name", Type.string )
                             , ( "secrets"
                               , Type.namedWith
                                   [ "BackendTask" ]
                                   "BackendTask"
                                   [ Type.var "error", Type.list Type.string ]
                               )
                             , ( "options"
                               , Type.maybe
                                   (Type.namedWith
                                      [ "Server", "SetCookie" ]
                                      "Options"
                                      []
                                   )
                               )
                             ]
                         , Type.function
                             [ Type.namedWith
                                   [ "Result" ]
                                   "Result"
                                   [ Type.namedWith
                                       [ "Server", "Session" ]
                                       "NotLoadedReason"
                                       []
                                   , Type.namedWith
                                       [ "Server", "Session" ]
                                       "Session"
                                       []
                                   ]
                             ]
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.var "error"
                                , Type.tuple
                                      (Type.namedWith
                                           [ "Server", "Session" ]
                                           "Session"
                                           []
                                      )
                                      (Type.namedWith
                                           [ "Server", "Response" ]
                                           "Response"
                                           [ Type.var "data"
                                           , Type.var "errorPage"
                                           ]
                                      )
                                ]
                             )
                         , Type.namedWith [ "Server", "Request" ] "Request" []
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error"
                              , Type.namedWith
                                  [ "Server", "Response" ]
                                  "Response"
                                  [ Type.var "data", Type.var "errorPage" ]
                              ]
                         )
                    )
            }
    , empty =
        Elm.value
            { importFrom = [ "Server", "Session" ]
            , name = "empty"
            , annotation =
                Just (Type.namedWith [ "Server", "Session" ] "Session" [])
            }
    , get =
        Elm.value
            { importFrom = [ "Server", "Session" ]
            , name = "get"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Server", "Session" ] "Session" []
                         ]
                         (Type.maybe Type.string)
                    )
            }
    , insert =
        Elm.value
            { importFrom = [ "Server", "Session" ]
            , name = "insert"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.string
                         , Type.namedWith [ "Server", "Session" ] "Session" []
                         ]
                         (Type.namedWith [ "Server", "Session" ] "Session" [])
                    )
            }
    , remove =
        Elm.value
            { importFrom = [ "Server", "Session" ]
            , name = "remove"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Server", "Session" ] "Session" []
                         ]
                         (Type.namedWith [ "Server", "Session" ] "Session" [])
                    )
            }
    , update =
        Elm.value
            { importFrom = [ "Server", "Session" ]
            , name = "update"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.function
                             [ Type.maybe Type.string ]
                             (Type.maybe Type.string)
                         , Type.namedWith [ "Server", "Session" ] "Session" []
                         ]
                         (Type.namedWith [ "Server", "Session" ] "Session" [])
                    )
            }
    , withFlash =
        Elm.value
            { importFrom = [ "Server", "Session" ]
            , name = "withFlash"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.string
                         , Type.namedWith [ "Server", "Session" ] "Session" []
                         ]
                         (Type.namedWith [ "Server", "Session" ] "Session" [])
                    )
            }
    }