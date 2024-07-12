module Gen.Effect.Http exposing (moduleName_, riskyTask, bytesResolver, stringResolver, task, expectWhatever, expectBytes, expectJson, expectBytesResponse, expectStringResponse, expectString, riskyRequest, fractionReceived, fractionSent, track, cancel, bytesPart, filePart, stringPart, multipartBody, fileBody, bytesBody, stringBody, jsonBody, emptyBody, header, request, post, get, annotation_, make_, caseOf_, call_, values_)

{-|

@docs moduleName_, riskyTask, bytesResolver, stringResolver, task, expectWhatever, expectBytes, expectJson, expectBytesResponse, expectStringResponse, expectString, riskyRequest, fractionReceived, fractionSent, track, cancel, bytesPart, filePart, stringPart, multipartBody, fileBody, bytesBody, stringBody, jsonBody, emptyBody, header, request, post, get, annotation_, make_, caseOf_, call_, values_

-}

import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module.
-}
moduleName_ : List String
moduleName_ =
    [ "Effect", "Http" ]


{-| {-| Just like [`riskyRequest`](#riskyRequest), but it creates a `Task`. **Use
with caution!** This has all the same security concerns as `riskyRequest`.
-}

riskyTask:
{ method : String
, headers : List Effect.Http.Header
, url : String
, body : Effect.Http.Body
, resolver : Effect.Http.Resolver restriction x a
, timeout : Maybe Duration.Duration
}
-> Effect.Task.Task restriction x a

-}
riskyTask :
    { method : String
    , headers : List Elm.Expression
    , url : String
    , body : Elm.Expression
    , resolver : Elm.Expression
    , timeout : Elm.Expression
    }
    -> Elm.Expression
riskyTask riskyTaskArg =
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
                              , Type.namedWith [ "Effect", "Http" ] "Body" []
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
                                    (Type.namedWith [ "Duration" ] "Duration" [])
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
        [ Elm.record
            [ Tuple.pair "method" (Elm.string riskyTaskArg.method)
            , Tuple.pair "headers" (Elm.list riskyTaskArg.headers)
            , Tuple.pair "url" (Elm.string riskyTaskArg.url)
            , Tuple.pair "body" riskyTaskArg.body
            , Tuple.pair "resolver" riskyTaskArg.resolver
            , Tuple.pair "timeout" riskyTaskArg.timeout
            ]
        ]


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


{-| {-| Just like [`request`](#request), but it creates a `Task`.
-}

task:
{ method : String
, headers : List Effect.Http.Header
, url : String
, body : Effect.Http.Body
, resolver : Effect.Http.Resolver restriction x a
, timeout : Maybe Duration.Duration
}
-> Effect.Task.Task restriction x a

-}
task :
    { method : String
    , headers : List Elm.Expression
    , url : String
    , body : Elm.Expression
    , resolver : Elm.Expression
    , timeout : Elm.Expression
    }
    -> Elm.Expression
task taskArg =
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
                              , Type.namedWith [ "Effect", "Http" ] "Body" []
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
                                    (Type.namedWith [ "Duration" ] "Duration" [])
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
        [ Elm.record
            [ Tuple.pair "method" (Elm.string taskArg.method)
            , Tuple.pair "headers" (Elm.list taskArg.headers)
            , Tuple.pair "url" (Elm.string taskArg.url)
            , Tuple.pair "body" taskArg.body
            , Tuple.pair "resolver" taskArg.resolver
            , Tuple.pair "timeout" taskArg.timeout
            ]
        ]


{-| {-| Expect the response body to be whatever.
-}

expectWhatever: (Result.Result Effect.Http.Error () -> msg) -> Effect.Http.Expect msg

-}
expectWhatever : (Elm.Expression -> Elm.Expression) -> Elm.Expression
expectWhatever expectWhateverArg =
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
        [ Elm.functionReduced "expectWhateverUnpack" expectWhateverArg ]


{-| {-| Expect the response body to be binary data. For example, maybe you are
talking to an endpoint that gives back ProtoBuf data:

    import Bytes.Decode as Bytes
    import Http

    type Msg
        = GotData (Result Http.Error Data)

    getData : Cmd Msg
    getData =
        Http.get
            { url = "/data"
            , expect = Http.expectBytes GotData dataDecoder
            }

    -- dataDecoder : Bytes.Decoder Data

You would use [`elm/bytes`](/packages/elm/bytes/latest/) to decode the binary
data according to a proto definition file like `example.proto`.

If the decoder fails, you get a `BadBody` error that just indicates that
_something_ went wrong. It probably makes sense to debug by peeking at the
bytes you are getting in the browser developer tools or something.

-}

expectBytes:
(Result.Result Effect.Http.Error a -> msg)
-> Bytes.Decode.Decoder a
-> Effect.Http.Expect msg

-}
expectBytes : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
expectBytes expectBytesArg expectBytesArg0 =
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
        [ Elm.functionReduced "expectBytesUnpack" expectBytesArg
        , expectBytesArg0
        ]


{-| {-| Expect the response body to be JSON.
-}

expectJson:
(Result.Result Effect.Http.Error a -> msg)
-> Json.Decode.Decoder a
-> Effect.Http.Expect msg

-}
expectJson : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
expectJson expectJsonArg expectJsonArg0 =
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
        [ Elm.functionReduced "expectJsonUnpack" expectJsonArg, expectJsonArg0 ]


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


{-| {-| Expect the response body to be a `String`.
-}

expectString: (Result.Result Effect.Http.Error String -> msg) -> Effect.Http.Expect msg

-}
expectString : (Elm.Expression -> Elm.Expression) -> Elm.Expression
expectString expectStringArg =
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
        [ Elm.functionReduced "expectStringUnpack" expectStringArg ]


{-| {-| Create a request with a risky security policy. Things like:

  - Allow responses from other domains to set cookies.
  - Include cookies in requests to other domains.

This is called [`withCredentials`][wc] in JavaScript, and it allows a couple
other risky things as well. It can be useful if `www.example.com` needs to
talk to `uploads.example.com`, but it should be used very carefully!

For example, every HTTP request includes a `Host` header revealing the domain,
so any request to `facebook.com` reveals the website that sent it. From there,
cookies can be used to correlate browsing habits with specific users. “Oh, it
looks like they visited `example.com`. Maybe they want ads about examples!”
This is why you can get shoe ads for months without saying anything about it
on any social networks. **This risk exists even for people who do not have an
account.** Servers can set a new cookie to uniquely identify the browser and
build a profile around that. Same kind of tricks for logged out users.

**Context:** A significantly worse version of this can happen when trying to
add integrations with Google, Facebook, Pinterest, Twitter, etc. “Add our share
button. It is super easy. Just add this `<script>` tag!” But the goal here is
to get _arbitrary_ access to the executing context. Now they can track clicks,
read page content, use time zones to approximate location, etc. As of this
writing, suggesting that developers just embed `<script>` tags is the default
for Google Analytics, Facebook Like Buttons, Twitter Follow Buttons, Pinterest
Save Buttons, and Instagram Embeds.

[ah]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Authorization
[wc]: https://developer.mozilla.org/en-US/docs/Web/API/XMLHttpRequest/withCredentials

-}

riskyRequest:
{ method : String
, headers : List Effect.Http.Header
, url : String
, body : Effect.Http.Body
, expect : Effect.Http.Expect msg
, timeout : Maybe Duration.Duration
, tracker : Maybe String
}
-> Effect.Command.Command restriction toMsg msg

-}
riskyRequest :
    { method : String
    , headers : List Elm.Expression
    , url : String
    , body : Elm.Expression
    , expect : Elm.Expression
    , timeout : Elm.Expression
    , tracker : Elm.Expression
    }
    -> Elm.Expression
riskyRequest riskyRequestArg =
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
                              , Type.namedWith [ "Effect", "Http" ] "Body" []
                              )
                            , ( "expect"
                              , Type.namedWith
                                    [ "Effect", "Http" ]
                                    "Expect"
                                    [ Type.var "msg" ]
                              )
                            , ( "timeout"
                              , Type.maybe
                                    (Type.namedWith [ "Duration" ] "Duration" [])
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
        [ Elm.record
            [ Tuple.pair "method" (Elm.string riskyRequestArg.method)
            , Tuple.pair "headers" (Elm.list riskyRequestArg.headers)
            , Tuple.pair "url" (Elm.string riskyRequestArg.url)
            , Tuple.pair "body" riskyRequestArg.body
            , Tuple.pair "expect" riskyRequestArg.expect
            , Tuple.pair "timeout" riskyRequestArg.timeout
            , Tuple.pair "tracker" riskyRequestArg.tracker
            ]
        ]


{-| {-| Turn `Receiving` progress into a useful fraction for progress bars.

    fractionReceived { received =   0, size = Just 1024 } == 0.0
    fractionReceived { received = 256, size = Just 1024 } == 0.25
    fractionReceived { received = 512, size = Just 1024 } == 0.5

    -- fractionReceived { received =   0, size = Nothing } == 0.0
    -- fractionReceived { received = 256, size = Nothing } == 0.0
    -- fractionReceived { received = 512, size = Nothing } == 0.0

The `size` here is based on the [`Content-Length`][cl] header which may be
missing in some cases. A server may be misconfigured or it may be streaming
data and not actually know the final size. Whatever the case, this function
will always give `0.0` when the final size is unknown.

Furthermore, the `Content-Length` header may be incorrect! The implementation
clamps the fraction between `0.0` and `1.0`, so you will just get `1.0` if
you ever receive more bytes than promised.

**Note:** If you are streaming something, you can write a custom version of
this function that just tracks bytes received. Maybe you show that 22kb or 83kb
have been downloaded, without a specific fraction. If you do this, be wary of
divide-by-zero errors because `size` can always be zero!

[cl]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Length

-}

fractionReceived: { received : Int, size : Maybe Int } -> Float

-}
fractionReceived : { received : Int, size : Elm.Expression } -> Elm.Expression
fractionReceived fractionReceivedArg =
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
        [ Elm.record
            [ Tuple.pair "received" (Elm.int fractionReceivedArg.received)
            , Tuple.pair "size" fractionReceivedArg.size
            ]
        ]


{-| {-| Turn `Sending` progress into a useful fraction.

    fractionSent { sent =   0, size = 1024 } == 0.0
    fractionSent { sent = 256, size = 1024 } == 0.25
    fractionSent { sent = 512, size = 1024 } == 0.5

    -- fractionSent { sent = 0, size = 0 } == 1.0

The result is always between `0.0` and `1.0`, ensuring that any progress bar
animations never go out of bounds.

And notice that `size` can be zero. That means you are sending a request with
an empty body. Very common! When `size` is zero, the result is always `1.0`.

**Note:** If you create your own function to compute this fraction, watch out
for divide-by-zero errors!

-}

fractionSent: { sent : Int, size : Int } -> Float

-}
fractionSent : { sent : Int, size : Int } -> Elm.Expression
fractionSent fractionSentArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "fractionSent"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "sent", Type.int ), ( "size", Type.int ) ]
                        ]
                        Type.float
                    )
            }
        )
        [ Elm.record
            [ Tuple.pair "sent" (Elm.int fractionSentArg.sent)
            , Tuple.pair "size" (Elm.int fractionSentArg.size)
            ]
        ]


