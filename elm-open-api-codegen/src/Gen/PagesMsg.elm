module Gen.PagesMsg exposing
    ( moduleName_, fromMsg, map, noOp, annotation_, call_
    , values_
    )

{-|
# Generated bindings for PagesMsg

@docs moduleName_, fromMsg, map, noOp, annotation_, call_
@docs values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "PagesMsg" ]


{-| import Form
    import Pages.Form
    import PagesMsg exposing (PagesMsg)

    type Msg
        = ToggleMenu

    view :
        Maybe PageUrl
        -> Shared.Model
        -> Model
        -> App Data ActionData RouteParams
        -> View (PagesMsg Msg)
    view maybeUrl sharedModel model app =
        { title = "My Page"
        , view =
            [ button
                -- we need to wrap our Route module's `Msg` here so we have a `PagesMsg Msg`
                [ onClick (PagesMsg.fromMsg ToggleMenu) ]
                []

            -- `Pages.Form.renderHtml` gives us `Html (PagesMsg msg)`, so we don't need to wrap its Msg type
            , logoutForm
                |> Pages.Form.renderHtml []
                    Pages.Form.Serial
                    (Form.options "logout"
                        |> Form.withOnSubmit (\_ -> NewItemSubmitted)
                    )
                    app
            ]
        }

fromMsg: userMsg -> PagesMsg.PagesMsg userMsg
-}
fromMsg : Elm.Expression -> Elm.Expression
fromMsg fromMsgArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "PagesMsg" ]
             , name = "fromMsg"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "userMsg" ]
                          (Type.namedWith
                               [ "PagesMsg" ]
                               "PagesMsg"
                               [ Type.var "userMsg" ]
                          )
                     )
             }
        )
        [ fromMsgArg_ ]


{-| map: (a -> b) -> PagesMsg.PagesMsg a -> PagesMsg.PagesMsg b -}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg_ mapArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "PagesMsg" ]
             , name = "map"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function [ Type.var "a" ] (Type.var "b")
                          , Type.namedWith
                              [ "PagesMsg" ]
                              "PagesMsg"
                              [ Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "PagesMsg" ]
                               "PagesMsg"
                               [ Type.var "b" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapUnpack" mapArg_, mapArg_0 ]


{-| A Msg that is handled by the elm-pages framework and does nothing. Helpful for when you don't want to register a callback.

    import Browser.Dom as Dom
    import PagesMsg exposing (PagesMsg)
    import Task

    resetViewport : Cmd (PagesMsg msg)
    resetViewport =
        Dom.setViewport 0 0
            |> Task.perform (\() -> PagesMsg.noOp)

noOp: PagesMsg.PagesMsg userMsg
-}
noOp : Elm.Expression
noOp =
    Elm.value
        { importFrom = [ "PagesMsg" ]
        , name = "noOp"
        , annotation =
            Just
                (Type.namedWith [ "PagesMsg" ] "PagesMsg" [ Type.var "userMsg" ]
                )
        }


annotation_ : { pagesMsg : Type.Annotation -> Type.Annotation }
annotation_ =
    { pagesMsg =
        \pagesMsgArg0 ->
            Type.alias
                moduleName_
                "PagesMsg"
                [ pagesMsgArg0 ]
                (Type.namedWith
                     [ "Pages", "Internal", "Msg" ]
                     "Msg"
                     [ Type.var "userMsg" ]
                )
    }


call_ :
    { fromMsg : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { fromMsg =
        \fromMsgArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "PagesMsg" ]
                     , name = "fromMsg"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "userMsg" ]
                                  (Type.namedWith
                                       [ "PagesMsg" ]
                                       "PagesMsg"
                                       [ Type.var "userMsg" ]
                                  )
                             )
                     }
                )
                [ fromMsgArg_ ]
    , map =
        \mapArg_ mapArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "PagesMsg" ]
                     , name = "map"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.var "b")
                                  , Type.namedWith
                                      [ "PagesMsg" ]
                                      "PagesMsg"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "PagesMsg" ]
                                       "PagesMsg"
                                       [ Type.var "b" ]
                                  )
                             )
                     }
                )
                [ mapArg_, mapArg_0 ]
    }


values_ :
    { fromMsg : Elm.Expression, map : Elm.Expression, noOp : Elm.Expression }
values_ =
    { fromMsg =
        Elm.value
            { importFrom = [ "PagesMsg" ]
            , name = "fromMsg"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "userMsg" ]
                         (Type.namedWith
                              [ "PagesMsg" ]
                              "PagesMsg"
                              [ Type.var "userMsg" ]
                         )
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "PagesMsg" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.var "a" ] (Type.var "b")
                         , Type.namedWith
                             [ "PagesMsg" ]
                             "PagesMsg"
                             [ Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "PagesMsg" ]
                              "PagesMsg"
                              [ Type.var "b" ]
                         )
                    )
            }
    , noOp =
        Elm.value
            { importFrom = [ "PagesMsg" ]
            , name = "noOp"
            , annotation =
                Just
                    (Type.namedWith
                         [ "PagesMsg" ]
                         "PagesMsg"
                         [ Type.var "userMsg" ]
                    )
            }
    }