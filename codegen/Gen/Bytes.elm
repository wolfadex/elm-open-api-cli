module Gen.Bytes exposing
    ( moduleName_, width, getHostEndianness, annotation_, make_, caseOf_
    , call_, values_
    )

{-|
# Generated bindings for Bytes

@docs moduleName_, width, getHostEndianness, annotation_, make_, caseOf_
@docs call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
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
width widthArg_ =
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
        [ widthArg_ ]


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
                     [ Type.var "x"
                     , Type.namedWith [ "Bytes" ] "Endianness" []
                     ]
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
        -> { lE : Elm.Expression, bE : Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { endianness =
        \endiannessExpression endiannessTags ->
            Elm.Case.custom
                endiannessExpression
                (Type.namedWith [ "Bytes" ] "Endianness" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType "LE" endiannessTags.lE)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "BE" endiannessTags.bE)
                    Basics.identity
                ]
    }


call_ : { width : Elm.Expression -> Elm.Expression }
call_ =
    { width =
        \widthArg_ ->
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
                [ widthArg_ ]
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