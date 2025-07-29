module Gen.Json.Decode exposing
    ( string, bool, int, float
    , list, dict, keyValuePairs, field
    , oneOf
    , map
    , value, null
    , succeed, fail, andThen, annotation_
    , call_, values_
    )

{-|


# Generated bindings for Json.Decode

@docs string, bool, int, float
@docs list, dict, keyValuePairs, field
@docs oneOf
@docs map
@docs value, null
@docs succeed, fail, andThen, annotation_
@docs call_, values_

-}

import Elm
import Elm.Annotation as Type


{-| The name of this module.
-}
moduleName_ : List String
moduleName_ =
    [ "Json", "Decode" ]


{-| Decode a JSON string into an Elm `String`.

    decodeString string "true"              == Err ...
    decodeString string "42"                == Err ...
    decodeString string "3.14"              == Err ...
    decodeString string "\"hello\""         == Ok "hello"
    decodeString string "{ \"hello\": 42 }" == Err ...

string: Json.Decode.Decoder String

-}
string : Elm.Expression
string =
    Elm.value
        { importFrom = [ "Json", "Decode" ]
        , name = "string"
        , annotation =
            Just (Type.namedWith [ "Json", "Decode" ] "Decoder" [ Type.string ])
        }


{-| Decode a JSON boolean into an Elm `Bool`.

    decodeString bool "true"              == Ok True
    decodeString bool "42"                == Err ...
    decodeString bool "3.14"              == Err ...
    decodeString bool "\"hello\""         == Err ...
    decodeString bool "{ \"hello\": 42 }" == Err ...

bool: Json.Decode.Decoder Bool

-}
bool : Elm.Expression
bool =
    Elm.value
        { importFrom = [ "Json", "Decode" ]
        , name = "bool"
        , annotation =
            Just (Type.namedWith [ "Json", "Decode" ] "Decoder" [ Type.bool ])
        }


{-| Decode a JSON number into an Elm `Int`.

    decodeString int "true"              == Err ...
    decodeString int "42"                == Ok 42
    decodeString int "3.14"              == Err ...
    decodeString int "\"hello\""         == Err ...
    decodeString int "{ \"hello\": 42 }" == Err ...

int: Json.Decode.Decoder Int

-}
int : Elm.Expression
int =
    Elm.value
        { importFrom = [ "Json", "Decode" ]
        , name = "int"
        , annotation =
            Just (Type.namedWith [ "Json", "Decode" ] "Decoder" [ Type.int ])
        }


{-| Decode a JSON number into an Elm `Float`.

    decodeString float "true"              == Err ..
    decodeString float "42"                == Ok 42
    decodeString float "3.14"              == Ok 3.14
    decodeString float "\"hello\""         == Err ...
    decodeString float "{ \"hello\": 42 }" == Err ...

float: Json.Decode.Decoder Float

-}
float : Elm.Expression
float =
    Elm.value
        { importFrom = [ "Json", "Decode" ]
        , name = "float"
        , annotation =
            Just (Type.namedWith [ "Json", "Decode" ] "Decoder" [ Type.float ])
        }


{-| Decode a JSON array into an Elm `List`.

    decodeString (list int) "[1,2,3]" == Ok [ 1, 2, 3 ]

    decodeString (list bool) "[true,false]" == Ok [ True, False ]

list: Json.Decode.Decoder a -> Json.Decode.Decoder (List a)

-}
list : Elm.Expression -> Elm.Expression
list listArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "list"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.list (Type.var "a") ]
                        )
                    )
            }
        )
        [ listArg_ ]


