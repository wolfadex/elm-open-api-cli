module Gen.Date exposing (add, annotation_, call_, caseOf_, ceiling, clamp, compare, day, diff, floor, format, formatWithLanguage, fromCalendarDate, fromIsoString, fromOrdinalDate, fromPosix, fromRataDie, fromWeekDate, isBetween, make_, max, min, moduleName_, month, monthNumber, monthToNumber, numberToMonth, numberToWeekday, ordinalDay, quarter, range, toIsoString, toRataDie, today, values_, weekNumber, weekYear, weekday, weekdayNumber, weekdayToNumber, withOrdinalSuffix, year)

{-| 
@docs moduleName_, today, fromPosix, fromCalendarDate, fromWeekDate, fromOrdinalDate, fromIsoString, fromRataDie, toIsoString, toRataDie, year, month, day, weekYear, weekNumber, weekday, ordinalDay, quarter, monthNumber, weekdayNumber, format, withOrdinalSuffix, formatWithLanguage, add, diff, ceiling, floor, range, compare, isBetween, min, max, clamp, monthToNumber, numberToMonth, weekdayToNumber, numberToWeekday, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Date" ]


{-| Get the current local date. See [this page][calendarexample] for a full example.

[calendarexample]: https://github.com/justinmimbs/date/blob/master/examples/Calendar.elm

today: Task.Task x Date.Date
-}
today : Elm.Expression
today =
    Elm.value
        { importFrom = [ "Date" ]
        , name = "today"
        , annotation =
            Just
                (Type.namedWith
                     [ "Task" ]
                     "Task"
                     [ Type.var "x", Type.namedWith [ "Date" ] "Date" [] ]
                )
        }


{-| Create a date from a time [`Zone`][zone] and a [`Posix`][posix] time. This
conversion loses the time information associated with the `Posix` value.

    import Date exposing (fromCalendarDate, fromPosix)
    import Time exposing (millisToPosix, utc, Month(..))

    fromPosix utc (millisToPosix 0)
        == fromCalendarDate 1970 Jan 1

[zone]: https://package.elm-lang.org/packages/elm/time/latest/Time#Zone
[posix]: https://package.elm-lang.org/packages/elm/time/latest/Time#Posix

fromPosix: Time.Zone -> Time.Posix -> Date.Date
-}
fromPosix : Elm.Expression -> Elm.Expression -> Elm.Expression
fromPosix fromPosixArg fromPosixArg0 =
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
        [ fromPosixArg, fromPosixArg0 ]


{-| Create a date from a [calendar date][gregorian]: a year, month, and day of
the month. Out-of-range day values will be clamped.

    import Date exposing (fromCalendarDate)
    import Time exposing (Month(..))

    fromCalendarDate 2018 Sep 26

[gregorian]: https://en.wikipedia.org/wiki/Proleptic_Gregorian_calendar

fromCalendarDate: Int -> Date.Month -> Int -> Date.Date
-}
fromCalendarDate : Int -> Elm.Expression -> Int -> Elm.Expression
fromCalendarDate fromCalendarDateArg fromCalendarDateArg0 fromCalendarDateArg1 =
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
        [ Elm.int fromCalendarDateArg
        , fromCalendarDateArg0
        , Elm.int fromCalendarDateArg1
        ]


{-| Create a date from an [ISO week date][weekdate]: a week-numbering year,
week number, and weekday. Out-of-range week number values will be clamped.

    import Date exposing (fromWeekDate)
    import Time exposing (Weekday(..))

    fromWeekDate 2018 39 Wed

[weekdate]: https://en.wikipedia.org/wiki/ISO_week_date

fromWeekDate: Int -> Int -> Date.Weekday -> Date.Date
-}
fromWeekDate : Int -> Int -> Elm.Expression -> Elm.Expression
fromWeekDate fromWeekDateArg fromWeekDateArg0 fromWeekDateArg1 =
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
        [ Elm.int fromWeekDateArg, Elm.int fromWeekDateArg0, fromWeekDateArg1 ]


{-| Create a date from an [ordinal date][ordinaldate]: a year and day of the
year. Out-of-range day values will be clamped.

    import Date exposing (fromOrdinalDate)

    fromOrdinalDate 2018 269

[ordinaldate]: https://en.wikipedia.org/wiki/Ordinal_date

fromOrdinalDate: Int -> Int -> Date.Date
-}
fromOrdinalDate : Int -> Int -> Elm.Expression
fromOrdinalDate fromOrdinalDateArg fromOrdinalDateArg0 =
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
        [ Elm.int fromOrdinalDateArg, Elm.int fromOrdinalDateArg0 ]


{-| Attempt to create a date from a string in [ISO 8601][iso8601] format.
Calendar dates, week dates, and ordinal dates are all supported in extended
and basic format.

    import Date exposing (fromIsoString, fromCalendarDate, fromWeekDate, fromOrdinalDate)
    import Time exposing (Month(..), Weekday(..))

    -- calendar date
    fromIsoString "2018-09-26"
        == Ok (fromCalendarDate 2018 Sep 26)


    -- week date
    fromIsoString "2018-W39-3"
        == Ok (fromWeekDate 2018 39 Wed)


    -- ordinal date
    fromIsoString "2018-269"
        == Ok (fromOrdinalDate 2018 269)

The string must represent a valid date; unlike `fromCalendarDate` and
friends, any out-of-range values will fail to produce a date.

    fromIsoString "2018-02-29"
        == Err "Invalid calendar date (2018, 2, 29)"

[iso8601]: https://en.wikipedia.org/wiki/ISO_8601

fromIsoString: String -> Result.Result String Date.Date
-}
fromIsoString : String -> Elm.Expression
fromIsoString fromIsoStringArg =
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
        [ Elm.string fromIsoStringArg ]


{-| [Rata Die][ratadie] is a system for assigning numbers to calendar days,
where the number 1 represents the date _1 January 0001_.

You can losslessly convert a `Date` to and from an `Int` representing the date
in Rata Die. This makes it a convenient representation for transporting dates
or using them as comparables. For all date values:

    (date |> toRataDie |> fromRataDie)
        == date

[ratadie]: https://en.wikipedia.org/wiki/Rata_Die

fromRataDie: Int -> Date.Date
-}
fromRataDie : Int -> Elm.Expression
fromRataDie fromRataDieArg =
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
        [ Elm.int fromRataDieArg ]


{-| Convert a date to a string in ISO 8601 extended format.

    import Date exposing (fromOrdinalDate, toIsoString)

    toIsoString (fromOrdinalDate 2001 1)
        == "2001-01-01"

toIsoString: Date.Date -> String
-}
toIsoString : Elm.Expression -> Elm.Expression
toIsoString toIsoStringArg =
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
        [ toIsoStringArg ]


{-| Convert a date to its number representation in Rata Die (see
[`fromRataDie`](#fromRataDie)). For all date values:

    (date |> toRataDie |> fromRataDie)
        == date

toRataDie: Date.Date -> Int
-}
toRataDie : Elm.Expression -> Elm.Expression
toRataDie toRataDieArg =
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
        [ toRataDieArg ]


{-| The calendar year.

year: Date.Date -> Int
-}
year : Elm.Expression -> Elm.Expression
year yearArg =
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
        [ yearArg ]


{-| The month as a [`Month`](https://package.elm-lang.org/packages/elm/time/latest/Time#Month)
value (`Jan`–`Dec`).

month: Date.Date -> Date.Month
-}
month : Elm.Expression -> Elm.Expression
month monthArg =
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
        [ monthArg ]


{-| The day of the month (1–31).

day: Date.Date -> Int
-}
day : Elm.Expression -> Elm.Expression
day dayArg =
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
        [ dayArg ]


{-| The ISO week-numbering year. This is not always the same as the
calendar year.

weekYear: Date.Date -> Int
-}
weekYear : Elm.Expression -> Elm.Expression
weekYear weekYearArg =
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
        [ weekYearArg ]


{-| The ISO week number of the year (1–53).

weekNumber: Date.Date -> Int
-}
weekNumber : Elm.Expression -> Elm.Expression
weekNumber weekNumberArg =
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
        [ weekNumberArg ]


{-| The weekday as a [`Weekday`](https://package.elm-lang.org/packages/elm/time/latest/Time#Weekday)
value (`Mon`–`Sun`).

weekday: Date.Date -> Date.Weekday
-}
weekday : Elm.Expression -> Elm.Expression
weekday weekdayArg =
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
        [ weekdayArg ]


{-| The day of the year (1–366).

ordinalDay: Date.Date -> Int
-}
ordinalDay : Elm.Expression -> Elm.Expression
ordinalDay ordinalDayArg =
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
        [ ordinalDayArg ]


{-| The quarter of the year (1–4).

quarter: Date.Date -> Int
-}
quarter : Elm.Expression -> Elm.Expression
quarter quarterArg =
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
        [ quarterArg ]


{-| The month number (1–12).

monthNumber: Date.Date -> Int
-}
monthNumber : Elm.Expression -> Elm.Expression
monthNumber monthNumberArg =
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
        [ monthNumberArg ]


{-| The weekday number (1–7), beginning with Monday.

weekdayNumber: Date.Date -> Int
-}
weekdayNumber : Elm.Expression -> Elm.Expression
weekdayNumber weekdayNumberArg =
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
        [ weekdayNumberArg ]


{-| Format a date using a string as a template.

    import Date exposing (fromOrdinalDate, format)

    format "EEEE, d MMMM y" (fromOrdinalDate 1970 1)
        == "Thursday, 1 January 1970"

Alphabetic characters in the template represent date information; the number of
times a character is repeated specifies the form of a name (e.g. `"Tue"`,
`"Tuesday"`) or the padding of a number (e.g. `"1"`, `"01"`).

Alphabetic characters can be escaped within single-quotes; a single-quote can
be escaped as a sequence of two single-quotes, whether appearing inside or
outside an escaped sequence.

Templates are based on Date Format Patterns in [Unicode Technical
Standard #35][uts35]. Only the following subset of formatting characters
are available:

    "y" -- year

    "Y" -- week-numbering year

    "Q" -- quarter

    "M" -- month (number or name)

    "w" -- week number

    "d" -- day

    "D" -- ordinal day

    "E" -- weekday name

    "e" -- weekday number

[uts35]: http://www.unicode.org/reports/tr35/tr35-43/tr35-dates.html#Date_Format_Patterns

The non-standard pattern field "ddd" is available to indicate the day of the
month with an ordinal suffix (e.g. `"1st"`, `"15th"`), as the current standard
does not include such a field.

    format "MMMM ddd, y" (fromOrdinalDate 1970 1)
        == "January 1st, 1970"

format: String -> Date.Date -> String
-}
format : String -> Elm.Expression -> Elm.Expression
format formatArg formatArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Date" ]
             , name = "format"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string, Type.namedWith [ "Date" ] "Date" [] ]
                          Type.string
                     )
             }
        )
        [ Elm.string formatArg, formatArg0 ]


{-| Convert an integer into an English ordinal number string (like `"4th"`).

    import Date exposing (withOrdinalSuffix)

    withOrdinalSuffix 21 == "21st"
    withOrdinalSuffix 42 == "42nd"
    withOrdinalSuffix 0 == "0th"
    withOrdinalSuffix 23 == "23rd"
    withOrdinalSuffix -1 == "-1st"

withOrdinalSuffix: Int -> String
-}
withOrdinalSuffix : Int -> Elm.Expression
withOrdinalSuffix withOrdinalSuffixArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Date" ]
             , name = "withOrdinalSuffix"
             , annotation = Just (Type.function [ Type.int ] Type.string)
             }
        )
        [ Elm.int withOrdinalSuffixArg ]


