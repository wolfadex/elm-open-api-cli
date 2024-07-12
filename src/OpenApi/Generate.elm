module OpenApi.Generate exposing
    ( ContentSchema(..)
    , EffectType(..)
    , Mime
    , Server(..)
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
import Gen.BackendTask
import Gen.BackendTask.Http
import Gen.Basics
import Gen.Bytes
import Gen.Debug
import Gen.Dict
import Gen.Effect.Http
import Gen.Effect.Task
import Gen.FatalError
import Gen.Http
import Gen.Json.Decode
import Gen.Json.Encode
import Gen.List
import Gen.Maybe
import Gen.OpenApi.Common
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


type EffectType
    = Cmd
    | CmdRisky
    | Task
    | TaskRisky
    | BackendTask
    | ProgramTest
    | ProgramTestTask


type ContentSchema
    = EmptyContent
    | JsonContent Common.Type
    | StringContent Mime
    | BytesContent Mime


type Server
    = Default
    | Single String
    | Multiple (Dict.Dict String String)


type alias AuthorizationInfo =
    { headers : Elm.Expression -> List ( Elm.Expression, Elm.Expression )
    , query : Elm.Expression -> List ( Elm.Expression, Elm.Expression )
    , params : List ( String, Elm.Annotation.Annotation )
    , scopes : List String
    }


type alias PerPackage a =
    { core : a
    , elmPages : a
    , lamderaProgramTest : a
    }


files :
    { namespace : List String
    , generateTodos : Bool
    , effectTypes : List EffectType
    , server : Server
    }
    -> OpenApi.OpenApi
    -> Result CliMonad.Message ( List Elm.File, List CliMonad.Message )
files { namespace, generateTodos, effectTypes, server } apiSpec =
    CliMonad.combine
        [ pathDeclarations server effectTypes namespace
        , componentDeclarations namespace
        , responsesDeclarations namespace
        , requestBodiesDeclarations namespace
        ]
        |> CliMonad.map List.concat
        |> CliMonad.run
            (SchemaUtils.oneOfDeclarations namespace)
            { openApi = apiSpec
            , generateTodos = generateTodos
            }
        |> Result.map
            (\( decls, warnings ) ->
                let
                    allDecls : List ( Common.Module, Elm.Declaration )
                    allDecls =
                        decls
                            ++ [ ( Common.Common
                                 , expectJsonCustom.declaration
                                    |> Elm.exposeWith
                                        { exposeConstructor = False
                                        , group = Just "Http"
                                        }
                                 )
                               , ( Common.Common
                                 , jsonResolverCustom.declaration
                                    |> Elm.exposeWith
                                        { exposeConstructor = False
                                        , group = Just "Http"
                                        }
                                 )
                               ]
                            ++ (if List.member ProgramTest effectTypes || List.member ProgramTestTask effectTypes then
                                    [ ( Common.Common
                                      , expectJsonCustomEffect.declaration
                                            |> Elm.exposeWith
                                                { exposeConstructor = False
                                                , group = Just "Http"
                                                }
                                      )
                                    , ( Common.Common
                                      , jsonResolverCustomEffect.declaration
                                            |> Elm.exposeWith
                                                { exposeConstructor = False
                                                , group = Just "Http"
                                                }
                                      )
                                    ]

                                else
                                    []
                               )
                            ++ [ ( Common.Common
                                 , SchemaUtils.decodeOptionalField.declaration
                                    |> Elm.withDocumentation SchemaUtils.decodeOptionalFieldDocumentation
                                    |> Elm.exposeWith
                                        { exposeConstructor = False
                                        , group = Just "Decoders"
                                        }
                                 )
                               , ( Common.Common
                                 , jsonDecodeAndMap
                                    |> Elm.withDocumentation "Chain JSON decoders, when `Json.Decode.map8` isn't enough."
                                    |> Elm.exposeWith
                                        { exposeConstructor = False
                                        , group = Just "Decoders"
                                        }
                                 )
                               , ( Common.Common
                                 , customHttpError
                                    |> Elm.exposeWith
                                        { exposeConstructor = True
                                        , group = Just "Http"
                                        }
                                 )
                               , ( Common.Common
                                 , nullableType
                                    |> Elm.exposeWith
                                        { exposeConstructor = True
                                        , group = Just "Types"
                                        }
                                 )
                               ]
                            ++ (case server of
                                    Multiple servers ->
                                        servers
                                            |> Dict.toList
                                            |> List.map
                                                (\( key, value ) ->
                                                    ( Common.Servers
                                                    , Elm.string value
                                                        |> Elm.declaration key
                                                        |> Elm.exposeWith
                                                            { exposeConstructor = True
                                                            , group = Just "Servers"
                                                            }
                                                    )
                                                )

                                    _ ->
                                        []
                               )
                in
                ( allDecls
                    |> List.Extra.gatherEqualsBy Tuple.first
                    |> List.map
                        (\( ( module_, head ), tail ) ->
                            Elm.fileWith (Common.moduleToNamespace namespace module_)
                                { docs =
                                    \docs ->
                                        docs
                                            |> List.sortBy
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
                                            |> formatModuleDocs
                                , aliases = []
                                }
                                (head :: List.map Tuple.second tail)
                        )
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


pathDeclarations : Server -> List EffectType -> List String -> CliMonad (List ( Common.Module, Elm.Declaration ))
pathDeclarations server effectTypes namespace =
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
                                        toRequestFunctions server effectTypes namespace method url operation
                                            |> CliMonad.errorToWarning
                                    )
                                |> CliMonad.map (List.filterMap identity >> List.concat)
                        )
                    |> CliMonad.map List.concat
            )


responsesDeclarations : List String -> CliMonad (List ( Common.Module, Elm.Declaration ))
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


requestBodiesDeclarations : List String -> CliMonad (List ( Common.Module, Elm.Declaration ))
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


componentDeclarations : List String -> CliMonad (List ( Common.Module, Elm.Declaration ))
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


unitDeclarations : List String -> String -> CliMonad (List ( Common.Module, Elm.Declaration ))
unitDeclarations namespace name =
    let
        typeName : Common.TypeName
        typeName =
            Common.typifyName name
    in
    CliMonad.combine
        [ ( Common.Types
          , Elm.alias typeName Elm.Annotation.unit
                |> Elm.exposeWith
                    { exposeConstructor = False
                    , group = Just "Aliases"
                    }
          )
            |> CliMonad.succeed
        , CliMonad.map
            (\schemaDecoder ->
                ( Common.Json
                , Elm.declaration ("decode" ++ typeName)
                    (schemaDecoder
                        |> Elm.withType (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.named (Common.moduleToNamespace namespace Common.Types) typeName))
                    )
                    |> Elm.exposeWith
                        { exposeConstructor = False
                        , group = Just "Decoders"
                        }
                )
            )
            (SchemaUtils.typeToDecoder False namespace Common.Unit)
        , CliMonad.map
            (\encoder ->
                ( Common.Json
                , Elm.declaration ("encode" ++ typeName)
                    (Elm.functionReduced "rec" encoder
                        |> Elm.withType (Elm.Annotation.function [ Elm.Annotation.named (Common.moduleToNamespace namespace Common.Types) typeName ] Gen.Json.Encode.annotation_.value)
                    )
                    |> Elm.exposeWith
                        { exposeConstructor = False
                        , group = Just "Encoders"
                        }
                )
            )
            (SchemaUtils.typeToEncoder False namespace Common.Unit)
        ]


responseToDeclarations : List String -> String -> OpenApi.Reference.ReferenceOr OpenApi.Response.Response -> CliMonad (List ( Common.Module, Elm.Declaration ))
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


