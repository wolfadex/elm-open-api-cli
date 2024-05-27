module OpenApi.Generate exposing
    ( ContentSchema(..)
    , Mime
    , files
    , sanitizeModuleName
    )

import Cli.Validate
import CliMonad exposing (CliMonad)
import Common
import Dict
import Dict.Extra
import Elm
import Elm.Annotation
import Elm.Case
import Elm.Declare
import Elm.Op
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
import JsonSchema.Generate
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
import OpenApi.SecurityScheme
import OpenApi.Server
import SchemaUtils
import String.Extra
import Util.List


type alias Mime =
    String


type ContentSchema
    = EmptyContent
    | JsonContent Common.Type
    | StringContent Mime
    | BytesContent Mime


type alias AuthorizationInfo =
    { headers : Elm.Expression -> List Elm.Expression
    , params : List ( String, Elm.Annotation.Annotation )
    , scopes : List String
    }


files : { namespace : List String, generateTodos : Bool } -> OpenApi.OpenApi -> Result CliMonad.Message ( List Elm.File, List CliMonad.Message )
files { namespace, generateTodos } apiSpec =
    CliMonad.combine
        [ pathDeclarations namespace
        , componentDeclarations namespace
        , responsesDeclarations namespace
        , requestBodiesDeclarations namespace
        ]
        |> CliMonad.map List.concat
        |> CliMonad.run
            (SchemaUtils.oneOfDeclarations (namespace ++ [ "Api" ]))
            { openApi = apiSpec
            , generateTodos = generateTodos
            }
        |> Result.map
            (\( decls, warnings ) ->
                ( [ Elm.fileWith (namespace ++ [ "Api" ])
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
                                >> formatModuleDocs
                        , aliases = []
                        }
                        decls
                  , Elm.fileWith (namespace ++ [ "OpenApi" ])
                        { docs =
                            List.sortBy
                                (\{ group } ->
                                    case group of
                                        Just "Http" ->
                                            1

                                        Just "Json" ->
                                            2

                                        Just "Open API" ->
                                            3

                                        _ ->
                                            4
                                )
                                >> formatModuleDocs
                        , aliases = []
                        }
                        [ expectJsonCustom.declaration
                            |> Elm.exposeWith
                                { exposeConstructor = False
                                , group = Just "Http"
                                }
                        , jsonResolverCustom.declaration
                            |> Elm.exposeWith
                                { exposeConstructor = False
                                , group = Just "Http"
                                }
                        , SchemaUtils.decodeOptionalField.declaration
                            |> Elm.withDocumentation """{-| Decode an optional field

    decodeString (decodeOptionalField "x" int) "{ "x": 3 }"
    --> Ok (Just 3)

    decodeString (decodeOptionalField "x" int) "{ "x": true }"
    --> Err ...

    decodeString (decodeOptionalField "x" int) "{ "y": 4 }"
    --> Ok Nothing

-}"""
                            |> Elm.exposeWith
                                { exposeConstructor = False
                                , group = Just "Json"
                                }
                        , jsonDecodeAndMap
                            |> Elm.withDocumentation "Chain JSON decoders, when `Json.Decode.map8` isn't enough."
                            |> Elm.exposeWith
                                { exposeConstructor = False
                                , group = Just "Json"
                                }
                        , customHttpError
                            |> Elm.exposeWith
                                { exposeConstructor = True
                                , group = Just "Open API"
                                }
                        , nullableType
                            |> Elm.exposeWith
                                { exposeConstructor = True
                                , group = Just "Open API"
                                }
                        ]
                  ]
                , warnings
                )
            )


formatModuleDocs : List { group : Maybe String, members : List String } -> List String
formatModuleDocs =
    List.map
        (\{ group, members } ->
            "## "
                ++ Maybe.withDefault "Other" group
                ++ "\n\n\n"
                ++ (members
                        |> List.sort
                        |> List.foldl
                            (\member memberLines ->
                                case memberLines of
                                    [] ->
                                        [ [ member ] ]

                                    memberLine :: restOfLines ->
                                        let
                                            groupSize : Int
                                            groupSize =
                                                String.length (String.join ", " memberLine)
                                        in
                                        if String.length member + groupSize < 105 then
                                            (member :: memberLine) :: restOfLines

                                        else
                                            [ member ] :: memberLines
                            )
                            []
                        |> List.map (\memberLine -> "@docs " ++ String.join ", " (List.reverse memberLine))
                        |> List.reverse
                        |> String.join "\n"
                   )
        )


pathDeclarations : List String -> CliMonad (List Elm.Declaration)
pathDeclarations namespace =
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
                                        toRequestFunctions namespace method url operation
                                            |> CliMonad.errorToWarning
                                    )
                                |> CliMonad.map (List.filterMap identity >> List.concat)
                        )
                    |> CliMonad.map List.concat
            )


