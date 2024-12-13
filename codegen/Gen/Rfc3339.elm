module Gen.Rfc3339 exposing
    ( moduleName_, parse, toString, dateTimeOffsetParser, dateTimeLocalParser, dateLocalParser
    , timeLocalParser, annotation_, make_, caseOf_, call_, values_
    )

{-|
# Generated bindings for Rfc3339

@docs moduleName_, parse, toString, dateTimeOffsetParser, dateTimeLocalParser, dateLocalParser
@docs timeLocalParser, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Rfc3339" ]


{-| Attempts to convert a `String` to a `DateTime`

parse: String -> Result.Result (List Rfc3339.Error) Rfc3339.DateTime
-}
parse : String -> Elm.Expression
parse parseArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Rfc3339" ]
             , name = "parse"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "Result" ]
                               "Result"
                               [ Type.list
                                   (Type.namedWith [ "Rfc3339" ] "Error" [])
                               , Type.namedWith [ "Rfc3339" ] "DateTime" []
                               ]
                          )
                     )
             }
        )
        [ Elm.string parseArg_ ]


{-| Prints an RFC3339 formatted String, using `T` as the date time separator and `Z` for an offset of 0 hours and 0 minutes.

toString: Rfc3339.DateTime -> String
-}
toString : Elm.Expression -> Elm.Expression
toString toStringArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Rfc3339" ]
             , name = "toString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Rfc3339" ] "DateTime" [] ]
                          Type.string
                     )
             }
        )
        [ toStringArg_ ]


{-| Parser for a **date time with offset**: e.g. 1970-11-21T09:15:22+01:00.

dateTimeOffsetParser: 
    Parser.Advanced.Parser context Rfc3339.Error { instant : Time.Posix
    , offset : { hour : Int, minute : Int }
    }
-}
dateTimeOffsetParser : Elm.Expression
dateTimeOffsetParser =
    Elm.value
        { importFrom = [ "Rfc3339" ]
        , name = "dateTimeOffsetParser"
        , annotation =
            Just
                (Type.namedWith
                     [ "Parser", "Advanced" ]
                     "Parser"
                     [ Type.var "context"
                     , Type.namedWith [ "Rfc3339" ] "Error" []
                     , Type.record
                         [ ( "instant", Type.namedWith [ "Time" ] "Posix" [] )
                         , ( "offset"
                           , Type.record
                               [ ( "hour", Type.int ), ( "minute", Type.int ) ]
                           )
                         ]
                     ]
                )
        }


