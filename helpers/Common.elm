module OpenApi.Common exposing
    ( Nullable(..)
    , decodeOptionalField, jsonDecodeAndMap
    , Error(..), bytesResolverCustom, bytesResolverCustomEffect, expectBytesCustom, expectBytesCustomEffect
    , expectJsonCustom, expectJsonCustomEffect, expectStringCustom, expectStringCustomEffect, jsonResolverCustom
    , jsonResolverCustomEffect, stringResolverCustom, stringResolverCustomEffect
    )

{-|


## Types

@docs Nullable


## Decoders

@docs decodeOptionalField, jsonDecodeAndMap


## Http

@docs Error, bytesResolverCustom, bytesResolverCustomEffect, expectBytesCustom, expectBytesCustomEffect
@docs expectJsonCustom, expectJsonCustomEffect, expectStringCustom, expectStringCustomEffect, jsonResolverCustom
@docs jsonResolverCustomEffect, stringResolverCustom, stringResolverCustomEffect

-}

import Bytes
import Bytes.Decode
import Dict
import Effect.Http
import Http
import Json.Decode


expectJsonCustom :
    (Result (Error err String) success -> msg)
    -> Dict.Dict String (Json.Decode.Decoder err)
    -> Json.Decode.Decoder success
    -> Http.Expect msg
expectJsonCustom toMsg errorDecoders successDecoder =
    Http.expectStringResponse
        toMsg
        (\expectStringResponseUnpack ->
            case expectStringResponseUnpack of
                Http.BadUrl_ stringString ->
                    Result.Err (BadUrl stringString)

                Http.Timeout_ ->
                    Result.Err Timeout

                Http.NetworkError_ ->
                    Result.Err NetworkError

                Http.BadStatus_ httpMetadata body ->
                    case
                        Dict.get
                            (String.fromInt httpMetadata.statusCode)
                            errorDecoders
                    of
                        Maybe.Just a ->
                            case Json.Decode.decodeString a body of
                                Result.Ok value ->
                                    Result.Err
                                        (KnownBadStatus
                                            httpMetadata.statusCode
                                            value
                                        )

                                Result.Err error ->
                                    Result.Err (BadErrorBody httpMetadata body)

                        Maybe.Nothing ->
                            Result.Err (UnknownBadStatus httpMetadata body)

                Http.GoodStatus_ httpMetadata body ->
                    case Json.Decode.decodeString successDecoder body of
                        Result.Ok value ->
                            Result.Ok value

                        Result.Err error ->
                            Result.Err (BadBody httpMetadata body)
        )


jsonResolverCustom :
    Dict.Dict String (Json.Decode.Decoder err)
    -> Json.Decode.Decoder success
    -> Http.Resolver (Error err String) success
jsonResolverCustom errorDecoders successDecoder =
    Http.stringResolver
        (\stringResolverUnpack ->
            case stringResolverUnpack of
                Http.BadUrl_ stringString ->
                    Result.Err (BadUrl stringString)

                Http.Timeout_ ->
                    Result.Err Timeout

                Http.NetworkError_ ->
                    Result.Err NetworkError

                Http.BadStatus_ httpMetadata body ->
                    case
                        Dict.get
                            (String.fromInt httpMetadata.statusCode)
                            errorDecoders
                    of
                        Maybe.Just a ->
                            case Json.Decode.decodeString a body of
                                Result.Ok value ->
                                    Result.Err
                                        (KnownBadStatus
                                            httpMetadata.statusCode
                                            value
                                        )

                                Result.Err error ->
                                    Result.Err (BadErrorBody httpMetadata body)

                        Maybe.Nothing ->
                            Result.Err (UnknownBadStatus httpMetadata body)

                Http.GoodStatus_ httpMetadata body ->
                    case Json.Decode.decodeString successDecoder body of
                        Result.Ok value ->
                            Result.Ok value

                        Result.Err error ->
                            Result.Err (BadBody httpMetadata body)
        )


