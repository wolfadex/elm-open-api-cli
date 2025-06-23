module Gen.Pages.Internal.RoutePattern exposing
    ( moduleName_, view, toVariant, routeToBranch, fromModuleName, hasRouteParams
    , repeatWithoutOptionalEnding, toModuleName, toRouteParamTypes, toRouteParamsRecord, toVariantName, annotation_, make_
    , caseOf_, call_, values_
    )

{-|
# Generated bindings for Pages.Internal.RoutePattern

@docs moduleName_, view, toVariant, routeToBranch, fromModuleName, hasRouteParams
@docs repeatWithoutOptionalEnding, toModuleName, toRouteParamTypes, toRouteParamsRecord, toVariantName, annotation_
@docs make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Internal", "RoutePattern" ]


{-| view: Pages.Internal.RoutePattern.RoutePattern -> Html.Html msg -}
view : Elm.Expression -> Elm.Expression
view viewArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "RoutePattern" ]
             , name = "view"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Internal", "RoutePattern" ]
                              "RoutePattern"
                              []
                          ]
                          (Type.namedWith [ "Html" ] "Html" [ Type.var "msg" ])
                     )
             }
        )
        [ viewArg_ ]


{-| toVariant: Pages.Internal.RoutePattern.RoutePattern -> Elm.Variant -}
toVariant : Elm.Expression -> Elm.Expression
toVariant toVariantArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "RoutePattern" ]
             , name = "toVariant"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Internal", "RoutePattern" ]
                              "RoutePattern"
                              []
                          ]
                          (Type.namedWith [ "Elm" ] "Variant" [])
                     )
             }
        )
        [ toVariantArg_ ]


{-| routeToBranch: 
    Pages.Internal.RoutePattern.RoutePattern
    -> List ( Elm.CodeGen.Pattern, Elm.CodeGen.Expression )
-}
routeToBranch : Elm.Expression -> Elm.Expression
routeToBranch routeToBranchArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "RoutePattern" ]
             , name = "routeToBranch"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Internal", "RoutePattern" ]
                              "RoutePattern"
                              []
                          ]
                          (Type.list
                               (Type.tuple
                                    (Type.namedWith
                                         [ "Elm", "CodeGen" ]
                                         "Pattern"
                                         []
                                    )
                                    (Type.namedWith
                                         [ "Elm", "CodeGen" ]
                                         "Expression"
                                         []
                                    )
                               )
                          )
                     )
             }
        )
        [ routeToBranchArg_ ]


{-| fromModuleName: List String -> Maybe Pages.Internal.RoutePattern.RoutePattern -}
fromModuleName : List String -> Elm.Expression
fromModuleName fromModuleNameArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "RoutePattern" ]
             , name = "fromModuleName"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list Type.string ]
                          (Type.maybe
                               (Type.namedWith
                                    [ "Pages", "Internal", "RoutePattern" ]
                                    "RoutePattern"
                                    []
                               )
                          )
                     )
             }
        )
        [ Elm.list (List.map Elm.string fromModuleNameArg_) ]


{-| hasRouteParams: Pages.Internal.RoutePattern.RoutePattern -> Bool -}
hasRouteParams : Elm.Expression -> Elm.Expression
hasRouteParams hasRouteParamsArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "RoutePattern" ]
             , name = "hasRouteParams"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Internal", "RoutePattern" ]
                              "RoutePattern"
                              []
                          ]
                          Type.bool
                     )
             }
        )
        [ hasRouteParamsArg_ ]


{-| repeatWithoutOptionalEnding: 
    List Pages.Internal.RoutePattern.RouteParam
    -> Maybe (List Pages.Internal.RoutePattern.RouteParam)
-}
repeatWithoutOptionalEnding : List Elm.Expression -> Elm.Expression
repeatWithoutOptionalEnding repeatWithoutOptionalEndingArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "RoutePattern" ]
             , name = "repeatWithoutOptionalEnding"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "Pages", "Internal", "RoutePattern" ]
                                 "RouteParam"
                                 []
                              )
                          ]
                          (Type.maybe
                               (Type.list
                                    (Type.namedWith
                                         [ "Pages", "Internal", "RoutePattern" ]
                                         "RouteParam"
                                         []
                                    )
                               )
                          )
                     )
             }
        )
        [ Elm.list repeatWithoutOptionalEndingArg_ ]