{-| Format a date in a custom language using a string as a template.

    import Date exposing (fromOrdinalDate, formatWithLanguage)

    formatWithLanguage fr "EEEE, ddd MMMM y" (fromOrdinalDate 1970 1)
        == "jeudi, 1er janvier 1970"

    -- assuming `fr` is a custom `Date.Language`

formatWithLanguage: Date.Language -> String -> Date.Date -> String
-}
formatWithLanguage :
    Elm.Expression -> String -> Elm.Expression -> Elm.Expression
formatWithLanguage formatWithLanguageArg formatWithLanguageArg0 formatWithLanguageArg1 =
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
        [ formatWithLanguageArg
        , Elm.string formatWithLanguageArg0
        , formatWithLanguageArg1
        ]


{-| Get a past or future date by adding a number of units to a date.

    import Date exposing (Unit(..), add, fromCalendarDate)
    import Time exposing (Month(..))

    add Weeks -2 (fromCalendarDate 2018 Sep 26)
        == fromCalendarDate 2018 Sep 12

When adding `Years` or `Months`, day values are clamped to the end of the
month if necessary.

    add Months 1 (fromCalendarDate 2000 Jan 31)
        == fromCalendarDate 2000 Feb 29

add: Date.Unit -> Int -> Date.Date -> Date.Date
-}
add : Elm.Expression -> Int -> Elm.Expression -> Elm.Expression
add addArg addArg0 addArg1 =
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
        [ addArg, Elm.int addArg0, addArg1 ]