expectStringCustom :
    (Result (Error err String) String -> msg)
    -> Dict.Dict String (Json.Decode.Decoder err)
    -> Http.Expect msg
expectStringCustom toMsg errorDecoders =
    Http.expectStringResponse
        toMsg
        (\expectStringResponseUnpack ->
            case expectStringResponseUnpack of
                Http.BadUrl_ stringString ->
                    Result.Err (BadUrl stringString)

                Http.Timeout_ ->
                    Result.Err Timeout

                Http.NetworkError_ ->
                    Result.Err NetworkError

                Http.BadStatus_ httpMetadata body ->
                    case
                        Dict.get
                            (String.fromInt httpMetadata.statusCode)
                            errorDecoders
                    of
                        Maybe.Just a ->
                            case Json.Decode.decodeString a body of
                                Result.Ok value ->
                                    Result.Err
                                        (KnownBadStatus
                                            httpMetadata.statusCode
                                            value
                                        )

                                Result.Err error ->
                                    Result.Err (BadErrorBody httpMetadata body)

                        Maybe.Nothing ->
                            Result.Err (UnknownBadStatus httpMetadata body)

                Http.GoodStatus_ httpMetadata body ->
                    Result.Ok body
        )


stringResolverCustom :
    Dict.Dict String (Json.Decode.Decoder err)
    -> Http.Resolver (Error err String) String
stringResolverCustom errorDecoders =
    Http.stringResolver
        (\stringResolverUnpack ->
            case stringResolverUnpack of
                Http.BadUrl_ stringString ->
                    Result.Err (BadUrl stringString)

                Http.Timeout_ ->
                    Result.Err Timeout

                Http.NetworkError_ ->
                    Result.Err NetworkError

                Http.BadStatus_ httpMetadata body ->
                    case
                        Dict.get
                            (String.fromInt httpMetadata.statusCode)
                            errorDecoders
                    of
                        Maybe.Just a ->
                            case Json.Decode.decodeString a body of
                                Result.Ok value ->
                                    Result.Err
                                        (KnownBadStatus
                                            httpMetadata.statusCode
                                            value
                                        )

                                Result.Err error ->
                                    Result.Err (BadErrorBody httpMetadata body)

                        Maybe.Nothing ->
                            Result.Err (UnknownBadStatus httpMetadata body)

                Http.GoodStatus_ httpMetadata body ->
                    Result.Ok body
        )


expectBytesCustom :
    (Result (Error err Bytes.Bytes) Bytes.Bytes -> msg)
    -> Dict.Dict String (Json.Decode.Decoder err)
    -> Http.Expect msg
expectBytesCustom toMsg errorDecoders =
    Http.expectBytesResponse
        toMsg
        (\expectBytesResponseUnpack ->
            case expectBytesResponseUnpack of
                Http.BadUrl_ stringString ->
                    Result.Err (BadUrl stringString)

                Http.Timeout_ ->
                    Result.Err Timeout

                Http.NetworkError_ ->
                    Result.Err NetworkError

                Http.BadStatus_ httpMetadata body ->
                    case
                        Dict.get
                            (String.fromInt httpMetadata.statusCode)
                            errorDecoders
                    of
                        Maybe.Just a ->
                            case
                                Json.Decode.decodeString
                                    a
                                    (Maybe.withDefault
                                        ""
                                        (Bytes.Decode.decode
                                            (Bytes.Decode.string
                                                (Bytes.width body)
                                            )
                                            body
                                        )
                                    )
                            of
                                Result.Ok value ->
                                    Result.Err
                                        (KnownBadStatus
                                            httpMetadata.statusCode
                                            value
                                        )

                                Result.Err error ->
                                    Result.Err (BadErrorBody httpMetadata body)

                        Maybe.Nothing ->
                            Result.Err (UnknownBadStatus httpMetadata body)

                Http.GoodStatus_ httpMetadata body ->
                    Result.Ok body
        )


bytesResolverCustom :
    Dict.Dict String (Json.Decode.Decoder err)
    -> Http.Resolver (Error err Bytes.Bytes) Bytes.Bytes
