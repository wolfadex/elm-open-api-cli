module Utils exposing (sanitizeModuleName)

import String.Extra
import Util.List


sanitizeModuleName : String -> Maybe String
sanitizeModuleName str =
    let
        finalName : String
        finalName =
            String.filter
                (\char ->
                    Char.isAlphaNum char
                        || (let
                                code : Int
                                code =
                                    Char.toCode char
                            in
                            (code == {- '_' -} 95)
                                || (code == {- '-' -} 45)
                                || (code == {- ' ' -} 32)
                                || (code == {- ':' -} 58)
                           )
                )
                str
                |> String.replace "_" " "
                |> String.replace "-" " "
                |> String.replace ":" " "
                |> String.words
                |> Util.List.mapFirst numberToString
                |> List.map (\word -> word |> String.toLower |> String.Extra.toSentenceCase)
                |> String.concat
    in
    if String.isEmpty finalName then
        Nothing

    else
        Just finalName


numberToString : String -> String
numberToString str =
    case String.uncons str of
        Just ( first, rest ) ->
            case first of
                '0' ->
                    "Zero" ++ rest

                '1' ->
                    "One" ++ rest

                '2' ->
                    "Two" ++ rest

                '3' ->
                    "Three" ++ rest

                '4' ->
                    "Four" ++ rest

                '5' ->
                    "Five" ++ rest

                '6' ->
                    "Six" ++ rest

                '7' ->
                    "Seven" ++ rest

                '8' ->
                    "Eight" ++ rest

                '9' ->
                    "Nine" ++ rest

                _ ->
                    str

        Nothing ->
            str
