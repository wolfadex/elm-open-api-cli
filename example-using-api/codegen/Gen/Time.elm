module Gen.Time exposing
    ( moduleName_, now, every, posixToMillis, millisToPosix, utc
    , here, toYear, toMonth, toDay, toWeekday, toHour, toMinute
    , toSecond, toMillis, customZone, getZoneName, annotation_, make_, caseOf_
    , call_, values_
    )

{-|
# Generated bindings for Time

@docs moduleName_, now, every, posixToMillis, millisToPosix, utc
@docs here, toYear, toMonth, toDay, toWeekday, toHour
@docs toMinute, toSecond, toMillis, customZone, getZoneName, annotation_
@docs make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Time" ]


{-| Get the POSIX time at the moment when this task is run.

now: Task.Task x Time.Posix
-}
now : Elm.Expression
now =
    Elm.value
        { importFrom = [ "Time" ]
        , name = "now"
        , annotation =
            Just
                (Type.namedWith
                     [ "Task" ]
                     "Task"
                     [ Type.var "x", Type.namedWith [ "Time" ] "Posix" [] ]
                )
        }


{-| Get the current time periodically. How often though? Well, you provide an
interval in milliseconds (like `1000` for a second or `60 * 1000` for a minute
or `60 * 60 * 1000` for an hour) and that is how often you get a new time!

Check out [this example](https://elm-lang.org/examples/time) to see how to use
it in an application.

**This function is not for animation.** Use the [`elm/animation-frame`][af]
package for that sort of thing! It syncs up with repaints and will end up
being much smoother for any moving visuals.

[af]: /packages/elm/animation-frame/latest

every: Float -> (Time.Posix -> msg) -> Platform.Sub.Sub msg
-}
every : Float -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
every everyArg_ everyArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time" ]
             , name = "every"
             , annotation =
                 Just
                     (Type.function
                          [ Type.float
                          , Type.function
                              [ Type.namedWith [ "Time" ] "Posix" [] ]
                              (Type.var "msg")
                          ]
                          (Type.namedWith [] "Sub" [ Type.var "msg" ])
                     )
             }
        )
        [ Elm.float everyArg_, Elm.functionReduced "everyUnpack" everyArg_0 ]


{-| Turn a `Posix` time into the number of milliseconds since 1970 January 1
at 00:00:00 UTC. It was a Thursday.

posixToMillis: Time.Posix -> Int
-}
posixToMillis : Elm.Expression -> Elm.Expression
posixToMillis posixToMillisArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time" ]
             , name = "posixToMillis"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Time" ] "Posix" [] ]
                          Type.int
                     )
             }
        )
        [ posixToMillisArg_ ]


{-| Turn milliseconds into a `Posix` time.

millisToPosix: Int -> Time.Posix
-}
millisToPosix : Int -> Elm.Expression
millisToPosix millisToPosixArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time" ]
             , name = "millisToPosix"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int ]
                          (Type.namedWith [ "Time" ] "Posix" [])
                     )
             }
        )
        [ Elm.int millisToPosixArg_ ]


{-| The time zone for Coordinated Universal Time ([UTC][])

The `utc` zone has no time adjustments. It never observes daylight-saving
time and it never shifts around based on political restructuring.

[UTC]: https://en.wikipedia.org/wiki/Coordinated_Universal_Time

utc: Time.Zone
-}
utc : Elm.Expression
utc =
    Elm.value
        { importFrom = [ "Time" ]
        , name = "utc"
        , annotation = Just (Type.namedWith [ "Time" ] "Zone" [])
        }


