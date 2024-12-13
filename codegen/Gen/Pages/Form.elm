module Gen.Pages.Form exposing
    ( moduleName_, renderHtml, renderStyledHtml, withConcurrent, annotation_, call_
    , values_
    )

{-|
# Generated bindings for Pages.Form

@docs moduleName_, renderHtml, renderStyledHtml, withConcurrent, annotation_, call_
@docs values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Form" ]


{-| A replacement for `Form.renderHtml` from `dillonkearns/elm-form` that integrates with `elm-pages`. Use this to render your [`Form`](https://package.elm-lang.org/packages/dillonkearns/elm-form/latest/Form)
as `elm/html` `Html`.

renderHtml: 
    List (Html.Attribute (PagesMsg.PagesMsg userMsg))
    -> Pages.Form.Options error parsed input userMsg
    -> { app
        | pageFormState : Form.Model
        , navigation : Maybe Pages.Navigation.Navigation
        , concurrentSubmissions :
            Dict.Dict String (Pages.ConcurrentSubmission.ConcurrentSubmission (Maybe action))
    }
    -> Form.Form error { combine :
        Form.Validation.Validation error parsed named constraints
    , view :
        Form.Context error input -> List (Html.Html (PagesMsg.PagesMsg userMsg))
    } parsed input
    -> Html.Html (PagesMsg.PagesMsg userMsg)
-}
renderHtml :
    List Elm.Expression
    -> Elm.Expression
    -> { app
        | pageFormState : Elm.Expression
        , navigation : Elm.Expression
        , concurrentSubmissions : Elm.Expression
    }
    -> Elm.Expression
    -> Elm.Expression
renderHtml renderHtmlArg_ renderHtmlArg_0 renderHtmlArg_1 renderHtmlArg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Form" ]
             , name = "renderHtml"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "Html" ]
                                 "Attribute"
                                 [ Type.namedWith
                                       [ "PagesMsg" ]
                                       "PagesMsg"
                                       [ Type.var "userMsg" ]
                                 ]
                              )
                          , Type.namedWith
                              [ "Pages", "Form" ]
                              "Options"
                              [ Type.var "error"
                              , Type.var "parsed"
                              , Type.var "input"
                              , Type.var "userMsg"
                              ]
                          , Type.extensible
                              "app"
                              [ ( "pageFormState"
                                , Type.namedWith [ "Form" ] "Model" []
                                )
                              , ( "navigation"
                                , Type.maybe
                                    (Type.namedWith
                                       [ "Pages", "Navigation" ]
                                       "Navigation"
                                       []
                                    )
                                )
                              , ( "concurrentSubmissions"
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.string
                                    , Type.namedWith
                                          [ "Pages", "ConcurrentSubmission" ]
                                          "ConcurrentSubmission"
                                          [ Type.maybe (Type.var "action") ]
                                    ]
                                )
                              ]
                          , Type.namedWith
                              [ "Form" ]
                              "Form"
                              [ Type.var "error"
                              , Type.record
                                    [ ( "combine"
                                      , Type.namedWith
                                            [ "Form", "Validation" ]
                                            "Validation"
                                            [ Type.var "error"
                                            , Type.var "parsed"
                                            , Type.var "named"
                                            , Type.var "constraints"
                                            ]
                                      )
                                    , ( "view"
                                      , Type.function
                                            [ Type.namedWith
                                                [ "Form" ]
                                                "Context"
                                                [ Type.var "error"
                                                , Type.var "input"
                                                ]
                                            ]
                                            (Type.list
                                                 (Type.namedWith
                                                      [ "Html" ]
                                                      "Html"
                                                      [ Type.namedWith
                                                          [ "PagesMsg" ]
                                                          "PagesMsg"
                                                          [ Type.var "userMsg" ]
                                                      ]
                                                 )
                                            )
                                      )
                                    ]
                              , Type.var "parsed"
                              , Type.var "input"
                              ]
                          ]
                          (Type.namedWith
                               [ "Html" ]
                               "Html"
                               [ Type.namedWith
                                   [ "PagesMsg" ]
                                   "PagesMsg"
                                   [ Type.var "userMsg" ]
                               ]
                          )
                     )
             }
        )
        [ Elm.list renderHtmlArg_
        , renderHtmlArg_0
        , Elm.record
            [ Tuple.pair "pageFormState" renderHtmlArg_1.pageFormState
            , Tuple.pair "navigation" renderHtmlArg_1.navigation
            , Tuple.pair
                  "concurrentSubmissions"
                  renderHtmlArg_1.concurrentSubmissions
            ]
        , renderHtmlArg_2
        ]


