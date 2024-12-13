module Gen.Scaffold.Form exposing
    ( moduleName_, provide, restArgsParser, recordEncoder, fieldEncoder, annotation_
    , make_, caseOf_, call_, values_
    )

{-|
# Generated bindings for Scaffold.Form

@docs moduleName_, provide, restArgsParser, recordEncoder, fieldEncoder, annotation_
@docs make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Scaffold", "Form" ]


{-| provide: 
    { fields : List ( String, Scaffold.Form.Kind )
    , elmCssView : Bool
    , view :
        { formState : Scaffold.Form.Context
        , params :
            List { name : String
            , kind : Scaffold.Form.Kind
            , param : Elm.Expression
            }
        }
        -> Elm.Expression
    }
    -> Maybe { formHandlers : Elm.Expression
    , form : Elm.Expression
    , declarations : List Elm.Declaration
    }
-}
provide :
    { fields : List Elm.Expression
    , elmCssView : Bool
    , view : Elm.Expression -> Elm.Expression
    }
    -> Elm.Expression
provide provideArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Scaffold", "Form" ]
             , name = "provide"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "fields"
                                , Type.list
                                    (Type.tuple
                                       Type.string
                                       (Type.namedWith
                                          [ "Scaffold", "Form" ]
                                          "Kind"
                                          []
                                       )
                                    )
                                )
                              , ( "elmCssView", Type.bool )
                              , ( "view"
                                , Type.function
                                    [ Type.record
                                          [ ( "formState"
                                            , Type.namedWith
                                                  [ "Scaffold", "Form" ]
                                                  "Context"
                                                  []
                                            )
                                          , ( "params"
                                            , Type.list
                                                  (Type.record
                                                       [ ( "name", Type.string )
                                                       , ( "kind"
                                                         , Type.namedWith
                                                               [ "Scaffold"
                                                               , "Form"
                                                               ]
                                                               "Kind"
                                                               []
                                                         )
                                                       , ( "param"
                                                         , Type.namedWith
                                                               [ "Elm" ]
                                                               "Expression"
                                                               []
                                                         )
                                                       ]
                                                  )
                                            )
                                          ]
                                    ]
                                    (Type.namedWith [ "Elm" ] "Expression" [])
                                )
                              ]
                          ]
                          (Type.maybe
                               (Type.record
                                    [ ( "formHandlers"
                                      , Type.namedWith [ "Elm" ] "Expression" []
                                      )
                                    , ( "form"
                                      , Type.namedWith [ "Elm" ] "Expression" []
                                      )
                                    , ( "declarations"
                                      , Type.list
                                            (Type.namedWith
                                                 [ "Elm" ]
                                                 "Declaration"
                                                 []
                                            )
                                      )
                                    ]
                               )
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "fields" (Elm.list provideArg_.fields)
            , Tuple.pair "elmCssView" (Elm.bool provideArg_.elmCssView)
            , Tuple.pair
                  "view"
                  (Elm.functionReduced "provideUnpack" provideArg_.view)
            ]
        ]


{-| This parser handles the following field types (or `text` if none is provided):

  - `text`
  - `textarea`
  - `checkbox`
  - `time`
  - `date`

The naming convention follows the same naming as the HTML form field elements or attributes that are used to represent them.
In addition to using the appropriate field type, this will also give you an Elm type with the corresponding base type (like `Date` for `date` or `Bool` for `checkbox`).

restArgsParser: Cli.Option.Option (List String) (List ( String, Scaffold.Form.Kind )) Cli.Option.RestArgsOption
-}
restArgsParser : Elm.Expression
restArgsParser =
    Elm.value
        { importFrom = [ "Scaffold", "Form" ]
        , name = "restArgsParser"
        , annotation =
            Just
                (Type.namedWith
                     [ "Cli", "Option" ]
                     "Option"
                     [ Type.list Type.string
                     , Type.list
                         (Type.tuple
                            Type.string
                            (Type.namedWith [ "Scaffold", "Form" ] "Kind" [])
                         )
                     , Type.namedWith [ "Cli", "Option" ] "RestArgsOption" []
                     ]
                )
        }


