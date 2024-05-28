module Gen.Pages.Internal.Router exposing (annotation_, call_, firstMatch, fromOptionalSplat, make_, maybeToList, moduleName_, nonEmptyToList, toNonEmpty, values_)

{-| 
@docs moduleName_, firstMatch, fromOptionalSplat, maybeToList, nonEmptyToList, toNonEmpty, annotation_, make_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Internal", "Router" ]


{-| firstMatch: List (Pages.Internal.Router.Matcher route) -> String -> Maybe route -}
firstMatch : List Elm.Expression -> String -> Elm.Expression
firstMatch firstMatchArg firstMatchArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "Router" ]
             , name = "firstMatch"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "Pages", "Internal", "Router" ]
                                 "Matcher"
                                 [ Type.var "route" ]
                              )
                          , Type.string
                          ]
                          (Type.maybe (Type.var "route"))
                     )
             }
        )
        [ Elm.list firstMatchArg, Elm.string firstMatchArg0 ]


{-| fromOptionalSplat: Maybe String -> List String -}
fromOptionalSplat : Elm.Expression -> Elm.Expression
fromOptionalSplat fromOptionalSplatArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "Router" ]
             , name = "fromOptionalSplat"
             , annotation =
                 Just
                     (Type.function
                          [ Type.maybe Type.string ]
                          (Type.list Type.string)
                     )
             }
        )
        [ fromOptionalSplatArg ]


{-| maybeToList: Maybe String -> List String -}
maybeToList : Elm.Expression -> Elm.Expression
maybeToList maybeToListArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "Router" ]
             , name = "maybeToList"
             , annotation =
                 Just
                     (Type.function
                          [ Type.maybe Type.string ]
                          (Type.list Type.string)
                     )
             }
        )
        [ maybeToListArg ]


{-| nonEmptyToList: ( String, List String ) -> List String -}
nonEmptyToList : Elm.Expression -> Elm.Expression
nonEmptyToList nonEmptyToListArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "Router" ]
             , name = "nonEmptyToList"
             , annotation =
                 Just
                     (Type.function
                          [ Type.tuple Type.string (Type.list Type.string) ]
                          (Type.list Type.string)
                     )
             }
        )
        [ nonEmptyToListArg ]


{-| toNonEmpty: String -> ( String, List String ) -}
toNonEmpty : String -> Elm.Expression
toNonEmpty toNonEmptyArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "Router" ]
             , name = "toNonEmpty"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.tuple Type.string (Type.list Type.string))
                     )
             }
        )
        [ Elm.string toNonEmptyArg ]


annotation_ : { matcher : Type.Annotation -> Type.Annotation }
annotation_ =
    { matcher =
        \matcherArg0 ->
            Type.alias
                moduleName_
                "Matcher"
                [ matcherArg0 ]
                (Type.record
                     [ ( "pattern", Type.string )
                     , ( "toRoute"
                       , Type.function
                             [ Type.list (Type.maybe Type.string) ]
                             (Type.maybe (Type.var "route"))
                       )
                     ]
                )
    }


make_ :
    { matcher :
        { pattern : Elm.Expression, toRoute : Elm.Expression } -> Elm.Expression
    }
make_ =
    { matcher =
        \matcher_args ->
            Elm.withType
                (Type.alias
                     [ "Pages", "Internal", "Router" ]
                     "Matcher"
                     [ Type.var "route" ]
                     (Type.record
                          [ ( "pattern", Type.string )
                          , ( "toRoute"
                            , Type.function
                                  [ Type.list (Type.maybe Type.string) ]
                                  (Type.maybe (Type.var "route"))
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "pattern" matcher_args.pattern
                     , Tuple.pair "toRoute" matcher_args.toRoute
                     ]
                )
    }


call_ :
    { firstMatch : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fromOptionalSplat : Elm.Expression -> Elm.Expression
    , maybeToList : Elm.Expression -> Elm.Expression
    , nonEmptyToList : Elm.Expression -> Elm.Expression
    , toNonEmpty : Elm.Expression -> Elm.Expression
    }
call_ =
    { firstMatch =
        \firstMatchArg firstMatchArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Router" ]
                     , name = "firstMatch"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "Pages", "Internal", "Router" ]
                                         "Matcher"
                                         [ Type.var "route" ]
                                      )
                                  , Type.string
                                  ]
                                  (Type.maybe (Type.var "route"))
                             )
                     }
                )
                [ firstMatchArg, firstMatchArg0 ]
    , fromOptionalSplat =
        \fromOptionalSplatArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Router" ]
                     , name = "fromOptionalSplat"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.maybe Type.string ]
                                  (Type.list Type.string)
                             )
                     }
                )
                [ fromOptionalSplatArg ]
    , maybeToList =
        \maybeToListArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Router" ]
                     , name = "maybeToList"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.maybe Type.string ]
                                  (Type.list Type.string)
                             )
                     }
                )
                [ maybeToListArg ]
    , nonEmptyToList =
        \nonEmptyToListArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Router" ]
                     , name = "nonEmptyToList"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.tuple
                                      Type.string
                                      (Type.list Type.string)
                                  ]
                                  (Type.list Type.string)
                             )
                     }
                )
                [ nonEmptyToListArg ]
    , toNonEmpty =
        \toNonEmptyArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "Router" ]
                     , name = "toNonEmpty"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.tuple
                                       Type.string
                                       (Type.list Type.string)
                                  )
                             )
                     }
                )
                [ toNonEmptyArg ]
    }


values_ :
    { firstMatch : Elm.Expression
    , fromOptionalSplat : Elm.Expression
    , maybeToList : Elm.Expression
    , nonEmptyToList : Elm.Expression
    , toNonEmpty : Elm.Expression
    }
values_ =
    { firstMatch =
        Elm.value
            { importFrom = [ "Pages", "Internal", "Router" ]
            , name = "firstMatch"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "Pages", "Internal", "Router" ]
                                "Matcher"
                                [ Type.var "route" ]
                             )
                         , Type.string
                         ]
                         (Type.maybe (Type.var "route"))
                    )
            }
    , fromOptionalSplat =
        Elm.value
            { importFrom = [ "Pages", "Internal", "Router" ]
            , name = "fromOptionalSplat"
            , annotation =
                Just
                    (Type.function
                         [ Type.maybe Type.string ]
                         (Type.list Type.string)
                    )
            }
    , maybeToList =
        Elm.value
            { importFrom = [ "Pages", "Internal", "Router" ]
            , name = "maybeToList"
            , annotation =
                Just
                    (Type.function
                         [ Type.maybe Type.string ]
                         (Type.list Type.string)
                    )
            }
    , nonEmptyToList =
        Elm.value
            { importFrom = [ "Pages", "Internal", "Router" ]
            , name = "nonEmptyToList"
            , annotation =
                Just
                    (Type.function
                         [ Type.tuple Type.string (Type.list Type.string) ]
                         (Type.list Type.string)
                    )
            }
    , toNonEmpty =
        Elm.value
            { importFrom = [ "Pages", "Internal", "Router" ]
            , name = "toNonEmpty"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.tuple Type.string (Type.list Type.string))
                    )
            }
    }