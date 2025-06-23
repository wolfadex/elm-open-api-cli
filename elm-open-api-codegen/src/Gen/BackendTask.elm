module Gen.BackendTask exposing
    ( moduleName_, map, succeed, fail, fromResult, andThen
    , resolve, combine, andMap, map2, map3, map4, map5
    , map6, map7, map8, map9, allowFatal, mapError, onError
    , toResult, do, doEach, sequence, failIf, inDir, quiet
    , withEnv, annotation_, call_, values_
    )

{-|
# Generated bindings for BackendTask

@docs moduleName_, map, succeed, fail, fromResult, andThen
@docs resolve, combine, andMap, map2, map3, map4
@docs map5, map6, map7, map8, map9, allowFatal
@docs mapError, onError, toResult, do, doEach, sequence
@docs failIf, inDir, quiet, withEnv, annotation_, call_
@docs values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "BackendTask" ]


{-| Transform a request into an arbitrary value. The same underlying task will be performed,
but mapping allows you to change the resulting values by applying functions to the results.

    import BackendTask exposing (BackendTask)
    import BackendTask.Http
    import FatalError exposing (FatalError)
    import Json.Decode as Decode

    starsMessage : BackendTask FatalError String
    starsMessage =
        BackendTask.Http.getJson
            "https://api.github.com/repos/dillonkearns/elm-pages"
            (Decode.field "stargazers_count" Decode.int)
            |> BackendTask.map
                (\stars -> "⭐️ " ++ String.fromInt stars)
            |> BackendTask.allowFatal

map: (a -> b) -> BackendTask.BackendTask error a -> BackendTask.BackendTask error b
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg_ mapArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "map"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function [ Type.var "a" ] (Type.var "b")
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "b" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapUnpack" mapArg_, mapArg_0 ]


{-| This is useful for prototyping with some hardcoded data, or for having a view that doesn't have any BackendTask data.

    import BackendTask exposing (BackendTask)

    type alias RouteParams =
        { name : String }

    pages : BackendTask error (List RouteParams)
    pages =
        BackendTask.succeed [ { name = "elm-pages" } ]

succeed: a -> BackendTask.BackendTask error a
-}
succeed : Elm.Expression -> Elm.Expression
succeed succeedArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "succeed"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "a" ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "a" ]
                          )
                     )
             }
        )
        [ succeedArg_ ]


{-| fail: error -> BackendTask.BackendTask error a -}
fail : Elm.Expression -> Elm.Expression
fail failArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "fail"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "error" ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "a" ]
                          )
                     )
             }
        )
        [ failArg_ ]


{-| Turn `Ok` into `BackendTask.succeed` and `Err` into `BackendTask.fail`.

fromResult: Result.Result error value -> BackendTask.BackendTask error value
-}
fromResult : Elm.Expression -> Elm.Expression
fromResult fromResultArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "fromResult"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Result" ]
                              "Result"
                              [ Type.var "error", Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "value" ]
                          )
                     )
             }
        )
        [ fromResultArg_ ]


{-| Build off of the response from a previous `BackendTask` request to build a follow-up request. You can use the data
from the previous response to build up the URL, headers, etc. that you send to the subsequent request.

    import BackendTask exposing (BackendTask)
    import BackendTask.Http
    import FatalError exposing (FatalError)
    import Json.Decode as Decode

    licenseData : BackendTask FatalError String
    licenseData =
        BackendTask.Http.getJson
            "https://api.github.com/repos/dillonkearns/elm-pages"
            (Decode.at [ "license", "url" ] Decode.string)
            |> BackendTask.andThen
                (\licenseUrl ->
                    BackendTask.Http.getJson licenseUrl (Decode.field "description" Decode.string)
                )
            |> BackendTask.allowFatal

andThen: 
    (a -> BackendTask.BackendTask error b)
    -> BackendTask.BackendTask error a
    -> BackendTask.BackendTask error b
-}
andThen : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
andThen andThenArg_ andThenArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "andThen"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a" ]
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.var "error", Type.var "b" ]
                              )
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "b" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "andThenUnpack" andThenArg_, andThenArg_0 ]


{-| Helper to remove an inner layer of Request wrapping.

resolve: 
    BackendTask.BackendTask error (List (BackendTask.BackendTask error value))
    -> BackendTask.BackendTask error (List value)
-}
resolve : Elm.Expression -> Elm.Expression
resolve resolveArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "resolve"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error"
                              , Type.list
                                    (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.var "error", Type.var "value" ]
                                    )
                              ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error"
                               , Type.list (Type.var "value")
                               ]
                          )
                     )
             }
        )
        [ resolveArg_ ]


{-| Turn a list of `BackendTask`s into a single one.

    import BackendTask exposing (BackendTask)
    import BackendTask.Http
    import FatalError exposing (FatalError)
    import Json.Decode as Decode

    type alias Pokemon =
        { name : String
        , sprite : String
        }

    pokemonDetailRequest : BackendTask FatalError (List Pokemon)
    pokemonDetailRequest =
        BackendTask.Http.getJson
            "https://pokeapi.co/api/v2/pokemon/?limit=3"
            (Decode.field "results"
                (Decode.list
                    (Decode.map2 Tuple.pair
                        (Decode.field "name" Decode.string)
                        (Decode.field "url" Decode.string)
                        |> Decode.map
                            (\( name, url ) ->
                                BackendTask.Http.getJson url
                                    (Decode.at
                                        [ "sprites", "front_default" ]
                                        Decode.string
                                        |> Decode.map (Pokemon name)
                                    )
                            )
                    )
                )
            )
            |> BackendTask.andThen BackendTask.combine
            |> BackendTask.allowFatal

combine: 
    List (BackendTask.BackendTask error value)
    -> BackendTask.BackendTask error (List value)
-}
combine : List Elm.Expression -> Elm.Expression
combine combineArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "combine"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.var "error", Type.var "value" ]
                              )
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error"
                               , Type.list (Type.var "value")
                               ]
                          )
                     )
             }
        )
        [ Elm.list combineArg_ ]


