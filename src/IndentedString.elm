module IndentedString exposing (IndentedString, fromString, indent, listItem, toString)


type IndentedString
    = IndentedString Int String


fromString : String -> List IndentedString
fromString input =
    input
        |> String.lines
        |> List.map (IndentedString 0)


indent : Int -> List IndentedString -> List IndentedString
indent i ls =
    List.map (\(IndentedString j l) -> IndentedString (i + j) l) ls


toString : List IndentedString -> String
toString ls =
    ls
        |> List.map (\(IndentedString i l) -> String.repeat i " " ++ l)
        |> String.join "\n"


listItem : String -> List IndentedString -> List IndentedString
listItem s ls =
    case ls of
        [] ->
            []

        (IndentedString j h) :: t ->
            IndentedString j (s ++ " " ++ h)
                :: indent (String.length s + 1) t