{-| Decode a JSON object into an Elm `Dict`.

    decodeString (dict int) "{ \"alice\": 42, \"bob\": 99 }"
        == Ok (Dict.fromList [ ( "alice", 42 ), ( "bob", 99 ) ])

If you need the keys (like `"alice"` and `"bob"`) available in the `Dict`
values as well, I recommend using a (private) intermediate data structure like
`Info` in this example:

    module User exposing (User, decoder)

    import Dict
    import Json.Decode exposing (..)

    type alias User =
        { name : String
        , height : Float
        , age : Int
        }

    decoder : Decoder (Dict.Dict String User)
    decoder =
        map (Dict.map infoToUser) (dict infoDecoder)

    type alias Info =
        { height : Float
        , age : Int
        }

    infoDecoder : Decoder Info
    infoDecoder =
        map2 Info
            (field "height" float)
            (field "age" int)

    infoToUser : String -> Info -> User
    infoToUser name { height, age } =
        User name height age

So now JSON like `{ "alice": { height: 1.6, age: 33 }}` are turned into
dictionary values like `Dict.singleton "alice" (User "alice" 1.6 33)` if
you need that.

dict: Json.Decode.Decoder a -> Json.Decode.Decoder (Dict.Dict String a)

-}
dict : Elm.Expression -> Elm.Expression
dict dictArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "dict"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.namedWith
                                [ "Dict" ]
                                "Dict"
                                [ Type.string, Type.var "a" ]
                            ]
                        )
                    )
            }
        )
        [ dictArg_ ]


{-| Decode a JSON object into an Elm `List` of pairs.

    decodeString (keyValuePairs int) "{ \"alice\": 42, \"bob\": 99 }"
        == Ok [ ( "alice", 42 ), ( "bob", 99 ) ]

keyValuePairs: Json.Decode.Decoder a -> Json.Decode.Decoder (List ( String, a ))

-}
keyValuePairs : Elm.Expression -> Elm.Expression
keyValuePairs keyValuePairsArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "keyValuePairs"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.list
                                (Type.tuple Type.string (Type.var "a"))
                            ]
                        )
                    )
            }
        )
        [ keyValuePairsArg_ ]


{-| Decode a JSON object, requiring a particular field.

    decodeString (field "x" int) "{ \"x\": 3 }" == Ok 3

    decodeString (field "x" int) "{ \"x\": 3, \"y\": 4 }" == Ok 3

    decodeString (field "x" int) "{ \"x\": true }"
        == Err
        ... decodeString (field "x" int) "{ \"y\": 4 }"
        == Err
        ... decodeString (field "name" string) "{ \"name\": \"tom\" }"
        == Ok "tom"

The object _can_ have other fields. Lots of them! The only thing this decoder
cares about is if `x` is present and that the value there is an `Int`.

Check out [`map2`](#map2) to see how to decode multiple fields!

field: String -> Json.Decode.Decoder a -> Json.Decode.Decoder a

-}
field : String -> Elm.Expression -> Elm.Expression
field fieldArg_ fieldArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "field"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        )
                    )
            }
        )
        [ Elm.string fieldArg_, fieldArg_0 ]


{-| Try a bunch of different decoders. This can be useful if the JSON may come
in a couple different formats. For example, say you want to read an array of
numbers, but some of them are `null`.

    import String

    badInt : Decoder Int
    badInt =
        oneOf [ int, null 0 ]

    -- decodeString (list badInt) "[1,2,null,4]" == Ok [1,2,0,4]

Why would someone generate JSON like this? Questions like this are not good
for your health. The point is that you can use `oneOf` to handle situations
like this!

You could also use `oneOf` to help version your data. Try the latest format,
then a few older ones that you still support. You could use `andThen` to be
even more particular if you wanted.

oneOf: List (Json.Decode.Decoder a) -> Json.Decode.Decoder a

-}
oneOf : List Elm.Expression -> Elm.Expression
oneOf oneOfArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "oneOf"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.namedWith
                                [ "Json", "Decode" ]
                                "Decoder"
                                [ Type.var "a" ]
                            )
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        )
                    )
            }
        )
        [ Elm.list oneOfArg_ ]


