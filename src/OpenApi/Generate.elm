module OpenApi.Generate exposing (ContentSchema(..), Mime, file, makeNamespaceValid, removeInvalidChars)

import CliMonad exposing (CliMonad)
import Common exposing (Field, FieldName, Type(..), TypeName, toValueName, typifyName)
import Dict
import Elm
import Elm.Annotation
import Elm.Case
import Elm.Declare
import Elm.Op
import Elm.ToString
import FastDict exposing (Dict)
import Gen.Basics
import Gen.Bytes
import Gen.Debug
import Gen.Http
import Gen.Json.Decode
import Gen.Json.Decode.Extra
import Gen.Json.Encode
import Gen.List
import Gen.Maybe
import Gen.Result
import Gen.String
import Gen.Task
import Gen.Url.Builder
import Json.Schema.Definitions
import Maybe.Extra
import OpenApi
import OpenApi.Components
import OpenApi.MediaType
import OpenApi.Operation
import OpenApi.Parameter
import OpenApi.Path
import OpenApi.Reference
import OpenApi.RequestBody
import OpenApi.Response
import OpenApi.Schema
import OpenApi.SecurityRequirement
import OpenApi.Server
import Set exposing (Set)
import String.Extra


type alias Mime =
    String


type alias Warning =
    String


type ContentSchema
    = EmptyContent
    | JsonContent Type
    | StringContent Mime
    | BytesContent Mime


type alias AuthorizationInfo =
    { headers : Elm.Expression -> List Elm.Expression
    , params : List ( String, Elm.Annotation.Annotation )
    , scopes : List String
    }


file : { namespace : String, generateTodos : Bool } -> OpenApi.OpenApi -> Result String ( Elm.File, List Warning )
file { namespace, generateTodos } apiSpec =
    CliMonad.combine
        [ pathDeclarations
        , CliMonad.succeed
            [ decodeOptionalField.declaration
            , responseToResult.declaration
            , jsonResolver.declaration
            , whateverResolver.declaration
            , nullableType
            ]
        , componentDeclarations
        , responsesDeclarations
        ]
        |> CliMonad.map List.concat
        |> CliMonad.run
            { openApi = apiSpec
            , generateTodos = generateTodos
            }
        |> Result.map
            (\( decls, warnings ) ->
                ( Elm.fileWith [ namespace ]
                    { docs =
                        List.sortBy
                            (\{ group } ->
                                case group of
                                    Just "Request functions" ->
                                        1

                                    Just "Types" ->
                                        2

                                    Just "Encoders" ->
                                        3

                                    Just "Decoders" ->
                                        4

                                    _ ->
                                        5
                            )
                            >> List.map Elm.docs
                    , aliases = []
                    }
                    decls
                , warnings
                )
            )


pathDeclarations : CliMonad (List Elm.Declaration)
pathDeclarations =
    CliMonad.fromApiSpec OpenApi.paths
        |> CliMonad.andThen
            (\paths ->
                paths
                    |> Dict.toList
                    |> CliMonad.combineMap
                        (\( url, path ) ->
                            [ ( "GET", OpenApi.Path.get )
                            , ( "POST", OpenApi.Path.post )
                            , ( "PUT", OpenApi.Path.put )
                            , ( "PATCH", OpenApi.Path.patch )
                            , ( "DELETE", OpenApi.Path.delete )
                            , ( "HEAD", OpenApi.Path.head )
                            , ( "TRACE", OpenApi.Path.trace )
                            ]
                                |> List.filterMap (\( method, getter ) -> Maybe.map (Tuple.pair method) (getter path))
                                |> CliMonad.combineMap
                                    (\( method, operation ) ->
                                        toRequestFunctions method url operation
                                            |> CliMonad.errorToWarning
                                    )
                                |> CliMonad.map (List.filterMap identity >> List.concat)
                        )
                    |> CliMonad.map
                        (List.concat
                            >> List.map
                                (Elm.exposeWith
                                    { exposeConstructor = False
                                    , group = Just "Request functions"
                                    }
                                )
                        )
            )


responsesDeclarations : CliMonad (List Elm.Declaration)
responsesDeclarations =
    CliMonad.fromApiSpec
        (OpenApi.components
            >> Maybe.map OpenApi.Components.responses
            >> Maybe.withDefault Dict.empty
        )
        |> CliMonad.andThen
            (Dict.foldl
                (\name schema ->
                    CliMonad.map2 (::)
                        (responseToDeclarations name schema)
                )
                (CliMonad.succeed [])
            )
        |> CliMonad.map List.concat


componentDeclarations : CliMonad (List Elm.Declaration)
componentDeclarations =
    CliMonad.fromApiSpec
        (OpenApi.components
            >> Maybe.map OpenApi.Components.schemas
            >> Maybe.withDefault Dict.empty
        )
        |> CliMonad.andThen
            (Dict.foldl
                (\name schema ->
                    CliMonad.map2 (::)
                        (schemaToDeclarations name (OpenApi.Schema.get schema))
                )
                (CliMonad.succeed [])
            )
        |> CliMonad.map List.concat


schemaToDeclarations : String -> Json.Schema.Definitions.Schema -> CliMonad (List Elm.Declaration)
schemaToDeclarations name schema =
    schemaToAnnotation schema
        |> CliMonad.andThen
            (\ann ->
                let
                    typeName : TypeName
                    typeName =
                        typifyName name
                in
                if (Elm.ToString.annotation ann).signature == typeName then
                    CliMonad.succeed []

                else
                    [ Elm.alias typeName ann
                        |> Elm.exposeWith
                            { exposeConstructor = False
                            , group = Just "Types"
                            }
                        |> CliMonad.succeed
                    , CliMonad.map
                        (\schemaDecoder ->
                            Elm.declaration ("decode" ++ typeName)
                                (schemaDecoder
                                    |> Elm.withType (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.named [] typeName))
                                )
                                |> Elm.exposeWith
                                    { exposeConstructor = False
                                    , group = Just "Decoders"
                                    }
                        )
                        (schemaToDecoder schema)
                    , CliMonad.map
                        (\encoder ->
                            Elm.declaration ("encode" ++ typeName)
                                (Elm.functionReduced "rec" encoder
                                    |> Elm.withType (Elm.Annotation.function [ Elm.Annotation.named [] typeName ] Gen.Json.Encode.annotation_.value)
                                )
                                |> Elm.exposeWith
                                    { exposeConstructor = False
                                    , group = Just "Encoders"
                                    }
                        )
                        (schemaToEncoder schema)
                    ]
                        |> CliMonad.combine
            )
        |> CliMonad.withPath name


responseToDeclarations : String -> OpenApi.Reference.ReferenceOr OpenApi.Response.Response -> CliMonad (List Elm.Declaration)
responseToDeclarations name reference =
    case OpenApi.Reference.toConcrete reference of
        Just response ->
            let
                content : Dict.Dict String OpenApi.MediaType.MediaType
                content =
                    OpenApi.Response.content response
            in
            if Dict.isEmpty content then
                -- If there is no content then we go with the unit value, `()` as the response type
                CliMonad.succeed []

            else
                responseToSchema response
                    |> CliMonad.withPath name
                    |> CliMonad.andThen (schemaToDeclarations name)

        Nothing ->
            CliMonad.fail "Could not convert reference to concrete value"
                |> CliMonad.withPath name


