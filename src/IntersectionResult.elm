module IntersectionResult exposing (IntersectionResult(..), map)


type IntersectionResult a
    = NoIntersection
    | MayIntersect -- Because recursive or unimplemented
    | FoundIntersection a


map : (a -> b) -> IntersectionResult a -> IntersectionResult b
map f r =
    case r of
        MayIntersect ->
            MayIntersect

        NoIntersection ->
            NoIntersection

        FoundIntersection x ->
            FoundIntersection (f x)