{-| Parser for a **local date time**: e.g. 1970-11-21T09:15:22 ([Time.Extra.Parts](https://package.elm-lang.org/packages/justinmimbs/time-extra/1.2.0/Time-Extra#Parts)).

dateTimeLocalParser: Parser.Advanced.Parser context Rfc3339.Error Time.Extra.Parts
-}
dateTimeLocalParser : Elm.Expression
dateTimeLocalParser =
    Elm.value
        { importFrom = [ "Rfc3339" ]
        , name = "dateTimeLocalParser"
        , annotation =
            Just
                (Type.namedWith
                     [ "Parser", "Advanced" ]
                     "Parser"
                     [ Type.var "context"
                     , Type.namedWith [ "Rfc3339" ] "Error" []
                     , Type.namedWith [ "Time", "Extra" ] "Parts" []
                     ]
                )
        }


{-| Parser for a **local date**: e.g. 1970-11-21 ([Date.Date](https://package.elm-lang.org/packages/justinmimbs/date/4.1.0/Date#Date)).

dateLocalParser: Parser.Advanced.Parser context Rfc3339.Error Date.Date
-}
dateLocalParser : Elm.Expression
dateLocalParser =
    Elm.value
        { importFrom = [ "Rfc3339" ]
        , name = "dateLocalParser"
        , annotation =
            Just
                (Type.namedWith
                     [ "Parser", "Advanced" ]
                     "Parser"
                     [ Type.var "context"
                     , Type.namedWith [ "Rfc3339" ] "Error" []
                     , Type.namedWith [ "Date" ] "Date" []
                     ]
                )
        }


{-| Parser for a **local time**: e.g. 09:15:22.

timeLocalParser: 
    Parser.Advanced.Parser context Rfc3339.Error { hour : Int
    , minute : Int
    , second : Int
    , millisecond : Int
    }
-}
timeLocalParser : Elm.Expression
timeLocalParser =
    Elm.value
        { importFrom = [ "Rfc3339" ]
        , name = "timeLocalParser"
        , annotation =
            Just
                (Type.namedWith
                     [ "Parser", "Advanced" ]
                     "Parser"
                     [ Type.var "context"
                     , Type.namedWith [ "Rfc3339" ] "Error" []
                     , Type.record
                         [ ( "hour", Type.int )
                         , ( "minute", Type.int )
                         , ( "second", Type.int )
                         , ( "millisecond", Type.int )
                         ]
                     ]
                )
        }


annotation_ : { dateTime : Type.Annotation, error : Type.Annotation }
annotation_ =
    { dateTime = Type.namedWith [ "Rfc3339" ] "DateTime" []
    , error = Type.namedWith [ "Rfc3339" ] "Error" []
    }


make_ :
    { dateTimeOffset : Elm.Expression -> Elm.Expression
    , dateTimeLocal : Elm.Expression -> Elm.Expression
    , dateLocal : Elm.Expression -> Elm.Expression
    , timeLocal : Elm.Expression -> Elm.Expression
    , expectedDateSeparator : Elm.Expression
    , expectedDateTimeSeparator : Elm.Expression
    , expectedTimeSeparator : Elm.Expression
    , expectedOffsetSeparator : Elm.Expression
    , invalidMonth : Elm.Expression
    , dayTooLarge : Elm.Expression -> Elm.Expression
    , expectedZuluOffset : Elm.Expression
    , expectedOffsetSign : Elm.Expression
    , expectedFractionalSecondSeparator : Elm.Expression
    , expectedDigit : Elm.Expression
    , expectedAnInt : Elm.Expression
    , invalidNegativeDigits : Elm.Expression
    , invalidHour : Elm.Expression
    , invalidMinute : Elm.Expression
    , invalidSecond : Elm.Expression
    , invalidDay : Elm.Expression
    }
make_ =
    { dateTimeOffset =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Rfc3339" ]
                     , name = "DateTimeOffset"
                     , annotation = Just (Type.namedWith [] "DateTime" [])
                     }
                )
                [ ar0 ]
    , dateTimeLocal =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Rfc3339" ]
                     , name = "DateTimeLocal"
                     , annotation = Just (Type.namedWith [] "DateTime" [])
                     }
                )
                [ ar0 ]
    , dateLocal =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Rfc3339" ]
                     , name = "DateLocal"
                     , annotation = Just (Type.namedWith [] "DateTime" [])
                     }
                )
                [ ar0 ]
    , timeLocal =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Rfc3339" ]
                     , name = "TimeLocal"
                     , annotation = Just (Type.namedWith [] "DateTime" [])
                     }
                )
                [ ar0 ]
    , expectedDateSeparator =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "ExpectedDateSeparator"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , expectedDateTimeSeparator =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "ExpectedDateTimeSeparator"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , expectedTimeSeparator =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "ExpectedTimeSeparator"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , expectedOffsetSeparator =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "ExpectedOffsetSeparator"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , invalidMonth =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "InvalidMonth"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , dayTooLarge =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Rfc3339" ]
                     , name = "DayTooLarge"
                     , annotation = Just (Type.namedWith [] "Error" [])
                     }
                )
                [ ar0 ]
    , expectedZuluOffset =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "ExpectedZuluOffset"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , expectedOffsetSign =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "ExpectedOffsetSign"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , expectedFractionalSecondSeparator =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "ExpectedFractionalSecondSeparator"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , expectedDigit =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "ExpectedDigit"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , expectedAnInt =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "ExpectedAnInt"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , invalidNegativeDigits =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "InvalidNegativeDigits"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , invalidHour =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "InvalidHour"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , invalidMinute =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "InvalidMinute"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , invalidSecond =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "InvalidSecond"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , invalidDay =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "InvalidDay"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    }


