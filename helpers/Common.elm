module OpenApi.Common exposing
    ( Nullable(..)
    , decodeOptionalField, jsonDecodeAndMap
    , Error(..), expectJsonCustom, jsonResolverCustom
    )

{-|


## Types

@docs Nullable


## Decoders

@docs decodeOptionalField, jsonDecodeAndMap


## Http

@docs Error, expectJsonCustom, jsonResolverCustom

-}

import Dict
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
                Http.BadUrl_ url ->
                    Result.Err (BadUrl url)

                Http.Timeout_ ->
                    Result.Err Timeout

                Http.NetworkError_ ->
                    Result.Err NetworkError

                Http.BadStatus_ metadata body ->
                    case
                        Dict.get
                            (String.fromInt metadata.statusCode)
                            errorDecoders
                    of
                        Maybe.Just a ->
                            case Json.Decode.decodeString a body of
                                Result.Ok value ->
                                    Result.Err
                                        (KnownBadStatus
                                            metadata.statusCode
                                            value
                                        )

                                Result.Err error ->
                                    Result.Err (BadErrorBody metadata body)

                        Maybe.Nothing ->
                            Result.Err (UnknownBadStatus metadata body)

                Http.GoodStatus_ metadata body ->
                    case Json.Decode.decodeString successDecoder body of
                        Result.Ok value ->
                            Result.Ok value

                        Result.Err error ->
                            Result.Err (BadBody metadata body)
        )


{-| {-| Decode an optional field

    decodeString (decodeOptionalField "x" int) "{ "x": 3 }"
    --> Ok (Just 3)

    decodeString (decodeOptionalField "x" int) "{ "x": true }"
    --> Err ...

    decodeString (decodeOptionalField "x" int) "{ "y": 4 }"
    --> Ok Nothing

-}

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
