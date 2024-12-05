module BackendTask.Extra exposing (combineMap)

import BackendTask


combineMap :
    (a -> BackendTask.BackendTask error value)
    -> List a
    -> BackendTask.BackendTask error (List value)
combineMap f list =
    BackendTask.combine (List.map f list)
