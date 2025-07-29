module Gen.Http exposing
    ( emptyBody
    , jsonBody, bytesBody
    , expectBytesResponse, stringResolver, bytesResolver, annotation_
    , caseOf_, call_
    , expectStringResponse
    )

{-|


# Generated bindings for Http

@docs emptyBody
@docs jsonBody, bytesBody
@docs expectString
@docs trackResponse
@docs expectBytesResponse, stringResolver, bytesResolver, annotation_
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
    [ "Http" ]


{-| Create an empty body for your `Request`. This is useful for GET requests
and POST requests where you are not sending any data.

emptyBody: Http.Body

-}
emptyBody : Elm.Expression
emptyBody =
    Elm.value
        { importFrom = [ "Http" ]
        , name = "emptyBody"
        , annotation = Just (Type.namedWith [ "Http" ] "Body" [])
        }


{-| Put some JSON value in the body of your `Request`. This will automatically
add the `Content-Type: application/json` header.

jsonBody: Json.Encode.Value -> Http.Body

-}
jsonBody : Elm.Expression -> Elm.Expression
jsonBody jsonBodyArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Http" ]
            , name = "jsonBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Json", "Encode" ] "Value" [] ]
                        (Type.namedWith [ "Http" ] "Body" [])
                    )
            }
        )
        [ jsonBodyArg_ ]


{-| Put some `Bytes` in the body of your `Request`. This allows you to use
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

bytesBody: String -> Bytes.Bytes -> Http.Body

-}
bytesBody : String -> Elm.Expression -> Elm.Expression
bytesBody bytesBodyArg_ bytesBodyArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Http" ]
            , name = "bytesBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.namedWith [ "Bytes" ] "Bytes" [] ]
                        (Type.namedWith [ "Http" ] "Body" [])
                    )
            }
        )
        [ Elm.string bytesBodyArg_, bytesBodyArg_0 ]


{-| Expect a [`Response`](#Response) with a `String` body. So you could define
your own [`expectJson`](#expectJson) like this:

    import Http
    import Json.Decode as D

    expectJson : (Result Http.Error a -> msg) -> D.Decoder a -> Expect msg
    expectJson toMsg decoder =
        expectStringResponse toMsg <|
            \response ->
                case response of
                    Http.BadUrl_ url ->
                        Err (Http.BadUrl url)

                    Http.Timeout_ ->
                        Err Http.Timeout

                    Http.NetworkError_ ->
                        Err Http.NetworkError

                    Http.BadStatus_ metadata body ->
                        Err (Http.BadStatus metadata.statusCode)

                    Http.GoodStatus_ metadata body ->
                        case D.decodeString decoder body of
                            Ok value ->
                                Ok value

                            Err err ->
                                BadBody (D.errorToString err)

This function is great for fancier error handling and getting response headers.
For example, maybe when your sever gives a 404 status code (not found) it also
provides a helpful JSON message in the response body. This function lets you
add logic to the `BadStatus_` branch so you can parse that JSON and give users
a more helpful message! Or make your own custom error type for your particular
application!

expectStringResponse:
(Result.Result x a -> msg)
-> (Http.Response String -> Result.Result x a)
-> Http.Expect msg

-}
expectStringResponse :
    (Elm.Expression -> Elm.Expression)
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
expectStringResponse expectStringResponseArg_ expectStringResponseArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Http" ]
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
                                [ "Http" ]
                                "Response"
                                [ Type.string ]
                            ]
                            (Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.var "x", Type.var "a" ]
                            )
                        ]
                        (Type.namedWith [ "Http" ] "Expect" [ Type.var "msg" ])
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


{-| Expect a [`Response`](#Response) with a `Bytes` body.

It works just like [`expectStringResponse`](#expectStringResponse), giving you
more access to headers and more leeway in defining your own errors.

expectBytesResponse:
(Result.Result x a -> msg)
-> (Http.Response Bytes.Bytes -> Result.Result x a)
-> Http.Expect msg

-}
expectBytesResponse :
    (Elm.Expression -> Elm.Expression)
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Expression
expectBytesResponse expectBytesResponseArg_ expectBytesResponseArg_0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Http" ]
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
                                [ "Http" ]
                                "Response"
                                [ Type.namedWith [ "Bytes" ] "Bytes" [] ]
                            ]
                            (Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.var "x", Type.var "a" ]
                            )
                        ]
                        (Type.namedWith [ "Http" ] "Expect" [ Type.var "msg" ])
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


