module Gen.Json.Encode.Extra exposing ( moduleName_, maybe, call_, values_ )

{-|
# Generated bindings for Json.Encode.Extra

@docs moduleName_, maybe, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Json", "Encode", "Extra" ]


{-| Encode a Maybe value. If the value is `Nothing` it will be encoded as `null`

    import Json.Encode exposing (..)


    maybe int (Just 50)
    --> int 50


    maybe int Nothing
    --> null

maybe: (a -> Json.Encode.Value) -> Maybe a -> Json.Encode.Value
-}
maybe : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
maybe maybeArg_ maybeArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Json", "Encode", "Extra" ]
             , name = "maybe"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a" ]
                              (Type.namedWith [ "Json", "Encode" ] "Value" [])
                          , Type.maybe (Type.var "a")
                          ]
                          (Type.namedWith [ "Json", "Encode" ] "Value" [])
                     )
             }
        )
        [ Elm.functionReduced "maybeUnpack" maybeArg_, maybeArg_0 ]


call_ : { maybe : Elm.Expression -> Elm.Expression -> Elm.Expression }
call_ =
    { maybe =
        \maybeArg_ maybeArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Json", "Encode", "Extra" ]
                     , name = "maybe"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.namedWith
                                         [ "Json", "Encode" ]
                                         "Value"
                                         []
                                      )
                                  , Type.maybe (Type.var "a")
                                  ]
                                  (Type.namedWith
                                       [ "Json", "Encode" ]
                                       "Value"
                                       []
                                  )
                             )
                     }
                )
                [ maybeArg_, maybeArg_0 ]
    }


values_ : { maybe : Elm.Expression }
values_ =
    { maybe =
        Elm.value
            { importFrom = [ "Json", "Encode", "Extra" ]
            , name = "maybe"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a" ]
                             (Type.namedWith [ "Json", "Encode" ] "Value" [])
                         , Type.maybe (Type.var "a")
                         ]
                         (Type.namedWith [ "Json", "Encode" ] "Value" [])
                    )
            }
    }