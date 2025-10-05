module OpenApi.Generate exposing (Config, ContentSchema(..), Message, Path, Mime, files)

{-|

@docs Config, ContentSchema, Message, Path, Mime, files

-}

import CliMonad exposing (CliMonad)
import Common
import Dict
import Dict.Extra
import Elm
import Elm.Annotation
import Elm.Arg
import Elm.Case
import Elm.Op
import FastDict
import FastSet
import Gen.BackendTask
import Gen.BackendTask.Http
import Gen.Base64
import Gen.Basics
import Gen.Bytes
import Gen.Bytes.Decode
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
import Gen.String
import Gen.Task
import Gen.Url.Builder
import Json.Schema.Definitions
import JsonSchema.Generate
import List.Extra
import OpenApi
import OpenApi.Common.Internal
import OpenApi.Components
import OpenApi.Config
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
import Regex exposing (Regex)
import SchemaUtils
import String.Extra


{-| -}
type alias Mime =
    String


{-| -}
type alias Message =
    { message : String
    , path : Path
    }


{-| -}
type alias Path =
    List String


{-| -}
type ContentSchema
    = EmptyContent
    | JsonContent Common.Type
    | StringContent Mime
    | BytesContent Mime
    | Base64Content Mime


type alias AuthorizationInfo =
    { headers : Elm.Expression -> List ( Elm.Expression, Elm.Expression )
    , query : Elm.Expression -> List ( Elm.Expression, Elm.Expression )
    , params : List ( Common.UnsafeName, Elm.Annotation.Annotation )
    , scopes : List String
    }


type alias PerPackage a =
    { core : a
    , elmPages : a
    , lamderaProgramTest : a
    }


{-| -}
type alias Config =
    { namespace : List String
    , generateTodos : Bool
    , effectTypes : List OpenApi.Config.EffectType
    , server : OpenApi.Config.Server
    , formats : List OpenApi.Config.Format
    }


{-| -}
files :
    Config
    -> OpenApi.OpenApi
    ->
        Result
            Message
            { modules :
                List
                    { moduleName : List String
                    , declarations : FastDict.Dict String { group : String, declaration : Elm.Declaration }
                    }
            , warnings : List Message
            , requiredPackages : FastSet.Set String
            }
files { namespace, generateTodos, effectTypes, server, formats } apiSpec =
    case extractEnums apiSpec of
        Err e ->
            Err e

        Ok enums ->
            serverInfo server
                |> CliMonad.andThen
                    (\info ->
                        CliMonad.combine
                            [ pathDeclarations info effectTypes
                            , schemasDeclarations
                            , responsesDeclarations
                            , requestBodiesDeclarations
                            , CliMonad.succeed (serverDeclarations info)
                            ]
                            |> CliMonad.map List.concat
                    )
                |> CliMonad.withPath (Common.UnsafeName (String.join "." namespace))
                |> CliMonad.run
                    SchemaUtils.oneOfDeclarations
                    { openApi = apiSpec
                    , generateTodos = generateTodos
                    , enums = enums
                    , namespace = namespace
                    , formats = formats
                    }
                |> Result.map
                    (\{ declarations, warnings, requiredPackages } ->
                        { modules =
                            declarations
                                |> Dict.Extra.groupBy (\{ moduleName } -> Common.moduleToNamespace namespace moduleName)
                                |> Dict.toList
                                |> List.map
                                    (\( moduleName, group ) ->
                                        { moduleName = moduleName
                                        , declarations =
                                            group
                                                |> List.map
                                                    (\declaration ->
                                                        ( declaration.name
                                                        , { group = declaration.group
                                                          , declaration = declaration.declaration
                                                          }
                                                        )
                                                    )
                                                |> FastDict.fromList
                                        }
                                    )
                        , warnings = warnings
                        , requiredPackages = requiredPackages
                        }
                    )


extractEnums :
    OpenApi.OpenApi
    ->
        Result
            Message
            (FastDict.Dict (List String) { name : Common.UnsafeName, documentation : Maybe String })
extractEnums openApi =
    openApi
        |> OpenApi.components
        |> Maybe.map OpenApi.Components.schemas
        |> Maybe.withDefault Dict.empty
        |> Dict.foldl
            (\name schema q ->
                Result.andThen
                    (\acc ->
                        case OpenApi.Schema.get schema of
                            Json.Schema.Definitions.ObjectSchema subSchema ->
                                case SchemaUtils.subschemaToEnumMaybe subSchema of
                                    Ok (Just { decodedEnums, hasNull }) ->
                                        if hasNull then
                                            -- If the enum can contain null then we require another named enum, without null, to name it
                                            Ok acc

                                        else
                                            Ok
                                                (FastDict.insert
                                                    (List.sort decodedEnums)
                                                    { name = Common.UnsafeName name
                                                    , documentation = subSchema.description
                                                    }
                                                    acc
                                                )

                                    Ok Nothing ->
                                        Ok acc

                                    Err e ->
                                        Err
                                            { message = e
                                            , path = [ name, "Extracting enums" ]
                                            }

                            _ ->
                                Ok acc
                    )
                    q
            )
            (Ok FastDict.empty)


serverDeclarations : ServerInfo -> List CliMonad.Declaration
serverDeclarations server =
    case server of
        MultipleServers list ->
            list
                |> List.map
                    (\{ name, url, description } ->
                        { moduleName = Common.Servers
                        , name = name
                        , declaration =
                            url
                                |> stripTrailingSlash
                                |> Elm.string
                                |> Elm.declaration name
                                |> (case description of
                                        Nothing ->
                                            identity

                                        Just doc ->
                                            Elm.withDocumentation doc
                                   )
                                |> Elm.exposeConstructor
                        , group = "Servers"
                        }
                    )

        SingleServer _ ->
            []


stripTrailingSlash : String -> String
stripTrailingSlash input =
    if String.endsWith "/" input then
        String.dropRight 1 input

    else
        input


pathDeclarations : ServerInfo -> List OpenApi.Config.EffectType -> CliMonad (List CliMonad.Declaration)
pathDeclarations server effectTypes =
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
                                        toRequestFunctions server effectTypes method url operation
                                            |> CliMonad.errorToWarning
                                    )
                                |> CliMonad.map (List.filterMap identity >> List.concat)
                        )
                    |> CliMonad.map List.concat
            )


responsesDeclarations : CliMonad (List CliMonad.Declaration)
responsesDeclarations =
    CliMonad.fromApiSpec
        (\spec ->
            spec
                |> OpenApi.components
                |> Maybe.map OpenApi.Components.responses
                |> Maybe.withDefault Dict.empty
        )
        |> CliMonad.andThen
            (Dict.foldl
                (\name schema ->
                    CliMonad.map2 (::)
                        (responseToDeclarations (Common.UnsafeName name) schema)
                )
                (CliMonad.succeed [])
            )
        |> CliMonad.map List.concat


requestBodiesDeclarations : CliMonad (List CliMonad.Declaration)
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
                        (requestBodyToDeclarations (Common.UnsafeName name) schema)
                )
                (CliMonad.succeed [])
            )
        |> CliMonad.map List.concat


schemasDeclarations : CliMonad (List CliMonad.Declaration)
schemasDeclarations =
    CliMonad.fromApiSpec
        (\spec ->
            spec
                |> OpenApi.components
                |> Maybe.map OpenApi.Components.schemas
                |> Maybe.withDefault Dict.empty
        )
        |> CliMonad.andThen
            (Dict.foldl
                (\name schema ->
                    CliMonad.map2
                        (\decls declAcc -> decls ++ declAcc)
                        (JsonSchema.Generate.schemaToDeclarations (Common.UnsafeName name) (OpenApi.Schema.get schema))
                )
                (CliMonad.succeed [])
            )


unitDeclarations : Common.UnsafeName -> CliMonad (List CliMonad.Declaration)
unitDeclarations name =
    let
        typeName : Common.TypeName
        typeName =
            Common.toTypeName name
    in
    CliMonad.combine
        [ { moduleName = Common.Types
          , name = typeName
          , declaration =
                Elm.alias typeName Elm.Annotation.unit
                    |> Elm.expose
          , group = "Aliases"
          }
            |> CliMonad.succeed
        , CliMonad.map2
            (\typesNamespace schemaDecoder ->
                { moduleName = Common.Json
                , name = "decode" ++ typeName
                , declaration =
                    Elm.declaration ("decode" ++ typeName)
                        (schemaDecoder
                            |> Elm.withType (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.named typesNamespace typeName))
                        )
                        |> Elm.exposeConstructor
                , group = "Decoders"
                }
            )
            (CliMonad.moduleToNamespace Common.Types)
            (SchemaUtils.typeToDecoder False Common.Unit)
        , CliMonad.map2
            (\typesNamespace encoder ->
                { moduleName = Common.Json
                , name = "encode" ++ typeName
                , declaration =
                    Elm.declaration ("encode" ++ typeName)
                        (Elm.functionReduced "rec" encoder
                            |> Elm.withType (Elm.Annotation.function [ Elm.Annotation.named typesNamespace typeName ] Gen.Json.Encode.annotation_.value)
                        )
                        |> Elm.expose
                , group = "Encoders"
                }
            )
            (CliMonad.moduleToNamespace Common.Types)
            (SchemaUtils.typeToEncoder False Common.Unit)
        ]


