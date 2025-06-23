module Gen.Time.Extra exposing
    ( moduleName_, partsToPosix, posixToParts, compare, diff, add
    , floor, ceiling, range, toOffset, annotation_, make_, caseOf_
    , call_, values_
    )

{-|
# Generated bindings for Time.Extra

@docs moduleName_, partsToPosix, posixToParts, compare, diff, add
@docs floor, ceiling, range, toOffset, annotation_, make_
@docs caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Time", "Extra" ]


{-| Create a `Posix` from a description of a time and a specific time zone.

    import Time exposing (Month(..), utc)
    import Time.Extra exposing (Parts, partsToPosix)

    partsToPosix utc (Parts 2018 Sep 26 14 30 0 0)

Any out-of-range day or time values will be clamped within range.

    partsToPosix utc (Parts 2018 Sep 31 24 60 -60 -500)
        == partsToPosix utc (Parts 2018 Sep 30 23 59 0 0)

partsToPosix: Time.Zone -> Time.Extra.Parts -> Time.Posix
-}
partsToPosix : Elm.Expression -> Elm.Expression -> Elm.Expression
partsToPosix partsToPosixArg_ partsToPosixArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time", "Extra" ]
             , name = "partsToPosix"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Time" ] "Zone" []
                          , Type.namedWith [ "Time", "Extra" ] "Parts" []
                          ]
                          (Type.namedWith [ "Time" ] "Posix" [])
                     )
             }
        )
        [ partsToPosixArg_, partsToPosixArg_0 ]


{-| Convert a `Posix` to a description of a time in a specific time zone. This
is a convenience function for extracting parts of a time into a single record.

    import Time exposing (Month(..), utc)
    import Time.Extra exposing (Parts, partsToPosix, posixToParts)

    posixToParts
        utc
        (partsToPosix utc (Parts 2018 Sep 26 14 30 0 0))
        == { year = 2018
           , month = Sep
           , day = 26
           , hour = 14
           , minute = 30
           , second = 0
           , millisecond = 0
           }

posixToParts: Time.Zone -> Time.Posix -> Time.Extra.Parts
-}
posixToParts : Elm.Expression -> Elm.Expression -> Elm.Expression
posixToParts posixToPartsArg_ posixToPartsArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time", "Extra" ]
             , name = "posixToParts"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Time" ] "Zone" []
                          , Type.namedWith [ "Time" ] "Posix" []
                          ]
                          (Type.namedWith [ "Time", "Extra" ] "Parts" [])
                     )
             }
        )
        [ posixToPartsArg_, posixToPartsArg_0 ]


{-| Compare the first time to the second time.

    import Time
    import Time.Extra as Time

    Time.compare (Time.millisToPosix 0) (Time.millisToPosix 1000)
        == LT

compare: Time.Posix -> Time.Posix -> Basics.Order
-}
compare : Elm.Expression -> Elm.Expression -> Elm.Expression
compare compareArg_ compareArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time", "Extra" ]
             , name = "compare"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Time" ] "Posix" []
                          , Type.namedWith [ "Time" ] "Posix" []
                          ]
                          (Type.namedWith [ "Basics" ] "Order" [])
                     )
             }
        )
        [ compareArg_, compareArg_0 ]


{-| Get the difference, as a number of whole intervals, between two times.

    import Time exposing (Month(..), utc)
    import Time.Extra exposing (Interval(..), Parts, partsToPosix, diff)

    diff Month utc
        (partsToPosix utc (Parts 2020 Jan 2 0 0 0 0))
        (partsToPosix utc (Parts 2020 Apr 1 0 0 0 0))
        == 2

diff: Time.Extra.Interval -> Time.Zone -> Time.Posix -> Time.Posix -> Int
-}
diff :
    Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
diff diffArg_ diffArg_0 diffArg_1 diffArg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time", "Extra" ]
             , name = "diff"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Time", "Extra" ] "Interval" []
                          , Type.namedWith [ "Time" ] "Zone" []
                          , Type.namedWith [ "Time" ] "Posix" []
                          , Type.namedWith [ "Time" ] "Posix" []
                          ]
                          Type.int
                     )
             }
        )
        [ diffArg_, diffArg_0, diffArg_1, diffArg_2 ]