{-| Turn a response with a `String` body into a result.
Similar to [`expectStringResponse`](#expectStringResponse).

stringResolver: (Http.Response String -> Result.Result x a) -> Http.Resolver x a

-}
stringResolver : (Elm.Expression -> Elm.Expression) -> Elm.Expression
stringResolver stringResolverArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Http" ]
            , name = "stringResolver"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith
                                [ "Http" ]
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
                            [ "Http" ]
                            "Resolver"
                            [ Type.var "x", Type.var "a" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "stringResolverUnpack" stringResolverArg_ ]


{-| Turn a response with a `Bytes` body into a result.
Similar to [`expectBytesResponse`](#expectBytesResponse).

bytesResolver: (Http.Response Bytes.Bytes -> Result.Result x a) -> Http.Resolver x a

-}
bytesResolver : (Elm.Expression -> Elm.Expression) -> Elm.Expression
bytesResolver bytesResolverArg_ =
    Elm.apply
        (Elm.value
            { importFrom = [ "Http" ]
            , name = "bytesResolver"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith
                                [ "Http" ]
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
                            [ "Http" ]
                            "Resolver"
                            [ Type.var "x", Type.var "a" ]
                        )
                    )
            }
        )
        [ Elm.functionReduced "bytesResolverUnpack" bytesResolverArg_ ]


annotation_ :
    { header : Type.Annotation
    , body : Type.Annotation
    , part : Type.Annotation
    , expect : Type.Annotation -> Type.Annotation
    , error : Type.Annotation
    , progress : Type.Annotation
    , response : Type.Annotation -> Type.Annotation
    , metadata : Type.Annotation
    , resolver : Type.Annotation -> Type.Annotation -> Type.Annotation
    }
annotation_ =
    { header = Type.namedWith [ "Http" ] "Header" []
    , body = Type.namedWith [ "Http" ] "Body" []
    , part = Type.namedWith [ "Http" ] "Part" []
    , expect = \expectArg0 -> Type.namedWith [ "Http" ] "Expect" [ expectArg0 ]
    , error = Type.namedWith [ "Http" ] "Error" []
    , progress = Type.namedWith [ "Http" ] "Progress" []
    , response =
        \responseArg0 -> Type.namedWith [ "Http" ] "Response" [ responseArg0 ]
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
    , resolver =
        \resolverArg0 resolverArg1 ->
            Type.namedWith [ "Http" ] "Resolver" [ resolverArg0, resolverArg1 ]
    }


