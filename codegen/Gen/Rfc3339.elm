module Gen.Rfc3339 exposing (annotation_, call_, caseOf_, dateLocalParser, dateTimeLocalParser, dateTimeOffsetParser, make_, moduleName_, parse, timeLocalParser, toString, values_)

{-| 
@docs moduleName_, parse, toString, dateTimeOffsetParser, dateTimeLocalParser, dateLocalParser, timeLocalParser, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Rfc3339" ]


{-| Attempts to convert a `String` to a `DateTime`

parse: String -> Result.Result (List Rfc3339.Error) Rfc3339.DateTime
-}
parse : String -> Elm.Expression
parse parseArg =
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
        [ Elm.string parseArg ]


{-| Prints an RFC3339 formatted String, using `T` as the date time separator and `Z` for an offset of 0 hours and 0 minutes.

toString: Rfc3339.DateTime -> String
-}
toString : Elm.Expression -> Elm.Expression
toString toStringArg =
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
        [ toStringArg ]


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


caseOf_ :
    { dateTime :
        Elm.Expression
        -> { dateTimeTags_0_0
            | dateTimeOffset : Elm.Expression -> Elm.Expression
            , dateTimeLocal : Elm.Expression -> Elm.Expression
            , dateLocal : Elm.Expression -> Elm.Expression
            , timeLocal : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , error :
        Elm.Expression
        -> { errorTags_1_0
            | expectedDateSeparator : Elm.Expression
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
        -> Elm.Expression
    }
caseOf_ =
    { dateTime =
        \dateTimeExpression dateTimeTags ->
            Elm.Case.custom
                dateTimeExpression
                (Type.namedWith [ "Rfc3339" ] "DateTime" [])
                [ Elm.Case.branch1
                    "DateTimeOffset"
                    ( "one"
                    , Type.record
                          [ ( "instant", Type.namedWith [ "Time" ] "Posix" [] )
                          , ( "offset"
                            , Type.record
                                  [ ( "hour", Type.int )
                                  , ( "minute", Type.int )
                                  ]
                            )
                          ]
                    )
                    dateTimeTags.dateTimeOffset
                , Elm.Case.branch1
                    "DateTimeLocal"
                    ( "timeExtraParts"
                    , Type.namedWith [ "Time", "Extra" ] "Parts" []
                    )
                    dateTimeTags.dateTimeLocal
                , Elm.Case.branch1
                    "DateLocal"
                    ( "dateDate", Type.namedWith [ "Date" ] "Date" [] )
                    dateTimeTags.dateLocal
                , Elm.Case.branch1
                    "TimeLocal"
                    ( "one"
                    , Type.record
                          [ ( "hour", Type.int )
                          , ( "minute", Type.int )
                          , ( "second", Type.int )
                          , ( "millisecond", Type.int )
                          ]
                    )
                    dateTimeTags.timeLocal
                ]
    , error =
        \errorExpression errorTags ->
            Elm.Case.custom
                errorExpression
                (Type.namedWith [ "Rfc3339" ] "Error" [])
                [ Elm.Case.branch0
                    "ExpectedDateSeparator"
                    errorTags.expectedDateSeparator
                , Elm.Case.branch0
                    "ExpectedDateTimeSeparator"
                    errorTags.expectedDateTimeSeparator
                , Elm.Case.branch0
                    "ExpectedTimeSeparator"
                    errorTags.expectedTimeSeparator
                , Elm.Case.branch0
                    "ExpectedOffsetSeparator"
                    errorTags.expectedOffsetSeparator
                , Elm.Case.branch0 "InvalidMonth" errorTags.invalidMonth
                , Elm.Case.branch1
                    "DayTooLarge"
                    ( "basicsInt", Type.int )
                    errorTags.dayTooLarge
                , Elm.Case.branch0
                    "ExpectedZuluOffset"
                    errorTags.expectedZuluOffset
                , Elm.Case.branch0
                    "ExpectedOffsetSign"
                    errorTags.expectedOffsetSign
                , Elm.Case.branch0
                    "ExpectedFractionalSecondSeparator"
                    errorTags.expectedFractionalSecondSeparator
                , Elm.Case.branch0 "ExpectedDigit" errorTags.expectedDigit
                , Elm.Case.branch0 "ExpectedAnInt" errorTags.expectedAnInt
                , Elm.Case.branch0
                    "InvalidNegativeDigits"
                    errorTags.invalidNegativeDigits
                , Elm.Case.branch0 "InvalidHour" errorTags.invalidHour
                , Elm.Case.branch0 "InvalidMinute" errorTags.invalidMinute
                , Elm.Case.branch0 "InvalidSecond" errorTags.invalidSecond
                , Elm.Case.branch0 "InvalidDay" errorTags.invalidDay
                ]
    }


call_ :
    { parse : Elm.Expression -> Elm.Expression
    , toString : Elm.Expression -> Elm.Expression
    }
call_ =
    { parse =
        \parseArg ->
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
                [ parseArg ]
    , toString =
        \toStringArg ->
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
                [ toStringArg ]
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