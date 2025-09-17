module Gen.Effect.Task exposing (annotation_)

{-|


# Generated bindings for Effect.Task

@docs annotation_

-}

import Elm.Annotation as Type


{-| The name of this module.
-}
moduleName_ : List String
moduleName_ =
    [ "Effect", "Task" ]


annotation_ :
    { task :
        Type.Annotation -> Type.Annotation -> Type.Annotation -> Type.Annotation
    }
annotation_ =
    { task =
        \taskArg0 taskArg1 taskArg2 ->
            Type.alias
                moduleName_
                "Task"
                [ taskArg0, taskArg1, taskArg2 ]
                (Type.namedWith
                    [ "Effect", "Internal" ]
                    "Task"
                    [ Type.var "restriction", Type.var "x", Type.var "a" ]
                )
    }
