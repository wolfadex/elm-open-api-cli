module Gen.Effect.Http exposing (bytesResolver, stringResolver, expectBytesResponse, expectStringResponse, bytesBody, jsonBody, emptyBody, annotation_, caseOf_, call_)

{-|

@docs bytesResolver, stringResolver, expectBytesResponse, expectStringResponse, bytesBody, jsonBody, emptyBody, annotation_, caseOf_, call_

-}

import Elm
import Elm.Annotation as Type
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
bytesResolver bytesResolverArg =
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
        [ Elm.functionReduced "bytesResolverUnpack" bytesResolverArg ]


{-| {-| Turn a response with a `String` body into a result.
-}

stringResolver:
(Effect.Http.Response String -> Result.Result x a)
-> Effect.Http.Resolver restriction x a

-}
stringResolver : (Elm.Expression -> Elm.Expression) -> Elm.Expression
stringResolver stringResolverArg =
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
        [ Elm.functionReduced "stringResolverUnpack" stringResolverArg ]


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
expectBytesResponse expectBytesResponseArg expectBytesResponseArg0 =
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
        [ Elm.functionReduced "expectBytesResponseUnpack" expectBytesResponseArg
        , Elm.functionReduced
            "expectBytesResponseUnpack"
            expectBytesResponseArg0
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
expectStringResponse expectStringResponseArg expectStringResponseArg0 =
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
            expectStringResponseArg
        , Elm.functionReduced
            "expectStringResponseUnpack"
            expectStringResponseArg0
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
bytesBody bytesBodyArg bytesBodyArg0 =
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
        [ Elm.string bytesBodyArg, bytesBodyArg0 ]


{-| {-| Put some JSON value in the body of your `Request`. This will automatically
add the `Content-Type: application/json` header.
-}

jsonBody: Json.Encode.Value -> Effect.Http.Body

-}
jsonBody : Elm.Expression -> Elm.Expression
jsonBody jsonBodyArg =
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
        [ jsonBodyArg ]


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


caseOf_ :
    { error :
        Elm.Expression
        ->
            { errorTags_0_0
                | badUrl : Elm.Expression -> Elm.Expression
                , timeout : Elm.Expression
                , networkError : Elm.Expression
                , badStatus : Elm.Expression -> Elm.Expression
                , badBody : Elm.Expression -> Elm.Expression
            }
        -> Elm.Expression
    , response :
        Elm.Expression
        ->
            { responseTags_1_0
                | badUrl_ : Elm.Expression -> Elm.Expression
                , timeout_ : Elm.Expression
                , networkError_ : Elm.Expression
                , badStatus_ : Elm.Expression -> Elm.Expression -> Elm.Expression
                , goodStatus_ : Elm.Expression -> Elm.Expression -> Elm.Expression
            }
        -> Elm.Expression
    , progress :
        Elm.Expression
        ->
            { progressTags_2_0
                | sending : Elm.Expression -> Elm.Expression
                , receiving : Elm.Expression -> Elm.Expression
            }
        -> Elm.Expression
    }
caseOf_ =
    { error =
        \errorExpression errorTags ->
            Elm.Case.custom
                errorExpression
                (Type.namedWith [ "Effect", "Http" ] "Error" [])
                [ Elm.Case.branch1
                    "BadUrl"
                    ( "stringString", Type.string )
                    errorTags.badUrl
                , Elm.Case.branch0 "Timeout" errorTags.timeout
                , Elm.Case.branch0 "NetworkError" errorTags.networkError
                , Elm.Case.branch1
                    "BadStatus"
                    ( "basicsInt", Type.int )
                    errorTags.badStatus
                , Elm.Case.branch1
                    "BadBody"
                    ( "stringString", Type.string )
                    errorTags.badBody
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
                [ Elm.Case.branch1
                    "BadUrl_"
                    ( "stringString", Type.string )
                    responseTags.badUrl_
                , Elm.Case.branch0 "Timeout_" responseTags.timeout_
                , Elm.Case.branch0 "NetworkError_" responseTags.networkError_
                , Elm.Case.branch2
                    "BadStatus_"
                    ( "effectHttpMetadata"
                    , Type.namedWith [ "Effect", "Http" ] "Metadata" []
                    )
                    ( "body", Type.var "body" )
                    responseTags.badStatus_
                , Elm.Case.branch2
                    "GoodStatus_"
                    ( "effectHttpMetadata"
                    , Type.namedWith [ "Effect", "Http" ] "Metadata" []
                    )
                    ( "body", Type.var "body" )
                    responseTags.goodStatus_
                ]
    , progress =
        \progressExpression progressTags ->
            Elm.Case.custom
                progressExpression
                (Type.namedWith [ "Effect", "Http" ] "Progress" [])
                [ Elm.Case.branch1
                    "Sending"
                    ( "one"
                    , Type.record [ ( "sent", Type.int ), ( "size", Type.int ) ]
                    )
                    progressTags.sending
                , Elm.Case.branch1
                    "Receiving"
                    ( "one"
                    , Type.record
                        [ ( "received", Type.int )
                        , ( "size", Type.maybe Type.int )
                        ]
                    )
                    progressTags.receiving
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
        \riskyTaskArg ->
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
                [ riskyTaskArg ]
    , bytesResolver =
        \bytesResolverArg ->
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
                [ bytesResolverArg ]
    , stringResolver =
        \stringResolverArg ->
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
                [ stringResolverArg ]
    , task =
        \taskArg ->
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
                [ taskArg ]
    , expectWhatever =
        \expectWhateverArg ->
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
                [ expectWhateverArg ]
    , expectBytes =
        \expectBytesArg expectBytesArg0 ->
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
                [ expectBytesArg, expectBytesArg0 ]
    , expectJson =
        \expectJsonArg expectJsonArg0 ->
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
                [ expectJsonArg, expectJsonArg0 ]
    , expectBytesResponse =
        \expectBytesResponseArg expectBytesResponseArg0 ->
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
                [ expectBytesResponseArg, expectBytesResponseArg0 ]
    , expectStringResponse =
        \expectStringResponseArg expectStringResponseArg0 ->
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
                [ expectStringResponseArg, expectStringResponseArg0 ]
    , expectString =
        \expectStringArg ->
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
                [ expectStringArg ]
    , riskyRequest =
        \riskyRequestArg ->
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
                [ riskyRequestArg ]
    , fractionReceived =
        \fractionReceivedArg ->
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
                [ fractionReceivedArg ]
    , fractionSent =
        \fractionSentArg ->
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
                [ fractionSentArg ]
    , track =
        \trackArg trackArg0 ->
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
                [ trackArg, trackArg0 ]
    , cancel =
        \cancelArg ->
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
                [ cancelArg ]
    , bytesPart =
        \bytesPartArg bytesPartArg0 bytesPartArg1 ->
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
                [ bytesPartArg, bytesPartArg0, bytesPartArg1 ]
    , filePart =
        \filePartArg filePartArg0 ->
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
                [ filePartArg, filePartArg0 ]
    , stringPart =
        \stringPartArg stringPartArg0 ->
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
                [ stringPartArg, stringPartArg0 ]
    , multipartBody =
        \multipartBodyArg ->
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
                [ multipartBodyArg ]
    , fileBody =
        \fileBodyArg ->
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
                [ fileBodyArg ]
    , bytesBody =
        \bytesBodyArg bytesBodyArg0 ->
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
                [ bytesBodyArg, bytesBodyArg0 ]
    , stringBody =
        \stringBodyArg stringBodyArg0 ->
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
                [ stringBodyArg, stringBodyArg0 ]
    , jsonBody =
        \jsonBodyArg ->
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
                [ jsonBodyArg ]
    , header =
        \headerArg headerArg0 ->
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
                [ headerArg, headerArg0 ]
    , request =
        \requestArg ->
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
                [ requestArg ]
    , post =
        \postArg ->
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
                [ postArg ]
    , get =
        \getArg ->
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
                [ getArg ]
    }
