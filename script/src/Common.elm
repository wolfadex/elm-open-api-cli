module Common exposing (TypeName(..), intToWord, toValueName, typifyName)

import String.Extra


intToWord : Int -> Result String String
intToWord i =
    case i of
        1 ->
            Ok "one"

        2 ->
            Ok "two"

        3 ->
            Ok "three"

        4 ->
            Ok "four"

        5 ->
            Ok "five"

        6 ->
            Ok "six"

        7 ->
            Ok "seven"

        8 ->
            Ok "eight"

        9 ->
            Ok "nine"

        10 ->
            Ok "ten"

        11 ->
            Ok "eleven"

        12 ->
            Ok "twelve"

        13 ->
            Ok "thirteen"

        14 ->
            Ok "fourteen"

        15 ->
            Ok "fifteen"

        16 ->
            Ok "sixteen"

        17 ->
            Ok "seventeen"

        18 ->
            Ok "eighteen"

        19 ->
            Ok "nineteen"

        _ ->
            if i < 0 then
                Err "Negative numbers aren't supported"

            else if i == 0 then
                Err "Zero isn't supported"

            else if i == 20 then
                Ok "twenty"

            else if i < 30 then
                intToWord (i - 20)
                    |> Result.map (\ones -> "twenty-" ++ ones)

            else if i == 30 then
                Ok "thirty"

            else if i < 40 then
                intToWord (i - 30)
                    |> Result.map (\ones -> "thirty-" ++ ones)

            else if i == 40 then
                Ok "forty"

            else if i < 50 then
                intToWord (i - 40)
                    |> Result.map (\ones -> "forty-" ++ ones)

            else if i == 50 then
                Ok "fifty"

            else if i < 60 then
                intToWord (i - 50)
                    |> Result.map (\ones -> "fifty-" ++ ones)

            else if i == 60 then
                Ok "sixty"

            else if i < 70 then
                intToWord (i - 60)
                    |> Result.map (\ones -> "sixty-" ++ ones)

            else if i == 70 then
                Ok "seventy"

            else if i < 80 then
                intToWord (i - 70)
                    |> Result.map (\ones -> "seventy-" ++ ones)

            else if i == 80 then
                Ok "eighty"

            else if i < 90 then
                intToWord (i - 80)
                    |> Result.map (\ones -> "eighty-" ++ ones)

            else if i == 90 then
                Ok "ninety"

            else if i < 100 then
                intToWord (i - 90)
                    |> Result.map (\ones -> "ninety-" ++ ones)

            else
                Err ("Numbers larger than 99 aren't currently supported and I got an " ++ String.fromInt i)



-- Names adaptation --


type TypeName
    = TypeName String


typifyName : String -> TypeName
typifyName name =
    name
        |> String.uncons
        |> Maybe.map (\( first, rest ) -> String.cons first (String.replace "-" " " rest))
        |> Maybe.withDefault ""
        |> String.replace "_" " "
        |> String.Extra.toTitleCase
        |> String.replace " " ""
        |> deSymbolify
        |> TypeName


{-| Sometimes a word in the schema contains invalid characers for an Elm name.
We don't want to completely remove them though.
-}
deSymbolify : String -> String
deSymbolify str =
    str
        |> String.replace "+" "Plus"
        |> String.replace "-" "Minus"


{-| Convert into a name suitable to be used in Elm as a variable.
-}
toValueName : String -> String
toValueName name =
    name
        |> deSymbolify
        |> String.uncons
        |> Maybe.map (\( first, rest ) -> String.cons (Char.toLower first) (String.replace "-" "_" rest))
        |> Maybe.withDefault ""