{-| Transform a decoder. Maybe you just want to know the length of a string:

    import String

    stringLength : Decoder Int
    stringLength =
        map String.length string

It is often helpful to use `map` with `oneOf`, like when defining `nullable`:

    nullable : Decoder a -> Decoder (Maybe a)
    nullable decoder =
        oneOf
            [ null Nothing
            , map Just decoder
            ]

map: (a -> value) -> Json.Decode.Decoder a -> Json.Decode.Decoder value

-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg_ mapArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "value")
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "value" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "mapUnpack" mapArg_, mapArg_0 ]


{-| Do not do anything with a JSON value, just bring it into Elm as a `Value`.
This can be useful if you have particularly complex data that you would like to
deal with later. Or if you are going to send it out a port and do not care
about its structure.

value: Json.Decode.Decoder Json.Decode.Value

-}
value : Elm.Expression
value =
    Elm.value
        { importFrom = [ "Json", "Decode" ]
        , name = "value"
        , annotation =
            Just
                (Type.namedWith
                    [ "Json", "Decode" ]
                    "Decoder"
                    [ Type.namedWith [ "Json", "Decode" ] "Value" [] ]
                )
        }


{-| Decode a `null` value into some Elm value.

    decodeString (null False) "null" == Ok False
    decodeString (null 42) "null"    == Ok 42
    decodeString (null 42) "42"      == Err ..
    decodeString (null 42) "false"   == Err ..

So if you ever see a `null`, this will return whatever value you specified.

null: a -> Json.Decode.Decoder a

-}
null : Elm.Expression -> Elm.Expression
null nullArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "null"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a" ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        )
                    )
            }
        )
        [ nullArg_ ]


{-| Ignore the JSON and produce a certain Elm value.

    decodeString (succeed 42) "true"    == Ok 42
    decodeString (succeed 42) "[1,2,3]" == Ok 42
    decodeString (succeed 42) "hello"   == Err ... -- this is not a valid JSON string

This is handy when used with `oneOf` or `andThen`.

succeed: a -> Json.Decode.Decoder a

-}
succeed : Elm.Expression -> Elm.Expression
succeed succeedArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "succeed"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a" ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        )
                    )
            }
        )
        [ succeedArg_ ]


{-| Ignore the JSON and make the decoder fail. This is handy when used with
`oneOf` or `andThen` where you want to give a custom error message in some
case.

See the [`andThen`](#andThen) docs for an example.

fail: String -> Json.Decode.Decoder a

-}
fail : String -> Elm.Expression
fail failArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "fail"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        )
                    )
            }
        )
        [ Elm.string failArg_ ]


{-| Create decoders that depend on previous results. If you are creating
versioned data, you might do something like this:


    info : Decoder Info
    info =
        field "version" int
            |> andThen infoHelp

    infoHelp : Int -> Decoder Info
    infoHelp version =
        case version of
            4 ->
                infoDecoder4

            3 ->
                infoDecoder3

            _ ->
                fail <|
                    "Trying to decode info, but version "
                        ++ toString version
                        ++ " is not supported."

    -- infoDecoder4 : Decoder Info
    -- infoDecoder3 : Decoder Info

andThen: (a -> Json.Decode.Decoder b) -> Json.Decode.Decoder a -> Json.Decode.Decoder b

-}
andThen : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
andThen andThenArg_ andThenArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "andThen"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.namedWith
                                [ "Json", "Decode" ]
                                "Decoder"
                                [ Type.var "b" ]
                            )
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "b" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "andThenUnpack" andThenArg_, andThenArg_0 ]


annotation_ :
    { decoder : Type.Annotation -> Type.Annotation
    , value : Type.Annotation
    , error : Type.Annotation
    }
annotation_ =
    { decoder =
        \decoderArg0 ->
            Type.namedWith [ "Json", "Decode" ] "Decoder" [ decoderArg0 ]
    , value =
        Type.alias
            moduleName_
            "Value"
            []
            (Type.namedWith [ "Json", "Encode" ] "Value" [])
    , error = Type.namedWith [ "Json", "Decode" ] "Error" []
    }


