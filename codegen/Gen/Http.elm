module Gen.Http exposing (annotation_, bytesBody, bytesPart, bytesResolver, call_, cancel, caseOf_, emptyBody, expectBytes, expectBytesResponse, expectJson, expectString, expectStringResponse, expectWhatever, fileBody, filePart, fractionReceived, fractionSent, get, header, jsonBody, make_, moduleName_, multipartBody, post, request, riskyRequest, riskyTask, stringBody, stringPart, stringResolver, task, track, values_)

{-| 
@docs values_, call_, caseOf_, make_, annotation_, riskyTask, bytesResolver, stringResolver, task, expectBytesResponse, expectStringResponse, riskyRequest, cancel, fractionReceived, fractionSent, track, expectWhatever, expectBytes, expectJson, expectString, bytesPart, filePart, stringPart, multipartBody, bytesBody, fileBody, jsonBody, stringBody, emptyBody, header, request, post, get, moduleName_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case
import Tuple


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Http" ]


{-| Create a `GET` request.

    import Http

    type Msg
      = GotText (Result Http.Error String)

    getPublicOpinion : Cmd Msg
    getPublicOpinion =
      Http.get
        { url = "https://elm-lang.org/assets/public-opinion.txt"
        , expect = Http.expectString GotText
        }

You can use functions like [`expectString`](#expectString) and
[`expectJson`](#expectJson) to interpret the response in different ways. In
this example, we are expecting the response body to be a `String` containing
the full text of _Public Opinion_ by Walter Lippmann.

**Note:** Use [`elm/url`](/packages/elm/url/latest) to build reliable URLs.

get: { url : String, expect : Http.Expect msg } -> Platform.Cmd.Cmd msg
-}
get : { url : String, expect : Elm.Expression } -> Elm.Expression
get getArg =
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
        [ Elm.record
            [ Tuple.pair "url" (Elm.string getArg.url)
            , Tuple.pair "expect" getArg.expect
            ]
        ]


{-| Create a `POST` request. So imagine we want to send a POST request for
some JSON data. It might look like this:

    import Http
    import Json.Decode exposing (list, string)

    type Msg
      = GotBooks (Result Http.Error (List String))

    postBooks : Cmd Msg
    postBooks =
      Http.post
        { url = "https://example.com/books"
        , body = Http.emptyBody
        , expect = Http.expectJson GotBooks (list string)
        }

Notice that we are using [`expectJson`](#expectJson) to interpret the response
as JSON. You can learn more about how JSON decoders work [here][] in the guide.

We did not put anything in the body of our request, but you can use functions
like [`stringBody`](#stringBody) and [`jsonBody`](#jsonBody) if you need to
send information to the server.

[here]: https://guide.elm-lang.org/interop/json.html

post: 
    { url : String, body : Http.Body, expect : Http.Expect msg }
    -> Platform.Cmd.Cmd msg
-}
post :
    { url : String, body : Elm.Expression, expect : Elm.Expression }
    -> Elm.Expression
post postArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Http" ]
            , name = "post"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "url", Type.string )
                            , ( "body", Type.namedWith [ "Http" ] "Body" [] )
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
        [ Elm.record
            [ Tuple.pair "url" (Elm.string postArg.url)
            , Tuple.pair "body" postArg.body
            , Tuple.pair "expect" postArg.expect
            ]
        ]


{-| Create a custom request. For example, a PUT for files might look like this:

    import File
    import Http

    type Msg = Uploaded (Result Http.Error ())

    upload : File.File -> Cmd Msg
    upload file =
      Http.request
        { method = "PUT"
        , headers = []
        , url = "https://example.com/publish"
        , body = Http.fileBody file
        , expect = Http.expectWhatever Uploaded
        , timeout = Nothing
        , tracker = Nothing
        }

It lets you set custom `headers` as needed. The `timeout` is the number of
milliseconds you are willing to wait before giving up. The `tracker` lets you
[`cancel`](#cancel) and [`track`](#track) requests.

request: 
    { method : String
    , headers : List Http.Header
    , url : String
    , body : Http.Body
    , expect : Http.Expect msg
    , timeout : Maybe Float
    , tracker : Maybe String
    }
    -> Platform.Cmd.Cmd msg
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
            { importFrom = [ "Http" ]
            , name = "request"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "method", Type.string )
                            , ( "headers"
                              , Type.list
                                    (Type.namedWith [ "Http" ] "Header" [])
                              )
                            , ( "url", Type.string )
                            , ( "body", Type.namedWith [ "Http" ] "Body" [] )
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


{-| Create a `Header`.

    header "If-Modified-Since" "Sat 29 Oct 1994 19:43:31 GMT"
    header "Max-Forwards" "10"
    header "X-Requested-With" "XMLHttpRequest"

header: String -> String -> Http.Header
-}
header : String -> String -> Elm.Expression
header headerArg headerArg0 =
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
        [ Elm.string headerArg, Elm.string headerArg0 ]


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


{-| Put some string in the body of your `Request`. Defining `jsonBody` looks
like this:

    import Json.Encode as Encode

    jsonBody : Encode.Value -> Body
    jsonBody value =
      stringBody "application/json" (Encode.encode 0 value)

The first argument is a [MIME type](https://en.wikipedia.org/wiki/Media_type)
of the body. Some servers are strict about this!

stringBody: String -> String -> Http.Body
-}
stringBody : String -> String -> Elm.Expression
stringBody stringBodyArg stringBodyArg0 =
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
        [ Elm.string stringBodyArg, Elm.string stringBodyArg0 ]


{-| Put some JSON value in the body of your `Request`. This will automatically
add the `Content-Type: application/json` header.

jsonBody: Json.Encode.Value -> Http.Body
-}
jsonBody : Elm.Expression -> Elm.Expression
jsonBody jsonBodyArg =
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
        [ jsonBodyArg ]


{-| Use a file as the body of your `Request`. When someone uploads an image
into the browser with [`elm/file`](/packages/elm/file/latest) you can forward
it to a server.

This will automatically set the `Content-Type` to the MIME type of the file.

**Note:** Use [`track`](#track) to track upload progress.

fileBody: File.File -> Http.Body
-}
fileBody : Elm.Expression -> Elm.Expression
fileBody fileBodyArg =
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
        [ fileBodyArg ]


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
bytesBody bytesBodyArg bytesBodyArg0 =
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
        [ Elm.string bytesBodyArg, bytesBodyArg0 ]


{-| When someone clicks submit on the `<form>`, browsers send a special HTTP
request with all the form data. Something like this:

```
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
```

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

multipartBody: List Http.Part -> Http.Body
-}
multipartBody : List Elm.Expression -> Elm.Expression
multipartBody multipartBodyArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Http" ]
            , name = "multipartBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.namedWith [ "Http" ] "Part" []) ]
                        (Type.namedWith [ "Http" ] "Body" [])
                    )
            }
        )
        [ Elm.list multipartBodyArg ]


{-| A part that contains `String` data.

    multipartBody
      [ stringPart "title" "Tom"
      , filePart "photo" tomPng
      ]

stringPart: String -> String -> Http.Part
-}
stringPart : String -> String -> Elm.Expression
stringPart stringPartArg stringPartArg0 =
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
        [ Elm.string stringPartArg, Elm.string stringPartArg0 ]


{-| A part that contains a file. You can use
[`elm/file`](/packages/elm/file/latest) to get files loaded into the
browser. From there, you can send it along to a server like this:

    multipartBody
      [ stringPart "product" "Ikea Bekant"
      , stringPart "description" "Great desk for home office."
      , filePart "image[]" file1
      , filePart "image[]" file2
      , filePart "image[]" file3
      ]

filePart: String -> File.File -> Http.Part
-}
filePart : String -> Elm.Expression -> Elm.Expression
filePart filePartArg filePartArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Http" ]
            , name = "filePart"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.namedWith [ "File" ] "File" [] ]
                        (Type.namedWith [ "Http" ] "Part" [])
                    )
            }
        )
        [ Elm.string filePartArg, filePartArg0 ]


{-| A part that contains bytes, allowing you to use
[`elm/bytes`](/packages/elm/bytes/latest) to encode data exactly in the format
you need.

    multipartBody
      [ stringPart "title" "Tom"
      , bytesPart "photo" "image/png" bytes
      ]

**Note:** You must provide a MIME type so that the receiver has clues about
how to interpret the bytes.

bytesPart: String -> String -> Bytes.Bytes -> Http.Part
-}
bytesPart : String -> String -> Elm.Expression -> Elm.Expression
bytesPart bytesPartArg bytesPartArg0 bytesPartArg1 =
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
        [ Elm.string bytesPartArg, Elm.string bytesPartArg0, bytesPartArg1 ]


{-| Expect the response body to be a `String`. Like when getting the full text
of a book:

    import Http

    type Msg
      = GotText (Result Http.Error String)

    getPublicOpinion : Cmd Msg
    getPublicOpinion =
      Http.get
        { url = "https://elm-lang.org/assets/public-opinion.txt"
        , expect = Http.expectString GotText
        }

The response body is always some sequence of bytes, but in this case, we
expect it to be UTF-8 encoded text that can be turned into a `String`.

expectString: (Result.Result Http.Error String -> msg) -> Http.Expect msg
-}
expectString : (Elm.Expression -> Elm.Expression) -> Elm.Expression
expectString expectStringArg =
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
                                [ Type.namedWith [ "Http" ] "Error" []
                                , Type.string
                                ]
                            ]
                            (Type.var "msg")
                        ]
                        (Type.namedWith [ "Http" ] "Expect" [ Type.var "msg" ])
                    )
            }
        )
        [ Elm.functionReduced "expectStringUnpack" expectStringArg ]