{-| {-| Track the progress of a request. Create a [`request`](#request) where
`tracker = Just "form.pdf"` and you can track it with a subscription like
`track "form.pdf" GotProgress`.
-}

track:
String
-> (Effect.Http.Progress -> msg)
-> Effect.Subscription.Subscription restriction msg

-}
track : String -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
track trackArg trackArg0 =
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
                            [ Type.var "restriction", Type.var "msg" ]
                        )
                    )
            }
        )
        [ Elm.string trackArg, Elm.functionReduced "trackUnpack" trackArg0 ]


{-| {-| Try to cancel an ongoing request based on a `tracker`.
-}

cancel: String -> Effect.Command.Command restriction toMsg msg

-}
cancel : String -> Elm.Expression
cancel cancelArg =
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
        [ Elm.string cancelArg ]


{-| {-| A part that contains bytes, allowing you to use
[`elm/bytes`](/packages/elm/bytes/latest) to encode data exactly in the format
you need.

    multipartBody
        [ stringPart "title" "Tom"
        , bytesPart "photo" "image/png" bytes
        ]

**Note:** You must provide a MIME type so that the receiver has clues about
how to interpret the bytes.

-}

bytesPart: String -> String -> Bytes.Bytes -> Effect.Http.Part

-}
bytesPart : String -> String -> Elm.Expression -> Elm.Expression
bytesPart bytesPartArg bytesPartArg0 bytesPartArg1 =
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
        [ Elm.string bytesPartArg, Elm.string bytesPartArg0, bytesPartArg1 ]