requestBodyToDeclarations : List String -> String -> OpenApi.Reference.ReferenceOr OpenApi.RequestBody.RequestBody -> CliMonad (List ( Common.Module, Elm.Declaration ))
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


toRequestFunctions : Server -> List EffectType -> List String -> String -> String -> OpenApi.Operation.Operation -> CliMonad (List ( Common.Module, Elm.Declaration ))
toRequestFunctions server effectTypes namespace method pathUrl operation =
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
                    toMsg : Elm.Expression -> Elm.Expression -> Elm.Expression
                    toMsg config msg =
                        Elm.apply (Elm.get "toMsg" config) [ msg ]

                    body :
                        ContentSchema
                        -> CliMonad (Elm.Expression -> PerPackage Elm.Expression)
                    body bodyContent =
                        case bodyContent of
                            EmptyContent ->
                                CliMonad.succeed
                                    (\_ ->
                                        { core = Gen.Http.emptyBody
                                        , elmPages = Gen.BackendTask.Http.emptyBody
                                        , lamderaProgramTest = Gen.Effect.Http.emptyBody
                                        }
                                    )

                            JsonContent type_ ->
                                SchemaUtils.typeToEncoder True namespace type_
                                    |> CliMonad.map
                                        (\encoder config ->
                                            let
                                                encoded : Elm.Expression
                                                encoded =
                                                    encoder <| Elm.get "body" config
                                            in
                                            { core = Gen.Http.jsonBody encoded
                                            , elmPages = Gen.BackendTask.Http.jsonBody encoded
                                            , lamderaProgramTest = Gen.Effect.Http.jsonBody encoded
                                            }
                                        )

                            StringContent mime ->
                                CliMonad.succeed <|
                                    \config ->
                                        let
                                            toBody : (Elm.Expression -> Elm.Expression -> Elm.Expression) -> Elm.Expression
                                            toBody f =
                                                f (Elm.string mime) (Elm.get "body" config)
                                        in
                                        { core = toBody Gen.Http.call_.stringBody
                                        , elmPages = toBody Gen.BackendTask.Http.call_.stringBody
                                        , lamderaProgramTest = toBody Gen.Effect.Http.call_.stringBody
                                        }

                            BytesContent mime ->
                                CliMonad.succeed <|
                                    \config ->
                                        let
                                            toBody : (String -> Elm.Expression -> Elm.Expression) -> Elm.Expression
                                            toBody f =
                                                f mime (Elm.get "body" config)
                                        in
                                        { core = toBody Gen.Http.bytesBody
                                        , elmPages = toBody Gen.BackendTask.Http.bytesBody
                                        , lamderaProgramTest = toBody Gen.Effect.Http.bytesBody
                                        }

                    bodyParams : ContentSchema -> CliMonad (List ( String, Elm.Annotation.Annotation ))
                    bodyParams contentSchema =
                        case contentSchema of
                            EmptyContent ->
                                CliMonad.succeed []

                            JsonContent type_ ->
                                SchemaUtils.typeToAnnotation True namespace type_
                                    |> CliMonad.map (\annotation -> [ ( "body", annotation ) ])

                            StringContent _ ->
                                CliMonad.succeed [ ( "body", Elm.Annotation.string ) ]

                            BytesContent _ ->
                                CliMonad.succeed [ ( "body", Gen.Bytes.annotation_.bytes ) ]

                    justIf : EffectType -> a -> Maybe a
                    justIf tipe value =
                        if List.member tipe effectTypes then
                            Just value

                        else
                            Nothing

                    httpHeadersFromList : AuthorizationInfo -> Elm.Expression -> Elm.Expression
                    httpHeadersFromList auth config =
                        Elm.list <| List.map (\( k, v ) -> Gen.Http.call_.header k v) <| auth.headers config

                    commands :
                        AuthorizationInfo
                        -> Elm.Annotation.Annotation
                        -> (Elm.Expression -> PerPackage Elm.Expression)
                        -> (Elm.Expression -> Elm.Expression)
                        -> ({ requireToMsg : Bool } -> PerPackage Elm.Annotation.Annotation)
                        -> CliMonad (List Elm.Declaration)
                    commands auth _ toBody replaced paramType =
                        if List.member Cmd effectTypes || List.member CmdRisky effectTypes then
                            toExpect
                                |> CliMonad.map
                                    (\expect ->
                                        let
                                            cmdArg : Elm.Expression -> Elm.Expression
                                            cmdArg config =
                                                Elm.record
                                                    [ ( "url", replaced config )
                                                    , ( "method", Elm.string method )
                                                    , ( "headers", httpHeadersFromList auth config )
                                                    , ( "expect", (expect <| toMsg config).core )
                                                    , ( "body", (toBody config).core )
                                                    , ( "timeout", Gen.Maybe.make_.nothing )
                                                    , ( "tracker", Gen.Maybe.make_.nothing )
                                                    ]

                                            cmdAnnotation : Elm.Annotation.Annotation
                                            cmdAnnotation =
                                                Elm.Annotation.function
                                                    [ (paramType { requireToMsg = True }).core ]
                                                    (Elm.Annotation.cmd (Elm.Annotation.var "msg"))
                                        in
                                        [ Elm.fn
                                            ( "config", Nothing )
                                            (\config -> Gen.Http.call_.request (cmdArg config))
                                            |> Elm.withType cmdAnnotation
                                            |> Elm.declaration functionName
                                            |> justIf Cmd
                                        , Elm.fn
                                            ( "config", Nothing )
                                            (\config -> Gen.Http.call_.riskyRequest (cmdArg config))
                                            |> Elm.withType cmdAnnotation
                                            |> Elm.declaration (functionName ++ "Risky")
                                            |> justIf CmdRisky
                                        ]
                                            |> List.filterMap identity
                                    )

                        else
                            CliMonad.succeed []

                    tasks :
                        AuthorizationInfo
                        -> Elm.Annotation.Annotation
                        -> (Elm.Expression -> PerPackage Elm.Expression)
                        -> (Elm.Expression -> Elm.Expression)
                        -> ({ requireToMsg : Bool } -> PerPackage Elm.Annotation.Annotation)
                        -> CliMonad (List Elm.Declaration)
                    tasks auth successAnnotation toBody replaced paramType =
                        if List.member Task effectTypes || List.member TaskRisky effectTypes then
                            resolver.core
                                |> CliMonad.map
                                    (\resolverCore ->
                                        let
                                            taskArg : Elm.Expression -> Elm.Expression
                                            taskArg config =
                                                Elm.record
                                                    [ ( "url", replaced config )
                                                    , ( "method", Elm.string method )
                                                    , ( "headers", httpHeadersFromList auth config )
                                                    , ( "resolver", resolverCore )
                                                    , ( "body", (toBody config).core )
                                                    , ( "timeout", Gen.Maybe.make_.nothing )
                                                    ]

                                            taskAnnotation : Elm.Annotation.Annotation
                                            taskAnnotation =
                                                Elm.Annotation.function
                                                    [ (paramType { requireToMsg = False }).core ]
                                                    (Gen.Task.annotation_.task
                                                        (Gen.OpenApi.Common.annotation_.error errorTypeAnnotation bodyTypeAnnotation)
                                                        successAnnotation
                                                    )
                                        in
                                        [ Elm.fn
                                            ( "config", Nothing )
                                            (\config -> Gen.Http.call_.task (taskArg config))
                                            |> Elm.withType taskAnnotation
                                            |> Elm.declaration (functionName ++ "Task")
                                            |> justIf Task
                                        , Elm.fn
                                            ( "config", Nothing )
                                            (\config -> Gen.Http.call_.riskyTask (taskArg config))
                                            |> Elm.withType taskAnnotation
                                            |> Elm.declaration (functionName ++ "TaskRisky")
                                            |> justIf TaskRisky
                                        ]
                                            |> List.filterMap identity
                                    )

                        else
                            CliMonad.succeed []

                    backendTask :
                        AuthorizationInfo
                        -> Elm.Annotation.Annotation
                        -> (Elm.Expression -> PerPackage Elm.Expression)
                        -> (Elm.Expression -> Elm.Expression)
                        -> ({ requireToMsg : Bool } -> PerPackage Elm.Annotation.Annotation)
                        -> CliMonad (List Elm.Declaration)
                    backendTask auth successAnnotation toBody replaced paramType =
                        if List.member BackendTask effectTypes then
                            toExpect
                                |> CliMonad.map
                                    (\innerExpect ->
                                        [ let
                                            backendTaskHeaders : Elm.Expression -> Elm.Expression
                                            backendTaskHeaders config =
                                                Elm.list <| List.map (\( k, v ) -> Elm.tuple k v) <| auth.headers config

                                            taskArg : Elm.Expression -> Elm.Expression
                                            taskArg config =
                                                Elm.record
                                                    [ ( "url", replaced config )
                                                    , ( "method", Elm.string method )
                                                    , ( "headers", backendTaskHeaders config )
                                                    , ( "body", (toBody config).elmPages )
                                                    , ( "retries", Gen.Maybe.make_.nothing )
                                                    , ( "timeoutInMs", Gen.Maybe.make_.nothing )
                                                    ]

                                            taskAnnotation : Elm.Annotation.Annotation
                                            taskAnnotation =
                                                Elm.Annotation.function
                                                    [ (paramType { requireToMsg = False }).elmPages ]
                                                    (Gen.BackendTask.annotation_.backendTask
                                                        (Elm.Annotation.record
                                                            [ ( "fatal", Gen.FatalError.annotation_.fatalError )
                                                            , ( "recoverable", Gen.BackendTask.Http.annotation_.error )
                                                            ]
                                                        )
                                                        successAnnotation
                                                    )

                                            expect : Elm.Expression -> Elm.Expression
                                            expect config =
                                                (innerExpect <| toMsg config).elmPages
                                          in
                                          Elm.fn
                                            ( "config", Nothing )
                                            (\config -> Gen.BackendTask.Http.call_.request (taskArg config) (expect config))
                                            |> Elm.withType taskAnnotation
                                            |> Elm.declaration (functionName ++ "BackendTask")
                                        ]
                                    )

                        else
                            CliMonad.succeed []

                    programTest :
                        AuthorizationInfo
                        -> Elm.Annotation.Annotation
                        -> (Elm.Expression -> PerPackage Elm.Expression)
                        -> (Elm.Expression -> Elm.Expression)
                        -> ({ requireToMsg : Bool } -> PerPackage Elm.Annotation.Annotation)
                        -> CliMonad (List Elm.Declaration)
                    programTest auth successAnnotation toBody replaced paramType =
                        if List.member ProgramTest effectTypes || List.member ProgramTestTask effectTypes then
                            CliMonad.map2
                                (\resolverLamderaProgramTest expect ->
                                    let
                                        programTestHttpHeadersFromList : Elm.Expression -> Elm.Expression
                                        programTestHttpHeadersFromList config =
                                            Elm.list <| List.map (\( k, v ) -> Gen.Effect.Http.call_.header k v) <| auth.headers config

                                        cmdArg : Elm.Expression -> Elm.Expression
                                        cmdArg config =
                                            Elm.record
                                                [ ( "url", replaced config )
                                                , ( "method", Elm.string method )
                                                , ( "headers", programTestHttpHeadersFromList config )
                                                , ( "expect", (expect <| toMsg config).lamderaProgramTest )
                                                , ( "body", (toBody config).lamderaProgramTest )
                                                , ( "timeout", Gen.Maybe.make_.nothing )
                                                , ( "tracker", Gen.Maybe.make_.nothing )
                                                ]

                                        cmdParam : Elm.Annotation.Annotation
                                        cmdParam =
                                            (paramType { requireToMsg = True }).lamderaProgramTest

                                        taskArg : Elm.Expression -> Elm.Expression
                                        taskArg config =
                                            Elm.record
                                                [ ( "url", replaced config )
                                                , ( "method", Elm.string method )
                                                , ( "headers", programTestHttpHeadersFromList config )
                                                , ( "resolver", resolverLamderaProgramTest )
                                                , ( "body", (toBody config).lamderaProgramTest )
                                                , ( "timeout", Gen.Maybe.make_.nothing )
                                                ]

                                        taskAnnotation : Elm.Annotation.Annotation
                                        taskAnnotation =
                                            Elm.Annotation.function
                                                [ (paramType { requireToMsg = False }).lamderaProgramTest ]
                                                (Gen.Effect.Task.annotation_.task
                                                    (Elm.Annotation.var "restriction")
                                                    (Gen.OpenApi.Common.annotation_.error errorTypeAnnotation bodyTypeAnnotation)
                                                    successAnnotation
                                                )
                                    in
                                    [ Elm.fn
                                        ( "config", Just cmdParam )
                                        (\config -> Gen.Effect.Http.call_.request (cmdArg config))
                                        |> Elm.declaration (functionName ++ "Effect")
                                        |> justIf ProgramTest
                                    , Elm.fn
                                        ( "config", Nothing )
                                        (\config -> Gen.Effect.Http.call_.task (taskArg config))
                                        |> Elm.withType taskAnnotation
                                        |> Elm.declaration (functionName ++ "EffectTask")
                                        |> justIf ProgramTestTask
                                    ]
                                        |> List.filterMap identity
                                )
                                resolver.lamderaProgramTest
                                toExpect

                        else
                            CliMonad.succeed []

                    documentation : AuthorizationInfo -> String
                    documentation { scopes } =
                        let
                            summaryDoc : Maybe String
                            summaryDoc =
                                OpenApi.Operation.summary operation

                            descriptionDoc : Maybe String
                            descriptionDoc =
                                OpenApi.Operation.description operation

                            scopesDoc : Maybe String
                            scopesDoc =
                                if List.isEmpty scopes then
                                    Nothing

                                else
                                    ("This operations requires the following scopes:"
                                        :: List.map
                                            (\scope ->
                                                " - `" ++ scope ++ "`"
                                            )
                                            scopes
                                    )
                                        |> String.join "\n"
                                        |> Just
                        in
                        [ summaryDoc
                        , descriptionDoc
                        , scopesDoc
                        ]
                            |> List.filterMap identity
                            |> String.join "\n\n"
                in
                CliMonad.andThen3
                    (\contentSchema auth successAnnotation ->
                        CliMonad.andThen3
                            (\toBody configAnnotation replaced ->
                                [ commands, tasks, backendTask, programTest ]
                                    |> CliMonad.combineMap
                                        (\toDecls ->
                                            toDecls auth successAnnotation toBody replaced configAnnotation
                                        )
                                    |> CliMonad.map
                                        (\decls ->
                                            (decls
                                                |> List.concatMap
                                                    (List.map
                                                        (\decl ->
                                                            ( Common.Api
                                                            , decl
                                                                |> Elm.withDocumentation (documentation auth)
                                                                |> Elm.exposeWith
                                                                    { exposeConstructor = False
                                                                    , group =
                                                                        operation
                                                                            |> operationToGroup
                                                                            |> Just
                                                                    }
                                                            )
                                                        )
                                                    )
                                            )
                                                ++ [ ( Common.Types, errorTypeDeclaration ) ]
                                        )
                            )
                            (body contentSchema)
                            (bodyParams contentSchema
                                |> CliMonad.andThen
                                    (\params ->
                                        toConfigParamAnnotation namespace
                                            { operation = operation
                                            , successAnnotation = successAnnotation
                                            , errorBodyAnnotation = bodyTypeAnnotation
                                            , errorTypeAnnotation = errorTypeAnnotation
                                            , authorizationInfo = auth
                                            , bodyParams = params
                                            , server = server
                                            }
                                    )
                            )
                            (replacedUrl server auth namespace pathUrl operation)
                    )
                    (operationToContentSchema True namespace operation)
                    (operationToAuthorizationInfo operation)
                    (SchemaUtils.typeToAnnotation True namespace successType)
            )
        |> CliMonad.withPath method
        |> CliMonad.withPath pathUrl