responsesDeclarations : List String -> CliMonad (List Elm.Declaration)
responsesDeclarations namespace =
    CliMonad.fromApiSpec
        (OpenApi.components
            >> Maybe.map OpenApi.Components.responses
            >> Maybe.withDefault Dict.empty
        )
        |> CliMonad.andThen
            (Dict.foldl
                (\name schema ->
                    CliMonad.map2 (::)
                        (responseToDeclarations namespace (Common.typifyName name) schema)
                )
                (CliMonad.succeed [])
            )
        |> CliMonad.map List.concat


requestBodiesDeclarations : List String -> CliMonad (List Elm.Declaration)
requestBodiesDeclarations namespace =
    CliMonad.fromApiSpec
        (OpenApi.components
            >> Maybe.map OpenApi.Components.requestBodies
            >> Maybe.withDefault Dict.empty
        )
        |> CliMonad.andThen
            (Dict.foldl
                (\name schema ->
                    CliMonad.map2 (::)
                        (requestBodyToDeclarations namespace name schema)
                )
                (CliMonad.succeed [])
            )
        |> CliMonad.map List.concat


componentDeclarations : List String -> CliMonad (List Elm.Declaration)
componentDeclarations namespace =
    CliMonad.fromApiSpec
        (OpenApi.components
            >> Maybe.map OpenApi.Components.schemas
            >> Maybe.withDefault Dict.empty
        )
        |> CliMonad.andThen
            (Dict.foldl
                (\name schema ->
                    CliMonad.map2 (::)
                        (JsonSchema.Generate.schemaToDeclarations namespace name (OpenApi.Schema.get schema))
                )
                (CliMonad.succeed [])
            )
        |> CliMonad.map List.concat


unitDeclarations : List String -> String -> CliMonad (List Elm.Declaration)
unitDeclarations namespace name =
    let
        typeName : Common.TypeName
        typeName =
            Common.typifyName name
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
            (SchemaUtils.typeToDecoder namespace Common.Unit)
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
            (SchemaUtils.typeToEncoder namespace Common.Unit)
        ]


responseToDeclarations : List String -> String -> OpenApi.Reference.ReferenceOr OpenApi.Response.Response -> CliMonad (List Elm.Declaration)
responseToDeclarations namespace name reference =
    case OpenApi.Reference.toConcrete reference of
        Just response ->
            let
                content : Dict.Dict String OpenApi.MediaType.MediaType
                content =
                    OpenApi.Response.content response
            in
            if Dict.isEmpty content then
                -- If there is no content then we go with the unit value, `()` as the response type
                unitDeclarations namespace name

            else
                responseToSchema response
                    |> CliMonad.withPath name
                    |> CliMonad.andThen (JsonSchema.Generate.schemaToDeclarations namespace name)

        Nothing ->
            CliMonad.fail "Could not convert reference to concrete value"
                |> CliMonad.withPath name


requestBodyToDeclarations : List String -> String -> OpenApi.Reference.ReferenceOr OpenApi.RequestBody.RequestBody -> CliMonad (List Elm.Declaration)
requestBodyToDeclarations namespace name reference =
    case OpenApi.Reference.toConcrete reference of
        Just requestBody ->
            let
                content : Dict.Dict String OpenApi.MediaType.MediaType
                content =
                    OpenApi.RequestBody.content requestBody
            in
            if Dict.isEmpty content then
                -- If there is no content then we go with the unit value, `()` as the requestBody type
                unitDeclarations namespace name

            else
                requestBodyToSchema requestBody
                    |> CliMonad.withPath name
                    |> CliMonad.andThen (JsonSchema.Generate.schemaToDeclarations namespace name)

        Nothing ->
            CliMonad.fail "Could not convert reference to concrete value"
                |> CliMonad.withPath name