{-| A helper for combining `BackendTask`s in pipelines.

andMap: 
    BackendTask.BackendTask error a
    -> BackendTask.BackendTask error (a -> b)
    -> BackendTask.BackendTask error b
-}
andMap : Elm.Expression -> Elm.Expression -> Elm.Expression
andMap andMapArg_ andMapArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "andMap"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "a" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error"
                              , Type.function [ Type.var "a" ] (Type.var "b")
                              ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "b" ]
                          )
                     )
             }
        )
        [ andMapArg_, andMapArg_0 ]


{-| Like map, but it takes in two `BackendTask`s.

    import BackendTask exposing (BackendTask)
    import BackendTask.Env as Env
    import BackendTask.Http
    import FatalError exposing (FatalError)
    import Json.Decode as Decode

    type alias Data =
        { pokemon : List String, envValue : Maybe String }

    data : BackendTask FatalError Data
    data =
        BackendTask.map2 Data
            (BackendTask.Http.getJson
                "https://pokeapi.co/api/v2/pokemon/?limit=100&offset=0"
                (Decode.field "results"
                    (Decode.list (Decode.field "name" Decode.string))
                )
                |> BackendTask.allowFatal
            )
            (Env.get "HELLO")

map2: 
    (a -> b -> c)
    -> BackendTask.BackendTask error a
    -> BackendTask.BackendTask error b
    -> BackendTask.BackendTask error c
-}
map2 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map2 map2Arg_ map2Arg_0 map2Arg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "map2"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "a", Type.var "b" ]
                              (Type.var "c")
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "a" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "b" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "c" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map2Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced "unpack" (map2Arg_ functionReducedUnpack)
            )
        , map2Arg_0
        , map2Arg_1
        ]


{-| map3: 
    (value1 -> value2 -> value3 -> valueCombined)
    -> BackendTask.BackendTask error value1
    -> BackendTask.BackendTask error value2
    -> BackendTask.BackendTask error value3
    -> BackendTask.BackendTask error valueCombined
-}
map3 :
    (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map3 map3Arg_ map3Arg_0 map3Arg_1 map3Arg_2 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "map3"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "value1"
                              , Type.var "value2"
                              , Type.var "value3"
                              ]
                              (Type.var "valueCombined")
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value1" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value2" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value3" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "valueCombined" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map3Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            ((map3Arg_ functionReducedUnpack)
                                 functionReducedUnpack0
                            )
                   )
            )
        , map3Arg_0
        , map3Arg_1
        , map3Arg_2
        ]


{-| map4: 
    (value1 -> value2 -> value3 -> value4 -> valueCombined)
    -> BackendTask.BackendTask error value1
    -> BackendTask.BackendTask error value2
    -> BackendTask.BackendTask error value3
    -> BackendTask.BackendTask error value4
    -> BackendTask.BackendTask error valueCombined
-}
map4 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map4 map4Arg_ map4Arg_0 map4Arg_1 map4Arg_2 map4Arg_3 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "map4"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "value1"
                              , Type.var "value2"
                              , Type.var "value3"
                              , Type.var "value4"
                              ]
                              (Type.var "valueCombined")
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value1" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value2" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value3" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value4" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "valueCombined" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map4Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (((map4Arg_ functionReducedUnpack)
                                           functionReducedUnpack0
                                      )
                                          functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                     )
                            )
                   )
            )
        , map4Arg_0
        , map4Arg_1
        , map4Arg_2
        , map4Arg_3
        ]


{-| map5: 
    (value1 -> value2 -> value3 -> value4 -> value5 -> valueCombined)
    -> BackendTask.BackendTask error value1
    -> BackendTask.BackendTask error value2
    -> BackendTask.BackendTask error value3
    -> BackendTask.BackendTask error value4
    -> BackendTask.BackendTask error value5
    -> BackendTask.BackendTask error valueCombined
-}
map5 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map5 map5Arg_ map5Arg_0 map5Arg_1 map5Arg_2 map5Arg_3 map5Arg_4 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "map5"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "value1"
                              , Type.var "value2"
                              , Type.var "value3"
                              , Type.var "value4"
                              , Type.var "value5"
                              ]
                              (Type.var "valueCombined")
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value1" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value2" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value3" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value4" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value5" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "valueCombined" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map5Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (\functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0 ->
                                          Elm.functionReduced
                                              "unpack"
                                              ((((map5Arg_ functionReducedUnpack
                                                 )
                                                     functionReducedUnpack0
                                                )
                                                    functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                               )
                                                   functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0
                                              )
                                     )
                            )
                   )
            )
        , map5Arg_0
        , map5Arg_1
        , map5Arg_2
        , map5Arg_3
        , map5Arg_4
        ]


{-| map6: 
    (value1 -> value2 -> value3 -> value4 -> value5 -> value6 -> valueCombined)
    -> BackendTask.BackendTask error value1
    -> BackendTask.BackendTask error value2
    -> BackendTask.BackendTask error value3
    -> BackendTask.BackendTask error value4
    -> BackendTask.BackendTask error value5
    -> BackendTask.BackendTask error value6
    -> BackendTask.BackendTask error valueCombined
-}
map6 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map6 map6Arg_ map6Arg_0 map6Arg_1 map6Arg_2 map6Arg_3 map6Arg_4 map6Arg_5 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "map6"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "value1"
                              , Type.var "value2"
                              , Type.var "value3"
                              , Type.var "value4"
                              , Type.var "value5"
                              , Type.var "value6"
                              ]
                              (Type.var "valueCombined")
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value1" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value2" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value3" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value4" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value5" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value6" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "valueCombined" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map6Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (\functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0 ->
                                          Elm.functionReduced
                                              "unpack"
                                              (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                   Elm.functionReduced
                                                       "unpack"
                                                       (((((map6Arg_
                                                                functionReducedUnpack
                                                           )
                                                               functionReducedUnpack0
                                                          )
                                                              functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                                         )
                                                             functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0
                                                        )
                                                            functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                       )
                                              )
                                     )
                            )
                   )
            )
        , map6Arg_0
        , map6Arg_1
        , map6Arg_2
        , map6Arg_3
        , map6Arg_4
        , map6Arg_5
        ]


