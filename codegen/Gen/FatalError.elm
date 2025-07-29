module Gen.FatalError exposing (annotation_)

{-|


# Generated bindings for FatalError

@docs annotation_

-}

import Elm.Annotation as Type


{-| The name of this module.
-}
moduleName_ : List String
moduleName_ =
    [ "FatalError" ]


annotation_ : { fatalError : Type.Annotation }
annotation_ =
    { fatalError =
        Type.alias
            moduleName_
            "FatalError"
            []
            (Type.namedWith
                [ "Pages", "Internal", "FatalError" ]
                "FatalError"
                []
            )
    }
