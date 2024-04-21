module OpenApi.Generate exposing
    ( ContentSchema(..)
    , Mime
    , file
    , sanitizeModuleName
    )

import Cli.Validate exposing (ValidationResult(..), regex)
import CliMonad exposing (CliMonad, Message)
import Common exposing (Field, FieldName, Type(..), TypeName, toValueName, typifyName)
import Dict
import Dict.Extra
import Elm
import Elm.Annotation
import Elm.Case
import Elm.Declare
import Elm.Op
import Elm.ToString
import FastDict
import Gen.Basics
import Gen.Bytes
import Gen.Debug
import Gen.Dict
import Gen.Http
import Gen.Json.Decode
import Gen.Json.Encode
import Gen.List
import Gen.Maybe
import Gen.Result
import Gen.String
import Gen.Task
import Gen.Url.Builder
import Json.Schema.Definitions
import List.Extra
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
import SchemaUtils exposing (getAlias, schemaToAnnotation, schemaToType)
import String.Extra
import Util.List


type alias Mime =
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


file : { namespace : String, generateTodos : Bool } -> OpenApi.OpenApi -> Result Message ( Elm.File, List Message )
file { namespace, generateTodos } apiSpec =
    CliMonad.combine
        [ pathDeclarations
        , CliMonad.succeed
            [ decodeOptionalField.declaration
            , responseToResult.declaration
            , customHttpError
            , expectJsonCustom.declaration
            , jsonResolverCustom.declaration
            , whateverResolver.declaration
            , jsonDecodeAndMap
            , nullableType
            ]
        , componentDeclarations
        , responsesDeclarations
        , requestBodiesDeclarations
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
                    |> CliMonad.map List.concat
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


requestBodiesDeclarations : CliMonad (List Elm.Declaration)
requestBodiesDeclarations =
    CliMonad.fromApiSpec
        (OpenApi.components
            >> Maybe.map OpenApi.Components.requestBodies
            >> Maybe.withDefault Dict.empty
        )
        |> CliMonad.andThen
            (Dict.foldl
                (\name schema ->
                    CliMonad.map2 (::)
                        (requestBodyToDeclarations name schema)
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


unitDeclarations : String -> CliMonad (List Elm.Declaration)
unitDeclarations name =
    let
        typeName : TypeName
        typeName =
            typifyName name
    in
    CliMonad.combine
        [ Elm.alias typeName Elm.Annotation.unit
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
            (typeToDecoder Unit)
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
            (typeToEncoder Unit)
        ]


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
                unitDeclarations name

            else
                responseToSchema response
                    |> CliMonad.withPath name
                    |> CliMonad.andThen (schemaToDeclarations name)

        Nothing ->
            CliMonad.fail "Could not convert reference to concrete value"
                |> CliMonad.withPath name


requestBodyToDeclarations : String -> OpenApi.Reference.ReferenceOr OpenApi.RequestBody.RequestBody -> CliMonad (List Elm.Declaration)
requestBodyToDeclarations name reference =
    case OpenApi.Reference.toConcrete reference of
        Just requestBody ->
            let
                content : Dict.Dict String OpenApi.MediaType.MediaType
                content =
                    OpenApi.RequestBody.content requestBody
            in
            if Dict.isEmpty content then
                -- If there is no content then we go with the unit value, `()` as the requestBody type
                unitDeclarations name

            else
                requestBodyToSchema requestBody
                    |> CliMonad.withPath name
                    |> CliMonad.andThen (schemaToDeclarations name)

        Nothing ->
            CliMonad.fail "Could not convert reference to concrete value"
                |> CliMonad.withPath name


toRequestFunctions : String -> String -> OpenApi.Operation.Operation -> CliMonad (List Elm.Declaration)
toRequestFunctions method pathUrl operation =
    let
        functionName : String
        functionName =
            OpenApi.Operation.operationId operation
                |> Maybe.withDefault pathUrl
                |> makeNamespaceValid
                |> removeInvalidChars
                |> String.Extra.camelize
    in
    operationToTypesExpectAndResolver functionName operation
        |> CliMonad.andThen
            (\{ successType, bodyTypeAnnotation, errorTypeDeclaration, errorTypeAnnotation, toExpect, resolver } ->
                let
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
                                                paramToType concreteParam
                                                    |> CliMonad.andThen
                                                        (\( paramName, type_ ) ->
                                                            paramToString type_
                                                                |> CliMonad.map
                                                                    (\{ toString, alwaysJust } ->
                                                                        { concreteParam = concreteParam
                                                                        , paramName = paramName
                                                                        , toString = toString
                                                                        , alwaysJust = alwaysJust
                                                                        }
                                                                    )
                                                        )
                                            )
                                        |> CliMonad.andThen
                                            (\{ concreteParam, paramName, toString, alwaysJust } ->
                                                case OpenApi.Parameter.in_ concreteParam of
                                                    "path" ->
                                                        if OpenApi.Parameter.required concreteParam && alwaysJust then
                                                            CliMonad.succeed
                                                                ( Just
                                                                    ( -- This is used for the basic URL replacement in a static path
                                                                      \config ->
                                                                        Elm.get (toValueName paramName) (Elm.get "params" config)
                                                                            |> toString
                                                                            |> Gen.String.call_.replace
                                                                                (Elm.string <| "{" ++ paramName ++ "}")
                                                                    , -- This is used for segment replacement when usig `Url.Builder.crossOrigin`
                                                                      ( "{" ++ paramName ++ "}"
                                                                      , \config ->
                                                                            Elm.get (toValueName paramName) (Elm.get "params" config)
                                                                                |> toString
                                                                      )
                                                                    )
                                                                , []
                                                                )

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
                                        ( replacements, queryParams ) =
                                            List.unzip pairs
                                                |> Tuple.mapBoth (List.filterMap identity) List.concat
                                    in
                                    if List.isEmpty queryParams then
                                        OpenApi.servers
                                            |> CliMonad.fromApiSpec
                                            |> CliMonad.map
                                                (\servers ->
                                                    \config ->
                                                        let
                                                            initialUrl =
                                                                case servers of
                                                                    [] ->
                                                                        pathUrl

                                                                    firstServer :: _ ->
                                                                        if String.startsWith "/" pathUrl then
                                                                            OpenApi.Server.url firstServer ++ pathUrl

                                                                        else
                                                                            OpenApi.Server.url firstServer ++ "/" ++ pathUrl
                                                        in
                                                        List.foldl
                                                            (\( replacement, _ ) -> replacement config)
                                                            (Elm.string initialUrl)
                                                            replacements
                                                )

                                    else
                                        let
                                            serverUrl : CliMonad String
                                            serverUrl =
                                                CliMonad.fromApiSpec OpenApi.servers
                                                    |> CliMonad.map
                                                        (\servers ->
                                                            case servers of
                                                                [] ->
                                                                    ""

                                                                firstServer :: _ ->
                                                                    OpenApi.Server.url firstServer
                                                        )
                                        in
                                        queryParams
                                            |> CliMonad.combineMap queryParameterToUrlBuilderArgument
                                            |> CliMonad.map2
                                                (\srvUrl queryArgs config ->
                                                    queryArgs
                                                        |> List.map (\arg -> arg config)
                                                        |> Gen.List.filterMap Gen.Basics.identity
                                                        |> Gen.Url.Builder.call_.crossOrigin
                                                            (Elm.string srvUrl)
                                                            (pathUrl
                                                                |> String.split "/"
                                                                |> List.filterMap
                                                                    (\segment ->
                                                                        if String.isEmpty segment then
                                                                            Nothing

                                                                        else
                                                                            Just <|
                                                                                case List.Extra.find (\( _, ( pattern, _ ) ) -> pattern == segment) replacements of
                                                                                    Nothing ->
                                                                                        Elm.string segment

                                                                                    Just ( _, ( _, repl ) ) ->
                                                                                        repl config
                                                                    )
                                                                |> Elm.list
                                                            )
                                                )
                                                serverUrl
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
                        toExpect (Elm.get "toMsg" config)

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

                    requestCommand : ContentSchema -> CliMonad ( Elm.Expression, Elm.Expression, Elm.Annotation.Annotation )
                    requestCommand bodyContent =
                        authorizationInfo
                            |> CliMonad.andThen
                                (\auth ->
                                    CliMonad.map3
                                        (\toBody paramType replaced ->
                                            ( Elm.fn
                                                ( "config", Nothing )
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
                                            , Elm.fn
                                                ( "config", Nothing )
                                                (\config ->
                                                    Gen.Http.call_.riskyRequest
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
                                                    , errorBodyAnnotation = bodyTypeAnnotation
                                                    , errorTypeAnnotation = errorTypeAnnotation
                                                    , authorizationInfo = auth
                                                    , bodyParams = bp
                                                    }
                                            )
                                            (bodyParams bodyContent)
                                            (CliMonad.typeToAnnotation successType)
                                        )
                                        replacedUrl
                                )

                    requestTask : ContentSchema -> CliMonad ( Elm.Expression, Elm.Expression, Elm.Annotation.Annotation )
                    requestTask bodyContent =
                        CliMonad.andThen2
                            (\auth successAnnotation ->
                                CliMonad.map3
                                    (\toBody paramType replaced ->
                                        ( Elm.fn
                                            ( "config", Nothing )
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
                                        , Elm.fn
                                            ( "config", Nothing )
                                            (\config ->
                                                Gen.Http.call_.riskyTask
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
                                                (customErrorAnnotation errorTypeAnnotation bodyTypeAnnotation)
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
                                                , errorBodyAnnotation = bodyTypeAnnotation
                                                , errorTypeAnnotation = errorTypeAnnotation
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
                        (\doc ( ( requestCmd, riskyCmd, requestCmdType ), ( requestTsk, riskyTask, requestTskType ) ) ->
                            [ requestCmd
                                |> Elm.withType requestCmdType
                                |> Elm.declaration functionName
                                |> Elm.withDocumentation doc
                                |> Elm.exposeWith
                                    { exposeConstructor = False
                                    , group = Just "Request functions"
                                    }
                            , riskyCmd
                                |> Elm.withType requestCmdType
                                |> Elm.declaration (functionName ++ "Risky")
                                |> Elm.withDocumentation doc
                                |> Elm.exposeWith
                                    { exposeConstructor = False
                                    , group = Just "Request functions"
                                    }
                            , requestTsk
                                |> Elm.withType requestTskType
                                |> Elm.declaration (functionName ++ "Task")
                                |> Elm.withDocumentation doc
                                |> Elm.exposeWith
                                    { exposeConstructor = False
                                    , group = Just "Request functions"
                                    }
                            , riskyTask
                                |> Elm.withType requestTskType
                                |> Elm.declaration (functionName ++ "TaskRisky")
                                |> Elm.withDocumentation doc
                                |> Elm.exposeWith
                                    { exposeConstructor = False
                                    , group = Just "Request functions"
                                    }
                            , errorTypeDeclaration
                            ]
                        )
                        documentation
            )
        |> CliMonad.withPath method
        |> CliMonad.withPath pathUrl


customErrorAnnotation : Elm.Annotation.Annotation -> Elm.Annotation.Annotation -> Elm.Annotation.Annotation
customErrorAnnotation errorTypeAnnotation bodyTypeAnnotation =
    Elm.Annotation.namedWith []
        "Error"
        [ errorTypeAnnotation
        , bodyTypeAnnotation
        ]


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

        [ [ ( "Token", [] ) ] ] ->
            CliMonad.succeed
                { headers =
                    \config ->
                        [ Gen.Http.call_.header (Elm.string "authorization")
                            (Elm.Op.append
                                (Elm.string "Token ")
                                (config
                                    |> Elm.get "authorization"
                                    |> Elm.get "token"
                                )
                            )
                        ]
                , params =
                    [ ( "authorization"
                      , Elm.Annotation.record
                            [ ( "token"
                              , Elm.Annotation.string
                              )
                            ]
                      )
                    ]
                , scopes = []
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
                        |> CliMonad.stepOrFail "I found a successfull response, but I couldn't convert it to a concrete one"
                            OpenApi.Reference.toReference
                        |> CliMonad.map (\ref -> JsonContent (Ref <| String.split "/" <| OpenApi.Reference.ref ref))


regexToCheckIfJson : String -> Cli.Validate.ValidationResult
regexToCheckIfJson =
    regex "^application\\/(vnd\\.[a-z0-9]+(\\.v\\d+)?(\\.[a-z0-9]+)?)?\\+?json$"


searchForJsonMediaType : String -> a -> Bool
searchForJsonMediaType mediaType _ =
    case regexToCheckIfJson mediaType of
        Valid ->
            True

        Invalid _ ->
            False


contentToContentSchema : Dict.Dict String OpenApi.MediaType.MediaType -> CliMonad ContentSchema
contentToContentSchema content =
    let
        default : Maybe (CliMonad ContentSchema) -> CliMonad ContentSchema
        default fallback =
            let
                maybeJsonMediaType : Maybe OpenApi.MediaType.MediaType
                maybeJsonMediaType =
                    Dict.Extra.find searchForJsonMediaType content
                        |> Maybe.map Tuple.second
            in
            case maybeJsonMediaType of
                Just jsonSchema ->
                    CliMonad.succeed jsonSchema
                        |> CliMonad.stepOrFail "The request's application/json content option doesn't have a schema"
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
                |> CliMonad.stepOrFail ("The request's " ++ mime ++ " content option doesn't have a schema")
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
    , errorBodyAnnotation : Elm.Annotation.Annotation
    , errorTypeAnnotation : Elm.Annotation.Annotation
    , authorizationInfo : AuthorizationInfo
    , bodyParams : List ( String, Elm.Annotation.Annotation )
    }
    -> CliMonad Elm.Annotation.Annotation
toConfigParamAnnotation options =
    CliMonad.map
        (\urlParams ->
            (options.authorizationInfo.params
                ++ (if options.requireToMsg then
                        [ ( "toMsg"
                          , Elm.Annotation.function
                                [ Gen.Result.annotation_.result
                                    (customErrorAnnotation options.errorTypeAnnotation options.errorBodyAnnotation)
                                    options.successAnnotation
                                ]
                                (Elm.Annotation.var "msg")
                          )
                        ]

                    else
                        []
                   )
                ++ options.bodyParams
                ++ urlParams
            )
                |> CliMonad.recordType
        )
        (operationToUrlParams options.operation)


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

        Ref ref ->
            --  These are mostly aliases
            getAlias ref
                |> CliMonad.andThen schemaToType
                |> CliMonad.andThen paramToString

        OneOf name data ->
            CliMonad.map2
                (\valType branches ->
                    { toString =
                        \val -> Elm.Case.custom val valType branches
                    , alwaysJust = True
                    }
                )
                (CliMonad.typeToAnnotation type_)
                (CliMonad.combineMap
                    (\alternative ->
                        CliMonad.andThen2
                            (\{ toString, alwaysJust } annotation ->
                                if not alwaysJust then
                                    CliMonad.fail "Nullable alternative"

                                else
                                    Elm.Case.branch1 (name ++ "_" ++ alternative.name) ( "alternative", annotation ) toString
                                        |> CliMonad.succeed
                            )
                            (paramToString alternative.type_)
                            (CliMonad.typeToAnnotation alternative.type_)
                    )
                    data
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
        |> CliMonad.stepOrFail ("Could not get schema for parameter " ++ pname)
            (OpenApi.Parameter.schema >> Maybe.map OpenApi.Schema.get)
        |> CliMonad.andThen schemaToType
        |> CliMonad.andThen
            (\type_ ->
                case type_ of
                    Ref ref ->
                        ref
                            |> getAlias
                            |> CliMonad.andThen schemaToType
                            |> CliMonad.map
                                (\inner ->
                                    case inner of
                                        Nullable _ ->
                                            -- If it's a ref to a nullable type, we don't want another layer of nullable
                                            inner

                                        _ ->
                                            if OpenApi.Parameter.required concreteParam then
                                                type_

                                            else
                                                Nullable type_
                                )

                    _ ->
                        if OpenApi.Parameter.required concreteParam then
                            CliMonad.succeed type_

                        else
                            CliMonad.succeed <| Nullable type_
            )
        |> CliMonad.map (Tuple.pair pname)


toConcreteParam : OpenApi.Reference.ReferenceOr OpenApi.Parameter.Parameter -> CliMonad OpenApi.Parameter.Parameter
toConcreteParam param =
    case OpenApi.Reference.toConcrete param of
        Just concreteParam ->
            CliMonad.succeed concreteParam

        Nothing ->
            CliMonad.succeed param
                |> CliMonad.stepOrFail "I found a params, but I couldn't convert it to a concrete one" OpenApi.Reference.toReference
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


operationToTypesExpectAndResolver :
    String
    -> OpenApi.Operation.Operation
    ->
        CliMonad
            { successType : Type
            , bodyTypeAnnotation : Elm.Annotation.Annotation
            , errorTypeDeclaration : Elm.Declaration
            , errorTypeAnnotation : Elm.Annotation.Annotation
            , toExpect : Elm.Expression -> Elm.Expression
            , resolver : Elm.Expression
            }
operationToTypesExpectAndResolver functionName operation =
    let
        responses : Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response)
        responses =
            OpenApi.Operation.responses operation

        expectJsonBetter : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
        expectJsonBetter errorDecoders successDecoder toMsg =
            expectJsonCustom.call toMsg errorDecoders successDecoder
    in
    CliMonad.succeed responses
        |> CliMonad.stepOrFail
            ("Among the "
                ++ String.fromInt (Dict.size responses)
                ++ " possible responses, there was no successfull one."
            )
            getFirstSuccessResponse
        |> CliMonad.andThen
            (\( _, responseOrRef ) ->
                let
                    errorResponses : Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response)
                    errorResponses =
                        getErrorResponses responses

                    toErrorVariant : String -> String
                    toErrorVariant statusCode =
                        String.Extra.toSentenceCase functionName ++ "_" ++ statusCode

                    errorDecoders : CliMonad Elm.Expression
                    errorDecoders =
                        errorResponses
                            |> Dict.map
                                (\statusCode errRespOrRef ->
                                    case OpenApi.Reference.toConcrete errRespOrRef of
                                        Just errResp ->
                                            OpenApi.Response.content errResp
                                                |> contentToContentSchema
                                                |> CliMonad.andThen
                                                    (\contentSchema ->
                                                        case contentSchema of
                                                            JsonContent type_ ->
                                                                typeToDecoder type_
                                                                    |> CliMonad.map
                                                                        (toErrorVariant statusCode
                                                                            |> Elm.val
                                                                            |> Gen.Json.Decode.call_.map
                                                                        )

                                                            StringContent _ ->
                                                                CliMonad.succeed Gen.Json.Decode.string
                                                                    |> CliMonad.map
                                                                        (toErrorVariant statusCode
                                                                            |> Elm.val
                                                                            |> Gen.Json.Decode.call_.map
                                                                        )

                                                            BytesContent _ ->
                                                                CliMonad.succeed (Gen.Debug.todo "decode bytes err?")
                                                                    |> CliMonad.map
                                                                        (toErrorVariant statusCode
                                                                            |> Elm.val
                                                                            |> Gen.Json.Decode.call_.map
                                                                        )

                                                            EmptyContent ->
                                                                CliMonad.succeed (Gen.Json.Decode.succeed Elm.unit)
                                                                    |> CliMonad.map
                                                                        (toErrorVariant statusCode
                                                                            |> Elm.val
                                                                            |> Gen.Json.Decode.call_.map
                                                                        )
                                                    )

                                        Nothing ->
                                            CliMonad.succeed errRespOrRef
                                                |> CliMonad.stepOrFail "I found an error response, but I couldn't convert it to a concrete decoder"
                                                    OpenApi.Reference.toReference
                                                |> CliMonad.andThen
                                                    (\ref ->
                                                        let
                                                            inner : String
                                                            inner =
                                                                OpenApi.Reference.ref ref
                                                        in
                                                        CliMonad.refToTypeName (String.split "/" inner)
                                                            |> CliMonad.map
                                                                (\typeName ->
                                                                    Elm.val ("decode" ++ typeName)
                                                                )
                                                            |> CliMonad.map
                                                                (toErrorVariant statusCode
                                                                    |> Elm.val
                                                                    |> Gen.Json.Decode.call_.map
                                                                )
                                                    )
                                )
                            |> CliMonad.combineDict
                            |> CliMonad.map
                                (\decoders ->
                                    Dict.toList decoders
                                        |> List.map (\( k, v ) -> Elm.tuple (Elm.string k) v)
                                        |> Elm.list
                                        |> Gen.Dict.call_.fromList
                                )

                    errorTypeDeclaration : CliMonad ( Elm.Declaration, Elm.Annotation.Annotation )
                    errorTypeDeclaration =
                        errorResponses
                            |> Dict.map
                                (\_ errRespOrRef ->
                                    case OpenApi.Reference.toConcrete errRespOrRef of
                                        Just errResp ->
                                            OpenApi.Response.content errResp
                                                |> contentToContentSchema
                                                |> CliMonad.andThen
                                                    (\contentSchema ->
                                                        case contentSchema of
                                                            JsonContent type_ ->
                                                                CliMonad.typeToAnnotation type_

                                                            StringContent _ ->
                                                                CliMonad.succeed Elm.Annotation.string

                                                            BytesContent _ ->
                                                                CliMonad.succeed Gen.Bytes.annotation_.bytes

                                                            EmptyContent ->
                                                                CliMonad.succeed Elm.Annotation.unit
                                                    )

                                        Nothing ->
                                            CliMonad.succeed errRespOrRef
                                                |> CliMonad.stepOrFail "I found an error response, but I couldn't convert it to a concrete annotation"
                                                    OpenApi.Reference.toReference
                                                |> CliMonad.andThen
                                                    (\ref ->
                                                        let
                                                            inner : String
                                                            inner =
                                                                OpenApi.Reference.ref ref
                                                        in
                                                        CliMonad.refToTypeName (String.split "/" inner)
                                                            |> CliMonad.map
                                                                (\typeName ->
                                                                    Elm.Annotation.named [] typeName
                                                                )
                                                    )
                                )
                            |> CliMonad.combineDict
                            |> CliMonad.map
                                (\dict ->
                                    let
                                        errorName : String
                                        errorName =
                                            String.Extra.toSentenceCase functionName ++ "_Error"
                                    in
                                    ( dict
                                        |> Dict.toList
                                        |> List.map (\( statusCode, annotation ) -> Elm.variantWith (toErrorVariant statusCode) [ annotation ])
                                        |> Elm.customType errorName
                                        |> Elm.exposeWith
                                            { exposeConstructor = True
                                            , group = Just "Types"
                                            }
                                    , Elm.Annotation.named [] errorName
                                    )
                                )
                in
                case OpenApi.Reference.toConcrete responseOrRef of
                    Just response ->
                        OpenApi.Response.content response
                            |> contentToContentSchema
                            |> CliMonad.andThen
                                (\contentSchema ->
                                    case contentSchema of
                                        JsonContent type_ ->
                                            CliMonad.map3
                                                (\successDecoder errorDecoders_ ( errorTypeDeclaration_, errorTypeAnnotation ) ->
                                                    { successType = type_
                                                    , bodyTypeAnnotation = Elm.Annotation.string
                                                    , errorTypeDeclaration = errorTypeDeclaration_
                                                    , errorTypeAnnotation = errorTypeAnnotation
                                                    , toExpect = expectJsonBetter errorDecoders_ successDecoder
                                                    , resolver = jsonResolverCustom.call errorDecoders_ successDecoder
                                                    }
                                                )
                                                (typeToDecoder type_)
                                                errorDecoders
                                                errorTypeDeclaration

                                        StringContent _ ->
                                            CliMonad.map
                                                (\( errorTypeDeclaration_, errorTypeAnnotation ) ->
                                                    { successType = String
                                                    , bodyTypeAnnotation = Elm.Annotation.string
                                                    , errorTypeDeclaration = errorTypeDeclaration_
                                                    , errorTypeAnnotation = errorTypeAnnotation
                                                    , toExpect = Gen.Http.call_.expectString
                                                    , resolver = Gen.Http.stringResolver responseToResult.call
                                                    }
                                                )
                                                errorTypeDeclaration

                                        BytesContent _ ->
                                            CliMonad.map
                                                (\( errorTypeDeclaration_, errorTypeAnnotation ) ->
                                                    { successType = Bytes
                                                    , bodyTypeAnnotation = Gen.Bytes.annotation_.bytes
                                                    , errorTypeDeclaration = errorTypeDeclaration_
                                                    , errorTypeAnnotation = errorTypeAnnotation
                                                    , toExpect = \toMsg -> Gen.Http.call_.expectBytes toMsg Gen.Basics.values_.identity
                                                    , resolver = Gen.Http.bytesResolver responseToResult.call
                                                    }
                                                )
                                                errorTypeDeclaration

                                        EmptyContent ->
                                            CliMonad.map
                                                (\( errorTypeDeclaration_, errorTypeAnnotation ) ->
                                                    { successType = Unit
                                                    , bodyTypeAnnotation = Elm.Annotation.unit
                                                    , errorTypeDeclaration = errorTypeDeclaration_
                                                    , errorTypeAnnotation = errorTypeAnnotation
                                                    , toExpect = Gen.Http.call_.expectWhatever
                                                    , resolver = whateverResolver.call []
                                                    }
                                                )
                                                errorTypeDeclaration
                                )

                    Nothing ->
                        CliMonad.succeed responseOrRef
                            |> CliMonad.stepOrFail "I found a successfull response, but I couldn't convert it to a concrete one"
                                OpenApi.Reference.toReference
                            |> CliMonad.andThen
                                (\ref ->
                                    let
                                        inner : String
                                        inner =
                                            OpenApi.Reference.ref ref
                                    in
                                    CliMonad.refToTypeName (String.split "/" inner)
                                        |> CliMonad.map3
                                            (\errorDecoders_ ( errorTypeDeclaration_, errorTypeAnnotation ) typeName ->
                                                { successType = Common.ref inner
                                                , bodyTypeAnnotation = Elm.Annotation.string
                                                , errorTypeDeclaration = errorTypeDeclaration_
                                                , errorTypeAnnotation = errorTypeAnnotation
                                                , toExpect = expectJsonBetter errorDecoders_ (Elm.val ("decode" ++ typeName))
                                                , resolver = jsonResolverCustom.call errorDecoders_ <| Elm.val ("decode" ++ typeName)
                                                }
                                            )
                                            errorDecoders
                                            errorTypeDeclaration
                                )
            )


customHttpError : Elm.Declaration
customHttpError =
    Elm.customType "Error"
        [ Elm.variantWith "BadUrl" [ Elm.Annotation.string ]
        , Elm.variant "Timeout"
        , Elm.variant "NetworkError"
        , Elm.variantWith "KnownBadStatus" [ Elm.Annotation.int, Elm.Annotation.var "err" ]
        , Elm.variantWith "UnknownBadStatus" [ Gen.Http.annotation_.metadata, Elm.Annotation.var "body" ]
        , Elm.variantWith "BadErrorBody" [ Gen.Http.annotation_.metadata, Elm.Annotation.var "body" ]
        , Elm.variantWith "BadBody" [ Gen.Http.annotation_.metadata, Elm.Annotation.var "body" ]
        ]
        |> Elm.exposeWith
            { exposeConstructor = True
            , group = Just "Types"
            }


expectJsonCustom :
    { declaration : Elm.Declaration
    , call : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , callFrom : List String -> Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , value : List String -> Elm.Expression
    }
expectJsonCustom =
    Elm.Declare.fn3 "expectJsonCustom"
        ( "toMsg"
        , Just
            (Elm.Annotation.function
                [ Gen.Result.annotation_.result
                    (Elm.Annotation.namedWith [] "Error" [ Elm.Annotation.var "err", Elm.Annotation.string ])
                    (Elm.Annotation.var "success")
                ]
                (Elm.Annotation.var "msg")
            )
        )
        ( "errorDecoders"
        , Just
            (Gen.Dict.annotation_.dict
                Gen.String.annotation_.string
                (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.var "err"))
            )
        )
        ( "successDecoder"
        , Just
            (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.var "success"))
        )
        (\toMsg errorDecoders successDecoder ->
            Gen.Http.expectStringResponse (\result -> Elm.apply toMsg [ result ]) <|
                \response ->
                    Gen.Http.caseOf_.response response
                        { badUrl_ = \url -> Gen.Result.make_.err (Elm.apply (Elm.val "BadUrl") [ url ])
                        , timeout_ = Gen.Result.make_.err (Elm.val "Timeout")
                        , networkError_ = Gen.Result.make_.err (Elm.val "NetworkError")
                        , badStatus_ =
                            \metadata body ->
                                Gen.Maybe.caseOf_.maybe
                                    (Gen.Dict.call_.get (Gen.String.call_.fromInt (Elm.get "statusCode" metadata)) errorDecoders)
                                    { nothing = Gen.Result.make_.err (Elm.apply (Elm.val "UnknownBadStatus") [ metadata, body ])
                                    , just =
                                        \errorDecoder ->
                                            Gen.Result.caseOf_.result
                                                (Gen.Json.Decode.call_.decodeString errorDecoder body)
                                                { ok = \x -> Gen.Result.make_.err (Elm.apply (Elm.val "KnownBadStatus") [ Elm.get "statusCode" metadata, x ])
                                                , err = \_ -> Gen.Result.make_.err (Elm.apply (Elm.val "BadErrorBody") [ metadata, body ])
                                                }
                                    }
                        , goodStatus_ =
                            \metadata body ->
                                Gen.Result.caseOf_.result
                                    (Gen.Json.Decode.call_.decodeString successDecoder body)
                                    { err = \_ -> Gen.Result.make_.err (Elm.apply (Elm.val "BadBody") [ metadata, body ])
                                    , ok = \a -> Gen.Result.make_.ok a
                                    }
                        }
        )


jsonResolverCustom :
    { declaration : Elm.Declaration
    , call : Elm.Expression -> Elm.Expression -> Elm.Expression
    , callFrom : List String -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , value : List String -> Elm.Expression
    }
jsonResolverCustom =
    Elm.Declare.fn2 "jsonResolverCustom"
        ( "errorDecoders"
        , Just
            (Gen.Dict.annotation_.dict
                Gen.String.annotation_.string
                (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.var "err"))
            )
        )
        ( "successDecoder"
        , Just
            (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.var "success"))
        )
    <|
        \errorDecoders successDecoder ->
            Gen.Http.stringResolver
                (\response ->
                    Elm.Case.custom response
                        (Gen.Http.annotation_.response Elm.Annotation.string)
                        [ Elm.Case.branch1 "BadUrl_"
                            ( "url", Elm.Annotation.string )
                            (\url -> Gen.Result.make_.err (Elm.apply (Elm.val "BadUrl") [ url ]))
                        , Elm.Case.branch0 "Timeout_"
                            (Gen.Result.make_.err (Elm.val "Timeout"))
                        , Elm.Case.branch0 "NetworkError_"
                            (Gen.Result.make_.err (Elm.val "NetworkError"))
                        , Elm.Case.branch2 "BadStatus_"
                            ( "metadata", Gen.Http.annotation_.metadata )
                            ( "body", Elm.Annotation.string )
                            (\metadata body ->
                                Gen.Maybe.caseOf_.maybe
                                    (Gen.Dict.call_.get (Gen.String.call_.fromInt (Elm.get "statusCode" metadata)) errorDecoders)
                                    { nothing = Gen.Result.make_.err (Elm.apply (Elm.val "UnknownBadStatus") [ metadata, body ])
                                    , just =
                                        \errorDecoder ->
                                            Gen.Result.caseOf_.result
                                                (Gen.Json.Decode.call_.decodeString errorDecoder body)
                                                { ok = \x -> Gen.Result.make_.err (Elm.apply (Elm.val "KnownBadStatus") [ Elm.get "statusCode" metadata, x ])
                                                , err = \_ -> Gen.Result.make_.err (Elm.apply (Elm.val "BadErrorBody") [ metadata, body ])
                                                }
                                    }
                            )
                        , Elm.Case.branch2 "GoodStatus_"
                            ( "metadata", Gen.Http.annotation_.metadata )
                            ( "body", Elm.Annotation.string )
                            (\metadata body ->
                                Gen.Result.caseOf_.result
                                    (Gen.Json.Decode.call_.decodeString successDecoder body)
                                    { err = \_ -> Gen.Result.make_.err (Elm.apply (Elm.val "BadBody") [ metadata, body ])
                                    , ok = \a -> Gen.Result.make_.ok a
                                    }
                            )
                        ]
                )



-- NOTE: Maybe we keep this around and let people choose the type of error handling they want?
-- jsonResolver :
--     { declaration : Elm.Declaration
--     , call : Elm.Expression -> Elm.Expression
--     , callFrom : List String -> Elm.Expression -> Elm.Expression
--     , value : List String -> Elm.Expression
--     }
-- jsonResolver =
--     Elm.Declare.fn "jsonResolver"
--         ( "decoder"
--         , Just <| Gen.Json.Decode.annotation_.decoder (Elm.Annotation.var "t")
--         )
--     <|
--         \decoder ->
--             Gen.Http.stringResolver
--                 (\response ->
--                     response
--                         |> responseToResult.call
--                         |> Gen.Result.andThen
--                             (\body ->
--                                 body
--                                     |> Gen.Json.Decode.call_.decodeString decoder
--                                     |> Gen.Result.mapError (\err -> Gen.Http.make_.badBody (Gen.Json.Decode.errorToString err))
--                             )
--                 )


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


isSuccessResponseStatus : String -> Bool
isSuccessResponseStatus status =
    String.startsWith "2" status || String.startsWith "3" status


getFirstSuccessResponse : Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response) -> Maybe ( String, OpenApi.Reference.ReferenceOr OpenApi.Response.Response )
getFirstSuccessResponse responses =
    responses
        |> Dict.toList
        |> List.filter (Tuple.first >> isSuccessResponseStatus)
        |> List.head


getErrorResponses : Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response) -> Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response)
getErrorResponses responses =
    responses
        |> Dict.filter (\status _ -> not <| isSuccessResponseStatus status)


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

        Ref ref ->
            CliMonad.map (\name rec -> Elm.apply (Elm.val ("encode" ++ name)) [ rec ]) (CliMonad.refToTypeName ref)

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
                                    (Elm.val "jsonDecodeAndMap")
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

        Ref ref ->
            CliMonad.map (\name -> Elm.val ("decode" ++ name)) (CliMonad.refToTypeName ref)

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


