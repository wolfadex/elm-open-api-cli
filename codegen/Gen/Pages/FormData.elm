module Gen.Pages.FormData exposing ( moduleName_, annotation_, make_ )

{-|
# Generated bindings for Pages.FormData

@docs moduleName_, annotation_, make_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "FormData" ]


annotation_ : { formData : Type.Annotation }
annotation_ =
    { formData =
        Type.alias
            moduleName_
            "FormData"
            []
            (Type.record
                 [ ( "fields", Type.list (Type.tuple Type.string Type.string) )
                 , ( "method", Type.namedWith [ "Form" ] "Method" [] )
                 , ( "action", Type.string )
                 , ( "id", Type.maybe Type.string )
                 ]
            )
    }


make_ :
    { formData :
        { fields : Elm.Expression
        , method : Elm.Expression
        , action : Elm.Expression
        , id : Elm.Expression
        }
        -> Elm.Expression
    }
make_ =
    { formData =
        \formData_args ->
            Elm.withType
                (Type.alias
                     [ "Pages", "FormData" ]
                     "FormData"
                     []
                     (Type.record
                          [ ( "fields"
                            , Type.list (Type.tuple Type.string Type.string)
                            )
                          , ( "method", Type.namedWith [ "Form" ] "Method" [] )
                          , ( "action", Type.string )
                          , ( "id", Type.maybe Type.string )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "fields" formData_args.fields
                     , Tuple.pair "method" formData_args.method
                     , Tuple.pair "action" formData_args.action
                     , Tuple.pair "id" formData_args.id
                     ]
                )
    }