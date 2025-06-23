module Data.Id exposing
    ( Id
    , MessageId
    , ThreadId
    , UserId
    , decode
    , encode
    , parse
    , test_fromString
    , toString
    )

{-| Defines opaque Id types for each kind of API entity
-}

import Data.Id.Internal
    exposing
        (MessageTag
        , ThreadTag
        , UserTag
        )
import Json.Decode
import Json.Encode
import Regex exposing (Regex)
import Time


type Id kind
    = Id String



-- ID TYPES


type alias MessageId =
    Id MessageTag


type alias ThreadId =
    Id ThreadTag


type alias UserId =
    Id UserTag


toString : Id kind -> String
toString (Id id) =
    id


decode : Json.Decode.Decoder (Id kind)
decode =
    Json.Decode.string |> Json.Decode.map Id


invalidIdPattern : Regex
invalidIdPattern =
    Regex.fromString "[^a-z0-9-]"
        |> Maybe.withDefault Regex.never


parse : String -> Result String (Id kind)
parse raw =
    case raw of
        "" ->
            Err "Empty id"

        nonEmpty ->
            if Regex.contains invalidIdPattern nonEmpty then
                Err "Id contains invalid characters"

            else
                Ok (Id nonEmpty)


encode : Id kind -> Json.Encode.Value
encode (Id id) =
    Json.Encode.string id


test_fromString : String -> Id kind
test_fromString id =
    Id id