{-| map7: 
    (value1
    -> value2
    -> value3
    -> value4
    -> value5
    -> value6
    -> value7
    -> valueCombined)
    -> BackendTask.BackendTask error value1
    -> BackendTask.BackendTask error value2
    -> BackendTask.BackendTask error value3
    -> BackendTask.BackendTask error value4
    -> BackendTask.BackendTask error value5
    -> BackendTask.BackendTask error value6
    -> BackendTask.BackendTask error value7
    -> BackendTask.BackendTask error valueCombined
-}
map7 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map7 map7Arg_ map7Arg_0 map7Arg_1 map7Arg_2 map7Arg_3 map7Arg_4 map7Arg_5 map7Arg_6 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "map7"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "value1"
                              , Type.var "value2"
                              , Type.var "value3"
                              , Type.var "value4"
                              , Type.var "value5"
                              , Type.var "value6"
                              , Type.var "value7"
                              ]
                              (Type.var "valueCombined")
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value1" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value2" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value3" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value4" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value5" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value6" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value7" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "valueCombined" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map7Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (\functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0 ->
                                          Elm.functionReduced
                                              "unpack"
                                              (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                   Elm.functionReduced
                                                       "unpack"
                                                       (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                            Elm.functionReduced
                                                                "unpack"
                                                                ((((((map7Arg_
                                                                          functionReducedUnpack
                                                                     )
                                                                         functionReducedUnpack0
                                                                    )
                                                                        functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                                                   )
                                                                       functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0
                                                                  )
                                                                      functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                 )
                                                                     functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                )
                                                       )
                                              )
                                     )
                            )
                   )
            )
        , map7Arg_0
        , map7Arg_1
        , map7Arg_2
        , map7Arg_3
        , map7Arg_4
        , map7Arg_5
        , map7Arg_6
        ]


{-| map8: 
    (value1
    -> value2
    -> value3
    -> value4
    -> value5
    -> value6
    -> value7
    -> value8
    -> valueCombined)
    -> BackendTask.BackendTask error value1
    -> BackendTask.BackendTask error value2
    -> BackendTask.BackendTask error value3
    -> BackendTask.BackendTask error value4
    -> BackendTask.BackendTask error value5
    -> BackendTask.BackendTask error value6
    -> BackendTask.BackendTask error value7
    -> BackendTask.BackendTask error value8
    -> BackendTask.BackendTask error valueCombined
-}
map8 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map8 map8Arg_ map8Arg_0 map8Arg_1 map8Arg_2 map8Arg_3 map8Arg_4 map8Arg_5 map8Arg_6 map8Arg_7 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "map8"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "value1"
                              , Type.var "value2"
                              , Type.var "value3"
                              , Type.var "value4"
                              , Type.var "value5"
                              , Type.var "value6"
                              , Type.var "value7"
                              , Type.var "value8"
                              ]
                              (Type.var "valueCombined")
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value1" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value2" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value3" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value4" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value5" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value6" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value7" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value8" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "valueCombined" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map8Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (\functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0 ->
                                          Elm.functionReduced
                                              "unpack"
                                              (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                   Elm.functionReduced
                                                       "unpack"
                                                       (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                            Elm.functionReduced
                                                                "unpack"
                                                                (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                                     Elm.functionReduced
                                                                         "unpack"
                                                                         (((((((map8Arg_
                                                                                    functionReducedUnpack
                                                                               )
                                                                                   functionReducedUnpack0
                                                                              )
                                                                                  functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                                                             )
                                                                                 functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0
                                                                            )
                                                                                functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                           )
                                                                               functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                          )
                                                                              functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                         )
                                                                )
                                                       )
                                              )
                                     )
                            )
                   )
            )
        , map8Arg_0
        , map8Arg_1
        , map8Arg_2
        , map8Arg_3
        , map8Arg_4
        , map8Arg_5
        , map8Arg_6
        , map8Arg_7
        ]