{-| Produce a `Zone` based on the current UTC offset. You can use this to figure
out what day it is where you are:

    import Task exposing (Task)
    import Time

    whatDayIsIt : Task x Int
    whatDayIsIt =
      Task.map2 Time.toDay Time.here Time.now

**Accuracy Note:** This function can only give time zones like `Etc/GMT+9` or
`Etc/GMT-6`. It cannot give you `Europe/Stockholm`, `Asia/Tokyo`, or any other
normal time zone from the [full list][tz] due to limitations in JavaScript.
For example, if you run `here` in New York City, the resulting `Zone` will
never be `America/New_York`. Instead you get `Etc/GMT-5` or `Etc/GMT-4`
depending on Daylight Saving Time. So even though browsers must have internal
access to `America/New_York` to figure out that offset, there is no public API
to get the full information. This means the `Zone` you get from this function
will act weird if (1) an application stays open across a Daylight Saving Time
boundary or (2) you try to use it on historical data.

**Future Note:** We can improve `here` when there is good browser support for
JavaScript functions that (1) expose the IANA time zone database and (2) let
you ask the time zone of the computer. The committee that reviews additions to
JavaScript is called TC39, and I encourage you to push for these capabilities! I
cannot do it myself unfortunately.

**Alternatives:** See the `customZone` docs to learn how to implement stopgaps.

[tz]: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

here: Task.Task x Time.Zone
-}
here : Elm.Expression
here =
    Elm.value
        { importFrom = [ "Time" ]
        , name = "here"
        , annotation =
            Just
                (Type.namedWith
                     [ "Task" ]
                     "Task"
                     [ Type.var "x", Type.namedWith [ "Time" ] "Zone" [] ]
                )
        }


{-| What year is it?!

    import Time exposing (toYear, utc, millisToPosix)

    toYear utc (millisToPosix 0) == 1970
    toYear nyc (millisToPosix 0) == 1969

    -- pretend `nyc` is the `Zone` for America/New_York.

toYear: Time.Zone -> Time.Posix -> Int
-}
toYear : Elm.Expression -> Elm.Expression -> Elm.Expression
toYear toYearArg_ toYearArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time" ]
             , name = "toYear"
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
        [ toYearArg_, toYearArg_0 ]


{-| What month is it?!

    import Time exposing (toMonth, utc, millisToPosix)

    toMonth utc (millisToPosix 0) == Jan
    toMonth nyc (millisToPosix 0) == Dec

    -- pretend `nyc` is the `Zone` for America/New_York.

toMonth: Time.Zone -> Time.Posix -> Time.Month
-}
toMonth : Elm.Expression -> Elm.Expression -> Elm.Expression
toMonth toMonthArg_ toMonthArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time" ]
             , name = "toMonth"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Time" ] "Zone" []
                          , Type.namedWith [ "Time" ] "Posix" []
                          ]
                          (Type.namedWith [ "Time" ] "Month" [])
                     )
             }
        )
        [ toMonthArg_, toMonthArg_0 ]


{-| What day is it?! (Days go from 1 to 31)

    import Time exposing (toDay, utc, millisToPosix)

    toDay utc (millisToPosix 0) == 1
    toDay nyc (millisToPosix 0) == 31

    -- pretend `nyc` is the `Zone` for America/New_York.

toDay: Time.Zone -> Time.Posix -> Int
-}
toDay : Elm.Expression -> Elm.Expression -> Elm.Expression
toDay toDayArg_ toDayArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time" ]
             , name = "toDay"
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
        [ toDayArg_, toDayArg_0 ]


{-| What day of the week is it?

    import Time exposing (toWeekday, utc, millisToPosix)

    toWeekday utc (millisToPosix 0) == Thu
    toWeekday nyc (millisToPosix 0) == Wed

    -- pretend `nyc` is the `Zone` for America/New_York.

toWeekday: Time.Zone -> Time.Posix -> Time.Weekday
-}
toWeekday : Elm.Expression -> Elm.Expression -> Elm.Expression
toWeekday toWeekdayArg_ toWeekdayArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time" ]
             , name = "toWeekday"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Time" ] "Zone" []
                          , Type.namedWith [ "Time" ] "Posix" []
                          ]
                          (Type.namedWith [ "Time" ] "Weekday" [])
                     )
             }
        )
        [ toWeekdayArg_, toWeekdayArg_0 ]


{-| What hour is it? (From 0 to 23)

    import Time exposing (toHour, utc, millisToPosix)

    toHour utc (millisToPosix 0) == 0  -- 12am
    toHour nyc (millisToPosix 0) == 19 -- 7pm

    -- pretend `nyc` is the `Zone` for America/New_York.

toHour: Time.Zone -> Time.Posix -> Int
-}
toHour : Elm.Expression -> Elm.Expression -> Elm.Expression
toHour toHourArg_ toHourArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time" ]
             , name = "toHour"
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
        [ toHourArg_, toHourArg_0 ]


