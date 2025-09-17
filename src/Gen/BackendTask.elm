module Gen.BackendTask exposing (annotation_)

{-|


# Generated bindings for BackendTask

@docs map
@docs map56
@docs annotation_

-}

import Elm.Annotation as Type


{-| The name of this module.
-}
moduleName_ : List String
moduleName_ =
    [ "BackendTask" ]


annotation_ : { backendTask : Type.Annotation -> Type.Annotation -> Type.Annotation }
annotation_ =
    { backendTask =
        \backendTaskArg0 backendTaskArg1 ->
            Type.alias
                moduleName_
                "BackendTask"
                [ backendTaskArg0, backendTaskArg1 ]
                (Type.namedWith
                    [ "Pages", "StaticHttpRequest" ]
                    "RawRequest"
                    [ Type.var "error", Type.var "value" ]
                )
    }