{-| A replacement for `Form.renderStyledHtml` from `dillonkearns/elm-form` that integrates with `elm-pages`. Use this to render your [`Form`](https://package.elm-lang.org/packages/dillonkearns/elm-form/latest/Form)
as `rtfeldman/elm-css` `Html.Styled.Html`.

renderStyledHtml: 
    List (Html.Styled.Attribute (PagesMsg.PagesMsg userMsg))
    -> Pages.Form.Options error parsed input userMsg
    -> { app
        | pageFormState : Form.Model
        , navigation : Maybe Pages.Navigation.Navigation
        , concurrentSubmissions :
            Dict.Dict String (Pages.ConcurrentSubmission.ConcurrentSubmission (Maybe action))
    }
    -> Form.Form error { combine :
        Form.Validation.Validation error parsed named constraints
    , view :
        Form.Context error input
        -> List (Html.Styled.Html (PagesMsg.PagesMsg userMsg))
    } parsed input
    -> Html.Styled.Html (PagesMsg.PagesMsg userMsg)
-}
renderStyledHtml :
    List Elm.Expression
    -> Elm.Expression
    -> { app
        | pageFormState : Elm.Expression
        , navigation : Elm.Expression
        , concurrentSubmissions : Elm.Expression
    }
    -> Elm.Expression
    -> Elm.Expression
renderStyledHtml renderStyledHtmlArg_ renderStyledHtmlArg_0 renderStyledHtmlArg_1 renderStyledHtmlArg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Form" ]
             , name = "renderStyledHtml"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "Html", "Styled" ]
                                 "Attribute"
                                 [ Type.namedWith
                                       [ "PagesMsg" ]
                                       "PagesMsg"
                                       [ Type.var "userMsg" ]
                                 ]
                              )
                          , Type.namedWith
                              [ "Pages", "Form" ]
                              "Options"
                              [ Type.var "error"
                              , Type.var "parsed"
                              , Type.var "input"
                              , Type.var "userMsg"
                              ]
                          , Type.extensible
                              "app"
                              [ ( "pageFormState"
                                , Type.namedWith [ "Form" ] "Model" []
                                )
                              , ( "navigation"
                                , Type.maybe
                                    (Type.namedWith
                                       [ "Pages", "Navigation" ]
                                       "Navigation"
                                       []
                                    )
                                )
                              , ( "concurrentSubmissions"
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.string
                                    , Type.namedWith
                                          [ "Pages", "ConcurrentSubmission" ]
                                          "ConcurrentSubmission"
                                          [ Type.maybe (Type.var "action") ]
                                    ]
                                )
                              ]
                          , Type.namedWith
                              [ "Form" ]
                              "Form"
                              [ Type.var "error"
                              , Type.record
                                    [ ( "combine"
                                      , Type.namedWith
                                            [ "Form", "Validation" ]
                                            "Validation"
                                            [ Type.var "error"
                                            , Type.var "parsed"
                                            , Type.var "named"
                                            , Type.var "constraints"
                                            ]
                                      )
                                    , ( "view"
                                      , Type.function
                                            [ Type.namedWith
                                                [ "Form" ]
                                                "Context"
                                                [ Type.var "error"
                                                , Type.var "input"
                                                ]
                                            ]
                                            (Type.list
                                                 (Type.namedWith
                                                      [ "Html", "Styled" ]
                                                      "Html"
                                                      [ Type.namedWith
                                                          [ "PagesMsg" ]
                                                          "PagesMsg"
                                                          [ Type.var "userMsg" ]
                                                      ]
                                                 )
                                            )
                                      )
                                    ]
                              , Type.var "parsed"
                              , Type.var "input"
                              ]
                          ]
                          (Type.namedWith
                               [ "Html", "Styled" ]
                               "Html"
                               [ Type.namedWith
                                   [ "PagesMsg" ]
                                   "PagesMsg"
                                   [ Type.var "userMsg" ]
                               ]
                          )
                     )
             }
        )
        [ Elm.list renderStyledHtmlArg_
        , renderStyledHtmlArg_0
        , Elm.record
            [ Tuple.pair "pageFormState" renderStyledHtmlArg_1.pageFormState
            , Tuple.pair "navigation" renderStyledHtmlArg_1.navigation
            , Tuple.pair
                  "concurrentSubmissions"
                  renderStyledHtmlArg_1.concurrentSubmissions
            ]
        , renderStyledHtmlArg_2
        ]