{-| What minute is it? (From 0 to 59)

    import Time exposing (toMinute, utc, millisToPosix)

    toMinute utc (millisToPosix 0) == 0

This can be different in different time zones. Some time zones are offset
by 30 or 45 minutes!

toMinute: Time.Zone -> Time.Posix -> Int
-}
toMinute : Elm.Expression -> Elm.Expression -> Elm.Expression
toMinute toMinuteArg_ toMinuteArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time" ]
             , name = "toMinute"
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
        [ toMinuteArg_, toMinuteArg_0 ]


{-| What second is it?

    import Time exposing (toSecond, utc, millisToPosix)

    toSecond utc (millisToPosix    0) == 0
    toSecond utc (millisToPosix 1234) == 1
    toSecond utc (millisToPosix 5678) == 5

toSecond: Time.Zone -> Time.Posix -> Int
-}
toSecond : Elm.Expression -> Elm.Expression -> Elm.Expression
toSecond toSecondArg_ toSecondArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time" ]
             , name = "toSecond"
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
        [ toSecondArg_, toSecondArg_0 ]


{-| import Time exposing (toMillis, utc, millisToPosix)

    toMillis utc (millisToPosix    0) == 0
    toMillis utc (millisToPosix 1234) == 234
    toMillis utc (millisToPosix 5678) == 678

toMillis: Time.Zone -> Time.Posix -> Int
-}
toMillis : Elm.Expression -> Elm.Expression -> Elm.Expression
toMillis toMillisArg_ toMillisArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time" ]
             , name = "toMillis"
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
        [ toMillisArg_, toMillisArg_0 ]


{-| **Intended for package authors.**

The documentation of [`here`](#here) explains that it has certain accuracy
limitations that block on adding new APIs to JavaScript. The `customZone`
function is a stopgap that takes:

1. A default offset in minutes. So `Etc/GMT-5` is `customZone (-5 * 60) []`
and `Etc/GMT+9` is `customZone (9 * 60) []`.
2. A list of exceptions containing their `start` time in "minutes since the Unix
epoch" and their `offset` in "minutes from UTC"

Human times will be based on the nearest `start`, falling back on the default
offset if the time is older than all of the exceptions.

When paired with `getZoneName`, this allows you to load the real IANA time zone
database however you want: HTTP, cache, hardcode, etc.

**Note:** If you use this, please share your work in an Elm community forum!
I am sure others would like to hear about it, and more experience reports will
help me and the any potential TC39 proposal.

customZone: Int -> List { start : Int, offset : Int } -> Time.Zone
-}
customZone : Int -> List { start : Int, offset : Int } -> Elm.Expression
customZone customZoneArg_ customZoneArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Time" ]
             , name = "customZone"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.list
                              (Type.record
                                 [ ( "start", Type.int )
                                 , ( "offset", Type.int )
                                 ]
                              )
                          ]
                          (Type.namedWith [ "Time" ] "Zone" [])
                     )
             }
        )
        [ Elm.int customZoneArg_
        , Elm.list
            (List.map
               (\unpack ->
                  Elm.record
                      [ Tuple.pair "start" (Elm.int unpack.start)
                      , Tuple.pair "offset" (Elm.int unpack.offset)
                      ]
               )
               customZoneArg_0
            )
        ]


{-| **Intended for package authors.**

Use `Intl.DateTimeFormat().resolvedOptions().timeZone` to try to get names
like `Europe/Moscow` or `America/Havana`. From there you can look it up in any
IANA data you loaded yourself.

getZoneName: Task.Task x Time.ZoneName
-}
getZoneName : Elm.Expression
getZoneName =
    Elm.value
        { importFrom = [ "Time" ]
        , name = "getZoneName"
        , annotation =
            Just
                (Type.namedWith
                     [ "Task" ]
                     "Task"
                     [ Type.var "x", Type.namedWith [ "Time" ] "ZoneName" [] ]
                )
        }


annotation_ :
    { posix : Type.Annotation
    , zone : Type.Annotation
    , weekday : Type.Annotation
    , month : Type.Annotation
    , zoneName : Type.Annotation
    }