call_ :
    { nullable : Elm.Expression -> Elm.Expression
    , list : Elm.Expression -> Elm.Expression
    , array : Elm.Expression -> Elm.Expression
    , dict : Elm.Expression -> Elm.Expression
    , keyValuePairs : Elm.Expression -> Elm.Expression
    , oneOrMore : Elm.Expression -> Elm.Expression -> Elm.Expression
    , field : Elm.Expression -> Elm.Expression -> Elm.Expression
    , at : Elm.Expression -> Elm.Expression -> Elm.Expression
    , index : Elm.Expression -> Elm.Expression -> Elm.Expression
    , maybe : Elm.Expression -> Elm.Expression
    , oneOf : Elm.Expression -> Elm.Expression
    , decodeString : Elm.Expression -> Elm.Expression -> Elm.Expression
    , decodeValue : Elm.Expression -> Elm.Expression -> Elm.Expression
    , errorToString : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , map2 :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , map3 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map4 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map5 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map6 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map7 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map8 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , lazy : Elm.Expression -> Elm.Expression
    , null : Elm.Expression -> Elm.Expression
    , succeed : Elm.Expression -> Elm.Expression
    , fail : Elm.Expression -> Elm.Expression
    , andThen : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { nullable =
        \nullableArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "nullable"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.maybe (Type.var "a") ]
                                )
                            )
                    }
                )
                [ nullableArg_ ]
    , list =
        \listArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "list"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.list (Type.var "a") ]
                                )
                            )
                    }
                )
                [ listArg_ ]
    , array =
        \arrayArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "array"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.namedWith
                                        [ "Array" ]
                                        "Array"
                                        [ Type.var "a" ]
                                    ]
                                )
                            )
                    }
                )
                [ arrayArg_ ]
    , dict =
        \dictArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "dict"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.namedWith
                                        [ "Dict" ]
                                        "Dict"
                                        [ Type.string, Type.var "a" ]
                                    ]
                                )
                            )
                    }
                )
                [ dictArg_ ]
    , keyValuePairs =
        \keyValuePairsArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "keyValuePairs"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.list
                                        (Type.tuple
                                            Type.string
                                            (Type.var "a")
                                        )
                                    ]
                                )
                            )
                    }
                )
                [ keyValuePairsArg_ ]
    , oneOrMore =
        \oneOrMoreArg_ oneOrMoreArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "oneOrMore"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.list (Type.var "a") ]
                                    (Type.var "value")
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "value" ]
                                )
                            )
                    }
                )
                [ oneOrMoreArg_, oneOrMoreArg_0 ]
    , field =
        \fieldArg_ fieldArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "field"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ fieldArg_, fieldArg_0 ]
    , at =
        \atArg_ atArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "at"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list Type.string
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ atArg_, atArg_0 ]
    , index =
        \indexArg_ indexArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "index"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ indexArg_, indexArg_0 ]
    , maybe =
        \maybeArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "maybe"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.maybe (Type.var "a") ]
                                )
                            )
                    }
                )
                [ maybeArg_ ]
    , oneOf =
        \oneOfArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "oneOf"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.namedWith
                                        [ "Json", "Decode" ]
                                        "Decoder"
                                        [ Type.var "a" ]
                                    )
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ oneOfArg_ ]
    , decodeString =
        \decodeStringArg_ decodeStringArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "decodeString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                , Type.string
                                ]
                                (Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.namedWith
                                        [ "Json", "Decode" ]
                                        "Error"
                                        []
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ decodeStringArg_, decodeStringArg_0 ]
    , decodeValue =
        \decodeValueArg_ decodeValueArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "decodeValue"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Value"
                                    []
                                ]
                                (Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.namedWith
                                        [ "Json", "Decode" ]
                                        "Error"
                                        []
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ decodeValueArg_, decodeValueArg_0 ]
    , errorToString =
        \errorToStringArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "errorToString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Error"
                                    []
                                ]
                                Type.string
                            )
                    }
                )
                [ errorToStringArg_ ]
    , map =
        \mapArg_ mapArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "map"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.var "value")
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "value" ]
                                )
                            )
                    }
                )
                [ mapArg_, mapArg_0 ]
    , map2 =
        \map2Arg_ map2Arg_0 map2Arg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "map2"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a", Type.var "b" ]
                                    (Type.var "value")
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "b" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "value" ]
                                )
                            )
                    }
                )
                [ map2Arg_, map2Arg_0, map2Arg_1 ]
    , map3 =
        \map3Arg_ map3Arg_0 map3Arg_1 map3Arg_2 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "map3"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a"
                                    , Type.var "b"
                                    , Type.var "c"
                                    ]
                                    (Type.var "value")
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "b" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "c" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "value" ]
                                )
                            )
                    }
                )
                [ map3Arg_, map3Arg_0, map3Arg_1, map3Arg_2 ]
    , map4 =
        \map4Arg_ map4Arg_0 map4Arg_1 map4Arg_2 map4Arg_3 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "map4"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a"
                                    , Type.var "b"
                                    , Type.var "c"
                                    , Type.var "d"
                                    ]
                                    (Type.var "value")
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "b" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "c" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "d" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "value" ]
                                )
                            )
                    }
                )
                [ map4Arg_, map4Arg_0, map4Arg_1, map4Arg_2, map4Arg_3 ]
    , map5 =
        \map5Arg_ map5Arg_0 map5Arg_1 map5Arg_2 map5Arg_3 map5Arg_4 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "map5"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a"
                                    , Type.var "b"
                                    , Type.var "c"
                                    , Type.var "d"
                                    , Type.var "e"
                                    ]
                                    (Type.var "value")
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "b" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "c" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "d" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "e" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "value" ]
                                )
                            )
                    }
                )
                [ map5Arg_
                , map5Arg_0
                , map5Arg_1
                , map5Arg_2
                , map5Arg_3
                , map5Arg_4
                ]
    , map6 =
        \map6Arg_ map6Arg_0 map6Arg_1 map6Arg_2 map6Arg_3 map6Arg_4 map6Arg_5 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "map6"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a"
                                    , Type.var "b"
                                    , Type.var "c"
                                    , Type.var "d"
                                    , Type.var "e"
                                    , Type.var "f"
                                    ]
                                    (Type.var "value")
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "b" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "c" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "d" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "e" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "f" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "value" ]
                                )
                            )
                    }
                )
                [ map6Arg_
                , map6Arg_0
                , map6Arg_1
                , map6Arg_2
                , map6Arg_3
                , map6Arg_4
                , map6Arg_5
                ]
    , map7 =
        \map7Arg_ map7Arg_0 map7Arg_1 map7Arg_2 map7Arg_3 map7Arg_4 map7Arg_5 map7Arg_6 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "map7"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a"
                                    , Type.var "b"
                                    , Type.var "c"
                                    , Type.var "d"
                                    , Type.var "e"
                                    , Type.var "f"
                                    , Type.var "g"
                                    ]
                                    (Type.var "value")
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "b" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "c" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "d" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "e" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "f" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "g" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "value" ]
                                )
                            )
                    }
                )
                [ map7Arg_
                , map7Arg_0
                , map7Arg_1
                , map7Arg_2
                , map7Arg_3
                , map7Arg_4
                , map7Arg_5
                , map7Arg_6
                ]
    , map8 =
        \map8Arg_ map8Arg_0 map8Arg_1 map8Arg_2 map8Arg_3 map8Arg_4 map8Arg_5 map8Arg_6 map8Arg_7 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "map8"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a"
                                    , Type.var "b"
                                    , Type.var "c"
                                    , Type.var "d"
                                    , Type.var "e"
                                    , Type.var "f"
                                    , Type.var "g"
                                    , Type.var "h"
                                    ]
                                    (Type.var "value")
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "b" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "c" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "d" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "e" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "f" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "g" ]
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "h" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "value" ]
                                )
                            )
                    }
                )
                [ map8Arg_
                , map8Arg_0
                , map8Arg_1
                , map8Arg_2
                , map8Arg_3
                , map8Arg_4
                , map8Arg_5
                , map8Arg_6
                , map8Arg_7
                ]
    , lazy =
        \lazyArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "lazy"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.unit ]
                                    (Type.namedWith
                                        [ "Json", "Decode" ]
                                        "Decoder"
                                        [ Type.var "a" ]
                                    )
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ lazyArg_ ]
    , null =
        \nullArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "null"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "a" ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ nullArg_ ]
    , succeed =
        \succeedArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "succeed"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "a" ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ succeedArg_ ]
    , fail =
        \failArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "fail"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                )
                            )
                    }
                )
                [ failArg_ ]
    , andThen =
        \andThenArg_ andThenArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Decode" ]
                    , name = "andThen"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.namedWith
                                        [ "Json", "Decode" ]
                                        "Decoder"
                                        [ Type.var "b" ]
                                    )
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "b" ]
                                )
                            )
                    }
                )
                [ andThenArg_, andThenArg_0 ]
    }