{-| map9: 
    (value1
    -> value2
    -> value3
    -> value4
    -> value5
    -> value6
    -> value7
    -> value8
    -> value9
    -> valueCombined)
    -> BackendTask.BackendTask error value1
    -> BackendTask.BackendTask error value2
    -> BackendTask.BackendTask error value3
    -> BackendTask.BackendTask error value4
    -> BackendTask.BackendTask error value5
    -> BackendTask.BackendTask error value6
    -> BackendTask.BackendTask error value7
    -> BackendTask.BackendTask error value8
    -> BackendTask.BackendTask error value9
    -> BackendTask.BackendTask error valueCombined
-}
map9 :
    (Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
    -> Elm.Expression
map9 map9Arg_ map9Arg_0 map9Arg_1 map9Arg_2 map9Arg_3 map9Arg_4 map9Arg_5 map9Arg_6 map9Arg_7 map9Arg_8 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "map9"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "value1"
                              , Type.var "value2"
                              , Type.var "value3"
                              , Type.var "value4"
                              , Type.var "value5"
                              , Type.var "value6"
                              , Type.var "value7"
                              , Type.var "value8"
                              , Type.var "value9"
                              ]
                              (Type.var "valueCombined")
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value1" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value2" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value3" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value4" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value5" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value6" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value7" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value8" ]
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value9" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "valueCombined" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "map9Unpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (\functionReducedUnpack0 ->
                        Elm.functionReduced
                            "unpack"
                            (\functionReducedUnpack_2_1_2_0_2_0_2_0_0 ->
                                 Elm.functionReduced
                                     "unpack"
                                     (\functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0 ->
                                          Elm.functionReduced
                                              "unpack"
                                              (\functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                   Elm.functionReduced
                                                       "unpack"
                                                       (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                            Elm.functionReduced
                                                                "unpack"
                                                                (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                                     Elm.functionReduced
                                                                         "unpack"
                                                                         (\functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0 ->
                                                                              Elm.functionReduced
                                                                                  "unpack"
                                                                                  ((((((((map9Arg_
                                                                                              functionReducedUnpack
                                                                                         )
                                                                                             functionReducedUnpack0
                                                                                        )
                                                                                            functionReducedUnpack_2_1_2_0_2_0_2_0_0
                                                                                       )
                                                                                           functionReducedUnpack_2_1_2_1_2_0_2_0_2_0_0
                                                                                      )
                                                                                          functionReducedUnpack_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                                     )
                                                                                         functionReducedUnpack_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                                    )
                                                                                        functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                                   )
                                                                                       functionReducedUnpack_2_1_2_1_2_1_2_1_2_1_2_1_2_0_2_0_2_0_0
                                                                                  )
                                                                         )
                                                                )
                                                       )
                                              )
                                     )
                            )
                   )
            )
        , map9Arg_0
        , map9Arg_1
        , map9Arg_2
        , map9Arg_3
        , map9Arg_4
        , map9Arg_5
        , map9Arg_6
        , map9Arg_7
        , map9Arg_8
        ]


{-| Ignore any recoverable error data and propagate the `FatalError`. Similar to a `Cmd` in The Elm Architecture,
a `FatalError` will not do anything except if it is returned at the top-level of your application. Read more
in the [`FatalError` docs](FatalError).

allowFatal: 
    BackendTask.BackendTask { error | fatal : FatalError.FatalError } data
    -> BackendTask.BackendTask FatalError.FatalError data
-}
allowFatal : Elm.Expression -> Elm.Expression
allowFatal allowFatalArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "allowFatal"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.extensible
                                    "error"
                                    [ ( "fatal"
                                      , Type.namedWith
                                            [ "FatalError" ]
                                            "FatalError"
                                            []
                                      )
                                    ]
                              , Type.var "data"
                              ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.namedWith [ "FatalError" ] "FatalError" []
                               , Type.var "data"
                               ]
                          )
                     )
             }
        )
        [ allowFatalArg_ ]


{-| mapError: 
    (error -> errorMapped)
    -> BackendTask.BackendTask error value
    -> BackendTask.BackendTask errorMapped value
-}
mapError :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
mapError mapErrorArg_ mapErrorArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "mapError"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "error" ]
                              (Type.var "errorMapped")
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "errorMapped", Type.var "value" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapErrorUnpack" mapErrorArg_, mapErrorArg_0 ]


{-| onError: 
    (error -> BackendTask.BackendTask mappedError value)
    -> BackendTask.BackendTask error value
    -> BackendTask.BackendTask mappedError value
-}
onError : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
onError onErrorArg_ onErrorArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "onError"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "error" ]
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.var "mappedError", Type.var "value" ]
                              )
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "mappedError", Type.var "value" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "onErrorUnpack" onErrorArg_, onErrorArg_0 ]


{-| toResult: 
    BackendTask.BackendTask error data
    -> BackendTask.BackendTask noError (Result.Result error data)
-}
toResult : Elm.Expression -> Elm.Expression
toResult toResultArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "toResult"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "data" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "noError"
                               , Type.namedWith
                                   [ "Result" ]
                                   "Result"
                                   [ Type.var "error", Type.var "data" ]
                               ]
                          )
                     )
             }
        )
        [ toResultArg_ ]


{-| Ignore the resulting value of the BackendTask.

do: BackendTask.BackendTask error value -> BackendTask.BackendTask error ()
-}
do : Elm.Expression -> Elm.Expression
do doArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "do"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.unit ]
                          )
                     )
             }
        )
        [ doArg_ ]


{-| Perform a List of `BackendTask`s with no output, one-by-one sequentially.

Same as [`sequence`](#sequence), except it ignores the resulting value of each `BackendTask`.

doEach: List (BackendTask.BackendTask error ()) -> BackendTask.BackendTask error ()
-}
doEach : List Elm.Expression -> Elm.Expression
doEach doEachArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "doEach"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.var "error", Type.unit ]
                              )
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.unit ]
                          )
                     )
             }
        )
        [ Elm.list doEachArg_ ]


{-| Perform a List of `BackendTask`s one-by-one sequentially. [`combine`](#combine) will perform them all in parallel, which is
typically a better default when you aren't sure which you want.

Same as [`doEach`](#doEach), except it ignores the resulting value of each `BackendTask`.

sequence: 
    List (BackendTask.BackendTask error value)
    -> BackendTask.BackendTask error (List value)
-}
sequence : List Elm.Expression -> Elm.Expression
sequence sequenceArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "sequence"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "BackendTask" ]
                                 "BackendTask"
                                 [ Type.var "error", Type.var "value" ]
                              )
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error"
                               , Type.list (Type.var "value")
                               ]
                          )
                     )
             }
        )
        [ Elm.list sequenceArg_ ]


