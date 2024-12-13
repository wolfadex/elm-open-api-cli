module Effect.Http exposing
    ( get, post, request
    , Header, header
    , Body, emptyBody, stringBody, jsonBody, fileBody, bytesBody
    , multipartBody, Part, stringPart, filePart, bytesPart
    , Expect, expectString, expectJson, expectBytes, expectWhatever, Error(..)
    , track, Progress(..), fractionSent, fractionReceived
    , cancel
    , riskyRequest
    , expectStringResponse, expectBytesResponse, Response(..), Metadata
    , task, Resolver, stringResolver, bytesResolver, riskyTask
    )

{-| Send HTTP requests.


# Requests

@docs get, post, request


# Header

@docs Header, header


# Body

@docs Body, emptyBody, stringBody, jsonBody, fileBody, bytesBody


# Body Parts

@docs multipartBody, Part, stringPart, filePart, bytesPart


# Expect

@docs Expect, expectString, expectJson, expectBytes, expectWhatever, Error


# Progress

@docs track, Progress, fractionSent, fractionReceived


# Cancel

@docs cancel


# Risky Requests

@docs riskyRequest


# Elaborate Expectations

@docs expectStringResponse, expectBytesResponse, Response, Metadata


# Tasks

@docs task, Resolver, stringResolver, bytesResolver, riskyTask

-}

import Bytes exposing (Bytes)
import Bytes.Decode
import Dict exposing (Dict)
import Duration exposing (Duration)
import Effect.Command exposing (Command)
import Effect.File exposing (File)
import Effect.Internal exposing (HttpBody(..), Task(..))
import Effect.Subscription exposing (Subscription)
import Effect.Task exposing (Task)
import Http
import Json.Decode exposing (Decoder)
import Json.Encode


{-| An HTTP header for configuring requests.
-}
type alias Header =
    ( String, String )


{-| Represents the body of a `Request`.
-}
type alias Body =
    Effect.Internal.HttpBody


{-| Create a `GET` request.
-}
get :
    { url : String
    , expect : Expect msg
    }
    -> Command restriction toFrontend msg
get r =
    request
        { method = "GET"
        , headers = []
        , url = r.url
        , body = emptyBody
        , expect = r.expect
        , timeout = Nothing
        , tracker = Nothing
        }


{-| Create a `POST` request.
-}
post :
    { url : String
    , body : Body
    , expect : Expect msg
    }
    -> Command restriction toFrontend msg
post r =
    request
        { method = "POST"
        , headers = []
        , url = r.url
        , body = r.body
        , expect = r.expect
        , timeout = Nothing
        , tracker = Nothing
        }


{-| Create a custom request.
-}
request :
    { method : String
    , headers : List Header
    , url : String
    , body : Body
    , expect : Expect msg
    , timeout : Maybe Duration
    , tracker : Maybe String
    }
    -> Command restriction toFrontend msg
request r =
    case r.expect of
        ExpectString onResult ->
            HttpStringTask (requestHelper False r onResult) |> Effect.Internal.Task

        ExpectBytes onResult ->
            HttpBytesTask (requestHelper False r onResult) |> Effect.Internal.Task


mapResponse : Http.Response body -> Response body
mapResponse response =
    case response of
        Http.BadUrl_ url ->
            BadUrl_ url

        Http.Timeout_ ->
            Timeout_

        Http.NetworkError_ ->
            NetworkError_

        Http.BadStatus_ metadata body ->
            BadStatus_ metadata body

        Http.GoodStatus_ metadata body ->
            GoodStatus_ metadata body


{-| Create a `Header`.
-}
header : String -> String -> Header
header =
    Tuple.pair


{-| Create an empty body for your `Request`.
-}
emptyBody : Body
emptyBody =
    EmptyBody


{-| Put some JSON value in the body of your `Request`. This will automatically
add the `Content-Type: application/json` header.
-}
jsonBody : Json.Encode.Value -> Body
jsonBody value =
    JsonBody value


{-| Put some string in the body of your `Request`.
-}
stringBody : String -> String -> Body
stringBody contentType content =
    StringBody
        { contentType = contentType
        , content = content
        }


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

-}
bytesBody : String -> Bytes -> Body
bytesBody =
    BytesBody