{-| Expect the response body to be JSON. Like if you want to get a random cat
GIF you might say:

    import Http
    import Json.Decode exposing (Decoder, field, string)

    type Msg
      = GotGif (Result Http.Error String)

    getRandomCatGif : Cmd Msg
    getRandomCatGif =
      Http.get
        { url = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=cat"
        , expect = Http.expectJson GotGif gifDecoder
        }

    gifDecoder : Decoder String
    gifDecoder =
      field "data" (field "image_url" string)

The official guide goes through this particular example [here][]. That page
also introduces [`elm/json`][json] to help you get started turning JSON into
Elm values in other situations.

[here]: https://guide.elm-lang.org/interop/json.html
[json]: /packages/elm/json/latest/

If the JSON decoder fails, you get a `BadBody` error that tries to explain
what went wrong.

expectJson: (Result.Result Http.Error a -> msg) -> Json.Decode.Decoder a -> Http.Expect msg
-}
expectJson :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
expectJson expectJsonArg expectJsonArg0 =
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
                                [ Type.namedWith [ "Http" ] "Error" []
                                , Type.var "a"
                                ]
                            ]
                            (Type.var "msg")
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith [ "Http" ] "Expect" [ Type.var "msg" ])
                    )
            }
        )
        [ Elm.functionReduced "expectJsonUnpack" expectJsonArg, expectJsonArg0 ]