{-| toModuleName: Pages.Internal.RoutePattern.RoutePattern -> List String -}
toModuleName : Elm.Expression -> Elm.Expression
toModuleName toModuleNameArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "RoutePattern" ]
             , name = "toModuleName"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Internal", "RoutePattern" ]
                              "RoutePattern"
                              []
                          ]
                          (Type.list Type.string)
                     )
             }
        )
        [ toModuleNameArg_ ]


{-| toRouteParamTypes: 
    Pages.Internal.RoutePattern.RoutePattern
    -> List ( String, Pages.Internal.RoutePattern.Param )
-}
toRouteParamTypes : Elm.Expression -> Elm.Expression
toRouteParamTypes toRouteParamTypesArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "RoutePattern" ]
             , name = "toRouteParamTypes"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Internal", "RoutePattern" ]
                              "RoutePattern"
                              []
                          ]
                          (Type.list
                               (Type.tuple
                                    Type.string
                                    (Type.namedWith
                                         [ "Pages", "Internal", "RoutePattern" ]
                                         "Param"
                                         []
                                    )
                               )
                          )
                     )
             }
        )
        [ toRouteParamTypesArg_ ]


{-| toRouteParamsRecord: 
    Pages.Internal.RoutePattern.RoutePattern
    -> List ( String, Elm.Annotation.Annotation )
-}
toRouteParamsRecord : Elm.Expression -> Elm.Expression
toRouteParamsRecord toRouteParamsRecordArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "RoutePattern" ]
             , name = "toRouteParamsRecord"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Internal", "RoutePattern" ]
                              "RoutePattern"
                              []
                          ]
                          (Type.list
                               (Type.tuple
                                    Type.string
                                    (Type.namedWith
                                         [ "Elm", "Annotation" ]
                                         "Annotation"
                                         []
                                    )
                               )
                          )
                     )
             }
        )
        [ toRouteParamsRecordArg_ ]


{-| toVariantName: 
    Pages.Internal.RoutePattern.RoutePattern
    -> { variantName : String
    , params : List Pages.Internal.RoutePattern.RouteParam
    }
-}
toVariantName : Elm.Expression -> Elm.Expression
toVariantName toVariantNameArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "Pages", "Internal", "RoutePattern" ]
             , name = "toVariantName"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Internal", "RoutePattern" ]
                              "RoutePattern"
                              []
                          ]
                          (Type.record
                               [ ( "variantName", Type.string )
                               , ( "params"
                                 , Type.list
                                       (Type.namedWith
                                            [ "Pages"
                                            , "Internal"
                                            , "RoutePattern"
                                            ]
                                            "RouteParam"
                                            []
                                       )
                                 )
                               ]
                          )
                     )
             }
        )
        [ toVariantNameArg_ ]


annotation_ :
    { ending : Type.Annotation
    , routePattern : Type.Annotation
    , segment : Type.Annotation
    , param : Type.Annotation
    , routeParam : Type.Annotation
    }
annotation_ =
    { ending =
        Type.namedWith [ "Pages", "Internal", "RoutePattern" ] "Ending" []
    , routePattern =
        Type.alias
            moduleName_
            "RoutePattern"
            []
            (Type.record
                 [ ( "segments"
                   , Type.list
                         (Type.namedWith
                              [ "Pages", "Internal", "RoutePattern" ]
                              "Segment"
                              []
                         )
                   )
                 , ( "ending"
                   , Type.maybe
                         (Type.namedWith
                              [ "Pages", "Internal", "RoutePattern" ]
                              "Ending"
                              []
                         )
                   )
                 ]
            )
    , segment =
        Type.namedWith [ "Pages", "Internal", "RoutePattern" ] "Segment" []
    , param = Type.namedWith [ "Pages", "Internal", "RoutePattern" ] "Param" []
    , routeParam =
        Type.namedWith [ "Pages", "Internal", "RoutePattern" ] "RouteParam" []
    }


