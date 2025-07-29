module ArticleId exposing
    ( ArticleId
    , decode
    , encode
    , parse
    , toString
    )

{-| Defines an opaque Id type for Articles
-}

import Json.Decode
import Json.Encode


type ArticleId
    = ArticleId String


toString : ArticleId -> String
toString (ArticleId id) =
    id


parse : String -> Result String ArticleId
parse raw =
    if String.isEmpty raw then
        Err "Article id must not be empty"

    else if String.contains "%" raw then
        -- Just an example ID format rule
        Err "Article id must not contain % character"

    else
        Ok (ArticleId raw)


decode : Json.Decode.Decoder ArticleId
decode =
    Json.Decode.map ArticleId Json.Decode.string


encode : ArticleId -> Json.Encode.Value
encode (ArticleId id) =
    Json.Encode.string id
