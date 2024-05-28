module Gen.BackendTask.Custom exposing (annotation_, call_, caseOf_, dateDecoder, make_, moduleName_, run, timeDecoder, values_)

{-| 
@docs moduleName_, run, timeDecoder, dateDecoder, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "BackendTask", "Custom" ]


{-| run: 
    String
    -> Json.Encode.Value
    -> Json.Decode.Decoder b
    -> BackendTask.BackendTask { fatal : FatalError.FatalError
    , recoverable : BackendTask.Custom.Error
    } b
-}
run : String -> Elm.Expression -> Elm.Expression -> Elm.Expression
run runArg runArg0 runArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Custom" ]
             , name = "run"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Json", "Encode" ] "Value" []
                          , Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.var "b" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.record
                                   [ ( "fatal"
                                     , Type.namedWith
                                         [ "FatalError" ]
                                         "FatalError"
                                         []
                                     )
                                   , ( "recoverable"
                                     , Type.namedWith
                                         [ "BackendTask", "Custom" ]
                                         "Error"
                                         []
                                     )
                                   ]
                               , Type.var "b"
                               ]
                          )
                     )
             }
        )
        [ Elm.string runArg, runArg0, runArg1 ]


{-| timeDecoder: Json.Decode.Decoder Time.Posix -}
timeDecoder : Elm.Expression
timeDecoder =
    Elm.value
        { importFrom = [ "BackendTask", "Custom" ]
        , name = "timeDecoder"
        , annotation =
            Just
                (Type.namedWith
                     [ "Json", "Decode" ]
                     "Decoder"
                     [ Type.namedWith [ "Time" ] "Posix" [] ]
                )
        }


{-| The same as `timeDecoder`, but it converts the decoded `Time.Posix` value into a `Date` with `Date.fromPosix Time.utc`.

JavaScript `Date` objects don't distinguish between values with only a date vs. values with both a date and a time. So be sure
to use this decoder when you know the semantics represent a date with no associated time (or you're sure you don't care about the time).

dateDecoder: Json.Decode.Decoder Date.Date
-}
dateDecoder : Elm.Expression
dateDecoder =
    Elm.value
        { importFrom = [ "BackendTask", "Custom" ]
        , name = "dateDecoder"
        , annotation =
            Just
                (Type.namedWith
                     [ "Json", "Decode" ]
                     "Decoder"
                     [ Type.namedWith [ "Date" ] "Date" [] ]
                )
        }


annotation_ : { error : Type.Annotation }
annotation_ =
    { error = Type.namedWith [ "BackendTask", "Custom" ] "Error" [] }


make_ :
    { error : Elm.Expression
    , errorInCustomBackendTaskFile : Elm.Expression
    , missingCustomBackendTaskFile : Elm.Expression
    , customBackendTaskNotDefined : Elm.Expression -> Elm.Expression
    , customBackendTaskException : Elm.Expression -> Elm.Expression
    , nonJsonException : Elm.Expression -> Elm.Expression
    , exportIsNotFunction : Elm.Expression
    , decodeError : Elm.Expression -> Elm.Expression
    }