make_ :
    { optional : Elm.Expression -> Elm.Expression
    , requiredSplat : Elm.Expression
    , optionalSplat : Elm.Expression
    , routePattern :
        { segments : Elm.Expression, ending : Elm.Expression } -> Elm.Expression
    , staticSegment : Elm.Expression -> Elm.Expression
    , dynamicSegment : Elm.Expression -> Elm.Expression
    , requiredParam : Elm.Expression
    , optionalParam : Elm.Expression
    , requiredSplatParam : Elm.Expression
    , optionalSplatParam : Elm.Expression
    , staticParam : Elm.Expression -> Elm.Expression
    , dynamicParam : Elm.Expression -> Elm.Expression
    , optionalParam2 : Elm.Expression -> Elm.Expression
    , requiredSplatParam2 : Elm.Expression
    , optionalSplatParam2 : Elm.Expression
    }
make_ =
    { optional =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "RoutePattern" ]
                     , name = "Optional"
                     , annotation = Just (Type.namedWith [] "Ending" [])
                     }
                )
                [ ar0 ]
    , requiredSplat =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "RequiredSplat"
            , annotation = Just (Type.namedWith [] "Ending" [])
            }
    , optionalSplat =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "OptionalSplat"
            , annotation = Just (Type.namedWith [] "Ending" [])
            }
    , routePattern =
        \routePattern_args ->
            Elm.withType
                (Type.alias
                     [ "Pages", "Internal", "RoutePattern" ]
                     "RoutePattern"
                     []
                     (Type.record
                          [ ( "segments"
                            , Type.list
                                  (Type.namedWith
                                       [ "Pages", "Internal", "RoutePattern" ]
                                       "Segment"
                                       []
                                  )
                            )
                          , ( "ending"
                            , Type.maybe
                                  (Type.namedWith
                                       [ "Pages", "Internal", "RoutePattern" ]
                                       "Ending"
                                       []
                                  )
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "segments" routePattern_args.segments
                     , Tuple.pair "ending" routePattern_args.ending
                     ]
                )
    , staticSegment =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "RoutePattern" ]
                     , name = "StaticSegment"
                     , annotation = Just (Type.namedWith [] "Segment" [])
                     }
                )
                [ ar0 ]
    , dynamicSegment =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "RoutePattern" ]
                     , name = "DynamicSegment"
                     , annotation = Just (Type.namedWith [] "Segment" [])
                     }
                )
                [ ar0 ]
    , requiredParam =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "RequiredParam"
            , annotation = Just (Type.namedWith [] "Param" [])
            }
    , optionalParam =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "OptionalParam"
            , annotation = Just (Type.namedWith [] "Param" [])
            }
    , requiredSplatParam =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "RequiredSplatParam"
            , annotation = Just (Type.namedWith [] "Param" [])
            }
    , optionalSplatParam =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "OptionalSplatParam"
            , annotation = Just (Type.namedWith [] "Param" [])
            }
    , staticParam =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "RoutePattern" ]
                     , name = "StaticParam"
                     , annotation = Just (Type.namedWith [] "RouteParam" [])
                     }
                )
                [ ar0 ]
    , dynamicParam =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "RoutePattern" ]
                     , name = "DynamicParam"
                     , annotation = Just (Type.namedWith [] "RouteParam" [])
                     }
                )
                [ ar0 ]
    , optionalParam2 =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "RoutePattern" ]
                     , name = "OptionalParam2"
                     , annotation = Just (Type.namedWith [] "RouteParam" [])
                     }
                )
                [ ar0 ]
    , requiredSplatParam2 =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "RequiredSplatParam2"
            , annotation = Just (Type.namedWith [] "RouteParam" [])
            }
    , optionalSplatParam2 =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "OptionalSplatParam2"
            , annotation = Just (Type.namedWith [] "RouteParam" [])
            }
    }