jsonDecodeAndMap : Elm.Declaration
jsonDecodeAndMap =
    let
        aVarAnnotation : Elm.Annotation.Annotation
        aVarAnnotation =
            Elm.Annotation.var "a"

        aToBAnnotation : Elm.Annotation.Annotation
        aToBAnnotation =
            Elm.Annotation.function [ Elm.Annotation.var "a" ] (Elm.Annotation.var "b")

        bVarAnnotation : Elm.Annotation.Annotation
        bVarAnnotation =
            Elm.Annotation.var "b"
    in
    Elm.function []
        (\_ ->
            Elm.apply
                Gen.Json.Decode.values_.map2
                [ Elm.val "(|>)" ]
        )
        |> Elm.withType
            (Elm.Annotation.function
                [ Gen.Json.Decode.annotation_.decoder aVarAnnotation
                , Gen.Json.Decode.annotation_.decoder aToBAnnotation
                ]
                (Gen.Json.Decode.annotation_.decoder bVarAnnotation)
            )
        |> Elm.declaration "jsonDecodeAndMap"


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
        |> CliMonad.stepOrFail "Could not get application's json content"
            (OpenApi.Response.content
                >> Dict.Extra.find searchForJsonMediaType
                >> Maybe.map Tuple.second
            )
        |> CliMonad.stepOrFail "The response's json content option doesn't have a schema"
            OpenApi.MediaType.schema
        |> CliMonad.map OpenApi.Schema.get


requestBodyToSchema : OpenApi.RequestBody.RequestBody -> CliMonad Json.Schema.Definitions.Schema
requestBodyToSchema requestBody =
    CliMonad.succeed requestBody
        |> CliMonad.stepOrFail "Could not get application's json content"
            (OpenApi.RequestBody.content
                >> Dict.Extra.find searchForJsonMediaType
                >> Maybe.map Tuple.second
            )
        |> CliMonad.stepOrFail "The request body's json content option doesn't have a schema"
            OpenApi.MediaType.schema
        |> CliMonad.map OpenApi.Schema.get


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


sanitizeModuleName : String -> Maybe String
sanitizeModuleName str =
    let
        finalName : String
        finalName =
            String.filter
                (\char ->
                    Char.isAlphaNum char
                        || (char == '_')
                        || (char == '-')
                        || (char == ' ')
                        || (char == ':')
                )
                str
                |> String.replace "_" " "
                |> String.replace "-" " "
                |> String.replace ":" " "
                |> String.words
                |> Util.List.mapFirst numberToString
                |> List.map (String.toLower >> String.Extra.toSentenceCase)
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
    , ':'
    , '('
    , ')'
    ]
