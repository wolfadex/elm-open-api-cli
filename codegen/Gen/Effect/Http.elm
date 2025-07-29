module Gen.Effect.Http exposing
    ( bytesResolver, stringResolver
    , expectBytesResponse, expectStringResponse
    , bytesBody, jsonBody
    , emptyBody, annotation_
    , caseOf_, call_
    )

{-|


# Generated bindings for Effect.Http

@docs bytesResolver, stringResolver
@docs expectBytesResponse, expectStringResponse
@docs bytesBody, jsonBody
@docs emptyBody, annotation_
@docs caseOf_, call_

-}

import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module.
-}
moduleName_ : List String
moduleName_ =
    [ "Effect", "Http" ]


{-| {-| Turn a response with a `Bytes` body into a result.
Similar to [`expectBytesResponse`](#expectBytesResponse).
-}

bytesResolver:
(Effect.Http.Response Bytes.Bytes -> Result.Result x a)
-> Effect.Http.Resolver restriction x a

-}
bytesResolver : (Elm.Expression -> Elm.Expression) -> Elm.Expression
bytesResolver bytesResolverArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "bytesResolver"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith
                                [ "Effect", "Http" ]
                                "Response"
                                [ Type.namedWith [ "Bytes" ] "Bytes" [] ]
                            ]
                            (Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.var "x", Type.var "a" ]
                            )
                        ]
                        (Type.namedWith
                            [ "Effect", "Http" ]
                            "Resolver"
                            [ Type.var "restriction"
                            , Type.var "x"
                            , Type.var "a"
                            ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "bytesResolverUnpack" bytesResolverArg_ ]


{-| {-| Turn a response with a `String` body into a result.
-}

stringResolver:
(Effect.Http.Response String -> Result.Result x a)
-> Effect.Http.Resolver restriction x a

-}
stringResolver : (Elm.Expression -> Elm.Expression) -> Elm.Expression
stringResolver stringResolverArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "stringResolver"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith
                                [ "Effect", "Http" ]
                                "Response"
                                [ Type.string ]
                            ]
                            (Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.var "x", Type.var "a" ]
                            )
                        ]
                        (Type.namedWith
                            [ "Effect", "Http" ]
                            "Resolver"
                            [ Type.var "restriction"
                            , Type.var "x"
                            , Type.var "a"
                            ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "stringResolverUnpack" stringResolverArg_ ]


{-| {-| Expect a [`Response`](#Response) with a `Bytes` body.

It works just like [`expectStringResponse`](#expectStringResponse), giving you
more access to headers and more leeway in defining your own errors.

-}

expectBytesResponse:
(Result.Result x a -> msg)
-> (Effect.Http.Response Bytes.Bytes -> Result.Result x a)
-> Effect.Http.Expect msg

-}
expectBytesResponse :
    (Elm.Expression -> Elm.Expression)
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
expectBytesResponse expectBytesResponseArg_ expectBytesResponseArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "expectBytesResponse"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.var "x", Type.var "a" ]
                            ]
                            (Type.var "msg")
                        , Type.function
                            [ Type.namedWith
                                [ "Effect", "Http" ]
                                "Response"
                                [ Type.namedWith [ "Bytes" ] "Bytes" [] ]
                            ]
                            (Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.var "x", Type.var "a" ]
                            )
                        ]
                        (Type.namedWith
                            [ "Effect", "Http" ]
                            "Expect"
                            [ Type.var "msg" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "expectBytesResponseUnpack"
            expectBytesResponseArg_
        , Elm.functionReduced
            "expectBytesResponseUnpack"
            expectBytesResponseArg_0
        ]


{-| {-| Expect a Response with a String body.
-}

expectStringResponse:
(Result.Result x a -> msg)
-> (Effect.Http.Response String -> Result.Result x a)
-> Effect.Http.Expect msg

-}
expectStringResponse :
    (Elm.Expression -> Elm.Expression)
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
expectStringResponse expectStringResponseArg_ expectStringResponseArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "expectStringResponse"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.var "x", Type.var "a" ]
                            ]
                            (Type.var "msg")
                        , Type.function
                            [ Type.namedWith
                                [ "Effect", "Http" ]
                                "Response"
                                [ Type.string ]
                            ]
                            (Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.var "x", Type.var "a" ]
                            )
                        ]
                        (Type.namedWith
                            [ "Effect", "Http" ]
                            "Expect"
                            [ Type.var "msg" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced
            "expectStringResponseUnpack"
            expectStringResponseArg_
        , Elm.functionReduced
            "expectStringResponseUnpack"
            expectStringResponseArg_0
        ]


{-| {-| Put some `Bytes` in the body of your `Request`. This allows you to use
[`elm/bytes`](/packages/elm/bytes/latest) to have full control over the binary
representation of the data you are sending. For example, you could create an
`archive.zip` file and send it along like this:

    import Bytes exposing (Bytes)

    zipBody : Bytes -> Body
    zipBody bytes =
        bytesBody "application/zip" bytes

The first argument is a [MIME type](https://en.wikipedia.org/wiki/Media_type)
of the body. In other scenarios you may want to use MIME types like `image/png`
or `image/jpeg` instead.

**Note:** Use [`track`](#track) to track upload progress.

-}

bytesBody: String -> Bytes.Bytes -> Effect.Http.Body

-}
bytesBody : String -> Elm.Expression -> Elm.Expression
bytesBody bytesBodyArg_ bytesBodyArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "bytesBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.namedWith [ "Bytes" ] "Bytes" [] ]
                        (Type.namedWith [ "Effect", "Http" ] "Body" [])
                    )
            }
        )
        [ Elm.string bytesBodyArg_, bytesBodyArg_0 ]


