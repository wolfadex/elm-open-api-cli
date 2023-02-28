module Gen.Bytes exposing (annotation_, call_, caseOf_, getHostEndianness, make_, moduleName_, values_, width)

{-| 
@docs values_, call_, caseOf_, make_, annotation_, getHostEndianness, width, moduleName_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Bytes" ]


{-| Get the width of a sequence of bytes.

So if a sequence has four-hundred bytes, then `width bytes` would give back
`400`. That may be 400 unsigned 8-bit integers, 100 signed 32-bit integers, or
even a UTF-8 string. The content does not matter. This is just figuring out
how many bytes there are!

width: Bytes.Bytes -> Int
-}
width : Elm.Expression -> Elm.Expression
width widthArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Bytes" ]
            , name = "width"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Bytes" [] ]
                        Type.int
                    )
            }
        )
        [ widthArg ]


{-| Is this program running on a big-endian or little-endian machine?

getHostEndianness: Task.Task x Bytes.Endianness
-}
getHostEndianness : Elm.Expression
getHostEndianness =
    Elm.value
        { importFrom = [ "Bytes" ]
        , name = "getHostEndianness"
        , annotation =
            Just
                (Type.namedWith
                    [ "Task" ]
                    "Task"
                    [ Type.var "x", Type.namedWith [ "Bytes" ] "Endianness" [] ]
                )
        }


annotation_ : { bytes : Type.Annotation, endianness : Type.Annotation }
annotation_ =
    { bytes = Type.namedWith [ "Bytes" ] "Bytes" []
    , endianness = Type.namedWith [ "Bytes" ] "Endianness" []
    }


make_ : { lE : Elm.Expression, bE : Elm.Expression }
make_ =
    { lE =
        Elm.value
            { importFrom = [ "Bytes" ]
            , name = "LE"
            , annotation = Just (Type.namedWith [] "Endianness" [])
            }
    , bE =
        Elm.value
            { importFrom = [ "Bytes" ]
            , name = "BE"
            , annotation = Just (Type.namedWith [] "Endianness" [])
            }
    }


caseOf_ :
    { endianness :
        Elm.Expression
        -> { endiannessTags_0_0 | lE : Elm.Expression, bE : Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { endianness =
        \endiannessExpression endiannessTags ->
            Elm.Case.custom
                endiannessExpression
                (Type.namedWith [ "Bytes" ] "Endianness" [])
                [ Elm.Case.branch0 "LE" endiannessTags.lE
                , Elm.Case.branch0 "BE" endiannessTags.bE
                ]
    }


call_ : { width : Elm.Expression -> Elm.Expression }
call_ =
    { width =
        \widthArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Bytes" ]
                    , name = "width"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Bytes" ] "Bytes" [] ]
                                Type.int
                            )
                    }
                )
                [ widthArg ]
    }


values_ : { width : Elm.Expression, getHostEndianness : Elm.Expression }
values_ =
    { width =
        Elm.value
            { importFrom = [ "Bytes" ]
            , name = "width"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Bytes" ] "Bytes" [] ]
                        Type.int
                    )
            }
    , getHostEndianness =
        Elm.value
            { importFrom = [ "Bytes" ]
            , name = "getHostEndianness"
            , annotation =
                Just
                    (Type.namedWith
                        [ "Task" ]
                        "Task"
                        [ Type.var "x"
                        , Type.namedWith [ "Bytes" ] "Endianness" []
                        ]
                    )
            }
    }


