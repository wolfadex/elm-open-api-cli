module Common exposing
    ( BasicType(..), commonModuleName, base64PackageName
    , ConstValue(..), Field, Module(..), Object, OneOfData, Package(..), Type(..), TypeName, UnsafeName(..), VariantName, basicTypeToString, enum, moduleToNamespace, ref, reservedList, toTypeName, toValueName, unwrapUnsafe
    )

{-|

@docs BasicType, commonModuleName, base64PackageName


# TODO: These should probably not be exposed.

@docs ConstValue, Field, Module, Object, OneOfData, Package, Type, TypeName, UnsafeName, VariantName, basicTypeToString, enum, moduleToNamespace, ref, reservedList, toTypeName, toValueName, unwrapUnsafe

-}

import Regex
import Set exposing (Set)
import String.Extra


{-| An Elm module being generated

TODO: Don't expose this.

-}
type Module
    = Json
    | Types
      -- Nothing if we are only generating effects for a single package
    | Api (Maybe Package)
    | Common
    | Servers


{-| An Effects package we can target when code-generating API calls
-}
type Package
    = ElmHttp
    | DillonkearnsElmPages
    | LamderaProgramTest


{-| An unsanitized name

TODO: Don't expose this.

-}
type UnsafeName
    = UnsafeName String


{-| Given a namespace and Module, generate the full module name

TODO: Don't expose this.

-}
moduleToNamespace : List String -> Module -> List String
moduleToNamespace namespace moduleName =
    case moduleName of
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
            commonModuleName


{-| Module where we generate common helper functions.
-}
commonModuleName : List String
commonModuleName =
    [ "OpenApi", "Common" ]



-- Names adaptation --


{-| Convert an UnsafeName to a valid TypeName.

TODO: Don't expose this.

-}
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
        |> deSymbolify ' '
        |> reduceWith replaceSpacesRegex
            (\match ->
                case match.submatches of
                    [ Just before, Just after ] ->
                        case String.toInt before of
                            Nothing ->
                                before ++ after

                            Just _ ->
                                case String.toInt after of
                                    Nothing ->
                                        before ++ after

                                    Just _ ->
                                        match.match

                    [ Just before, Nothing ] ->
                        before

                    [ Nothing, Just after ] ->
                        after

                    _ ->
                        ""
            )
        |> String.replace " " "_"
        |> String.Extra.toTitleCase


replaceSpacesRegex : Regex.Regex
replaceSpacesRegex =
    Regex.fromString "(.)? (.)?"
        |> Maybe.withDefault Regex.never


{-| Convert into a name suitable to be used in Elm as a variable.

TODO: Don't expose this.

-}
toValueName : UnsafeName -> String
toValueName (UnsafeName name) =
    let
        raw : String
        raw =
            name
                |> String.replace " " "_"
                |> deSymbolify '_'
    in
    if raw == "dollar__" || raw == "empty__" then
        raw

    else
        let
            clean : String
            clean =
                raw
                    |> reduceWith replaceUnderscoresRegex
                        (\{ match } ->
                            if match == "__" then
                                "_"

                            else
                                ""
                        )
                    |> initialUppercaseWordToLowercase
        in
        if Set.member clean reservedList then
            clean ++ "_"

        else
            clean


{-| Reserved words; these can't be used for Elm variable names.

TODO: Don't expose this.

-}
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


replaceUnderscoresRegex : Regex.Regex
replaceUnderscoresRegex =
    Regex.fromString "(?:__)|(?:_$)"
        |> Maybe.withDefault Regex.never


reduceWith : Regex.Regex -> (Regex.Match -> String) -> String -> String
reduceWith regex map input =
    let
        output : String
        output =
            Regex.replace regex map input
    in
    if output == input then
        input

    else
        reduceWith regex map output


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
deSymbolify : Char -> String -> String
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
                case String.uncons acc of
                    Nothing ->
                        "empty__"

                    Just ( head, tail ) ->
                        if head == replacement then
                            removeLeadingUnderscores tail

                        else if Char.isDigit head then
                            "N" ++ acc

                        else
                            acc
        in
        str
            |> replaceSymbolsWith replacement
            |> removeLeadingUnderscores


replaceSymbolsWith : Char -> String -> String
replaceSymbolsWith replacement input =
    input
        |> String.map
            (\c ->
                if c /= '_' && not (Char.isAlphaNum c) then
                    replacement

                else
                    c
            )


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


{-| Intermediate representation of an OpenAPI schema

TODO: Don't expose this.

-}
type Type
    = Nullable Type
    | Object Object
    | Basic
        -- This is separate for easier pattern matching
        BasicType
        { format : Maybe String
        , const : Maybe ConstValue
        }
    | Null
    | List Type
      -- The type declared in additionalProperties, and a list of normal properties
    | Dict { type_ : Type, documentation : Maybe String } Object
    | OneOf TypeName OneOfData
    | Enum (List UnsafeName)
    | Value
    | Ref (List String)
    | Bytes
    | Unit


{-| A basic value
-}
type BasicType
    = Integer
    | Boolean
    | String
    | Number


{-| A constant value

TODO: Don't expose this.

-}
type ConstValue
    = ConstInteger Int
    | ConstBoolean Bool
    | ConstString String
    | ConstNumber Float


{-| Convert BasicType to OpenAPI "type" string

TODO: Don't expose this. Move to CliMonad?

-}
basicTypeToString : BasicType -> String
basicTypeToString basicType =
    case basicType of
        Integer ->
            "integer"

        Boolean ->
            "boolean"

        String ->
            "string"

        Number ->
            "number"


{-| An Object in a schema

TODO: Don't expose this.

-}
type alias Object =
    List ( UnsafeName, Field )


{-| A `oneOf` declaration

TODO: Don't expose this.

-}
type alias OneOfData =
    List
        { name : UnsafeName
        , type_ : Type
        , documentation : Maybe String
        }


{-| Name of a Type

TODO: Don't expose this.

-}
type alias TypeName =
    String


{-| Variant of a custom type

TODO: Don't expose this.

-}
type alias VariantName =
    TypeName


{-| An Object field
TODO: Don't expose this.
-}
type alias Field =
    { type_ : Type
    , required : Bool
    , documentation : Maybe String
    }


{-| Create a "Ref", as in `$ref: "#/components/..."`.

TODO: Don't expose this.

-}
ref : String -> Type
ref str =
    Ref (String.split "/" str)


{-| Get the value inside of an UnsafeName.

TODO: Don't expose this.

-}
unwrapUnsafe : UnsafeName -> String
unwrapUnsafe (UnsafeName name) =
    name


{-| Generate an "enum" from a list of variants.

TODO: Don't expose this.

-}
enum : List String -> Type
enum variants =
    variants
        |> List.sort
        |> List.map UnsafeName
        |> Enum


{-| Name of the package needed for Base64.
-}
base64PackageName : String
base64PackageName =
    "danfishgold/base64-bytes"