{-| {-| Put some JSON value in the body of your `Request`. This will automatically
add the `Content-Type: application/json` header.
-}

jsonBody: Json.Encode.Value -> Effect.Http.Body

-}
jsonBody : Elm.Expression -> Elm.Expression
jsonBody jsonBodyArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "jsonBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Json", "Encode" ] "Value" [] ]
                        (Type.namedWith [ "Effect", "Http" ] "Body" [])
                    )
            }
        )
        [ jsonBodyArg_ ]


{-| {-| Create an empty body for your `Request`.
-}

emptyBody: Effect.Http.Body

-}
emptyBody : Elm.Expression
emptyBody =
    Elm.value
        { importFrom = [ "Effect", "Http" ]
        , name = "emptyBody"
        , annotation = Just (Type.namedWith [ "Effect", "Http" ] "Body" [])
        }


annotation_ :
    { metadata : Type.Annotation
    , part : Type.Annotation
    , body : Type.Annotation
    , header : Type.Annotation
    , resolver :
        Type.Annotation -> Type.Annotation -> Type.Annotation -> Type.Annotation
    , error : Type.Annotation
    , response : Type.Annotation -> Type.Annotation
    , expect : Type.Annotation -> Type.Annotation
    , progress : Type.Annotation
    }
annotation_ =
    { metadata =
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
    , part =
        Type.alias
            moduleName_
            "Part"
            []
            (Type.namedWith [ "Effect", "Internal" ] "HttpPart" [])
    , body =
        Type.alias
            moduleName_
            "Body"
            []
            (Type.namedWith [ "Effect", "Internal" ] "HttpBody" [])
    , header =
        Type.alias moduleName_ "Header" [] (Type.tuple Type.string Type.string)
    , resolver =
        \resolverArg0 resolverArg1 resolverArg2 ->
            Type.namedWith
                [ "Effect", "Http" ]
                "Resolver"
                [ resolverArg0, resolverArg1, resolverArg2 ]
    , error = Type.namedWith [ "Effect", "Http" ] "Error" []
    , response =
        \responseArg0 ->
            Type.namedWith [ "Effect", "Http" ] "Response" [ responseArg0 ]
    , expect =
        \expectArg0 ->
            Type.namedWith [ "Effect", "Http" ] "Expect" [ expectArg0 ]
    , progress = Type.namedWith [ "Effect", "Http" ] "Progress" []
    }