{-| {-| A part that contains a file. You can use
[`elm/file`](/packages/elm/file/latest) to get files loaded into the
browser. From there, you can send it along to a server like this:

    multipartBody
        [ stringPart "product" "Ikea Bekant"
        , stringPart "description" "Great desk for home office."
        , filePart "image[]" file1
        , filePart "image[]" file2
        , filePart "image[]" file3
        ]

-}

filePart: String -> Effect.File.File -> Effect.Http.Part

-}
filePart : String -> Elm.Expression -> Elm.Expression
filePart filePartArg filePartArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "filePart"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Effect", "File" ] "File" []
                        ]
                        (Type.namedWith [ "Effect", "Http" ] "Part" [])
                    )
            }
        )
        [ Elm.string filePartArg, filePartArg0 ]


{-| {-| A part that contains `String` data.

    multipartBody
        [ stringPart "title" "Tom"
        , filePart "photo" tomPng
        ]

-}

stringPart: String -> String -> Effect.Http.Part

-}
stringPart : String -> String -> Elm.Expression
stringPart stringPartArg stringPartArg0 =
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
        [ Elm.string stringPartArg, Elm.string stringPartArg0 ]


{-| {-| When someone clicks submit on the `<form>`, browsers send a special HTTP
request with all the form data. Something like this:

    POST /test.html HTTP/1.1
    Host: example.org
    Content-Type: multipart/form-data;boundary="7MA4YWxkTrZu0gW"

    --7MA4YWxkTrZu0gW
    Content-Disposition: form-data; name="title"

    Trip to London
    --7MA4YWxkTrZu0gW
    Content-Disposition: form-data; name="album[]"; filename="parliment.jpg"

    ...RAW...IMAGE...BITS...
    --7MA4YWxkTrZu0gW--

This was the only way to send files for a long time, so many servers expect
data in this format. **The `multipartBody` function lets you create these
requests.** For example, to upload a photo album all at once, you could create
a body like this:

    multipartBody
        [ stringPart "title" "Trip to London"
        , filePart "album[]" file1
        , filePart "album[]" file2
        , filePart "album[]" file3
        ]

All of the body parts need to have a name. Names can be repeated. Adding the
`[]` on repeated names is a convention from PHP. It seems weird, but I see it
enough to mention it. You do not have to do it that way, especially if your
server uses some other convention!

The `Content-Type: multipart/form-data` header is automatically set when
creating a body this way.

**Note:** Use [`track`](#track) to track upload progress.

-}

multipartBody: List Effect.Http.Part -> Effect.Http.Body

-}
multipartBody : List Elm.Expression -> Elm.Expression
multipartBody multipartBodyArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "multipartBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.namedWith [ "Effect", "Http" ] "Part" [])
                        ]
                        (Type.namedWith [ "Effect", "Http" ] "Body" [])
                    )
            }
        )
        [ Elm.list multipartBodyArg ]