{-| Get the difference, as a number of whole units, between two dates.

    import Date exposing (Unit(..), diff, fromCalendarDate)
    import Time exposing (Month(..))

    diff Months
        (fromCalendarDate 2020 Jan 2)
        (fromCalendarDate 2020 Apr 1)
        == 2

diff: Date.Unit -> Date.Date -> Date.Date -> Int
-}
diff : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
diff diffArg diffArg0 diffArg1 =
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
        [ diffArg, diffArg0, diffArg1 ]


{-| Round up a date to the beginning of the closest interval. The resulting
date will be greater than or equal to the one provided.

    import Date exposing (Interval(..), ceiling, fromCalendarDate)
    import Time exposing (Month(..))

    ceiling Tuesday (fromCalendarDate 2018 May 11)
        == fromCalendarDate 2018 May 15

ceiling: Date.Interval -> Date.Date -> Date.Date
-}
ceiling : Elm.Expression -> Elm.Expression -> Elm.Expression
ceiling ceilingArg ceilingArg0 =
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
        [ ceilingArg, ceilingArg0 ]


{-| Round down a date to the beginning of the closest interval. The resulting
date will be less than or equal to the one provided.

    import Date exposing (Interval(..), floor, fromCalendarDate)
    import Time exposing (Month(..))

    floor Tuesday (fromCalendarDate 2018 May 11)
        == fromCalendarDate 2018 May 8

floor: Date.Interval -> Date.Date -> Date.Date
-}
floor : Elm.Expression -> Elm.Expression -> Elm.Expression
floor floorArg floorArg0 =
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
        [ floorArg, floorArg0 ]


