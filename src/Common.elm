module Common exposing
    ( BasicType(..)
    , Component(..)
    , ConstValue(..)
    , Field
    , Module(..)
    , Object
    , OneOfData
    , Package(..)
    , RefTo
    , RequestBody
    , Response
    , Schema
    , Type(..)
    , TypeName
    , UnsafeName(..)
    , VariantName
    , base64PackageName
    , basicTypeToString
    , commonModuleName
    , enum
    , moduleToNamespace
    , parseRef
    , parseRequestBodyRef
    , parseResponseRef
    , parseSchemaRef
    , refTo
    , refToString
    , reservedList
    , toTypeName
    , toValueName
    , unwrapRef
    , unwrapUnsafe
    )

import Json.Encode
import NonEmpty
import Regex
import Set exposing (Set)
import String.Extra


type Module
    = Json Component
    | Types Component
      -- Nothing if we are only generating effects for a single package
    | Api (Maybe Package)
    | Common
    | Servers


type Component
    = Schema
    | Parameter
    | SecurityScheme
    | RequestBody
    | Response
    | Header
    | Example
    | Link
    | Callback


type Package
    = ElmHttp
    | DillonkearnsElmPages
    | LamderaProgramTest


{-| An unsanitized name
-}
type UnsafeName
    = UnsafeName String


moduleToNamespace : List String -> Module -> List String
moduleToNamespace namespace moduleName =
    case moduleName of
        Json Schema ->
            namespace ++ [ "Json" ]

        Json component ->
            namespace ++ [ "Json", componentToModulePiece component ]

        Types Schema ->
            namespace ++ [ "Types" ]

        Types component ->
            namespace ++ [ "Types", componentToModulePiece component ]

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


componentToModulePiece : Component -> String
componentToModulePiece component =
    case component of
        Schema ->
            "Schemas"

        Parameter ->
            "Parameters"

        SecurityScheme ->
            "SecuritySchemes"

        RequestBody ->
            "RequestBodies"

        Response ->
            "Responses"

        Header ->
            "Headers"

        Example ->
            "Examples"

        Link ->
            "Links"

        Callback ->
            "Callbacks"


componentFromString : String -> Maybe Component
componentFromString component =
    case component of
        "schemas" ->
            Just Schema

        "parameters" ->
            Just Parameter

        "securitySchemes" ->
            Just SecurityScheme

        "requestBodies" ->
            Just RequestBody

        "responses" ->
            Just Response

        "headers" ->
            Just Header

        "examples" ->
            Just Example

        "links" ->
            Just Link

        "callbacks" ->
            Just Callback

        _ ->
            Nothing


componentToString : Component -> String
componentToString component =
    case component of
        Schema ->
            "schemas"

        Parameter ->
            "parameters"

        SecurityScheme ->
            "securitySchemes"

        RequestBody ->
            "requestBodies"

        Response ->
            "responses"

        Header ->
            "headers"

        Example ->
            "examples"

        Link ->
            "links"

        Callback ->
            "callbacks"


commonModuleName : List String
commonModuleName =
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

    else
        let
            replaced : List Char
            replaced =
                str
                    |> String.foldl
                        (\c acc ->
                            let
                                code : Int
                                code =
                                    Char.toCode c
                            in
                            if
                                -- lowercase
                                (0x61 <= code && code <= 0x7A)
                                    || -- uppercase
                                       (0x41 <= code && code <= 0x5A)
                                    || -- digits
                                       (0x30 <= code && code <= 0x39)
                            then
                                c :: acc

                            else if List.isEmpty acc then
                                acc

                            else if code == {- '_' -} 95 then
                                c :: acc

                            else
                                replacement :: acc
                        )
                        []
        in
        case List.reverse replaced of
            [] ->
                "empty__"

            (h :: _) as nonEmpty ->
                if Char.isDigit h then
                    "N" ++ String.fromList nonEmpty

                else
                    String.fromList nonEmpty


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
    | OneOf TypeName ( OneOfData, List OneOfData )
    | Enum ( UnsafeName, List UnsafeName )
    | Value
    | Ref (RefTo Schema)
    | Bytes
    | Unit


type RefTo r
    = RefTo Component UnsafeName


type Schema
    = TypeLevelSchema Never


type RequestBody
    = TypeLevelRequestBody Never


type Response
    = TypeLevelResponse Never


type BasicType
    = Integer
    | Boolean
    | String
    | Number


type ConstValue
    = ConstInteger Int
    | ConstBoolean Bool
    | ConstString String
    | ConstNumber Float


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


type alias Object =
    List ( UnsafeName, Field )


type alias OneOfData =
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


parseRef : String -> Result String (RefTo ())
parseRef ref =
    case String.split "/" ref of
        [ "#", "components", component, name ] ->
            case componentFromString component of
                Just c ->
                    Ok (RefTo c (UnsafeName name))

                Nothing ->
                    Err ("Invalid component: " ++ component)

        _ ->
            Err ("Couldn't parse the ref " ++ Json.Encode.encode 0 (Json.Encode.string ref))


parseSchemaRef : String -> Result String (RefTo Schema)
parseSchemaRef ref =
    parseRef ref
        |> Result.andThen
            (\(RefTo component res) ->
                if component == Schema then
                    Ok (RefTo Schema res)

                else
                    Err ("Expected a reference to a schema, found a reference to " ++ ref)
            )


parseRequestBodyRef : String -> Result String (RefTo RequestBody)
parseRequestBodyRef ref =
    parseRef ref
        |> Result.andThen
            (\(RefTo component res) ->
                if component == RequestBody then
                    Ok (RefTo RequestBody res)

                else
                    Err ("Expected a reference to a schema, found a reference to " ++ ref)
            )


parseResponseRef : String -> Result String (RefTo Response)
parseResponseRef ref =
    parseRef ref
        |> Result.andThen
            (\(RefTo component res) ->
                if component == Response then
                    Ok (RefTo Response res)

                else
                    Err ("Expected a reference to a schema, found a reference to " ++ ref)
            )


unwrapUnsafe : UnsafeName -> String
unwrapUnsafe (UnsafeName name) =
    name


enum : ( String, List String ) -> Type
enum variants =
    variants
        |> NonEmpty.sort
        |> NonEmpty.map UnsafeName
        |> Enum


base64PackageName : String
base64PackageName =
    "danfishgold/base64-bytes"


refToString : RefTo component -> UnsafeName
refToString (RefTo component (UnsafeName name)) =
    UnsafeName (String.join "/" [ "#", "components", componentToString component, name ])


unwrapRef : RefTo component -> ( Component, UnsafeName )
unwrapRef (RefTo component ref) =
    ( component, ref )


refTo : Component -> UnsafeName -> RefTo ()
refTo component name =
    RefTo component name