caseOf_ :
    { ending :
        Elm.Expression
        -> { optional : Elm.Expression -> Elm.Expression
        , requiredSplat : Elm.Expression
        , optionalSplat : Elm.Expression
        }
        -> Elm.Expression
    , segment :
        Elm.Expression
        -> { staticSegment : Elm.Expression -> Elm.Expression
        , dynamicSegment : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , param :
        Elm.Expression
        -> { requiredParam : Elm.Expression
        , optionalParam : Elm.Expression
        , requiredSplatParam : Elm.Expression
        , optionalSplatParam : Elm.Expression
        }
        -> Elm.Expression
    , routeParam :
        Elm.Expression
        -> { staticParam : Elm.Expression -> Elm.Expression
        , dynamicParam : Elm.Expression -> Elm.Expression
        , optionalParam2 : Elm.Expression -> Elm.Expression
        , requiredSplatParam2 : Elm.Expression
        , optionalSplatParam2 : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { ending =
        \endingExpression endingTags ->
            Elm.Case.custom
                endingExpression
                (Type.namedWith
                     [ "Pages", "Internal", "RoutePattern" ]
                     "Ending"
                     []
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "Optional"
                       endingTags.optional |> Elm.Arg.item
                                                    (Elm.Arg.varWith
                                                           "arg_0"
                                                           Type.string
                                                    )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "RequiredSplat" endingTags.requiredSplat
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "OptionalSplat" endingTags.optionalSplat
                    )
                    Basics.identity
                ]
    , segment =
        \segmentExpression segmentTags ->
            Elm.Case.custom
                segmentExpression
                (Type.namedWith
                     [ "Pages", "Internal", "RoutePattern" ]
                     "Segment"
                     []
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "StaticSegment"
                       segmentTags.staticSegment |> Elm.Arg.item
                                                          (Elm.Arg.varWith
                                                                 "arg_0"
                                                                 Type.string
                                                          )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "DynamicSegment"
                       segmentTags.dynamicSegment |> Elm.Arg.item
                                                           (Elm.Arg.varWith
                                                                  "arg_0"
                                                                  Type.string
                                                           )
                    )
                    Basics.identity
                ]
    , param =
        \paramExpression paramTags ->
            Elm.Case.custom
                paramExpression
                (Type.namedWith
                     [ "Pages", "Internal", "RoutePattern" ]
                     "Param"
                     []
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType "RequiredParam" paramTags.requiredParam)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "OptionalParam" paramTags.optionalParam)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "RequiredSplatParam"
                       paramTags.requiredSplatParam
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "OptionalSplatParam"
                       paramTags.optionalSplatParam
                    )
                    Basics.identity
                ]
    , routeParam =
        \routeParamExpression routeParamTags ->
            Elm.Case.custom
                routeParamExpression
                (Type.namedWith
                     [ "Pages", "Internal", "RoutePattern" ]
                     "RouteParam"
                     []
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "StaticParam"
                       routeParamTags.staticParam |> Elm.Arg.item
                                                           (Elm.Arg.varWith
                                                                  "arg_0"
                                                                  Type.string
                                                           )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "DynamicParam"
                       routeParamTags.dynamicParam |> Elm.Arg.item
                                                            (Elm.Arg.varWith
                                                                   "arg_0"
                                                                   Type.string
                                                            )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "OptionalParam2"
                       routeParamTags.optionalParam2 |> Elm.Arg.item
                                                              (Elm.Arg.varWith
                                                                     "arg_0"
                                                                     Type.string
                                                              )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "RequiredSplatParam2"
                       routeParamTags.requiredSplatParam2
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "OptionalSplatParam2"
                       routeParamTags.optionalSplatParam2
                    )
                    Basics.identity
                ]
    }


call_ :
    { view : Elm.Expression -> Elm.Expression
    , toVariant : Elm.Expression -> Elm.Expression
    , routeToBranch : Elm.Expression -> Elm.Expression
    , fromModuleName : Elm.Expression -> Elm.Expression
    , hasRouteParams : Elm.Expression -> Elm.Expression
    , repeatWithoutOptionalEnding : Elm.Expression -> Elm.Expression
    , toModuleName : Elm.Expression -> Elm.Expression
    , toRouteParamTypes : Elm.Expression -> Elm.Expression
    , toRouteParamsRecord : Elm.Expression -> Elm.Expression
    , toVariantName : Elm.Expression -> Elm.Expression
    }