{-| Shift a time into the past or future by adding a number of whole intervals.

    import Time exposing (Month(..), utc)
    import Time.Extra exposing (Interval(..), Parts, partsToPosix, add)

    add Week 2 utc (partsToPosix utc (Parts 2018 Sep 1 11 55 0 0))
        == partsToPosix utc (Parts 2018 Sep 15 11 55 0 0)

When adding `Month`, `Quarter`, or `Year` intervals, day values are clamped to
the end of the month if necessary.

    add Month 1 utc (partsToPosix utc (Parts 2020 Jan 31 0 0 0 0))
        == partsToPosix utc (Parts 2020 Feb 29 0 0 0 0)

add: Time.Extra.Interval -> Int -> Time.Zone -> Time.Posix -> Time.Posix
-}
add :
    Elm.Expression -> Int -> Elm.Expression -> Elm.Expression -> Elm.Expression
add addArg_ addArg_0 addArg_1 addArg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time", "Extra" ]
             , name = "add"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Time", "Extra" ] "Interval" []
                          , Type.int
                          , Type.namedWith [ "Time" ] "Zone" []
                          , Type.namedWith [ "Time" ] "Posix" []
                          ]
                          (Type.namedWith [ "Time" ] "Posix" [])
                     )
             }
        )
        [ addArg_, Elm.int addArg_0, addArg_1, addArg_2 ]


{-| Round down a time to the beginning of the closest interval. The resulting
time will be less than or equal to the one provided.

    import Time exposing (Month(..), utc)
    import Time.Extra exposing (Interval(..), Parts, partsToPosix, floor)

    floor Hour utc
        (partsToPosix utc (Parts 1999 Dec 31 23 59 59 999))
        == (partsToPosix utc (Parts 1999 Dec 31 23 0 0 0))

floor: Time.Extra.Interval -> Time.Zone -> Time.Posix -> Time.Posix
-}
floor : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
floor floorArg_ floorArg_0 floorArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time", "Extra" ]
             , name = "floor"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Time", "Extra" ] "Interval" []
                          , Type.namedWith [ "Time" ] "Zone" []
                          , Type.namedWith [ "Time" ] "Posix" []
                          ]
                          (Type.namedWith [ "Time" ] "Posix" [])
                     )
             }
        )
        [ floorArg_, floorArg_0, floorArg_1 ]


{-| Round up a time to the beginning of the closest interval. The resulting
time will be greater than or equal to the one provided.

    import Time exposing (Month(..), utc)
    import Time.Extra exposing (Interval(..), Parts, partsToPosix, ceiling)

    ceiling Hour utc
        (partsToPosix utc (Parts 1999 Dec 31 23 59 59 999))
        == (partsToPosix utc (Parts 2000 Jan 1 0 0 0 0))

ceiling: Time.Extra.Interval -> Time.Zone -> Time.Posix -> Time.Posix
-}
ceiling : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
ceiling ceilingArg_ ceilingArg_0 ceilingArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time", "Extra" ]
             , name = "ceiling"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Time", "Extra" ] "Interval" []
                          , Type.namedWith [ "Time" ] "Zone" []
                          , Type.namedWith [ "Time" ] "Posix" []
                          ]
                          (Type.namedWith [ "Time" ] "Posix" [])
                     )
             }
        )
        [ ceilingArg_, ceilingArg_0, ceilingArg_1 ]