{-| Expect the response body to be binary data. For example, maybe you are
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

expectBytes: (Result.Result Http.Error a -> msg) -> Bytes.Decode.Decoder a -> Http.Expect msg
-}
expectBytes :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
expectBytes expectBytesArg expectBytesArg0 =
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
                                [ Type.namedWith [ "Http" ] "Error" []
                                , Type.var "a"
                                ]
                            ]
                            (Type.var "msg")
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith [ "Http" ] "Expect" [ Type.var "msg" ])
                    )
            }
        )
        [ Elm.functionReduced "expectBytesUnpack" expectBytesArg
        , expectBytesArg0
        ]


{-| Expect the response body to be whatever. It does not matter. Ignore it!
For example, you might want this when uploading files:

    import Http

    type Msg
      = Uploaded (Result Http.Error ())

    upload : File -> Cmd Msg
    upload file =
      Http.post
        { url = "/upload"
        , body = Http.fileBody file
        , expect = Http.expectWhatever Uploaded
        }

The server may be giving back a response body, but we do not care about it.

expectWhatever: (Result.Result Http.Error () -> msg) -> Http.Expect msg
-}
expectWhatever : (Elm.Expression -> Elm.Expression) -> Elm.Expression
expectWhatever expectWhateverArg =
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
                                [ Type.namedWith [ "Http" ] "Error" []
                                , Type.unit
                                ]
                            ]
                            (Type.var "msg")
                        ]
                        (Type.namedWith [ "Http" ] "Expect" [ Type.var "msg" ])
                    )
            }
        )
        [ Elm.functionReduced "expectWhateverUnpack" expectWhateverArg ]