stepOrFail : String -> (a -> Maybe value) -> CliMonad a -> CliMonad value
stepOrFail msg f =
    CliMonad.andThen
        (\y ->
            case f y of
                Just z ->
                    CliMonad.succeed z

                Nothing ->
                    CliMonad.fail msg
        )


toRequestFunctions : String -> String -> OpenApi.Operation.Operation -> CliMonad (List Elm.Declaration)
toRequestFunctions method url operation =
    operationToSuccessTypeAndExpectAndResolver operation
        |> CliMonad.andThen
            (\( successType, toExpect, resolver ) ->
                let
                    functionName : String
                    functionName =
                        (OpenApi.Operation.operationId operation
                            |> Maybe.withDefault url
                        )
                            |> makeNamespaceValid
                            |> removeInvalidChars
                            |> String.Extra.camelize

                    replacedUrl : CliMonad (Elm.Expression -> Elm.Expression)
                    replacedUrl =
                        let
                            params : List (OpenApi.Reference.ReferenceOr OpenApi.Parameter.Parameter)
                            params =
                                OpenApi.Operation.parameters operation
                        in
                        params
                            |> CliMonad.combineMap
                                (\param ->
                                    toConcreteParam param
                                        |> CliMonad.andThen
                                            (\concreteParam ->
                                                case OpenApi.Parameter.in_ concreteParam of
                                                    "path" ->
                                                        if OpenApi.Parameter.required concreteParam then
                                                            let
                                                                pname : String
                                                                pname =
                                                                    OpenApi.Parameter.name concreteParam
                                                            in
                                                            ( Just
                                                                (\config ->
                                                                    Gen.String.call_.replace
                                                                        (Elm.string <| "{" ++ pname ++ "}")
                                                                        (Elm.get (toValueName pname) (Elm.get "params" config))
                                                                )
                                                            , []
                                                            )
                                                                |> CliMonad.succeed

                                                        else
                                                            CliMonad.fail "Optional parameters in path"

                                                    "query" ->
                                                        CliMonad.succeed ( Nothing, [ concreteParam ] )

                                                    paramIn ->
                                                        CliMonad.todoWithDefault ( Nothing, [] ) <| "Parameters in \"" ++ paramIn ++ "\""
                                            )
                                )
                            |> CliMonad.andThen
                                (\pairs ->
                                    let
                                        fullUrl : CliMonad String
                                        fullUrl =
                                            CliMonad.fromApiSpec OpenApi.servers
                                                |> CliMonad.map
                                                    (\servers ->
                                                        case servers of
                                                            [] ->
                                                                url

                                                            firstServer :: _ ->
                                                                if String.startsWith "/" url then
                                                                    OpenApi.Server.url firstServer ++ url

                                                                else
                                                                    OpenApi.Server.url firstServer ++ "/" ++ url
                                                    )

                                        ( replacements, queryParams ) =
                                            List.unzip pairs
                                                |> Tuple.mapBoth (List.filterMap identity) List.concat

                                        replaced : CliMonad (Elm.Expression -> Elm.Expression)
                                        replaced =
                                            fullUrl
                                                |> CliMonad.map
                                                    (\u ->
                                                        \config ->
                                                            List.foldl
                                                                (\replacement -> replacement config)
                                                                (Elm.string u)
                                                                replacements
                                                    )
                                    in
                                    if List.isEmpty queryParams then
                                        replaced

                                    else
                                        queryParams
                                            |> CliMonad.combineMap queryParameterToUrlBuilderArgument
                                            |> CliMonad.map2
                                                (\repl queryArgs config ->
                                                    queryArgs
                                                        |> List.map (\arg -> arg config)
                                                        |> Gen.List.filterMap Gen.Basics.identity
                                                        |> Gen.Url.Builder.call_.crossOrigin
                                                            (repl config)
                                                            (Elm.list [])
                                                )
                                                replaced
                                )

                    body : ContentSchema -> CliMonad (Elm.Expression -> Elm.Expression)
                    body bodyContent =
                        case bodyContent of
                            EmptyContent ->
                                CliMonad.succeed (\_ -> Gen.Http.emptyBody)

                            JsonContent type_ ->
                                typeToEncoder type_
                                    |> CliMonad.map
                                        (\encoder config ->
                                            Gen.Http.jsonBody
                                                (encoder <| Elm.get "body" config)
                                        )

                            StringContent mime ->
                                CliMonad.succeed <| \config -> Gen.Http.call_.stringBody (Elm.string mime) (Elm.get "body" config)

                            BytesContent mime ->
                                CliMonad.succeed <| \config -> Gen.Http.bytesBody mime (Elm.get "body" config)

                    expect : Elm.Expression -> Elm.Expression
                    expect config =
                        toExpect (\toMsgArg -> Elm.apply (Elm.get "toMsg" config) [ toMsgArg ])

                    bodyParams : ContentSchema -> CliMonad (List ( String, Elm.Annotation.Annotation ))
                    bodyParams contentSchema =
                        case contentSchema of
                            EmptyContent ->
                                CliMonad.succeed []

                            JsonContent type_ ->
                                CliMonad.typeToAnnotation type_
                                    |> CliMonad.map (\annotation -> [ ( "body", annotation ) ])

                            StringContent _ ->
                                CliMonad.succeed [ ( "body", Elm.Annotation.string ) ]

                            BytesContent _ ->
                                CliMonad.succeed [ ( "body", Gen.Bytes.annotation_.bytes ) ]

                    requestCommand : ContentSchema -> CliMonad ( Elm.Expression, Elm.Annotation.Annotation )
                    requestCommand bodyContent =
                        authorizationInfo
                            |> CliMonad.andThen
                                (\auth ->
                                    CliMonad.map3
                                        (\toBody paramType replaced ->
                                            ( Elm.fn
                                                ( "config", Just paramType )
                                                (\config ->
                                                    Gen.Http.call_.request
                                                        (Elm.record
                                                            [ ( "method", Elm.string method )
                                                            , ( "headers", Elm.list <| auth.headers config )
                                                            , ( "expect", expect config )
                                                            , ( "body", toBody config )
                                                            , ( "timeout", Gen.Maybe.make_.nothing )
                                                            , ( "tracker", Gen.Maybe.make_.nothing )
                                                            , ( "url", replaced config )
                                                            ]
                                                        )
                                                )
                                            , Elm.Annotation.function
                                                [ paramType ]
                                                (Elm.Annotation.cmd (Elm.Annotation.var "msg"))
                                            )
                                        )
                                        (body bodyContent)
                                        (CliMonad.andThen2
                                            (\bp successAnnotation ->
                                                toConfigParamAnnotation
                                                    { operation = operation
                                                    , requireToMsg = True
                                                    , successAnnotation = successAnnotation
                                                    , authorizationInfo = auth
                                                    , bodyParams = bp
                                                    }
                                            )
                                            (bodyParams bodyContent)
                                            (CliMonad.typeToAnnotation successType)
                                        )
                                        replacedUrl
                                )

                    requestTask : ContentSchema -> CliMonad ( Elm.Expression, Elm.Annotation.Annotation )
                    requestTask bodyContent =
                        CliMonad.andThen2
                            (\auth successAnnotation ->
                                CliMonad.map3
                                    (\toBody paramType replaced ->
                                        ( Elm.fn
                                            ( "config", Just paramType )
                                            (\config ->
                                                Gen.Http.call_.task
                                                    (Elm.record
                                                        [ ( "url", replaced config )
                                                        , ( "method", Elm.string method )
                                                        , ( "headers", Elm.list <| auth.headers config )
                                                        , ( "resolver", resolver )
                                                        , ( "body", toBody config )
                                                        , ( "timeout", Gen.Maybe.make_.nothing )
                                                        ]
                                                    )
                                            )
                                        , Elm.Annotation.function
                                            [ paramType ]
                                            (Gen.Task.annotation_.task
                                                Gen.Http.annotation_.error
                                                successAnnotation
                                            )
                                        )
                                    )
                                    (body bodyContent)
                                    (CliMonad.andThen
                                        (\bp ->
                                            toConfigParamAnnotation
                                                { operation = operation
                                                , requireToMsg = False
                                                , successAnnotation = successAnnotation
                                                , authorizationInfo = auth
                                                , bodyParams = bp
                                                }
                                        )
                                        (bodyParams bodyContent)
                                    )
                                    replacedUrl
                            )
                            authorizationInfo
                            (CliMonad.typeToAnnotation successType)

                    authorizationInfo : CliMonad AuthorizationInfo
                    authorizationInfo =
                        operationToAuthorizationInfo operation

                    documentation : CliMonad String
                    documentation =
                        authorizationInfo
                            |> CliMonad.map
                                (\{ scopes } ->
                                    let
                                        descriptionDoc : String
                                        descriptionDoc =
                                            OpenApi.Operation.description operation
                                                |> Maybe.withDefault ""
                                    in
                                    if List.isEmpty scopes then
                                        descriptionDoc

                                    else
                                        ([ descriptionDoc
                                         , ""
                                         , "This operations requires the following scopes:"
                                         ]
                                            ++ List.map
                                                (\scope ->
                                                    " - `" ++ scope ++ "`"
                                                )
                                                scopes
                                        )
                                            |> String.join "\n"
                                )
                in
                operationToContentSchema operation
                    |> CliMonad.andThen
                        (\contentSchema ->
                            CliMonad.map2
                                Tuple.pair
                                (requestCommand contentSchema)
                                (requestTask contentSchema)
                        )
                    |> CliMonad.map2
                        (\doc ( ( requestCmd, requestCmdType ), ( requestTsk, requestTskType ) ) ->
                            [ requestCmd
                                |> Elm.withType requestCmdType
                                |> Elm.declaration functionName
                                |> Elm.withDocumentation doc
                            , requestTsk
                                |> Elm.withType requestTskType
                                |> Elm.declaration (functionName ++ "Task")
                                |> Elm.withDocumentation doc
                            ]
                        )
                        documentation
            )
        |> CliMonad.withPath method
        |> CliMonad.withPath url