caseOf_ =
    { error =
        \errorExpression errorTags ->
            Elm.Case.custom
                errorExpression
                (Type.namedWith [ "Effect", "Http" ] "Error" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                        "BadUrl"
                        errorTags.badUrl
                        |> Elm.Arg.item
                            (Elm.Arg.varWith
                                "arg_0"
                                Type.string
                            )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Timeout" errorTags.timeout)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "NetworkError" errorTags.networkError)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                        "BadStatus"
                        errorTags.badStatus
                        |> Elm.Arg.item
                            (Elm.Arg.varWith
                                "arg_0"
                                Type.int
                            )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                        "BadBody"
                        errorTags.badBody
                        |> Elm.Arg.item
                            (Elm.Arg.varWith
                                "arg_0"
                                Type.string
                            )
                    )
                    Basics.identity
                ]
    , response =
        \responseExpression responseTags ->
            Elm.Case.custom
                responseExpression
                (Type.namedWith
                    [ "Effect", "Http" ]
                    "Response"
                    [ Type.var "body" ]
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType
                        "BadUrl_"
                        responseTags.badUrl_
                        |> Elm.Arg.item
                            (Elm.Arg.varWith
                                "arg_0"
                                Type.string
                            )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Timeout_" responseTags.timeout_)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                        "NetworkError_"
                        responseTags.networkError_
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                        "BadStatus_"
                        responseTags.badStatus_
                        |> Elm.Arg.item
                            (Elm.Arg.varWith
                                "effectHttpMetadata"
                                (Type.namedWith
                                    [ "Effect"
                                    , "Http"
                                    ]
                                    "Metadata"
                                    []
                                )
                            )
                        |> Elm.Arg.item
                            (Elm.Arg.varWith
                                "body"
                                (Type.var
                                    "body"
                                )
                            )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                        "GoodStatus_"
                        responseTags.goodStatus_
                        |> Elm.Arg.item
                            (Elm.Arg.varWith
                                "effectHttpMetadata"
                                (Type.namedWith
                                    [ "Effect"
                                    , "Http"
                                    ]
                                    "Metadata"
                                    []
                                )
                            )
                        |> Elm.Arg.item
                            (Elm.Arg.varWith
                                "body"
                                (Type.var
                                    "body"
                                )
                            )
                    )
                    Basics.identity
                ]
    , progress =
        \progressExpression progressTags ->
            Elm.Case.custom
                progressExpression
                (Type.namedWith [ "Effect", "Http" ] "Progress" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                        "Sending"
                        progressTags.sending
                        |> Elm.Arg.item
                            (Elm.Arg.varWith
                                "arg_0"
                                (Type.record
                                    [ ( "sent"
                                      , Type.int
                                      )
                                    , ( "size"
                                      , Type.int
                                      )
                                    ]
                                )
                            )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                        "Receiving"
                        progressTags.receiving
                        |> Elm.Arg.item
                            (Elm.Arg.varWith
                                "arg_0"
                                (Type.record
                                    [ ( "received"
                                      , Type.int
                                      )
                                    , ( "size"
                                      , Type.maybe
                                            Type.int
                                      )
                                    ]
                                )
                            )
                    )
                    Basics.identity
                ]
    }


call_ :
    { riskyTask : Elm.Expression -> Elm.Expression
    , bytesResolver : Elm.Expression -> Elm.Expression
    , stringResolver : Elm.Expression -> Elm.Expression
    , task : Elm.Expression -> Elm.Expression
    , expectWhatever : Elm.Expression -> Elm.Expression
    , expectBytes : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectJson : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectBytesResponse : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectStringResponse : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectString : Elm.Expression -> Elm.Expression
    , riskyRequest : Elm.Expression -> Elm.Expression
    , fractionReceived : Elm.Expression -> Elm.Expression
    , fractionSent : Elm.Expression -> Elm.Expression
    , track : Elm.Expression -> Elm.Expression -> Elm.Expression
    , cancel : Elm.Expression -> Elm.Expression
    , bytesPart :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , filePart : Elm.Expression -> Elm.Expression -> Elm.Expression
    , stringPart : Elm.Expression -> Elm.Expression -> Elm.Expression
    , multipartBody : Elm.Expression -> Elm.Expression
    , fileBody : Elm.Expression -> Elm.Expression
    , bytesBody : Elm.Expression -> Elm.Expression -> Elm.Expression
    , stringBody : Elm.Expression -> Elm.Expression -> Elm.Expression
    , jsonBody : Elm.Expression -> Elm.Expression
    , header : Elm.Expression -> Elm.Expression -> Elm.Expression
    , request : Elm.Expression -> Elm.Expression
    , post : Elm.Expression -> Elm.Expression
    , get : Elm.Expression -> Elm.Expression
    }