{-| Track the progress of a request. Create a [`request`](#request) where
`tracker = Just "form.pdf"` and you can track it with a subscription like
`track "form.pdf" GotProgress`.

track: String -> (Http.Progress -> msg) -> Platform.Sub.Sub msg
-}
track : String -> (Elm.Expression -> Elm.Expression) -> Elm.Expression
track trackArg trackArg0 =
    Elm.apply
        (Elm.value
            { importFrom = [ "Http" ]
            , name = "track"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.function
                            [ Type.namedWith [ "Http" ] "Progress" [] ]
                            (Type.var "msg")
                        ]
                        (Type.namedWith [] "Sub" [ Type.var "msg" ])
                    )
            }
        )
        [ Elm.string trackArg, Elm.functionReduced "trackUnpack" trackArg0 ]


{-| Turn `Sending` progress into a useful fraction.

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

fractionSent: { sent : Int, size : Int } -> Float
-}
fractionSent : { sent : Int, size : Int } -> Elm.Expression
fractionSent fractionSentArg =
    Elm.apply
        (Elm.value
            { importFrom = [ "Http" ]
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


{-| Turn `Receiving` progress into a useful fraction for progress bars.

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

fractionReceived: { received : Int, size : Maybe Int } -> Float
-}
fractionReceived : { received : Int, size : Elm.Expression } -> Elm.Expression
fractionReceived fractionReceivedArg =
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
        [ Elm.record
            [ Tuple.pair "received" (Elm.int fractionReceivedArg.received)
            , Tuple.pair "size" fractionReceivedArg.size
            ]
        ]


{-| Try to cancel an ongoing request based on a `tracker`.

cancel: String -> Platform.Cmd.Cmd msg
-}
cancel : String -> Elm.Expression
cancel cancelArg =
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
        [ Elm.string cancelArg ]


{-| Create a request with a risky security policy. Things like:

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

riskyRequest: 
    { method : String
    , headers : List Http.Header
    , url : String
    , body : Http.Body
    , expect : Http.Expect msg
    , timeout : Maybe Float
    , tracker : Maybe String
    }
    -> Platform.Cmd.Cmd msg
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
            { importFrom = [ "Http" ]
            , name = "riskyRequest"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "method", Type.string )
                            , ( "headers"
                              , Type.list
                                    (Type.namedWith [ "Http" ] "Header" [])
                              )
                            , ( "url", Type.string )
                            , ( "body", Type.namedWith [ "Http" ] "Body" [] )
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
expectStringResponse expectStringResponseArg expectStringResponseArg0 =
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
            expectStringResponseArg
        , Elm.functionReduced
            "expectStringResponseUnpack"
            expectStringResponseArg0
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
expectBytesResponse expectBytesResponseArg expectBytesResponseArg0 =
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
        [ Elm.functionReduced "expectBytesResponseUnpack" expectBytesResponseArg
        , Elm.functionReduced
            "expectBytesResponseUnpack"
            expectBytesResponseArg0
        ]


{-| Just like [`request`](#request), but it creates a `Task`. This makes it
possible to pair your HTTP request with `Time.now` if you need timestamps for
some reason. **This should be quite rare.**

task: 
    { method : String
    , headers : List Http.Header
    , url : String
    , body : Http.Body
    , resolver : Http.Resolver x a
    , timeout : Maybe Float
    }
    -> Task.Task x a
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
            { importFrom = [ "Http" ]
            , name = "task"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "method", Type.string )
                            , ( "headers"
                              , Type.list
                                    (Type.namedWith [ "Http" ] "Header" [])
                              )
                            , ( "url", Type.string )
                            , ( "body", Type.namedWith [ "Http" ] "Body" [] )
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
        [ Elm.record
            [ Tuple.pair "method" (Elm.string taskArg.method)
            , Tuple.pair "headers" (Elm.list taskArg.headers)
            , Tuple.pair "url" (Elm.string taskArg.url)
            , Tuple.pair "body" taskArg.body
            , Tuple.pair "resolver" taskArg.resolver
            , Tuple.pair "timeout" taskArg.timeout
            ]
        ]


{-| Turn a response with a `String` body into a result.
Similar to [`expectStringResponse`](#expectStringResponse).

stringResolver: (Http.Response String -> Result.Result x a) -> Http.Resolver x a
-}
stringResolver : (Elm.Expression -> Elm.Expression) -> Elm.Expression
stringResolver stringResolverArg =
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
        [ Elm.functionReduced "stringResolverUnpack" stringResolverArg ]


{-| Turn a response with a `Bytes` body into a result.
Similar to [`expectBytesResponse`](#expectBytesResponse).

bytesResolver: (Http.Response Bytes.Bytes -> Result.Result x a) -> Http.Resolver x a
-}
bytesResolver : (Elm.Expression -> Elm.Expression) -> Elm.Expression
bytesResolver bytesResolverArg =
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
        [ Elm.functionReduced "bytesResolverUnpack" bytesResolverArg ]


{-| Just like [`riskyRequest`](#riskyRequest), but it creates a `Task`. **Use
with caution!** This has all the same security concerns as `riskyRequest`.

riskyTask: 
    { method : String
    , headers : List Http.Header
    , url : String
    , body : Http.Body
    , resolver : Http.Resolver x a
    , timeout : Maybe Float
    }
    -> Task.Task x a
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
            { importFrom = [ "Http" ]
            , name = "riskyTask"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "method", Type.string )
                            , ( "headers"
                              , Type.list
                                    (Type.namedWith [ "Http" ] "Header" [])
                              )
                            , ( "url", Type.string )
                            , ( "body", Type.namedWith [ "Http" ] "Body" [] )
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
        [ Elm.record
            [ Tuple.pair "method" (Elm.string riskyTaskArg.method)
            , Tuple.pair "headers" (Elm.list riskyTaskArg.headers)
            , Tuple.pair "url" (Elm.string riskyTaskArg.url)
            , Tuple.pair "body" riskyTaskArg.body
            , Tuple.pair "resolver" riskyTaskArg.resolver
            , Tuple.pair "timeout" riskyTaskArg.timeout
            ]
        ]


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


make_ :
    { badUrl : Elm.Expression -> Elm.Expression
    , timeout : Elm.Expression
    , networkError : Elm.Expression
    , badStatus : Elm.Expression -> Elm.Expression
    , badBody : Elm.Expression -> Elm.Expression
    , sending : Elm.Expression -> Elm.Expression
    , receiving : Elm.Expression -> Elm.Expression
    , badUrl_ : Elm.Expression -> Elm.Expression
    , timeout_ : Elm.Expression
    , networkError_ : Elm.Expression
    , badStatus_ : Elm.Expression -> Elm.Expression -> Elm.Expression
    , goodStatus_ : Elm.Expression -> Elm.Expression -> Elm.Expression
    , metadata :
        { url : Elm.Expression
        , statusCode : Elm.Expression
        , statusText : Elm.Expression
        , headers : Elm.Expression
        }
        -> Elm.Expression
    }
make_ =
    { badUrl =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "BadUrl"
                    , annotation = Just (Type.namedWith [] "Error" [])
                    }
                )
                [ ar0 ]
    , timeout =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "Timeout"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , networkError =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "NetworkError"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , badStatus =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "BadStatus"
                    , annotation = Just (Type.namedWith [] "Error" [])
                    }
                )
                [ ar0 ]
    , badBody =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "BadBody"
                    , annotation = Just (Type.namedWith [] "Error" [])
                    }
                )
                [ ar0 ]
    , sending =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "Sending"
                    , annotation = Just (Type.namedWith [] "Progress" [])
                    }
                )
                [ ar0 ]
    , receiving =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "Receiving"
                    , annotation = Just (Type.namedWith [] "Progress" [])
                    }
                )
                [ ar0 ]
    , badUrl_ =
        \ar0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "BadUrl_"
                    , annotation =
                        Just (Type.namedWith [] "Response" [ Type.var "body" ])
                    }
                )
                [ ar0 ]
    , timeout_ =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "Timeout_"
            , annotation =
                Just (Type.namedWith [] "Response" [ Type.var "body" ])
            }
    , networkError_ =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "NetworkError_"
            , annotation =
                Just (Type.namedWith [] "Response" [ Type.var "body" ])
            }
    , badStatus_ =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
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
                    { importFrom = [ "Http" ]
                    , name = "GoodStatus_"
                    , annotation =
                        Just (Type.namedWith [] "Response" [ Type.var "body" ])
                    }
                )
                [ ar0, ar1 ]
    , metadata =
        \metadata_args ->
            Elm.withType
                (Type.alias
                    [ "Http" ]
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
    }


