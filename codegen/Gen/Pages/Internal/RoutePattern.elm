module Gen.Pages.Internal.RoutePattern exposing (annotation_, call_, caseOf_, fromModuleName, hasRouteParams, make_, moduleName_, repeatWithoutOptionalEnding, routeToBranch, toModuleName, toRouteParamTypes, toRouteParamsRecord, toVariant, toVariantName, values_, view)

{-| 
@docs moduleName_, view, toVariant, routeToBranch, fromModuleName, hasRouteParams, repeatWithoutOptionalEnding, toModuleName, toRouteParamTypes, toRouteParamsRecord, toVariantName, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Pages", "Internal", "RoutePattern" ]


{-| view: Pages.Internal.RoutePattern.RoutePattern -> Html.Html msg -}
view : Elm.Expression -> Elm.Expression
view viewArg =
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
        [ viewArg ]


{-| toVariant: Pages.Internal.RoutePattern.RoutePattern -> Elm.Variant -}
toVariant : Elm.Expression -> Elm.Expression
toVariant toVariantArg =
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
        [ toVariantArg ]


{-| routeToBranch: 
    Pages.Internal.RoutePattern.RoutePattern
    -> List ( Elm.CodeGen.Pattern, Elm.CodeGen.Expression )
-}
routeToBranch : Elm.Expression -> Elm.Expression
routeToBranch routeToBranchArg =
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
        [ routeToBranchArg ]


{-| fromModuleName: List String -> Maybe Pages.Internal.RoutePattern.RoutePattern -}
fromModuleName : List String -> Elm.Expression
fromModuleName fromModuleNameArg =
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
        [ Elm.list (List.map Elm.string fromModuleNameArg) ]


{-| hasRouteParams: Pages.Internal.RoutePattern.RoutePattern -> Bool -}
hasRouteParams : Elm.Expression -> Elm.Expression
hasRouteParams hasRouteParamsArg =
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
        [ hasRouteParamsArg ]


{-| repeatWithoutOptionalEnding: 
    List Pages.Internal.RoutePattern.RouteParam
    -> Maybe (List Pages.Internal.RoutePattern.RouteParam)
-}
repeatWithoutOptionalEnding : List Elm.Expression -> Elm.Expression
repeatWithoutOptionalEnding repeatWithoutOptionalEndingArg =
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
        [ Elm.list repeatWithoutOptionalEndingArg ]


{-| toModuleName: Pages.Internal.RoutePattern.RoutePattern -> List String -}
toModuleName : Elm.Expression -> Elm.Expression
toModuleName toModuleNameArg =
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
        [ toModuleNameArg ]


{-| toRouteParamTypes: 
    Pages.Internal.RoutePattern.RoutePattern
    -> List ( String, Pages.Internal.RoutePattern.Param )
-}
toRouteParamTypes : Elm.Expression -> Elm.Expression
toRouteParamTypes toRouteParamTypesArg =
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
        [ toRouteParamTypesArg ]


{-| toRouteParamsRecord: 
    Pages.Internal.RoutePattern.RoutePattern
    -> List ( String, Elm.Annotation.Annotation )
-}
toRouteParamsRecord : Elm.Expression -> Elm.Expression
toRouteParamsRecord toRouteParamsRecordArg =
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
        [ toRouteParamsRecordArg ]


{-| toVariantName: 
    Pages.Internal.RoutePattern.RoutePattern
    -> { variantName : String
    , params : List Pages.Internal.RoutePattern.RouteParam
    }
-}
toVariantName : Elm.Expression -> Elm.Expression
toVariantName toVariantNameArg =
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
        [ toVariantNameArg ]


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
        -> { endingTags_0_0
            | optional : Elm.Expression -> Elm.Expression
            , requiredSplat : Elm.Expression
            , optionalSplat : Elm.Expression
        }
        -> Elm.Expression
    , segment :
        Elm.Expression
        -> { segmentTags_1_0
            | staticSegment : Elm.Expression -> Elm.Expression
            , dynamicSegment : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , param :
        Elm.Expression
        -> { paramTags_2_0
            | requiredParam : Elm.Expression
            , optionalParam : Elm.Expression
            , requiredSplatParam : Elm.Expression
            , optionalSplatParam : Elm.Expression
        }
        -> Elm.Expression
    , routeParam :
        Elm.Expression
        -> { routeParamTags_3_0
            | staticParam : Elm.Expression -> Elm.Expression
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
                [ Elm.Case.branch1
                    "Optional"
                    ( "stringString", Type.string )
                    endingTags.optional
                , Elm.Case.branch0 "RequiredSplat" endingTags.requiredSplat
                , Elm.Case.branch0 "OptionalSplat" endingTags.optionalSplat
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
                [ Elm.Case.branch1
                    "StaticSegment"
                    ( "stringString", Type.string )
                    segmentTags.staticSegment
                , Elm.Case.branch1
                    "DynamicSegment"
                    ( "stringString", Type.string )
                    segmentTags.dynamicSegment
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
                [ Elm.Case.branch0 "RequiredParam" paramTags.requiredParam
                , Elm.Case.branch0 "OptionalParam" paramTags.optionalParam
                , Elm.Case.branch0
                    "RequiredSplatParam"
                    paramTags.requiredSplatParam
                , Elm.Case.branch0
                    "OptionalSplatParam"
                    paramTags.optionalSplatParam
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
                [ Elm.Case.branch1
                    "StaticParam"
                    ( "stringString", Type.string )
                    routeParamTags.staticParam
                , Elm.Case.branch1
                    "DynamicParam"
                    ( "stringString", Type.string )
                    routeParamTags.dynamicParam
                , Elm.Case.branch1
                    "OptionalParam2"
                    ( "stringString", Type.string )
                    routeParamTags.optionalParam2
                , Elm.Case.branch0
                    "RequiredSplatParam2"
                    routeParamTags.requiredSplatParam2
                , Elm.Case.branch0
                    "OptionalSplatParam2"
                    routeParamTags.optionalSplatParam2
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
        \viewArg ->
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
                [ viewArg ]
    , toVariant =
        \toVariantArg ->
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
                [ toVariantArg ]
    , routeToBranch =
        \routeToBranchArg ->
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
                [ routeToBranchArg ]
    , fromModuleName =
        \fromModuleNameArg ->
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
                [ fromModuleNameArg ]
    , hasRouteParams =
        \hasRouteParamsArg ->
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
                [ hasRouteParamsArg ]
    , repeatWithoutOptionalEnding =
        \repeatWithoutOptionalEndingArg ->
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
                [ repeatWithoutOptionalEndingArg ]
    , toModuleName =
        \toModuleNameArg ->
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
                [ toModuleNameArg ]
    , toRouteParamTypes =
        \toRouteParamTypesArg ->
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
                [ toRouteParamTypesArg ]
    , toRouteParamsRecord =
        \toRouteParamsRecordArg ->
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
                [ toRouteParamsRecordArg ]
    , toVariantName =
        \toVariantNameArg ->
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
                [ toVariantNameArg ]
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