{-| Create a list of dates, at rounded intervals, increasing by a step value,
between two dates. The list will start on or after the first date, and end
before the second date.

    import Date exposing (Interval(..), range, fromCalendarDate)
    import Time exposing (Month(..))

    start = fromCalendarDate 2018 May 8
    until = fromCalendarDate 2018 May 14

    range Day 2 start until
        == [ fromCalendarDate 2018 May 8
           , fromCalendarDate 2018 May 10
           , fromCalendarDate 2018 May 12
           ]

range: Date.Interval -> Int -> Date.Date -> Date.Date -> List Date.Date
-}
range :
    Elm.Expression -> Int -> Elm.Expression -> Elm.Expression -> Elm.Expression
range rangeArg rangeArg0 rangeArg1 rangeArg2 =
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
                          (Type.list (Type.namedWith [ "Date" ] "Date" []))
                     )
             }
        )
        [ rangeArg, Elm.int rangeArg0, rangeArg1, rangeArg2 ]


{-| Compare two dates. This can be used as the compare function for
`List.sortWith`.

    import Date exposing (fromOrdinalDate, compare)

    compare (fromOrdinalDate 1970 1) (fromOrdinalDate 2038 1)
        == LT

compare: Date.Date -> Date.Date -> Basics.Order
-}
compare : Elm.Expression -> Elm.Expression -> Elm.Expression
compare compareArg compareArg0 =
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
        [ compareArg, compareArg0 ]


