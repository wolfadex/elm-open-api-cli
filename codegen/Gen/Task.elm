module Gen.Task exposing (annotation_)

{-|


# Generated bindings for Task

@docs map
@docs onErrorError, annotation_

-}

import Elm.Annotation as Type


{-| The name of this module.
-}
moduleName_ : List String
moduleName_ =
    [ "Task" ]


annotation_ : { task : Type.Annotation -> Type.Annotation -> Type.Annotation }
annotation_ =
    { task =
        \taskArg0 taskArg1 ->
            Type.alias
                moduleName_
                "Task"
                [ taskArg0, taskArg1 ]
                (Type.namedWith
                    [ "Platform" ]
                    "Task"
                    [ Type.var "x", Type.var "a" ]
                )
    }