bytesResolverCustom errorDecoders =
    Http.bytesResolver
        (\bytesResolverUnpack ->
            case bytesResolverUnpack of
                Http.BadUrl_ stringString ->
                    Result.Err (BadUrl stringString)

                Http.Timeout_ ->
                    Result.Err Timeout

                Http.NetworkError_ ->
                    Result.Err NetworkError

                Http.BadStatus_ httpMetadata body ->
                    case
                        Dict.get
                            (String.fromInt httpMetadata.statusCode)
                            errorDecoders
                    of
                        Maybe.Just a ->
                            case
                                Json.Decode.decodeString
                                    a
                                    (Maybe.withDefault
                                        ""
                                        (Bytes.Decode.decode
                                            (Bytes.Decode.string
                                                (Bytes.width body)
                                            )
                                            body
                                        )
                                    )
                            of
                                Result.Ok value ->
                                    Result.Err
                                        (KnownBadStatus
                                            httpMetadata.statusCode
                                            value
                                        )

                                Result.Err error ->
                                    Result.Err (BadErrorBody httpMetadata body)

                        Maybe.Nothing ->
                            Result.Err (UnknownBadStatus httpMetadata body)

                Http.GoodStatus_ httpMetadata body ->
                    Result.Ok body
        )


expectJsonCustomEffect :
    (Result (Error err String) success -> msg)
    -> Dict.Dict String (Json.Decode.Decoder err)
    -> Json.Decode.Decoder success
    -> Effect.Http.Expect msg
expectJsonCustomEffect toMsg errorDecoders successDecoder =
    Effect.Http.expectStringResponse
        toMsg
        (\expectStringResponseUnpack ->
            case expectStringResponseUnpack of
                Effect.Http.BadUrl_ stringString ->
                    Result.Err (BadUrl stringString)

                Effect.Http.Timeout_ ->
                    Result.Err Timeout

                Effect.Http.NetworkError_ ->
                    Result.Err NetworkError

                Effect.Http.BadStatus_ effectHttpMetadata body ->
                    case
                        Dict.get
                            (String.fromInt effectHttpMetadata.statusCode)
                            errorDecoders
                    of
                        Maybe.Just a ->
                            case Json.Decode.decodeString a body of
                                Result.Ok value ->
                                    Result.Err
                                        (KnownBadStatus
                                            effectHttpMetadata.statusCode
                                            value
                                        )

                                Result.Err error ->
                                    Result.Err
                                        (BadErrorBody effectHttpMetadata body)

                        Maybe.Nothing ->
                            Result.Err
                                (UnknownBadStatus effectHttpMetadata body)

                Effect.Http.GoodStatus_ effectHttpMetadata body ->
                    case Json.Decode.decodeString successDecoder body of
                        Result.Ok value ->
                            Result.Ok value

                        Result.Err error ->
                            Result.Err (BadBody effectHttpMetadata body)
        )


jsonResolverCustomEffect :
    Dict.Dict String (Json.Decode.Decoder err)
    -> Json.Decode.Decoder success
    -> Effect.Http.Resolver restrictions (Error err String) success
jsonResolverCustomEffect errorDecoders successDecoder =
    Effect.Http.stringResolver
        (\stringResolverUnpack ->
            case stringResolverUnpack of
                Effect.Http.BadUrl_ stringString ->
                    Result.Err (BadUrl stringString)

                Effect.Http.Timeout_ ->
                    Result.Err Timeout

                Effect.Http.NetworkError_ ->
                    Result.Err NetworkError

                Effect.Http.BadStatus_ effectHttpMetadata body ->
                    case
                        Dict.get
                            (String.fromInt effectHttpMetadata.statusCode)
                            errorDecoders
                    of
                        Maybe.Just a ->
                            case Json.Decode.decodeString a body of
                                Result.Ok value ->
                                    Result.Err
                                        (KnownBadStatus
                                            effectHttpMetadata.statusCode
                                            value
                                        )

                                Result.Err error ->
                                    Result.Err
                                        (BadErrorBody effectHttpMetadata body)

                        Maybe.Nothing ->
                            Result.Err
                                (UnknownBadStatus effectHttpMetadata body)

                Effect.Http.GoodStatus_ effectHttpMetadata body ->
                    case Json.Decode.decodeString successDecoder body of
                        Result.Ok value ->
                            Result.Ok value

                        Result.Err error ->
                            Result.Err (BadBody effectHttpMetadata body)
        )