operationToAuthorizationInfo : OpenApi.Operation.Operation -> CliMonad AuthorizationInfo
operationToAuthorizationInfo operation =
    let
        empty : AuthorizationInfo
        empty =
            { headers = \_ -> []
            , params = []
            , scopes = []
            }
    in
    case
        List.map
            (Dict.toList << OpenApi.SecurityRequirement.requirements)
            (OpenApi.Operation.security operation)
    of
        [] ->
            CliMonad.succeed empty

        [ [ ( "oauth_2_0", ss ) ] ] ->
            CliMonad.succeed
                { headers =
                    \config ->
                        [ Gen.Http.call_.header (Elm.string "Authorization")
                            (Elm.Op.append
                                (Elm.string "Bearer ")
                                (config
                                    |> Elm.get "authorization"
                                    |> Elm.get "bearer"
                                )
                            )
                        ]
                , params =
                    [ ( "authorization"
                      , Elm.Annotation.record
                            [ ( "bearer"
                              , Elm.Annotation.string
                              )
                            ]
                      )
                    ]
                , scopes = ss
                }

        _ ->
            CliMonad.todoWithDefault empty "Multiple security requirements"


operationToContentSchema : OpenApi.Operation.Operation -> CliMonad ContentSchema
operationToContentSchema operation =
    case OpenApi.Operation.requestBody operation of
        Nothing ->
            CliMonad.succeed EmptyContent

        Just requestOrRef ->
            case OpenApi.Reference.toConcrete requestOrRef of
                Just request ->
                    OpenApi.RequestBody.content request
                        |> contentToContentSchema

                Nothing ->
                    CliMonad.succeed requestOrRef
                        |> stepOrFail "I found a successfull response, but I couldn't convert it to a concrete one"
                            OpenApi.Reference.toReference
                        |> CliMonad.map OpenApi.Reference.ref
                        |> CliMonad.andThen schemaTypeRef
                        |> CliMonad.map (\typeName -> JsonContent (Named typeName))


contentToContentSchema : Dict.Dict String OpenApi.MediaType.MediaType -> CliMonad ContentSchema
contentToContentSchema content =
    let
        default : Maybe (CliMonad ContentSchema) -> CliMonad ContentSchema
        default fallback =
            case Dict.get "application/json" content of
                Just jsonSchema ->
                    CliMonad.succeed jsonSchema
                        |> stepOrFail "The request's application/json content option doesn't have a schema"
                            (OpenApi.MediaType.schema >> Maybe.map OpenApi.Schema.get)
                        |> CliMonad.andThen schemaToType
                        |> CliMonad.map JsonContent

                Nothing ->
                    case Dict.get "text/html" content of
                        Just htmlSchema ->
                            stringContent "text/html" htmlSchema

                        Nothing ->
                            case Dict.get "text/plain" content of
                                Just htmlSchema ->
                                    stringContent "text/plain" htmlSchema

                                Nothing ->
                                    let
                                        msg : String
                                        msg =
                                            "The content doesn't have an application/json, text/html or text/plain option, it has " ++ String.join ", " (Dict.keys content)
                                    in
                                    fallback
                                        |> Maybe.withDefault (CliMonad.fail msg)

        stringContent : String -> OpenApi.MediaType.MediaType -> CliMonad ContentSchema
        stringContent mime htmlSchema =
            CliMonad.succeed htmlSchema
                |> stepOrFail ("The request's " ++ mime ++ " content option doesn't have a schema")
                    (OpenApi.MediaType.schema >> Maybe.map OpenApi.Schema.get)
                |> CliMonad.andThen schemaToType
                |> CliMonad.andThen
                    (\type_ ->
                        if type_ == String then
                            CliMonad.succeed (StringContent mime)

                        else
                            CliMonad.fail ("The only supported type for " ++ mime ++ " content is string")
                    )
    in
    case Dict.toList content of
        [] ->
            CliMonad.succeed EmptyContent

        [ ( singleKey, singleValue ) ] ->
            let
                fallback : CliMonad ContentSchema
                fallback =
                    CliMonad.succeed
                        (BytesContent singleKey)
                        |> CliMonad.withWarning ("Unrecognized mime type: " ++ singleKey ++ ", treating it as bytes")
            in
            case
                singleValue
                    |> OpenApi.MediaType.schema
                    |> Maybe.map OpenApi.Schema.get
            of
                Just (Json.Schema.Definitions.ObjectSchema schema) ->
                    if schema.type_ == Json.Schema.Definitions.SingleType Json.Schema.Definitions.StringType then
                        -- This is used by, e.g., base64 encoded data
                        CliMonad.succeed (StringContent singleKey)

                    else if singleKey == "application/octet-stream" then
                        CliMonad.succeed (BytesContent singleKey)

                    else
                        default (Just fallback)

                _ ->
                    default (Just fallback)

        _ ->
            default Nothing