{-| {-| Use a file as the body of your `Request`. When someone uploads an image
into the browser with [`elm/file`](/packages/elm/file/latest) you can forward
it to a server.

This will automatically set the `Content-Type` to the MIME type of the file.

**Note:** Use [`track`](#track) to track upload progress.

-}

fileBody: Effect.File.File -> Effect.Http.Body

-}
fileBody : Elm.Expression -> Elm.Expression
fileBody fileBodyArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "fileBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Effect", "File" ] "File" [] ]
                        (Type.namedWith [ "Effect", "Http" ] "Body" [])
                    )
            }
        )
        [ fileBodyArg ]


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


{-| {-| Put some string in the body of your `Request`.
-}

stringBody: String -> String -> Effect.Http.Body

-}
stringBody : String -> String -> Elm.Expression
stringBody stringBodyArg stringBodyArg0 =
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
        [ Elm.string stringBodyArg, Elm.string stringBodyArg0 ]


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


{-| {-| Create a `Header`.
-}

header: String -> String -> Effect.Http.Header

-}
header : String -> String -> Elm.Expression
header headerArg headerArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "header"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string ]
                        (Type.namedWith [ "Effect", "Http" ] "Header" [])
                    )
            }
        )
        [ Elm.string headerArg, Elm.string headerArg0 ]


