module Gen.Pages.Flags exposing (annotation_, caseOf_, make_, moduleName_)

{-|
# Generated bindings for Pages.Flags

@docs moduleName_, annotation_, make_, caseOf_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
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
        -> { browserFlags : Elm.Expression -> Elm.Expression
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
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "BrowserFlags"
                       flagsTags.browserFlags |> Elm.Arg.item
                                                       (Elm.Arg.var
                                                              "jsonDecodeValue"
                                                       )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "PreRenderFlags"
                       flagsTags.preRenderFlags
                    )
                    Basics.identity
                ]
    }