expectStringCustomEffect :
    (Result (Error err String) String -> msg)
    -> Dict.Dict String (Json.Decode.Decoder err)
    -> Effect.Http.Expect msg
expectStringCustomEffect toMsg errorDecoders =
    Effect.Http.expectStringResponse
        toMsg
        (\expectStringResponseUnpack ->
            case expectStringResponseUnpack of
                Effect.Http.BadUrl_ stringString ->
                    Result.Err (BadUrl stringString)

                Effect.Http.Timeout_ ->
                    Result.Err Timeout

                Effect.Http.NetworkError_ ->
                    Result.Err NetworkError

                Effect.Http.BadStatus_ effectHttpMetadata body ->
                    case
                        Dict.get
                            (String.fromInt effectHttpMetadata.statusCode)
                            errorDecoders
                    of
                        Maybe.Just a ->
                            case Json.Decode.decodeString a body of
                                Result.Ok value ->
                                    Result.Err
                                        (KnownBadStatus
                                            effectHttpMetadata.statusCode
                                            value
                                        )

                                Result.Err error ->
                                    Result.Err
                                        (BadErrorBody effectHttpMetadata body)

                        Maybe.Nothing ->
                            Result.Err
                                (UnknownBadStatus effectHttpMetadata body)

                Effect.Http.GoodStatus_ effectHttpMetadata body ->
                    Result.Ok body
        )


stringResolverCustomEffect :
    Dict.Dict String (Json.Decode.Decoder err)
    -> Effect.Http.Resolver restrictions (Error err String) String
stringResolverCustomEffect errorDecoders =
    Effect.Http.stringResolver
        (\stringResolverUnpack ->
            case stringResolverUnpack of
                Effect.Http.BadUrl_ stringString ->
                    Result.Err (BadUrl stringString)

                Effect.Http.Timeout_ ->
                    Result.Err Timeout

                Effect.Http.NetworkError_ ->
                    Result.Err NetworkError

                Effect.Http.BadStatus_ effectHttpMetadata body ->
                    case
                        Dict.get
                            (String.fromInt effectHttpMetadata.statusCode)
                            errorDecoders
                    of
                        Maybe.Just a ->
                            case Json.Decode.decodeString a body of
                                Result.Ok value ->
                                    Result.Err
                                        (KnownBadStatus
                                            effectHttpMetadata.statusCode
                                            value
                                        )

                                Result.Err error ->
                                    Result.Err
                                        (BadErrorBody effectHttpMetadata body)

                        Maybe.Nothing ->
                            Result.Err
                                (UnknownBadStatus effectHttpMetadata body)

                Effect.Http.GoodStatus_ effectHttpMetadata body ->
                    Result.Ok body
        )


expectBytesCustomEffect :
    (Result (Error err Bytes.Bytes) Bytes.Bytes -> msg)
    -> Dict.Dict String (Json.Decode.Decoder err)
    -> Effect.Http.Expect msg
