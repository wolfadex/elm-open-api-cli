module Gen.Json.Encode exposing
    ( encode
    , null, object
    , annotation_, call_
    )

{-|


# Generated bindings for Json.Encode

@docs encode
@docs null, object
@docs annotation_, call_

-}

import Elm
import Elm.Annotation as Type


{-| Convert a `Value` into a prettified string. The first argument specifies
the amount of indentation in the resulting string.

    import Json.Encode as Encode

    tom : Encode.Value
    tom =
        Encode.object
            [ ( "name", Encode.string "Tom" )
            , ( "age", Encode.int 42 )
            ]

    compact =
        Encode.encode 0 tom

    -- {"name":"Tom","age":42}
    readable =
        Encode.encode 4 tom

    -- {
    --     "name": "Tom",
    --     "age": 42
    -- }

encode: Int -> Json.Encode.Value -> String

-}
encode : Int -> Elm.Expression -> Elm.Expression
encode encodeArg_ encodeArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Json", "Encode" ]
            , name = "encode"
            , annotation =
                Just
                    (Type.function
                        [ Type.int
                        , Type.namedWith [ "Json", "Encode" ] "Value" []
                        ]
                        Type.string
                    )
            }
        )
        [ Elm.int encodeArg_, encodeArg_0 ]


{-| Create a JSON `null` value.

    import Json.Encode exposing (encode, null)


    -- encode 0 null == "null"

null: Json.Encode.Value

-}
null : Elm.Expression
null =
    Elm.value
        { importFrom = [ "Json", "Encode" ]
        , name = "null"
        , annotation = Just (Type.namedWith [ "Json", "Encode" ] "Value" [])
        }


{-| Create a JSON object.

    import Json.Encode as Encode

    tom : Encode.Value
    tom =
        Encode.object
            [ ( "name", Encode.string "Tom" )
            , ( "age", Encode.int 42 )
            ]

    -- Encode.encode 0 tom == """{"name":"Tom","age":42}"""

object: List ( String, Json.Encode.Value ) -> Json.Encode.Value

-}
object : List Elm.Expression -> Elm.Expression
object objectArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Json", "Encode" ]
            , name = "object"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.tuple
                                Type.string
                                (Type.namedWith [ "Json", "Encode" ] "Value" [])
                            )
                        ]
                        (Type.namedWith [ "Json", "Encode" ] "Value" [])
                    )
            }
        )
        [ Elm.list objectArg_ ]


annotation_ : { value : Type.Annotation }
annotation_ =
    { value = Type.namedWith [ "Json", "Encode" ] "Value" [] }


call_ :
    { encode : Elm.Expression -> Elm.Expression -> Elm.Expression
    , string : Elm.Expression -> Elm.Expression
    , int : Elm.Expression -> Elm.Expression
    , float : Elm.Expression -> Elm.Expression
    , bool : Elm.Expression -> Elm.Expression
    , list : Elm.Expression -> Elm.Expression -> Elm.Expression
    , array : Elm.Expression -> Elm.Expression -> Elm.Expression
    , set : Elm.Expression -> Elm.Expression -> Elm.Expression
    , object : Elm.Expression -> Elm.Expression
    , dict :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { encode =
        \encodeArg_ encodeArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Encode" ]
                    , name = "encode"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int
                                , Type.namedWith
                                    [ "Json", "Encode" ]
                                    "Value"
                                    []
                                ]
                                Type.string
                            )
                    }
                )
                [ encodeArg_, encodeArg_0 ]
    , string =
        \stringArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Encode" ]
                    , name = "string"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith
                                    [ "Json", "Encode" ]
                                    "Value"
                                    []
                                )
                            )
                    }
                )
                [ stringArg_ ]
    , int =
        \intArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Encode" ]
                    , name = "int"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.int ]
                                (Type.namedWith
                                    [ "Json", "Encode" ]
                                    "Value"
                                    []
                                )
                            )
                    }
                )
                [ intArg_ ]
    , float =
        \floatArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Encode" ]
                    , name = "float"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.float ]
                                (Type.namedWith
                                    [ "Json", "Encode" ]
                                    "Value"
                                    []
                                )
                            )
                    }
                )
                [ floatArg_ ]
    , bool =
        \boolArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Encode" ]
                    , name = "bool"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.bool ]
                                (Type.namedWith
                                    [ "Json", "Encode" ]
                                    "Value"
                                    []
                                )
                            )
                    }
                )
                [ boolArg_ ]
    , list =
        \listArg_ listArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Encode" ]
                    , name = "list"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.namedWith
                                        [ "Json", "Encode" ]
                                        "Value"
                                        []
                                    )
                                , Type.list (Type.var "a")
                                ]
                                (Type.namedWith
                                    [ "Json", "Encode" ]
                                    "Value"
                                    []
                                )
                            )
                    }
                )
                [ listArg_, listArg_0 ]
    , array =
        \arrayArg_ arrayArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Encode" ]
                    , name = "array"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.namedWith
                                        [ "Json", "Encode" ]
                                        "Value"
                                        []
                                    )
                                , Type.namedWith
                                    [ "Array" ]
                                    "Array"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Encode" ]
                                    "Value"
                                    []
                                )
                            )
                    }
                )
                [ arrayArg_, arrayArg_0 ]
    , set =
        \setArg_ setArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Encode" ]
                    , name = "set"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.var "a" ]
                                    (Type.namedWith
                                        [ "Json", "Encode" ]
                                        "Value"
                                        []
                                    )
                                , Type.namedWith
                                    [ "Set" ]
                                    "Set"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Encode" ]
                                    "Value"
                                    []
                                )
                            )
                    }
                )
                [ setArg_, setArg_0 ]
    , object =
        \objectArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Encode" ]
                    , name = "object"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.tuple
                                        Type.string
                                        (Type.namedWith
                                            [ "Json", "Encode" ]
                                            "Value"
                                            []
                                        )
                                    )
                                ]
                                (Type.namedWith
                                    [ "Json", "Encode" ]
                                    "Value"
                                    []
                                )
                            )
                    }
                )
                [ objectArg_ ]
    , dict =
        \dictArg_ dictArg_0 dictArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Json", "Encode" ]
                    , name = "dict"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function [ Type.var "k" ] Type.string
                                , Type.function
                                    [ Type.var "v" ]
                                    (Type.namedWith
                                        [ "Json", "Encode" ]
                                        "Value"
                                        []
                                    )
                                , Type.namedWith
                                    [ "Dict" ]
                                    "Dict"
                                    [ Type.var "k", Type.var "v" ]
                                ]
                                (Type.namedWith
                                    [ "Json", "Encode" ]
                                    "Value"
                                    []
                                )
                            )
                    }
                )
                [ dictArg_, dictArg_0, dictArg_1 ]
    }