caseOf_ =
    { error =
        \errorExpression errorTags ->
            Elm.Case.custom
                errorExpression
                (Type.namedWith [ "Http" ] "Error" [])
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
    , progress =
        \progressExpression progressTags ->
            Elm.Case.custom
                progressExpression
                (Type.namedWith [ "Http" ] "Progress" [])
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
    , response =
        \responseExpression responseTags ->
            Elm.Case.custom
                responseExpression
                (Type.namedWith [ "Http" ] "Response" [ Type.var "body" ])
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
                                "httpMetadata"
                                (Type.namedWith
                                    [ "Http" ]
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
                                "httpMetadata"
                                (Type.namedWith
                                    [ "Http"
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
    }


call_ :
    { get : Elm.Expression -> Elm.Expression
    , post : Elm.Expression -> Elm.Expression
    , request : Elm.Expression -> Elm.Expression
    , header : Elm.Expression -> Elm.Expression -> Elm.Expression
    , stringBody : Elm.Expression -> Elm.Expression -> Elm.Expression
    , jsonBody : Elm.Expression -> Elm.Expression
    , fileBody : Elm.Expression -> Elm.Expression
    , bytesBody : Elm.Expression -> Elm.Expression -> Elm.Expression
    , multipartBody : Elm.Expression -> Elm.Expression
    , stringPart : Elm.Expression -> Elm.Expression -> Elm.Expression
    , filePart : Elm.Expression -> Elm.Expression -> Elm.Expression
    , bytesPart :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectString : Elm.Expression -> Elm.Expression
    , expectJson : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectBytes : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectWhatever : Elm.Expression -> Elm.Expression
    , track : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fractionSent : Elm.Expression -> Elm.Expression
    , fractionReceived : Elm.Expression -> Elm.Expression
    , cancel : Elm.Expression -> Elm.Expression
    , riskyRequest : Elm.Expression -> Elm.Expression
    , expectStringResponse : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectBytesResponse : Elm.Expression -> Elm.Expression -> Elm.Expression
    , task : Elm.Expression -> Elm.Expression
    , stringResolver : Elm.Expression -> Elm.Expression
    , bytesResolver : Elm.Expression -> Elm.Expression
    , riskyTask : Elm.Expression -> Elm.Expression
    }
call_ =
    { get =
        \getArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "get"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "url", Type.string )
                                    , ( "expect"
                                      , Type.namedWith
                                            [ "Http" ]
                                            "Expect"
                                            [ Type.var "msg" ]
                                      )
                                    ]
                                ]
                                (Type.namedWith [] "Cmd" [ Type.var "msg" ])
                            )
                    }
                )
                [ getArg_ ]
    , post =
        \postArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "post"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "url", Type.string )
                                    , ( "body"
                                      , Type.namedWith [ "Http" ] "Body" []
                                      )
                                    , ( "expect"
                                      , Type.namedWith
                                            [ "Http" ]
                                            "Expect"
                                            [ Type.var "msg" ]
                                      )
                                    ]
                                ]
                                (Type.namedWith [] "Cmd" [ Type.var "msg" ])
                            )
                    }
                )
                [ postArg_ ]
    , request =
        \requestArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "request"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "method", Type.string )
                                    , ( "headers"
                                      , Type.list
                                            (Type.namedWith
                                                [ "Http" ]
                                                "Header"
                                                []
                                            )
                                      )
                                    , ( "url", Type.string )
                                    , ( "body"
                                      , Type.namedWith [ "Http" ] "Body" []
                                      )
                                    , ( "expect"
                                      , Type.namedWith
                                            [ "Http" ]
                                            "Expect"
                                            [ Type.var "msg" ]
                                      )
                                    , ( "timeout", Type.maybe Type.float )
                                    , ( "tracker", Type.maybe Type.string )
                                    ]
                                ]
                                (Type.namedWith [] "Cmd" [ Type.var "msg" ])
                            )
                    }
                )
                [ requestArg_ ]
    , header =
        \headerArg_ headerArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "header"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                (Type.namedWith [ "Http" ] "Header" [])
                            )
                    }
                )
                [ headerArg_, headerArg_0 ]
    , stringBody =
        \stringBodyArg_ stringBodyArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "stringBody"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                (Type.namedWith [ "Http" ] "Body" [])
                            )
                    }
                )
                [ stringBodyArg_, stringBodyArg_0 ]
    , jsonBody =
        \jsonBodyArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "jsonBody"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith
                                    [ "Json", "Encode" ]
                                    "Value"
                                    []
                                ]
                                (Type.namedWith [ "Http" ] "Body" [])
                            )
                    }
                )
                [ jsonBodyArg_ ]
    , fileBody =
        \fileBodyArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "fileBody"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "File" ] "File" [] ]
                                (Type.namedWith [ "Http" ] "Body" [])
                            )
                    }
                )
                [ fileBodyArg_ ]
    , bytesBody =
        \bytesBodyArg_ bytesBodyArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "bytesBody"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith [ "Bytes" ] "Bytes" []
                                ]
                                (Type.namedWith [ "Http" ] "Body" [])
                            )
                    }
                )
                [ bytesBodyArg_, bytesBodyArg_0 ]
    , multipartBody =
        \multipartBodyArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "multipartBody"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.list
                                    (Type.namedWith [ "Http" ] "Part" [])
                                ]
                                (Type.namedWith [ "Http" ] "Body" [])
                            )
                    }
                )
                [ multipartBodyArg_ ]
    , stringPart =
        \stringPartArg_ stringPartArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "stringPart"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string, Type.string ]
                                (Type.namedWith [ "Http" ] "Part" [])
                            )
                    }
                )
                [ stringPartArg_, stringPartArg_0 ]
    , filePart =
        \filePartArg_ filePartArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "filePart"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.namedWith [ "File" ] "File" []
                                ]
                                (Type.namedWith [ "Http" ] "Part" [])
                            )
                    }
                )
                [ filePartArg_, filePartArg_0 ]
    , bytesPart =
        \bytesPartArg_ bytesPartArg_0 bytesPartArg_1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "bytesPart"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.string
                                , Type.namedWith [ "Bytes" ] "Bytes" []
                                ]
                                (Type.namedWith [ "Http" ] "Part" [])
                            )
                    }
                )
                [ bytesPartArg_, bytesPartArg_0, bytesPartArg_1 ]
    , expectString =
        \expectStringArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "expectString"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith
                                        [ "Result" ]
                                        "Result"
                                        [ Type.namedWith
                                            [ "Http" ]
                                            "Error"
                                            []
                                        , Type.string
                                        ]
                                    ]
                                    (Type.var "msg")
                                ]
                                (Type.namedWith
                                    [ "Http" ]
                                    "Expect"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ expectStringArg_ ]
    , expectJson =
        \expectJsonArg_ expectJsonArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "expectJson"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith
                                        [ "Result" ]
                                        "Result"
                                        [ Type.namedWith
                                            [ "Http" ]
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
                                    [ "Http" ]
                                    "Expect"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ expectJsonArg_, expectJsonArg_0 ]
    , expectBytes =
        \expectBytesArg_ expectBytesArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "expectBytes"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith
                                        [ "Result" ]
                                        "Result"
                                        [ Type.namedWith
                                            [ "Http" ]
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
                                    [ "Http" ]
                                    "Expect"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ expectBytesArg_, expectBytesArg_0 ]
    , expectWhatever =
        \expectWhateverArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "expectWhatever"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith
                                        [ "Result" ]
                                        "Result"
                                        [ Type.namedWith
                                            [ "Http" ]
                                            "Error"
                                            []
                                        , Type.unit
                                        ]
                                    ]
                                    (Type.var "msg")
                                ]
                                (Type.namedWith
                                    [ "Http" ]
                                    "Expect"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ expectWhateverArg_ ]
    , track =
        \trackArg_ trackArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "track"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.function
                                    [ Type.namedWith [ "Http" ] "Progress" []
                                    ]
                                    (Type.var "msg")
                                ]
                                (Type.namedWith [] "Sub" [ Type.var "msg" ])
                            )
                    }
                )
                [ trackArg_, trackArg_0 ]
    , fractionSent =
        \fractionSentArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
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
    , fractionReceived =
        \fractionReceivedArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
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
    , cancel =
        \cancelArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "cancel"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string ]
                                (Type.namedWith [] "Cmd" [ Type.var "msg" ])
                            )
                    }
                )
                [ cancelArg_ ]
    , riskyRequest =
        \riskyRequestArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "riskyRequest"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "method", Type.string )
                                    , ( "headers"
                                      , Type.list
                                            (Type.namedWith
                                                [ "Http" ]
                                                "Header"
                                                []
                                            )
                                      )
                                    , ( "url", Type.string )
                                    , ( "body"
                                      , Type.namedWith [ "Http" ] "Body" []
                                      )
                                    , ( "expect"
                                      , Type.namedWith
                                            [ "Http" ]
                                            "Expect"
                                            [ Type.var "msg" ]
                                      )
                                    , ( "timeout", Type.maybe Type.float )
                                    , ( "tracker", Type.maybe Type.string )
                                    ]
                                ]
                                (Type.namedWith [] "Cmd" [ Type.var "msg" ])
                            )
                    }
                )
                [ riskyRequestArg_ ]
    , expectStringResponse =
        \expectStringResponseArg_ expectStringResponseArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
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
                                        [ "Http" ]
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
                                    [ "Http" ]
                                    "Expect"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ expectStringResponseArg_, expectStringResponseArg_0 ]
    , expectBytesResponse =
        \expectBytesResponseArg_ expectBytesResponseArg_0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
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
                                        [ "Http" ]
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
                                    [ "Http" ]
                                    "Expect"
                                    [ Type.var "msg" ]
                                )
                            )
                    }
                )
                [ expectBytesResponseArg_, expectBytesResponseArg_0 ]
    , task =
        \taskArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "task"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "method", Type.string )
                                    , ( "headers"
                                      , Type.list
                                            (Type.namedWith
                                                [ "Http" ]
                                                "Header"
                                                []
                                            )
                                      )
                                    , ( "url", Type.string )
                                    , ( "body"
                                      , Type.namedWith [ "Http" ] "Body" []
                                      )
                                    , ( "resolver"
                                      , Type.namedWith
                                            [ "Http" ]
                                            "Resolver"
                                            [ Type.var "x", Type.var "a" ]
                                      )
                                    , ( "timeout", Type.maybe Type.float )
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "a" ]
                                )
                            )
                    }
                )
                [ taskArg_ ]
    , stringResolver =
        \stringResolverArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "stringResolver"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith
                                        [ "Http" ]
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
                                    [ "Http" ]
                                    "Resolver"
                                    [ Type.var "x", Type.var "a" ]
                                )
                            )
                    }
                )
                [ stringResolverArg_ ]
    , bytesResolver =
        \bytesResolverArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "bytesResolver"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.function
                                    [ Type.namedWith
                                        [ "Http" ]
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
                                    [ "Http" ]
                                    "Resolver"
                                    [ Type.var "x", Type.var "a" ]
                                )
                            )
                    }
                )
                [ bytesResolverArg_ ]
    , riskyTask =
        \riskyTaskArg_ ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "riskyTask"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.record
                                    [ ( "method", Type.string )
                                    , ( "headers"
                                      , Type.list
                                            (Type.namedWith
                                                [ "Http" ]
                                                "Header"
                                                []
                                            )
                                      )
                                    , ( "url", Type.string )
                                    , ( "body"
                                      , Type.namedWith [ "Http" ] "Body" []
                                      )
                                    , ( "resolver"
                                      , Type.namedWith
                                            [ "Http" ]
                                            "Resolver"
                                            [ Type.var "x", Type.var "a" ]
                                      )
                                    , ( "timeout", Type.maybe Type.float )
                                    ]
                                ]
                                (Type.namedWith
                                    [ "Task" ]
                                    "Task"
                                    [ Type.var "x", Type.var "a" ]
                                )
                            )
                    }
                )
                [ riskyTaskArg_ ]
    }