toConfigParamAnnotation :
    { operation : OpenApi.Operation.Operation
    , requireToMsg : Bool
    , successAnnotation : Elm.Annotation.Annotation
    , authorizationInfo : AuthorizationInfo
    , bodyParams : List ( String, Elm.Annotation.Annotation )
    }
    -> CliMonad Elm.Annotation.Annotation
toConfigParamAnnotation { operation, requireToMsg, successAnnotation, authorizationInfo, bodyParams } =
    CliMonad.map
        (\urlParams ->
            (authorizationInfo.params
                ++ (if requireToMsg then
                        [ ( "toMsg"
                          , Elm.Annotation.function
                                [ Gen.Result.annotation_.result Gen.Http.annotation_.error successAnnotation ]
                                (Elm.Annotation.var "msg")
                          )
                        ]

                    else
                        []
                   )
                ++ bodyParams
                ++ urlParams
            )
                |> CliMonad.recordType
        )
        (operationToUrlParams operation)


operationToUrlParams : OpenApi.Operation.Operation -> CliMonad (List ( String, Elm.Annotation.Annotation ))
operationToUrlParams operation =
    let
        params : List (OpenApi.Reference.ReferenceOr OpenApi.Parameter.Parameter)
        params =
            OpenApi.Operation.parameters operation
    in
    if List.isEmpty params then
        CliMonad.succeed []

    else
        params
            |> CliMonad.combineMap
                (\param ->
                    toConcreteParam param
                        |> CliMonad.andThen paramToAnnotation
                )
            |> CliMonad.map
                (\types -> [ ( "params", CliMonad.recordType types ) ])


queryParameterToUrlBuilderArgument : OpenApi.Parameter.Parameter -> CliMonad (Elm.Expression -> Elm.Expression)
queryParameterToUrlBuilderArgument param =
    paramToType param
        |> CliMonad.andThen
            (\( paramName, type_ ) ->
                paramToString type_
                    |> CliMonad.map
                        (\{ toString, alwaysJust } config ->
                            let
                                name : Elm.Expression
                                name =
                                    Elm.string paramName

                                value : Elm.Expression
                                value =
                                    Elm.get (toValueName paramName) (Elm.get "params" config)
                                        |> toString

                                build : Elm.Expression -> Elm.Expression
                                build =
                                    Gen.Url.Builder.call_.string name
                            in
                            if alwaysJust then
                                Gen.Maybe.make_.just (build value)

                            else
                                Gen.Maybe.map build value
                        )
            )


paramToString : Type -> CliMonad { toString : Elm.Expression -> Elm.Expression, alwaysJust : Bool }
paramToString type_ =
    let
        basic :
            (Elm.Expression -> Elm.Expression)
            -> CliMonad { toString : Elm.Expression -> Elm.Expression, alwaysJust : Bool }
        basic f =
            CliMonad.succeed { toString = f, alwaysJust = True }

        recursive :
            Type
            -> ({ toString : Elm.Expression, alwaysJust : Bool } -> Elm.Expression -> Elm.Expression)
            -> CliMonad { toString : Elm.Expression -> Elm.Expression, alwaysJust : Bool }
        recursive p f =
            paramToString p
                |> CliMonad.map
                    (\{ toString, alwaysJust } ->
                        { toString =
                            f
                                { alwaysJust = alwaysJust
                                , toString = Elm.functionReduced "toStringArg" toString
                                }
                        , alwaysJust = False
                        }
                    )
    in
    case type_ of
        String ->
            basic identity

        Int ->
            basic Gen.String.call_.fromInt

        Float ->
            basic Gen.String.call_.fromFloat

        Bool ->
            (\val ->
                Elm.ifThen val
                    (Elm.string "true")
                    (Elm.string "false")
            )
                |> basic

        Nullable String ->
            { toString = identity
            , alwaysJust = False
            }
                |> CliMonad.succeed

        Nullable p ->
            recursive p <|
                \{ toString, alwaysJust } val ->
                    if alwaysJust then
                        Gen.Maybe.call_.map toString val

                    else
                        Gen.Maybe.call_.andThen toString val

        List String ->
            { toString =
                \val ->
                    Elm.ifThen (Gen.List.call_.isEmpty val)
                        Gen.Maybe.make_.nothing
                        (val
                            |> Gen.String.call_.join (Elm.string ",")
                            |> Gen.Maybe.make_.just
                        )
            , alwaysJust = False
            }
                |> CliMonad.succeed

        List p ->
            recursive p <|
                \{ toString, alwaysJust } val ->
                    let
                        map : Elm.Expression -> Elm.Expression -> Elm.Expression
                        map =
                            if alwaysJust then
                                Gen.List.call_.map

                            else
                                Gen.List.call_.filterMap
                    in
                    Elm.ifThen (Gen.List.call_.isEmpty val)
                        Gen.Maybe.make_.nothing
                        (val
                            |> map toString
                            |> Gen.String.call_.join (Elm.string ",")
                            |> Gen.Maybe.make_.just
                        )

        _ ->
            CliMonad.typeToAnnotation type_
                |> CliMonad.andThen
                    (\annotation ->
                        let
                            msg : String
                            msg =
                                "Params of type \"" ++ Elm.Annotation.toString annotation ++ "\""
                        in
                        CliMonad.todoWithDefault
                            { toString = \_ -> Gen.Debug.todo msg
                            , alwaysJust = True
                            }
                            msg
                    )


paramToAnnotation : OpenApi.Parameter.Parameter -> CliMonad ( String, Elm.Annotation.Annotation )
paramToAnnotation concreteParam =
    paramToType concreteParam
        |> CliMonad.andThen
            (\( pname, type_ ) ->
                CliMonad.typeToAnnotationMaybe type_
                    |> CliMonad.map
                        (\annotation -> ( pname, annotation ))
            )


