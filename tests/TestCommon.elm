module TestCommon exposing (toTypeName, toValueName)

import Common
import Expect
import Test


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
        ]


toTypeName : Test.Test
toTypeName =
    Test.describe "toTypeName"
        [ toTypeNameTest "-1" "Minus1"
        , toTypeNameTest "+1" "Plus1"
        , toTypeNameTest "$" "Dollar"
        , toTypeNameTest "$res" "Res"
        , toTypeNameTest "" "Empty"
        , toTypeNameTest "$___" "Empty"
        , toTypeNameTest "X-API-KEY" "XAPIKEY"
        , toTypeNameTest "PASVersion" "PASVersion"
        , toTypeNameTest "MACOS" "MACOS"
        , toTypeNameTest "SHA256" "SHA256"
        , toTypeNameTest "SHA256-DSA" "SHA256DSA"
        , toTypeNameTest "not-found" "NotFound"
        , toTypeNameTest "not_found" "NotFound"
        ]


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
