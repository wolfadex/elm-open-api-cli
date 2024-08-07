module TestCommon exposing (toTypeName, toTypeNameIdempotence, toTypeNameSafety, toValueName, toValueNameIdempotence, toValueNameSafety)

import Common
import Expect
import Fuzz
import Json.Encode
import Set exposing (Set)
import Test
import Unicode


toValueName : Test.Test
toValueName =
    Test.describe "toValueName"
        [ toValueNameTest "-1" "minus1"
        , toValueNameTest "+1" "plus1"
        , toValueNameTest "$" "dollar__"
        , toValueNameTest "$res" "res"
        , toValueNameTest "" "empty__"
        , toValueNameTest "$___" "empty__"
        , toValueNameTest "X-API-KEY" "x_API_KEY"
        , toValueNameTest "PASVersion" "pasVersion"
        , toValueNameTest "MACOS" "macos"
        , toValueNameTest "SHA256" "sha256"
        , toValueNameTest "SHA256-DSA" "sha256_DSA"
        , toValueNameTest "decode-not-found" "decode_not_found"
        , toValueNameTest "not_found" "not_found"
        , toValueNameTest "PAS (2013)" "pas__2013_"
        ]


toTypeName : Test.Test
toTypeName =
    Test.describe "toTypeName"
        [ toTypeNameTest "-1" "Minus1"
        , toTypeNameTest "+1" "Plus1"
        , toTypeNameTest "$" "Dollar__"
        , toTypeNameTest "$res" "Res"
        , toTypeNameTest "" "Empty__"
        , toTypeNameTest "$___" "Dollar__"
        , toTypeNameTest "X-API-KEY" "XAPIKEY"
        , toTypeNameTest "PASVersion" "PASVersion"
        , toTypeNameTest "MACOS" "MACOS"
        , toTypeNameTest "SHA256" "SHA256"
        , toTypeNameTest "SHA256-DSA" "SHA256DSA"
        , toTypeNameTest "not-found" "NotFound"
        , toTypeNameTest "not_found" "NotFound"
        , toTypeNameTest "PAS (2013)" "PAS2013"
        ]


toTypeNameIdempotence : Test.Test
toTypeNameIdempotence =
    Test.fuzz Fuzz.string "toTypeName is idempotent" <|
        \input ->
            let
                typed : String
                typed =
                    input
                        |> Common.UnsafeName
                        |> Common.toTypeName
            in
            if typed == "Empty__" then
                Expect.pass

            else
                typed
                    |> Common.UnsafeName
                    |> Common.toTypeName
                    |> Expect.equal typed


toTypeNameSafety : Test.Test
toTypeNameSafety =
    Test.fuzz Fuzz.string "toTypeName produces a valid identifier" <|
        \input ->
            let
                typed : String
                typed =
                    input
                        |> Common.UnsafeName
                        |> Common.toTypeName
            in
            if Set.member typed reservedList then
                Expect.fail "Invalid identifier: reserved word"

            else
                case String.toList typed of
                    [] ->
                        Expect.fail "Invalid identifier: it is empty"

                    head :: tail ->
                        if isUpper head && List.all isAlphaNumOrUnderscore tail then
                            Expect.pass

                        else
                            Expect.fail ("Invalid type name " ++ escape typed)


toValueNameIdempotence : Test.Test
toValueNameIdempotence =
    Test.fuzz Fuzz.string "toValueName is idempotent" <|
        \input ->
            let
                typed : String
                typed =
                    input
                        |> Common.UnsafeName
                        |> Common.toValueName
            in
            typed
                |> Common.UnsafeName
                |> Common.toValueName
                |> Expect.equal typed


toValueNameSafety : Test.Test
toValueNameSafety =
    Test.fuzz Fuzz.string "toValueName produces a valid identifier" <|
        \input ->
            let
                typed : String
                typed =
                    input
                        |> Common.UnsafeName
                        |> Common.toValueName
            in
            if Set.member typed reservedList then
                Expect.fail "Invalid identifier: reserved word"

            else
                case String.toList typed of
                    [] ->
                        Expect.fail "Invalid identifier: it is empty"

                    head :: tail ->
                        if isLower head && List.all isAlphaNumOrUnderscore tail then
                            Expect.pass

                        else
                            Expect.fail ("Invalid value name " ++ escape typed)


reservedList : Set String
reservedList =
    -- Copied from elm-syntax
    [ "module"
    , "exposing"
    , "import"
    , "as"
    , "if"
    , "then"
    , "else"
    , "let"
    , "in"
    , "case"
    , "of"
    , "port"
    , "type"
    , "where"
    ]
        |> Set.fromList


isUpper : Char -> Bool
isUpper c =
    Char.isUpper c || Unicode.isUpper c


isLower : Char -> Bool
isLower c =
    Char.isLower c || Unicode.isLower c


isAlphaNumOrUnderscore : Char -> Bool
isAlphaNumOrUnderscore c =
    Char.isAlphaNum c || c == '_' || Unicode.isAlphaNum c


escape : String -> String
escape input =
    Json.Encode.encode 0 (Json.Encode.string input)


toValueNameTest : String -> String -> Test.Test
toValueNameTest from to =
    Test.test ("\"" ++ from ++ "\" becomes value name " ++ to) <|
        \_ ->
            from
                |> Common.UnsafeName
                |> Common.toValueName
                |> Expect.equal to


toTypeNameTest : String -> String -> Test.Test
toTypeNameTest from to =
    Test.test ("\"" ++ from ++ "\" becomes type name " ++ to) <|
        \_ ->
            from
                |> Common.UnsafeName
                |> Common.toTypeName
                |> Expect.equal to