paramToType : OpenApi.Parameter.Parameter -> CliMonad ( String, Type )
paramToType concreteParam =
    let
        pname : String
        pname =
            OpenApi.Parameter.name concreteParam
    in
    CliMonad.succeed concreteParam
        |> stepOrFail ("Could not get schema for parameter " ++ pname)
            (OpenApi.Parameter.schema >> Maybe.map OpenApi.Schema.get)
        |> CliMonad.andThen schemaToType
        |> CliMonad.map
            (\type_ ->
                ( pname
                , if OpenApi.Parameter.required concreteParam then
                    type_

                  else
                    Nullable type_
                )
            )


toConcreteParam : OpenApi.Reference.ReferenceOr OpenApi.Parameter.Parameter -> CliMonad OpenApi.Parameter.Parameter
toConcreteParam param =
    case OpenApi.Reference.toConcrete param of
        Just concreteParam ->
            CliMonad.succeed concreteParam

        Nothing ->
            CliMonad.succeed param
                |> stepOrFail "I found a params, but I couldn't convert it to a concrete one" OpenApi.Reference.toReference
                |> CliMonad.map OpenApi.Reference.ref
                |> CliMonad.andThen
                    (\ref ->
                        case String.split "/" ref of
                            [ "#", "components", "parameters", parameterType ] ->
                                CliMonad.fromApiSpec OpenApi.components
                                    |> CliMonad.andThen
                                        (\components ->
                                            components
                                                |> Maybe.map OpenApi.Components.parameters
                                                |> Maybe.andThen (Dict.get parameterType)
                                                |> Maybe.map toConcreteParam
                                                |> Maybe.withDefault (CliMonad.fail <| "Param ref " ++ parameterType ++ " not found")
                                        )

                            _ ->
                                CliMonad.fail <| "Param reference should be to \"#/components/parameters/ref\", found:" ++ ref
                    )


operationToSuccessTypeAndExpectAndResolver : OpenApi.Operation.Operation -> CliMonad ( Type, (Elm.Expression -> Elm.Expression) -> Elm.Expression, Elm.Expression )
operationToSuccessTypeAndExpectAndResolver operation =
    let
        responses : Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response)
        responses =
            OpenApi.Operation.responses operation

        expectJson : Elm.Expression -> ((Elm.Expression -> Elm.Expression) -> Elm.Expression)
        expectJson decoder toMsg =
            Gen.Http.expectJson toMsg decoder
    in
    CliMonad.succeed responses
        |> stepOrFail
            ("Among the "
                ++ String.fromInt (Dict.size responses)
                ++ " possible responses, there was no successfull one."
            )
            getFirstSuccessResponse
        |> CliMonad.andThen
            (\( _, responseOrRef ) ->
                case OpenApi.Reference.toConcrete responseOrRef of
                    Just response ->
                        OpenApi.Response.content response
                            |> contentToContentSchema
                            |> CliMonad.andThen
                                (\contentSchema ->
                                    case contentSchema of
                                        JsonContent type_ ->
                                            CliMonad.map
                                                (\decoder ->
                                                    ( type_
                                                    , expectJson decoder
                                                    , jsonResolver.call decoder
                                                    )
                                                )
                                                (typeToDecoder type_)

                                        StringContent _ ->
                                            CliMonad.succeed
                                                ( String
                                                , Gen.Http.expectString
                                                , Gen.Http.stringResolver responseToResult.call
                                                )

                                        BytesContent _ ->
                                            CliMonad.succeed
                                                ( Bytes
                                                , \toMsg -> Gen.Http.expectBytes toMsg Gen.Basics.values_.identity
                                                , Gen.Http.bytesResolver responseToResult.call
                                                )

                                        EmptyContent ->
                                            CliMonad.succeed
                                                ( Unit
                                                , Gen.Http.expectWhatever
                                                , whateverResolver.call []
                                                )
                                )

                    Nothing ->
                        CliMonad.succeed responseOrRef
                            |> stepOrFail "I found a successfull response, but I couldn't convert it to a concrete one"
                                OpenApi.Reference.toReference
                            |> CliMonad.map OpenApi.Reference.ref
                            |> CliMonad.andThen schemaTypeRef
                            |> CliMonad.map
                                (\typeName ->
                                    ( Named typeName
                                    , expectJson <| Elm.val ("decode" ++ typeName)
                                    , jsonResolver.call <| Elm.val ("decode" ++ typeName)
                                    )
                                )
            )


jsonResolver :
    { declaration : Elm.Declaration
    , call : Elm.Expression -> Elm.Expression
    , callFrom : List String -> Elm.Expression -> Elm.Expression
    , value : List String -> Elm.Expression
    }
jsonResolver =
    Elm.Declare.fn "jsonResolver"
        ( "decoder"
        , Just <| Gen.Json.Decode.annotation_.decoder (Elm.Annotation.var "t")
        )
    <|
        \decoder ->
            Gen.Http.stringResolver
                (\response ->
                    response
                        |> responseToResult.call
                        |> Gen.Result.andThen
                            (\body ->
                                body
                                    |> Gen.Json.Decode.call_.decodeString decoder
                                    |> Gen.Result.mapError (\err -> Gen.Http.make_.badBody (Gen.Json.Decode.errorToString err))
                            )
                )


whateverResolver :
    { declaration : Elm.Declaration
    , call : List Elm.Expression -> Elm.Expression
    , callFrom : List String -> List Elm.Expression -> Elm.Expression
    , value : List String -> Elm.Expression
    }
whateverResolver =
    Elm.Declare.function "whateverResolver"
        []
    <|
        \_ ->
            Gen.Http.stringResolver
                (\response ->
                    response
                        |> responseToResult.call
                        |> Gen.Result.map
                            (\_ -> Elm.unit)
                )
                |> Elm.withType
                    (Gen.Http.annotation_.resolver Gen.Http.annotation_.error Elm.Annotation.unit)


schemaTypeRef : String -> CliMonad TypeName
schemaTypeRef refUri =
    case String.split "/" refUri of
        [ "#", "components", "schemas", schemaName ] ->
            CliMonad.succeed (typifyName schemaName)

        [ "#", "components", "responses", responseName ] ->
            CliMonad.succeed (typifyName responseName)

        _ ->
            CliMonad.fail <| "Couldn't get the type ref (" ++ refUri ++ ") for the response"


isSuccessResponseStatus : String -> Bool
isSuccessResponseStatus status =
    String.startsWith "2" status || String.startsWith "3" status


getFirstSuccessResponse : Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response) -> Maybe ( String, OpenApi.Reference.ReferenceOr OpenApi.Response.Response )
getFirstSuccessResponse responses =
    responses
        |> Dict.toList
        |> List.filter (Tuple.first >> isSuccessResponseStatus)
        |> List.head