{-| Create a list of times, at rounded intervals, increasing by a step value,
between two times. The list will start on or after the first time, and end
before the second time.

    import Time exposing (Month(..), utc)
    import Time.Extra exposing (Interval(..), Parts, partsToPosix, range)

    start = Parts 2020 Jan 1 12 0 0 0
    until = Parts 2020 Jan 8 0 0 0 0

    range Day 2 utc (partsToPosix utc start) (partsToPosix utc until)
        == List.map (partsToPosix utc)
            [ Parts 2020 Jan 2 0 0 0 0
            , Parts 2020 Jan 4 0 0 0 0
            , Parts 2020 Jan 6 0 0 0 0
            ]

range: 
    Time.Extra.Interval
    -> Int
    -> Time.Zone
    -> Time.Posix
    -> Time.Posix
    -> List Time.Posix
-}
range :
    Elm.Expression
    -> Int
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
range rangeArg_ rangeArg_0 rangeArg_1 rangeArg_2 rangeArg_3 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time", "Extra" ]
             , name = "range"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Time", "Extra" ] "Interval" []
                          , Type.int
                          , Type.namedWith [ "Time" ] "Zone" []
                          , Type.namedWith [ "Time" ] "Posix" []
                          , Type.namedWith [ "Time" ] "Posix" []
                          ]
                          (Type.list (Type.namedWith [ "Time" ] "Posix" []))
                     )
             }
        )
        [ rangeArg_, Elm.int rangeArg_0, rangeArg_1, rangeArg_2, rangeArg_3 ]


{-| What is the offset from UTC, in minutes, for this `Zone` at this
`Posix` time?

    import Time exposing (Month(..))
    import Time.Extra exposing (Parts, partsToPosix, toOffset)

    toOffset nyc
        (partsToPosix nyc (Parts 2018 Sep 26 10 30 0 0))
        == -240

    -- assuming `nyc` is a `Zone` for America/New_York

**Note:** It's possible to verify the example above by using time zone data
from the package [justinmimbs/timezone-data][tzdata] to define `nyc`:

    import TimeZone

    nyc =
        TimeZone.america__new_york ()

[tzdata]: https://package.elm-lang.org/packages/justinmimbs/timezone-data/latest/

toOffset: Time.Zone -> Time.Posix -> Int
-}
toOffset : Elm.Expression -> Elm.Expression -> Elm.Expression
toOffset toOffsetArg_ toOffsetArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time", "Extra" ]
             , name = "toOffset"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Time" ] "Zone" []
                          , Type.namedWith [ "Time" ] "Posix" []
                          ]
                          Type.int
                     )
             }
        )
        [ toOffsetArg_, toOffsetArg_0 ]


annotation_ : { parts : Type.Annotation, interval : Type.Annotation }
annotation_ =
    { parts =
        Type.alias
            moduleName_
            "Parts"
            []
            (Type.record
                 [ ( "year", Type.int )
                 , ( "month", Type.namedWith [ "Time" ] "Month" [] )
                 , ( "day", Type.int )
                 , ( "hour", Type.int )
                 , ( "minute", Type.int )
                 , ( "second", Type.int )
                 , ( "millisecond", Type.int )
                 ]
            )
    , interval = Type.namedWith [ "Time", "Extra" ] "Interval" []
    }


make_ :
    { parts :
        { year : Elm.Expression
        , month : Elm.Expression
        , day : Elm.Expression
        , hour : Elm.Expression
        , minute : Elm.Expression
        , second : Elm.Expression
        , millisecond : Elm.Expression
        }
        -> Elm.Expression
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
    , hour : Elm.Expression
    , minute : Elm.Expression
    , second : Elm.Expression
    , millisecond : Elm.Expression
    }
make_ =
    { parts =
        \parts_args ->
            Elm.withType
                (Type.alias
                     [ "Time", "Extra" ]
                     "Parts"
                     []
                     (Type.record
                          [ ( "year", Type.int )
                          , ( "month", Type.namedWith [ "Time" ] "Month" [] )
                          , ( "day", Type.int )
                          , ( "hour", Type.int )
                          , ( "minute", Type.int )
                          , ( "second", Type.int )
                          , ( "millisecond", Type.int )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "year" parts_args.year
                     , Tuple.pair "month" parts_args.month
                     , Tuple.pair "day" parts_args.day
                     , Tuple.pair "hour" parts_args.hour
                     , Tuple.pair "minute" parts_args.minute
                     , Tuple.pair "second" parts_args.second
                     , Tuple.pair "millisecond" parts_args.millisecond
                     ]
                )
    , year =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "Year"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , quarter =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "Quarter"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , month =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "Month"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , week =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "Week"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , monday =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "Monday"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , tuesday =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "Tuesday"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , wednesday =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "Wednesday"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , thursday =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "Thursday"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , friday =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "Friday"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , saturday =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "Saturday"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , sunday =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "Sunday"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , day =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "Day"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , hour =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "Hour"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , minute =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "Minute"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , second =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "Second"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    , millisecond =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "Millisecond"
            , annotation = Just (Type.namedWith [] "Interval" [])
            }
    }