toRequestFunctions : List String -> String -> String -> OpenApi.Operation.Operation -> CliMonad (List Elm.Declaration)
toRequestFunctions namespace method pathUrl operation =
    let
        functionName : String
        functionName =
            OpenApi.Operation.operationId operation
                |> Maybe.withDefault pathUrl
                |> makeNamespaceValid
                |> removeInvalidChars
                |> String.Extra.camelize
    in
    operationToTypesExpectAndResolver namespace functionName operation
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
                                                paramToType namespace concreteParam
                                                    |> CliMonad.andThen
                                                        (\( paramName, type_ ) ->
                                                            paramToString namespace type_
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
                                                                        Elm.get (Common.toValueName paramName) (Elm.get "params" config)
                                                                            |> toString
                                                                            |> Gen.String.call_.replace
                                                                                (Elm.string <| "{" ++ paramName ++ "}")
                                                                    , -- This is used for segment replacement when usig `Url.Builder.crossOrigin`
                                                                      ( "{" ++ paramName ++ "}"
                                                                      , \config ->
                                                                            Elm.get (Common.toValueName paramName) (Elm.get "params" config)
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
                                                            initialUrl : String
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
                                            |> CliMonad.combineMap (queryParameterToUrlBuilderArgument namespace)
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
                                SchemaUtils.typeToEncoder namespace type_
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
                                SchemaUtils.typeToAnnotation namespace type_
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
                                                toConfigParamAnnotation namespace
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
                                            (SchemaUtils.typeToAnnotation namespace successType)
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
                                                (customErrorAnnotation namespace errorTypeAnnotation bodyTypeAnnotation)
                                                successAnnotation
                                            )
                                        )
                                    )
                                    (body bodyContent)
                                    (CliMonad.andThen
                                        (\bp ->
                                            toConfigParamAnnotation namespace
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
                            (SchemaUtils.typeToAnnotation namespace successType)

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
                operationToContentSchema namespace operation
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


customErrorAnnotation : List String -> Elm.Annotation.Annotation -> Elm.Annotation.Annotation -> Elm.Annotation.Annotation
customErrorAnnotation namespace errorTypeAnnotation bodyTypeAnnotation =
    Elm.Annotation.namedWith (namespace ++ [ "OpenApi" ])
        "Error"
        [ errorTypeAnnotation
        , bodyTypeAnnotation
        ]


operationToAuthorizationInfo : OpenApi.Operation.Operation -> CliMonad AuthorizationInfo
operationToAuthorizationInfo operation =
    CliMonad.andThen2
        (\globalSecurity components ->
            (OpenApi.Operation.security operation ++ globalSecurity)
                |> List.concatMap
                    (Dict.toList << OpenApi.SecurityRequirement.requirements)
                |> List.foldl
                    (\e ->
                        CliMonad.andThen
                            (\acc ->
                                case e of
                                    ( "oauth_2_0", ss ) ->
                                        if Dict.member "Authorization" acc.headers then
                                            CliMonad.todoWithDefault acc "Authorization header already set"

                                        else
                                            CliMonad.succeed
                                                { headers =
                                                    Dict.insert "Authorization"
                                                        (\config ->
                                                            Elm.Op.append
                                                                (Elm.string "Bearer ")
                                                                (config
                                                                    |> Elm.get "authorization"
                                                                    |> Elm.get "bearer"
                                                                )
                                                        )
                                                        acc.headers
                                                , params =
                                                    Dict.insert "authorization"
                                                        (Dict.insert "bearer" Elm.Annotation.string <|
                                                            Maybe.withDefault Dict.empty <|
                                                                Dict.get "authorization" acc.params
                                                        )
                                                        acc.params
                                                , scopes = ss
                                                }

                                    ( "Token", [] ) ->
                                        if Dict.member "Authorization" acc.headers then
                                            CliMonad.todoWithDefault acc "Authorization header already set"

                                        else
                                            CliMonad.succeed
                                                { headers =
                                                    Dict.insert "Authorization"
                                                        (\config ->
                                                            Elm.Op.append
                                                                (Elm.string "Token ")
                                                                (config
                                                                    |> Elm.get "authorization"
                                                                    |> Elm.get "token"
                                                                )
                                                        )
                                                        acc.headers
                                                , params =
                                                    Dict.insert "authorization"
                                                        (Dict.insert "token" Elm.Annotation.string <|
                                                            Maybe.withDefault Dict.empty <|
                                                                Dict.get "authorization" acc.params
                                                        )
                                                        acc.params
                                                , scopes = []
                                                }

                                    ( name, _ ) ->
                                        case Maybe.map OpenApi.Components.securitySchemes components of
                                            Just securitySchemas ->
                                                case Maybe.andThen OpenApi.Reference.toConcrete <| Dict.get name securitySchemas of
                                                    Nothing ->
                                                        CliMonad.todoWithDefault acc
                                                            ("Unknown security requirement: " ++ name)

                                                    Just securitySchema ->
                                                        case OpenApi.SecurityScheme.type_ securitySchema of
                                                            OpenApi.SecurityScheme.ApiKey apiKey ->
                                                                case apiKey.in_ of
                                                                    OpenApi.SecurityScheme.Header ->
                                                                        if Dict.member apiKey.name acc.headers then
                                                                            CliMonad.todoWithDefault acc (apiKey.name ++ " header already set")

                                                                        else
                                                                            let
                                                                                cleanName : String
                                                                                cleanName =
                                                                                    Common.toValueName apiKey.name
                                                                            in
                                                                            CliMonad.succeed
                                                                                { headers =
                                                                                    Dict.insert apiKey.name
                                                                                        (\config ->
                                                                                            config
                                                                                                |> Elm.get cleanName
                                                                                        )
                                                                                        acc.headers
                                                                                , params = Dict.insert cleanName (Dict.singleton "" Elm.Annotation.string) acc.params
                                                                                , scopes = []
                                                                                }

                                                                    OpenApi.SecurityScheme.Query ->
                                                                        CliMonad.todoWithDefault acc "Unsupported security schema: ApiKey in Query"

                                                                    OpenApi.SecurityScheme.Cookie ->
                                                                        CliMonad.todoWithDefault acc "Unsupported security schema: ApiKey in Cookie"

                                                            OpenApi.SecurityScheme.Http _ ->
                                                                CliMonad.todoWithDefault acc "Unsupported security schema: Http"

                                                            OpenApi.SecurityScheme.MutualTls ->
                                                                CliMonad.todoWithDefault acc "Unsupported security schema: MutualTls"

                                                            OpenApi.SecurityScheme.Oauth2 _ ->
                                                                CliMonad.todoWithDefault acc "Unsupported security schema: Oauth2"

                                                            OpenApi.SecurityScheme.OpenIdConnect _ ->
                                                                CliMonad.todoWithDefault acc "Unsupported security schema: OpenIdConnect"

                                            Nothing ->
                                                CliMonad.todoWithDefault acc
                                                    ("Unknown security requirement: " ++ name)
                            )
                    )
                    (CliMonad.succeed
                        { headers = Dict.empty
                        , params = Dict.empty
                        , scopes = []
                        }
                    )
                |> CliMonad.map
                    (\{ headers, params, scopes } ->
                        { headers =
                            \config ->
                                headers
                                    |> Dict.toList
                                    |> List.map (\( k, v ) -> Gen.Http.call_.header (Elm.string k) (v config))
                        , params =
                            params
                                |> Dict.map
                                    (\_ v ->
                                        case Dict.toList v of
                                            [ ( "", t ) ] ->
                                                t

                                            list ->
                                                Elm.Annotation.record list
                                    )
                                |> Dict.toList
                        , scopes = scopes
                        }
                    )
        )
        (CliMonad.fromApiSpec OpenApi.security)
        (CliMonad.fromApiSpec OpenApi.components)


operationToContentSchema : List String -> OpenApi.Operation.Operation -> CliMonad ContentSchema
operationToContentSchema namespace operation =
    case OpenApi.Operation.requestBody operation of
        Nothing ->
            CliMonad.succeed EmptyContent

        Just requestOrRef ->
            case OpenApi.Reference.toConcrete requestOrRef of
                Just request ->
                    OpenApi.RequestBody.content request
                        |> contentToContentSchema namespace

                Nothing ->
                    CliMonad.succeed requestOrRef
                        |> CliMonad.stepOrFail "I found a successfull response, but I couldn't convert it to a concrete one"
                            OpenApi.Reference.toReference
                        |> CliMonad.map (\ref -> JsonContent (Common.Ref <| String.split "/" <| OpenApi.Reference.ref ref))


regexToCheckIfJson : String -> Cli.Validate.ValidationResult
regexToCheckIfJson =
    Cli.Validate.regex "^application\\/(vnd\\.[a-z0-9]+(\\.v\\d+)?(\\.[a-z0-9]+)?)?\\+?json$"


searchForJsonMediaType : String -> a -> Bool
searchForJsonMediaType mediaType _ =
    case regexToCheckIfJson mediaType of
        Cli.Validate.Valid ->
            True

        Cli.Validate.Invalid _ ->
            False


contentToContentSchema : List String -> Dict.Dict String OpenApi.MediaType.MediaType -> CliMonad ContentSchema
contentToContentSchema namespace content =
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
                        |> CliMonad.andThen (SchemaUtils.schemaToType namespace)
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
                |> CliMonad.andThen (SchemaUtils.schemaToType namespace)
                |> CliMonad.andThen
                    (\type_ ->
                        if type_ == Common.String then
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
    List String
    ->
        { operation : OpenApi.Operation.Operation
        , requireToMsg : Bool
        , successAnnotation : Elm.Annotation.Annotation
        , errorBodyAnnotation : Elm.Annotation.Annotation
        , errorTypeAnnotation : Elm.Annotation.Annotation
        , authorizationInfo : AuthorizationInfo
        , bodyParams : List ( String, Elm.Annotation.Annotation )
        }
    -> CliMonad Elm.Annotation.Annotation
toConfigParamAnnotation namespace options =
    CliMonad.map
        (\urlParams ->
            (options.authorizationInfo.params
                ++ (if options.requireToMsg then
                        [ ( "toMsg"
                          , Elm.Annotation.function
                                [ Gen.Result.annotation_.result
                                    (customErrorAnnotation namespace options.errorTypeAnnotation options.errorBodyAnnotation)
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
                |> SchemaUtils.recordType
        )
        (operationToUrlParams namespace options.operation)


operationToUrlParams : List String -> OpenApi.Operation.Operation -> CliMonad (List ( String, Elm.Annotation.Annotation ))
operationToUrlParams namespace operation =
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
                        |> CliMonad.andThen (paramToAnnotation namespace)
                )
            |> CliMonad.map
                (\types -> [ ( "params", SchemaUtils.recordType types ) ])


queryParameterToUrlBuilderArgument : List String -> OpenApi.Parameter.Parameter -> CliMonad (Elm.Expression -> Elm.Expression)
queryParameterToUrlBuilderArgument namespace param =
    paramToType namespace param
        |> CliMonad.andThen
            (\( paramName, type_ ) ->
                paramToString namespace type_
                    |> CliMonad.map
                        (\{ toString, alwaysJust } config ->
                            let
                                name : Elm.Expression
                                name =
                                    Elm.string paramName

                                value : Elm.Expression
                                value =
                                    Elm.get (Common.toValueName paramName) (Elm.get "params" config)
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


paramToString : List String -> Common.Type -> CliMonad { toString : Elm.Expression -> Elm.Expression, alwaysJust : Bool }
paramToString namespace type_ =
    let
        basic :
            (Elm.Expression -> Elm.Expression)
            -> CliMonad { toString : Elm.Expression -> Elm.Expression, alwaysJust : Bool }
        basic f =
            CliMonad.succeed { toString = f, alwaysJust = True }

        recursive :
            Common.Type
            -> ({ toString : Elm.Expression, alwaysJust : Bool } -> Elm.Expression -> Elm.Expression)
            -> CliMonad { toString : Elm.Expression -> Elm.Expression, alwaysJust : Bool }
        recursive p f =
            paramToString namespace p
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
        Common.String ->
            basic identity

        Common.Int ->
            basic Gen.String.call_.fromInt

        Common.Float ->
            basic Gen.String.call_.fromFloat

        Common.Bool ->
            (\val ->
                Elm.ifThen val
                    (Elm.string "true")
                    (Elm.string "false")
            )
                |> basic

        Common.Nullable Common.String ->
            { toString = identity
            , alwaysJust = False
            }
                |> CliMonad.succeed

        Common.Nullable p ->
            recursive p <|
                \{ toString, alwaysJust } val ->
                    if alwaysJust then
                        Gen.Maybe.call_.map toString val

                    else
                        Gen.Maybe.call_.andThen toString val

        Common.List Common.String ->
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

        Common.List p ->
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

        Common.Ref ref ->
            --  These are mostly aliases
            SchemaUtils.getAlias ref
                |> CliMonad.andThen (SchemaUtils.schemaToType namespace)
                |> CliMonad.andThen (paramToString namespace)

        Common.OneOf name data ->
            CliMonad.map2
                (\valType branches ->
                    { toString =
                        \val -> Elm.Case.custom val valType branches
                    , alwaysJust = True
                    }
                )
                (SchemaUtils.typeToAnnotation namespace type_)
                (CliMonad.combineMap
                    (\alternative ->
                        CliMonad.andThen2
                            (\{ toString, alwaysJust } annotation ->
                                if not alwaysJust then
                                    CliMonad.fail "Nullable alternative"

                                else
                                    Elm.Case.branch1 (SchemaUtils.toVariantName name alternative.name) ( "alternative", annotation ) toString
                                        |> CliMonad.succeed
                            )
                            (paramToString namespace alternative.type_)
                            (SchemaUtils.typeToAnnotation namespace alternative.type_)
                    )
                    data
                )

        _ ->
            SchemaUtils.typeToAnnotation namespace type_
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


paramToAnnotation : List String -> OpenApi.Parameter.Parameter -> CliMonad ( String, Elm.Annotation.Annotation )
paramToAnnotation namespace concreteParam =
    paramToType namespace concreteParam
        |> CliMonad.andThen
            (\( pname, type_ ) ->
                SchemaUtils.typeToAnnotationMaybe namespace type_
                    |> CliMonad.map
                        (\annotation -> ( pname, annotation ))
            )


paramToType : List String -> OpenApi.Parameter.Parameter -> CliMonad ( String, Common.Type )
paramToType namespace concreteParam =
    let
        pname : String
        pname =
            OpenApi.Parameter.name concreteParam
    in
    CliMonad.succeed concreteParam
        |> CliMonad.stepOrFail ("Could not get schema for parameter " ++ pname)
            (OpenApi.Parameter.schema >> Maybe.map OpenApi.Schema.get)
        |> CliMonad.andThen (SchemaUtils.schemaToType namespace)
        |> CliMonad.andThen
            (\type_ ->
                case type_ of
                    Common.Ref ref ->
                        ref
                            |> SchemaUtils.getAlias
                            |> CliMonad.andThen (SchemaUtils.schemaToType namespace)
                            |> CliMonad.map
                                (\inner ->
                                    case inner of
                                        Common.Nullable _ ->
                                            -- If it's a ref to a nullable type, we don't want another layer of nullable
                                            inner

                                        _ ->
                                            if OpenApi.Parameter.required concreteParam then
                                                type_

                                            else
                                                Common.Nullable type_
                                )

                    _ ->
                        if OpenApi.Parameter.required concreteParam then
                            CliMonad.succeed type_

                        else
                            CliMonad.succeed <| Common.Nullable type_
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
    List String
    -> String
    -> OpenApi.Operation.Operation
    ->
        CliMonad
            { successType : Common.Type
            , bodyTypeAnnotation : Elm.Annotation.Annotation
            , errorTypeDeclaration : Elm.Declaration
            , errorTypeAnnotation : Elm.Annotation.Annotation
            , toExpect : Elm.Expression -> Elm.Expression
            , resolver : Elm.Expression
            }
operationToTypesExpectAndResolver namespace functionName operation =
    let
        responses : Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response)
        responses =
            OpenApi.Operation.responses operation

        expectJsonBetter : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
        expectJsonBetter errorDecoders successDecoder toMsg =
            expectJsonCustom.callFrom (namespace ++ [ "OpenApi" ]) toMsg errorDecoders successDecoder
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
                                                |> contentToContentSchema namespace
                                                |> CliMonad.andThen
                                                    (\contentSchema ->
                                                        case contentSchema of
                                                            JsonContent type_ ->
                                                                SchemaUtils.typeToDecoder namespace type_
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
                                                        SchemaUtils.refToTypeName (String.split "/" inner)
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
                                                |> contentToContentSchema namespace
                                                |> CliMonad.andThen
                                                    (\contentSchema ->
                                                        case contentSchema of
                                                            JsonContent type_ ->
                                                                SchemaUtils.typeToAnnotation namespace type_

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
                                                        SchemaUtils.refToTypeName (String.split "/" inner)
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
                                    ( if Dict.isEmpty dict then
                                        Elm.alias errorName Elm.Annotation.unit

                                      else
                                        dict
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
                            |> contentToContentSchema namespace
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
                                                    , resolver = jsonResolverCustom.callFrom (namespace ++ [ "OpenApi" ]) errorDecoders_ successDecoder
                                                    }
                                                )
                                                (SchemaUtils.typeToDecoder namespace type_)
                                                errorDecoders
                                                errorTypeDeclaration

                                        StringContent _ ->
                                            CliMonad.map2
                                                (\errorDecoders_ ( errorTypeDeclaration_, errorTypeAnnotation ) ->
                                                    { successType = Common.String
                                                    , bodyTypeAnnotation = Elm.Annotation.string
                                                    , errorTypeDeclaration = errorTypeDeclaration_
                                                    , errorTypeAnnotation = errorTypeAnnotation
                                                    , toExpect = expectJsonBetter errorDecoders_ Gen.Json.Decode.string
                                                    , resolver =
                                                        Gen.Http.stringResolver
                                                            (\resp ->
                                                                Elm.Case.custom
                                                                    resp
                                                                    (Elm.Annotation.namedWith [ "Http" ] "Response" [ Elm.Annotation.var "body" ])
                                                                    [ Elm.Case.branch1
                                                                        "BadUrl_"
                                                                        ( "string", Elm.Annotation.string )
                                                                        (\url ->
                                                                            Gen.Result.make_.err
                                                                                (Elm.apply
                                                                                    (Elm.value
                                                                                        { importFrom = namespace ++ [ "OpenApi" ]
                                                                                        , name = "BadUrl"
                                                                                        , annotation = Nothing
                                                                                        }
                                                                                    )
                                                                                    [ url ]
                                                                                )
                                                                        )
                                                                    , Elm.Case.branch0
                                                                        "Timeout_"
                                                                        (Gen.Result.make_.err
                                                                            (Elm.value
                                                                                { importFrom = namespace ++ [ "OpenApi" ]
                                                                                , name = "Timeout"
                                                                                , annotation = Nothing
                                                                                }
                                                                            )
                                                                        )
                                                                    , Elm.Case.branch0
                                                                        "NetworkError_"
                                                                        (Gen.Result.make_.err
                                                                            (Elm.value
                                                                                { importFrom = namespace ++ [ "OpenApi" ]
                                                                                , name = "NetworkError"
                                                                                , annotation = Nothing
                                                                                }
                                                                            )
                                                                        )
                                                                    , Elm.Case.branch2 "BadStatus_"
                                                                        ( "metadata", Gen.Http.annotation_.metadata )
                                                                        ( "body", Elm.Annotation.string )
                                                                        (\metadata body ->
                                                                            Gen.Maybe.caseOf_.maybe
                                                                                (Gen.Dict.call_.get (Gen.String.call_.fromInt (Elm.get "statusCode" metadata)) errorDecoders_)
                                                                                { nothing =
                                                                                    Gen.Result.make_.err
                                                                                        (Elm.apply
                                                                                            (Elm.value
                                                                                                { importFrom = namespace ++ [ "OpenApi" ]
                                                                                                , name = "UnknownBadStatus"
                                                                                                , annotation = Nothing
                                                                                                }
                                                                                            )
                                                                                            [ metadata, body ]
                                                                                        )
                                                                                , just =
                                                                                    \errorDecoder ->
                                                                                        Gen.Result.caseOf_.result
                                                                                            (Gen.Json.Decode.call_.decodeString errorDecoder body)
                                                                                            { ok =
                                                                                                \x ->
                                                                                                    Gen.Result.make_.err
                                                                                                        (Elm.apply
                                                                                                            (Elm.value
                                                                                                                { importFrom = namespace ++ [ "OpenApi" ]
                                                                                                                , name = "KnownBadStatus"
                                                                                                                , annotation = Nothing
                                                                                                                }
                                                                                                            )
                                                                                                            [ Elm.get "statusCode" metadata, x ]
                                                                                                        )
                                                                                            , err =
                                                                                                \_ ->
                                                                                                    Gen.Result.make_.err
                                                                                                        (Elm.apply
                                                                                                            (Elm.value
                                                                                                                { importFrom = namespace ++ [ "OpenApi" ]
                                                                                                                , name = "BadErrorBody"
                                                                                                                , annotation = Nothing
                                                                                                                }
                                                                                                            )
                                                                                                            [ metadata, body ]
                                                                                                        )
                                                                                            }
                                                                                }
                                                                        )
                                                                    , Elm.Case.branch2 "GoodStatus_"
                                                                        ( "metadata", Gen.Http.annotation_.metadata )
                                                                        ( "body", Elm.Annotation.string )
                                                                        (\metadata body ->
                                                                            Gen.Result.caseOf_.result
                                                                                (Gen.Json.Decode.call_.decodeString Gen.Json.Decode.string body)
                                                                                { err =
                                                                                    \_ ->
                                                                                        Gen.Result.make_.err
                                                                                            (Elm.apply
                                                                                                (Elm.value
                                                                                                    { importFrom = namespace ++ [ "OpenApi" ]
                                                                                                    , name = "BadBody"
                                                                                                    , annotation = Nothing
                                                                                                    }
                                                                                                )
                                                                                                [ metadata, body ]
                                                                                            )
                                                                                , ok = \a -> Gen.Result.make_.ok a
                                                                                }
                                                                        )
                                                                    ]
                                                            )
                                                    }
                                                )
                                                errorDecoders
                                                errorTypeDeclaration

                                        BytesContent _ ->
                                            CliMonad.map2
                                                (\errorDecoders_ ( errorTypeDeclaration_, errorTypeAnnotation ) ->
                                                    { successType = Common.Bytes
                                                    , bodyTypeAnnotation = Gen.Bytes.annotation_.bytes
                                                    , errorTypeDeclaration = errorTypeDeclaration_
                                                    , errorTypeAnnotation = errorTypeAnnotation
                                                    , toExpect = \toMsg -> Gen.Http.call_.expectBytes toMsg Gen.Basics.values_.identity
                                                    , resolver =
                                                        Gen.Http.bytesResolver
                                                            (\resp ->
                                                                Elm.Case.custom
                                                                    resp
                                                                    (Elm.Annotation.namedWith [ "Http" ] "Response" [ Elm.Annotation.var "body" ])
                                                                    [ Elm.Case.branch1
                                                                        "BadUrl_"
                                                                        ( "string", Elm.Annotation.string )
                                                                        (\url ->
                                                                            Gen.Result.make_.err
                                                                                (Elm.apply
                                                                                    (Elm.value
                                                                                        { importFrom = namespace ++ [ "OpenApi" ]
                                                                                        , name = "BadUrl"
                                                                                        , annotation = Nothing
                                                                                        }
                                                                                    )
                                                                                    [ url ]
                                                                                )
                                                                        )
                                                                    , Elm.Case.branch0
                                                                        "Timeout_"
                                                                        (Gen.Result.make_.err
                                                                            (Elm.value
                                                                                { importFrom = namespace ++ [ "OpenApi" ]
                                                                                , name = "Timeout"
                                                                                , annotation = Nothing
                                                                                }
                                                                            )
                                                                        )
                                                                    , Elm.Case.branch0
                                                                        "NetworkError_"
                                                                        (Gen.Result.make_.err
                                                                            (Elm.value
                                                                                { importFrom = namespace ++ [ "OpenApi" ]
                                                                                , name = "NetworkError"
                                                                                , annotation = Nothing
                                                                                }
                                                                            )
                                                                        )
                                                                    , Elm.Case.branch2 "BadStatus_"
                                                                        ( "metadata", Gen.Http.annotation_.metadata )
                                                                        ( "body", Elm.Annotation.string )
                                                                        (\metadata body ->
                                                                            Gen.Maybe.caseOf_.maybe
                                                                                (Gen.Dict.call_.get (Gen.String.call_.fromInt (Elm.get "statusCode" metadata)) errorDecoders_)
                                                                                { nothing =
                                                                                    Gen.Result.make_.err
                                                                                        (Elm.apply
                                                                                            (Elm.value
                                                                                                { importFrom = namespace ++ [ "OpenApi" ]
                                                                                                , name = "UnknownBadStatus"
                                                                                                , annotation = Nothing
                                                                                                }
                                                                                            )
                                                                                            [ metadata, body ]
                                                                                        )
                                                                                , just =
                                                                                    \errorDecoder ->
                                                                                        Gen.Result.caseOf_.result
                                                                                            (Gen.Json.Decode.call_.decodeString errorDecoder body)
                                                                                            { ok =
                                                                                                \x ->
                                                                                                    Gen.Result.make_.err
                                                                                                        (Elm.apply
                                                                                                            (Elm.value
                                                                                                                { importFrom = namespace ++ [ "OpenApi" ]
                                                                                                                , name = "KnownBadStatus"
                                                                                                                , annotation = Nothing
                                                                                                                }
                                                                                                            )
                                                                                                            [ Elm.get "statusCode" metadata, x ]
                                                                                                        )
                                                                                            , err =
                                                                                                \_ ->
                                                                                                    Gen.Result.make_.err
                                                                                                        (Elm.apply
                                                                                                            (Elm.value
                                                                                                                { importFrom = namespace ++ [ "OpenApi" ]
                                                                                                                , name = "BadErrorBody"
                                                                                                                , annotation = Nothing
                                                                                                                }
                                                                                                            )
                                                                                                            [ metadata, body ]
                                                                                                        )
                                                                                            }
                                                                                }
                                                                        )
                                                                    , Elm.Case.branch2 "GoodStatus_"
                                                                        ( "_", Gen.Http.annotation_.metadata )
                                                                        ( "body", Elm.Annotation.string )
                                                                        (\_ body ->
                                                                            Gen.Result.make_.ok body
                                                                        )
                                                                    ]
                                                            )
                                                    }
                                                )
                                                errorDecoders
                                                errorTypeDeclaration

                                        EmptyContent ->
                                            CliMonad.map2
                                                (\errorDecoders_ ( errorTypeDeclaration_, errorTypeAnnotation ) ->
                                                    { successType = Common.Unit
                                                    , bodyTypeAnnotation = Elm.Annotation.string
                                                    , errorTypeDeclaration = errorTypeDeclaration_
                                                    , errorTypeAnnotation = errorTypeAnnotation
                                                    , toExpect = expectJsonBetter errorDecoders_ (Gen.Json.Decode.succeed Elm.unit)
                                                    , resolver = jsonResolverCustom.callFrom (namespace ++ [ "OpenApi" ]) errorDecoders_ (Gen.Json.Decode.succeed Elm.unit)
                                                    }
                                                )
                                                errorDecoders
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
                                    SchemaUtils.refToTypeName (String.split "/" inner)
                                        |> CliMonad.map3
                                            (\errorDecoders_ ( errorTypeDeclaration_, errorTypeAnnotation ) typeName ->
                                                { successType = Common.ref inner
                                                , bodyTypeAnnotation = Elm.Annotation.string
                                                , errorTypeDeclaration = errorTypeDeclaration_
                                                , errorTypeAnnotation = errorTypeAnnotation
                                                , toExpect = expectJsonBetter errorDecoders_ (Elm.val ("decode" ++ typeName))
                                                , resolver = jsonResolverCustom.callFrom (namespace ++ [ "OpenApi" ]) errorDecoders_ <| Elm.val ("decode" ++ typeName)
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