call_ =
    { riskyTask =
        \riskyTaskArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "riskyTask"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "method", Type.string )
                                    , ( "headers"
                                      , Type.list
                                            (Type.namedWith
                                                [ "Effect", "Http" ]
                                                "Header"
                                                []
                                            )
                                      )
                                    , ( "url", Type.string )
                                    , ( "body"
                                      , Type.namedWith
                                            [ "Effect", "Http" ]
                                            "Body"
                                            []
                                      )
                                    , ( "resolver"
                                      , Type.namedWith
                                            [ "Effect", "Http" ]
                                            "Resolver"
                                            [ Type.var "restriction"
                                            , Type.var "x"
                                            , Type.var "a"
                                            ]
                                      )
                                    , ( "timeout"
                                      , Type.maybe
                                            (Type.namedWith
                                                [ "Duration" ]
                                                "Duration"
                                                []
                                            )
                                      )
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Effect", "Task" ]
                                    "Task"
                                    [ Type.var "restriction"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ riskyTaskArg_ ]
    , bytesResolver =
        \bytesResolverArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "bytesResolver"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith
                                        [ "Effect", "Http" ]
                                        "Response"
                                        [ Type.namedWith
                                            [ "Bytes" ]
                                            "Bytes"
                                            []
                                        ]
                                    ]
                                    (Type.namedWith
                                        [ "Result" ]
                                        "Result"
                                        [ Type.var "x", Type.var "a" ]
                                    )
                                ]
                                (Type.namedWith
                                    [ "Effect", "Http" ]
                                    "Resolver"
                                    [ Type.var "restriction"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ bytesResolverArg_ ]
    , stringResolver =
        \stringResolverArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "stringResolver"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith
                                        [ "Effect", "Http" ]
                                        "Response"
                                        [ Type.string ]
                                    ]
                                    (Type.namedWith
                                        [ "Result" ]
                                        "Result"
                                        [ Type.var "x", Type.var "a" ]
                                    )
                                ]
                                (Type.namedWith
                                    [ "Effect", "Http" ]
                                    "Resolver"
                                    [ Type.var "restriction"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ stringResolverArg_ ]
    , task =
        \taskArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "task"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "method", Type.string )
                                    , ( "headers"
                                      , Type.list
                                            (Type.namedWith
                                                [ "Effect", "Http" ]
                                                "Header"
                                                []
                                            )
                                      )
                                    , ( "url", Type.string )
                                    , ( "body"
                                      , Type.namedWith
                                            [ "Effect", "Http" ]
                                            "Body"
                                            []
                                      )
                                    , ( "resolver"
                                      , Type.namedWith
                                            [ "Effect", "Http" ]
                                            "Resolver"
                                            [ Type.var "restriction"
                                            , Type.var "x"
                                            , Type.var "a"
                                            ]
                                      )
                                    , ( "timeout"
                                      , Type.maybe
                                            (Type.namedWith
                                                [ "Duration" ]
                                                "Duration"
                                                []
                                            )
                                      )
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Effect", "Task" ]
                                    "Task"
                                    [ Type.var "restriction"
                                    , Type.var "x"
                                    , Type.var "a"
                                    ]
                                )
                            )
                    }
                )
                [ taskArg_ ]
    , expectWhatever =
        \expectWhateverArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "expectWhatever"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith
                                        [ "Result" ]
                                        "Result"
                                        [ Type.namedWith
                                            [ "Effect", "Http" ]
                                            "Error"
                                            []
                                        , Type.unit
                                        ]
                                    ]
                                    (Type.var "msg")
                                ]
                                (Type.namedWith
                                    [ "Effect", "Http" ]
                                    "Expect"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ expectWhateverArg_ ]
    , expectBytes =
        \expectBytesArg_ expectBytesArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "expectBytes"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith
                                        [ "Result" ]
                                        "Result"
                                        [ Type.namedWith
                                            [ "Effect", "Http" ]
                                            "Error"
                                            []
                                        , Type.var "a"
                                        ]
                                    ]
                                    (Type.var "msg")
                                , Type.namedWith
                                    [ "Bytes", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Effect", "Http" ]
                                    "Expect"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ expectBytesArg_, expectBytesArg_0 ]
    , expectJson =
        \expectJsonArg_ expectJsonArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "expectJson"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith
                                        [ "Result" ]
                                        "Result"
                                        [ Type.namedWith
                                            [ "Effect", "Http" ]
                                            "Error"
                                            []
                                        , Type.var "a"
                                        ]
                                    ]
                                    (Type.var "msg")
                                , Type.namedWith
                                    [ "Json", "Decode" ]
                                    "Decoder"
                                    [ Type.var "a" ]
                                ]
                                (Type.namedWith
                                    [ "Effect", "Http" ]
                                    "Expect"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ expectJsonArg_, expectJsonArg_0 ]
    , expectBytesResponse =
        \expectBytesResponseArg_ expectBytesResponseArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "expectBytesResponse"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith
                                        [ "Result" ]
                                        "Result"
                                        [ Type.var "x", Type.var "a" ]
                                    ]
                                    (Type.var "msg")
                                , Type.function
                                    [ Type.namedWith
                                        [ "Effect", "Http" ]
                                        "Response"
                                        [ Type.namedWith
                                            [ "Bytes" ]
                                            "Bytes"
                                            []
                                        ]
                                    ]
                                    (Type.namedWith
                                        [ "Result" ]
                                        "Result"
                                        [ Type.var "x", Type.var "a" ]
                                    )
                                ]
                                (Type.namedWith
                                    [ "Effect", "Http" ]
                                    "Expect"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ expectBytesResponseArg_, expectBytesResponseArg_0 ]
    , expectStringResponse =
        \expectStringResponseArg_ expectStringResponseArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "expectStringResponse"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith
                                        [ "Result" ]
                                        "Result"
                                        [ Type.var "x", Type.var "a" ]
                                    ]
                                    (Type.var "msg")
                                , Type.function
                                    [ Type.namedWith
                                        [ "Effect", "Http" ]
                                        "Response"
                                        [ Type.string ]
                                    ]
                                    (Type.namedWith
                                        [ "Result" ]
                                        "Result"
                                        [ Type.var "x", Type.var "a" ]
                                    )
                                ]
                                (Type.namedWith
                                    [ "Effect", "Http" ]
                                    "Expect"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ expectStringResponseArg_, expectStringResponseArg_0 ]
    , expectString =
        \expectStringArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "expectString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith
                                        [ "Result" ]
                                        "Result"
                                        [ Type.namedWith
                                            [ "Effect", "Http" ]
                                            "Error"
                                            []
                                        , Type.string
                                        ]
                                    ]
                                    (Type.var "msg")
                                ]
                                (Type.namedWith
                                    [ "Effect", "Http" ]
                                    "Expect"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ expectStringArg_ ]
    , riskyRequest =
        \riskyRequestArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "riskyRequest"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "method", Type.string )
                                    , ( "headers"
                                      , Type.list
                                            (Type.namedWith
                                                [ "Effect", "Http" ]
                                                "Header"
                                                []
                                            )
                                      )
                                    , ( "url", Type.string )
                                    , ( "body"
                                      , Type.namedWith
                                            [ "Effect", "Http" ]
                                            "Body"
                                            []
                                      )
                                    , ( "expect"
                                      , Type.namedWith
                                            [ "Effect", "Http" ]
                                            "Expect"
                                            [ Type.var "msg" ]
                                      )
                                    , ( "timeout"
                                      , Type.maybe
                                            (Type.namedWith
                                                [ "Duration" ]
                                                "Duration"
                                                []
                                            )
                                      )
                                    , ( "tracker", Type.maybe Type.string )
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Effect", "Command" ]
                                    "Command"
                                    [ Type.var "restriction"
                                    , Type.var "toMsg"
                                    , Type.var "msg"
                                    ]
                                )
                            )
                    }
                )
                [ riskyRequestArg_ ]
    , fractionReceived =
        \fractionReceivedArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "fractionReceived"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "received", Type.int )
                                    , ( "size", Type.maybe Type.int )
                                    ]
                                ]
                                Type.float
                            )
                    }
                )
                [ fractionReceivedArg_ ]
    , fractionSent =
        \fractionSentArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "fractionSent"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "sent", Type.int )
                                    , ( "size", Type.int )
                                    ]
                                ]
                                Type.float
                            )
                    }
                )
                [ fractionSentArg_ ]
    , track =
        \trackArg_ trackArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "track"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.function
                                    [ Type.namedWith
                                        [ "Effect", "Http" ]
                                        "Progress"
                                        []
                                    ]
                                    (Type.var "msg")
                                ]
                                (Type.namedWith
                                    [ "Effect", "Subscription" ]
                                    "Subscription"
                                    [ Type.var "restriction"
                                    , Type.var "msg"
                                    ]
                                )
                            )
                    }
                )
                [ trackArg_, trackArg_0 ]
    , cancel =
        \cancelArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "cancel"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith
                                    [ "Effect", "Command" ]
                                    "Command"
                                    [ Type.var "restriction"
                                    , Type.var "toMsg"
                                    , Type.var "msg"
                                    ]
                                )
                            )
                    }
                )
                [ cancelArg_ ]
    , bytesPart =
        \bytesPartArg_ bytesPartArg_0 bytesPartArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "bytesPart"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.string
                                , Type.namedWith [ "Bytes" ] "Bytes" []
                                ]
                                (Type.namedWith [ "Effect", "Http" ] "Part" [])
                            )
                    }
                )
                [ bytesPartArg_, bytesPartArg_0, bytesPartArg_1 ]
    , filePart =
        \filePartArg_ filePartArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "filePart"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith
                                    [ "Effect", "File" ]
                                    "File"
                                    []
                                ]
                                (Type.namedWith [ "Effect", "Http" ] "Part" [])
                            )
                    }
                )
                [ filePartArg_, filePartArg_0 ]
    , stringPart =
        \stringPartArg_ stringPartArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "stringPart"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                (Type.namedWith [ "Effect", "Http" ] "Part" [])
                            )
                    }
                )
                [ stringPartArg_, stringPartArg_0 ]
    , multipartBody =
        \multipartBodyArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "multipartBody"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.namedWith
                                        [ "Effect", "Http" ]
                                        "Part"
                                        []
                                    )
                                ]
                                (Type.namedWith [ "Effect", "Http" ] "Body" [])
                            )
                    }
                )
                [ multipartBodyArg_ ]
    , fileBody =
        \fileBodyArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "fileBody"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Effect", "File" ]
                                    "File"
                                    []
                                ]
                                (Type.namedWith [ "Effect", "Http" ] "Body" [])
                            )
                    }
                )
                [ fileBodyArg_ ]
    , bytesBody =
        \bytesBodyArg_ bytesBodyArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "bytesBody"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith [ "Bytes" ] "Bytes" []
                                ]
                                (Type.namedWith [ "Effect", "Http" ] "Body" [])
                            )
                    }
                )
                [ bytesBodyArg_, bytesBodyArg_0 ]
    , stringBody =
        \stringBodyArg_ stringBodyArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "stringBody"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                (Type.namedWith [ "Effect", "Http" ] "Body" [])
                            )
                    }
                )
                [ stringBodyArg_, stringBodyArg_0 ]
    , jsonBody =
        \jsonBodyArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "jsonBody"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Json", "Encode" ]
                                    "Value"
                                    []
                                ]
                                (Type.namedWith [ "Effect", "Http" ] "Body" [])
                            )
                    }
                )
                [ jsonBodyArg_ ]
    , header =
        \headerArg_ headerArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "header"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                (Type.namedWith
                                    [ "Effect", "Http" ]
                                    "Header"
                                    []
                                )
                            )
                    }
                )
                [ headerArg_, headerArg_0 ]
    , request =
        \requestArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "request"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "method", Type.string )
                                    , ( "headers"
                                      , Type.list
                                            (Type.namedWith
                                                [ "Effect", "Http" ]
                                                "Header"
                                                []
                                            )
                                      )
                                    , ( "url", Type.string )
                                    , ( "body"
                                      , Type.namedWith
                                            [ "Effect", "Http" ]
                                            "Body"
                                            []
                                      )
                                    , ( "expect"
                                      , Type.namedWith
                                            [ "Effect", "Http" ]
                                            "Expect"
                                            [ Type.var "msg" ]
                                      )
                                    , ( "timeout"
                                      , Type.maybe
                                            (Type.namedWith
                                                [ "Duration" ]
                                                "Duration"
                                                []
                                            )
                                      )
                                    , ( "tracker", Type.maybe Type.string )
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Effect", "Command" ]
                                    "Command"
                                    [ Type.var "restriction"
                                    , Type.var "toFrontend"
                                    , Type.var "msg"
                                    ]
                                )
                            )
                    }
                )
                [ requestArg_ ]
    , post =
        \postArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "post"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "url", Type.string )
                                    , ( "body"
                                      , Type.namedWith
                                            [ "Effect", "Http" ]
                                            "Body"
                                            []
                                      )
                                    , ( "expect"
                                      , Type.namedWith
                                            [ "Effect", "Http" ]
                                            "Expect"
                                            [ Type.var "msg" ]
                                      )
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Effect", "Command" ]
                                    "Command"
                                    [ Type.var "restriction"
                                    , Type.var "toFrontend"
                                    , Type.var "msg"
                                    ]
                                )
                            )
                    }
                )
                [ postArg_ ]
    , get =
        \getArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "get"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "url", Type.string )
                                    , ( "expect"
                                      , Type.namedWith
                                            [ "Effect", "Http" ]
                                            "Expect"
                                            [ Type.var "msg" ]
                                      )
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Effect", "Command" ]
                                    "Command"
                                    [ Type.var "restriction"
                                    , Type.var "toFrontend"
                                    , Type.var "msg"
                                    ]
                                )
                            )
                    }
                )
                [ getArg_ ]
    }