caseOf_ :
    { error :
        Elm.Expression
        -> { errorTags_0_0
            | badUrl : Elm.Expression -> Elm.Expression
            , timeout : Elm.Expression
            , networkError : Elm.Expression
            , badStatus : Elm.Expression -> Elm.Expression
            , badBody : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , progress :
        Elm.Expression
        -> { progressTags_1_0
            | sending : Elm.Expression -> Elm.Expression
            , receiving : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , response :
        Elm.Expression
        -> { responseTags_2_0
            | badUrl_ : Elm.Expression -> Elm.Expression
            , timeout_ : Elm.Expression
            , networkError_ : Elm.Expression
            , badStatus_ : Elm.Expression -> Elm.Expression -> Elm.Expression
            , goodStatus_ : Elm.Expression -> Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { error =
        \errorExpression errorTags ->
            Elm.Case.custom
                errorExpression
                (Type.namedWith [ "Http" ] "Error" [])
                [ Elm.Case.branch1
                    "BadUrl"
                    ( "string.String", Type.string )
                    errorTags.badUrl
                , Elm.Case.branch0 "Timeout" errorTags.timeout
                , Elm.Case.branch0 "NetworkError" errorTags.networkError
                , Elm.Case.branch1
                    "BadStatus"
                    ( "basics.Int", Type.int )
                    errorTags.badStatus
                , Elm.Case.branch1
                    "BadBody"
                    ( "string.String", Type.string )
                    errorTags.badBody
                ]
    , progress =
        \progressExpression progressTags ->
            Elm.Case.custom
                progressExpression
                (Type.namedWith [ "Http" ] "Progress" [])
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
    , response =
        \responseExpression responseTags ->
            Elm.Case.custom
                responseExpression
                (Type.namedWith [ "Http" ] "Response" [ Type.var "body" ])
                [ Elm.Case.branch1
                    "BadUrl_"
                    ( "string.String", Type.string )
                    responseTags.badUrl_
                , Elm.Case.branch0 "Timeout_" responseTags.timeout_
                , Elm.Case.branch0 "NetworkError_" responseTags.networkError_
                , Elm.Case.branch2
                    "BadStatus_"
                    ( "http.Metadata", Type.namedWith [ "Http" ] "Metadata" [] )
                    ( "body", Type.var "body" )
                    responseTags.badStatus_
                , Elm.Case.branch2
                    "GoodStatus_"
                    ( "http.Metadata", Type.namedWith [ "Http" ] "Metadata" [] )
                    ( "body", Type.var "body" )
                    responseTags.goodStatus_
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
        \getArg ->
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
                [ getArg ]
    , post =
        \postArg ->
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
                [ postArg ]
    , request =
        \requestArg ->
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
                [ requestArg ]
    , header =
        \headerArg headerArg0 ->
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
                [ headerArg, headerArg0 ]
    , stringBody =
        \stringBodyArg stringBodyArg0 ->
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
                [ stringBodyArg, stringBodyArg0 ]
    , jsonBody =
        \jsonBodyArg ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "jsonBody"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.namedWith [ "Json", "Encode" ] "Value" []
                                ]
                                (Type.namedWith [ "Http" ] "Body" [])
                            )
                    }
                )
                [ jsonBodyArg ]
    , fileBody =
        \fileBodyArg ->
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
                [ fileBodyArg ]
    , bytesBody =
        \bytesBodyArg bytesBodyArg0 ->
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
                [ bytesBodyArg, bytesBodyArg0 ]
    , multipartBody =
        \multipartBodyArg ->
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
                [ multipartBodyArg ]
    , stringPart =
        \stringPartArg stringPartArg0 ->
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
                [ stringPartArg, stringPartArg0 ]
    , filePart =
        \filePartArg filePartArg0 ->
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
                [ filePartArg, filePartArg0 ]
    , bytesPart =
        \bytesPartArg bytesPartArg0 bytesPartArg1 ->
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
                [ bytesPartArg, bytesPartArg0, bytesPartArg1 ]
    , expectString =
        \expectStringArg ->
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
                                        [ Type.namedWith [ "Http" ] "Error" []
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
                [ expectStringArg ]
    , expectJson =
        \expectJsonArg expectJsonArg0 ->
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
                                        [ Type.namedWith [ "Http" ] "Error" []
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
                [ expectJsonArg, expectJsonArg0 ]
    , expectBytes =
        \expectBytesArg expectBytesArg0 ->
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
                                        [ Type.namedWith [ "Http" ] "Error" []
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
                [ expectBytesArg, expectBytesArg0 ]
    , expectWhatever =
        \expectWhateverArg ->
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
                                        [ Type.namedWith [ "Http" ] "Error" []
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
                [ expectWhateverArg ]
    , track =
        \trackArg trackArg0 ->
            Elm.apply
                (Elm.value
                    { importFrom = [ "Http" ]
                    , name = "track"
                    , annotation =
                        Just
                            (Type.function
                                [ Type.string
                                , Type.function
                                    [ Type.namedWith [ "Http" ] "Progress" [] ]
                                    (Type.var "msg")
                                ]
                                (Type.namedWith [] "Sub" [ Type.var "msg" ])
                            )
                    }
                )
                [ trackArg, trackArg0 ]
    , fractionSent =
        \fractionSentArg ->
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
                [ fractionSentArg ]
    , fractionReceived =
        \fractionReceivedArg ->
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
                [ fractionReceivedArg ]
    , cancel =
        \cancelArg ->
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
                [ cancelArg ]
    , riskyRequest =
        \riskyRequestArg ->
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
                [ riskyRequestArg ]
    , expectStringResponse =
        \expectStringResponseArg expectStringResponseArg0 ->
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
                [ expectStringResponseArg, expectStringResponseArg0 ]
    , expectBytesResponse =
        \expectBytesResponseArg expectBytesResponseArg0 ->
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
                                        [ Type.namedWith [ "Bytes" ] "Bytes" []
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
                [ expectBytesResponseArg, expectBytesResponseArg0 ]
    , task =
        \taskArg ->
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
                [ taskArg ]
    , stringResolver =
        \stringResolverArg ->
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
                [ stringResolverArg ]
    , bytesResolver =
        \bytesResolverArg ->
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
                                        [ Type.namedWith [ "Bytes" ] "Bytes" []
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
                [ bytesResolverArg ]
    , riskyTask =
        \riskyTaskArg ->
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
                [ riskyTaskArg ]
    }


values_ :
    { get : Elm.Expression
    , post : Elm.Expression
    , request : Elm.Expression
    , header : Elm.Expression
    , emptyBody : Elm.Expression
    , stringBody : Elm.Expression
    , jsonBody : Elm.Expression
    , fileBody : Elm.Expression
    , bytesBody : Elm.Expression
    , multipartBody : Elm.Expression
    , stringPart : Elm.Expression
    , filePart : Elm.Expression
    , bytesPart : Elm.Expression
    , expectString : Elm.Expression
    , expectJson : Elm.Expression
    , expectBytes : Elm.Expression
    , expectWhatever : Elm.Expression
    , track : Elm.Expression
    , fractionSent : Elm.Expression
    , fractionReceived : Elm.Expression
    , cancel : Elm.Expression
    , riskyRequest : Elm.Expression
    , expectStringResponse : Elm.Expression
    , expectBytesResponse : Elm.Expression
    , task : Elm.Expression
    , stringResolver : Elm.Expression
    , bytesResolver : Elm.Expression
    , riskyTask : Elm.Expression
    }
values_ =
    { get =
        Elm.value
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
    , post =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "post"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "url", Type.string )
                            , ( "body", Type.namedWith [ "Http" ] "Body" [] )
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
    , request =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "request"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "method", Type.string )
                            , ( "headers"
                              , Type.list
                                    (Type.namedWith [ "Http" ] "Header" [])
                              )
                            , ( "url", Type.string )
                            , ( "body", Type.namedWith [ "Http" ] "Body" [] )
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
    , header =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "header"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string ]
                        (Type.namedWith [ "Http" ] "Header" [])
                    )
            }
    , emptyBody =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "emptyBody"
            , annotation = Just (Type.namedWith [ "Http" ] "Body" [])
            }
    , stringBody =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "stringBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string ]
                        (Type.namedWith [ "Http" ] "Body" [])
                    )
            }
    , jsonBody =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "jsonBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "Json", "Encode" ] "Value" [] ]
                        (Type.namedWith [ "Http" ] "Body" [])
                    )
            }
    , fileBody =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "fileBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.namedWith [ "File" ] "File" [] ]
                        (Type.namedWith [ "Http" ] "Body" [])
                    )
            }
    , bytesBody =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "bytesBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.namedWith [ "Bytes" ] "Bytes" [] ]
                        (Type.namedWith [ "Http" ] "Body" [])
                    )
            }
    , multipartBody =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "multipartBody"
            , annotation =
                Just
                    (Type.function
                        [ Type.list (Type.namedWith [ "Http" ] "Part" []) ]
                        (Type.namedWith [ "Http" ] "Body" [])
                    )
            }
    , stringPart =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "stringPart"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.string ]
                        (Type.namedWith [ "Http" ] "Part" [])
                    )
            }
    , filePart =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "filePart"
            , annotation =
                Just
                    (Type.function
                        [ Type.string, Type.namedWith [ "File" ] "File" [] ]
                        (Type.namedWith [ "Http" ] "Part" [])
                    )
            }
    , bytesPart =
        Elm.value
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
    , expectString =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "expectString"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.namedWith [ "Http" ] "Error" []
                                , Type.string
                                ]
                            ]
                            (Type.var "msg")
                        ]
                        (Type.namedWith [ "Http" ] "Expect" [ Type.var "msg" ])
                    )
            }
    , expectJson =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "expectJson"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.namedWith [ "Http" ] "Error" []
                                , Type.var "a"
                                ]
                            ]
                            (Type.var "msg")
                        , Type.namedWith
                            [ "Json", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith [ "Http" ] "Expect" [ Type.var "msg" ])
                    )
            }
    , expectBytes =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "expectBytes"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.namedWith [ "Http" ] "Error" []
                                , Type.var "a"
                                ]
                            ]
                            (Type.var "msg")
                        , Type.namedWith
                            [ "Bytes", "Decode" ]
                            "Decoder"
                            [ Type.var "a" ]
                        ]
                        (Type.namedWith [ "Http" ] "Expect" [ Type.var "msg" ])
                    )
            }
    , expectWhatever =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "expectWhatever"
            , annotation =
                Just
                    (Type.function
                        [ Type.function
                            [ Type.namedWith
                                [ "Result" ]
                                "Result"
                                [ Type.namedWith [ "Http" ] "Error" []
                                , Type.unit
                                ]
                            ]
                            (Type.var "msg")
                        ]
                        (Type.namedWith [ "Http" ] "Expect" [ Type.var "msg" ])
                    )
            }
    , track =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "track"
            , annotation =
                Just
                    (Type.function
                        [ Type.string
                        , Type.function
                            [ Type.namedWith [ "Http" ] "Progress" [] ]
                            (Type.var "msg")
                        ]
                        (Type.namedWith [] "Sub" [ Type.var "msg" ])
                    )
            }
    , fractionSent =
        Elm.value
            { importFrom = [ "Http" ]
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
    , fractionReceived =
        Elm.value
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
    , cancel =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "cancel"
            , annotation =
                Just
                    (Type.function
                        [ Type.string ]
                        (Type.namedWith [] "Cmd" [ Type.var "msg" ])
                    )
            }
    , riskyRequest =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "riskyRequest"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "method", Type.string )
                            , ( "headers"
                              , Type.list
                                    (Type.namedWith [ "Http" ] "Header" [])
                              )
                            , ( "url", Type.string )
                            , ( "body", Type.namedWith [ "Http" ] "Body" [] )
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
    , expectStringResponse =
        Elm.value
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
    , expectBytesResponse =
        Elm.value
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
    , task =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "task"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "method", Type.string )
                            , ( "headers"
                              , Type.list
                                    (Type.namedWith [ "Http" ] "Header" [])
                              )
                            , ( "url", Type.string )
                            , ( "body", Type.namedWith [ "Http" ] "Body" [] )
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
    , stringResolver =
        Elm.value
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
    , bytesResolver =
        Elm.value
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
    , riskyTask =
        Elm.value
            { importFrom = [ "Http" ]
            , name = "riskyTask"
            , annotation =
                Just
                    (Type.function
                        [ Type.record
                            [ ( "method", Type.string )
                            , ( "headers"
                              , Type.list
                                    (Type.namedWith [ "Http" ] "Header" [])
                              )
                            , ( "url", Type.string )
                            , ( "body", Type.namedWith [ "Http" ] "Body" [] )
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
    }


