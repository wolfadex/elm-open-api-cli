module Gen.BackendTask.Http exposing
    ( expectString, expectJson
    , expectBytes, emptyBody, jsonBody
    , annotation_
    , call_
    , bytesBody
    )

{-|


# Generated bindings for BackendTask.Http

@docs get, expectString, expectJson
@docs expectBytes, emptyBody, jsonBody
@docs bytesBodyWithOptions, annotation_
@docs call_

-}

import Elm
import Elm.Annotation as Type


{-| The name of this module.
-}
moduleName_ : List String
moduleName_ =
    [ "BackendTask", "Http" ]


{-| Gives the HTTP response body as a raw String.

    import BackendTask exposing (BackendTask)
    import BackendTask.Http

    request : BackendTask String
    request =
        BackendTask.Http.request
            { url = "https://example.com/file.txt"
            , method = "GET"
            , headers = []
            , body = BackendTask.Http.emptyBody
            }
            BackendTask.Http.expectString

expectString: BackendTask.Http.Expect String

-}
expectString : Elm.Expression
expectString =
    Elm.value
        { importFrom = [ "BackendTask", "Http" ]
        , name = "expectString"
        , annotation =
            Just
                (Type.namedWith
                    [ "BackendTask", "Http" ]
                    "Expect"
                    [ Type.string ]
                )
        }


{-| Handle the incoming response as JSON and don't optimize the asset and strip out unused values.
Be sure to use the `BackendTask.Http.request` function if you want an optimized request that
strips out unused JSON to optimize your asset size. This function makes sense to use for things like a GraphQL request
where the JSON payload is already trimmed down to the data you explicitly requested.

If the function you pass to `expectString` yields an `Err`, then you will get a build error that will
fail your `elm-pages` build and print out the String from the `Err`.

expectJson: Json.Decode.Decoder value -> BackendTask.Http.Expect value

-}
expectJson : Elm.Expression -> Elm.Expression
expectJson expectJsonArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "expectJson"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "value" ]
                        ]
                        (Type.namedWith
                            [ "BackendTask", "Http" ]
                            "Expect"
                            [ Type.var "value" ]
                        )
                    )
            }
        )
        [ expectJsonArg_ ]


{-| expectBytes: Bytes.Decode.Decoder value -> BackendTask.Http.Expect value
-}
expectBytes : Elm.Expression -> Elm.Expression
expectBytes expectBytesArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "expectBytes"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "value" ]
                        ]
                        (Type.namedWith
                            [ "BackendTask", "Http" ]
                            "Expect"
                            [ Type.var "value" ]
                        )
                    )
            }
        )
        [ expectBytesArg_ ]


{-| Build an empty body for a BackendTask.Http request. See [elm/http's `Http.emptyBody`](https://package.elm-lang.org/packages/elm/http/latest/Http#emptyBody).

emptyBody: BackendTask.Http.Body

-}
emptyBody : Elm.Expression
emptyBody =
    Elm.value
        { importFrom = [ "BackendTask", "Http" ]
        , name = "emptyBody"
        , annotation = Just (Type.namedWith [ "BackendTask", "Http" ] "Body" [])
        }


{-| Builds a JSON body for a BackendTask.Http request. See [elm/http's `Http.jsonBody`](https://package.elm-lang.org/packages/elm/http/latest/Http#jsonBody).

jsonBody: Json.Encode.Value -> BackendTask.Http.Body

-}
jsonBody : Elm.Expression -> Elm.Expression
jsonBody jsonBodyArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "jsonBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Json", "Encode" ] "Value" [] ]
                        (Type.namedWith [ "BackendTask", "Http" ] "Body" [])
                    )
            }
        )
        [ jsonBodyArg_ ]


{-| Build a body from `Bytes` for a BackendTask.Http request. See [elm/http's `Http.bytesBody`](https://package.elm-lang.org/packages/elm/http/latest/Http#bytesBody).

bytesBody: String -> Bytes.Bytes -> BackendTask.Http.Body

-}
bytesBody : String -> Elm.Expression -> Elm.Expression
bytesBody bytesBodyArg_ bytesBodyArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "bytesBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.namedWith [ "Bytes" ] "Bytes" [] ]
                        (Type.namedWith [ "BackendTask", "Http" ] "Body" [])
                    )
            }
        )
        [ Elm.string bytesBodyArg_, bytesBodyArg_0 ]