{-| Use a file as the body of your `Request`. When someone uploads an image
into the browser with [`elm/file`](/packages/elm/file/latest) you can forward
it to a server.

This will automatically set the `Content-Type` to the MIME type of the file.

**Note:** Use [`track`](#track) to track upload progress.

-}
fileBody : File -> Body
fileBody file =
    FileBody (Effect.File.toInternalFile file)



-- PARTS


{-| When someone clicks submit on the `<form>`, browsers send a special HTTP
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
multipartBody : List Part -> Body
multipartBody =
    MultipartBody


{-| One part of a `multipartBody`.
-}
type alias Part =
    Effect.Internal.HttpPart


{-| A part that contains `String` data.

    multipartBody
        [ stringPart "title" "Tom"
        , filePart "photo" tomPng
        ]

-}
stringPart : String -> String -> Part
stringPart =
    Effect.Internal.StringPart


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

-}
filePart : String -> File -> Part
filePart key file =
    Effect.Internal.FilePart key (Effect.File.toInternalFile file)


{-| A part that contains bytes, allowing you to use
[`elm/bytes`](/packages/elm/bytes/latest) to encode data exactly in the format
you need.

    multipartBody
        [ stringPart "title" "Tom"
        , bytesPart "photo" "image/png" bytes
        ]

**Note:** You must provide a MIME type so that the receiver has clues about
how to interpret the bytes.

-}
bytesPart : String -> String -> Bytes -> Part
bytesPart =
    Effect.Internal.BytesPart



-- CANCEL


{-| Try to cancel an ongoing request based on a `tracker`.
-}
cancel : String -> Command restriction toMsg msg
cancel =
    Effect.Internal.HttpCancel



-- PROGRESS


{-| Track the progress of a request. Create a [`request`](#request) where
`tracker = Just "form.pdf"` and you can track it with a subscription like
`track "form.pdf" GotProgress`.
-}
track : String -> (Progress -> msg) -> Subscription restriction msg
track tracker toMsg =
    Effect.Internal.HttpTrack tracker (progressFromInternal >> toMsg)


{-| There are two phases to HTTP requests. First you **send** a bunch of data,
then you **receive** a bunch of data. For example, say you use `fileBody` to
upload a file of 262144 bytes. From there, progress will go like this:

    Sending { sent = 0, size = 262144 } -- 0.0

    Sending { sent = 65536, size = 262144 } -- 0.25

    Sending { sent = 131072, size = 262144 } -- 0.5

    Sending { sent = 196608, size = 262144 } -- 0.75

    Sending { sent = 262144, size = 262144 } -- 1.0

    Receiving { received = 0, size = Just 16 } -- 0.0

    Receiving { received = 16, size = Just 16 } -- 1.0

With file uploads, the **send** phase is expensive. That is what we saw in our
example. But with file downloads, the **receive** phase is expensive.

Use [`fractionSent`](#fractionSent) and [`fractionReceived`](#fractionReceived)
to turn this progress information into specific fractions!

**Note:** The `size` of the response is based on the [`Content-Length`][cl]
header, and in rare and annoying cases, a server may not include that header.
That is why the `size` is a `Maybe Int` in `Receiving`.

[cl]: https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Length

-}
type Progress
    = Sending { sent : Int, size : Int }
    | Receiving { received : Int, size : Maybe Int }


progressFromInternal : Http.Progress -> Progress
progressFromInternal progress =
    case progress of
        Http.Sending a ->
            Sending a

        Http.Receiving a ->
            Receiving a


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

-}
fractionSent : { sent : Int, size : Int } -> Float
fractionSent p =
    if p.size == 0 then
        1

    else
        clamp 0 1 (toFloat p.sent / toFloat p.size)


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

-}
fractionReceived : { received : Int, size : Maybe Int } -> Float
fractionReceived p =
    case p.size of
        Nothing ->
            0

        Just n ->
            if n == 0 then
                1

            else
                clamp 0 1 (toFloat p.received / toFloat n)



-- CUSTOM REQUESTS


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

-}
riskyRequest :
    { method : String
    , headers : List Header
    , url : String
    , body : Body
    , expect : Expect msg
    , timeout : Maybe Duration
    , tracker : Maybe String
    }
    -> Command restriction toMsg msg