{-| Test if a date is within a range, inclusive of the range values.

    import Date exposing (fromOrdinalDate, isBetween)

    minimum = fromOrdinalDate 1970 1
    maximum = fromOrdinalDate 2038 1

    isBetween minimum maximum (fromOrdinalDate 1969 201)
        == False

isBetween: Date.Date -> Date.Date -> Date.Date -> Bool
-}
isBetween : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
isBetween isBetweenArg isBetweenArg0 isBetweenArg1 =
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
        [ isBetweenArg, isBetweenArg0, isBetweenArg1 ]


{-| Find the lesser of two dates.

    import Date exposing (fromOrdinalDate, min)

    min (fromOrdinalDate 1970 1) (fromOrdinalDate 2038 1)
        == (fromOrdinalDate 1970 1)

min: Date.Date -> Date.Date -> Date.Date
-}
min : Elm.Expression -> Elm.Expression -> Elm.Expression
min minArg minArg0 =
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
        [ minArg, minArg0 ]


{-| Find the greater of two dates.

    import Date exposing (fromOrdinalDate, max)

    max (fromOrdinalDate 1970 1) (fromOrdinalDate 2038 1)
        == (fromOrdinalDate 2038 1)

max: Date.Date -> Date.Date -> Date.Date
-}
max : Elm.Expression -> Elm.Expression -> Elm.Expression
max maxArg maxArg0 =
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
        [ maxArg, maxArg0 ]


{-| Clamp a date within a range.

    import Date exposing (fromOrdinalDate, clamp)

    minimum = fromOrdinalDate 1970 1
    maximum = fromOrdinalDate 2038 1

    clamp minimum maximum (fromOrdinalDate 1969 201)
        == fromOrdinalDate 1970 1

clamp: Date.Date -> Date.Date -> Date.Date -> Date.Date
-}
clamp : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
clamp clampArg clampArg0 clampArg1 =
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
        [ clampArg, clampArg0, clampArg1 ]


{-| Maps `Jan`–`Dec` to 1–12.

monthToNumber: Date.Month -> Int
-}
monthToNumber : Elm.Expression -> Elm.Expression
monthToNumber monthToNumberArg =
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
        [ monthToNumberArg ]


{-| Maps 1–12 to `Jan`–`Dec`.

numberToMonth: Int -> Date.Month
-}
numberToMonth : Int -> Elm.Expression
numberToMonth numberToMonthArg =
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
        [ Elm.int numberToMonthArg ]


{-| Maps `Mon`–`Sun` to 1-7.

weekdayToNumber: Date.Weekday -> Int
-}
weekdayToNumber : Elm.Expression -> Elm.Expression
weekdayToNumber weekdayToNumberArg =
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
        [ weekdayToNumberArg ]


{-| Maps 1-7 to `Mon`–`Sun`.

numberToWeekday: Int -> Date.Weekday
-}
numberToWeekday : Int -> Elm.Expression
numberToWeekday numberToWeekdayArg =
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
        [ Elm.int numberToWeekdayArg ]


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


make_ :
    { language :
        { monthName : Elm.Expression
        , monthNameShort : Elm.Expression
        , weekdayName : Elm.Expression
        , weekdayNameShort : Elm.Expression
        , dayWithSuffix : Elm.Expression
        }
        -> Elm.Expression
    , years : Elm.Expression
    , months : Elm.Expression
    , weeks : Elm.Expression
    , days : Elm.Expression
    , year : Elm.Expression
    , quarter : Elm.Expression
    , month : Elm.Expression
    , week : Elm.Expression
    , monday : Elm.Expression
    , tuesday : Elm.Expression
    , wednesday : Elm.Expression
    , thursday : Elm.Expression
    , friday : Elm.Expression
    , saturday : Elm.Expression
    , sunday : Elm.Expression
    , day : Elm.Expression
    }