annotation_ =
    { posix = Type.namedWith [ "Time" ] "Posix" []
    , zone = Type.namedWith [ "Time" ] "Zone" []
    , weekday = Type.namedWith [ "Time" ] "Weekday" []
    , month = Type.namedWith [ "Time" ] "Month" []
    , zoneName = Type.namedWith [ "Time" ] "ZoneName" []
    }


make_ :
    { mon : Elm.Expression
    , tue : Elm.Expression
    , wed : Elm.Expression
    , thu : Elm.Expression
    , fri : Elm.Expression
    , sat : Elm.Expression
    , sun : Elm.Expression
    , jan : Elm.Expression
    , feb : Elm.Expression
    , mar : Elm.Expression
    , apr : Elm.Expression
    , may : Elm.Expression
    , jun : Elm.Expression
    , jul : Elm.Expression
    , aug : Elm.Expression
    , sep : Elm.Expression
    , oct : Elm.Expression
    , nov : Elm.Expression
    , dec : Elm.Expression
    , name : Elm.Expression -> Elm.Expression
    , offset : Elm.Expression -> Elm.Expression
    }
make_ =
    { mon =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Mon"
            , annotation = Just (Type.namedWith [] "Weekday" [])
            }
    , tue =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Tue"
            , annotation = Just (Type.namedWith [] "Weekday" [])
            }
    , wed =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Wed"
            , annotation = Just (Type.namedWith [] "Weekday" [])
            }
    , thu =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Thu"
            , annotation = Just (Type.namedWith [] "Weekday" [])
            }
    , fri =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Fri"
            , annotation = Just (Type.namedWith [] "Weekday" [])
            }
    , sat =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Sat"
            , annotation = Just (Type.namedWith [] "Weekday" [])
            }
    , sun =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Sun"
            , annotation = Just (Type.namedWith [] "Weekday" [])
            }
    , jan =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Jan"
            , annotation = Just (Type.namedWith [] "Month" [])
            }
    , feb =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Feb"
            , annotation = Just (Type.namedWith [] "Month" [])
            }
    , mar =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Mar"
            , annotation = Just (Type.namedWith [] "Month" [])
            }
    , apr =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Apr"
            , annotation = Just (Type.namedWith [] "Month" [])
            }
    , may =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "May"
            , annotation = Just (Type.namedWith [] "Month" [])
            }
    , jun =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Jun"
            , annotation = Just (Type.namedWith [] "Month" [])
            }
    , jul =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Jul"
            , annotation = Just (Type.namedWith [] "Month" [])
            }
    , aug =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Aug"
            , annotation = Just (Type.namedWith [] "Month" [])
            }
    , sep =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Sep"
            , annotation = Just (Type.namedWith [] "Month" [])
            }
    , oct =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Oct"
            , annotation = Just (Type.namedWith [] "Month" [])
            }
    , nov =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Nov"
            , annotation = Just (Type.namedWith [] "Month" [])
            }
    , dec =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "Dec"
            , annotation = Just (Type.namedWith [] "Month" [])
            }
    , name =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time" ]
                     , name = "Name"
                     , annotation = Just (Type.namedWith [] "ZoneName" [])
                     }
                )
                [ ar0 ]
    , offset =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time" ]
                     , name = "Offset"
                     , annotation = Just (Type.namedWith [] "ZoneName" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { weekday :
        Elm.Expression
        -> { mon : Elm.Expression
        , tue : Elm.Expression
        , wed : Elm.Expression
        , thu : Elm.Expression
        , fri : Elm.Expression
        , sat : Elm.Expression
        , sun : Elm.Expression
        }
        -> Elm.Expression
    , month :
        Elm.Expression
        -> { jan : Elm.Expression
        , feb : Elm.Expression
        , mar : Elm.Expression
        , apr : Elm.Expression
        , may : Elm.Expression
        , jun : Elm.Expression
        , jul : Elm.Expression
        , aug : Elm.Expression
        , sep : Elm.Expression
        , oct : Elm.Expression
        , nov : Elm.Expression
        , dec : Elm.Expression
        }
        -> Elm.Expression
    , zoneName :
        Elm.Expression
        -> { name : Elm.Expression -> Elm.Expression
        , offset : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { weekday =
        \weekdayExpression weekdayTags ->
            Elm.Case.custom
                weekdayExpression
                (Type.namedWith [ "Time" ] "Weekday" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType "Mon" weekdayTags.mon)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Tue" weekdayTags.tue)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Wed" weekdayTags.wed)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Thu" weekdayTags.thu)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Fri" weekdayTags.fri)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Sat" weekdayTags.sat)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Sun" weekdayTags.sun)
                    Basics.identity
                ]
    , month =
        \monthExpression monthTags ->
            Elm.Case.custom
                monthExpression
                (Type.namedWith [ "Time" ] "Month" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType "Jan" monthTags.jan)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Feb" monthTags.feb)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Mar" monthTags.mar)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Apr" monthTags.apr)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "May" monthTags.may)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Jun" monthTags.jun)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Jul" monthTags.jul)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Aug" monthTags.aug)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Sep" monthTags.sep)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Oct" monthTags.oct)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Nov" monthTags.nov)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Dec" monthTags.dec)
                    Basics.identity
                ]
    , zoneName =
        \zoneNameExpression zoneNameTags ->
            Elm.Case.custom
                zoneNameExpression
                (Type.namedWith [ "Time" ] "ZoneName" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType "Name" zoneNameTags.name |> Elm.Arg.item
                                                                          (Elm.Arg.varWith
                                                                                 "arg_0"
                                                                                 Type.string
                                                                          )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "Offset"
                       zoneNameTags.offset |> Elm.Arg.item
                                                    (Elm.Arg.varWith
                                                           "arg_0"
                                                           Type.int
                                                    )
                    )
                    Basics.identity
                ]
    }