operationToGroup : OpenApi.Operation.Operation -> String
operationToGroup operation =
    case OpenApi.Operation.tags operation of
        [ tag ] ->
            tag

        _ ->
            "Operations"


replacedUrl : Server -> AuthorizationInfo -> List String -> String -> OpenApi.Operation.Operation -> CliMonad (Elm.Expression -> Elm.Expression)
replacedUrl server authinfo namespace pathUrl operation =
    let
        pathSegments : List String
        pathSegments =
            pathUrl
                |> String.split "/"
                |> List.filterMap
                    (\segment ->
                        if String.isEmpty segment then
                            Nothing

                        else
                            Just segment
                    )

        params : List (OpenApi.Reference.ReferenceOr OpenApi.Parameter.Parameter)
        params =
            OpenApi.Operation.parameters operation

        initialUrl : List ( String, Elm.Expression -> Elm.Expression ) -> List (Elm.Expression -> Elm.Expression) -> CliMonad (Elm.Expression -> Elm.Expression)
        initialUrl replacements queryParams =
            OpenApi.servers
                |> CliMonad.fromApiSpec
                |> CliMonad.map
                    (\servers config ->
                        let
                            authArgs : List Elm.Expression
                            authArgs =
                                authinfo.query config
                                    |> List.map
                                        (\( k, v ) ->
                                            Gen.Url.Builder.call_.string k v
                                        )

                            resolvedServer : Result String Elm.Expression
                            resolvedServer =
                                case server of
                                    Single cliServer ->
                                        Err cliServer

                                    Default ->
                                        case servers of
                                            [] ->
                                                Err ""

                                            firstServer :: _ ->
                                                -- TODO: possibly switch to config.server and generate the server list file?
                                                Err (OpenApi.Server.url firstServer)

                                    Multiple _ ->
                                        Ok (Elm.get "server" config)
                        in
                        if List.isEmpty pathSegments && List.isEmpty queryParams && List.isEmpty authArgs then
                            case resolvedServer of
                                Err "" ->
                                    Elm.string "/"

                                Err s ->
                                    Elm.string s

                                Ok s ->
                                    s

                        else
                            let
                                replacedSegments : List Elm.Expression
                                replacedSegments =
                                    pathSegments
                                        |> List.map
                                            (\segment ->
                                                case List.Extra.find (\( pattern, _ ) -> pattern == segment) replacements of
                                                    Nothing ->
                                                        Elm.string segment

                                                    Just ( _, repl ) ->
                                                        repl config
                                            )

                                replacedQueryParams : List Elm.Expression
                                replacedQueryParams =
                                    List.map (\arg -> arg config) queryParams

                                allQueryParams : Elm.Expression
                                allQueryParams =
                                    if List.isEmpty replacedQueryParams then
                                        authArgs
                                            |> Elm.list

                                    else
                                        (replacedQueryParams
                                            ++ List.map (\arg -> Gen.Maybe.make_.just arg) authArgs
                                        )
                                            |> Gen.List.filterMap Gen.Basics.identity
                            in
                            case resolvedServer of
                                Err "" ->
                                    Gen.Url.Builder.call_.absolute (Elm.list replacedSegments) allQueryParams

                                Err s ->
                                    Gen.Url.Builder.call_.crossOrigin (Elm.string s) (Elm.list replacedSegments) allQueryParams

                                Ok s ->
                                    Gen.Url.Builder.call_.crossOrigin s (Elm.list replacedSegments) allQueryParams
                    )
    in
    params
        |> CliMonad.combineMap
            (\param ->
                toConcreteParam param
                    |> CliMonad.andThen
                        (\concreteParam ->
                            paramToType True namespace concreteParam
                                |> CliMonad.andThen
                                    (\( paramName, type_ ) ->
                                        paramToString True namespace type_
                                            |> CliMonad.map
                                                (\{ inputToString, alwaysJust } ->
                                                    { concreteParam = concreteParam
                                                    , paramName = paramName
                                                    , inputToString = inputToString
                                                    , alwaysJust = alwaysJust
                                                    }
                                                )
                                    )
                        )
                    |> CliMonad.andThen
                        (\{ concreteParam, paramName, inputToString, alwaysJust } ->
                            case OpenApi.Parameter.in_ concreteParam of
                                "path" ->
                                    if OpenApi.Parameter.required concreteParam && alwaysJust then
                                        CliMonad.succeed
                                            ( Just
                                                ( "{" ++ paramName ++ "}"
                                                , \config ->
                                                    Elm.get (Common.toValueName paramName) (Elm.get "params" config)
                                                        |> inputToString
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
                (queryParams
                    |> CliMonad.combineMap (queryParameterToUrlBuilderArgument True namespace)
                )
                    |> CliMonad.andThen (initialUrl replacements)
            )


operationToAuthorizationInfo : OpenApi.Operation.Operation -> CliMonad AuthorizationInfo
operationToAuthorizationInfo operation =
    CliMonad.andThen2
        (\globalSecurity components ->
            (OpenApi.Operation.security operation ++ globalSecurity)
                |> List.concatMap
                    (Dict.toList << OpenApi.SecurityRequirement.requirements)
                |> CliMonad.foldl
                    (\e acc ->
                        case e of
                            ( "oauth_2_0", ss ) ->
                                if Dict.member "Authorization" acc.headers then
                                    CliMonad.todoWithDefault acc "Authorization header already set"

                                else
                                    CliMonad.succeed
                                        { acc
                                            | headers =
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
                                            , scopes = ss ++ acc.scopes
                                        }

                            ( "Token", [] ) ->
                                if Dict.member "Authorization" acc.headers then
                                    CliMonad.todoWithDefault acc "Authorization header already set"

                                else
                                    CliMonad.succeed
                                        { acc
                                            | headers =
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
                                                        let
                                                            cleanName : String
                                                            cleanName =
                                                                Common.toValueName (String.toLower apiKey.name)
                                                        in
                                                        case apiKey.in_ of
                                                            OpenApi.SecurityScheme.Header ->
                                                                if Dict.member apiKey.name acc.headers then
                                                                    CliMonad.todoWithDefault acc (apiKey.name ++ " header already set")

                                                                else
                                                                    CliMonad.succeed
                                                                        { acc
                                                                            | headers =
                                                                                Dict.insert apiKey.name
                                                                                    (\config ->
                                                                                        config
                                                                                            |> Elm.get "authorization"
                                                                                            |> Elm.get cleanName
                                                                                    )
                                                                                    acc.headers
                                                                            , params =
                                                                                Dict.insert "authorization"
                                                                                    (Dict.insert cleanName Elm.Annotation.string <|
                                                                                        Maybe.withDefault Dict.empty <|
                                                                                            Dict.get "authorization" acc.params
                                                                                    )
                                                                                    acc.params
                                                                        }

                                                            OpenApi.SecurityScheme.Query ->
                                                                { acc
                                                                    | query =
                                                                        Dict.insert cleanName
                                                                            (\config ->
                                                                                config
                                                                                    |> Elm.get "authorization"
                                                                                    |> Elm.get cleanName
                                                                            )
                                                                            acc.query
                                                                    , params =
                                                                        Dict.insert "authorization"
                                                                            (Dict.insert cleanName Elm.Annotation.string <|
                                                                                Maybe.withDefault Dict.empty <|
                                                                                    Dict.get "authorization" acc.params
                                                                            )
                                                                            acc.params
                                                                }
                                                                    |> CliMonad.succeed

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
                    (CliMonad.succeed
                        { headers = Dict.empty
                        , params = Dict.empty
                        , query = Dict.empty
                        , scopes = []
                        }
                    )
                |> CliMonad.map
                    (\{ headers, params, query, scopes } ->
                        { headers =
                            \config ->
                                headers
                                    |> Dict.toList
                                    |> List.map (\( k, v ) -> ( Elm.string k, v config ))
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
                        , query =
                            \config ->
                                query
                                    |> Dict.toList
                                    |> List.map (\( k, v ) -> ( Elm.string k, v config ))
                        , scopes = scopes
                        }
                    )
        )
        (CliMonad.fromApiSpec OpenApi.security)
        (CliMonad.fromApiSpec OpenApi.components)


operationToContentSchema : Bool -> List String -> OpenApi.Operation.Operation -> CliMonad ContentSchema
operationToContentSchema qualify namespace operation =
    case OpenApi.Operation.requestBody operation of
        Nothing ->
            CliMonad.succeed EmptyContent

        Just requestOrRef ->
            case OpenApi.Reference.toConcrete requestOrRef of
                Just request ->
                    OpenApi.RequestBody.content request
                        |> contentToContentSchema qualify namespace

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


contentToContentSchema : Bool -> List String -> Dict.Dict String OpenApi.MediaType.MediaType -> CliMonad ContentSchema
contentToContentSchema qualify namespace content =
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
                        |> CliMonad.andThen (SchemaUtils.schemaToType qualify namespace)
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
                |> CliMonad.andThen (SchemaUtils.schemaToType True namespace)
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
        , successAnnotation : Elm.Annotation.Annotation
        , errorBodyAnnotation : Elm.Annotation.Annotation
        , errorTypeAnnotation : Elm.Annotation.Annotation
        , authorizationInfo : AuthorizationInfo
        , bodyParams : List ( String, Elm.Annotation.Annotation )
        , server : Server
        }
    -> CliMonad ({ requireToMsg : Bool } -> PerPackage Elm.Annotation.Annotation)
toConfigParamAnnotation namespace options =
    CliMonad.map
        (\urlParams { requireToMsg } ->
            let
                maybeServer : List ( String, Elm.Annotation.Annotation )
                maybeServer =
                    case options.server of
                        Multiple _ ->
                            [ ( "server", Elm.Annotation.string ) ]

                        _ ->
                            []

                toMsgCore : Elm.Annotation.Annotation
                toMsgCore =
                    Elm.Annotation.function
                        [ Gen.Result.annotation_.result
                            (Gen.OpenApi.Common.annotation_.error options.errorTypeAnnotation options.errorBodyAnnotation)
                            options.successAnnotation
                        ]
                        (Elm.Annotation.var "msg")

                toMsgLamderaProgramTest : Elm.Annotation.Annotation
                toMsgLamderaProgramTest =
                    Elm.Annotation.function
                        [ Gen.Result.annotation_.result
                            (Gen.OpenApi.Common.annotation_.error options.errorTypeAnnotation options.errorBodyAnnotation)
                            options.successAnnotation
                        ]
                        (Elm.Annotation.var "msg")

                toAnnotation : Elm.Annotation.Annotation -> Elm.Annotation.Annotation
                toAnnotation toMsg =
                    (maybeServer
                        ++ options.authorizationInfo.params
                        ++ (if requireToMsg then
                                [ ( "toMsg", toMsg ) ]

                            else
                                []
                           )
                        ++ options.bodyParams
                        ++ urlParams
                    )
                        |> SchemaUtils.recordType
            in
            { core = toAnnotation toMsgCore

            -- This is not actually used
            , elmPages = toAnnotation toMsgCore
            , lamderaProgramTest = toAnnotation toMsgLamderaProgramTest
            }
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
                        |> CliMonad.andThen (paramToAnnotation True namespace)
                )
            |> CliMonad.map
                (\types -> [ ( "params", SchemaUtils.recordType types ) ])


queryParameterToUrlBuilderArgument : Bool -> List String -> OpenApi.Parameter.Parameter -> CliMonad (Elm.Expression -> Elm.Expression)
queryParameterToUrlBuilderArgument qualify namespace param =
    paramToType qualify namespace param
        |> CliMonad.andThen
            (\( paramName, type_ ) ->
                paramToString qualify namespace type_
                    |> CliMonad.map
                        (\{ inputToString, alwaysJust } config ->
                            let
                                name : Elm.Expression
                                name =
                                    Elm.string paramName

                                value : Elm.Expression
                                value =
                                    Elm.get (Common.toValueName paramName) (Elm.get "params" config)
                                        |> inputToString

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


paramToString : Bool -> List String -> Common.Type -> CliMonad { inputToString : Elm.Expression -> Elm.Expression, alwaysJust : Bool }
paramToString qualify namespace type_ =
    let
        basic :
            (Elm.Expression -> Elm.Expression)
            -> CliMonad { inputToString : Elm.Expression -> Elm.Expression, alwaysJust : Bool }
        basic f =
            CliMonad.succeed { inputToString = f, alwaysJust = True }

        recursive :
            Common.Type
            -> ({ inputToString : Elm.Expression, alwaysJust : Bool } -> Elm.Expression -> Elm.Expression)
            -> CliMonad { inputToString : Elm.Expression -> Elm.Expression, alwaysJust : Bool }
        recursive p f =
            paramToString qualify namespace p
                |> CliMonad.map
                    (\{ inputToString, alwaysJust } ->
                        { inputToString =
                            f
                                { alwaysJust = alwaysJust
                                , inputToString = Elm.functionReduced "toStringArg" inputToString
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
            { inputToString = identity
            , alwaysJust = False
            }
                |> CliMonad.succeed

        Common.Nullable p ->
            recursive p <|
                \{ inputToString, alwaysJust } val ->
                    if alwaysJust then
                        Gen.Maybe.call_.map inputToString val

                    else
                        Gen.Maybe.call_.andThen inputToString val

        Common.List Common.String ->
            { inputToString =
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
                \{ inputToString, alwaysJust } val ->
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
                            |> map inputToString
                            |> Gen.String.call_.join (Elm.string ",")
                            |> Gen.Maybe.make_.just
                        )

        Common.Ref ref ->
            --  These are mostly aliases
            SchemaUtils.getAlias ref
                |> CliMonad.andThen (SchemaUtils.schemaToType qualify namespace)
                |> CliMonad.andThen (paramToString qualify namespace)

        Common.OneOf name data ->
            CliMonad.map2
                (\valType branches ->
                    { inputToString =
                        \val -> Elm.Case.custom val valType branches
                    , alwaysJust = True
                    }
                )
                (SchemaUtils.typeToAnnotation qualify namespace type_)
                (CliMonad.combineMap
                    (\alternative ->
                        CliMonad.andThen2
                            (\{ inputToString, alwaysJust } annotation ->
                                if not alwaysJust then
                                    CliMonad.fail "Nullable alternative"

                                else
                                    Elm.Case.branch1 (SchemaUtils.toVariantName name alternative.name) ( "alternative", annotation ) inputToString
                                        |> CliMonad.succeed
                            )
                            (paramToString qualify namespace alternative.type_)
                            (SchemaUtils.typeToAnnotation qualify namespace alternative.type_)
                    )
                    data
                )

        _ ->
            SchemaUtils.typeToAnnotation qualify namespace type_
                |> CliMonad.andThen
                    (\annotation ->
                        let
                            msg : String
                            msg =
                                "Params of type \"" ++ Elm.Annotation.toString annotation ++ "\""
                        in
                        CliMonad.todoWithDefault
                            { inputToString = \_ -> Gen.Debug.todo msg
                            , alwaysJust = True
                            }
                            msg
                    )


paramToAnnotation : Bool -> List String -> OpenApi.Parameter.Parameter -> CliMonad ( String, Elm.Annotation.Annotation )
paramToAnnotation qualify namespace concreteParam =
    paramToType qualify namespace concreteParam
        |> CliMonad.andThen
            (\( pname, type_ ) ->
                SchemaUtils.typeToAnnotationMaybe qualify namespace type_
                    |> CliMonad.map
                        (\annotation -> ( pname, annotation ))
            )


paramToType : Bool -> List String -> OpenApi.Parameter.Parameter -> CliMonad ( String, Common.Type )
paramToType qualify namespace concreteParam =
    let
        pname : String
        pname =
            OpenApi.Parameter.name concreteParam
    in
    CliMonad.succeed concreteParam
        |> CliMonad.stepOrFail ("Could not get schema for parameter " ++ pname)
            (OpenApi.Parameter.schema >> Maybe.map OpenApi.Schema.get)
        |> CliMonad.andThen (SchemaUtils.schemaToType qualify namespace)
        |> CliMonad.andThen
            (\type_ ->
                case type_ of
                    Common.Ref ref ->
                        ref
                            |> SchemaUtils.getAlias
                            |> CliMonad.andThen (SchemaUtils.schemaToType qualify namespace)
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


type alias OperationUtils =
    { successType : Common.Type
    , bodyTypeAnnotation : Elm.Annotation.Annotation
    , errorTypeDeclaration : Elm.Declaration
    , errorTypeAnnotation : Elm.Annotation.Annotation
    , toExpect : CliMonad ((Elm.Expression -> Elm.Expression) -> PerPackage Elm.Expression)
    , resolver : PerPackage (CliMonad Elm.Expression)
    }


operationToTypesExpectAndResolver :
    List String
    -> String
    -> OpenApi.Operation.Operation
    -> CliMonad OperationUtils
operationToTypesExpectAndResolver namespace functionName operation =
    let
        responses : Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response)
        responses =
            OpenApi.Operation.responses operation

        expectJsonBetter : Elm.Expression -> Elm.Expression -> CliMonad ((Elm.Expression -> Elm.Expression) -> PerPackage Elm.Expression)
        expectJsonBetter errorDecoders successDecoder =
            CliMonad.succeed <|
                \toMsg ->
                    { core = Gen.OpenApi.Common.expectJsonCustom toMsg errorDecoders successDecoder
                    , elmPages = Gen.BackendTask.Http.expectJson successDecoder
                    , lamderaProgramTest = Gen.OpenApi.Common.expectJsonCustomEffect toMsg errorDecoders successDecoder
                    }
    in
    CliMonad.succeed responses
        |> CliMonad.stepOrFail
            ("Among the "
                ++ String.fromInt (Dict.size responses)
             -- ++ " possible responses, there was no successful one."
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
                                                |> contentToContentSchema True namespace
                                                |> CliMonad.andThen
                                                    (\contentSchema ->
                                                        case contentSchema of
                                                            JsonContent type_ ->
                                                                SchemaUtils.typeToDecoder True namespace type_
                                                                    |> CliMonad.map
                                                                        (Elm.value
                                                                            { importFrom = Common.moduleToNamespace namespace Common.Types
                                                                            , name = toErrorVariant statusCode
                                                                            , annotation = Nothing
                                                                            }
                                                                            |> Gen.Json.Decode.call_.map
                                                                        )

                                                            StringContent _ ->
                                                                CliMonad.succeed Gen.Json.Decode.string
                                                                    |> CliMonad.map
                                                                        (Elm.value
                                                                            { importFrom = Common.moduleToNamespace namespace Common.Types
                                                                            , name = toErrorVariant statusCode
                                                                            , annotation = Nothing
                                                                            }
                                                                            |> Gen.Json.Decode.call_.map
                                                                        )

                                                            BytesContent _ ->
                                                                CliMonad.todo "decode bytes err?"
                                                                    |> CliMonad.map
                                                                        (Elm.value
                                                                            { importFrom = Common.moduleToNamespace namespace Common.Types
                                                                            , name = toErrorVariant statusCode
                                                                            , annotation = Nothing
                                                                            }
                                                                            |> Gen.Json.Decode.call_.map
                                                                        )

                                                            EmptyContent ->
                                                                CliMonad.succeed (Gen.Json.Decode.succeed Elm.unit)
                                                                    |> CliMonad.map
                                                                        (Elm.value
                                                                            { importFrom = Common.moduleToNamespace namespace Common.Types
                                                                            , name = toErrorVariant statusCode
                                                                            , annotation = Nothing
                                                                            }
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
                                                                    Elm.value
                                                                        { importFrom = Common.moduleToNamespace namespace Common.Json
                                                                        , name = "decode" ++ typeName
                                                                        , annotation = Nothing
                                                                        }
                                                                )
                                                            |> CliMonad.map
                                                                (Elm.value
                                                                    { importFrom = Common.moduleToNamespace namespace Common.Types
                                                                    , name = toErrorVariant statusCode
                                                                    , annotation = Nothing
                                                                    }
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
                                                |> contentToContentSchema True namespace
                                                |> CliMonad.andThen
                                                    (\contentSchema ->
                                                        case contentSchema of
                                                            JsonContent type_ ->
                                                                SchemaUtils.typeToAnnotation False namespace type_

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
                                        Elm.alias errorName Gen.Basics.annotation_.never
                                            |> Elm.exposeWith
                                                { exposeConstructor = True
                                                , group = Just "Errors"
                                                }

                                      else
                                        dict
                                            |> Dict.toList
                                            |> List.map (\( statusCode, annotation ) -> Elm.variantWith (toErrorVariant statusCode) [ annotation ])
                                            |> Elm.customType errorName
                                            |> Elm.exposeWith
                                                { exposeConstructor = True
                                                , group = Just "Errors"
                                                }
                                    , Elm.Annotation.named (Common.moduleToNamespace namespace Common.Types) errorName
                                    )
                                )
                in
                case OpenApi.Reference.toConcrete responseOrRef of
                    Just response ->
                        OpenApi.Response.content response
                            |> contentToContentSchema True namespace
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
                                                    , resolver =
                                                        { core = CliMonad.succeed (Gen.OpenApi.Common.jsonResolverCustom errorDecoders_ successDecoder)
                                                        , elmPages = CliMonad.todo "operationToTypesExpectAndResolver -> resolver [concrete]"
                                                        , lamderaProgramTest = CliMonad.succeed (Gen.OpenApi.Common.jsonResolverCustomEffect errorDecoders_ successDecoder)
                                                        }
                                                    }
                                                )
                                                (SchemaUtils.typeToDecoder True namespace type_)
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
                                                        { core =
                                                            Gen.Http.stringResolver
                                                                (\resp ->
                                                                    Gen.Http.caseOf_.response resp
                                                                        { badUrl_ =
                                                                            \url ->
                                                                                Gen.Result.make_.err (Gen.OpenApi.Common.make_.badUrl url)
                                                                        , timeout_ =
                                                                            Gen.Result.make_.err Gen.OpenApi.Common.make_.timeout
                                                                        , networkError_ = Gen.Result.make_.err Gen.OpenApi.Common.make_.networkError
                                                                        , badStatus_ =
                                                                            \metadata body ->
                                                                                Gen.Maybe.caseOf_.maybe
                                                                                    (Gen.Dict.call_.get (Gen.String.call_.fromInt (Elm.get "statusCode" metadata)) errorDecoders_)
                                                                                    { nothing =
                                                                                        Gen.Result.make_.err
                                                                                            (Gen.OpenApi.Common.make_.unknownBadStatus metadata body)
                                                                                    , just =
                                                                                        \errorDecoder ->
                                                                                            Gen.Result.caseOf_.result
                                                                                                (Gen.Json.Decode.call_.decodeString errorDecoder body)
                                                                                                { ok =
                                                                                                    \x ->
                                                                                                        Gen.Result.make_.err
                                                                                                            (Gen.OpenApi.Common.make_.knownBadStatus (Elm.get "statusCode" metadata) x)
                                                                                                , err =
                                                                                                    \_ ->
                                                                                                        Gen.Result.make_.err
                                                                                                            (Gen.OpenApi.Common.make_.badErrorBody metadata body)
                                                                                                }
                                                                                    }
                                                                        , goodStatus_ =
                                                                            \metadata body ->
                                                                                Gen.Result.caseOf_.result
                                                                                    (Gen.Json.Decode.call_.decodeString Gen.Json.Decode.string body)
                                                                                    { err =
                                                                                        \_ ->
                                                                                            Gen.Result.make_.err (Gen.OpenApi.Common.make_.badBody metadata body)
                                                                                    , ok = \a -> Gen.Result.make_.ok a
                                                                                    }
                                                                        }
                                                                )
                                                                |> CliMonad.succeed
                                                        , elmPages = CliMonad.todo "operationToTypesExpectAndResolver -> resolver [String]"
                                                        , lamderaProgramTest = CliMonad.todo "operationToTypesExpectAndResolver -> resolver [String]"
                                                        }
                                                    }
                                                )
                                                errorDecoders
                                                errorTypeDeclaration

                                        BytesContent _ ->
                                            CliMonad.map2
                                                (\errorDecoders_ ( errorTypeDeclaration_, errorTypeAnnotation ) ->
                                                    let
                                                        toExpect : CliMonad ((Elm.Expression -> Elm.Expression) -> PerPackage Elm.Expression)
                                                        toExpect =
                                                            CliMonad.map
                                                                (\todo _ ->
                                                                    { core = todo
                                                                    , elmPages = todo
                                                                    , lamderaProgramTest = todo
                                                                    }
                                                                )
                                                                (CliMonad.todo "bytes decoder")
                                                    in
                                                    { successType = Common.Bytes
                                                    , bodyTypeAnnotation = Gen.Bytes.annotation_.bytes
                                                    , errorTypeDeclaration = errorTypeDeclaration_
                                                    , errorTypeAnnotation = errorTypeAnnotation
                                                    , toExpect = toExpect
                                                    , resolver =
                                                        { core =
                                                            Gen.Http.bytesResolver
                                                                (\resp ->
                                                                    Gen.Http.caseOf_.response resp
                                                                        { badUrl_ =
                                                                            \url ->
                                                                                Gen.Result.make_.err (Gen.OpenApi.Common.make_.badUrl url)
                                                                        , timeout_ = Gen.Result.make_.err Gen.OpenApi.Common.make_.timeout
                                                                        , networkError_ = Gen.Result.make_.err Gen.OpenApi.Common.make_.networkError
                                                                        , badStatus_ =
                                                                            \metadata body ->
                                                                                Gen.Maybe.caseOf_.maybe
                                                                                    (Gen.Dict.call_.get (Gen.String.call_.fromInt (Elm.get "statusCode" metadata)) errorDecoders_)
                                                                                    { nothing =
                                                                                        Gen.Result.make_.err
                                                                                            (Gen.OpenApi.Common.make_.unknownBadStatus metadata body)
                                                                                    , just =
                                                                                        \errorDecoder ->
                                                                                            Gen.Result.caseOf_.result
                                                                                                (Gen.Json.Decode.call_.decodeString errorDecoder body)
                                                                                                { ok =
                                                                                                    \x ->
                                                                                                        Gen.Result.make_.err
                                                                                                            (Gen.OpenApi.Common.make_.knownBadStatus (Elm.get "statusCode" metadata) x)
                                                                                                , err =
                                                                                                    \_ ->
                                                                                                        Gen.Result.make_.err
                                                                                                            (Gen.OpenApi.Common.make_.badErrorBody metadata body)
                                                                                                }
                                                                                    }
                                                                        , goodStatus_ =
                                                                            \_ body ->
                                                                                Gen.Result.make_.ok body
                                                                        }
                                                                )
                                                                |> CliMonad.succeed
                                                        , elmPages = CliMonad.todo "elm-pages - bytes resolver"
                                                        , lamderaProgramTest = CliMonad.todo "lamdera/program-test - bytes resolver"
                                                        }
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
                                                    , resolver =
                                                        { core = CliMonad.succeed (Gen.OpenApi.Common.jsonResolverCustom errorDecoders_ (Gen.Json.Decode.succeed Elm.unit))
                                                        , elmPages = CliMonad.todo "elm-pages - bytes resolver"
                                                        , lamderaProgramTest = CliMonad.succeed (Gen.OpenApi.Common.jsonResolverCustomEffect errorDecoders_ (Gen.Json.Decode.succeed Elm.unit))
                                                        }
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
                                                let
                                                    decoder : Elm.Expression
                                                    decoder =
                                                        Elm.value
                                                            { importFrom = Common.moduleToNamespace namespace Common.Json
                                                            , name = "decode" ++ typeName
                                                            , annotation = Nothing
                                                            }
                                                in
                                                { successType = Common.ref inner
                                                , bodyTypeAnnotation = Elm.Annotation.string
                                                , errorTypeDeclaration = errorTypeDeclaration_
                                                , errorTypeAnnotation = errorTypeAnnotation
                                                , toExpect = expectJsonBetter errorDecoders_ decoder
                                                , resolver =
                                                    { core = CliMonad.succeed (Gen.OpenApi.Common.jsonResolverCustom errorDecoders_ decoder)
                                                    , elmPages = CliMonad.todo "elm-pages - empty resolver"
                                                    , lamderaProgramTest = CliMonad.succeed (Gen.OpenApi.Common.jsonResolverCustomEffect errorDecoders_ decoder)
                                                    }
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
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Http.caseOf_.response response
                        { badUrl_ = \url -> Gen.Result.make_.err (Elm.apply (Elm.val "BadUrl") [ url ])
                        , timeout_ = Gen.Result.make_.err (Elm.val "Timeout")
                        , networkError_ = Gen.Result.make_.err (Elm.val "NetworkError")
                        , badStatus_ =
                            \metadata body ->
                                Gen.Maybe.caseOf_.maybe
                                    (Gen.Dict.call_.get (Gen.String.call_.fromInt (Elm.get "statusCode" metadata)) errorDecoders)
                                    { nothing =
                                        Gen.Result.make_.err
                                            (Elm.apply (Elm.val "UnknownBadStatus") [ metadata, body ])
                                    , just =
                                        \errorDecoder ->
                                            Gen.Result.caseOf_.result
                                                (Gen.Json.Decode.call_.decodeString errorDecoder body)
                                                { ok =
                                                    \x ->
                                                        Gen.Result.make_.err
                                                            (Elm.apply (Elm.val "KnownBadStatus") [ Elm.get "statusCode" metadata, x ])
                                                , err =
                                                    \_ ->
                                                        Gen.Result.make_.err
                                                            (Elm.apply (Elm.val "BadErrorBody") [ metadata, body ])
                                                }
                                    }
                        , goodStatus_ =
                            \metadata body ->
                                Gen.Result.caseOf_.result
                                    (Gen.Json.Decode.call_.decodeString successDecoder body)
                                    { err =
                                        \_ ->
                                            Gen.Result.make_.err
                                                (Elm.apply
                                                    (Elm.val "BadBody")
                                                    [ metadata, body ]
                                                )
                                    , ok = \a -> Gen.Result.make_.ok a
                                    }
                        }
            in
            Gen.Http.expectStringResponse (\result -> Elm.apply toMsg [ result ]) toResult
                |> Elm.withType (Gen.Http.annotation_.expect (Elm.Annotation.var "msg"))
        )


expectJsonCustomEffect :
    { declaration : Elm.Declaration
    , call : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , callFrom : List String -> Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , value : List String -> Elm.Expression
    }
expectJsonCustomEffect =
    Elm.Declare.fn3 "expectJsonCustomEffect"
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
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Effect.Http.caseOf_.response response
                        { badUrl_ = \url -> Gen.Result.make_.err (Elm.apply (Elm.val "BadUrl") [ url ])
                        , timeout_ = Gen.Result.make_.err (Elm.val "Timeout")
                        , networkError_ = Gen.Result.make_.err (Elm.val "NetworkError")
                        , badStatus_ =
                            \metadata body ->
                                Gen.Maybe.caseOf_.maybe
                                    (Gen.Dict.call_.get (Gen.String.call_.fromInt (Elm.get "statusCode" metadata)) errorDecoders)
                                    { nothing =
                                        Gen.Result.make_.err
                                            (Elm.apply (Elm.val "UnknownBadStatus") [ metadata, body ])
                                    , just =
                                        \errorDecoder ->
                                            Gen.Result.caseOf_.result
                                                (Gen.Json.Decode.call_.decodeString errorDecoder body)
                                                { ok =
                                                    \x ->
                                                        Gen.Result.make_.err
                                                            (Elm.apply (Elm.val "KnownBadStatus") [ Elm.get "statusCode" metadata, x ])
                                                , err =
                                                    \_ ->
                                                        Gen.Result.make_.err
                                                            (Elm.apply (Elm.val "BadErrorBody") [ metadata, body ])
                                                }
                                    }
                        , goodStatus_ =
                            \metadata body ->
                                Gen.Result.caseOf_.result
                                    (Gen.Json.Decode.call_.decodeString successDecoder body)
                                    { err =
                                        \_ ->
                                            Gen.Result.make_.err
                                                (Elm.apply
                                                    (Elm.val "BadBody")
                                                    [ metadata, body ]
                                                )
                                    , ok = \a -> Gen.Result.make_.ok a
                                    }
                        }
            in
            Gen.Effect.Http.expectStringResponse (\result -> Elm.apply toMsg [ result ]) toResult
                |> Elm.withType (Gen.Effect.Http.annotation_.expect (Elm.Annotation.var "msg"))
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
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Http.caseOf_.response response
                        { badUrl_ =
                            \url ->
                                Gen.Result.make_.err (Elm.apply (Elm.val "BadUrl") [ url ])
                        , timeout_ =
                            Gen.Result.make_.err (Elm.val "Timeout")
                        , networkError_ =
                            Gen.Result.make_.err (Elm.val "NetworkError")
                        , badStatus_ =
                            \metadata body ->
                                Gen.Maybe.caseOf_.maybe
                                    (Gen.Dict.call_.get (Gen.String.call_.fromInt (Elm.get "statusCode" metadata)) errorDecoders)
                                    { nothing =
                                        Gen.Result.make_.err
                                            (Elm.apply
                                                (Elm.val "UnknownBadStatus")
                                                [ metadata, body ]
                                            )
                                    , just =
                                        \errorDecoder ->
                                            Gen.Result.caseOf_.result
                                                (Gen.Json.Decode.call_.decodeString errorDecoder body)
                                                { ok =
                                                    \x ->
                                                        Gen.Result.make_.err
                                                            (Elm.apply (Elm.val "KnownBadStatus") [ Elm.get "statusCode" metadata, x ])
                                                , err =
                                                    \_ ->
                                                        Gen.Result.make_.err
                                                            (Elm.apply (Elm.val "BadErrorBody") [ metadata, body ])
                                                }
                                    }
                        , goodStatus_ =
                            \metadata body ->
                                Gen.Result.caseOf_.result
                                    (Gen.Json.Decode.call_.decodeString successDecoder body)
                                    { err =
                                        \_ ->
                                            Gen.Result.make_.err
                                                (Elm.apply (Elm.val "BadBody") [ metadata, body ])
                                    , ok = \a -> Gen.Result.make_.ok a
                                    }
                        }
            in
            Gen.Http.stringResolver toResult
                |> Elm.withType (Gen.Http.annotation_.resolver (Elm.Annotation.namedWith [] "Error" [ Elm.Annotation.var "err", Elm.Annotation.string ]) (Elm.Annotation.var "success"))


jsonResolverCustomEffect :
    { declaration : Elm.Declaration
    , call : Elm.Expression -> Elm.Expression -> Elm.Expression
    , callFrom : List String -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , value : List String -> Elm.Expression
    }
jsonResolverCustomEffect =
    Elm.Declare.fn2 "jsonResolverCustomEffect"
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
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Effect.Http.caseOf_.response response
                        { badUrl_ =
                            \url ->
                                Gen.Result.make_.err (Elm.apply (Elm.val "BadUrl") [ url ])
                        , timeout_ =
                            Gen.Result.make_.err (Elm.val "Timeout")
                        , networkError_ =
                            Gen.Result.make_.err (Elm.val "NetworkError")
                        , badStatus_ =
                            \metadata body ->
                                Gen.Maybe.caseOf_.maybe
                                    (Gen.Dict.call_.get (Gen.String.call_.fromInt (Elm.get "statusCode" metadata)) errorDecoders)
                                    { nothing =
                                        Gen.Result.make_.err
                                            (Elm.apply
                                                (Elm.val "UnknownBadStatus")
                                                [ metadata, body ]
                                            )
                                    , just =
                                        \errorDecoder ->
                                            Gen.Result.caseOf_.result
                                                (Gen.Json.Decode.call_.decodeString errorDecoder body)
                                                { ok =
                                                    \x ->
                                                        Gen.Result.make_.err
                                                            (Elm.apply (Elm.val "KnownBadStatus") [ Elm.get "statusCode" metadata, x ])
                                                , err =
                                                    \_ ->
                                                        Gen.Result.make_.err
                                                            (Elm.apply (Elm.val "BadErrorBody") [ metadata, body ])
                                                }
                                    }
                        , goodStatus_ =
                            \metadata body ->
                                Gen.Result.caseOf_.result
                                    (Gen.Json.Decode.call_.decodeString successDecoder body)
                                    { err =
                                        \_ ->
                                            Gen.Result.make_.err
                                                (Elm.apply (Elm.val "BadBody") [ metadata, body ])
                                    , ok = \a -> Gen.Result.make_.ok a
                                    }
                        }
            in
            Gen.Effect.Http.stringResolver toResult
                |> Elm.withType (Gen.Effect.Http.annotation_.resolver (Elm.Annotation.var "restrictions") (Elm.Annotation.namedWith [] "Error" [ Elm.Annotation.var "err", Elm.Annotation.string ]) (Elm.Annotation.var "success"))



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