make_ =
    { language =
        \language_args ->
            Elm.withType
                (Type.alias
                     [ "Date" ]
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
                          , ( "dayWithSuffix"
                            , Type.function [ Type.int ] Type.string
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "monthName" language_args.monthName
                     , Tuple.pair "monthNameShort" language_args.monthNameShort
                     , Tuple.pair "weekdayName" language_args.weekdayName
                     , Tuple.pair
                         "weekdayNameShort"
                         language_args.weekdayNameShort
                     , Tuple.pair "dayWithSuffix" language_args.dayWithSuffix
                     ]
                )
    , years =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "Years"
            , annotation = Just (Type.namedWith [] "Unit" [])
            }
    , months =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "Months"
            , annotation = Just (Type.namedWith [] "Unit" [])
            }
    , weeks =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "Weeks"
            , annotation = Just (Type.namedWith [] "Unit" [])
            }
    , days =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "Days"
            , annotation = Just (Type.namedWith [] "Unit" [])
            }
    , year =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "Year"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , quarter =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "Quarter"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , month =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "Month"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , week =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "Week"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , monday =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "Monday"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , tuesday =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "Tuesday"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , wednesday =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "Wednesday"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , thursday =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "Thursday"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , friday =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "Friday"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , saturday =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "Saturday"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , sunday =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "Sunday"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , day =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "Day"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    }