riskyRequest r =
    case r.expect of
        ExpectString onResult ->
            HttpStringTask (requestHelper True r onResult) |> Effect.Internal.Task

        ExpectBytes onResult ->
            HttpBytesTask (requestHelper True r onResult) |> Effect.Internal.Task


requestHelper isRisky r onResult =
    { method = r.method
    , url = r.url
    , headers = r.headers
    , body = r.body
    , onRequestComplete = mapResponse >> onResult >> Effect.Task.succeed
    , timeout = r.timeout
    , isRisky = isRisky
    }


{-| Logic for interpreting a response body.
-}
type Expect msg
    = ExpectString (Response String -> msg)
    | ExpectBytes (Response Bytes -> msg)


{-| Expect the response body to be a `String`.
-}
expectString : (Result Error String -> msg) -> Expect msg
expectString onResult =
    ExpectString <|
        \response ->
            case response of
                BadUrl_ s ->
                    onResult (Err <| BadUrl s)

                Timeout_ ->
                    onResult (Err Timeout)

                NetworkError_ ->
                    onResult (Err NetworkError)

                BadStatus_ metadata body ->
                    onResult (Err <| BadStatus metadata.statusCode)

                GoodStatus_ _ body ->
                    onResult (Ok body)


{-| Expect a Response with a String body.
-}
expectStringResponse : (Result x a -> msg) -> (Response String -> Result x a) -> Expect msg
expectStringResponse toMsg onResponse =
    ExpectString (onResponse >> toMsg)