{-| Instead of using the default submission strategy (tied to the page's navigation state), you can use `withConcurrent`.
`withConcurrent` allows multiple form submissions to be in flight at the same time. It is useful for more dynamic applications. A good rule of thumb
is if you could have multiple pending spinners on the page at the same time, you should use `withConcurrent`. For example, if you have a page with a list of items,
say a Twitter clone. If you click the like button on a Tweet, it won't result in a page navigation. You can click the like button on multiple Tweets at the same time
and they will all submit independently.

In the case of Twitter, there isn't an indication of a loading spinner on the like button because it is expected that it will succeed. This is an example of a User Experience (UX) pattern
called Optimistic UI. Since it is very likely that liking a Tweet will be successful, the UI will update the UI as if it has immediately succeeded even though the request is still in flight.
If the request fails, the UI will be updated to reflect the failure with an animation to show that something went wrong.

The `withConcurrent` is a good fit for either of these UX patterns (Optimistic UI or Pending UI, i.e. showing a loading spinner). You can derive either of these
visual states from the `app.concurrentSubmissions` field in your `Route` module.

You can call `withConcurrent` on your `Form.Options`. Note that while `withConcurrent` will allow multiple form submissions to be in flight at the same time independently,
the ID of the Form will still have a unique submission. For example, if you click submit on a form with the ID `"edit-123"` and then submit it again before the first submission has completed,
the second submission will cancel the first submission. So it is important to use unique IDs for forms that represent unique operations.

    import Form
    import Pages.Form

    todoItemView app todo =
        deleteItemForm
            |> Pages.Form.renderHtml []
                (Form.options ("delete-" ++ todo.id)
                    |> Form.withInput todo
                    |> Pages.Form.withConcurrent
                )
                app

withConcurrent: 
    Pages.Form.Options error parsed input msg
    -> Pages.Form.Options error parsed input msg
-}
withConcurrent : Elm.Expression -> Elm.Expression
withConcurrent withConcurrentArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Form" ]
             , name = "withConcurrent"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Form" ]
                              "Options"
                              [ Type.var "error"
                              , Type.var "parsed"
                              , Type.var "input"
                              , Type.var "msg"
                              ]
                          ]
                          (Type.namedWith
                               [ "Pages", "Form" ]
                               "Options"
                               [ Type.var "error"
                               , Type.var "parsed"
                               , Type.var "input"
                               , Type.var "msg"
                               ]
                          )
                     )
             }
        )
        [ withConcurrentArg_ ]


annotation_ :
    { options :
        Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
    , formWithServerValidations :
        Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
        -> Type.Annotation
    , handler : Type.Annotation -> Type.Annotation -> Type.Annotation
    }