{-| If the condition is true, fail with the given `FatalError`. Otherwise, succeed with `()`.

failIf: 
    Bool
    -> FatalError.FatalError
    -> BackendTask.BackendTask FatalError.FatalError ()
-}
failIf : Bool -> Elm.Expression -> Elm.Expression
failIf failIfArg_ failIfArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "failIf"
             , annotation =
                 Just
                     (Type.function
                          [ Type.bool
                          , Type.namedWith [ "FatalError" ] "FatalError" []
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.namedWith [ "FatalError" ] "FatalError" []
                               , Type.unit
                               ]
                          )
                     )
             }
        )
        [ Elm.bool failIfArg_, failIfArg_0 ]


{-| `inDir` sets the working directory for a `BackendTask`. The working directory of a `BackendTask` will be used to resolve relative paths
and is relevant for the following types of `BackendTask`s:

  - Reading files ([`BackendTask.File`](BackendTask-File))
  - Running glob patterns ([`BackendTask.Glob`](BackendTask-Glob))
  - Executing shell commands ([`BackendTask.Stream.command`](BackendTask-Stream#command)) and [`Pages.Script.sh`](Pages-Script#command)

See the BackendTask Context section for more about how setting context works.

For example, these two values will produce the same result:

    import BackendTask.Glob as Glob

    example1 : BackendTask error (List String)
    example1 =
        Glob.fromString "src/**/*.elm"

    example2 : BackendTask error (List String)
    example2 =
        BackendTask.inDir "src" (Glob.fromString "**/*.elm")

You can also nest the working directory by using `inDir` multiple times:

    import BackendTask.Glob as Glob

    example3 : BackendTask error (List String)
    example3 =
        BackendTask.map2
            (\routeModules specialModules ->
                { routeModules = routeModules
                , specialModules = specialModules
                }
            )
            (BackendTask.inDir "Route" (Glob.fromString "**/*.elm"))
            (Glob.fromString "*.elm")
            |> BackendTask.inDir "app"

The above example will list out files from `app/Route/**/*.elm` and `app/*.elm` because `inDir "app"` is applied to the `BackendTask.map2` which combines together both of the Glob tasks.

`inDir` supports absolute paths. In this example, we apply a relative path on top of an absolute path, so the relative path will be resolved relative to the absolute path.

    import BackendTask.Glob as Glob

    example3 : BackendTask error (List String)
    example3 =
        BackendTask.map2
            (\routeModules specialModules ->
                { routeModules = routeModules
                , specialModules = specialModules
                }
            )
            -- same as `Glob.fromString "/projects/my-elm-pages-blog/app/Route/**/*.elm"`
            (BackendTask.inDir "Route" (Glob.fromString "**/*.elm"))
            (Glob.fromString "*.elm")
            |> BackendTask.inDir "/projects/my-elm-pages-blog/app"

You can also use `BackendTask.inDir ".."` to go up a directory, or \`BackendTask.inDir "../.." to go up two directories, etc.

Use of trailing slashes is optional and does not change the behavior of `inDir`. Leading slashes distinguish between
absolute and relative paths, so `BackendTask.inDir "./src"` is exactly the same as `BackendTask.inDir "src"`, etc.

Each level of nesting with `inDir` will resolve using [NodeJS's `path.resolve`](https://nodejs.org/api/path.html#pathresolvepaths).

inDir: 
    String
    -> BackendTask.BackendTask error value
    -> BackendTask.BackendTask error value
-}
inDir : String -> Elm.Expression -> Elm.Expression
inDir inDirArg_ inDirArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "inDir"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "value" ]
                          )
                     )
             }
        )
        [ Elm.string inDirArg_, inDirArg_0 ]


{-| Sets the verbosity level to `quiet` in the context of the given `BackendTask` (including all nested `BackendTask`s and continuations within it).

This will turn off performance timing logs. It will also prevent shell commands from printing their output to the console when they are run
(see [`BackendTask.Stream.command`](BackendTask-Stream#command)).

quiet: BackendTask.BackendTask error value -> BackendTask.BackendTask error value
-}
quiet : Elm.Expression -> Elm.Expression
quiet quietArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "quiet"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "value" ]
                          )
                     )
             }
        )
        [ quietArg_ ]


{-| withEnv: 
    String
    -> String
    -> BackendTask.BackendTask error value
    -> BackendTask.BackendTask error value
-}
withEnv : String -> String -> Elm.Expression -> Elm.Expression
withEnv withEnvArg_ withEnvArg_0 withEnvArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask" ]
             , name = "withEnv"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.string
                          , Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.var "value" ]
                          )
                     )
             }
        )
        [ Elm.string withEnvArg_, Elm.string withEnvArg_0, withEnvArg_1 ]


annotation_ :
    { backendTask : Type.Annotation -> Type.Annotation -> Type.Annotation }
annotation_ =
    { backendTask =
        \backendTaskArg0 backendTaskArg1 ->
            Type.alias
                moduleName_
                "BackendTask"
                [ backendTaskArg0, backendTaskArg1 ]
                (Type.namedWith
                     [ "Pages", "StaticHttpRequest" ]
                     "RawRequest"
                     [ Type.var "error", Type.var "value" ]
                )
    }


call_ :
    { map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , succeed : Elm.Expression -> Elm.Expression
    , fail : Elm.Expression -> Elm.Expression
    , fromResult : Elm.Expression -> Elm.Expression
    , andThen : Elm.Expression -> Elm.Expression -> Elm.Expression
    , resolve : Elm.Expression -> Elm.Expression
    , combine : Elm.Expression -> Elm.Expression
    , andMap : Elm.Expression -> Elm.Expression -> Elm.Expression
    , map2 :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , map3 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map4 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map5 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map6 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map7 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map8 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , map9 :
        Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
        -> Elm.Expression
    , allowFatal : Elm.Expression -> Elm.Expression
    , mapError : Elm.Expression -> Elm.Expression -> Elm.Expression
    , onError : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toResult : Elm.Expression -> Elm.Expression
    , do : Elm.Expression -> Elm.Expression
    , doEach : Elm.Expression -> Elm.Expression
    , sequence : Elm.Expression -> Elm.Expression
    , failIf : Elm.Expression -> Elm.Expression -> Elm.Expression
    , inDir : Elm.Expression -> Elm.Expression -> Elm.Expression
    , quiet : Elm.Expression -> Elm.Expression
    , withEnv :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { map =
        \mapArg_ mapArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "map"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.var "b")
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.var "b" ]
                                  )
                             )
                     }
                )
                [ mapArg_, mapArg_0 ]
    , succeed =
        \succeedArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "succeed"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "a" ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.var "a" ]
                                  )
                             )
                     }
                )
                [ succeedArg_ ]
    , fail =
        \failArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "fail"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "error" ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.var "a" ]
                                  )
                             )
                     }
                )
                [ failArg_ ]
    , fromResult =
        \fromResultArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "fromResult"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Result" ]
                                      "Result"
                                      [ Type.var "error", Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.var "value" ]
                                  )
                             )
                     }
                )
                [ fromResultArg_ ]
    , andThen =
        \andThenArg_ andThenArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "andThen"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.var "error", Type.var "b" ]
                                      )
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.var "b" ]
                                  )
                             )
                     }
                )
                [ andThenArg_, andThenArg_0 ]
    , resolve =
        \resolveArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "resolve"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error"
                                      , Type.list
                                            (Type.namedWith
                                                 [ "BackendTask" ]
                                                 "BackendTask"
                                                 [ Type.var "error"
                                                 , Type.var "value"
                                                 ]
                                            )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.list (Type.var "value")
                                       ]
                                  )
                             )
                     }
                )
                [ resolveArg_ ]
    , combine =
        \combineArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "combine"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.var "error", Type.var "value" ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.list (Type.var "value")
                                       ]
                                  )
                             )
                     }
                )
                [ combineArg_ ]
    , andMap =
        \andMapArg_ andMapArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "andMap"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "a" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error"
                                      , Type.function
                                            [ Type.var "a" ]
                                            (Type.var "b")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.var "b" ]
                                  )
                             )
                     }
                )
                [ andMapArg_, andMapArg_0 ]
    , map2 =
        \map2Arg_ map2Arg_0 map2Arg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "map2"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a", Type.var "b" ]
                                      (Type.var "c")
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "a" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "b" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.var "c" ]
                                  )
                             )
                     }
                )
                [ map2Arg_, map2Arg_0, map2Arg_1 ]
    , map3 =
        \map3Arg_ map3Arg_0 map3Arg_1 map3Arg_2 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "map3"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "value1"
                                      , Type.var "value2"
                                      , Type.var "value3"
                                      ]
                                      (Type.var "valueCombined")
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value1" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value2" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value3" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.var "valueCombined"
                                       ]
                                  )
                             )
                     }
                )
                [ map3Arg_, map3Arg_0, map3Arg_1, map3Arg_2 ]
    , map4 =
        \map4Arg_ map4Arg_0 map4Arg_1 map4Arg_2 map4Arg_3 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "map4"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "value1"
                                      , Type.var "value2"
                                      , Type.var "value3"
                                      , Type.var "value4"
                                      ]
                                      (Type.var "valueCombined")
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value1" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value2" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value3" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value4" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.var "valueCombined"
                                       ]
                                  )
                             )
                     }
                )
                [ map4Arg_, map4Arg_0, map4Arg_1, map4Arg_2, map4Arg_3 ]
    , map5 =
        \map5Arg_ map5Arg_0 map5Arg_1 map5Arg_2 map5Arg_3 map5Arg_4 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "map5"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "value1"
                                      , Type.var "value2"
                                      , Type.var "value3"
                                      , Type.var "value4"
                                      , Type.var "value5"
                                      ]
                                      (Type.var "valueCombined")
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value1" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value2" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value3" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value4" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value5" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.var "valueCombined"
                                       ]
                                  )
                             )
                     }
                )
                [ map5Arg_
                , map5Arg_0
                , map5Arg_1
                , map5Arg_2
                , map5Arg_3
                , map5Arg_4
                ]
    , map6 =
        \map6Arg_ map6Arg_0 map6Arg_1 map6Arg_2 map6Arg_3 map6Arg_4 map6Arg_5 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "map6"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "value1"
                                      , Type.var "value2"
                                      , Type.var "value3"
                                      , Type.var "value4"
                                      , Type.var "value5"
                                      , Type.var "value6"
                                      ]
                                      (Type.var "valueCombined")
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value1" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value2" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value3" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value4" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value5" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value6" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.var "valueCombined"
                                       ]
                                  )
                             )
                     }
                )
                [ map6Arg_
                , map6Arg_0
                , map6Arg_1
                , map6Arg_2
                , map6Arg_3
                , map6Arg_4
                , map6Arg_5
                ]
    , map7 =
        \map7Arg_ map7Arg_0 map7Arg_1 map7Arg_2 map7Arg_3 map7Arg_4 map7Arg_5 map7Arg_6 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "map7"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "value1"
                                      , Type.var "value2"
                                      , Type.var "value3"
                                      , Type.var "value4"
                                      , Type.var "value5"
                                      , Type.var "value6"
                                      , Type.var "value7"
                                      ]
                                      (Type.var "valueCombined")
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value1" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value2" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value3" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value4" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value5" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value6" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value7" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.var "valueCombined"
                                       ]
                                  )
                             )
                     }
                )
                [ map7Arg_
                , map7Arg_0
                , map7Arg_1
                , map7Arg_2
                , map7Arg_3
                , map7Arg_4
                , map7Arg_5
                , map7Arg_6
                ]
    , map8 =
        \map8Arg_ map8Arg_0 map8Arg_1 map8Arg_2 map8Arg_3 map8Arg_4 map8Arg_5 map8Arg_6 map8Arg_7 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "map8"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "value1"
                                      , Type.var "value2"
                                      , Type.var "value3"
                                      , Type.var "value4"
                                      , Type.var "value5"
                                      , Type.var "value6"
                                      , Type.var "value7"
                                      , Type.var "value8"
                                      ]
                                      (Type.var "valueCombined")
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value1" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value2" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value3" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value4" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value5" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value6" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value7" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value8" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.var "valueCombined"
                                       ]
                                  )
                             )
                     }
                )
                [ map8Arg_
                , map8Arg_0
                , map8Arg_1
                , map8Arg_2
                , map8Arg_3
                , map8Arg_4
                , map8Arg_5
                , map8Arg_6
                , map8Arg_7
                ]
    , map9 =
        \map9Arg_ map9Arg_0 map9Arg_1 map9Arg_2 map9Arg_3 map9Arg_4 map9Arg_5 map9Arg_6 map9Arg_7 map9Arg_8 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "map9"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "value1"
                                      , Type.var "value2"
                                      , Type.var "value3"
                                      , Type.var "value4"
                                      , Type.var "value5"
                                      , Type.var "value6"
                                      , Type.var "value7"
                                      , Type.var "value8"
                                      , Type.var "value9"
                                      ]
                                      (Type.var "valueCombined")
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value1" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value2" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value3" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value4" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value5" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value6" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value7" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value8" ]
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value9" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.var "valueCombined"
                                       ]
                                  )
                             )
                     }
                )
                [ map9Arg_
                , map9Arg_0
                , map9Arg_1
                , map9Arg_2
                , map9Arg_3
                , map9Arg_4
                , map9Arg_5
                , map9Arg_6
                , map9Arg_7
                , map9Arg_8
                ]
    , allowFatal =
        \allowFatalArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "allowFatal"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.extensible
                                            "error"
                                            [ ( "fatal"
                                              , Type.namedWith
                                                    [ "FatalError" ]
                                                    "FatalError"
                                                    []
                                              )
                                            ]
                                      , Type.var "data"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.namedWith
                                           [ "FatalError" ]
                                           "FatalError"
                                           []
                                       , Type.var "data"
                                       ]
                                  )
                             )
                     }
                )
                [ allowFatalArg_ ]
    , mapError =
        \mapErrorArg_ mapErrorArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "mapError"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "error" ]
                                      (Type.var "errorMapped")
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "errorMapped"
                                       , Type.var "value"
                                       ]
                                  )
                             )
                     }
                )
                [ mapErrorArg_, mapErrorArg_0 ]
    , onError =
        \onErrorArg_ onErrorArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "onError"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "error" ]
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.var "mappedError"
                                         , Type.var "value"
                                         ]
                                      )
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "mappedError"
                                       , Type.var "value"
                                       ]
                                  )
                             )
                     }
                )
                [ onErrorArg_, onErrorArg_0 ]
    , toResult =
        \toResultArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "toResult"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "data" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "noError"
                                       , Type.namedWith
                                           [ "Result" ]
                                           "Result"
                                           [ Type.var "error", Type.var "data" ]
                                       ]
                                  )
                             )
                     }
                )
                [ toResultArg_ ]
    , do =
        \doArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "do"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.unit ]
                                  )
                             )
                     }
                )
                [ doArg_ ]
    , doEach =
        \doEachArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "doEach"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.var "error", Type.unit ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.unit ]
                                  )
                             )
                     }
                )
                [ doEachArg_ ]
    , sequence =
        \sequenceArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "sequence"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "BackendTask" ]
                                         "BackendTask"
                                         [ Type.var "error", Type.var "value" ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.list (Type.var "value")
                                       ]
                                  )
                             )
                     }
                )
                [ sequenceArg_ ]
    , failIf =
        \failIfArg_ failIfArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "failIf"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.bool
                                  , Type.namedWith
                                      [ "FatalError" ]
                                      "FatalError"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.namedWith
                                           [ "FatalError" ]
                                           "FatalError"
                                           []
                                       , Type.unit
                                       ]
                                  )
                             )
                     }
                )
                [ failIfArg_, failIfArg_0 ]
    , inDir =
        \inDirArg_ inDirArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "inDir"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.var "value" ]
                                  )
                             )
                     }
                )
                [ inDirArg_, inDirArg_0 ]
    , quiet =
        \quietArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "quiet"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.var "value" ]
                                  )
                             )
                     }
                )
                [ quietArg_ ]
    , withEnv =
        \withEnvArg_ withEnvArg_0 withEnvArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask" ]
                     , name = "withEnv"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.string
                                  , Type.namedWith
                                      [ "BackendTask" ]
                                      "BackendTask"
                                      [ Type.var "error", Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error", Type.var "value" ]
                                  )
                             )
                     }
                )
                [ withEnvArg_, withEnvArg_0, withEnvArg_1 ]
    }


values_ :
    { map : Elm.Expression
    , succeed : Elm.Expression
    , fail : Elm.Expression
    , fromResult : Elm.Expression
    , andThen : Elm.Expression
    , resolve : Elm.Expression
    , combine : Elm.Expression
    , andMap : Elm.Expression
    , map2 : Elm.Expression
    , map3 : Elm.Expression
    , map4 : Elm.Expression
    , map5 : Elm.Expression
    , map6 : Elm.Expression
    , map7 : Elm.Expression
    , map8 : Elm.Expression
    , map9 : Elm.Expression
    , allowFatal : Elm.Expression
    , mapError : Elm.Expression
    , onError : Elm.Expression
    , toResult : Elm.Expression
    , do : Elm.Expression
    , doEach : Elm.Expression
    , sequence : Elm.Expression
    , failIf : Elm.Expression
    , inDir : Elm.Expression
    , quiet : Elm.Expression
    , withEnv : Elm.Expression
    }
values_ =
    { map =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.var "a" ] (Type.var "b")
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "b" ]
                         )
                    )
            }
    , succeed =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "succeed"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "a" ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "a" ]
                         )
                    )
            }
    , fail =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "fail"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "error" ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "a" ]
                         )
                    )
            }
    , fromResult =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "fromResult"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Result" ]
                             "Result"
                             [ Type.var "error", Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                         )
                    )
            }
    , andThen =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "andThen"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a" ]
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.var "error", Type.var "b" ]
                             )
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "b" ]
                         )
                    )
            }
    , resolve =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "resolve"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error"
                             , Type.list
                                   (Type.namedWith
                                        [ "BackendTask" ]
                                        "BackendTask"
                                        [ Type.var "error", Type.var "value" ]
                                   )
                             ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.list (Type.var "value") ]
                         )
                    )
            }
    , combine =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "combine"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.var "error", Type.var "value" ]
                             )
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.list (Type.var "value") ]
                         )
                    )
            }
    , andMap =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "andMap"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "a" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error"
                             , Type.function [ Type.var "a" ] (Type.var "b")
                             ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "b" ]
                         )
                    )
            }
    , map2 =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "map2"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "a", Type.var "b" ]
                             (Type.var "c")
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "a" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "b" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "c" ]
                         )
                    )
            }
    , map3 =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "map3"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "value1"
                             , Type.var "value2"
                             , Type.var "value3"
                             ]
                             (Type.var "valueCombined")
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value1" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value2" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value3" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "valueCombined" ]
                         )
                    )
            }
    , map4 =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "map4"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "value1"
                             , Type.var "value2"
                             , Type.var "value3"
                             , Type.var "value4"
                             ]
                             (Type.var "valueCombined")
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value1" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value2" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value3" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value4" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "valueCombined" ]
                         )
                    )
            }
    , map5 =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "map5"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "value1"
                             , Type.var "value2"
                             , Type.var "value3"
                             , Type.var "value4"
                             , Type.var "value5"
                             ]
                             (Type.var "valueCombined")
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value1" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value2" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value3" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value4" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value5" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "valueCombined" ]
                         )
                    )
            }
    , map6 =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "map6"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "value1"
                             , Type.var "value2"
                             , Type.var "value3"
                             , Type.var "value4"
                             , Type.var "value5"
                             , Type.var "value6"
                             ]
                             (Type.var "valueCombined")
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value1" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value2" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value3" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value4" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value5" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value6" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "valueCombined" ]
                         )
                    )
            }
    , map7 =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "map7"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "value1"
                             , Type.var "value2"
                             , Type.var "value3"
                             , Type.var "value4"
                             , Type.var "value5"
                             , Type.var "value6"
                             , Type.var "value7"
                             ]
                             (Type.var "valueCombined")
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value1" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value2" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value3" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value4" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value5" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value6" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value7" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "valueCombined" ]
                         )
                    )
            }
    , map8 =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "map8"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "value1"
                             , Type.var "value2"
                             , Type.var "value3"
                             , Type.var "value4"
                             , Type.var "value5"
                             , Type.var "value6"
                             , Type.var "value7"
                             , Type.var "value8"
                             ]
                             (Type.var "valueCombined")
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value1" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value2" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value3" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value4" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value5" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value6" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value7" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value8" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "valueCombined" ]
                         )
                    )
            }
    , map9 =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "map9"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "value1"
                             , Type.var "value2"
                             , Type.var "value3"
                             , Type.var "value4"
                             , Type.var "value5"
                             , Type.var "value6"
                             , Type.var "value7"
                             , Type.var "value8"
                             , Type.var "value9"
                             ]
                             (Type.var "valueCombined")
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value1" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value2" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value3" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value4" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value5" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value6" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value7" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value8" ]
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value9" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "valueCombined" ]
                         )
                    )
            }
    , allowFatal =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "allowFatal"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.extensible
                                   "error"
                                   [ ( "fatal"
                                     , Type.namedWith
                                           [ "FatalError" ]
                                           "FatalError"
                                           []
                                     )
                                   ]
                             , Type.var "data"
                             ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.var "data"
                              ]
                         )
                    )
            }
    , mapError =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "mapError"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "error" ]
                             (Type.var "errorMapped")
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "errorMapped", Type.var "value" ]
                         )
                    )
            }
    , onError =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "onError"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "error" ]
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.var "mappedError", Type.var "value" ]
                             )
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "mappedError", Type.var "value" ]
                         )
                    )
            }
    , toResult =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "toResult"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "data" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "noError"
                              , Type.namedWith
                                  [ "Result" ]
                                  "Result"
                                  [ Type.var "error", Type.var "data" ]
                              ]
                         )
                    )
            }
    , do =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "do"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.unit ]
                         )
                    )
            }
    , doEach =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "doEach"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.var "error", Type.unit ]
                             )
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.unit ]
                         )
                    )
            }
    , sequence =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "sequence"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "BackendTask" ]
                                "BackendTask"
                                [ Type.var "error", Type.var "value" ]
                             )
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.list (Type.var "value") ]
                         )
                    )
            }
    , failIf =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "failIf"
            , annotation =
                Just
                    (Type.function
                         [ Type.bool
                         , Type.namedWith [ "FatalError" ] "FatalError" []
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.unit
                              ]
                         )
                    )
            }
    , inDir =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "inDir"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                         )
                    )
            }
    , quiet =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "quiet"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                         )
                    )
            }
    , withEnv =
        Elm.value
            { importFrom = [ "BackendTask" ]
            , name = "withEnv"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.string
                         , Type.namedWith
                             [ "BackendTask" ]
                             "BackendTask"
                             [ Type.var "error", Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.var "value" ]
                         )
                    )
            }
    }