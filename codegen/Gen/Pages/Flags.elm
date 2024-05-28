module Gen.Pages.Flags exposing (annotation_, caseOf_, make_, moduleName_)

{-| 
@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Flags" ]


annotation_ : { flags : Type.Annotation }
annotation_ =
    { flags = Type.namedWith [ "Pages", "Flags" ] "Flags" [] }


make_ :
    { browserFlags : Elm.Expression -> Elm.Expression
    , preRenderFlags : Elm.Expression
    }
make_ =
    { browserFlags =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Flags" ]
                     , name = "BrowserFlags"
                     , annotation = Just (Type.namedWith [] "Flags" [])
                     }
                )
                [ ar0 ]
    , preRenderFlags =
        Elm.value
            { importFrom = [ "Pages", "Flags" ]
            , name = "PreRenderFlags"
            , annotation = Just (Type.namedWith [] "Flags" [])
            }
    }


caseOf_ :
    { flags :
        Elm.Expression
        -> { flagsTags_0_0
            | browserFlags : Elm.Expression -> Elm.Expression
            , preRenderFlags : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { flags =
        \flagsExpression flagsTags ->
            Elm.Case.custom
                flagsExpression
                (Type.namedWith [ "Pages", "Flags" ] "Flags" [])
                [ Elm.Case.branch1
                    "BrowserFlags"
                    ( "jsonDecodeValue"
                    , Type.namedWith [ "Json", "Decode" ] "Value" []
                    )
                    flagsTags.browserFlags
                , Elm.Case.branch0 "PreRenderFlags" flagsTags.preRenderFlags
                ]
    }