{-| Generate a JSON Encoder for the form fields. This can be helpful for sending the validated form data through a
BackendTask.Custom or to an external API from your scaffolded Route Module code.

recordEncoder: Elm.Expression -> List ( String, Scaffold.Form.Kind ) -> Elm.Expression
-}
recordEncoder : Elm.Expression -> List Elm.Expression -> Elm.Expression
recordEncoder recordEncoderArg_ recordEncoderArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Scaffold", "Form" ]
             , name = "recordEncoder"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Elm" ] "Expression" []
                          , Type.list
                              (Type.tuple
                                 Type.string
                                 (Type.namedWith
                                    [ "Scaffold", "Form" ]
                                    "Kind"
                                    []
                                 )
                              )
                          ]
                          (Type.namedWith [ "Elm" ] "Expression" [])
                     )
             }
        )
        [ recordEncoderArg_, Elm.list recordEncoderArg_0 ]


{-| A lower-level, more granular version of `recordEncoder` - lets you generate a JSON Encoder `Expression` for an individual Field rather than a group of Fields.

fieldEncoder: Elm.Expression -> String -> Scaffold.Form.Kind -> Elm.Expression
-}
fieldEncoder : Elm.Expression -> String -> Elm.Expression -> Elm.Expression
fieldEncoder fieldEncoderArg_ fieldEncoderArg_0 fieldEncoderArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Scaffold", "Form" ]
             , name = "fieldEncoder"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Elm" ] "Expression" []
                          , Type.string
                          , Type.namedWith [ "Scaffold", "Form" ] "Kind" []
                          ]
                          (Type.namedWith [ "Elm" ] "Expression" [])
                     )
             }
        )
        [ fieldEncoderArg_, Elm.string fieldEncoderArg_0, fieldEncoderArg_1 ]


annotation_ : { kind : Type.Annotation, context : Type.Annotation }
annotation_ =
    { kind = Type.namedWith [ "Scaffold", "Form" ] "Kind" []
    , context =
        Type.alias
            moduleName_
            "Context"
            []
            (Type.record
                 [ ( "errors", Type.namedWith [ "Elm" ] "Expression" [] )
                 , ( "submitting", Type.namedWith [ "Elm" ] "Expression" [] )
                 , ( "submitAttempted"
                   , Type.namedWith [ "Elm" ] "Expression" []
                   )
                 , ( "data", Type.namedWith [ "Elm" ] "Expression" [] )
                 , ( "expression", Type.namedWith [ "Elm" ] "Expression" [] )
                 ]
            )
    }


make_ :
    { fieldInt : Elm.Expression
    , fieldText : Elm.Expression
    , fieldTextarea : Elm.Expression
    , fieldFloat : Elm.Expression
    , fieldTime : Elm.Expression
    , fieldDate : Elm.Expression
    , fieldCheckbox : Elm.Expression
    , context :
        { errors : Elm.Expression
        , submitting : Elm.Expression
        , submitAttempted : Elm.Expression
        , data : Elm.Expression
        , expression : Elm.Expression
        }
        -> Elm.Expression
    }
