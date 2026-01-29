module NonEmpty exposing (NonEmpty, fromList, head, map, sort, sortBy, toList)


type alias NonEmpty a =
    ( a, List a )


head : NonEmpty a -> a
head ( h, _ ) =
    h


fromList : List a -> Maybe (NonEmpty a)
fromList l =
    case l of
        [] ->
            Nothing

        h :: t ->
            Just ( h, t )


toList : NonEmpty a -> List a
toList ( h, t ) =
    h :: t


map : (a -> b) -> NonEmpty a -> NonEmpty b
map f ( h, t ) =
    ( f h, List.map f t )


sort : NonEmpty comparable -> NonEmpty comparable
sort ( h, t ) =
    case List.sort (h :: t) of
        [] ->
            -- This is impossible, the result is irrelevant
            ( h, t )

        nh :: nt ->
            ( nh, nt )


sortBy : (a -> comparable) -> ( a, List a ) -> ( a, List a )
sortBy f ( h, t ) =
    case List.sortBy f (h :: t) of
        [] ->
            -- This is impossible, the result is irrelevant
            ( h, t )

        nh :: nt ->
            ( nh, nt )
