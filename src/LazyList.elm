module LazyList exposing (LazyList(..), fromList, uniquePairs)


type LazyList a
    = LazyEmpty
    | LazyCons a (() -> LazyList a)


fromList : List a -> LazyList a
fromList q =
    List.foldr (\e a -> LazyCons e (\_ -> a)) LazyEmpty q


uniquePairs : LazyList a -> LazyList ( a, a )
uniquePairs xs =
    case xs of
        LazyEmpty ->
            LazyEmpty

        LazyCons x xs_ ->
            let
                tail : LazyList a
                tail =
                    xs_ ()
            in
            append
                (map (\y -> ( x, y )) tail)
                (\() -> uniquePairs tail)


append : LazyList a -> (() -> LazyList a) -> LazyList a
append l r =
    case l of
        LazyEmpty ->
            r ()

        LazyCons h t ->
            LazyCons h (\() -> append (t ()) r)


map : (a -> b) -> LazyList a -> LazyList b
map f l =
    case l of
        LazyEmpty ->
            LazyEmpty

        LazyCons h t ->
            LazyCons (f h) (\() -> map f (t ()))
