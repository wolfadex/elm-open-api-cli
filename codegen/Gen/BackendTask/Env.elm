module Gen.BackendTask.Env exposing
    ( moduleName_, get, expect, annotation_, make_, caseOf_
    , call_, values_
    )

{-|
# Generated bindings for BackendTask.Env

@docs moduleName_, get, expect, annotation_, make_, caseOf_
@docs call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "BackendTask", "Env" ]


{-| Get an environment variable, or Nothing if there is no environment variable matching that name. This `BackendTask`
will never fail, but instead will return `Nothing` if the environment variable is missing.

get: String -> BackendTask.BackendTask error (Maybe String)
-}
get : String -> Elm.Expression
get getArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Env" ]
             , name = "get"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.maybe Type.string ]
                          )
                     )
             }
        )
        [ Elm.string getArg_ ]


{-| Get an environment variable, or a BackendTask FatalError if there is no environment variable matching that name.

expect: 
    String
    -> BackendTask.BackendTask { fatal : FatalError.FatalError
    , recoverable : BackendTask.Env.Error
    } String
-}
expect : String -> Elm.Expression
expect expectArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Env" ]
             , name = "expect"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
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
                                         [ "BackendTask", "Env" ]
                                         "Error"
                                         []
                                     )
                                   ]
                               , Type.string
                               ]
                          )
                     )
             }
        )
        [ Elm.string expectArg_ ]


annotation_ : { error : Type.Annotation }
annotation_ =
    { error = Type.namedWith [ "BackendTask", "Env" ] "Error" [] }


make_ : { missingEnvVariable : Elm.Expression -> Elm.Expression }
make_ =
    { missingEnvVariable =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Env" ]
                     , name = "MissingEnvVariable"
                     , annotation = Just (Type.namedWith [] "Error" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { error :
        Elm.Expression
        -> { missingEnvVariable : Elm.Expression -> Elm.Expression }
        -> Elm.Expression
    }
caseOf_ =
    { error =
        \errorExpression errorTags ->
            Elm.Case.custom
                errorExpression
                (Type.namedWith [ "BackendTask", "Env" ] "Error" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "MissingEnvVariable"
                       errorTags.missingEnvVariable |> Elm.Arg.item
                                                             (Elm.Arg.varWith
                                                                    "arg_0"
                                                                    Type.string
                                                             )
                    )
                    Basics.identity
                ]
    }


call_ :
    { get : Elm.Expression -> Elm.Expression
    , expect : Elm.Expression -> Elm.Expression
    }
call_ =
    { get =
        \getArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Env" ]
                     , name = "get"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.maybe Type.string
                                       ]
                                  )
                             )
                     }
                )
                [ getArg_ ]
    , expect =
        \expectArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Env" ]
                     , name = "expect"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
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
                                                 [ "BackendTask", "Env" ]
                                                 "Error"
                                                 []
                                             )
                                           ]
                                       , Type.string
                                       ]
                                  )
                             )
                     }
                )
                [ expectArg_ ]
    }


values_ : { get : Elm.Expression, expect : Elm.Expression }
values_ =
    { get =
        Elm.value
            { importFrom = [ "BackendTask", "Env" ]
            , name = "get"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.maybe Type.string ]
                         )
                    )
            }
    , expect =
        Elm.value
            { importFrom = [ "BackendTask", "Env" ]
            , name = "expect"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
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
                                        [ "BackendTask", "Env" ]
                                        "Error"
                                        []
                                    )
                                  ]
                              , Type.string
                              ]
                         )
                    )
            }
    }