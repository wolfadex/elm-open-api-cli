module Gen.Bytes exposing (width, annotation_)

{-|


# Generated bindings for Bytes

@docs width, annotation_

-}

import Elm
import Elm.Annotation as Type


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


annotation_ : { bytes : Type.Annotation, endianness : Type.Annotation }
annotation_ =
    { bytes = Type.namedWith [ "Bytes" ] "Bytes" []
    , endianness = Type.namedWith [ "Bytes" ] "Endianness" []
    }