expectBytesCustomEffect toMsg errorDecoders =
    Effect.Http.expectBytesResponse
        toMsg
        (\expectBytesResponseUnpack ->
            case expectBytesResponseUnpack of
                Effect.Http.BadUrl_ stringString ->
                    Result.Err (BadUrl stringString)

                Effect.Http.Timeout_ ->
                    Result.Err Timeout

                Effect.Http.NetworkError_ ->
                    Result.Err NetworkError

                Effect.Http.BadStatus_ effectHttpMetadata body ->
                    case
                        Dict.get
                            (String.fromInt effectHttpMetadata.statusCode)
                            errorDecoders
                    of
                        Maybe.Just a ->
                            case
                                Json.Decode.decodeString
                                    a
                                    (Maybe.withDefault
                                        ""
                                        (Bytes.Decode.decode
                                            (Bytes.Decode.string
                                                (Bytes.width body)
                                            )
                                            body
                                        )
                                    )
                            of
                                Result.Ok value ->
                                    Result.Err
                                        (KnownBadStatus
                                            effectHttpMetadata.statusCode
                                            value
                                        )

                                Result.Err error ->
                                    Result.Err
                                        (BadErrorBody effectHttpMetadata body)

                        Maybe.Nothing ->
                            Result.Err
                                (UnknownBadStatus effectHttpMetadata body)

                Effect.Http.GoodStatus_ effectHttpMetadata body ->
                    Result.Ok body
        )


bytesResolverCustomEffect :
    Dict.Dict String (Json.Decode.Decoder err)
    -> Effect.Http.Resolver restrictions (Error err Bytes.Bytes) Bytes.Bytes
bytesResolverCustomEffect errorDecoders =
    Effect.Http.bytesResolver
        (\bytesResolverUnpack ->
            case bytesResolverUnpack of
                Effect.Http.BadUrl_ stringString ->
                    Result.Err (BadUrl stringString)

                Effect.Http.Timeout_ ->
                    Result.Err Timeout

                Effect.Http.NetworkError_ ->
                    Result.Err NetworkError

                Effect.Http.BadStatus_ effectHttpMetadata body ->
                    case
                        Dict.get
                            (String.fromInt effectHttpMetadata.statusCode)
                            errorDecoders
                    of
                        Maybe.Just a ->
                            case
                                Json.Decode.decodeString
                                    a
                                    (Maybe.withDefault
                                        ""
                                        (Bytes.Decode.decode
                                            (Bytes.Decode.string
                                                (Bytes.width body)
                                            )
                                            body
                                        )
                                    )
                            of
                                Result.Ok value ->
                                    Result.Err
                                        (KnownBadStatus
                                            effectHttpMetadata.statusCode
                                            value
                                        )

                                Result.Err error ->
                                    Result.Err
                                        (BadErrorBody effectHttpMetadata body)

                        Maybe.Nothing ->
                            Result.Err
                                (UnknownBadStatus effectHttpMetadata body)

                Effect.Http.GoodStatus_ effectHttpMetadata body ->
                    Result.Ok body
        )


{-| Decode an optional field

    decodeString (decodeOptionalField "x" int) "{ "x": 3 }"
    --> Ok (Just 3)

    decodeString (decodeOptionalField "x" int) "{ "x": true }"
    --> Err ...

    decodeString (decodeOptionalField "x" int) "{ "y": 4 }"
    --> Ok Nothing

-}
decodeOptionalField : String -> Json.Decode.Decoder t -> Json.Decode.Decoder (Maybe t)
decodeOptionalField key fieldDecoder =
    Json.Decode.andThen
        (\andThenUnpack ->
            if andThenUnpack then
                Json.Decode.field
                    key
                    (Json.Decode.oneOf
                        [ Json.Decode.map Just fieldDecoder
                        , Json.Decode.null Nothing
                        ]
                    )

            else
                Json.Decode.succeed Nothing
        )
        (Json.Decode.oneOf
            [ Json.Decode.map
                (\_ -> True)
                (Json.Decode.field key Json.Decode.value)
            , Json.Decode.succeed False
            ]
        )


{-| Chain JSON decoders, when `Json.Decode.map8` isn't enough.
-}
jsonDecodeAndMap :
    Json.Decode.Decoder a
    -> Json.Decode.Decoder (a -> value)
    -> Json.Decode.Decoder value
jsonDecodeAndMap =
    Json.Decode.map2 (|>)


type Error err body
    = BadUrl String
    | Timeout
    | NetworkError
    | KnownBadStatus Int err
    | UnknownBadStatus Http.Metadata body
    | BadErrorBody Http.Metadata body
    | BadBody Http.Metadata body


type Nullable value
    = Null
    | Present value
