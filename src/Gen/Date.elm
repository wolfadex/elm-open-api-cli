module Gen.Date exposing
    ( toIsoString
    , annotation_, call_
    )

{-|


# Generated bindings for Date

@docs toIsoString
@docs annotation_, call_

-}

import Elm
import Elm.Annotation as Type


{-| The name of this module.
-}
moduleName_ : List String
moduleName_ =
    [ "Date" ]


{-| Convert a date to a string in ISO 8601 extended format.

    import Date exposing (fromOrdinalDate, toIsoString)

    toIsoString (fromOrdinalDate 2001 1)
        == "2001-01-01"

toIsoString: Date.Date -> String

-}
toIsoString : Elm.Expression -> Elm.Expression
toIsoString toIsoStringArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Date" ]
            , name = "toIsoString"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Date" ] "Date" [] ]
                        Type.string
                    )
            }
        )
        [ toIsoStringArg_ ]


annotation_ :
    { date : Type.Annotation
    , month : Type.Annotation
    , weekday : Type.Annotation
    , language : Type.Annotation
    , unit : Type.Annotation
    , interval : Type.Annotation
    }
annotation_ =
    { date = Type.namedWith [ "Date" ] "Date" []
    , month =
        Type.alias moduleName_ "Month" [] (Type.namedWith [ "Time" ] "Month" [])
    , weekday =
        Type.alias
            moduleName_
            "Weekday"
            []
            (Type.namedWith [ "Time" ] "Weekday" [])
    , language =
        Type.alias
            moduleName_
            "Language"
            []
            (Type.record
                [ ( "monthName"
                  , Type.function
                        [ Type.namedWith [ "Date" ] "Month" [] ]
                        Type.string
                  )
                , ( "monthNameShort"
                  , Type.function
                        [ Type.namedWith [ "Date" ] "Month" [] ]
                        Type.string
                  )
                , ( "weekdayName"
                  , Type.function
                        [ Type.namedWith [ "Date" ] "Weekday" [] ]
                        Type.string
                  )
                , ( "weekdayNameShort"
                  , Type.function
                        [ Type.namedWith [ "Date" ] "Weekday" [] ]
                        Type.string
                  )
                , ( "dayWithSuffix", Type.function [ Type.int ] Type.string )
                ]
            )
    , unit = Type.namedWith [ "Date" ] "Unit" []
    , interval = Type.namedWith [ "Date" ] "Interval" []
    }


call_ :
    { fromPosix : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fromCalendarDate :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , fromWeekDate :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , fromOrdinalDate : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fromIsoString : Elm.Expression -> Elm.Expression
    , fromRataDie : Elm.Expression -> Elm.Expression
    , toIsoString : Elm.Expression -> Elm.Expression
    , toRataDie : Elm.Expression -> Elm.Expression
    , year : Elm.Expression -> Elm.Expression
    , month : Elm.Expression -> Elm.Expression
    , day : Elm.Expression -> Elm.Expression
    , weekYear : Elm.Expression -> Elm.Expression
    , weekNumber : Elm.Expression -> Elm.Expression
    , weekday : Elm.Expression -> Elm.Expression
    , ordinalDay : Elm.Expression -> Elm.Expression
    , quarter : Elm.Expression -> Elm.Expression
    , monthNumber : Elm.Expression -> Elm.Expression
    , weekdayNumber : Elm.Expression -> Elm.Expression
    , format : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withOrdinalSuffix : Elm.Expression -> Elm.Expression
    , formatWithLanguage :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , add : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , diff :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , ceiling : Elm.Expression -> Elm.Expression -> Elm.Expression
    , floor : Elm.Expression -> Elm.Expression -> Elm.Expression
    , range :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , compare : Elm.Expression -> Elm.Expression -> Elm.Expression
    , isBetween :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , min : Elm.Expression -> Elm.Expression -> Elm.Expression
    , max : Elm.Expression -> Elm.Expression -> Elm.Expression
    , clamp :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , monthToNumber : Elm.Expression -> Elm.Expression
    , numberToMonth : Elm.Expression -> Elm.Expression
    , weekdayToNumber : Elm.Expression -> Elm.Expression
    , numberToWeekday : Elm.Expression -> Elm.Expression
    }