make_ =
    { fieldInt =
        Elm.value
            { importFrom = [ "Scaffold", "Form" ]
            , name = "FieldInt"
            , annotation = Just (Type.namedWith [] "Kind" [])
            }
    , fieldText =
        Elm.value
            { importFrom = [ "Scaffold", "Form" ]
            , name = "FieldText"
            , annotation = Just (Type.namedWith [] "Kind" [])
            }
    , fieldTextarea =
        Elm.value
            { importFrom = [ "Scaffold", "Form" ]
            , name = "FieldTextarea"
            , annotation = Just (Type.namedWith [] "Kind" [])
            }
    , fieldFloat =
        Elm.value
            { importFrom = [ "Scaffold", "Form" ]
            , name = "FieldFloat"
            , annotation = Just (Type.namedWith [] "Kind" [])
            }
    , fieldTime =
        Elm.value
            { importFrom = [ "Scaffold", "Form" ]
            , name = "FieldTime"
            , annotation = Just (Type.namedWith [] "Kind" [])
            }
    , fieldDate =
        Elm.value
            { importFrom = [ "Scaffold", "Form" ]
            , name = "FieldDate"
            , annotation = Just (Type.namedWith [] "Kind" [])
            }
    , fieldCheckbox =
        Elm.value
            { importFrom = [ "Scaffold", "Form" ]
            , name = "FieldCheckbox"
            , annotation = Just (Type.namedWith [] "Kind" [])
            }
    , context =
        \context_args ->
            Elm.withType
                (Type.alias
                     [ "Scaffold", "Form" ]
                     "Context"
                     []
                     (Type.record
                          [ ( "errors"
                            , Type.namedWith [ "Elm" ] "Expression" []
                            )
                          , ( "submitting"
                            , Type.namedWith [ "Elm" ] "Expression" []
                            )
                          , ( "submitAttempted"
                            , Type.namedWith [ "Elm" ] "Expression" []
                            )
                          , ( "data", Type.namedWith [ "Elm" ] "Expression" [] )
                          , ( "expression"
                            , Type.namedWith [ "Elm" ] "Expression" []
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "errors" context_args.errors
                     , Tuple.pair "submitting" context_args.submitting
                     , Tuple.pair "submitAttempted" context_args.submitAttempted
                     , Tuple.pair "data" context_args.data
                     , Tuple.pair "expression" context_args.expression
                     ]
                )
    }


caseOf_ :
    { kind :
        Elm.Expression
        -> { fieldInt : Elm.Expression
        , fieldText : Elm.Expression
        , fieldTextarea : Elm.Expression
        , fieldFloat : Elm.Expression
        , fieldTime : Elm.Expression
        , fieldDate : Elm.Expression
        , fieldCheckbox : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { kind =
        \kindExpression kindTags ->
            Elm.Case.custom
                kindExpression
                (Type.namedWith [ "Scaffold", "Form" ] "Kind" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType "FieldInt" kindTags.fieldInt)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "FieldText" kindTags.fieldText)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "FieldTextarea" kindTags.fieldTextarea)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "FieldFloat" kindTags.fieldFloat)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "FieldTime" kindTags.fieldTime)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "FieldDate" kindTags.fieldDate)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "FieldCheckbox" kindTags.fieldCheckbox)
                    Basics.identity
                ]
    }


call_ :
    { provide : Elm.Expression -> Elm.Expression
    , recordEncoder : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fieldEncoder :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { provide =
        \provideArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Scaffold", "Form" ]
                     , name = "provide"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "fields"
                                        , Type.list
                                            (Type.tuple
                                               Type.string
                                               (Type.namedWith
                                                  [ "Scaffold", "Form" ]
                                                  "Kind"
                                                  []
                                               )
                                            )
                                        )
                                      , ( "elmCssView", Type.bool )
                                      , ( "view"
                                        , Type.function
                                            [ Type.record
                                                  [ ( "formState"
                                                    , Type.namedWith
                                                          [ "Scaffold", "Form" ]
                                                          "Context"
                                                          []
                                                    )
                                                  , ( "params"
                                                    , Type.list
                                                          (Type.record
                                                               [ ( "name"
                                                                 , Type.string
                                                                 )
                                                               , ( "kind"
                                                                 , Type.namedWith
                                                                       [ "Scaffold"
                                                                       , "Form"
                                                                       ]
                                                                       "Kind"
                                                                       []
                                                                 )
                                                               , ( "param"
                                                                 , Type.namedWith
                                                                       [ "Elm" ]
                                                                       "Expression"
                                                                       []
                                                                 )
                                                               ]
                                                          )
                                                    )
                                                  ]
                                            ]
                                            (Type.namedWith
                                               [ "Elm" ]
                                               "Expression"
                                               []
                                            )
                                        )
                                      ]
                                  ]
                                  (Type.maybe
                                       (Type.record
                                            [ ( "formHandlers"
                                              , Type.namedWith
                                                    [ "Elm" ]
                                                    "Expression"
                                                    []
                                              )
                                            , ( "form"
                                              , Type.namedWith
                                                    [ "Elm" ]
                                                    "Expression"
                                                    []
                                              )
                                            , ( "declarations"
                                              , Type.list
                                                    (Type.namedWith
                                                         [ "Elm" ]
                                                         "Declaration"
                                                         []
                                                    )
                                              )
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ provideArg_ ]
    , recordEncoder =
        \recordEncoderArg_ recordEncoderArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Scaffold", "Form" ]
                     , name = "recordEncoder"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.list
                                      (Type.tuple
                                         Type.string
                                         (Type.namedWith
                                            [ "Scaffold", "Form" ]
                                            "Kind"
                                            []
                                         )
                                      )
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                             )
                     }
                )
                [ recordEncoderArg_, recordEncoderArg_0 ]
    , fieldEncoder =
        \fieldEncoderArg_ fieldEncoderArg_0 fieldEncoderArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Scaffold", "Form" ]
                     , name = "fieldEncoder"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Elm" ] "Expression" []
                                  , Type.string
                                  , Type.namedWith
                                      [ "Scaffold", "Form" ]
                                      "Kind"
                                      []
                                  ]
                                  (Type.namedWith [ "Elm" ] "Expression" [])
                             )
                     }
                )
                [ fieldEncoderArg_, fieldEncoderArg_0, fieldEncoderArg_1 ]
    }