call_ :
    { every : Elm.Expression -> Elm.Expression -> Elm.Expression
    , posixToMillis : Elm.Expression -> Elm.Expression
    , millisToPosix : Elm.Expression -> Elm.Expression
    , toYear : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toMonth : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toDay : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toWeekday : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toHour : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toMinute : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toSecond : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toMillis : Elm.Expression -> Elm.Expression -> Elm.Expression
    , customZone : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { every =
        \everyArg_ everyArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time" ]
                     , name = "every"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.float
                                  , Type.function
                                      [ Type.namedWith [ "Time" ] "Posix" [] ]
                                      (Type.var "msg")
                                  ]
                                  (Type.namedWith [] "Sub" [ Type.var "msg" ])
                             )
                     }
                )
                [ everyArg_, everyArg_0 ]
    , posixToMillis =
        \posixToMillisArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time" ]
                     , name = "posixToMillis"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Time" ] "Posix" [] ]
                                  Type.int
                             )
                     }
                )
                [ posixToMillisArg_ ]
    , millisToPosix =
        \millisToPosixArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time" ]
                     , name = "millisToPosix"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int ]
                                  (Type.namedWith [ "Time" ] "Posix" [])
                             )
                     }
                )
                [ millisToPosixArg_ ]
    , toYear =
        \toYearArg_ toYearArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time" ]
                     , name = "toYear"
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
                [ toYearArg_, toYearArg_0 ]
    , toMonth =
        \toMonthArg_ toMonthArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time" ]
                     , name = "toMonth"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Time" ] "Zone" []
                                  , Type.namedWith [ "Time" ] "Posix" []
                                  ]
                                  (Type.namedWith [ "Time" ] "Month" [])
                             )
                     }
                )
                [ toMonthArg_, toMonthArg_0 ]
    , toDay =
        \toDayArg_ toDayArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time" ]
                     , name = "toDay"
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
                [ toDayArg_, toDayArg_0 ]
    , toWeekday =
        \toWeekdayArg_ toWeekdayArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time" ]
                     , name = "toWeekday"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Time" ] "Zone" []
                                  , Type.namedWith [ "Time" ] "Posix" []
                                  ]
                                  (Type.namedWith [ "Time" ] "Weekday" [])
                             )
                     }
                )
                [ toWeekdayArg_, toWeekdayArg_0 ]
    , toHour =
        \toHourArg_ toHourArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time" ]
                     , name = "toHour"
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
                [ toHourArg_, toHourArg_0 ]
    , toMinute =
        \toMinuteArg_ toMinuteArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time" ]
                     , name = "toMinute"
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
                [ toMinuteArg_, toMinuteArg_0 ]
    , toSecond =
        \toSecondArg_ toSecondArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time" ]
                     , name = "toSecond"
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
                [ toSecondArg_, toSecondArg_0 ]
    , toMillis =
        \toMillisArg_ toMillisArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time" ]
                     , name = "toMillis"
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
                [ toMillisArg_, toMillisArg_0 ]
    , customZone =
        \customZoneArg_ customZoneArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Time" ]
                     , name = "customZone"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.list
                                      (Type.record
                                         [ ( "start", Type.int )
                                         , ( "offset", Type.int )
                                         ]
                                      )
                                  ]
                                  (Type.namedWith [ "Time" ] "Zone" [])
                             )
                     }
                )
                [ customZoneArg_, customZoneArg_0 ]
    }