nullableType : Elm.Declaration
nullableType =
    Elm.customType "Nullable"
        [ Elm.variant "Null"
        , Elm.variantWith "Present" [ Elm.Annotation.var "value" ]
        ]
        |> Elm.exposeWith
            { exposeConstructor = True
            , group = Just "Types"
            }


schemaToEncoder : Json.Schema.Definitions.Schema -> CliMonad (Elm.Expression -> Elm.Expression)
schemaToEncoder schema =
    schemaToType schema |> CliMonad.andThen typeToEncoder


typeToEncoder : Type -> CliMonad (Elm.Expression -> Elm.Expression)
typeToEncoder type_ =
    case type_ of
        String ->
            CliMonad.succeed Gen.Json.Encode.call_.string

        Int ->
            CliMonad.succeed Gen.Json.Encode.call_.int

        Float ->
            CliMonad.succeed Gen.Json.Encode.call_.float

        Bool ->
            CliMonad.succeed Gen.Json.Encode.call_.bool

        Object properties ->
            let
                propertiesList : List ( FieldName, Field )
                propertiesList =
                    FastDict.toList properties

                allRequired : Bool
                allRequired =
                    List.all (\( _, { required } ) -> required) propertiesList
            in
            propertiesList
                |> CliMonad.combineMap
                    (\( key, field ) ->
                        typeToEncoder field.type_
                            |> CliMonad.map
                                (\encoder rec ->
                                    let
                                        fieldExpr : Elm.Expression
                                        fieldExpr =
                                            Elm.get (toValueName key) rec

                                        toTuple : Elm.Expression -> Elm.Expression
                                        toTuple value =
                                            Elm.tuple
                                                (Elm.string key)
                                                (encoder value)
                                    in
                                    if allRequired then
                                        toTuple fieldExpr

                                    else if field.required then
                                        Gen.Maybe.make_.just (toTuple fieldExpr)

                                    else
                                        Gen.Maybe.map toTuple fieldExpr
                                )
                    )
                |> CliMonad.map
                    (\toProperties value ->
                        if allRequired then
                            Gen.Json.Encode.object <|
                                List.map (\prop -> prop value) toProperties

                        else
                            Gen.Json.Encode.call_.object <|
                                Gen.List.filterMap Gen.Basics.identity <|
                                    List.map (\prop -> prop value) toProperties
                    )

        List t ->
            typeToEncoder t
                |> CliMonad.map
                    (\encoder ->
                        Gen.Json.Encode.call_.list (Elm.functionReduced "rec" encoder)
                    )

        Nullable t ->
            typeToEncoder t
                |> CliMonad.map
                    (\encoder nullableValue ->
                        Elm.Case.custom
                            nullableValue
                            (Elm.Annotation.namedWith [] "Nullable" [ Elm.Annotation.var "value" ])
                            [ Elm.Case.branch0 "Null" Gen.Json.Encode.null
                            , Elm.Case.branch1 "Present"
                                ( "value", Elm.Annotation.var "value" )
                                encoder
                            ]
                    )

        Value ->
            CliMonad.succeed <| Gen.Basics.identity

        Named name ->
            CliMonad.succeed <| \rec -> Elm.apply (Elm.val ("encode" ++ name)) [ rec ]

        OneOf oneOfName oneOfData ->
            oneOfData
                |> CliMonad.combineMap
                    (\variant ->
                        CliMonad.map2
                            (\ann variantEncoder ->
                                Elm.Case.branch1 (oneOfName ++ "_" ++ variant.name)
                                    ( "content", ann )
                                    variantEncoder
                            )
                            (CliMonad.typeToAnnotation variant.type_)
                            (typeToEncoder variant.type_)
                    )
                |> CliMonad.map
                    (\branches rec ->
                        Elm.Case.custom rec
                            (Elm.Annotation.named [] oneOfName)
                            branches
                    )

        Bytes ->
            CliMonad.todo "encoder for bytes not implemented"
                |> CliMonad.map (\encoder _ -> encoder)

        Unit ->
            CliMonad.succeed (\_ -> Gen.Json.Encode.null)


schemaToDecoder : Json.Schema.Definitions.Schema -> CliMonad Elm.Expression
schemaToDecoder schema =
    schemaToType schema
        |> CliMonad.andThen typeToDecoder


typeToDecoder : Type -> CliMonad Elm.Expression
typeToDecoder type_ =
    case type_ of
        Object properties ->
            let
                propertiesList : List ( String, Field )
                propertiesList =
                    FastDict.toList properties
            in
            List.foldl
                (\( key, field ) prevExprRes ->
                    CliMonad.map2
                        (\internalDecoder prevExpr ->
                            Elm.Op.pipe
                                (Elm.apply
                                    Gen.Json.Decode.Extra.values_.andMap
                                    [ if field.required then
                                        Gen.Json.Decode.field key internalDecoder

                                      else
                                        decodeOptionalField.call (Elm.string key) internalDecoder
                                    ]
                                )
                                prevExpr
                        )
                        (typeToDecoder field.type_)
                        prevExprRes
                )
                (CliMonad.succeed
                    (Gen.Json.Decode.succeed
                        (Elm.function
                            (List.map (\( key, _ ) -> ( toValueName key, Nothing )) propertiesList)
                            (\args ->
                                Elm.record
                                    (List.map2
                                        (\( key, _ ) arg -> ( toValueName key, arg ))
                                        propertiesList
                                        args
                                    )
                            )
                        )
                    )
                )
                propertiesList

        String ->
            CliMonad.succeed Gen.Json.Decode.string

        Int ->
            CliMonad.succeed Gen.Json.Decode.int

        Float ->
            CliMonad.succeed Gen.Json.Decode.float

        Bool ->
            CliMonad.succeed Gen.Json.Decode.bool

        Unit ->
            CliMonad.succeed (Gen.Json.Decode.succeed Elm.unit)

        List t ->
            CliMonad.map Gen.Json.Decode.list
                (typeToDecoder t)

        Value ->
            CliMonad.succeed Gen.Json.Decode.value

        Nullable t ->
            CliMonad.map
                (\decoder ->
                    Gen.Json.Decode.oneOf
                        [ Gen.Json.Decode.call_.map
                            (Elm.val "Present")
                            decoder
                        , Gen.Json.Decode.null (Elm.val "Null")
                        ]
                )
                (typeToDecoder t)

        Named name ->
            CliMonad.succeed (Elm.val ("decode" ++ name))

        OneOf oneOfName variants ->
            variants
                |> CliMonad.combineMap
                    (\variant ->
                        typeToDecoder variant.type_
                            |> CliMonad.map
                                (Gen.Json.Decode.call_.map
                                    (Elm.val
                                        (oneOfName ++ "_" ++ variant.name)
                                    )
                                )
                    )
                |> CliMonad.map
                    (Gen.Json.Decode.oneOf
                        >> Elm.withType (Elm.Annotation.named [] oneOfName)
                    )

        Bytes ->
            CliMonad.todo "Bytes decoder not implemented yet"