{-| Expect a [`Response`](#Response) with a `Bytes` body.

It works just like [`expectStringResponse`](#expectStringResponse), giving you
more access to headers and more leeway in defining your own errors.

-}
expectBytesResponse : (Result x a -> msg) -> (Response Bytes -> Result x a) -> Expect msg
expectBytesResponse toMsg onResponse =
    ExpectBytes (onResponse >> toMsg)


{-| Expect the response body to be JSON.
-}
expectJson : (Result Error a -> msg) -> Decoder a -> Expect msg
expectJson onResult decoder =
    ExpectString <|
        \response ->
            case response of
                BadUrl_ s ->
                    onResult (Err <| BadUrl s)

                Timeout_ ->
                    onResult (Err Timeout)

                NetworkError_ ->
                    onResult (Err NetworkError)

                BadStatus_ metadata _ ->
                    onResult (Err <| BadStatus metadata.statusCode)

                GoodStatus_ _ body ->
                    case Json.Decode.decodeString decoder body of
                        Err jsonError ->
                            onResult (Err <| BadBody <| Json.Decode.errorToString jsonError)

                        Ok value ->
                            onResult (Ok value)


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

-}
expectBytes : (Result Error a -> msg) -> Bytes.Decode.Decoder a -> Expect msg
expectBytes onResult decoder =
    ExpectBytes <|
        \response ->
            case response of
                BadUrl_ s ->
                    onResult (Err <| BadUrl s)

                Timeout_ ->
                    onResult (Err Timeout)

                NetworkError_ ->
                    onResult (Err NetworkError)

                BadStatus_ metadata _ ->
                    onResult (Err <| BadStatus metadata.statusCode)

                GoodStatus_ _ body ->
                    case Bytes.Decode.decode decoder body of
                        Nothing ->
                            onResult (Err <| BadBody "unexpected bytes")

                        Just value ->
                            onResult (Ok value)


{-| Expect the response body to be whatever.
-}
expectWhatever : (Result Error () -> msg) -> Expect msg
expectWhatever onResult =
    ExpectString <|
        \response ->
            case response of
                BadUrl_ s ->
                    onResult (Err <| BadUrl s)

                Timeout_ ->
                    onResult (Err Timeout)

                NetworkError_ ->
                    onResult (Err NetworkError)

                BadStatus_ metadata _ ->
                    onResult (Err <| BadStatus metadata.statusCode)

                GoodStatus_ _ _ ->
                    onResult (Ok ())


{-| A `Response` can come back a couple different ways:

  - `BadUrl_` means you did not provide a valid URL.
  - `Timeout_` means it took too long to get a response.
  - `NetworkError_` means the user turned off their wifi, went in a cave, etc.
  - `BadResponse_` means you got a response back, but the status code indicates failure.
  - `GoodResponse_` means you got a response back with a nice status code!

The type of the `body` depends on whether you use
[`expectStringResponse`](#expectStringResponse)
or [`expectBytesResponse`](#expectBytesResponse).

-}
type Response body
    = BadUrl_ String
    | Timeout_
    | NetworkError_
    | BadStatus_ Metadata body
    | GoodStatus_ Metadata body


{-| Extra information about the response:

  - `url` of the server that actually responded (so you can detect redirects)
  - `statusCode` like `200` or `404`
  - `statusText` describing what the `statusCode` means a little
  - `headers` like `Content-Length` and `Expires`

**Note:** It is possible for a response to have the same header multiple times.
In that case, all the values end up in a single entry in the `headers`
dictionary. The values are separated by commas, following the rules outlined
[here](https://stackoverflow.com/questions/4371328/are-duplicate-http-response-headers-acceptable).

-}
type alias Metadata =
    { url : String
    , statusCode : Int
    , statusText : String
    , headers : Dict String String
    }


{-| A `Request` can fail in a couple ways:

  - `BadUrl` means you did not provide a valid URL.
  - `Timeout` means it took too long to get a response.
  - `NetworkError` means the user turned off their wifi, went in a cave, etc.
  - `BadStatus` means you got a response back, but the status code indicates failure.
  - `BadBody` means you got a response back with a nice status code, but the body
    of the response was something unexpected. The `String` in this case is a
    debugging message that explains what went wrong with your JSON decoder or
    whatever.

**Note:** You can use [`expectStringResponse`](#expectStringResponse) and
[`expectBytesResponse`](#expectBytesResponse) to get more flexibility on this.

-}
type Error
    = BadUrl String
    | Timeout
    | NetworkError
    | BadStatus Int
    | BadBody String


{-| Just like [`request`](#request), but it creates a `Task`.
-}
task :
    { method : String
    , headers : List Header
    , url : String
    , body : Body
    , resolver : Resolver restriction x a
    , timeout : Maybe Duration
    }
    -> Task restriction x a
task r =
    case r.resolver of
        StringResolver f ->
            HttpStringTask
                { method = r.method
                , url = r.url
                , headers = r.headers
                , body = r.body
                , onRequestComplete = mapResponse >> f
                , timeout = r.timeout
                , isRisky = False
                }

        BytesResolver f ->
            HttpBytesTask
                { method = r.method
                , url = r.url
                , headers = r.headers
                , body = r.body
                , onRequestComplete = mapResponse >> f
                , timeout = r.timeout
                , isRisky = False
                }


{-| Describes how to resolve an HTTP task.
-}
type Resolver restriction x a
    = StringResolver (Response String -> Task restriction x a)
    | BytesResolver (Response Bytes -> Task restriction x a)


{-| Turn a response with a `String` body into a result.
-}
stringResolver : (Response String -> Result x a) -> Resolver restriction x a
stringResolver f =
    let
        fromResult result =
            case result of
                Err x ->
                    Effect.Task.fail x

                Ok a ->
                    Effect.Task.succeed a
    in
    StringResolver (f >> fromResult)


{-| Turn a response with a `Bytes` body into a result.
Similar to [`expectBytesResponse`](#expectBytesResponse).
-}
bytesResolver : (Response Bytes -> Result x a) -> Resolver restriction x a
bytesResolver f =
    let
        fromResult result =
            case result of
                Err x ->
                    Effect.Task.fail x

                Ok a ->
                    Effect.Task.succeed a
    in
    BytesResolver (f >> fromResult)


{-| Just like [`riskyRequest`](#riskyRequest), but it creates a `Task`. **Use
with caution!** This has all the same security concerns as `riskyRequest`.
-}
riskyTask :
    { method : String
    , headers : List Header
    , url : String
    , body : Body
    , resolver : Resolver restriction x a
    , timeout : Maybe Duration
    }
    -> Task restriction x a
riskyTask r =
    case r.resolver of
        StringResolver f ->
            HttpStringTask
                { method = r.method
                , url = r.url
                , headers = r.headers
                , body = r.body
                , onRequestComplete = mapResponse >> f
                , timeout = r.timeout
                , isRisky = True
                }

        BytesResolver f ->
            HttpBytesTask
                { method = r.method
                , url = r.url
                , headers = r.headers
                , body = r.body
                , onRequestComplete = mapResponse >> f
                , timeout = r.timeout
                , isRisky = True
                }