make_ =
    { error =
        Elm.value
            { importFrom = [ "BackendTask", "Custom" ]
            , name = "Error"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , errorInCustomBackendTaskFile =
        Elm.value
            { importFrom = [ "BackendTask", "Custom" ]
            , name = "ErrorInCustomBackendTaskFile"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , missingCustomBackendTaskFile =
        Elm.value
            { importFrom = [ "BackendTask", "Custom" ]
            , name = "MissingCustomBackendTaskFile"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , customBackendTaskNotDefined =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Custom" ]
                     , name = "CustomBackendTaskNotDefined"
                     , annotation = Just (Type.namedWith [] "Error" [])
                     }
                )
                [ ar0 ]
    , customBackendTaskException =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Custom" ]
                     , name = "CustomBackendTaskException"
                     , annotation = Just (Type.namedWith [] "Error" [])
                     }
                )
                [ ar0 ]
    , nonJsonException =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Custom" ]
                     , name = "NonJsonException"
                     , annotation = Just (Type.namedWith [] "Error" [])
                     }
                )
                [ ar0 ]
    , exportIsNotFunction =
        Elm.value
            { importFrom = [ "BackendTask", "Custom" ]
            , name = "ExportIsNotFunction"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , decodeError =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Custom" ]
                     , name = "DecodeError"
                     , annotation = Just (Type.namedWith [] "Error" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { error :
        Elm.Expression
        -> { errorTags_0_0
            | error : Elm.Expression
            , errorInCustomBackendTaskFile : Elm.Expression
            , missingCustomBackendTaskFile : Elm.Expression
            , customBackendTaskNotDefined : Elm.Expression -> Elm.Expression
            , customBackendTaskException : Elm.Expression -> Elm.Expression
            , nonJsonException : Elm.Expression -> Elm.Expression
            , exportIsNotFunction : Elm.Expression
            , decodeError : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { error =
        \errorExpression errorTags ->
            Elm.Case.custom
                errorExpression
                (Type.namedWith [ "BackendTask", "Custom" ] "Error" [])
                [ Elm.Case.branch0 "Error" errorTags.error
                , Elm.Case.branch0
                    "ErrorInCustomBackendTaskFile"
                    errorTags.errorInCustomBackendTaskFile
                , Elm.Case.branch0
                    "MissingCustomBackendTaskFile"
                    errorTags.missingCustomBackendTaskFile
                , Elm.Case.branch1
                    "CustomBackendTaskNotDefined"
                    ( "one", Type.record [ ( "name", Type.string ) ] )
                    errorTags.customBackendTaskNotDefined
                , Elm.Case.branch1
                    "CustomBackendTaskException"
                    ( "jsonDecodeValue"
                    , Type.namedWith [ "Json", "Decode" ] "Value" []
                    )
                    errorTags.customBackendTaskException
                , Elm.Case.branch1
                    "NonJsonException"
                    ( "stringString", Type.string )
                    errorTags.nonJsonException
                , Elm.Case.branch0
                    "ExportIsNotFunction"
                    errorTags.exportIsNotFunction
                , Elm.Case.branch1
                    "DecodeError"
                    ( "jsonDecodeError"
                    , Type.namedWith [ "Json", "Decode" ] "Error" []
                    )
                    errorTags.decodeError
                ]
    }


call_ :
    { run : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { run =
        \runArg runArg0 runArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Custom" ]
                     , name = "run"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Json", "Encode" ]
                                      "Value"
                                      []
                                  , Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Decoder"
                                      [ Type.var "b" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.record
                                           [ ( "fatal"
                                             , Type.namedWith
                                                 [ "FatalError" ]
                                                 "FatalError"
                                                 []
                                             )
                                           , ( "recoverable"
                                             , Type.namedWith
                                                 [ "BackendTask", "Custom" ]
                                                 "Error"
                                                 []
                                             )
                                           ]
                                       , Type.var "b"
                                       ]
                                  )
                             )
                     }
                )
                [ runArg, runArg0, runArg1 ]
    }


values_ :
    { run : Elm.Expression
    , timeDecoder : Elm.Expression
    , dateDecoder : Elm.Expression
    }
values_ =
    { run =
        Elm.value
            { importFrom = [ "BackendTask", "Custom" ]
            , name = "run"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Json", "Encode" ] "Value" []
                         , Type.namedWith
                             [ "Json", "Decode" ]
                             "Decoder"
                             [ Type.var "b" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.record
                                  [ ( "fatal"
                                    , Type.namedWith
                                        [ "FatalError" ]
                                        "FatalError"
                                        []
                                    )
                                  , ( "recoverable"
                                    , Type.namedWith
                                        [ "BackendTask", "Custom" ]
                                        "Error"
                                        []
                                    )
                                  ]
                              , Type.var "b"
                              ]
                         )
                    )
            }
    , timeDecoder =
        Elm.value
            { importFrom = [ "BackendTask", "Custom" ]
            , name = "timeDecoder"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Json", "Decode" ]
                         "Decoder"
                         [ Type.namedWith [ "Time" ] "Posix" [] ]
                    )
            }
    , dateDecoder =
        Elm.value
            { importFrom = [ "BackendTask", "Custom" ]
            , name = "dateDecoder"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Json", "Decode" ]
                         "Decoder"
                         [ Type.namedWith [ "Date" ] "Date" [] ]
                    )
            }
    }