{-| Decode an optional field

    decodeString (decodeOptionalField "x" int) "{ \"x\": 3 }"
    --> Ok (Just 3)

    decodeString (decodeOptionalField "x" int) "{ \"x\": true }"
    --> Err ...

    decodeString (decodeOptionalField "x" int) "{ \"y\": 4 }"
    --> Ok Nothing

-}
decodeOptionalField :
    { declaration : Elm.Declaration
    , call : Elm.Expression -> Elm.Expression -> Elm.Expression
    , callFrom : List String -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , value : List String -> Elm.Expression
    }
decodeOptionalField =
    let
        decoderAnnotation : Elm.Annotation.Annotation
        decoderAnnotation =
            Gen.Json.Decode.annotation_.decoder (Elm.Annotation.var "t")

        resultAnnotation : Elm.Annotation.Annotation
        resultAnnotation =
            Gen.Json.Decode.annotation_.decoder (Gen.Maybe.annotation_.maybe <| Elm.Annotation.var "t")
    in
    Elm.Declare.fn2 "decodeOptionalField"
        ( "key", Just Elm.Annotation.string )
        ( "fieldDecoder", Just decoderAnnotation )
    <|
        \key fieldDecoder ->
            -- The tricky part is that we want to make sure that
            -- if the field exists we error out if it has an incorrect shape.
            -- So what we do is we `oneOf` with `value` to avoid the `Nothing` branch,
            -- `andThen` we decode it. This is why we can't just use `maybe`, we would
            -- give `Nothing` when the shape is wrong.
            Gen.Json.Decode.oneOf
                [ Gen.Json.Decode.call_.map
                    (Elm.fn ( "_", Nothing ) <| \_ -> Elm.bool True)
                    (Gen.Json.Decode.call_.field key Gen.Json.Decode.value)
                , Gen.Json.Decode.succeed (Elm.bool False)
                ]
                |> Gen.Json.Decode.andThen
                    (\hasField ->
                        Elm.ifThen hasField
                            (Gen.Json.Decode.call_.field key
                                (Gen.Json.Decode.oneOf
                                    [ Gen.Json.Decode.map Gen.Maybe.make_.just fieldDecoder
                                    , Gen.Json.Decode.null Gen.Maybe.make_.nothing
                                    ]
                                )
                            )
                            (Gen.Json.Decode.succeed Gen.Maybe.make_.nothing)
                    )
                |> Elm.withType resultAnnotation


responseToResult :
    { declaration : Elm.Declaration
    , call : Elm.Expression -> Elm.Expression
    , callFrom : List String -> Elm.Expression -> Elm.Expression
    , value : List String -> Elm.Expression
    }
responseToResult =
    Elm.Declare.fn "responseToResult"
        ( "response"
        , Just <|
            Gen.Http.annotation_.response
                (Elm.Annotation.var "body")
        )
    <|
        \response ->
            Elm.Case.custom
                response
                (Elm.Annotation.namedWith [ "Http" ] "Response" [ Elm.Annotation.var "body" ])
                [ Elm.Case.branch1
                    "BadUrl_"
                    ( "string", Elm.Annotation.string )
                    (\url -> Gen.Result.make_.err <| Gen.Http.make_.badUrl url)
                , Elm.Case.branch0
                    "Timeout_"
                    (Gen.Result.make_.err Gen.Http.make_.timeout)
                , Elm.Case.branch0
                    "NetworkError_"
                    (Gen.Result.make_.err Gen.Http.make_.networkError)
                , Elm.Case.branch2
                    "BadStatus_"
                    ( "metadata", Elm.Annotation.namedWith [ "Http" ] "Metadata" [] )
                    ( "_", Elm.Annotation.var "body" )
                    (\metadata _ -> Gen.Result.make_.err <| Gen.Http.make_.badStatus (Elm.get "statusCode" metadata))
                , Elm.Case.branch2
                    "GoodStatus_"
                    ( "_", Elm.Annotation.namedWith [ "Http" ] "Metadata" [] )
                    ( "body", Elm.Annotation.var "body" )
                    (\_ body -> Gen.Result.make_.ok body)
                ]
                |> Elm.withType
                    (Gen.Result.annotation_.result
                        Gen.Http.annotation_.error
                        (Elm.Annotation.var "body")
                    )


responseToSchema : OpenApi.Response.Response -> CliMonad Json.Schema.Definitions.Schema
responseToSchema response =
    CliMonad.succeed response
        |> stepOrFail "Could not get application's application/json content"
            (OpenApi.Response.content
                >> Dict.get "application/json"
            )
        |> stepOrFail "The response's application/json content option doesn't have a schema"
            OpenApi.MediaType.schema
        |> CliMonad.map OpenApi.Schema.get


schemaToAnnotation : Json.Schema.Definitions.Schema -> CliMonad Elm.Annotation.Annotation
schemaToAnnotation schema =
    schemaToType schema |> CliMonad.andThen CliMonad.typeToAnnotation