annotation_ :
    { expect : Type.Annotation -> Type.Annotation
    , error : Type.Annotation
    , body : Type.Annotation
    , cacheStrategy : Type.Annotation
    , metadata : Type.Annotation
    }
annotation_ =
    { expect =
        \expectArg0 ->
            Type.namedWith [ "BackendTask", "Http" ] "Expect" [ expectArg0 ]
    , error = Type.namedWith [ "BackendTask", "Http" ] "Error" []
    , body =
        Type.alias
            moduleName_
            "Body"
            []
            (Type.namedWith [ "Pages", "Internal", "StaticHttpBody" ] "Body" [])
    , cacheStrategy =
        Type.namedWith [ "BackendTask", "Http" ] "CacheStrategy" []
    , metadata =
        Type.alias
            moduleName_
            "Metadata"
            []
            (Type.record
                [ ( "url", Type.string )
                , ( "statusCode", Type.int )
                , ( "statusText", Type.string )
                , ( "headers"
                  , Type.namedWith
                        [ "Dict" ]
                        "Dict"
                        [ Type.string, Type.string ]
                  )
                ]
            )
    }


call_ :
    { get : Elm.Expression -> Elm.Expression -> Elm.Expression
    , getJson : Elm.Expression -> Elm.Expression -> Elm.Expression
    , post :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectJson : Elm.Expression -> Elm.Expression
    , expectBytes : Elm.Expression -> Elm.Expression
    , expectWhatever : Elm.Expression -> Elm.Expression
    , request : Elm.Expression -> Elm.Expression -> Elm.Expression
    , stringBody : Elm.Expression -> Elm.Expression -> Elm.Expression
    , jsonBody : Elm.Expression -> Elm.Expression
    , bytesBody : Elm.Expression -> Elm.Expression -> Elm.Expression
    , getWithOptions : Elm.Expression -> Elm.Expression
    , withMetadata : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { get =
        \getArg_ getArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "BackendTask", "Http" ]
                    , name = "get"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "BackendTask", "Http" ]
                                    "Expect"
                                    [ Type.var "a" ]
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
                                                [ "BackendTask", "Http" ]
                                                "Error"
                                                []
                                          )
                                        ]
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ getArg_, getArg_0 ]
    , getJson =
        \getJsonArg_ getJsonArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "BackendTask", "Http" ]
                    , name = "getJson"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
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
                                                [ "BackendTask", "Http" ]
                                                "Error"
                                                []
                                          )
                                        ]
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ getJsonArg_, getJsonArg_0 ]
    , post =
        \postArg_ postArg_0 postArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "BackendTask", "Http" ]
                    , name = "post"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "BackendTask", "Http" ]
                                    "Body"
                                    []
                                , Type.namedWith
                                    [ "BackendTask", "Http" ]
                                    "Expect"
                                    [ Type.var "a" ]
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
                                                [ "BackendTask", "Http" ]
                                                "Error"
                                                []
                                          )
                                        ]
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ postArg_, postArg_0, postArg_1 ]
    , expectJson =
        \expectJsonArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "BackendTask", "Http" ]
                    , name = "expectJson"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "value" ]
                                ]
                                (Type.namedWith
                                    [ "BackendTask", "Http" ]
                                    "Expect"
                                    [ Type.var "value" ]
                                )
                            )
                    }
                )
                [ expectJsonArg_ ]
    , expectBytes =
        \expectBytesArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "BackendTask", "Http" ]
                    , name = "expectBytes"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "value" ]
                                ]
                                (Type.namedWith
                                    [ "BackendTask", "Http" ]
                                    "Expect"
                                    [ Type.var "value" ]
                                )
                            )
                    }
                )
                [ expectBytesArg_ ]
    , expectWhatever =
        \expectWhateverArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "BackendTask", "Http" ]
                    , name = "expectWhatever"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.var "value" ]
                                (Type.namedWith
                                    [ "BackendTask", "Http" ]
                                    "Expect"
                                    [ Type.var "value" ]
                                )
                            )
                    }
                )
                [ expectWhateverArg_ ]
    , request =
        \requestArg_ requestArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "BackendTask", "Http" ]
                    , name = "request"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "url", Type.string )
                                    , ( "method", Type.string )
                                    , ( "headers"
                                      , Type.list
                                            (Type.tuple Type.string Type.string)
                                      )
                                    , ( "body"
                                      , Type.namedWith
                                            [ "BackendTask", "Http" ]
                                            "Body"
                                            []
                                      )
                                    , ( "retries", Type.maybe Type.int )
                                    , ( "timeoutInMs", Type.maybe Type.int )
                                    ]
                                , Type.namedWith
                                    [ "BackendTask", "Http" ]
                                    "Expect"
                                    [ Type.var "a" ]
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
                                                [ "BackendTask", "Http" ]
                                                "Error"
                                                []
                                          )
                                        ]
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ requestArg_, requestArg_0 ]
    , stringBody =
        \stringBodyArg_ stringBodyArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "BackendTask", "Http" ]
                    , name = "stringBody"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                (Type.namedWith
                                    [ "BackendTask", "Http" ]
                                    "Body"
                                    []
                                )
                            )
                    }
                )
                [ stringBodyArg_, stringBodyArg_0 ]
    , jsonBody =
        \jsonBodyArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "BackendTask", "Http" ]
                    , name = "jsonBody"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Json", "Encode" ]
                                    "Value"
                                    []
                                ]
                                (Type.namedWith
                                    [ "BackendTask", "Http" ]
                                    "Body"
                                    []
                                )
                            )
                    }
                )
                [ jsonBodyArg_ ]
    , bytesBody =
        \bytesBodyArg_ bytesBodyArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "BackendTask", "Http" ]
                    , name = "bytesBody"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith [ "Bytes" ] "Bytes" []
                                ]
                                (Type.namedWith
                                    [ "BackendTask", "Http" ]
                                    "Body"
                                    []
                                )
                            )
                    }
                )
                [ bytesBodyArg_, bytesBodyArg_0 ]
    , getWithOptions =
        \getWithOptionsArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "BackendTask", "Http" ]
                    , name = "getWithOptions"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "url", Type.string )
                                    , ( "expect"
                                      , Type.namedWith
                                            [ "BackendTask", "Http" ]
                                            "Expect"
                                            [ Type.var "a" ]
                                      )
                                    , ( "headers"
                                      , Type.list
                                            (Type.tuple Type.string Type.string)
                                      )
                                    , ( "cacheStrategy"
                                      , Type.maybe
                                            (Type.namedWith
                                                [ "BackendTask", "Http" ]
                                                "CacheStrategy"
                                                []
                                            )
                                      )
                                    , ( "retries", Type.maybe Type.int )
                                    , ( "timeoutInMs", Type.maybe Type.int )
                                    , ( "cachePath", Type.maybe Type.string )
                                    ]
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
                                                [ "BackendTask", "Http" ]
                                                "Error"
                                                []
                                          )
                                        ]
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ getWithOptionsArg_ ]
    , withMetadata =
        \withMetadataArg_ withMetadataArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "BackendTask", "Http" ]
                    , name = "withMetadata"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith
                                        [ "BackendTask", "Http" ]
                                        "Metadata"
                                        []
                                    , Type.var "value"
                                    ]
                                    (Type.var "combined")
                                , Type.namedWith
                                    [ "BackendTask", "Http" ]
                                    "Expect"
                                    [ Type.var "value" ]
                                ]
                                (Type.namedWith
                                    [ "BackendTask", "Http" ]
                                    "Expect"
                                    [ Type.var "combined" ]
                                )
                            )
                    }
                )
                [ withMetadataArg_, withMetadataArg_0 ]
    }