values_ :
    { now : Elm.Expression
    , every : Elm.Expression
    , posixToMillis : Elm.Expression
    , millisToPosix : Elm.Expression
    , utc : Elm.Expression
    , here : Elm.Expression
    , toYear : Elm.Expression
    , toMonth : Elm.Expression
    , toDay : Elm.Expression
    , toWeekday : Elm.Expression
    , toHour : Elm.Expression
    , toMinute : Elm.Expression
    , toSecond : Elm.Expression
    , toMillis : Elm.Expression
    , customZone : Elm.Expression
    , getZoneName : Elm.Expression
    }
values_ =
    { now =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "now"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Task" ]
                         "Task"
                         [ Type.var "x", Type.namedWith [ "Time" ] "Posix" [] ]
                    )
            }
    , every =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "every"
            , annotation =
                Just
                    (Type.function
                         [ Type.float
                         , Type.function
                             [ Type.namedWith [ "Time" ] "Posix" [] ]
                             (Type.var "msg")
                         ]
                         (Type.namedWith [] "Sub" [ Type.var "msg" ])
                    )
            }
    , posixToMillis =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "posixToMillis"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time" ] "Posix" [] ]
                         Type.int
                    )
            }
    , millisToPosix =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "millisToPosix"
            , annotation =
                Just
                    (Type.function
                         [ Type.int ]
                         (Type.namedWith [ "Time" ] "Posix" [])
                    )
            }
    , utc =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "utc"
            , annotation = Just (Type.namedWith [ "Time" ] "Zone" [])
            }
    , here =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "here"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Task" ]
                         "Task"
                         [ Type.var "x", Type.namedWith [ "Time" ] "Zone" [] ]
                    )
            }
    , toYear =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "toYear"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time" ] "Zone" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                         Type.int
                    )
            }
    , toMonth =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "toMonth"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time" ] "Zone" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                         (Type.namedWith [ "Time" ] "Month" [])
                    )
            }
    , toDay =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "toDay"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time" ] "Zone" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                         Type.int
                    )
            }
    , toWeekday =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "toWeekday"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time" ] "Zone" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                         (Type.namedWith [ "Time" ] "Weekday" [])
                    )
            }
    , toHour =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "toHour"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time" ] "Zone" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                         Type.int
                    )
            }
    , toMinute =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "toMinute"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time" ] "Zone" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                         Type.int
                    )
            }
    , toSecond =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "toSecond"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time" ] "Zone" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                         Type.int
                    )
            }
    , toMillis =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "toMillis"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Time" ] "Zone" []
                         , Type.namedWith [ "Time" ] "Posix" []
                         ]
                         Type.int
                    )
            }
    , customZone =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "customZone"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.list
                             (Type.record
                                [ ( "start", Type.int )
                                , ( "offset", Type.int )
                                ]
                             )
                         ]
                         (Type.namedWith [ "Time" ] "Zone" [])
                    )
            }
    , getZoneName =
        Elm.value
            { importFrom = [ "Time" ]
            , name = "getZoneName"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Task" ]
                         "Task"
                         [ Type.var "x"
                         , Type.namedWith [ "Time" ] "ZoneName" []
                         ]
                    )
            }
    }