{-| {-| Create a custom request.
-}

request:
{ method : String
, headers : List Effect.Http.Header
, url : String
, body : Effect.Http.Body
, expect : Effect.Http.Expect msg
, timeout : Maybe Duration.Duration
, tracker : Maybe String
}
-> Effect.Command.Command restriction toFrontend msg

-}
request :
    { method : String
    , headers : List Elm.Expression
    , url : String
    , body : Elm.Expression
    , expect : Elm.Expression
    , timeout : Elm.Expression
    , tracker : Elm.Expression
    }
    -> Elm.Expression
request requestArg =
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
                              , Type.namedWith [ "Effect", "Http" ] "Body" []
                              )
                            , ( "expect"
                              , Type.namedWith
                                    [ "Effect", "Http" ]
                                    "Expect"
                                    [ Type.var "msg" ]
                              )
                            , ( "timeout"
                              , Type.maybe
                                    (Type.namedWith [ "Duration" ] "Duration" [])
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
        [ Elm.record
            [ Tuple.pair "method" (Elm.string requestArg.method)
            , Tuple.pair "headers" (Elm.list requestArg.headers)
            , Tuple.pair "url" (Elm.string requestArg.url)
            , Tuple.pair "body" requestArg.body
            , Tuple.pair "expect" requestArg.expect
            , Tuple.pair "timeout" requestArg.timeout
            , Tuple.pair "tracker" requestArg.tracker
            ]
        ]


{-| {-| Create a `POST` request.
-}

post:
{ url : String, body : Effect.Http.Body, expect : Effect.Http.Expect msg }
-> Effect.Command.Command restriction toFrontend msg

-}
post :
    { url : String, body : Elm.Expression, expect : Elm.Expression }
    -> Elm.Expression
post postArg =
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
                              , Type.namedWith [ "Effect", "Http" ] "Body" []
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
        [ Elm.record
            [ Tuple.pair "url" (Elm.string postArg.url)
            , Tuple.pair "body" postArg.body
            , Tuple.pair "expect" postArg.expect
            ]
        ]


{-| {-| Create a `GET` request.
-}

get:
{ url : String, expect : Effect.Http.Expect msg }
-> Effect.Command.Command restriction toFrontend msg

-}
get : { url : String, expect : Elm.Expression } -> Elm.Expression
get getArg =
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
        [ Elm.record
            [ Tuple.pair "url" (Elm.string getArg.url)
            , Tuple.pair "expect" getArg.expect
            ]
        ]


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


make_ :
    { metadata :
        { url : Elm.Expression
        , statusCode : Elm.Expression
        , statusText : Elm.Expression
        , headers : Elm.Expression
        }
        -> Elm.Expression
    , badUrl : Elm.Expression -> Elm.Expression
    , timeout : Elm.Expression
    , networkError : Elm.Expression
    , badStatus : Elm.Expression -> Elm.Expression
    , badBody : Elm.Expression -> Elm.Expression
    , badUrl_ : Elm.Expression -> Elm.Expression
    , timeout_ : Elm.Expression
    , networkError_ : Elm.Expression
    , badStatus_ : Elm.Expression -> Elm.Expression -> Elm.Expression
    , goodStatus_ : Elm.Expression -> Elm.Expression -> Elm.Expression
    , sending : Elm.Expression -> Elm.Expression
    , receiving : Elm.Expression -> Elm.Expression
    }
make_ =
    { metadata =
        \metadata_args ->
            Elm.withType
                (Type.alias
                    [ "Effect", "Http" ]
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
                )
                (Elm.record
                    [ Tuple.pair "url" metadata_args.url
                    , Tuple.pair "statusCode" metadata_args.statusCode
                    , Tuple.pair "statusText" metadata_args.statusText
                    , Tuple.pair "headers" metadata_args.headers
                    ]
                )
    , badUrl =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "BadUrl"
                    , annotation = Just (Type.namedWith [] "Error" [])
                    }
                )
                [ ar0 ]
    , timeout =
        Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "Timeout"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , networkError =
        Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "NetworkError"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , badStatus =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "BadStatus"
                    , annotation = Just (Type.namedWith [] "Error" [])
                    }
                )
                [ ar0 ]
    , badBody =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "BadBody"
                    , annotation = Just (Type.namedWith [] "Error" [])
                    }
                )
                [ ar0 ]
    , badUrl_ =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "BadUrl_"
                    , annotation =
                        Just (Type.namedWith [] "Response" [ Type.var "body" ])
                    }
                )
                [ ar0 ]
    , timeout_ =
        Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "Timeout_"
            , annotation =
                Just (Type.namedWith [] "Response" [ Type.var "body" ])
            }
    , networkError_ =
        Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "NetworkError_"
            , annotation =
                Just (Type.namedWith [] "Response" [ Type.var "body" ])
            }
    , badStatus_ =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "BadStatus_"
                    , annotation =
                        Just (Type.namedWith [] "Response" [ Type.var "body" ])
                    }
                )
                [ ar0, ar1 ]
    , goodStatus_ =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "GoodStatus_"
                    , annotation =
                        Just (Type.namedWith [] "Response" [ Type.var "body" ])
                    }
                )
                [ ar0, ar1 ]
    , sending =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "Sending"
                    , annotation = Just (Type.namedWith [] "Progress" [])
                    }
                )
                [ ar0 ]
    , receiving =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Effect", "Http" ]
                    , name = "Receiving"
                    , annotation = Just (Type.namedWith [] "Progress" [])
                    }
                )
                [ ar0 ]
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