values_ :
    { string : Elm.Expression
    , bool : Elm.Expression
    , int : Elm.Expression
    , float : Elm.Expression
    , nullable : Elm.Expression
    , list : Elm.Expression
    , array : Elm.Expression
    , dict : Elm.Expression
    , keyValuePairs : Elm.Expression
    , oneOrMore : Elm.Expression
    , field : Elm.Expression
    , at : Elm.Expression
    , index : Elm.Expression
    , maybe : Elm.Expression
    , oneOf : Elm.Expression
    , decodeString : Elm.Expression
    , decodeValue : Elm.Expression
    , errorToString : Elm.Expression
    , map : Elm.Expression
    , map2 : Elm.Expression
    , map3 : Elm.Expression
    , map4 : Elm.Expression
    , map5 : Elm.Expression
    , map6 : Elm.Expression
    , map7 : Elm.Expression
    , map8 : Elm.Expression
    , lazy : Elm.Expression
    , value : Elm.Expression
    , null : Elm.Expression
    , succeed : Elm.Expression
    , fail : Elm.Expression
    , andThen : Elm.Expression
    }
values_ =
    { string =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "string"
            , annotation =
                Just
                    (Type.namedWith
                        [ "Json", "Decode" ]
                        "Decoder"
                        [ Type.string ]
                    )
            }
    , bool =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "bool"
            , annotation =
                Just
                    (Type.namedWith [ "Json", "Decode" ] "Decoder" [ Type.bool ])
            }
    , int =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "int"
            , annotation =
                Just
                    (Type.namedWith [ "Json", "Decode" ] "Decoder" [ Type.int ])
            }
    , float =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "float"
            , annotation =
                Just
                    (Type.namedWith
                        [ "Json", "Decode" ]
                        "Decoder"
                        [ Type.float ]
                    )
            }
    , nullable =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "nullable"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.maybe (Type.var "a") ]
                        )
                    )
            }
    , list =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "list"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.list (Type.var "a") ]
                        )
                    )
            }
    , array =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "array"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.namedWith
                                [ "Array" ]
                                "Array"
                                [ Type.var "a" ]
                            ]
                        )
                    )
            }
    , dict =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "dict"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.namedWith
                                [ "Dict" ]
                                "Dict"
                                [ Type.string, Type.var "a" ]
                            ]
                        )
                    )
            }
    , keyValuePairs =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "keyValuePairs"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.list
                                (Type.tuple Type.string (Type.var "a"))
                            ]
                        )
                    )
            }
    , oneOrMore =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "oneOrMore"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.list (Type.var "a") ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "value" ]
                        )
                    )
            }
    , field =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "field"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        )
                    )
            }
    , at =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "at"
            , annotation =
                Just
                    (Type.function
                        [ Type.list Type.string
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        )
                    )
            }
    , index =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "index"
            , annotation =
                Just
                    (Type.function
                        [ Type.int
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        )
                    )
            }
    , maybe =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "maybe"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.maybe (Type.var "a") ]
                        )
                    )
            }
    , oneOf =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "oneOf"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.namedWith
                                [ "Json", "Decode" ]
                                "Decoder"
                                [ Type.var "a" ]
                            )
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        )
                    )
            }
    , decodeString =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "decodeString"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        , Type.string
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.namedWith [ "Json", "Decode" ] "Error" []
                            , Type.var "a"
                            ]
                        )
                    )
            }
    , decodeValue =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "decodeValue"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        , Type.namedWith [ "Json", "Decode" ] "Value" []
                        ]
                        (Type.namedWith
                            [ "Result" ]
                            "Result"
                            [ Type.namedWith [ "Json", "Decode" ] "Error" []
                            , Type.var "a"
                            ]
                        )
                    )
            }
    , errorToString =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "errorToString"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Json", "Decode" ] "Error" [] ]
                        Type.string
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                        [ Type.function [ Type.var "a" ] (Type.var "value")
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "value" ]
                        )
                    )
            }
    , map2 =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "map2"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b" ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "b" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "value" ]
                        )
                    )
            }
    , map3 =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "map3"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a", Type.var "b", Type.var "c" ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "b" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "c" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "value" ]
                        )
                    )
            }
    , map4 =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "map4"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a"
                            , Type.var "b"
                            , Type.var "c"
                            , Type.var "d"
                            ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "b" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "c" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "d" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "value" ]
                        )
                    )
            }
    , map5 =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "map5"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a"
                            , Type.var "b"
                            , Type.var "c"
                            , Type.var "d"
                            , Type.var "e"
                            ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "b" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "c" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "d" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "e" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "value" ]
                        )
                    )
            }
    , map6 =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "map6"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a"
                            , Type.var "b"
                            , Type.var "c"
                            , Type.var "d"
                            , Type.var "e"
                            , Type.var "f"
                            ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "b" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "c" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "d" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "e" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "f" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "value" ]
                        )
                    )
            }
    , map7 =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "map7"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a"
                            , Type.var "b"
                            , Type.var "c"
                            , Type.var "d"
                            , Type.var "e"
                            , Type.var "f"
                            , Type.var "g"
                            ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "b" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "c" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "d" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "e" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "f" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "g" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "value" ]
                        )
                    )
            }
    , map8 =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "map8"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a"
                            , Type.var "b"
                            , Type.var "c"
                            , Type.var "d"
                            , Type.var "e"
                            , Type.var "f"
                            , Type.var "g"
                            , Type.var "h"
                            ]
                            (Type.var "value")
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "b" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "c" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "d" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "e" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "f" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "g" ]
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "h" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "value" ]
                        )
                    )
            }
    , lazy =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "lazy"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.unit ]
                            (Type.namedWith
                                [ "Json", "Decode" ]
                                "Decoder"
                                [ Type.var "a" ]
                            )
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        )
                    )
            }
    , value =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "value"
            , annotation =
                Just
                    (Type.namedWith
                        [ "Json", "Decode" ]
                        "Decoder"
                        [ Type.namedWith [ "Json", "Decode" ] "Value" [] ]
                    )
            }
    , null =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "null"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a" ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        )
                    )
            }
    , succeed =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "succeed"
            , annotation =
                Just
                    (Type.function
                        [ Type.var "a" ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        )
                    )
            }
    , fail =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "fail"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        )
                    )
            }
    , andThen =
        Elm.value
            { importFrom = [ "Json", "Decode" ]
            , name = "andThen"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.var "a" ]
                            (Type.namedWith
                                [ "Json", "Decode" ]
                                "Decoder"
                                [ Type.var "b" ]
                            )
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "b" ]
                        )
                    )
            }
    }
