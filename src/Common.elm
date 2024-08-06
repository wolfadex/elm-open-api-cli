module Common exposing
    ( Field
    , Module(..)
    , Object
    , OneOfData
    , Package(..)
    , Type(..)
    , TypeName
    , UnsafeName(..)
    , VariantName
    , enum
    , moduleToNamespace
    , ref
    , toTypeName
    , toValueName
    , unwrapUnsafe
    )

import String.Extra


type Module
    = Json
    | Types
      -- Nothing if we are only generating effects for a single package
    | Api (Maybe Package)
    | Common
    | Servers


type Package
    = ElmHttp
    | DillonkearnsElmPages
    | LamderaProgramTest


{-| An unsanitized name
-}
type UnsafeName
    = UnsafeName String


moduleToNamespace : List String -> Module -> List String
moduleToNamespace namespace module_ =
    case module_ of
        Json ->
            namespace ++ [ "Json" ]

        Types ->
            namespace ++ [ "Types" ]

        Api package ->
            case package of
                Just ElmHttp ->
                    namespace ++ [ "Api", "ElmHttp" ]

                Just DillonkearnsElmPages ->
                    namespace ++ [ "Api", "DillonkearnsElmPages" ]

                Just LamderaProgramTest ->
                    namespace ++ [ "Api", "LamderaProgramTest" ]

                Nothing ->
                    namespace ++ [ "Api" ]

        Servers ->
            namespace ++ [ "Servers" ]

        Common ->
            [ "OpenApi", "Common" ]



-- Names adaptation --


toTypeName : UnsafeName -> TypeName
toTypeName (UnsafeName name) =
    name
        |> nameFromStatusCode
        |> String.uncons
        |> Maybe.map (\( first, rest ) -> String.cons first (String.replace "-" " " rest))
        |> Maybe.withDefault ""
        |> String.replace "_" " "
        |> String.trim
        |> String.Extra.toTitleCase
        |> deSymbolify " "
        |> String.replace " " ""
        |> String.Extra.toTitleCase


{-| Convert into a name suitable to be used in Elm as a variable.
-}
toValueName : UnsafeName -> String
toValueName (UnsafeName name) =
    name
        |> String.replace " " "_"
        |> deSymbolify "_"
        |> initialUppercaseWordToLowercase


{-| Some OAS have response refs that are just the status code.
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
deSymbolify : String -> String -> String
deSymbolify replacement str =
    if str == "$" then
        "dollar__"

    else if String.startsWith "-" str || String.startsWith "+" str then
        -- These were first identified in the GitHub OAS, for the names of emojis
        deSymbolify replacement
            (str
                |> String.replace "-" "Minus"
                |> String.replace "+" "Plus"
            )

    else if String.startsWith "$" str then
        -- This was first identified in the BIMcloud OAS, the fields of `Resource` were prefixed with `$`
        deSymbolify replacement (String.dropLeft 1 str)

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
            |> replaceSymbolsWith replacement
            |> removeLeadingUnderscores


replaceSymbolsWith : String -> String -> String
replaceSymbolsWith replacement input =
    input
        |> String.replace "-" replacement
        |> String.replace "+" replacement
        |> String.replace "$" replacement
        |> String.replace "(" replacement
        |> String.replace ")" replacement
        |> String.replace "/" replacement
        |> String.replace "," replacement


initialUppercaseWordToLowercase : String -> String
initialUppercaseWordToLowercase input =
    case String.toList input of
        [] ->
            input

        head :: tail ->
            if Char.isUpper head then
                let
                    go : Char -> List Char -> List Char -> String
                    go first next acc =
                        case next of
                            [] ->
                                String.toLower input

                            second :: rest ->
                                if Char.isUpper second then
                                    go second rest (Char.toLower first :: acc)

                                else if Char.isLower second then
                                    String.fromList (List.reverse acc ++ first :: next)

                                else
                                    String.fromList (List.reverse acc ++ Char.toLower first :: next)
                in
                go (Char.toLower head) tail []

            else
                input


type Type
    = Nullable Type
    | Object Object
    | String
    | Int
    | Float
    | Bool
    | List Type
    | OneOf TypeName OneOfData
    | Enum (List UnsafeName)
    | Value
    | Ref (List String)
    | Bytes
    | Unit


type alias Object =
    List ( UnsafeName, Field )


type alias OneOfData =
    List
        { name : UnsafeName
        , type_ : Type
        , documentation : Maybe String
        }


type alias TypeName =
    String


type alias VariantName =
    TypeName


type alias Field =
    { type_ : Type
    , required : Bool
    , documentation : Maybe String
    }


ref : String -> Type
ref str =
    Ref (String.split "/" str)


unwrapUnsafe : UnsafeName -> String
unwrapUnsafe (UnsafeName name) =
    name


enum : List String -> Type
enum variants =
    variants
        |> List.sort
        |> List.map UnsafeName
        |> Enum