call_ =
    { fromPosix =
        \fromPosixArg_ fromPosixArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "fromPosix"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Time" ] "Zone" []
                                , Type.namedWith [ "Time" ] "Posix" []
                                ]
                                (Type.namedWith [ "Date" ] "Date" [])
                            )
                    }
                )
                [ fromPosixArg_, fromPosixArg_0 ]
    , fromCalendarDate =
        \fromCalendarDateArg_ fromCalendarDateArg_0 fromCalendarDateArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "fromCalendarDate"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int
                                , Type.namedWith [ "Date" ] "Month" []
                                , Type.int
                                ]
                                (Type.namedWith [ "Date" ] "Date" [])
                            )
                    }
                )
                [ fromCalendarDateArg_
                , fromCalendarDateArg_0
                , fromCalendarDateArg_1
                ]
    , fromWeekDate =
        \fromWeekDateArg_ fromWeekDateArg_0 fromWeekDateArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "fromWeekDate"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int
                                , Type.int
                                , Type.namedWith [ "Date" ] "Weekday" []
                                ]
                                (Type.namedWith [ "Date" ] "Date" [])
                            )
                    }
                )
                [ fromWeekDateArg_, fromWeekDateArg_0, fromWeekDateArg_1 ]
    , fromOrdinalDate =
        \fromOrdinalDateArg_ fromOrdinalDateArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "fromOrdinalDate"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int, Type.int ]
                                (Type.namedWith [ "Date" ] "Date" [])
                            )
                    }
                )
                [ fromOrdinalDateArg_, fromOrdinalDateArg_0 ]
    , fromIsoString =
        \fromIsoStringArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "fromIsoString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.string
                                    , Type.namedWith [ "Date" ] "Date" []
                                    ]
                                )
                            )
                    }
                )
                [ fromIsoStringArg_ ]
    , fromRataDie =
        \fromRataDieArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "fromRataDie"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int ]
                                (Type.namedWith [ "Date" ] "Date" [])
                            )
                    }
                )
                [ fromRataDieArg_ ]
    , toIsoString =
        \toIsoStringArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "toIsoString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Date" [] ]
                                Type.string
                            )
                    }
                )
                [ toIsoStringArg_ ]
    , toRataDie =
        \toRataDieArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "toRataDie"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Date" [] ]
                                Type.int
                            )
                    }
                )
                [ toRataDieArg_ ]
    , year =
        \yearArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "year"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Date" [] ]
                                Type.int
                            )
                    }
                )
                [ yearArg_ ]
    , month =
        \monthArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "month"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Date" [] ]
                                (Type.namedWith [ "Date" ] "Month" [])
                            )
                    }
                )
                [ monthArg_ ]
    , day =
        \dayArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "day"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Date" [] ]
                                Type.int
                            )
                    }
                )
                [ dayArg_ ]
    , weekYear =
        \weekYearArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "weekYear"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Date" [] ]
                                Type.int
                            )
                    }
                )
                [ weekYearArg_ ]
    , weekNumber =
        \weekNumberArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "weekNumber"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Date" [] ]
                                Type.int
                            )
                    }
                )
                [ weekNumberArg_ ]
    , weekday =
        \weekdayArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "weekday"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Date" [] ]
                                (Type.namedWith [ "Date" ] "Weekday" [])
                            )
                    }
                )
                [ weekdayArg_ ]
    , ordinalDay =
        \ordinalDayArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "ordinalDay"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Date" [] ]
                                Type.int
                            )
                    }
                )
                [ ordinalDayArg_ ]
    , quarter =
        \quarterArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "quarter"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Date" [] ]
                                Type.int
                            )
                    }
                )
                [ quarterArg_ ]
    , monthNumber =
        \monthNumberArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "monthNumber"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Date" [] ]
                                Type.int
                            )
                    }
                )
                [ monthNumberArg_ ]
    , weekdayNumber =
        \weekdayNumberArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "weekdayNumber"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Date" [] ]
                                Type.int
                            )
                    }
                )
                [ weekdayNumberArg_ ]
    , format =
        \formatArg_ formatArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "format"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith [ "Date" ] "Date" []
                                ]
                                Type.string
                            )
                    }
                )
                [ formatArg_, formatArg_0 ]
    , withOrdinalSuffix =
        \withOrdinalSuffixArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "withOrdinalSuffix"
                    , annotation =
                        Just (Type.function [ Type.int ] Type.string)
                    }
                )
                [ withOrdinalSuffixArg_ ]
    , formatWithLanguage =
        \formatWithLanguageArg_ formatWithLanguageArg_0 formatWithLanguageArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "formatWithLanguage"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Language" []
                                , Type.string
                                , Type.namedWith [ "Date" ] "Date" []
                                ]
                                Type.string
                            )
                    }
                )
                [ formatWithLanguageArg_
                , formatWithLanguageArg_0
                , formatWithLanguageArg_1
                ]
    , add =
        \addArg_ addArg_0 addArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "add"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Unit" []
                                , Type.int
                                , Type.namedWith [ "Date" ] "Date" []
                                ]
                                (Type.namedWith [ "Date" ] "Date" [])
                            )
                    }
                )
                [ addArg_, addArg_0, addArg_1 ]
    , diff =
        \diffArg_ diffArg_0 diffArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "diff"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Unit" []
                                , Type.namedWith [ "Date" ] "Date" []
                                , Type.namedWith [ "Date" ] "Date" []
                                ]
                                Type.int
                            )
                    }
                )
                [ diffArg_, diffArg_0, diffArg_1 ]
    , ceiling =
        \ceilingArg_ ceilingArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "ceiling"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Interval" []
                                , Type.namedWith [ "Date" ] "Date" []
                                ]
                                (Type.namedWith [ "Date" ] "Date" [])
                            )
                    }
                )
                [ ceilingArg_, ceilingArg_0 ]
    , floor =
        \floorArg_ floorArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "floor"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Interval" []
                                , Type.namedWith [ "Date" ] "Date" []
                                ]
                                (Type.namedWith [ "Date" ] "Date" [])
                            )
                    }
                )
                [ floorArg_, floorArg_0 ]
    , range =
        \rangeArg_ rangeArg_0 rangeArg_1 rangeArg_2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "range"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Interval" []
                                , Type.int
                                , Type.namedWith [ "Date" ] "Date" []
                                , Type.namedWith [ "Date" ] "Date" []
                                ]
                                (Type.list
                                    (Type.namedWith [ "Date" ] "Date" [])
                                )
                            )
                    }
                )
                [ rangeArg_, rangeArg_0, rangeArg_1, rangeArg_2 ]
    , compare =
        \compareArg_ compareArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "compare"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Date" []
                                , Type.namedWith [ "Date" ] "Date" []
                                ]
                                (Type.namedWith [ "Basics" ] "Order" [])
                            )
                    }
                )
                [ compareArg_, compareArg_0 ]
    , isBetween =
        \isBetweenArg_ isBetweenArg_0 isBetweenArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "isBetween"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Date" []
                                , Type.namedWith [ "Date" ] "Date" []
                                , Type.namedWith [ "Date" ] "Date" []
                                ]
                                Type.bool
                            )
                    }
                )
                [ isBetweenArg_, isBetweenArg_0, isBetweenArg_1 ]
    , min =
        \minArg_ minArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "min"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Date" []
                                , Type.namedWith [ "Date" ] "Date" []
                                ]
                                (Type.namedWith [ "Date" ] "Date" [])
                            )
                    }
                )
                [ minArg_, minArg_0 ]
    , max =
        \maxArg_ maxArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "max"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Date" []
                                , Type.namedWith [ "Date" ] "Date" []
                                ]
                                (Type.namedWith [ "Date" ] "Date" [])
                            )
                    }
                )
                [ maxArg_, maxArg_0 ]
    , clamp =
        \clampArg_ clampArg_0 clampArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "clamp"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Date" []
                                , Type.namedWith [ "Date" ] "Date" []
                                , Type.namedWith [ "Date" ] "Date" []
                                ]
                                (Type.namedWith [ "Date" ] "Date" [])
                            )
                    }
                )
                [ clampArg_, clampArg_0, clampArg_1 ]
    , monthToNumber =
        \monthToNumberArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "monthToNumber"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Month" [] ]
                                Type.int
                            )
                    }
                )
                [ monthToNumberArg_ ]
    , numberToMonth =
        \numberToMonthArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "numberToMonth"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int ]
                                (Type.namedWith [ "Date" ] "Month" [])
                            )
                    }
                )
                [ numberToMonthArg_ ]
    , weekdayToNumber =
        \weekdayToNumberArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "weekdayToNumber"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Date" ] "Weekday" [] ]
                                Type.int
                            )
                    }
                )
                [ weekdayToNumberArg_ ]
    , numberToWeekday =
        \numberToWeekdayArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Date" ]
                    , name = "numberToWeekday"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int ]
                                (Type.namedWith [ "Date" ] "Weekday" [])
                            )
                    }
                )
                [ numberToWeekdayArg_ ]
    }