call_ =
    { view =
        \viewArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "RoutePattern" ]
                     , name = "view"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Internal", "RoutePattern" ]
                                      "RoutePattern"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Html" ]
                                       "Html"
                                       [ Type.var "msg" ]
                                  )
                             )
                     }
                )
                [ viewArg_ ]
    , toVariant =
        \toVariantArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "RoutePattern" ]
                     , name = "toVariant"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Internal", "RoutePattern" ]
                                      "RoutePattern"
                                      []
                                  ]
                                  (Type.namedWith [ "Elm" ] "Variant" [])
                             )
                     }
                )
                [ toVariantArg_ ]
    , routeToBranch =
        \routeToBranchArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "RoutePattern" ]
                     , name = "routeToBranch"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Internal", "RoutePattern" ]
                                      "RoutePattern"
                                      []
                                  ]
                                  (Type.list
                                       (Type.tuple
                                            (Type.namedWith
                                                 [ "Elm", "CodeGen" ]
                                                 "Pattern"
                                                 []
                                            )
                                            (Type.namedWith
                                                 [ "Elm", "CodeGen" ]
                                                 "Expression"
                                                 []
                                            )
                                       )
                                  )
                             )
                     }
                )
                [ routeToBranchArg_ ]
    , fromModuleName =
        \fromModuleNameArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "RoutePattern" ]
                     , name = "fromModuleName"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list Type.string ]
                                  (Type.maybe
                                       (Type.namedWith
                                            [ "Pages"
                                            , "Internal"
                                            , "RoutePattern"
                                            ]
                                            "RoutePattern"
                                            []
                                       )
                                  )
                             )
                     }
                )
                [ fromModuleNameArg_ ]
    , hasRouteParams =
        \hasRouteParamsArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "RoutePattern" ]
                     , name = "hasRouteParams"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Internal", "RoutePattern" ]
                                      "RoutePattern"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ hasRouteParamsArg_ ]
    , repeatWithoutOptionalEnding =
        \repeatWithoutOptionalEndingArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "RoutePattern" ]
                     , name = "repeatWithoutOptionalEnding"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "Pages", "Internal", "RoutePattern" ]
                                         "RouteParam"
                                         []
                                      )
                                  ]
                                  (Type.maybe
                                       (Type.list
                                            (Type.namedWith
                                                 [ "Pages"
                                                 , "Internal"
                                                 , "RoutePattern"
                                                 ]
                                                 "RouteParam"
                                                 []
                                            )
                                       )
                                  )
                             )
                     }
                )
                [ repeatWithoutOptionalEndingArg_ ]
    , toModuleName =
        \toModuleNameArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "RoutePattern" ]
                     , name = "toModuleName"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Internal", "RoutePattern" ]
                                      "RoutePattern"
                                      []
                                  ]
                                  (Type.list Type.string)
                             )
                     }
                )
                [ toModuleNameArg_ ]
    , toRouteParamTypes =
        \toRouteParamTypesArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "RoutePattern" ]
                     , name = "toRouteParamTypes"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Internal", "RoutePattern" ]
                                      "RoutePattern"
                                      []
                                  ]
                                  (Type.list
                                       (Type.tuple
                                            Type.string
                                            (Type.namedWith
                                                 [ "Pages"
                                                 , "Internal"
                                                 , "RoutePattern"
                                                 ]
                                                 "Param"
                                                 []
                                            )
                                       )
                                  )
                             )
                     }
                )
                [ toRouteParamTypesArg_ ]
    , toRouteParamsRecord =
        \toRouteParamsRecordArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "RoutePattern" ]
                     , name = "toRouteParamsRecord"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Internal", "RoutePattern" ]
                                      "RoutePattern"
                                      []
                                  ]
                                  (Type.list
                                       (Type.tuple
                                            Type.string
                                            (Type.namedWith
                                                 [ "Elm", "Annotation" ]
                                                 "Annotation"
                                                 []
                                            )
                                       )
                                  )
                             )
                     }
                )
                [ toRouteParamsRecordArg_ ]
    , toVariantName =
        \toVariantNameArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Pages", "Internal", "RoutePattern" ]
                     , name = "toVariantName"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Internal", "RoutePattern" ]
                                      "RoutePattern"
                                      []
                                  ]
                                  (Type.record
                                       [ ( "variantName", Type.string )
                                       , ( "params"
                                         , Type.list
                                               (Type.namedWith
                                                    [ "Pages"
                                                    , "Internal"
                                                    , "RoutePattern"
                                                    ]
                                                    "RouteParam"
                                                    []
                                               )
                                         )
                                       ]
                                  )
                             )
                     }
                )
                [ toVariantNameArg_ ]
    }