annotation_ =
    { options =
        \optionsArg0 optionsArg1 optionsArg2 optionsArg3 ->
            Type.alias
                moduleName_
                "Options"
                [ optionsArg0, optionsArg1, optionsArg2, optionsArg3 ]
                (Type.namedWith
                     [ "Form" ]
                     "Options"
                     [ Type.var "error"
                     , Type.var "parsed"
                     , Type.var "input"
                     , Type.var "msg"
                     , Type.record [ ( "concurrent", Type.bool ) ]
                     ]
                )
    , formWithServerValidations =
        \formWithServerValidationsArg0 formWithServerValidationsArg1 formWithServerValidationsArg2 formWithServerValidationsArg3 ->
            Type.alias
                moduleName_
                "FormWithServerValidations"
                [ formWithServerValidationsArg0
                , formWithServerValidationsArg1
                , formWithServerValidationsArg2
                , formWithServerValidationsArg3
                ]
                (Type.namedWith
                     [ "Form" ]
                     "Form"
                     [ Type.var "error"
                     , Type.record
                         [ ( "combine"
                           , Type.namedWith
                               [ "Form", "Validation" ]
                               "Validation"
                               [ Type.var "error"
                               , Type.namedWith
                                     [ "BackendTask" ]
                                     "BackendTask"
                                     [ Type.namedWith
                                         [ "FatalError" ]
                                         "FatalError"
                                         []
                                     , Type.namedWith
                                         [ "Form", "Validation" ]
                                         "Validation"
                                         [ Type.var "error"
                                         , Type.var "combined"
                                         , Type.namedWith
                                               [ "Basics" ]
                                               "Never"
                                               []
                                         , Type.namedWith
                                               [ "Basics" ]
                                               "Never"
                                               []
                                         ]
                                     ]
                               , Type.namedWith [ "Basics" ] "Never" []
                               , Type.namedWith [ "Basics" ] "Never" []
                               ]
                           )
                         , ( "view"
                           , Type.function
                               [ Type.namedWith
                                     [ "Form" ]
                                     "Context"
                                     [ Type.var "error", Type.var "input" ]
                               ]
                               (Type.var "view")
                           )
                         ]
                     , Type.namedWith
                         [ "BackendTask" ]
                         "BackendTask"
                         [ Type.namedWith [ "FatalError" ] "FatalError" []
                         , Type.namedWith
                               [ "Form", "Validation" ]
                               "Validation"
                               [ Type.var "error"
                               , Type.var "combined"
                               , Type.namedWith [ "Basics" ] "Never" []
                               , Type.namedWith [ "Basics" ] "Never" []
                               ]
                         ]
                     , Type.var "input"
                     ]
                )
    , handler =
        \handlerArg0 handlerArg1 ->
            Type.alias
                moduleName_
                "Handler"
                [ handlerArg0, handlerArg1 ]
                (Type.namedWith
                     [ "Form", "Handler" ]
                     "Handler"
                     [ Type.var "error"
                     , Type.namedWith
                         [ "BackendTask" ]
                         "BackendTask"
                         [ Type.namedWith [ "FatalError" ] "FatalError" []
                         , Type.namedWith
                               [ "Form", "Validation" ]
                               "Validation"
                               [ Type.var "error"
                               , Type.var "combined"
                               , Type.namedWith [ "Basics" ] "Never" []
                               , Type.namedWith [ "Basics" ] "Never" []
                               ]
                         ]
                     ]
                )
    }


call_ :
    { renderHtml :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , renderStyledHtml :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , withConcurrent : Elm.Expression -> Elm.Expression
    }
