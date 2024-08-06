module TestCommon exposing (suite)

import Common
import Expect
import Test


suite : Test.Test
suite =
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
        ]


toValueNameTest : String -> String -> Test.Test
toValueNameTest from to =
    Test.test ("\"" ++ from ++ "\" becomes " ++ to) <|
        \_ ->
            from
                |> Common.UnsafeName
                |> Common.toValueName
                |> Expect.equal to