values_ :
    { view : Elm.Expression
    , toVariant : Elm.Expression
    , routeToBranch : Elm.Expression
    , fromModuleName : Elm.Expression
    , hasRouteParams : Elm.Expression
    , repeatWithoutOptionalEnding : Elm.Expression
    , toModuleName : Elm.Expression
    , toRouteParamTypes : Elm.Expression
    , toRouteParamsRecord : Elm.Expression
    , toVariantName : Elm.Expression
    }
values_ =
    { view =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "view"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Internal", "RoutePattern" ]
                             "RoutePattern"
                             []
                         ]
                         (Type.namedWith [ "Html" ] "Html" [ Type.var "msg" ])
                    )
            }
    , toVariant =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "toVariant"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Internal", "RoutePattern" ]
                             "RoutePattern"
                             []
                         ]
                         (Type.namedWith [ "Elm" ] "Variant" [])
                    )
            }
    , routeToBranch =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "routeToBranch"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Internal", "RoutePattern" ]
                             "RoutePattern"
                             []
                         ]
                         (Type.list
                              (Type.tuple
                                   (Type.namedWith
                                        [ "Elm", "CodeGen" ]
                                        "Pattern"
                                        []
                                   )
                                   (Type.namedWith
                                        [ "Elm", "CodeGen" ]
                                        "Expression"
                                        []
                                   )
                              )
                         )
                    )
            }
    , fromModuleName =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "fromModuleName"
            , annotation =
                Just
                    (Type.function
                         [ Type.list Type.string ]
                         (Type.maybe
                              (Type.namedWith
                                   [ "Pages", "Internal", "RoutePattern" ]
                                   "RoutePattern"
                                   []
                              )
                         )
                    )
            }
    , hasRouteParams =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "hasRouteParams"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Internal", "RoutePattern" ]
                             "RoutePattern"
                             []
                         ]
                         Type.bool
                    )
            }
    , repeatWithoutOptionalEnding =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "repeatWithoutOptionalEnding"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "Pages", "Internal", "RoutePattern" ]
                                "RouteParam"
                                []
                             )
                         ]
                         (Type.maybe
                              (Type.list
                                   (Type.namedWith
                                        [ "Pages", "Internal", "RoutePattern" ]
                                        "RouteParam"
                                        []
                                   )
                              )
                         )
                    )
            }
    , toModuleName =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "toModuleName"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Internal", "RoutePattern" ]
                             "RoutePattern"
                             []
                         ]
                         (Type.list Type.string)
                    )
            }
    , toRouteParamTypes =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "toRouteParamTypes"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Internal", "RoutePattern" ]
                             "RoutePattern"
                             []
                         ]
                         (Type.list
                              (Type.tuple
                                   Type.string
                                   (Type.namedWith
                                        [ "Pages", "Internal", "RoutePattern" ]
                                        "Param"
                                        []
                                   )
                              )
                         )
                    )
            }
    , toRouteParamsRecord =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "toRouteParamsRecord"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Internal", "RoutePattern" ]
                             "RoutePattern"
                             []
                         ]
                         (Type.list
                              (Type.tuple
                                   Type.string
                                   (Type.namedWith
                                        [ "Elm", "Annotation" ]
                                        "Annotation"
                                        []
                                   )
                              )
                         )
                    )
            }
    , toVariantName =
        Elm.value
            { importFrom = [ "Pages", "Internal", "RoutePattern" ]
            , name = "toVariantName"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Internal", "RoutePattern" ]
                             "RoutePattern"
                             []
                         ]
                         (Type.record
                              [ ( "variantName", Type.string )
                              , ( "params"
                                , Type.list
                                      (Type.namedWith
                                           [ "Pages"
                                           , "Internal"
                                           , "RoutePattern"
                                           ]
                                           "RouteParam"
                                           []
                                      )
                                )
                              ]
                         )
                    )
            }
    }