caseOf_ :
    { unit :
        Elm.Expression
        -> { unitTags_0_0
            | years : Elm.Expression
            , months : Elm.Expression
            , weeks : Elm.Expression
            , days : Elm.Expression
        }
        -> Elm.Expression
    , interval :
        Elm.Expression
        -> { intervalTags_1_0
            | year : Elm.Expression
            , quarter : Elm.Expression
            , month : Elm.Expression
            , week : Elm.Expression
            , monday : Elm.Expression
            , tuesday : Elm.Expression
            , wednesday : Elm.Expression
            , thursday : Elm.Expression
            , friday : Elm.Expression
            , saturday : Elm.Expression
            , sunday : Elm.Expression
            , day : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { unit =
        \unitExpression unitTags ->
            Elm.Case.custom
                unitExpression
                (Type.namedWith [ "Date" ] "Unit" [])
                [ Elm.Case.branch0 "Years" unitTags.years
                , Elm.Case.branch0 "Months" unitTags.months
                , Elm.Case.branch0 "Weeks" unitTags.weeks
                , Elm.Case.branch0 "Days" unitTags.days
                ]
    , interval =
        \intervalExpression intervalTags ->
            Elm.Case.custom
                intervalExpression
                (Type.namedWith [ "Date" ] "Interval" [])
                [ Elm.Case.branch0 "Year" intervalTags.year
                , Elm.Case.branch0 "Quarter" intervalTags.quarter
                , Elm.Case.branch0 "Month" intervalTags.month
                , Elm.Case.branch0 "Week" intervalTags.week
                , Elm.Case.branch0 "Monday" intervalTags.monday
                , Elm.Case.branch0 "Tuesday" intervalTags.tuesday
                , Elm.Case.branch0 "Wednesday" intervalTags.wednesday
                , Elm.Case.branch0 "Thursday" intervalTags.thursday
                , Elm.Case.branch0 "Friday" intervalTags.friday
                , Elm.Case.branch0 "Saturday" intervalTags.saturday
                , Elm.Case.branch0 "Sunday" intervalTags.sunday
                , Elm.Case.branch0 "Day" intervalTags.day
                ]
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
        \fromPosixArg fromPosixArg0 ->
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
                [ fromPosixArg, fromPosixArg0 ]
    , fromCalendarDate =
        \fromCalendarDateArg fromCalendarDateArg0 fromCalendarDateArg1 ->
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
                [ fromCalendarDateArg
                , fromCalendarDateArg0
                , fromCalendarDateArg1
                ]
    , fromWeekDate =
        \fromWeekDateArg fromWeekDateArg0 fromWeekDateArg1 ->
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
                [ fromWeekDateArg, fromWeekDateArg0, fromWeekDateArg1 ]
    , fromOrdinalDate =
        \fromOrdinalDateArg fromOrdinalDateArg0 ->
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
                [ fromOrdinalDateArg, fromOrdinalDateArg0 ]
    , fromIsoString =
        \fromIsoStringArg ->
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
                [ fromIsoStringArg ]
    , fromRataDie =
        \fromRataDieArg ->
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
                [ fromRataDieArg ]
    , toIsoString =
        \toIsoStringArg ->
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
                [ toIsoStringArg ]
    , toRataDie =
        \toRataDieArg ->
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
                [ toRataDieArg ]
    , year =
        \yearArg ->
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
                [ yearArg ]
    , month =
        \monthArg ->
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
                [ monthArg ]
    , day =
        \dayArg ->
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
                [ dayArg ]
    , weekYear =
        \weekYearArg ->
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
                [ weekYearArg ]
    , weekNumber =
        \weekNumberArg ->
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
                [ weekNumberArg ]
    , weekday =
        \weekdayArg ->
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
                [ weekdayArg ]
    , ordinalDay =
        \ordinalDayArg ->
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
                [ ordinalDayArg ]
    , quarter =
        \quarterArg ->
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
                [ quarterArg ]
    , monthNumber =
        \monthNumberArg ->
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
                [ monthNumberArg ]
    , weekdayNumber =
        \weekdayNumberArg ->
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
                [ weekdayNumberArg ]
    , format =
        \formatArg formatArg0 ->
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
                [ formatArg, formatArg0 ]
    , withOrdinalSuffix =
        \withOrdinalSuffixArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Date" ]
                     , name = "withOrdinalSuffix"
                     , annotation =
                         Just (Type.function [ Type.int ] Type.string)
                     }
                )
                [ withOrdinalSuffixArg ]
    , formatWithLanguage =
        \formatWithLanguageArg formatWithLanguageArg0 formatWithLanguageArg1 ->
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
                [ formatWithLanguageArg
                , formatWithLanguageArg0
                , formatWithLanguageArg1
                ]
    , add =
        \addArg addArg0 addArg1 ->
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
                [ addArg, addArg0, addArg1 ]
    , diff =
        \diffArg diffArg0 diffArg1 ->
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
                [ diffArg, diffArg0, diffArg1 ]
    , ceiling =
        \ceilingArg ceilingArg0 ->
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
                [ ceilingArg, ceilingArg0 ]
    , floor =
        \floorArg floorArg0 ->
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
                [ floorArg, floorArg0 ]
    , range =
        \rangeArg rangeArg0 rangeArg1 rangeArg2 ->
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
                [ rangeArg, rangeArg0, rangeArg1, rangeArg2 ]
    , compare =
        \compareArg compareArg0 ->
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
                [ compareArg, compareArg0 ]
    , isBetween =
        \isBetweenArg isBetweenArg0 isBetweenArg1 ->
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
                [ isBetweenArg, isBetweenArg0, isBetweenArg1 ]
    , min =
        \minArg minArg0 ->
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
                [ minArg, minArg0 ]
    , max =
        \maxArg maxArg0 ->
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
                [ maxArg, maxArg0 ]
    , clamp =
        \clampArg clampArg0 clampArg1 ->
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
                [ clampArg, clampArg0, clampArg1 ]
    , monthToNumber =
        \monthToNumberArg ->
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
                [ monthToNumberArg ]
    , numberToMonth =
        \numberToMonthArg ->
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
                [ numberToMonthArg ]
    , weekdayToNumber =
        \weekdayToNumberArg ->
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
                [ weekdayToNumberArg ]
    , numberToWeekday =
        \numberToWeekdayArg ->
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
                [ numberToWeekdayArg ]
    }


values_ :
    { today : Elm.Expression
    , fromPosix : Elm.Expression
    , fromCalendarDate : Elm.Expression
    , fromWeekDate : Elm.Expression
    , fromOrdinalDate : Elm.Expression
    , fromIsoString : Elm.Expression
    , fromRataDie : Elm.Expression
    , toIsoString : Elm.Expression
    , toRataDie : Elm.Expression
    , year : Elm.Expression
    , month : Elm.Expression
    , day : Elm.Expression
    , weekYear : Elm.Expression
    , weekNumber : Elm.Expression
    , weekday : Elm.Expression
    , ordinalDay : Elm.Expression
    , quarter : Elm.Expression
    , monthNumber : Elm.Expression
    , weekdayNumber : Elm.Expression
    , format : Elm.Expression
    , withOrdinalSuffix : Elm.Expression
    , formatWithLanguage : Elm.Expression
    , add : Elm.Expression
    , diff : Elm.Expression
    , ceiling : Elm.Expression
    , floor : Elm.Expression
    , range : Elm.Expression
    , compare : Elm.Expression
    , isBetween : Elm.Expression
    , min : Elm.Expression
    , max : Elm.Expression
    , clamp : Elm.Expression
    , monthToNumber : Elm.Expression
    , numberToMonth : Elm.Expression
    , weekdayToNumber : Elm.Expression
    , numberToWeekday : Elm.Expression
    }
