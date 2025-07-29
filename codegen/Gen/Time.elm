module Gen.Time exposing (annotation_)

{-|


# Generated bindings for Time

@docs annotation_

-}

import Elm.Annotation as Type


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
