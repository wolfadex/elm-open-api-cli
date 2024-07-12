module Common exposing
    ( Field
    , FieldName
    , Module(..)
    , Object
    , OneOfData
    , Type(..)
    , TypeName
    , VariantName
    , moduleToNamespace
    , ref
    , toValueName
    , typifyName
    )

import FastDict
import String.Extra


type Module
    = Json
    | Types
    | Api
    | Common
    | Servers


moduleToNamespace : List String -> Module -> List String
moduleToNamespace namespace module_ =
    case module_ of
        Json ->
            namespace ++ [ "Json" ]

        Types ->
            namespace ++ [ "Types" ]

        Api ->
            namespace ++ [ "Api" ]

        Servers ->
            namespace ++ [ "Servers" ]

        Common ->
            [ "OpenApi", "Common" ]



-- Names adaptation --


typifyName : String -> TypeName
typifyName name =
    name
        |> nameFromStatusCode
        |> String.uncons
        |> Maybe.map (\( first, rest ) -> String.cons first (String.replace "-" " " rest))
        |> Maybe.withDefault ""
        |> String.replace "_" " "
        |> String.replace "(" " "
        |> String.replace ")" " "
        |> String.Extra.toTitleCase
        |> String.replace " " ""
        |> deSymbolify


{-| Some OAS have reponse refs that are just the status code.
We need to convert them to a valid Elm name.
-}
nameFromStatusCode : String -> String
nameFromStatusCode name =
    case String.toInt (String.left 3 name) of
        Just int ->
            if int >= 100 && int <= 599 then
                "statusCode" ++ name

            else
                name

        Nothing ->
            name


{-| Sometimes a word in the schema contains invalid characers for an Elm name.
We don't want to completely remove them though.
-}
deSymbolify : String -> String
deSymbolify str =
    if str == "$" then
        "dollar__"

    else if String.startsWith "-" str || String.startsWith "+" str then
        -- These were first identified in the GitHub OAS, for the names of emojis
        deSymbolify
            (str
                |> String.replace "-" "Minus"
                |> String.replace "+" "Plus"
            )

    else if String.startsWith "$" str then
        -- This was first identified in the BIMcloud OAS, the fields of `Resource` were prefixed with `$`
        deSymbolify (String.dropLeft 1 str)

    else
        let
            removeLeadingUnderscores : String -> String
            removeLeadingUnderscores acc =
                if String.isEmpty acc then
                    "empty__"

                else if String.startsWith "_" acc then
                    removeLeadingUnderscores (String.dropLeft 1 acc)

                else
                    acc
        in
        str
            |> String.replace "-" "_"
            |> String.replace "+" "_"
            |> String.replace "$" "_"
            |> removeLeadingUnderscores


{-| Convert into a name suitable to be used in Elm as a variable.
-}
toValueName : String -> String
toValueName name =
    let
        deSymbolified : String
        deSymbolified =
            deSymbolify name
    in
    case String.split "_" deSymbolified of
        [] ->
            ""

        head :: tail ->
            if head == String.toUpper head then
                String.join "_" (String.toLower head :: tail)

            else
                deSymbolified


type Type
    = Nullable Type
    | Object Object
    | String
    | Int
    | Float
    | Bool
    | List Type
    | OneOf TypeName OneOfData
    | Value
    | Ref (List String)
    | Bytes
    | Unit


type alias Object =
    FastDict.Dict FieldName Field


type alias OneOfData =
    List
        { name : VariantName
        , type_ : Type
        }


type alias TypeName =
    String


type alias VariantName =
    TypeName


type alias FieldName =
    String


type alias Field =
    { type_ : Type
    , required : Bool
    }


ref : String -> Type
ref str =
    Ref (String.split "/" str)
