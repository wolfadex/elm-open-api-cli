module Gen.Server.Session exposing (annotation_, call_, caseOf_, empty, get, insert, make_, moduleName_, remove, update, values_, withFlash, withSession, withSessionResult)

{-| 
@docs moduleName_, withSession, withSessionResult, empty, get, insert, remove, update, withFlash, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
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
withSession withSessionArg withSessionArg0 withSessionArg1 =
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
            [ Tuple.pair "name" (Elm.string withSessionArg.name)
            , Tuple.pair "secrets" withSessionArg.secrets
            , Tuple.pair "options" withSessionArg.options
            ]
        , Elm.functionReduced "withSessionUnpack" withSessionArg0
        , withSessionArg1
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
withSessionResult withSessionResultArg withSessionResultArg0 withSessionResultArg1 =
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
            [ Tuple.pair "name" (Elm.string withSessionResultArg.name)
            , Tuple.pair "secrets" withSessionResultArg.secrets
            , Tuple.pair "options" withSessionResultArg.options
            ]
        , Elm.functionReduced "withSessionResultUnpack" withSessionResultArg0
        , withSessionResultArg1
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
get getArg getArg0 =
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
        [ Elm.string getArg, getArg0 ]


{-| Insert a value under the given key in the `Session`.

    session
        |> Session.insert "mode" "dark"

insert: String -> String -> Server.Session.Session -> Server.Session.Session
-}
insert : String -> String -> Elm.Expression -> Elm.Expression
insert insertArg insertArg0 insertArg1 =
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
        [ Elm.string insertArg, Elm.string insertArg0, insertArg1 ]


{-| Remove a key from the `Session`.

remove: String -> Server.Session.Session -> Server.Session.Session
-}
remove : String -> Elm.Expression -> Elm.Expression
remove removeArg removeArg0 =
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
        [ Elm.string removeArg, removeArg0 ]


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
update updateArg updateArg0 updateArg1 =
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
        [ Elm.string updateArg
        , Elm.functionReduced "updateUnpack" updateArg0
        , updateArg1
        ]


{-| Flash session values are values that are only available for the next request.

    session
        |> Session.withFlash "message" "Your payment was successful!"

withFlash: String -> String -> Server.Session.Session -> Server.Session.Session
-}
withFlash : String -> String -> Elm.Expression -> Elm.Expression
withFlash withFlashArg withFlashArg0 withFlashArg1 =
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
        [ Elm.string withFlashArg, Elm.string withFlashArg0, withFlashArg1 ]


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
        -> { notLoadedReasonTags_0_0
            | noSessionCookie : Elm.Expression
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
                [ Elm.Case.branch0
                    "NoSessionCookie"
                    notLoadedReasonTags.noSessionCookie
                , Elm.Case.branch0
                    "InvalidSessionCookie"
                    notLoadedReasonTags.invalidSessionCookie
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
        \withSessionArg withSessionArg0 withSessionArg1 ->
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
                [ withSessionArg, withSessionArg0, withSessionArg1 ]
    , withSessionResult =
        \withSessionResultArg withSessionResultArg0 withSessionResultArg1 ->
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
                [ withSessionResultArg
                , withSessionResultArg0
                , withSessionResultArg1
                ]
    , get =
        \getArg getArg0 ->
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
                [ getArg, getArg0 ]
    , insert =
        \insertArg insertArg0 insertArg1 ->
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
                [ insertArg, insertArg0, insertArg1 ]
    , remove =
        \removeArg removeArg0 ->
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
                [ removeArg, removeArg0 ]
    , update =
        \updateArg updateArg0 updateArg1 ->
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
                [ updateArg, updateArg0, updateArg1 ]
    , withFlash =
        \withFlashArg withFlashArg0 withFlashArg1 ->
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
                [ withFlashArg, withFlashArg0, withFlashArg1 ]
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