caseOf_ :
    { interval :
        Elm.Expression
        -> { year : Elm.Expression
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
        , hour : Elm.Expression
        , minute : Elm.Expression
        , second : Elm.Expression
        , millisecond : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { interval =
        \intervalExpression intervalTags ->
            Elm.Case.custom
                intervalExpression
                (Type.namedWith [ "Time", "Extra" ] "Interval" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType "Year" intervalTags.year)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Quarter" intervalTags.quarter)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Month" intervalTags.month)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Week" intervalTags.week)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Monday" intervalTags.monday)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Tuesday" intervalTags.tuesday)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Wednesday" intervalTags.wednesday)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Thursday" intervalTags.thursday)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Friday" intervalTags.friday)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Saturday" intervalTags.saturday)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Sunday" intervalTags.sunday)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Day" intervalTags.day)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Hour" intervalTags.hour)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Minute" intervalTags.minute)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Second" intervalTags.second)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Millisecond" intervalTags.millisecond)
                    Basics.identity
                ]
    }


call_ :
    { partsToPosix : Elm.Expression -> Elm.Expression -> Elm.Expression
    , posixToParts : Elm.Expression -> Elm.Expression -> Elm.Expression
    , compare : Elm.Expression -> Elm.Expression -> Elm.Expression
    , diff :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , add :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , floor :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , ceiling :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , range :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , toOffset : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { partsToPosix =
        \partsToPosixArg_ partsToPosixArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time", "Extra" ]
                     , name = "partsToPosix"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Time" ] "Zone" []
                                  , Type.namedWith
                                      [ "Time", "Extra" ]
                                      "Parts"
                                      []
                                  ]
                                  (Type.namedWith [ "Time" ] "Posix" [])
                             )
                     }
                )
                [ partsToPosixArg_, partsToPosixArg_0 ]
    , posixToParts =
        \posixToPartsArg_ posixToPartsArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time", "Extra" ]
                     , name = "posixToParts"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Time" ] "Zone" []
                                  , Type.namedWith [ "Time" ] "Posix" []
                                  ]
                                  (Type.namedWith [ "Time", "Extra" ] "Parts" []
                                  )
                             )
                     }
                )
                [ posixToPartsArg_, posixToPartsArg_0 ]
    , compare =
        \compareArg_ compareArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time", "Extra" ]
                     , name = "compare"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Time" ] "Posix" []
                                  , Type.namedWith [ "Time" ] "Posix" []
                                  ]
                                  (Type.namedWith [ "Basics" ] "Order" [])
                             )
                     }
                )
                [ compareArg_, compareArg_0 ]
    , diff =
        \diffArg_ diffArg_0 diffArg_1 diffArg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time", "Extra" ]
                     , name = "diff"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Time", "Extra" ]
                                      "Interval"
                                      []
                                  , Type.namedWith [ "Time" ] "Zone" []
                                  , Type.namedWith [ "Time" ] "Posix" []
                                  , Type.namedWith [ "Time" ] "Posix" []
                                  ]
                                  Type.int
                             )
                     }
                )
                [ diffArg_, diffArg_0, diffArg_1, diffArg_2 ]
    , add =
        \addArg_ addArg_0 addArg_1 addArg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time", "Extra" ]
                     , name = "add"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Time", "Extra" ]
                                      "Interval"
                                      []
                                  , Type.int
                                  , Type.namedWith [ "Time" ] "Zone" []
                                  , Type.namedWith [ "Time" ] "Posix" []
                                  ]
                                  (Type.namedWith [ "Time" ] "Posix" [])
                             )
                     }
                )
                [ addArg_, addArg_0, addArg_1, addArg_2 ]
    , floor =
        \floorArg_ floorArg_0 floorArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time", "Extra" ]
                     , name = "floor"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Time", "Extra" ]
                                      "Interval"
                                      []
                                  , Type.namedWith [ "Time" ] "Zone" []
                                  , Type.namedWith [ "Time" ] "Posix" []
                                  ]
                                  (Type.namedWith [ "Time" ] "Posix" [])
                             )
                     }
                )
                [ floorArg_, floorArg_0, floorArg_1 ]
    , ceiling =
        \ceilingArg_ ceilingArg_0 ceilingArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time", "Extra" ]
                     , name = "ceiling"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Time", "Extra" ]
                                      "Interval"
                                      []
                                  , Type.namedWith [ "Time" ] "Zone" []
                                  , Type.namedWith [ "Time" ] "Posix" []
                                  ]
                                  (Type.namedWith [ "Time" ] "Posix" [])
                             )
                     }
                )
                [ ceilingArg_, ceilingArg_0, ceilingArg_1 ]
    , range =
        \rangeArg_ rangeArg_0 rangeArg_1 rangeArg_2 rangeArg_3 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time", "Extra" ]
                     , name = "range"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Time", "Extra" ]
                                      "Interval"
                                      []
                                  , Type.int
                                  , Type.namedWith [ "Time" ] "Zone" []
                                  , Type.namedWith [ "Time" ] "Posix" []
                                  , Type.namedWith [ "Time" ] "Posix" []
                                  ]
                                  (Type.list
                                       (Type.namedWith [ "Time" ] "Posix" [])
                                  )
                             )
                     }
                )
                [ rangeArg_, rangeArg_0, rangeArg_1, rangeArg_2, rangeArg_3 ]
    , toOffset =
        \toOffsetArg_ toOffsetArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time", "Extra" ]
                     , name = "toOffset"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Time" ] "Zone" []
                                  , Type.namedWith [ "Time" ] "Posix" []
                                  ]
                                  Type.int
                             )
                     }
                )
                [ toOffsetArg_, toOffsetArg_0 ]
    }


