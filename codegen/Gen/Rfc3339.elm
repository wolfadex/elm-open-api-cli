module Gen.Rfc3339 exposing
    ( toString, dateTimeOffsetParser
    , make_
    )

{-|


# Generated bindings for Rfc3339

@docs toString, dateTimeOffsetParser
@docs make_

-}

import Elm
import Elm.Annotation as Type


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