values_ :
    { provide : Elm.Expression
    , restArgsParser : Elm.Expression
    , recordEncoder : Elm.Expression
    , fieldEncoder : Elm.Expression
    }
values_ =
    { provide =
        Elm.value
            { importFrom = [ "Scaffold", "Form" ]
            , name = "provide"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "fields"
                               , Type.list
                                   (Type.tuple
                                      Type.string
                                      (Type.namedWith
                                         [ "Scaffold", "Form" ]
                                         "Kind"
                                         []
                                      )
                                   )
                               )
                             , ( "elmCssView", Type.bool )
                             , ( "view"
                               , Type.function
                                   [ Type.record
                                         [ ( "formState"
                                           , Type.namedWith
                                                 [ "Scaffold", "Form" ]
                                                 "Context"
                                                 []
                                           )
                                         , ( "params"
                                           , Type.list
                                                 (Type.record
                                                      [ ( "name", Type.string )
                                                      , ( "kind"
                                                        , Type.namedWith
                                                              [ "Scaffold"
                                                              , "Form"
                                                              ]
                                                              "Kind"
                                                              []
                                                        )
                                                      , ( "param"
                                                        , Type.namedWith
                                                              [ "Elm" ]
                                                              "Expression"
                                                              []
                                                        )
                                                      ]
                                                 )
                                           )
                                         ]
                                   ]
                                   (Type.namedWith [ "Elm" ] "Expression" [])
                               )
                             ]
                         ]
                         (Type.maybe
                              (Type.record
                                   [ ( "formHandlers"
                                     , Type.namedWith [ "Elm" ] "Expression" []
                                     )
                                   , ( "form"
                                     , Type.namedWith [ "Elm" ] "Expression" []
                                     )
                                   , ( "declarations"
                                     , Type.list
                                           (Type.namedWith
                                                [ "Elm" ]
                                                "Declaration"
                                                []
                                           )
                                     )
                                   ]
                              )
                         )
                    )
            }
    , restArgsParser =
        Elm.value
            { importFrom = [ "Scaffold", "Form" ]
            , name = "restArgsParser"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Cli", "Option" ]
                         "Option"
                         [ Type.list Type.string
                         , Type.list
                             (Type.tuple
                                Type.string
                                (Type.namedWith [ "Scaffold", "Form" ] "Kind" []
                                )
                             )
                         , Type.namedWith
                             [ "Cli", "Option" ]
                             "RestArgsOption"
                             []
                         ]
                    )
            }
    , recordEncoder =
        Elm.value
            { importFrom = [ "Scaffold", "Form" ]
            , name = "recordEncoder"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Elm" ] "Expression" []
                         , Type.list
                             (Type.tuple
                                Type.string
                                (Type.namedWith [ "Scaffold", "Form" ] "Kind" []
                                )
                             )
                         ]
                         (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    , fieldEncoder =
        Elm.value
            { importFrom = [ "Scaffold", "Form" ]
            , name = "fieldEncoder"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Elm" ] "Expression" []
                         , Type.string
                         , Type.namedWith [ "Scaffold", "Form" ] "Kind" []
                         ]
                         (Type.namedWith [ "Elm" ] "Expression" [])
                    )
            }
    }