responseToDeclarations : Common.UnsafeName -> OpenApi.Reference.ReferenceOr OpenApi.Response.Response -> CliMonad (List CliMonad.Declaration)
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
                    |> CliMonad.andThen (JsonSchema.Generate.schemaToDeclarations name)

        Nothing ->
            CliMonad.fail "Could not convert reference to concrete value"
                |> CliMonad.withPath name


requestBodyToDeclarations : Common.UnsafeName -> OpenApi.Reference.ReferenceOr OpenApi.RequestBody.RequestBody -> CliMonad (List CliMonad.Declaration)
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
                    |> CliMonad.andThen (JsonSchema.Generate.schemaToDeclarations name)

        Nothing ->
            CliMonad.fail "Could not convert reference to concrete value"
                |> CliMonad.withPath name


toRequestFunctions : ServerInfo -> List OpenApi.Config.EffectType -> String -> String -> OpenApi.Operation.Operation -> CliMonad (List CliMonad.Declaration)
toRequestFunctions server effectTypes method pathUrl operation =
    let
        functionName : String
        functionName =
            OpenApi.Operation.operationId operation
                |> Maybe.withDefault pathUrl
                |> makeNamespaceValid
                |> removeInvalidChars
                |> String.Extra.camelize
                |> (\n ->
                        if String.isEmpty n then
                            "root"

                        else
                            n
                   )

        isSinglePackage : Bool
        isSinglePackage =
            (effectTypes
                |> List.map OpenApi.Config.effectTypeToPackage
                |> List.Extra.unique
                |> List.length
            )
                == 1

        toMsg : Elm.Expression -> Elm.Expression
        toMsg config =
            Elm.get "toMsg" config

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
                    SchemaUtils.typeToEncoder True type_
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

                Base64Content mime ->
                    CliMonad.succeed <|
                        \config ->
                            let
                                toBody : (Elm.Expression -> Elm.Expression -> Elm.Expression) -> Elm.Expression
                                toBody f =
                                    f (Elm.string mime)
                                        (Elm.get "body" config
                                            |> Gen.Base64.fromBytes
                                            |> Gen.Maybe.withDefault (Elm.string "")
                                        )
                            in
                            { core = toBody Gen.Http.call_.stringBody
                            , elmPages = toBody Gen.BackendTask.Http.call_.stringBody
                            , lamderaProgramTest = toBody Gen.Effect.Http.call_.stringBody
                            }

        bodyParams : ContentSchema -> CliMonad (List ( Common.UnsafeName, Elm.Annotation.Annotation ))
        bodyParams contentSchema =
            case contentSchema of
                EmptyContent ->
                    CliMonad.succeed []

                JsonContent type_ ->
                    SchemaUtils.typeToAnnotationWithNullable True type_
                        |> CliMonad.map (\annotation -> [ ( Common.UnsafeName "body", annotation ) ])

                StringContent _ ->
                    CliMonad.succeed [ ( Common.UnsafeName "body", Elm.Annotation.string ) ]

                BytesContent _ ->
                    CliMonad.succeed [ ( Common.UnsafeName "body", Gen.Bytes.annotation_.bytes ) ]
                        |> CliMonad.withRequiredPackage "elm/bytes"

                Base64Content _ ->
                    CliMonad.succeed [ ( Common.UnsafeName "body", Gen.Bytes.annotation_.bytes ) ]
                        |> CliMonad.withRequiredPackage "elm/bytes"
                        |> CliMonad.withRequiredPackage Common.base64PackageName

        headersFromList : (Elm.Expression -> Elm.Expression -> Elm.Expression) -> AuthorizationInfo -> Elm.Expression -> List (Elm.Expression -> ( Elm.Expression, Elm.Expression, Bool )) -> Elm.Expression
        headersFromList f auth config headerFunctions =
            let
                headerParams : List ( Elm.Expression, Elm.Expression, Bool )
                headerParams =
                    List.map (\toHeader -> toHeader config) headerFunctions

                hasMaybes : Bool
                hasMaybes =
                    List.any (\( _, _, isMaybe ) -> isMaybe) headerParams

                authHeaders : List Elm.Expression
                authHeaders =
                    List.map
                        (\( k, v ) ->
                            if hasMaybes then
                                Elm.just
                                    (f k v)

                            else
                                f k v
                        )
                        (auth.headers config)

                paramHeaders : List Elm.Expression
                paramHeaders =
                    List.map
                        (\( k, v, isMaybe ) ->
                            if isMaybe then
                                Gen.Maybe.map (f k) v

                            else if hasMaybes then
                                Elm.just (f k v)

                            else
                                f k v
                        )
                        headerParams
            in
            case authHeaders ++ paramHeaders of
                [] ->
                    Elm.list []

                allHeaders ->
                    allHeaders
                        |> Elm.list
                        |> (if hasMaybes then
                                Gen.List.call_.filterMap Gen.Basics.values_.identity

                            else
                                identity
                           )

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

        step : OperationUtils -> CliMonad (List CliMonad.Declaration)
        step { successType, bodyTypeAnnotation, errorTypeDeclaration, errorTypeAnnotation, expect, resolver } =
            let
                declarationGroup :
                    (PerPackage (CliMonad (Elm.Expression -> Elm.Expression)) -> CliMonad (Elm.Expression -> Elm.Expression))
                    -> AuthorizationInfo
                    -> ((Elm.Expression -> Elm.Expression) -> a)
                    -> List ( OpenApi.Config.EffectType, a -> ( String, Elm.Expression ) )
                    -> CliMonad (List CliMonad.Declaration)
                declarationGroup package auth sharedData list =
                    if List.any (\( effectType, _ ) -> List.member effectType effectTypes) list then
                        package expect
                            |> CliMonad.map
                                (\specificExpect ->
                                    let
                                        shared : a
                                        shared =
                                            sharedData specificExpect
                                    in
                                    List.filterMap
                                        (\( effectType, toDeclaration ) ->
                                            if List.member effectType effectTypes then
                                                let
                                                    ( name, expr ) =
                                                        toDeclaration shared
                                                in
                                                { moduleName =
                                                    if isSinglePackage then
                                                        Common.Api Nothing

                                                    else
                                                        Common.Api (Just (OpenApi.Config.effectTypeToPackage effectType))
                                                , name = name
                                                , declaration =
                                                    expr
                                                        |> Elm.declaration name
                                                        |> Elm.withDocumentation (documentation auth)
                                                        |> Elm.expose
                                                , group =
                                                    operationToGroup operation
                                                }
                                                    |> Just

                                            else
                                                Nothing
                                        )
                                        list
                                )

                    else
                        CliMonad.succeed []

                elmHttpCommands :
                    AuthorizationInfo
                    -> List (Elm.Expression -> ( Elm.Expression, Elm.Expression, Bool ))
                    -> Elm.Annotation.Annotation
                    -> (Elm.Expression -> PerPackage Elm.Expression)
                    -> (Elm.Expression -> Elm.Expression)
                    -> ({ requireToMsg : Bool } -> PerPackage Elm.Annotation.Annotation)
                    -> CliMonad (List CliMonad.Declaration)
                elmHttpCommands auth toHeaderParams _ toBody replaced paramType =
                    declarationGroup .core
                        auth
                        (\specificExpect ->
                            { cmdArg =
                                \config ->
                                    Elm.record
                                        [ ( "url", replaced config )
                                        , ( "method", Elm.string method )
                                        , ( "headers"
                                          , headersFromList Gen.Http.call_.header auth config toHeaderParams
                                          )
                                        , ( "expect", specificExpect <| toMsg config )
                                        , ( "body", (toBody config).core )
                                        , ( "timeout", Gen.Maybe.make_.nothing )
                                        , ( "tracker", Gen.Maybe.make_.nothing )
                                        ]
                            , cmdAnnotation =
                                Elm.Annotation.function
                                    [ (paramType { requireToMsg = True }).core ]
                                    (Elm.Annotation.cmd (Elm.Annotation.var "msg"))
                            , recordAnnotation =
                                Elm.Annotation.function
                                    [ (paramType { requireToMsg = True }).core ]
                                    (Elm.Annotation.record
                                        [ ( "method", Elm.Annotation.string )
                                        , ( "headers", Elm.Annotation.list Gen.Http.annotation_.header )
                                        , ( "url", Elm.Annotation.string )
                                        , ( "body", Gen.Http.annotation_.header )
                                        , ( "expect", Gen.Http.annotation_.expect (Elm.Annotation.var "msg") )
                                        , ( "timeout", Elm.Annotation.maybe Elm.Annotation.float )
                                        , ( "tracker", Elm.Annotation.maybe Elm.Annotation.string )
                                        ]
                                    )
                            }
                        )
                        [ ( OpenApi.Config.ElmHttpCmd
                          , \{ cmdArg, cmdAnnotation } ->
                                ( functionName
                                , Elm.fn
                                    (Elm.Arg.var "config")
                                    (\config -> Gen.Http.call_.request (cmdArg config))
                                    |> Elm.withType cmdAnnotation
                                )
                          )
                        , ( OpenApi.Config.ElmHttpCmdRisky
                          , \{ cmdArg, cmdAnnotation } ->
                                ( functionName ++ "Risky"
                                , Elm.fn
                                    (Elm.Arg.var "config")
                                    (\config -> Gen.Http.call_.riskyRequest (cmdArg config))
                                    |> Elm.withType cmdAnnotation
                                )
                          )
                        , ( OpenApi.Config.ElmHttpCmdRecord
                          , \{ cmdArg, recordAnnotation } ->
                                ( functionName ++ "Record"
                                , Elm.fn
                                    (Elm.Arg.var "config")
                                    cmdArg
                                    |> Elm.withType recordAnnotation
                                )
                          )
                        ]

                elmHttpTasks :
                    AuthorizationInfo
                    -> List (Elm.Expression -> ( Elm.Expression, Elm.Expression, Bool ))
                    -> Elm.Annotation.Annotation
                    -> (Elm.Expression -> PerPackage Elm.Expression)
                    -> (Elm.Expression -> Elm.Expression)
                    -> ({ requireToMsg : Bool } -> PerPackage Elm.Annotation.Annotation)
                    -> CliMonad (List CliMonad.Declaration)
                elmHttpTasks auth toHeaderParams successAnnotation toBody replaced paramType =
                    declarationGroup .core
                        auth
                        (\_ ->
                            { taskArg =
                                \config ->
                                    Elm.record
                                        [ ( "url", replaced config )
                                        , ( "method", Elm.string method )
                                        , ( "headers"
                                          , headersFromList Gen.Http.call_.header auth config toHeaderParams
                                          )
                                        , ( "resolver", resolver.core )
                                        , ( "body", (toBody config).core )
                                        , ( "timeout", Gen.Maybe.make_.nothing )
                                        ]
                            , taskAnnotation =
                                Elm.Annotation.function
                                    [ (paramType { requireToMsg = False }).core ]
                                    (Gen.Task.annotation_.task
                                        (OpenApi.Common.Internal.annotation_.error errorTypeAnnotation bodyTypeAnnotation)
                                        successAnnotation
                                    )
                            , recordAnnotation =
                                Elm.Annotation.function
                                    [ (paramType { requireToMsg = False }).core ]
                                    (Elm.Annotation.record
                                        [ ( "method", Elm.Annotation.string )
                                        , ( "headers", Gen.Http.annotation_.header )
                                        , ( "url", Elm.Annotation.string )
                                        , ( "body", Gen.Http.annotation_.body )
                                        , ( "resolver"
                                          , Gen.Http.annotation_.resolver
                                                (OpenApi.Common.Internal.annotation_.error errorTypeAnnotation bodyTypeAnnotation)
                                                successAnnotation
                                          )
                                        , ( "timeout", Elm.Annotation.maybe Elm.Annotation.float )
                                        ]
                                    )
                            }
                        )
                        [ ( OpenApi.Config.ElmHttpTask
                          , \{ taskArg, taskAnnotation } ->
                                ( functionName ++ "Task"
                                , Elm.fn
                                    (Elm.Arg.var "config")
                                    (\config -> Gen.Http.call_.task (taskArg config))
                                    |> Elm.withType taskAnnotation
                                )
                          )
                        , ( OpenApi.Config.ElmHttpTaskRisky
                          , \{ taskArg, taskAnnotation } ->
                                ( functionName ++ "TaskRisky"
                                , Elm.fn
                                    (Elm.Arg.var "config")
                                    (\config -> Gen.Http.call_.riskyTask (taskArg config))
                                    |> Elm.withType taskAnnotation
                                )
                          )
                        , ( OpenApi.Config.ElmHttpTaskRecord
                          , \{ taskArg, recordAnnotation } ->
                                ( functionName ++ "TaskRecord"
                                , Elm.fn
                                    (Elm.Arg.var "config")
                                    taskArg
                                    |> Elm.withType recordAnnotation
                                )
                          )
                        ]

                dillonkearnsElmPagesBackendTask :
                    AuthorizationInfo
                    -> List (Elm.Expression -> ( Elm.Expression, Elm.Expression, Bool ))
                    -> Elm.Annotation.Annotation
                    -> (Elm.Expression -> PerPackage Elm.Expression)
                    -> (Elm.Expression -> Elm.Expression)
                    -> ({ requireToMsg : Bool } -> PerPackage Elm.Annotation.Annotation)
                    -> CliMonad (List CliMonad.Declaration)
                dillonkearnsElmPagesBackendTask auth toHeaderParams successAnnotation toBody replaced paramType =
                    declarationGroup .elmPages
                        auth
                        (\specificExpect ->
                            { taskArg =
                                \config ->
                                    Elm.record
                                        [ ( "url", replaced config )
                                        , ( "method", Elm.string method )
                                        , ( "headers"
                                          , headersFromList Elm.tuple auth config toHeaderParams
                                          )
                                        , ( "body", (toBody config).elmPages )
                                        , ( "retries", Gen.Maybe.make_.nothing )
                                        , ( "timeoutInMs", Gen.Maybe.make_.nothing )
                                        ]
                            , taskAnnotation =
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
                            , recordAnnotation =
                                Elm.Annotation.function
                                    [ (paramType { requireToMsg = False }).elmPages ]
                                    (Elm.Annotation.tuple
                                        (Elm.Annotation.record
                                            [ ( "url", Elm.Annotation.string )
                                            , ( "method", Elm.Annotation.string )
                                            , ( "headers", Elm.Annotation.list (Elm.Annotation.tuple Elm.Annotation.string Elm.Annotation.string) )
                                            , ( "body", Gen.BackendTask.Http.annotation_.body )
                                            , ( "retries", Elm.Annotation.maybe Elm.Annotation.int )
                                            , ( "timeoutInMs", Elm.Annotation.maybe Elm.Annotation.int )
                                            ]
                                        )
                                        (Gen.BackendTask.Http.annotation_.expect (Elm.Annotation.var "a"))
                                    )
                            , specificExpect = specificExpect
                            }
                        )
                        [ ( OpenApi.Config.DillonkearnsElmPagesTask
                          , \{ taskArg, taskAnnotation, specificExpect } ->
                                ( functionName
                                , Elm.fn
                                    (Elm.Arg.var "config")
                                    (\config -> Gen.BackendTask.Http.call_.request (taskArg config) (specificExpect <| toMsg config))
                                    |> Elm.withType taskAnnotation
                                )
                          )
                        , ( OpenApi.Config.DillonkearnsElmPagesTaskRecord
                          , \{ taskArg, recordAnnotation, specificExpect } ->
                                ( functionName
                                , Elm.fn
                                    (Elm.Arg.var "config")
                                    (\config -> Elm.tuple (taskArg config) (specificExpect <| toMsg config))
                                    |> Elm.withType recordAnnotation
                                )
                          )
                        ]

                lamderaProgramTestCommands :
                    AuthorizationInfo
                    -> List (Elm.Expression -> ( Elm.Expression, Elm.Expression, Bool ))
                    -> Elm.Annotation.Annotation
                    -> (Elm.Expression -> PerPackage Elm.Expression)
                    -> (Elm.Expression -> Elm.Expression)
                    -> ({ requireToMsg : Bool } -> PerPackage Elm.Annotation.Annotation)
                    -> CliMonad (List CliMonad.Declaration)
                lamderaProgramTestCommands auth toHeaderParams _ toBody replaced paramType =
                    declarationGroup .lamderaProgramTest
                        auth
                        (\specificExpect ->
                            { cmdArg =
                                \config ->
                                    Elm.record
                                        [ ( "url", replaced config )
                                        , ( "method", Elm.string method )
                                        , ( "headers"
                                          , headersFromList Gen.Effect.Http.call_.header auth config toHeaderParams
                                          )
                                        , ( "expect", specificExpect <| toMsg config )
                                        , ( "body", (toBody config).lamderaProgramTest )
                                        , ( "timeout", Gen.Maybe.make_.nothing )
                                        , ( "tracker", Gen.Maybe.make_.nothing )
                                        ]
                            , cmdParam = (paramType { requireToMsg = True }).lamderaProgramTest
                            }
                        )
                        [ ( OpenApi.Config.LamderaProgramTestCmd
                          , \{ cmdArg, cmdParam } ->
                                ( functionName
                                , Elm.fn
                                    (Elm.Arg.varWith "config" cmdParam)
                                    (\config -> Gen.Effect.Http.call_.request (cmdArg config))
                                )
                          )
                        , ( OpenApi.Config.LamderaProgramTestCmdRisky
                          , \{ cmdArg, cmdParam } ->
                                ( functionName ++ "Risky"
                                , Elm.fn
                                    (Elm.Arg.varWith "config" cmdParam)
                                    (\config -> Gen.Effect.Http.call_.riskyRequest (cmdArg config))
                                )
                          )
                        , ( OpenApi.Config.LamderaProgramTestCmdRecord
                          , \{ cmdArg, cmdParam } ->
                                ( functionName ++ "Record"
                                , Elm.fn
                                    (Elm.Arg.varWith "config" cmdParam)
                                    cmdArg
                                )
                          )
                        ]

                lamderaProgramTestTasks :
                    AuthorizationInfo
                    -> List (Elm.Expression -> ( Elm.Expression, Elm.Expression, Bool ))
                    -> Elm.Annotation.Annotation
                    -> (Elm.Expression -> PerPackage Elm.Expression)
                    -> (Elm.Expression -> Elm.Expression)
                    -> ({ requireToMsg : Bool } -> PerPackage Elm.Annotation.Annotation)
                    -> CliMonad (List CliMonad.Declaration)
                lamderaProgramTestTasks auth toHeaderParams successAnnotation toBody replaced paramType =
                    declarationGroup .lamderaProgramTest
                        auth
                        (\_ ->
                            { taskArg =
                                \config ->
                                    Elm.record
                                        [ ( "url", replaced config )
                                        , ( "method", Elm.string method )
                                        , ( "headers"
                                          , headersFromList Gen.Effect.Http.call_.header auth config toHeaderParams
                                          )
                                        , ( "resolver", resolver.lamderaProgramTest )
                                        , ( "body", (toBody config).lamderaProgramTest )
                                        , ( "timeout", Gen.Maybe.make_.nothing )
                                        ]
                            , taskAnnotation =
                                Elm.Annotation.function
                                    [ (paramType { requireToMsg = False }).lamderaProgramTest ]
                                    (Gen.Effect.Task.annotation_.task
                                        (Elm.Annotation.var "restriction")
                                        (OpenApi.Common.Internal.annotation_.error errorTypeAnnotation bodyTypeAnnotation)
                                        successAnnotation
                                    )
                            , recordAnnotation =
                                Elm.Annotation.function
                                    [ (paramType { requireToMsg = False }).lamderaProgramTest ]
                                    (Elm.Annotation.record
                                        [ ( "method", Elm.Annotation.string )
                                        , ( "headers", Elm.Annotation.list Gen.Effect.Http.annotation_.header )
                                        , ( "url", Elm.Annotation.string )
                                        , ( "body", Gen.Effect.Http.annotation_.body )
                                        , ( "resolver"
                                          , Gen.Effect.Http.annotation_.resolver
                                                (Elm.Annotation.var "restriction")
                                                (OpenApi.Common.Internal.annotation_.error errorTypeAnnotation bodyTypeAnnotation)
                                                successAnnotation
                                          )
                                        , ( "timeout", Elm.Annotation.maybe (Elm.Annotation.namedWith [ "Duration" ] "Duration" []) )
                                        ]
                                    )
                            }
                        )
                        [ ( OpenApi.Config.LamderaProgramTestTask
                          , \{ taskArg, taskAnnotation } ->
                                ( functionName ++ "Task"
                                , Elm.fn
                                    (Elm.Arg.var "config")
                                    (\config -> Gen.Effect.Http.call_.task (taskArg config))
                                    |> Elm.withType taskAnnotation
                                )
                          )
                        , ( OpenApi.Config.LamderaProgramTestTaskRisky
                          , \{ taskArg, taskAnnotation } ->
                                ( functionName ++ "TaskRisky"
                                , Elm.fn
                                    (Elm.Arg.var "config")
                                    (\config -> Gen.Effect.Http.call_.riskyTask (taskArg config))
                                    |> Elm.withType taskAnnotation
                                )
                          )
                        , ( OpenApi.Config.LamderaProgramTestTaskRecord
                          , \{ taskArg, recordAnnotation } ->
                                ( functionName ++ "TaskRecord"
                                , Elm.fn
                                    (Elm.Arg.var "config")
                                    taskArg
                                    |> Elm.withType recordAnnotation
                                )
                          )
                        ]
            in
            CliMonad.andThen3
                (\contentSchema auth successAnnotation ->
                    CliMonad.andThen4
                        (\toBody configAnnotation replaced toHeaderParams ->
                            CliMonad.map2 (++)
                                ([ elmHttpCommands, elmHttpTasks, dillonkearnsElmPagesBackendTask, lamderaProgramTestCommands, lamderaProgramTestTasks ]
                                    |> CliMonad.combineMap
                                        (\toDecls ->
                                            toDecls auth toHeaderParams successAnnotation toBody replaced configAnnotation
                                        )
                                    |> CliMonad.map List.concat
                                )
                                (case errorTypeDeclaration of
                                    Just { name, declaration, group } ->
                                        [ { moduleName = Common.Types
                                          , name = name
                                          , declaration = declaration
                                          , group = group
                                          }
                                        ]
                                            |> CliMonad.succeed

                                    Nothing ->
                                        [] |> CliMonad.succeed
                                )
                        )
                        (body contentSchema)
                        (bodyParams contentSchema
                            |> CliMonad.andThen
                                (\params ->
                                    toConfigParamAnnotation
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
                        (replacedUrl server auth pathUrl operation)
                        (operationToHeaderParams operation)
                )
                (operationToContentSchema operation)
                (operationToAuthorizationInfo operation)
                (SchemaUtils.typeToAnnotationWithNullable True successType)
    in
    operationToTypesExpectAndResolver functionName operation
        |> CliMonad.andThen step
        |> CliMonad.withPath (Common.UnsafeName method)
        |> CliMonad.withPath (Common.UnsafeName pathUrl)


operationToGroup : OpenApi.Operation.Operation -> String
operationToGroup operation =
    case OpenApi.Operation.tags operation of
        [ tag ] ->
            tag

        _ ->
            "Operations"


operationToHeaderParams : OpenApi.Operation.Operation -> CliMonad (List (Elm.Expression -> ( Elm.Expression, Elm.Expression, Bool )))
operationToHeaderParams operation =
    operation
        |> OpenApi.Operation.parameters
        |> CliMonad.combineMap
            (\param ->
                toConcreteParam param
                    |> CliMonad.andThen
                        (\concreteParam ->
                            case OpenApi.Parameter.in_ concreteParam of
                                "path" ->
                                    -- NOTE: This is handled in `replacedUrl`
                                    CliMonad.succeed Nothing

                                "query" ->
                                    -- NOTE: This is handled in `replacedUrl`
                                    CliMonad.succeed Nothing

                                "header" ->
                                    paramToType True concreteParam
                                        |> CliMonad.andThen
                                            (\( paramName, type_ ) ->
                                                paramToString True type_
                                                    |> CliMonad.map
                                                        (\{ inputToString, isMaybe } ->
                                                            (\config ->
                                                                ( paramName
                                                                    |> Common.unwrapUnsafe
                                                                    |> Elm.string
                                                                , config
                                                                    |> Elm.get "params"
                                                                    |> Elm.get (Common.toValueName paramName)
                                                                    |> inputToStringToFunction inputToString
                                                                , isMaybe
                                                                )
                                                            )
                                                                |> Just
                                                        )
                                            )
                                        |> CliMonad.withPath (Common.UnsafeName "header params")

                                _ ->
                                    -- NOTE: The warning for this is handled in `replacedUrl`
                                    CliMonad.succeed Nothing
                        )
            )
        |> CliMonad.map (List.filterMap identity)


replacedUrl : ServerInfo -> AuthorizationInfo -> String -> OpenApi.Operation.Operation -> CliMonad (Elm.Expression -> Elm.Expression)
replacedUrl server authInfo pathUrl operation =
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

        initialUrl : List ( String, Elm.Expression -> Elm.Expression ) -> List (Elm.Expression -> Elm.Expression) -> (Elm.Expression -> Elm.Expression)
        initialUrl replacements queryParams config =
            let
                authArgs : List Elm.Expression
                authArgs =
                    authInfo.query config
                        |> List.map
                            (\( k, v ) ->
                                Gen.Url.Builder.call_.string k v
                            )
            in
            if List.isEmpty pathSegments && List.isEmpty queryParams && List.isEmpty authArgs then
                case server of
                    SingleServer "" ->
                        Elm.string "/"

                    SingleServer s ->
                        Elm.string (stripTrailingSlash s)

                    MultipleServers _ ->
                        Elm.get "server" config

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
                case server of
                    SingleServer "" ->
                        Gen.Url.Builder.call_.absolute (Elm.list replacedSegments) allQueryParams

                    SingleServer s ->
                        Gen.Url.Builder.call_.crossOrigin (Elm.string (stripTrailingSlash s)) (Elm.list replacedSegments) allQueryParams

                    MultipleServers _ ->
                        Gen.Url.Builder.call_.crossOrigin (Elm.get "server" config) (Elm.list replacedSegments) allQueryParams
    in
    operation
        |> OpenApi.Operation.parameters
        |> CliMonad.combineMap
            (\param ->
                toConcreteParam param
                    |> CliMonad.andThen
                        (\concreteParam ->
                            case OpenApi.Parameter.in_ concreteParam of
                                "path" ->
                                    paramToType True concreteParam
                                        |> CliMonad.andThen
                                            (\( paramName, type_ ) ->
                                                paramToString True type_
                                                    |> CliMonad.map
                                                        (\{ inputToString, alwaysJust } ->
                                                            { paramName = paramName
                                                            , inputToString = inputToString
                                                            , alwaysJust = alwaysJust
                                                            }
                                                        )
                                            )
                                        |> CliMonad.andThen
                                            (\{ paramName, inputToString, alwaysJust } ->
                                                if OpenApi.Parameter.required concreteParam && alwaysJust then
                                                    ( Just
                                                        ( "{" ++ Common.toValueName paramName ++ "}"
                                                        , \config ->
                                                            config
                                                                |> Elm.get "params"
                                                                |> Elm.get (Common.toValueName paramName)
                                                                |> inputToStringToFunction inputToString
                                                        )
                                                    , []
                                                    )
                                                        |> CliMonad.succeed

                                                else
                                                    CliMonad.fail "Optional parameters in path"
                                            )
                                        |> CliMonad.withPath (Common.UnsafeName "path params")

                                "query" ->
                                    CliMonad.succeed ( Nothing, [ concreteParam ] )

                                "header" ->
                                    -- NOTE: This is handled in `operationToHeaderParams`
                                    CliMonad.succeed ( Nothing, [] )

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
                queryParams
                    |> CliMonad.combineMap (queryParameterToUrlBuilderArgument True)
                    |> CliMonad.map (\arg -> initialUrl replacements (List.concat arg))
            )


operationToAuthorizationInfo : OpenApi.Operation.Operation -> CliMonad AuthorizationInfo
operationToAuthorizationInfo operation =
    CliMonad.andThen2
        (\globalSecurity components ->
            -- If present, the operation's security overrides globalSecurity.
            OpenApi.Operation.security operation
                |> Maybe.withDefault globalSecurity
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
                                                            unsafeName : Common.UnsafeName
                                                            unsafeName =
                                                                Common.UnsafeName (String.toLower apiKey.name)

                                                            cleanName : String
                                                            cleanName =
                                                                Common.toValueName unsafeName
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

                                                    OpenApi.SecurityScheme.Http details ->
                                                        case details.scheme of
                                                            "bearer" ->
                                                                let
                                                                    unsafeName : Common.UnsafeName
                                                                    unsafeName =
                                                                        Common.UnsafeName (String.toLower name)

                                                                    cleanName : String
                                                                    cleanName =
                                                                        Common.toValueName unsafeName
                                                                in
                                                                { acc
                                                                    | headers =
                                                                        Dict.insert "authorization"
                                                                            (\config ->
                                                                                Elm.Op.append
                                                                                    (Elm.string "Bearer ")
                                                                                    (config
                                                                                        |> Elm.get "authorization"
                                                                                        |> Elm.get cleanName
                                                                                    )
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
                                                                    |> CliMonad.succeed

                                                            unsupportedScheme ->
                                                                CliMonad.todoWithDefault acc ("Unsupported security schema 'Http' with scheme of '" ++ unsupportedScheme ++ "'")

                                                    OpenApi.SecurityScheme.MutualTls ->
                                                        CliMonad.todoWithDefault acc "Unsupported security schema: MutualTls"

                                                    OpenApi.SecurityScheme.Oauth2 _ ->
                                                        let
                                                            unsafeName : Common.UnsafeName
                                                            unsafeName =
                                                                Common.UnsafeName (String.toLower name)

                                                            cleanName : String
                                                            cleanName =
                                                                Common.toValueName unsafeName
                                                        in
                                                        { acc
                                                            | headers =
                                                                Dict.insert "authorization"
                                                                    (\config ->
                                                                        Elm.Op.append
                                                                            (Elm.string "Bearer ")
                                                                            (config
                                                                                |> Elm.get "authorization"
                                                                                |> Elm.get cleanName
                                                                            )
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
                                                            |> CliMonad.succeed

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
                                |> List.map (Tuple.mapFirst Common.UnsafeName)
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


operationToContentSchema : OpenApi.Operation.Operation -> CliMonad ContentSchema
operationToContentSchema operation =
    case OpenApi.Operation.requestBody operation of
        Nothing ->
            CliMonad.succeed EmptyContent

        Just requestOrRef ->
            case OpenApi.Reference.toConcrete requestOrRef of
                Just request ->
                    OpenApi.RequestBody.content request
                        |> contentToContentSchema True

                Nothing ->
                    CliMonad.succeed requestOrRef
                        |> CliMonad.stepOrFail "I found a successful response, but I couldn't convert it to a concrete one"
                            OpenApi.Reference.toReference
                        |> CliMonad.map (\ref -> JsonContent (Common.Ref <| String.split "/" <| OpenApi.Reference.ref ref))


jsonRegex : Regex
jsonRegex =
    Regex.fromString "^application\\/(vnd\\.[a-z0-9]+(\\.v\\d+)?(\\.[a-z0-9]+)?)?\\+?json$"
        |> Maybe.withDefault Regex.never


searchForJsonMediaType : String -> a -> Bool
searchForJsonMediaType mediaType _ =
    Regex.contains jsonRegex mediaType


contentToContentSchema : Bool -> Dict.Dict String OpenApi.MediaType.MediaType -> CliMonad ContentSchema
contentToContentSchema qualify content =
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
                        |> CliMonad.andThen (SchemaUtils.schemaToType qualify)
                        |> CliMonad.map (\{ type_ } -> JsonContent type_)

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
                |> CliMonad.andThen (SchemaUtils.schemaToType True)
                |> CliMonad.andThen
                    (\{ type_ } ->
                        case type_ of
                            Common.Basic Common.String _ ->
                                CliMonad.succeed (StringContent mime)

                            _ ->
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
                        case schema.format of
                            Just "byte" ->
                                -- base64-encoded data
                                CliMonad.succeed (Base64Content singleKey)

                            Just "binary" ->
                                -- binary data
                                CliMonad.succeed (BytesContent singleKey)

                            _ ->
                                CliMonad.succeed (StringContent singleKey)

                    else
                        default (Just fallback)

                _ ->
                    default (Just fallback)

        _ ->
            default Nothing


toConfigParamAnnotation :
    { operation : OpenApi.Operation.Operation
    , successAnnotation : Elm.Annotation.Annotation
    , errorBodyAnnotation : Elm.Annotation.Annotation
    , errorTypeAnnotation : Elm.Annotation.Annotation
    , authorizationInfo : AuthorizationInfo
    , bodyParams : List ( Common.UnsafeName, Elm.Annotation.Annotation )
    , server : ServerInfo
    }
    -> CliMonad ({ requireToMsg : Bool } -> PerPackage Elm.Annotation.Annotation)
toConfigParamAnnotation options =
    CliMonad.map
        (\urlParams { requireToMsg } ->
            let
                toMsgCore : Elm.Annotation.Annotation
                toMsgCore =
                    Elm.Annotation.function
                        [ Elm.Annotation.result
                            (OpenApi.Common.Internal.annotation_.error options.errorTypeAnnotation options.errorBodyAnnotation)
                            options.successAnnotation
                        ]
                        (Elm.Annotation.var "msg")

                toMsgLamderaProgramTest : Elm.Annotation.Annotation
                toMsgLamderaProgramTest =
                    Elm.Annotation.function
                        [ Elm.Annotation.result
                            (OpenApi.Common.Internal.annotation_.error options.errorTypeAnnotation options.errorBodyAnnotation)
                            options.successAnnotation
                        ]
                        (Elm.Annotation.var "msg")

                toAnnotation : Elm.Annotation.Annotation -> Elm.Annotation.Annotation
                toAnnotation toMsg =
                    ((case options.server of
                        SingleServer _ ->
                            []

                        MultipleServers _ ->
                            [ ( Common.UnsafeName "server", Elm.Annotation.string ) ]
                     )
                        ++ options.authorizationInfo.params
                        ++ (if requireToMsg then
                                [ ( Common.UnsafeName "toMsg", toMsg ) ]

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
        (operationToUrlParams options.operation)


type ServerInfo
    = SingleServer String
    | MultipleServers (List { name : String, url : String, description : Maybe String })


serverInfo : OpenApi.Config.Server -> CliMonad ServerInfo
serverInfo server =
    CliMonad.fromApiSpec
        (\spec ->
            case server of
                OpenApi.Config.Single cliServer ->
                    SingleServer cliServer

                OpenApi.Config.Default ->
                    case OpenApi.servers spec of
                        [] ->
                            SingleServer ""

                        [ one ] ->
                            SingleServer (OpenApi.Server.url one)

                        servers ->
                            servers
                                |> List.indexedMap
                                    (\i value ->
                                        let
                                            description : Maybe String
                                            description =
                                                OpenApi.Server.description value

                                            name : String
                                            name =
                                                case description of
                                                    Nothing ->
                                                        "server" ++ String.fromInt i

                                                    Just d ->
                                                        d
                                        in
                                        { name = name
                                        , url = OpenApi.Server.url value
                                        , description = description
                                        }
                                    )
                                |> MultipleServers

                OpenApi.Config.Multiple servers ->
                    servers
                        |> Dict.toList
                        |> List.map
                            (\( name, url ) ->
                                { name = name
                                , url = url
                                , description = Nothing
                                }
                            )
                        |> MultipleServers
        )


operationToUrlParams : OpenApi.Operation.Operation -> CliMonad (List ( Common.UnsafeName, Elm.Annotation.Annotation ))
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
                        |> CliMonad.andThen (paramToAnnotation True)
                )
            |> CliMonad.map
                (\types -> [ ( Common.UnsafeName "params", SchemaUtils.recordType types ) ])


queryParameterToUrlBuilderArgument : Bool -> OpenApi.Parameter.Parameter -> CliMonad (List (Elm.Expression -> Elm.Expression))
queryParameterToUrlBuilderArgument qualify param =
    paramToType qualify param
        |> CliMonad.andThen
            (\( paramName, type_ ) ->
                let
                    paramToBuilder : InputToString -> Bool -> List ( Common.UnsafeName, Bool ) -> Elm.Expression -> Elm.Expression
                    paramToBuilder inputToString alwaysJust components config =
                        let
                            name : Elm.Expression
                            name =
                                components
                                    |> List.foldl
                                        (\( component, _ ) acc ->
                                            acc
                                                ++ "["
                                                ++ Common.unwrapUnsafe component
                                                ++ "]"
                                        )
                                        (Common.unwrapUnsafe paramName)
                                    |> Elm.string

                            value : Elm.Expression
                            value =
                                List.foldl
                                    (\( component, nullable ) ( acc, wasNullable ) ->
                                        ( if nullable then
                                            acc
                                                |> Gen.Maybe.andThen (Elm.get (Common.toValueName component))

                                          else if wasNullable then
                                            acc
                                                |> Gen.Maybe.map (Elm.get (Common.toValueName component))

                                          else
                                            acc
                                                |> Elm.get (Common.toValueName component)
                                        , wasNullable || nullable
                                        )
                                    )
                                    ( config
                                        |> Elm.get "params"
                                        |> Elm.get (Common.toValueName paramName)
                                    , False
                                    )
                                    components
                                    |> Tuple.first
                                    |> inputToStringToFunction inputToString

                            build : Elm.Expression -> Elm.Expression
                            build =
                                Gen.Url.Builder.call_.string name
                        in
                        if alwaysJust then
                            Gen.Maybe.make_.just (build value)

                        else
                            Gen.Maybe.map build value
                in
                case type_ of
                    Common.Nullable (Common.Object fields) ->
                        fields
                            |> CliMonad.combineMap
                                (\( fieldName, field ) ->
                                    paramToString qualify (Common.Nullable field.type_)
                                        |> CliMonad.map
                                            (\{ inputToString, alwaysJust } ->
                                                paramToBuilder inputToString alwaysJust [ ( fieldName, True ) ]
                                            )
                                        |> CliMonad.withPath (Common.UnsafeName "query params (object)")
                                )

                    Common.Object fields ->
                        fields
                            |> CliMonad.combineMap
                                (\( fieldName, field ) ->
                                    paramToString qualify field.type_
                                        |> CliMonad.map
                                            (\{ inputToString, alwaysJust } ->
                                                paramToBuilder inputToString alwaysJust [ ( fieldName, False ) ]
                                            )
                                        |> CliMonad.withPath (Common.UnsafeName "query params (object)")
                                )

                    _ ->
                        paramToString qualify type_
                            |> CliMonad.map
                                (\{ inputToString, alwaysJust } ->
                                    [ paramToBuilder inputToString alwaysJust []
                                    ]
                                )
                            |> CliMonad.withPath (Common.UnsafeName "query params")
            )


type InputToString
    = InputToString (Elm.Expression -> Elm.Expression)
    | Identity


paramToString :
    Bool
    -> Common.Type
    -> CliMonad { inputToString : InputToString, alwaysJust : Bool, isMaybe : Bool }
paramToString qualify type_ =
    let
        recursive :
            Common.Type
            -> Bool
            -> ({ inputToString : InputToString, alwaysJust : Bool, isMaybe : Bool } -> InputToString)
            -> CliMonad { inputToString : InputToString, alwaysJust : Bool, isMaybe : Bool }
        recursive p isMaybe f =
            paramToString qualify p
                |> CliMonad.map
                    (\{ inputToString, alwaysJust } ->
                        { inputToString =
                            f
                                { alwaysJust = alwaysJust
                                , inputToString = inputToString
                                , isMaybe = isMaybe
                                }
                        , alwaysJust = False
                        , isMaybe = isMaybe
                        }
                    )

        basicTypeToString : Common.BasicType -> InputToString
        basicTypeToString basicType =
            case basicType of
                Common.String ->
                    Identity

                Common.Integer ->
                    InputToString Gen.String.call_.fromInt

                Common.Number ->
                    InputToString Gen.String.call_.fromFloat

                Common.Boolean ->
                    InputToString
                        (\val ->
                            Elm.ifThen val
                                (Elm.string "true")
                                (Elm.string "false")
                        )
    in
    case type_ of
        Common.Basic basicType basic ->
            CliMonad.withFormat basicType
                basic.format
                (\{ toParamString } -> InputToString toParamString)
                (basicTypeToString basicType)
                |> CliMonad.map
                    (\inputToString ->
                        { inputToString = inputToString
                        , alwaysJust = True
                        , isMaybe = False
                        }
                    )

        Common.Nullable p ->
            recursive p True <|
                \{ inputToString, alwaysJust } ->
                    if alwaysJust then
                        case inputToString of
                            Identity ->
                                Identity

                            InputToString f ->
                                InputToString (\val -> Gen.Maybe.map f val)

                    else
                        InputToString
                            (\val ->
                                val
                                    |> Gen.Maybe.andThen (inputToStringToFunction inputToString)
                            )

        Common.List (Common.Basic basicType _) ->
            { inputToString =
                InputToString
                    (\val ->
                        Elm.ifThen (Gen.List.call_.isEmpty val)
                            Gen.Maybe.make_.nothing
                            ((case basicTypeToString basicType of
                                Identity ->
                                    val

                                InputToString f ->
                                    Gen.List.call_.map (Elm.functionReduced "arg" f) val
                             )
                                |> Gen.String.call_.join (Elm.string ",")
                                |> Gen.Maybe.make_.just
                            )
                    )
            , alwaysJust = False
            , isMaybe = False
            }
                |> CliMonad.succeed

        Common.List p ->
            recursive p False <|
                \{ inputToString, alwaysJust } ->
                    InputToString
                        (\val ->
                            Elm.ifThen (Gen.List.call_.isEmpty val)
                                Gen.Maybe.make_.nothing
                                ((if alwaysJust then
                                    case inputToString of
                                        Identity ->
                                            val

                                        InputToString f ->
                                            Gen.List.call_.map (Elm.functionReduced "unpack" f) val

                                  else
                                    Gen.List.call_.filterMap
                                        (Elm.functionReduced "unpack"
                                            (inputToStringToFunction inputToString)
                                        )
                                        val
                                 )
                                    |> Gen.String.call_.join (Elm.string ",")
                                    |> Gen.Maybe.make_.just
                                )
                        )

        Common.Ref ref ->
            --  These are mostly aliases
            SchemaUtils.getAlias ref
                |> CliMonad.andThen (SchemaUtils.schemaToType qualify)
                |> CliMonad.andThen (\param -> paramToString qualify param.type_)

        Common.OneOf name data ->
            CliMonad.map2
                (\valType branches ->
                    { inputToString =
                        InputToString (\val -> Elm.Case.custom val valType branches)
                    , alwaysJust = True
                    , isMaybe = False
                    }
                )
                (SchemaUtils.typeToAnnotationWithNullable qualify type_)
                (CliMonad.combineMap
                    (\alternative ->
                        CliMonad.andThen2
                            (\{ inputToString, alwaysJust } annotation ->
                                if not alwaysJust then
                                    CliMonad.fail "Nullable alternative"

                                else
                                    Elm.Case.branch
                                        (Elm.Arg.customType
                                            (SchemaUtils.toVariantName name alternative.name)
                                            identity
                                            |> Elm.Arg.item (Elm.Arg.varWith "alternative" annotation)
                                        )
                                        (inputToStringToFunction inputToString)
                                        |> CliMonad.succeed
                            )
                            (paramToString qualify alternative.type_)
                            (SchemaUtils.typeToAnnotationWithNullable qualify alternative.type_)
                    )
                    data
                )

        Common.Enum variants ->
            CliMonad.enumName variants
                |> CliMonad.andThen
                    (\maybeName ->
                        case maybeName of
                            Nothing ->
                                CliMonad.succeed { inputToString = Identity, alwaysJust = True, isMaybe = False }

                            Just name ->
                                CliMonad.map
                                    (\typesNamespace ->
                                        { inputToString =
                                            InputToString
                                                (\val ->
                                                    Elm.apply
                                                        (Elm.value
                                                            { importFrom = typesNamespace
                                                            , name = Common.toValueName name ++ "ToString"
                                                            , annotation = Nothing
                                                            }
                                                        )
                                                        [ val ]
                                                )
                                        , alwaysJust = True
                                        , isMaybe = False
                                        }
                                    )
                                    (CliMonad.moduleToNamespace Common.Types)
                    )

        _ ->
            SchemaUtils.typeToAnnotationWithNullable qualify type_
                |> CliMonad.andThen
                    (\annotation ->
                        let
                            msg : String
                            msg =
                                "Params of type \"" ++ Elm.Annotation.toString annotation ++ "\""
                        in
                        CliMonad.todoWithDefault
                            { inputToString = InputToString (\_ -> Gen.Debug.todo msg)
                            , alwaysJust = True
                            , isMaybe = False
                            }
                            msg
                    )


inputToStringToFunction : InputToString -> Elm.Expression -> Elm.Expression
inputToStringToFunction inputToString val =
    case inputToString of
        Identity ->
            val

        InputToString f ->
            f val


paramToAnnotation : Bool -> OpenApi.Parameter.Parameter -> CliMonad ( Common.UnsafeName, Elm.Annotation.Annotation )
paramToAnnotation qualify concreteParam =
    paramToType qualify concreteParam
        |> CliMonad.andThen
            (\( paramName, type_ ) ->
                SchemaUtils.typeToAnnotationWithMaybe qualify type_
                    |> CliMonad.map
                        (\annotation -> ( paramName, annotation ))
            )


paramToType : Bool -> OpenApi.Parameter.Parameter -> CliMonad ( Common.UnsafeName, Common.Type )
paramToType qualify concreteParam =
    let
        paramName : String
        paramName =
            OpenApi.Parameter.name concreteParam
    in
    CliMonad.succeed concreteParam
        |> CliMonad.stepOrFail ("Could not get schema for parameter " ++ paramName)
            (OpenApi.Parameter.schema >> Maybe.map OpenApi.Schema.get)
        |> CliMonad.andThen (SchemaUtils.schemaToType qualify)
        |> CliMonad.andThen
            (\{ type_ } ->
                case type_ of
                    Common.Ref ref ->
                        ref
                            |> SchemaUtils.getAlias
                            |> CliMonad.andThen (SchemaUtils.schemaToType qualify)
                            |> CliMonad.map
                                (\inner ->
                                    case inner.type_ of
                                        Common.Nullable _ ->
                                            -- If it's a ref to a nullable type, we don't want another layer of nullable
                                            inner.type_

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
        |> CliMonad.map (Tuple.pair (Common.UnsafeName paramName))


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
    , errorTypeDeclaration : Maybe { name : String, declaration : Elm.Declaration, group : String }
    , errorTypeAnnotation : Elm.Annotation.Annotation
    , expect : PerPackage (CliMonad (Elm.Expression -> Elm.Expression))
    , resolver :
        { core : Elm.Expression
        , lamderaProgramTest : Elm.Expression
        }
    }


operationToTypesExpectAndResolver :
    String
    -> OpenApi.Operation.Operation
    -> CliMonad OperationUtils
operationToTypesExpectAndResolver functionName operation =
    let
        responses : Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response)
        responses =
            OpenApi.Operation.responses operation

        expectJsonBetter : Elm.Expression -> Elm.Expression -> PerPackage (CliMonad (Elm.Expression -> Elm.Expression))
        expectJsonBetter errorDecoders successDecoder =
            { core =
                OpenApi.Common.Internal.elmHttpSubmodule.call.expectJsonCustom errorDecoders successDecoder
                    |> CliMonad.succeed
            , elmPages =
                always (Gen.BackendTask.Http.expectJson successDecoder)
                    |> CliMonad.succeed
            , lamderaProgramTest =
                OpenApi.Common.Internal.lamderaProgramTestSubmodule.call.expectJsonCustomEffect errorDecoders successDecoder
                    |> CliMonad.succeed
            }

        expectStringBetter : Elm.Expression -> PerPackage (CliMonad (Elm.Expression -> Elm.Expression))
        expectStringBetter errorDecoders =
            { core =
                OpenApi.Common.Internal.elmHttpSubmodule.call.expectStringCustom errorDecoders
                    |> CliMonad.succeed
            , elmPages =
                always Gen.BackendTask.Http.expectString
                    |> CliMonad.succeed
            , lamderaProgramTest =
                OpenApi.Common.Internal.lamderaProgramTestSubmodule.call.expectStringCustomEffect errorDecoders
                    |> CliMonad.succeed
            }

        expectBytesBetter : Elm.Expression -> PerPackage (CliMonad (Elm.Expression -> Elm.Expression))
        expectBytesBetter errorDecoders =
            { core =
                OpenApi.Common.Internal.elmHttpSubmodule.call.expectBytesCustom errorDecoders
                    |> CliMonad.succeed
            , elmPages =
                always (Gen.BackendTask.Http.expectBytes Gen.Bytes.Decode.values_.bytes)
                    |> CliMonad.succeed
            , lamderaProgramTest =
                OpenApi.Common.Internal.lamderaProgramTestSubmodule.call.expectBytesCustomEffect errorDecoders
                    |> CliMonad.succeed
            }

        expectBase64Better : Elm.Expression -> PerPackage (CliMonad (Elm.Expression -> Elm.Expression))
        expectBase64Better errorDecoders =
            { core =
                OpenApi.Common.Internal.elmHttpBase64Submodule.call.expectBase64Custom errorDecoders
                    |> CliMonad.succeed
            , elmPages = CliMonad.fail "Base64 not supported yet in `elm-pages`"
            , lamderaProgramTest =
                OpenApi.Common.Internal.lamderaProgramTestBase64Submodule.call.expectBase64CustomEffect errorDecoders
                    |> CliMonad.succeed
            }
    in
    CliMonad.succeed responses
        |> CliMonad.stepOrFail
            ("Among the "
                ++ String.fromInt (Dict.size responses)
                ++ " possible responses, there was no successful one."
            )
            getFirstSuccessResponse
        |> CliMonad.andThen
            (\( _, responseOrRef ) ->
                let
                    errorResponses : Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response)
                    errorResponses =
                        getErrorResponses responses

                    errorTypeDeclaration : CliMonad ( Maybe { name : String, declaration : Elm.Declaration, group : String }, Elm.Annotation.Annotation )
                    errorTypeDeclaration =
                        errorResponses
                            |> Dict.map
                                (\_ errResponseOrRef ->
                                    case OpenApi.Reference.toConcrete errResponseOrRef of
                                        Just errResponse ->
                                            OpenApi.Response.content errResponse
                                                |> contentToContentSchema True
                                                |> CliMonad.andThen
                                                    (\contentSchema ->
                                                        case contentSchema of
                                                            JsonContent type_ ->
                                                                CliMonad.map2 Tuple.pair
                                                                    (SchemaUtils.typeToAnnotationWithNullable False type_)
                                                                    (SchemaUtils.typeToAnnotationWithNullable True type_)

                                                            StringContent _ ->
                                                                CliMonad.succeed
                                                                    ( Elm.Annotation.string
                                                                    , Elm.Annotation.string
                                                                    )

                                                            BytesContent _ ->
                                                                CliMonad.succeed
                                                                    ( Gen.Bytes.annotation_.bytes
                                                                    , Gen.Bytes.annotation_.bytes
                                                                    )
                                                                    |> CliMonad.withRequiredPackage "elm/bytes"

                                                            EmptyContent ->
                                                                CliMonad.succeed
                                                                    ( Elm.Annotation.unit
                                                                    , Elm.Annotation.unit
                                                                    )

                                                            Base64Content _ ->
                                                                CliMonad.succeed
                                                                    ( Elm.Annotation.string
                                                                    , Elm.Annotation.string
                                                                    )
                                                    )

                                        Nothing ->
                                            CliMonad.succeed errResponseOrRef
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
                                                            |> CliMonad.map2
                                                                (\typesNamespace typeName ->
                                                                    ( Elm.Annotation.named [] (Common.toTypeName typeName)
                                                                    , Elm.Annotation.named typesNamespace (Common.toTypeName typeName)
                                                                    )
                                                                )
                                                                (CliMonad.moduleToNamespace Common.Types)
                                                    )
                                )
                            |> CliMonad.combineDict
                            |> CliMonad.map2
                                (\typesNamespace dict ->
                                    case Dict.toList dict of
                                        [] ->
                                            ( Nothing, Elm.Annotation.var "e" )

                                        [ ( _, ( _, globalAnnotation ) ) ] ->
                                            ( Nothing, globalAnnotation )

                                        errorList ->
                                            let
                                                errorName : String
                                                errorName =
                                                    String.Extra.toSentenceCase functionName ++ "_Error"
                                            in
                                            ( { name = errorName
                                              , declaration =
                                                    errorList
                                                        |> List.map (\( statusCode, ( localAnnotation, _ ) ) -> Elm.variantWith (toErrorVariant functionName statusCode) [ localAnnotation ])
                                                        |> Elm.customType errorName
                                                        |> Elm.exposeConstructor
                                              , group = "Errors"
                                              }
                                                |> Just
                                            , Elm.Annotation.named typesNamespace errorName
                                            )
                                )
                                (CliMonad.moduleToNamespace Common.Types)
                in
                CliMonad.andThen2
                    (\errorDecoders_ ( errorTypeDeclaration_, errorTypeAnnotation ) ->
                        case OpenApi.Reference.toConcrete responseOrRef of
                            Just response ->
                                CliMonad.andThen
                                    (\contentSchema ->
                                        case contentSchema of
                                            JsonContent type_ ->
                                                CliMonad.map
                                                    (\successDecoder ->
                                                        { successType = type_
                                                        , bodyTypeAnnotation = Elm.Annotation.string
                                                        , errorTypeDeclaration = errorTypeDeclaration_
                                                        , errorTypeAnnotation = errorTypeAnnotation
                                                        , expect = expectJsonBetter errorDecoders_ successDecoder
                                                        , resolver =
                                                            { core = OpenApi.Common.Internal.elmHttpSubmodule.call.jsonResolverCustom errorDecoders_ successDecoder
                                                            , lamderaProgramTest = OpenApi.Common.Internal.lamderaProgramTestSubmodule.call.jsonResolverCustomEffect errorDecoders_ successDecoder
                                                            }
                                                        }
                                                    )
                                                    (SchemaUtils.typeToDecoder True type_)

                                            StringContent _ ->
                                                { successType =
                                                    Common.Basic Common.String
                                                        { const = Nothing
                                                        , format = Nothing
                                                        }
                                                , bodyTypeAnnotation = Elm.Annotation.string
                                                , errorTypeDeclaration = errorTypeDeclaration_
                                                , errorTypeAnnotation = errorTypeAnnotation
                                                , expect = expectStringBetter errorDecoders_
                                                , resolver =
                                                    { core = OpenApi.Common.Internal.elmHttpSubmodule.call.stringResolverCustom errorDecoders_
                                                    , lamderaProgramTest = OpenApi.Common.Internal.lamderaProgramTestSubmodule.call.stringResolverCustomEffect errorDecoders_
                                                    }
                                                }
                                                    |> CliMonad.succeed

                                            BytesContent _ ->
                                                { successType = Common.Bytes
                                                , bodyTypeAnnotation = Gen.Bytes.annotation_.bytes
                                                , errorTypeDeclaration = errorTypeDeclaration_
                                                , errorTypeAnnotation = errorTypeAnnotation
                                                , expect = expectBytesBetter errorDecoders_
                                                , resolver =
                                                    { core = OpenApi.Common.Internal.elmHttpSubmodule.call.bytesResolverCustom errorDecoders_
                                                    , lamderaProgramTest = OpenApi.Common.Internal.lamderaProgramTestSubmodule.call.bytesResolverCustomEffect errorDecoders_
                                                    }
                                                }
                                                    |> CliMonad.succeed
                                                    |> CliMonad.withRequiredPackage "elm/bytes"

                                            Base64Content _ ->
                                                { successType = Common.Bytes
                                                , bodyTypeAnnotation = Elm.Annotation.string
                                                , errorTypeDeclaration = errorTypeDeclaration_
                                                , errorTypeAnnotation = errorTypeAnnotation
                                                , expect = expectBase64Better errorDecoders_
                                                , resolver =
                                                    { core = OpenApi.Common.Internal.elmHttpBase64Submodule.call.base64ResolverCustom errorDecoders_
                                                    , lamderaProgramTest = OpenApi.Common.Internal.lamderaProgramTestBase64Submodule.call.base64ResolverCustomEffect errorDecoders_
                                                    }
                                                }
                                                    |> CliMonad.succeed
                                                    |> CliMonad.withRequiredPackage "elm/bytes"
                                                    |> CliMonad.withRequiredPackage Common.base64PackageName

                                            EmptyContent ->
                                                { successType = Common.Unit
                                                , bodyTypeAnnotation = Elm.Annotation.string
                                                , errorTypeDeclaration = errorTypeDeclaration_
                                                , errorTypeAnnotation = errorTypeAnnotation
                                                , expect = expectJsonBetter errorDecoders_ (Gen.Json.Decode.succeed Elm.unit)
                                                , resolver =
                                                    { core = OpenApi.Common.Internal.elmHttpSubmodule.call.jsonResolverCustom errorDecoders_ (Gen.Json.Decode.succeed Elm.unit)
                                                    , lamderaProgramTest = OpenApi.Common.Internal.lamderaProgramTestSubmodule.call.jsonResolverCustomEffect errorDecoders_ (Gen.Json.Decode.succeed Elm.unit)
                                                    }
                                                }
                                                    |> CliMonad.succeed
                                    )
                                    (OpenApi.Response.content response
                                        |> contentToContentSchema True
                                    )

                            Nothing ->
                                CliMonad.succeed responseOrRef
                                    |> CliMonad.stepOrFail "I found a successful response, but I couldn't convert it to a concrete one"
                                        OpenApi.Reference.toReference
                                    |> CliMonad.andThen
                                        (\ref ->
                                            let
                                                inner : String
                                                inner =
                                                    OpenApi.Reference.ref ref
                                            in
                                            CliMonad.map2
                                                (\jsonNamespace typeName ->
                                                    let
                                                        decoder : Elm.Expression
                                                        decoder =
                                                            Elm.value
                                                                { importFrom = jsonNamespace
                                                                , name = "decode" ++ Common.toTypeName typeName
                                                                , annotation = Nothing
                                                                }
                                                    in
                                                    { successType = Common.ref inner
                                                    , bodyTypeAnnotation = Elm.Annotation.string
                                                    , errorTypeDeclaration = errorTypeDeclaration_
                                                    , errorTypeAnnotation = errorTypeAnnotation
                                                    , expect = expectJsonBetter errorDecoders_ decoder
                                                    , resolver =
                                                        { core = OpenApi.Common.Internal.elmHttpSubmodule.call.jsonResolverCustom errorDecoders_ decoder
                                                        , lamderaProgramTest = OpenApi.Common.Internal.lamderaProgramTestSubmodule.call.jsonResolverCustomEffect errorDecoders_ decoder
                                                        }
                                                    }
                                                )
                                                (CliMonad.moduleToNamespace Common.Json)
                                                (SchemaUtils.refToTypeName (String.split "/" inner))
                                        )
                    )
                    (errorResponsesToErrorDecoders functionName errorResponses)
                    errorTypeDeclaration
            )


errorResponsesToErrorDecoders : String -> Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response) -> CliMonad Elm.Expression
errorResponsesToErrorDecoders functionName errorResponses =
    case Dict.toList errorResponses of
        [] ->
            Elm.list []
                |> Gen.Dict.call_.fromList
                |> CliMonad.succeed

        errorList ->
            let
                single : Bool
                single =
                    case errorList of
                        [ _ ] ->
                            True

                        _ ->
                            False
            in
            CliMonad.moduleToNamespace Common.Types
                |> CliMonad.andThen
                    (\typesNamespace ->
                        errorList
                            |> CliMonad.combineMap
                                (\( statusCode, errResponseOrRef ) ->
                                    let
                                        decoder : CliMonad Elm.Expression
                                        decoder =
                                            case OpenApi.Reference.toConcrete errResponseOrRef of
                                                Just errResponse ->
                                                    OpenApi.Response.content errResponse
                                                        |> contentToContentSchema True
                                                        |> CliMonad.andThen
                                                            (\contentSchema ->
                                                                case contentSchema of
                                                                    JsonContent type_ ->
                                                                        SchemaUtils.typeToDecoder True type_

                                                                    StringContent _ ->
                                                                        CliMonad.succeed Gen.Json.Decode.string

                                                                    BytesContent _ ->
                                                                        CliMonad.todo "Bytes errors are not supported yet"

                                                                    Base64Content _ ->
                                                                        CliMonad.todo "Base 64 errors are not supported yet"

                                                                    EmptyContent ->
                                                                        CliMonad.succeed (Gen.Json.Decode.succeed Elm.unit)
                                                            )

                                                Nothing ->
                                                    CliMonad.succeed errResponseOrRef
                                                        |> CliMonad.stepOrFail "I found an error response, but I couldn't convert it to a concrete decoder"
                                                            OpenApi.Reference.toReference
                                                        |> CliMonad.andThen
                                                            (\ref ->
                                                                let
                                                                    inner : String
                                                                    inner =
                                                                        OpenApi.Reference.ref ref
                                                                in
                                                                CliMonad.map2
                                                                    (\jsonNamespace typeName ->
                                                                        Elm.value
                                                                            { importFrom = jsonNamespace
                                                                            , name = "decode" ++ Common.toTypeName typeName
                                                                            , annotation = Nothing
                                                                            }
                                                                    )
                                                                    (CliMonad.moduleToNamespace Common.Json)
                                                                    (SchemaUtils.refToTypeName (String.split "/" inner))
                                                            )
                                    in
                                    decoder
                                        |> CliMonad.map
                                            (\decoder_ ->
                                                Elm.tuple
                                                    (Elm.string statusCode)
                                                    (if single then
                                                        decoder_

                                                     else
                                                        Gen.Json.Decode.call_.map
                                                            (Elm.value
                                                                { importFrom = typesNamespace
                                                                , name = toErrorVariant functionName statusCode
                                                                , annotation = Nothing
                                                                }
                                                            )
                                                            decoder_
                                                    )
                                            )
                                )
                    )
                |> CliMonad.map
                    (\decoders ->
                        decoders
                            |> Elm.list
                            |> Gen.Dict.call_.fromList
                    )


toErrorVariant : String -> String -> String
toErrorVariant functionName statusCode =
    String.Extra.toSentenceCase functionName ++ "_" ++ statusCode


isSuccessResponseStatus : String -> Bool
isSuccessResponseStatus status =
    String.startsWith "2" status || String.startsWith "3" status


getFirstSuccessResponse : Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response) -> Maybe ( String, OpenApi.Reference.ReferenceOr OpenApi.Response.Response )
getFirstSuccessResponse responses =
    responses
        |> Dict.Extra.find (\code _ -> isSuccessResponseStatus code)


getErrorResponses : Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response) -> Dict.Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response)
getErrorResponses responses =
    responses
        |> Dict.filter (\status _ -> not <| isSuccessResponseStatus status)


responseToSchema : OpenApi.Response.Response -> CliMonad Json.Schema.Definitions.Schema
responseToSchema response =
    CliMonad.succeed response
        |> CliMonad.stepOrFail "The response does not have a json content"
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
        |> CliMonad.stepOrFail "The request does not have a json content"
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