values_ =
    { today =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "today"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Task" ]
                         "Task"
                         [ Type.var "x", Type.namedWith [ "Date" ] "Date" [] ]
                    )
            }
    , fromPosix =
        Elm.value
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
    , fromCalendarDate =
        Elm.value
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
    , fromWeekDate =
        Elm.value
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
    , fromOrdinalDate =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "fromOrdinalDate"
            , annotation =
                Just
                    (Type.function
                         [ Type.int, Type.int ]
                         (Type.namedWith [ "Date" ] "Date" [])
                    )
            }
    , fromIsoString =
        Elm.value
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
    , fromRataDie =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "fromRataDie"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith [ "Date" ] "Date" [])
                    )
            }
    , toIsoString =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "toIsoString"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Date" ] "Date" [] ]
                         Type.string
                    )
            }
    , toRataDie =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "toRataDie"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Date" ] "Date" [] ]
                         Type.int
                    )
            }
    , year =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "year"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Date" ] "Date" [] ]
                         Type.int
                    )
            }
    , month =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "month"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Date" ] "Date" [] ]
                         (Type.namedWith [ "Date" ] "Month" [])
                    )
            }
    , day =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "day"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Date" ] "Date" [] ]
                         Type.int
                    )
            }
    , weekYear =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "weekYear"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Date" ] "Date" [] ]
                         Type.int
                    )
            }
    , weekNumber =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "weekNumber"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Date" ] "Date" [] ]
                         Type.int
                    )
            }
    , weekday =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "weekday"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Date" ] "Date" [] ]
                         (Type.namedWith [ "Date" ] "Weekday" [])
                    )
            }
    , ordinalDay =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "ordinalDay"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Date" ] "Date" [] ]
                         Type.int
                    )
            }
    , quarter =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "quarter"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Date" ] "Date" [] ]
                         Type.int
                    )
            }
    , monthNumber =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "monthNumber"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Date" ] "Date" [] ]
                         Type.int
                    )
            }
    , weekdayNumber =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "weekdayNumber"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Date" ] "Date" [] ]
                         Type.int
                    )
            }
    , format =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "format"
            , annotation =
                Just
                    (Type.function
                         [ Type.string, Type.namedWith [ "Date" ] "Date" [] ]
                         Type.string
                    )
            }
    , withOrdinalSuffix =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "withOrdinalSuffix"
            , annotation = Just (Type.function [ Type.int ] Type.string)
            }
    , formatWithLanguage =
        Elm.value
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
    , add =
        Elm.value
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
    , diff =
        Elm.value
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
    , ceiling =
        Elm.value
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
    , floor =
        Elm.value
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
    , range =
        Elm.value
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
                         (Type.list (Type.namedWith [ "Date" ] "Date" []))
                    )
            }
    , compare =
        Elm.value
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
    , isBetween =
        Elm.value
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
    , min =
        Elm.value
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
    , max =
        Elm.value
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
    , clamp =
        Elm.value
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
    , monthToNumber =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "monthToNumber"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Date" ] "Month" [] ]
                         Type.int
                    )
            }
    , numberToMonth =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "numberToMonth"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith [ "Date" ] "Month" [])
                    )
            }
    , weekdayToNumber =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "weekdayToNumber"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Date" ] "Weekday" [] ]
                         Type.int
                    )
            }
    , numberToWeekday =
        Elm.value
            { importFrom = [ "Date" ]
            , name = "numberToWeekday"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith [ "Date" ] "Weekday" [])
                    )
            }
    }