schemaToType : Json.Schema.Definitions.Schema -> CliMonad Type
schemaToType schema =
    case schema of
        Json.Schema.Definitions.BooleanSchema _ ->
            CliMonad.todoWithDefault Value "Boolean schema"

        Json.Schema.Definitions.ObjectSchema subSchema ->
            let
                nullable : CliMonad Type -> CliMonad Type
                nullable =
                    CliMonad.map Nullable

                singleTypeToType : Json.Schema.Definitions.SingleType -> CliMonad Type
                singleTypeToType singleType =
                    case singleType of
                        Json.Schema.Definitions.ObjectType ->
                            objectSchemaToType subSchema

                        Json.Schema.Definitions.StringType ->
                            CliMonad.succeed String

                        Json.Schema.Definitions.IntegerType ->
                            CliMonad.succeed Int

                        Json.Schema.Definitions.NumberType ->
                            CliMonad.succeed Float

                        Json.Schema.Definitions.BooleanType ->
                            CliMonad.succeed Bool

                        Json.Schema.Definitions.NullType ->
                            CliMonad.todoWithDefault Value "Null type annotation"

                        Json.Schema.Definitions.ArrayType ->
                            case subSchema.items of
                                Json.Schema.Definitions.NoItems ->
                                    CliMonad.fail "Found an array type but no items definition"

                                Json.Schema.Definitions.ArrayOfItems _ ->
                                    CliMonad.todoWithDefault Value "Array of items as item definition"

                                Json.Schema.Definitions.ItemDefinition itemSchema ->
                                    CliMonad.map List (schemaToType itemSchema)

                anyOfToType : List Json.Schema.Definitions.Schema -> CliMonad Type
                anyOfToType _ =
                    CliMonad.succeed Value

                oneOfToType : List Json.Schema.Definitions.Schema -> CliMonad Type
                oneOfToType oneOf =
                    let
                        extractSubSchema : Json.Schema.Definitions.Schema -> CliMonad (Maybe { name : String, type_ : Type })
                        extractSubSchema s =
                            schemaToType s
                                |> CliMonad.andThen
                                    (\t ->
                                        t
                                            |> CliMonad.typeToAnnotation
                                            |> CliMonad.map
                                                (\ann ->
                                                    let
                                                        rawName : TypeName
                                                        rawName =
                                                            ann
                                                                |> Elm.ToString.annotation
                                                                |> .signature
                                                                |> typifyName
                                                    in
                                                    if String.contains "{" rawName then
                                                        Nothing

                                                    else
                                                        Just
                                                            { name = rawName
                                                            , type_ = t
                                                            }
                                                )
                                    )
                    in
                    CliMonad.combineMap extractSubSchema oneOf
                        |> CliMonad.map
                            (\maybeVariants ->
                                case Maybe.Extra.combine maybeVariants of
                                    Nothing ->
                                        Value

                                    Just variants ->
                                        let
                                            names : List String
                                            names =
                                                List.map .name variants
                                        in
                                        OneOf (String.join "Or" names) variants
                            )
            in
            case subSchema.type_ of
                Json.Schema.Definitions.SingleType singleType ->
                    singleTypeToType singleType

                Json.Schema.Definitions.AnyType ->
                    case subSchema.ref of
                        Just ref ->
                            CliMonad.map Named <| schemaTypeRef ref

                        Nothing ->
                            case subSchema.anyOf of
                                Just [ onlySchema ] ->
                                    schemaToType onlySchema

                                Just [ firstSchema, secondSchema ] ->
                                    case ( firstSchema, secondSchema ) of
                                        ( Json.Schema.Definitions.ObjectSchema firstSubSchema, Json.Schema.Definitions.ObjectSchema secondSubSchema ) ->
                                            -- The first 2 cases here are for pseudo-nullable schemas where the higher level schema type is AnyOf
                                            -- but it's actually made up of only 2 types and 1 of them is nullable. This acts as a hack of sorts to
                                            -- mark a value as nullable in the schema.
                                            case ( firstSubSchema.type_, secondSubSchema.type_ ) of
                                                ( Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType, _ ) ->
                                                    nullable (schemaToType secondSchema)

                                                ( _, Json.Schema.Definitions.SingleType Json.Schema.Definitions.NullType ) ->
                                                    nullable (schemaToType firstSchema)

                                                _ ->
                                                    anyOfToType [ firstSchema, secondSchema ]

                                        _ ->
                                            anyOfToType [ firstSchema, secondSchema ]

                                Just anyOf ->
                                    anyOfToType anyOf

                                Nothing ->
                                    case subSchema.allOf of
                                        Just [ onlySchema ] ->
                                            schemaToType onlySchema

                                        Just [] ->
                                            CliMonad.succeed Value

                                        Just _ ->
                                            -- If we have more than one item in `allOf`, then it's _probably_ an object
                                            -- TODO: improve this to actually check if all the `allOf` subschema are objects.
                                            objectSchemaToType subSchema

                                        Nothing ->
                                            case subSchema.oneOf of
                                                Just [ onlySchema ] ->
                                                    schemaToType onlySchema

                                                Just [] ->
                                                    CliMonad.succeed Value

                                                Just oneOfs ->
                                                    oneOfToType oneOfs

                                                Nothing ->
                                                    CliMonad.succeed Value

                Json.Schema.Definitions.NullableType singleType ->
                    nullable (singleTypeToType singleType)

                Json.Schema.Definitions.UnionType _ ->
                    CliMonad.todoWithDefault Value "union type"


objectSchemaToType : Json.Schema.Definitions.SubSchema -> CliMonad Type
objectSchemaToType subSchema =
    let
        propertiesFromSchema : Json.Schema.Definitions.SubSchema -> CliMonad (Dict String Field)
        propertiesFromSchema sch =
            let
                requiredSet : Set String
                requiredSet =
                    sch.required
                        |> Maybe.withDefault []
                        |> Set.fromList
            in
            sch.properties
                |> Maybe.map (\(Json.Schema.Definitions.Schemata schemata) -> schemata)
                |> Maybe.withDefault []
                |> CliMonad.combineMap
                    (\( key, valueSchema ) ->
                        schemaToType valueSchema
                            |> CliMonad.withPath key
                            |> CliMonad.map
                                (\type_ ->
                                    ( key
                                    , { type_ = type_
                                      , required = Set.member key requiredSet
                                      }
                                    )
                                )
                    )
                |> CliMonad.map FastDict.fromList

        schemaToProperties : Json.Schema.Definitions.Schema -> CliMonad (Dict String Field)
        schemaToProperties allOfItem =
            case allOfItem of
                Json.Schema.Definitions.ObjectSchema allOfItemSchema ->
                    CliMonad.map2 FastDict.union
                        (propertiesFromSchema allOfItemSchema)
                        (propertiesFromRef allOfItemSchema)

                Json.Schema.Definitions.BooleanSchema _ ->
                    CliMonad.todoWithDefault FastDict.empty "Boolean schema inside allOf"

        propertiesFromRef : Json.Schema.Definitions.SubSchema -> CliMonad (Dict String Field)
        propertiesFromRef allOfItem =
            case allOfItem.ref of
                Nothing ->
                    CliMonad.succeed FastDict.empty

                Just ref ->
                    case String.split "/" ref of
                        [ "#", "components", "schemas", refName ] ->
                            CliMonad.fromApiSpec OpenApi.components
                                |> CliMonad.andThen
                                    (\maybeComponents ->
                                        case maybeComponents of
                                            Nothing ->
                                                CliMonad.fail <| "Could not find components in the schema, while looking up" ++ ref

                                            Just components ->
                                                case Dict.get refName (OpenApi.Components.schemas components) of
                                                    Nothing ->
                                                        CliMonad.fail <| "Could not find component's schema, while looking up" ++ ref

                                                    Just found ->
                                                        found
                                                            |> OpenApi.Schema.get
                                                            |> schemaToProperties
                                                            |> CliMonad.withPath refName
                                    )

                        _ ->
                            CliMonad.fail <| "Cannot understand reference " ++ ref

        propertiesFromAllOf : CliMonad (Dict String Field)
        propertiesFromAllOf =
            subSchema.allOf
                |> Maybe.withDefault []
                |> CliMonad.combineMap schemaToProperties
                |> CliMonad.map (List.foldl FastDict.union FastDict.empty)
    in
    CliMonad.map2
        (\schemaProps allOfProps ->
            allOfProps
                |> FastDict.union schemaProps
                |> Object
        )
        (propertiesFromSchema subSchema)
        propertiesFromAllOf


makeNamespaceValid : String -> String
makeNamespaceValid str =
    String.map
        (\char ->
            if List.member char invalidModuleNameChars then
                '_'

            else
                char
        )
        str


removeInvalidChars : String -> String
removeInvalidChars str =
    String.filter (\char -> char /= '\'') str


invalidModuleNameChars : List Char
invalidModuleNameChars =
    [ ' '
    , '.'
    , '/'
    , '{'
    , '}'
    , '-'
    ]