call_ =
    { renderHtml =
        \renderHtmlArg_ renderHtmlArg_0 renderHtmlArg_1 renderHtmlArg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Form" ]
                     , name = "renderHtml"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "Html" ]
                                         "Attribute"
                                         [ Type.namedWith
                                               [ "PagesMsg" ]
                                               "PagesMsg"
                                               [ Type.var "userMsg" ]
                                         ]
                                      )
                                  , Type.namedWith
                                      [ "Pages", "Form" ]
                                      "Options"
                                      [ Type.var "error"
                                      , Type.var "parsed"
                                      , Type.var "input"
                                      , Type.var "userMsg"
                                      ]
                                  , Type.extensible
                                      "app"
                                      [ ( "pageFormState"
                                        , Type.namedWith [ "Form" ] "Model" []
                                        )
                                      , ( "navigation"
                                        , Type.maybe
                                            (Type.namedWith
                                               [ "Pages", "Navigation" ]
                                               "Navigation"
                                               []
                                            )
                                        )
                                      , ( "concurrentSubmissions"
                                        , Type.namedWith
                                            [ "Dict" ]
                                            "Dict"
                                            [ Type.string
                                            , Type.namedWith
                                                  [ "Pages"
                                                  , "ConcurrentSubmission"
                                                  ]
                                                  "ConcurrentSubmission"
                                                  [ Type.maybe
                                                      (Type.var "action")
                                                  ]
                                            ]
                                        )
                                      ]
                                  , Type.namedWith
                                      [ "Form" ]
                                      "Form"
                                      [ Type.var "error"
                                      , Type.record
                                            [ ( "combine"
                                              , Type.namedWith
                                                    [ "Form", "Validation" ]
                                                    "Validation"
                                                    [ Type.var "error"
                                                    , Type.var "parsed"
                                                    , Type.var "named"
                                                    , Type.var "constraints"
                                                    ]
                                              )
                                            , ( "view"
                                              , Type.function
                                                    [ Type.namedWith
                                                        [ "Form" ]
                                                        "Context"
                                                        [ Type.var "error"
                                                        , Type.var "input"
                                                        ]
                                                    ]
                                                    (Type.list
                                                         (Type.namedWith
                                                              [ "Html" ]
                                                              "Html"
                                                              [ Type.namedWith
                                                                  [ "PagesMsg" ]
                                                                  "PagesMsg"
                                                                  [ Type.var
                                                                        "userMsg"
                                                                  ]
                                                              ]
                                                         )
                                                    )
                                              )
                                            ]
                                      , Type.var "parsed"
                                      , Type.var "input"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "PagesMsg" ]
                                           "PagesMsg"
                                           [ Type.var "userMsg" ]
                                       ]
                                  )
                             )
                     }
                )
                [ renderHtmlArg_
                , renderHtmlArg_0
                , renderHtmlArg_1
                , renderHtmlArg_2
                ]
    , renderStyledHtml =
        \renderStyledHtmlArg_ renderStyledHtmlArg_0 renderStyledHtmlArg_1 renderStyledHtmlArg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Form" ]
                     , name = "renderStyledHtml"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "Html", "Styled" ]
                                         "Attribute"
                                         [ Type.namedWith
                                               [ "PagesMsg" ]
                                               "PagesMsg"
                                               [ Type.var "userMsg" ]
                                         ]
                                      )
                                  , Type.namedWith
                                      [ "Pages", "Form" ]
                                      "Options"
                                      [ Type.var "error"
                                      , Type.var "parsed"
                                      , Type.var "input"
                                      , Type.var "userMsg"
                                      ]
                                  , Type.extensible
                                      "app"
                                      [ ( "pageFormState"
                                        , Type.namedWith [ "Form" ] "Model" []
                                        )
                                      , ( "navigation"
                                        , Type.maybe
                                            (Type.namedWith
                                               [ "Pages", "Navigation" ]
                                               "Navigation"
                                               []
                                            )
                                        )
                                      , ( "concurrentSubmissions"
                                        , Type.namedWith
                                            [ "Dict" ]
                                            "Dict"
                                            [ Type.string
                                            , Type.namedWith
                                                  [ "Pages"
                                                  , "ConcurrentSubmission"
                                                  ]
                                                  "ConcurrentSubmission"
                                                  [ Type.maybe
                                                      (Type.var "action")
                                                  ]
                                            ]
                                        )
                                      ]
                                  , Type.namedWith
                                      [ "Form" ]
                                      "Form"
                                      [ Type.var "error"
                                      , Type.record
                                            [ ( "combine"
                                              , Type.namedWith
                                                    [ "Form", "Validation" ]
                                                    "Validation"
                                                    [ Type.var "error"
                                                    , Type.var "parsed"
                                                    , Type.var "named"
                                                    , Type.var "constraints"
                                                    ]
                                              )
                                            , ( "view"
                                              , Type.function
                                                    [ Type.namedWith
                                                        [ "Form" ]
                                                        "Context"
                                                        [ Type.var "error"
                                                        , Type.var "input"
                                                        ]
                                                    ]
                                                    (Type.list
                                                         (Type.namedWith
                                                              [ "Html"
                                                              , "Styled"
                                                              ]
                                                              "Html"
                                                              [ Type.namedWith
                                                                  [ "PagesMsg" ]
                                                                  "PagesMsg"
                                                                  [ Type.var
                                                                        "userMsg"
                                                                  ]
                                                              ]
                                                         )
                                                    )
                                              )
                                            ]
                                      , Type.var "parsed"
                                      , Type.var "input"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Html", "Styled" ]
                                       "Html"
                                       [ Type.namedWith
                                           [ "PagesMsg" ]
                                           "PagesMsg"
                                           [ Type.var "userMsg" ]
                                       ]
                                  )
                             )
                     }
                )
                [ renderStyledHtmlArg_
                , renderStyledHtmlArg_0
                , renderStyledHtmlArg_1
                , renderStyledHtmlArg_2
                ]
    , withConcurrent =
        \withConcurrentArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Form" ]
                     , name = "withConcurrent"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Form" ]
                                      "Options"
                                      [ Type.var "error"
                                      , Type.var "parsed"
                                      , Type.var "input"
                                      , Type.var "msg"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Pages", "Form" ]
                                       "Options"
                                       [ Type.var "error"
                                       , Type.var "parsed"
                                       , Type.var "input"
                                       , Type.var "msg"
                                       ]
                                  )
                             )
                     }
                )
                [ withConcurrentArg_ ]
    }