values_ :
    { riskyTask : Elm.Expression
    , bytesResolver : Elm.Expression
    , stringResolver : Elm.Expression
    , task : Elm.Expression
    , expectWhatever : Elm.Expression
    , expectBytes : Elm.Expression
    , expectJson : Elm.Expression
    , expectBytesResponse : Elm.Expression
    , expectStringResponse : Elm.Expression
    , expectString : Elm.Expression
    , riskyRequest : Elm.Expression
    , fractionReceived : Elm.Expression
    , fractionSent : Elm.Expression
    , track : Elm.Expression
    , cancel : Elm.Expression
    , bytesPart : Elm.Expression
    , filePart : Elm.Expression
    , stringPart : Elm.Expression
    , multipartBody : Elm.Expression
    , fileBody : Elm.Expression
    , bytesBody : Elm.Expression
    , stringBody : Elm.Expression
    , jsonBody : Elm.Expression
    , emptyBody : Elm.Expression
    , header : Elm.Expression
    , request : Elm.Expression
    , post : Elm.Expression
    , get : Elm.Expression
    }
values_ =
    { riskyTask =
        Elm.value
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
                              , Type.namedWith [ "Effect", "Http" ] "Body" []
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
                                    (Type.namedWith [ "Duration" ] "Duration" [])
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
    , bytesResolver =
        Elm.value
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
    , stringResolver =
        Elm.value
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
    , task =
        Elm.value
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
                              , Type.namedWith [ "Effect", "Http" ] "Body" []
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
                                    (Type.namedWith [ "Duration" ] "Duration" [])
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
    , expectWhatever =
        Elm.value
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
    , expectBytes =
        Elm.value
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
    , expectJson =
        Elm.value
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
    , expectBytesResponse =
        Elm.value
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
    , expectStringResponse =
        Elm.value
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
    , expectString =
        Elm.value
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
    , riskyRequest =
        Elm.value
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
                              , Type.namedWith [ "Effect", "Http" ] "Body" []
                              )
                            , ( "expect"
                              , Type.namedWith
                                    [ "Effect", "Http" ]
                                    "Expect"
                                    [ Type.var "msg" ]
                              )
                            , ( "timeout"
                              , Type.maybe
                                    (Type.namedWith [ "Duration" ] "Duration" [])
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
    , fractionReceived =
        Elm.value
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
    , fractionSent =
        Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "fractionSent"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "sent", Type.int ), ( "size", Type.int ) ]
                        ]
                        Type.float
                    )
            }
    , track =
        Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "track"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.function
                            [ Type.namedWith [ "Effect", "Http" ] "Progress" []
                            ]
                            (Type.var "msg")
                        ]
                        (Type.namedWith
                            [ "Effect", "Subscription" ]
                            "Subscription"
                            [ Type.var "restriction", Type.var "msg" ]
                        )
                    )
            }
    , cancel =
        Elm.value
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
    , bytesPart =
        Elm.value
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
    , filePart =
        Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "filePart"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.namedWith [ "Effect", "File" ] "File" []
                        ]
                        (Type.namedWith [ "Effect", "Http" ] "Part" [])
                    )
            }
    , stringPart =
        Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "stringPart"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string ]
                        (Type.namedWith [ "Effect", "Http" ] "Part" [])
                    )
            }
    , multipartBody =
        Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "multipartBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.list
                            (Type.namedWith [ "Effect", "Http" ] "Part" [])
                        ]
                        (Type.namedWith [ "Effect", "Http" ] "Body" [])
                    )
            }
    , fileBody =
        Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "fileBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Effect", "File" ] "File" [] ]
                        (Type.namedWith [ "Effect", "Http" ] "Body" [])
                    )
            }
    , bytesBody =
        Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "bytesBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.namedWith [ "Bytes" ] "Bytes" [] ]
                        (Type.namedWith [ "Effect", "Http" ] "Body" [])
                    )
            }
    , stringBody =
        Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "stringBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string ]
                        (Type.namedWith [ "Effect", "Http" ] "Body" [])
                    )
            }
    , jsonBody =
        Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "jsonBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Json", "Encode" ] "Value" [] ]
                        (Type.namedWith [ "Effect", "Http" ] "Body" [])
                    )
            }
    , emptyBody =
        Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "emptyBody"
            , annotation = Just (Type.namedWith [ "Effect", "Http" ] "Body" [])
            }
    , header =
        Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "header"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string ]
                        (Type.namedWith [ "Effect", "Http" ] "Header" [])
                    )
            }
    , request =
        Elm.value
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
                              , Type.namedWith [ "Effect", "Http" ] "Body" []
                              )
                            , ( "expect"
                              , Type.namedWith
                                    [ "Effect", "Http" ]
                                    "Expect"
                                    [ Type.var "msg" ]
                              )
                            , ( "timeout"
                              , Type.maybe
                                    (Type.namedWith [ "Duration" ] "Duration" [])
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
    , post =
        Elm.value
            { importFrom = [ "Effect", "Http" ]
            , name = "post"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "url", Type.string )
                            , ( "body"
                              , Type.namedWith [ "Effect", "Http" ] "Body" []
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
    , get =
        Elm.value
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
    }