values_ :
    { partsToPosix : Elm.Expression
    , posixToParts : Elm.Expression
    , compare : Elm.Expression
    , diff : Elm.Expression
    , add : Elm.Expression
    , floor : Elm.Expression
    , ceiling : Elm.Expression
    , range : Elm.Expression
    , toOffset : Elm.Expression
    }
values_ =
    { partsToPosix =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "partsToPosix"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time" ] "Zone" []
                         , Type.namedWith [ "Time", "Extra" ] "Parts" []
                         ]
                         (Type.namedWith [ "Time" ] "Posix" [])
                    )
            }
    , posixToParts =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "posixToParts"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time" ] "Zone" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                         (Type.namedWith [ "Time", "Extra" ] "Parts" [])
                    )
            }
    , compare =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "compare"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time" ] "Posix" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                         (Type.namedWith [ "Basics" ] "Order" [])
                    )
            }
    , diff =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "diff"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time", "Extra" ] "Interval" []
                         , Type.namedWith [ "Time" ] "Zone" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                         Type.int
                    )
            }
    , add =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "add"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time", "Extra" ] "Interval" []
                         , Type.int
                         , Type.namedWith [ "Time" ] "Zone" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                         (Type.namedWith [ "Time" ] "Posix" [])
                    )
            }
    , floor =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "floor"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time", "Extra" ] "Interval" []
                         , Type.namedWith [ "Time" ] "Zone" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                         (Type.namedWith [ "Time" ] "Posix" [])
                    )
            }
    , ceiling =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "ceiling"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time", "Extra" ] "Interval" []
                         , Type.namedWith [ "Time" ] "Zone" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                         (Type.namedWith [ "Time" ] "Posix" [])
                    )
            }
    , range =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "range"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time", "Extra" ] "Interval" []
                         , Type.int
                         , Type.namedWith [ "Time" ] "Zone" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                         (Type.list (Type.namedWith [ "Time" ] "Posix" []))
                    )
            }
    , toOffset =
        Elm.value
            { importFrom = [ "Time", "Extra" ]
            , name = "toOffset"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time" ] "Zone" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                         Type.int
                    )
            }
    }