values_ :
    { renderHtml : Elm.Expression
    , renderStyledHtml : Elm.Expression
    , withConcurrent : Elm.Expression
    }
values_ =
    { renderHtml =
        Elm.value
            { importFrom = [ "Pages", "Form" ]
            , name = "renderHtml"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "Html" ]
                                "Attribute"
                                [ Type.namedWith
                                      [ "PagesMsg" ]
                                      "PagesMsg"
                                      [ Type.var "userMsg" ]
                                ]
                             )
                         , Type.namedWith
                             [ "Pages", "Form" ]
                             "Options"
                             [ Type.var "error"
                             , Type.var "parsed"
                             , Type.var "input"
                             , Type.var "userMsg"
                             ]
                         , Type.extensible
                             "app"
                             [ ( "pageFormState"
                               , Type.namedWith [ "Form" ] "Model" []
                               )
                             , ( "navigation"
                               , Type.maybe
                                   (Type.namedWith
                                      [ "Pages", "Navigation" ]
                                      "Navigation"
                                      []
                                   )
                               )
                             , ( "concurrentSubmissions"
                               , Type.namedWith
                                   [ "Dict" ]
                                   "Dict"
                                   [ Type.string
                                   , Type.namedWith
                                         [ "Pages", "ConcurrentSubmission" ]
                                         "ConcurrentSubmission"
                                         [ Type.maybe (Type.var "action") ]
                                   ]
                               )
                             ]
                         , Type.namedWith
                             [ "Form" ]
                             "Form"
                             [ Type.var "error"
                             , Type.record
                                   [ ( "combine"
                                     , Type.namedWith
                                           [ "Form", "Validation" ]
                                           "Validation"
                                           [ Type.var "error"
                                           , Type.var "parsed"
                                           , Type.var "named"
                                           , Type.var "constraints"
                                           ]
                                     )
                                   , ( "view"
                                     , Type.function
                                           [ Type.namedWith
                                               [ "Form" ]
                                               "Context"
                                               [ Type.var "error"
                                               , Type.var "input"
                                               ]
                                           ]
                                           (Type.list
                                                (Type.namedWith
                                                     [ "Html" ]
                                                     "Html"
                                                     [ Type.namedWith
                                                         [ "PagesMsg" ]
                                                         "PagesMsg"
                                                         [ Type.var "userMsg" ]
                                                     ]
                                                )
                                           )
                                     )
                                   ]
                             , Type.var "parsed"
                             , Type.var "input"
                             ]
                         ]
                         (Type.namedWith
                              [ "Html" ]
                              "Html"
                              [ Type.namedWith
                                  [ "PagesMsg" ]
                                  "PagesMsg"
                                  [ Type.var "userMsg" ]
                              ]
                         )
                    )
            }
    , renderStyledHtml =
        Elm.value
            { importFrom = [ "Pages", "Form" ]
            , name = "renderStyledHtml"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "Html", "Styled" ]
                                "Attribute"
                                [ Type.namedWith
                                      [ "PagesMsg" ]
                                      "PagesMsg"
                                      [ Type.var "userMsg" ]
                                ]
                             )
                         , Type.namedWith
                             [ "Pages", "Form" ]
                             "Options"
                             [ Type.var "error"
                             , Type.var "parsed"
                             , Type.var "input"
                             , Type.var "userMsg"
                             ]
                         , Type.extensible
                             "app"
                             [ ( "pageFormState"
                               , Type.namedWith [ "Form" ] "Model" []
                               )
                             , ( "navigation"
                               , Type.maybe
                                   (Type.namedWith
                                      [ "Pages", "Navigation" ]
                                      "Navigation"
                                      []
                                   )
                               )
                             , ( "concurrentSubmissions"
                               , Type.namedWith
                                   [ "Dict" ]
                                   "Dict"
                                   [ Type.string
                                   , Type.namedWith
                                         [ "Pages", "ConcurrentSubmission" ]
                                         "ConcurrentSubmission"
                                         [ Type.maybe (Type.var "action") ]
                                   ]
                               )
                             ]
                         , Type.namedWith
                             [ "Form" ]
                             "Form"
                             [ Type.var "error"
                             , Type.record
                                   [ ( "combine"
                                     , Type.namedWith
                                           [ "Form", "Validation" ]
                                           "Validation"
                                           [ Type.var "error"
                                           , Type.var "parsed"
                                           , Type.var "named"
                                           , Type.var "constraints"
                                           ]
                                     )
                                   , ( "view"
                                     , Type.function
                                           [ Type.namedWith
                                               [ "Form" ]
                                               "Context"
                                               [ Type.var "error"
                                               , Type.var "input"
                                               ]
                                           ]
                                           (Type.list
                                                (Type.namedWith
                                                     [ "Html", "Styled" ]
                                                     "Html"
                                                     [ Type.namedWith
                                                         [ "PagesMsg" ]
                                                         "PagesMsg"
                                                         [ Type.var "userMsg" ]
                                                     ]
                                                )
                                           )
                                     )
                                   ]
                             , Type.var "parsed"
                             , Type.var "input"
                             ]
                         ]
                         (Type.namedWith
                              [ "Html", "Styled" ]
                              "Html"
                              [ Type.namedWith
                                  [ "PagesMsg" ]
                                  "PagesMsg"
                                  [ Type.var "userMsg" ]
                              ]
                         )
                    )
            }
    , withConcurrent =
        Elm.value
            { importFrom = [ "Pages", "Form" ]
            , name = "withConcurrent"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Form" ]
                             "Options"
                             [ Type.var "error"
                             , Type.var "parsed"
                             , Type.var "input"
                             , Type.var "msg"
                             ]
                         ]
                         (Type.namedWith
                              [ "Pages", "Form" ]
                              "Options"
                              [ Type.var "error"
                              , Type.var "parsed"
                              , Type.var "input"
                              , Type.var "msg"
                              ]
                         )
                    )
            }
    }