caseOf_ =
    { dateTime =
        \dateTimeExpression dateTimeTags ->
            Elm.Case.custom
                dateTimeExpression
                (Type.namedWith [ "Rfc3339" ] "DateTime" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "DateTimeOffset"
                       dateTimeTags.dateTimeOffset |> Elm.Arg.item
                                                            (Elm.Arg.varWith
                                                                   "arg_0"
                                                                   (Type.record
                                                                          [ ( "instant"
                                                                            , Type.namedWith
                                                                                [ "Time"
                                                                                ]
                                                                                "Posix"
                                                                                []
                                                                            )
                                                                          , ( "offset"
                                                                            , Type.record
                                                                                [ ( "hour"
                                                                                  , Type.int
                                                                                  )
                                                                                , ( "minute"
                                                                                  , Type.int
                                                                                  )
                                                                                ]
                                                                            )
                                                                          ]
                                                                   )
                                                            )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "DateTimeLocal"
                       dateTimeTags.dateTimeLocal |> Elm.Arg.item
                                                           (Elm.Arg.varWith
                                                                  "timeExtraParts"
                                                                  (Type.namedWith
                                                                         [ "Time"
                                                                         , "Extra"
                                                                         ]
                                                                         "Parts"
                                                                         []
                                                                  )
                                                           )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "DateLocal"
                       dateTimeTags.dateLocal |> Elm.Arg.item
                                                       (Elm.Arg.varWith
                                                              "dateDate"
                                                              (Type.namedWith
                                                                     [ "Date" ]
                                                                     "Date"
                                                                     []
                                                              )
                                                       )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "TimeLocal"
                       dateTimeTags.timeLocal |> Elm.Arg.item
                                                       (Elm.Arg.varWith
                                                              "arg_0"
                                                              (Type.record
                                                                     [ ( "hour"
                                                                       , Type.int
                                                                       )
                                                                     , ( "minute"
                                                                       , Type.int
                                                                       )
                                                                     , ( "second"
                                                                       , Type.int
                                                                       )
                                                                     , ( "millisecond"
                                                                       , Type.int
                                                                       )
                                                                     ]
                                                              )
                                                       )
                    )
                    Basics.identity
                ]
    , error =
        \errorExpression errorTags ->
            Elm.Case.custom
                errorExpression
                (Type.namedWith [ "Rfc3339" ] "Error" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "ExpectedDateSeparator"
                       errorTags.expectedDateSeparator
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ExpectedDateTimeSeparator"
                       errorTags.expectedDateTimeSeparator
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ExpectedTimeSeparator"
                       errorTags.expectedTimeSeparator
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ExpectedOffsetSeparator"
                       errorTags.expectedOffsetSeparator
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "InvalidMonth" errorTags.invalidMonth)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "DayTooLarge"
                       errorTags.dayTooLarge |> Elm.Arg.item
                                                      (Elm.Arg.varWith
                                                             "arg_0"
                                                             Type.int
                                                      )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ExpectedZuluOffset"
                       errorTags.expectedZuluOffset
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ExpectedOffsetSign"
                       errorTags.expectedOffsetSign
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ExpectedFractionalSecondSeparator"
                       errorTags.expectedFractionalSecondSeparator
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "ExpectedDigit" errorTags.expectedDigit)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "ExpectedAnInt" errorTags.expectedAnInt)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "InvalidNegativeDigits"
                       errorTags.invalidNegativeDigits
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "InvalidHour" errorTags.invalidHour)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "InvalidMinute" errorTags.invalidMinute)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "InvalidSecond" errorTags.invalidSecond)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "InvalidDay" errorTags.invalidDay)
                    Basics.identity
                ]
    }


call_ :
    { parse : Elm.Expression -> Elm.Expression
    , toString : Elm.Expression -> Elm.Expression
    }
call_ =
    { parse =
        \parseArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Rfc3339" ]
                     , name = "parse"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Result" ]
                                       "Result"
                                       [ Type.list
                                           (Type.namedWith
                                              [ "Rfc3339" ]
                                              "Error"
                                              []
                                           )
                                       , Type.namedWith
                                           [ "Rfc3339" ]
                                           "DateTime"
                                           []
                                       ]
                                  )
                             )
                     }
                )
                [ parseArg_ ]
    , toString =
        \toStringArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Rfc3339" ]
                     , name = "toString"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Rfc3339" ] "DateTime" [] ]
                                  Type.string
                             )
                     }
                )
                [ toStringArg_ ]
    }


values_ :
    { parse : Elm.Expression
    , toString : Elm.Expression
    , dateTimeOffsetParser : Elm.Expression
    , dateTimeLocalParser : Elm.Expression
    , dateLocalParser : Elm.Expression
    , timeLocalParser : Elm.Expression
    }
values_ =
    { parse =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "parse"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "Result" ]
                              "Result"
                              [ Type.list
                                  (Type.namedWith [ "Rfc3339" ] "Error" [])
                              , Type.namedWith [ "Rfc3339" ] "DateTime" []
                              ]
                         )
                    )
            }
    , toString =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "toString"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Rfc3339" ] "DateTime" [] ]
                         Type.string
                    )
            }
    , dateTimeOffsetParser =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "dateTimeOffsetParser"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Parser", "Advanced" ]
                         "Parser"
                         [ Type.var "context"
                         , Type.namedWith [ "Rfc3339" ] "Error" []
                         , Type.record
                             [ ( "instant"
                               , Type.namedWith [ "Time" ] "Posix" []
                               )
                             , ( "offset"
                               , Type.record
                                   [ ( "hour", Type.int )
                                   , ( "minute", Type.int )
                                   ]
                               )
                             ]
                         ]
                    )
            }
    , dateTimeLocalParser =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "dateTimeLocalParser"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Parser", "Advanced" ]
                         "Parser"
                         [ Type.var "context"
                         , Type.namedWith [ "Rfc3339" ] "Error" []
                         , Type.namedWith [ "Time", "Extra" ] "Parts" []
                         ]
                    )
            }
    , dateLocalParser =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "dateLocalParser"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Parser", "Advanced" ]
                         "Parser"
                         [ Type.var "context"
                         , Type.namedWith [ "Rfc3339" ] "Error" []
                         , Type.namedWith [ "Date" ] "Date" []
                         ]
                    )
            }
    , timeLocalParser =
        Elm.value
            { importFrom = [ "Rfc3339" ]
            , name = "timeLocalParser"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Parser", "Advanced" ]
                         "Parser"
                         [ Type.var "context"
                         , Type.namedWith [ "Rfc3339" ] "Error" []
                         , Type.record
                             [ ( "hour", Type.int )
                             , ( "minute", Type.int )
                             , ( "second", Type.int )
                             , ( "millisecond", Type.int )
                             ]
                         ]
                    )
            }
    }