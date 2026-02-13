module OpenApi.Generate exposing (ContentSchema, Message, Path, Mime, files)

{-|

@docs ContentSchema, Message, Path, Mime, files

-}

import CliMonad exposing (CliMonad)
import Common
import Dict exposing (Dict)
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
import NonEmpty
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
import Pretty
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
    , details : Pretty.Doc ()
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
    | MultipartContent (List { name : Common.UnsafeName, required : Bool, part : MultipartPart })


{-| -}
type MultipartPart
    = JsonPart Common.Type
    | StringPart
    | BytesPart


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
files :
    OpenApi.Config.Generate
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
files { namespace, generateTodos, effectTypes, server, formats, warnOnMissingEnums, keepGoing } apiSpec =
    case extractEnums apiSpec of
        Err e ->
            Err e

        Ok enums ->
            serverInfo server
                |> CliMonad.andThen
                    (\info ->
                        [ pathDeclarations effectTypes info
                        , schemasDeclarations
                        , responsesDeclarations
                        , requestBodiesDeclarations
                        , serverDeclarations info
                            |> CliMonad.succeed
                            |> CliMonad.withPath (Common.UnsafeName "servers")
                        ]
                            |> CliMonad.combine
                    )
                |> CliMonad.map List.concat
                |> CliMonad.withPath (Common.UnsafeName (String.join "." namespace))
                |> CliMonad.run
                    SchemaUtils.oneOfDeclarations
                    { openApi = apiSpec
                    , generateTodos = generateTodos
                    , enums = enums
                    , namespace = namespace
                    , formats = formats
                    , warnOnMissingEnums = warnOnMissingEnums
                    , keepGoing = keepGoing
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
                                                    (List.sort (NonEmpty.toList decodedEnums))
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
                                            , details = Pretty.empty
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
                        let
                            safeName : String
                            safeName =
                                Common.toValueName name
                        in
                        { moduleName = Common.Servers
                        , name = safeName
                        , declaration =
                            url
                                |> stripTrailingSlash
                                |> Elm.string
                                |> Elm.declaration safeName
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


pathDeclarations : List OpenApi.Config.EffectType -> ServerInfo -> CliMonad (List CliMonad.Declaration)
pathDeclarations effectTypes server =
    CliMonad.getApiSpec
        |> CliMonad.andThen
            (\spec ->
                spec
                    |> OpenApi.paths
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
                    |> CliMonad.withPath (Common.UnsafeName "paths")
            )


responsesDeclarations : CliMonad (List CliMonad.Declaration)
responsesDeclarations =
    CliMonad.getApiSpec
        |> CliMonad.andThen
            (\spec ->
                spec
                    |> OpenApi.components
                    |> Maybe.map OpenApi.Components.responses
                    |> Maybe.withDefault Dict.empty
                    |> Dict.foldl
                        (\name schema ->
                            CliMonad.map2 (::)
                                (responseToDeclarations (Common.UnsafeName name) schema)
                        )
                        (CliMonad.succeed [])
                    |> CliMonad.map List.concat
                    |> CliMonad.withPath (Common.UnsafeName "responses")
            )


requestBodiesDeclarations : CliMonad (List CliMonad.Declaration)
requestBodiesDeclarations =
    CliMonad.getApiSpec
        |> CliMonad.andThen
            (\spec ->
                spec
                    |> OpenApi.components
                    |> Maybe.map OpenApi.Components.requestBodies
                    |> Maybe.withDefault Dict.empty
                    |> Dict.foldl
                        (\name schema ->
                            CliMonad.map2 (::)
                                (requestBodyToDeclarations (Common.UnsafeName name) schema)
                        )
                        (CliMonad.succeed [])
                    |> CliMonad.map List.concat
                    |> CliMonad.withPath (Common.UnsafeName "requestBodies")
            )


schemasDeclarations : CliMonad (List CliMonad.Declaration)
schemasDeclarations =
    CliMonad.getApiSpec
        |> CliMonad.andThen
            (\spec ->
                spec
                    |> OpenApi.components
                    |> Maybe.map OpenApi.Components.schemas
                    |> Maybe.withDefault Dict.empty
                    |> Dict.foldl
                        (\name schema ->
                            CliMonad.map2
                                (\decls declAcc -> decls ++ declAcc)
                                (JsonSchema.Generate.schemaToDeclarations Common.Schema
                                    (Common.UnsafeName name)
                                    (OpenApi.Schema.get schema)
                                )
                        )
                        (CliMonad.succeed [])
                    |> CliMonad.withPath (Common.UnsafeName "schemas")
            )


unitDeclarations : Common.Component -> Common.UnsafeName -> CliMonad (List CliMonad.Declaration)
unitDeclarations component name =
    let
        typeName : Common.TypeName
        typeName =
            Common.toTypeName name
    in
    CliMonad.combine
        [ { moduleName = Common.Types component
          , name = typeName
          , declaration =
                Elm.alias typeName Elm.Annotation.unit
                    |> Elm.expose
          , group = "Aliases"
          }
            |> CliMonad.succeed
        , CliMonad.map2
            (\importFrom schemaDecoder ->
                { moduleName = Common.Json component
                , name = "decode" ++ typeName
                , declaration =
                    Elm.declaration ("decode" ++ typeName)
                        (schemaDecoder
                            |> Elm.withType (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.named importFrom typeName))
                        )
                        |> Elm.exposeConstructor
                , group = "Decoders"
                }
            )
            (CliMonad.moduleToNamespace (Common.Types component))
            (SchemaUtils.typeToDecoder Common.Unit)
        , CliMonad.map2
            (\importFrom encoder ->
                { moduleName = Common.Json component
                , name = "encode" ++ typeName
                , declaration =
                    Elm.declaration ("encode" ++ typeName)
                        (Elm.functionReduced "rec" encoder
                            |> Elm.withType (Elm.Annotation.function [ Elm.Annotation.named importFrom typeName ] Gen.Json.Encode.annotation_.value)
                        )
                        |> Elm.expose
                , group = "Encoders"
                }
            )
            (CliMonad.moduleToNamespace (Common.Types component))
            (SchemaUtils.typeToEncoder Common.Unit)
        ]


responseToDeclarations : Common.UnsafeName -> OpenApi.Reference.ReferenceOr OpenApi.Response.Response -> CliMonad (List CliMonad.Declaration)
responseToDeclarations name reference =
    case OpenApi.Reference.toConcrete reference of
        Just response ->
            let
                content : Dict String OpenApi.MediaType.MediaType
                content =
                    OpenApi.Response.content response
            in
            if Dict.isEmpty content then
                -- If there is no input content then we go with the unit value, `()` as the response type
                unitDeclarations Common.Response name

            else
                responseToSchema response
                    |> CliMonad.withPath name
                    |> CliMonad.andThen (JsonSchema.Generate.schemaToDeclarations Common.Response name)

        Nothing ->
            CliMonad.fail "Could not convert reference to concrete value"
                |> CliMonad.withPath name


requestBodyToDeclarations : Common.UnsafeName -> OpenApi.Reference.ReferenceOr OpenApi.RequestBody.RequestBody -> CliMonad (List CliMonad.Declaration)
requestBodyToDeclarations name reference =
    case OpenApi.Reference.toConcrete reference of
        Just requestBody ->
            let
                content : Dict String OpenApi.MediaType.MediaType
                content =
                    OpenApi.RequestBody.content requestBody
            in
            if Dict.isEmpty content then
                -- If there is no content then we go with the unit value, `()` as the requestBody type
                unitDeclarations Common.RequestBody name

            else
                case searchForJsonMediaType content of
                    Just jsonBody ->
                        CliMonad.succeed jsonBody
                            |> CliMonad.stepOrFail
                                "The request body's json content option doesn't have a schema"
                                OpenApi.MediaType.schema
                            |> CliMonad.map OpenApi.Schema.get
                            |> CliMonad.withPath name
                            |> CliMonad.andThen (JsonSchema.Generate.schemaToDeclarations Common.RequestBody name)

                    Nothing ->
                        case Dict.get "multipart/form-data" content of
                            Nothing ->
                                CliMonad.fail "The request body contains neither a json nor a multipart/form-data content"

                            Just formData ->
                                CliMonad.succeed formData
                                    |> CliMonad.stepOrFail
                                        "The request body's multipart/form-data content option doesn't have a schema"
                                        OpenApi.MediaType.schema
                                    |> CliMonad.map OpenApi.Schema.get
                                    |> CliMonad.withPath name
                                    |> CliMonad.andThen (JsonSchema.Generate.multipartFormDataRequestBodyToDeclarations name)

        Nothing ->
            CliMonad.fail "Could not convert reference to concrete value"
                |> CliMonad.withPath name


toRequestFunctions : ServerInfo -> List OpenApi.Config.EffectType -> String -> String -> OpenApi.Operation.Operation -> CliMonad (List CliMonad.Declaration)
toRequestFunctions server effectTypes method pathUrl operation =
    let
        step : OperationUtils -> CliMonad (List CliMonad.Declaration)
        step ({ successType, bodyTypeAnnotation, errorTypeDeclaration, errorTypeAnnotation } as operationUtils) =
            CliMonad.andThen4
                (\contentSchema auth toHeaderParams successAnnotation ->
                    CliMonad.andThen2
                        (\configAnnotation replaced ->
                            CliMonad.map2 (++)
                                ([ elmHttpCommands, elmHttpTasks, dillonkearnsElmPagesBackendTask, lamderaProgramTestCommands, lamderaProgramTestTasks ]
                                    |> CliMonad.combineMap
                                        (\toDecls ->
                                            toDecls operationUtils auth toHeaderParams successAnnotation (contentSchemaToBodyBuilder contentSchema) replaced configAnnotation
                                        )
                                    |> CliMonad.map List.concat
                                )
                                (case errorTypeDeclaration of
                                    Just { name, declaration, group } ->
                                        [ { moduleName = Common.Types Common.Response
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
                        (contentSchemaToBodyParams contentSchema
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
                )
                (operationToContentSchema operation)
                (operationToAuthorizationInfo operation)
                (operationToHeaderParams operation)
                (case successType of
                    SuccessType t ->
                        SchemaUtils.typeToAnnotationWithNullable t

                    SuccessReference ref ->
                        CliMonad.refToAnnotation ref
                )
    in
    operationToTypesExpectAndResolver effectTypes method pathUrl operation
        |> CliMonad.andThen step
        |> CliMonad.withPath (Common.UnsafeName method)
        |> CliMonad.withPath (Common.UnsafeName pathUrl)


contentSchemaToBodyBuilder :
    ContentSchema
    -> PerPackage (CliMonad (Elm.Expression -> Elm.Expression))
contentSchemaToBodyBuilder bodyContent =
    case bodyContent of
        EmptyContent ->
            { core = CliMonad.succeed (\_ -> Gen.Http.emptyBody)
            , elmPages = CliMonad.succeed (\_ -> Gen.BackendTask.Http.emptyBody)
            , lamderaProgramTest = CliMonad.succeed (\_ -> Gen.Effect.Http.emptyBody)
            }

        JsonContent type_ ->
            let
                encoded : (Elm.Expression -> Elm.Expression) -> CliMonad (Elm.Expression -> Elm.Expression)
                encoded f =
                    SchemaUtils.typeToEncoder type_
                        |> CliMonad.map
                            (\encoder config ->
                                f (encoder <| Elm.get "body" config)
                            )
            in
            { core = encoded Gen.Http.jsonBody
            , elmPages = encoded Gen.BackendTask.Http.jsonBody
            , lamderaProgramTest = encoded Gen.Effect.Http.jsonBody
            }

        StringContent mime ->
            let
                toBody : (Elm.Expression -> Elm.Expression -> a) -> CliMonad (Elm.Expression -> a)
                toBody f =
                    CliMonad.succeed <| \config -> f (Elm.string mime) (Elm.get "body" config)
            in
            { core = toBody Gen.Http.call_.stringBody
            , elmPages = toBody Gen.BackendTask.Http.call_.stringBody
            , lamderaProgramTest = toBody Gen.Effect.Http.call_.stringBody
            }

        BytesContent mime ->
            let
                toBody : (Mime -> Elm.Expression -> Elm.Expression) -> CliMonad (Elm.Expression -> Elm.Expression)
                toBody f =
                    CliMonad.succeed <| \config -> f mime (Elm.get "body" config)
            in
            { core = toBody Gen.Http.bytesBody
            , elmPages = toBody Gen.BackendTask.Http.bytesBody
            , lamderaProgramTest = toBody Gen.Effect.Http.bytesBody
            }

        Base64Content mime ->
            let
                toBody : (Elm.Expression -> Elm.Expression -> Elm.Expression) -> CliMonad (Elm.Expression -> Elm.Expression)
                toBody f =
                    CliMonad.succeed <|
                        \config ->
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

        MultipartContent parts ->
            let
                coreUtils :
                    { stringPart : Elm.Expression -> Elm.Expression -> Elm.Expression
                    , bytesPart : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
                    , multipartBody : List Elm.Expression -> Elm.Expression
                    }
                coreUtils =
                    { stringPart = Gen.Http.call_.stringPart
                    , bytesPart = Gen.Http.call_.bytesPart
                    , multipartBody = Gen.Http.multipartBody
                    }

                lamderaProgramTestUtils :
                    { stringPart : Elm.Expression -> Elm.Expression -> Elm.Expression
                    , bytesPart : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
                    , multipartBody : List Elm.Expression -> Elm.Expression
                    }
                lamderaProgramTestUtils =
                    { stringPart = Gen.Effect.Http.call_.stringPart
                    , bytesPart = Gen.Effect.Http.call_.bytesPart
                    , multipartBody = Gen.Effect.Http.multipartBody
                    }
            in
            let
                toBody :
                    { stringPart : Elm.Expression -> Elm.Expression -> Elm.Expression
                    , bytesPart : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
                    , multipartBody : List Elm.Expression -> Elm.Expression
                    }
                    -> CliMonad (Elm.Expression -> Elm.Expression)
                toBody utils =
                    parts
                        |> CliMonad.combineMap
                            (\part ->
                                let
                                    build : CliMonad (Elm.Expression -> Elm.Expression)
                                    build =
                                        case part.part of
                                            JsonPart partType ->
                                                SchemaUtils.typeToEncoder partType
                                                    |> CliMonad.map
                                                        (\encoder field ->
                                                            field
                                                                |> encoder
                                                                |> Gen.Json.Encode.call_.encode
                                                                    (Elm.int 0)
                                                                |> utils.stringPart
                                                                    (Elm.string (Common.toValueName part.name))
                                                        )

                                            StringPart ->
                                                CliMonad.succeed
                                                    (\field ->
                                                        utils.stringPart
                                                            (Elm.string (Common.toValueName part.name))
                                                            field
                                                    )

                                            BytesPart ->
                                                CliMonad.succeed
                                                    (\field ->
                                                        utils.bytesPart
                                                            (Elm.string (Common.toValueName part.name))
                                                            (Elm.string "application/octet-stream")
                                                            field
                                                    )
                                in
                                build
                                    |> CliMonad.map
                                        (\partMaker config ->
                                            config
                                                |> Elm.get "body"
                                                |> Elm.get (Common.toValueName part.name)
                                                |> partMaker
                                        )
                            )
                        |> CliMonad.map
                            (\fs config ->
                                utils.multipartBody (List.map (\x -> x config) fs)
                            )
            in
            { core = toBody coreUtils
            , elmPages = CliMonad.fail "dillonkearns/elm-pages does not support multipart bodies"
            , lamderaProgramTest = toBody lamderaProgramTestUtils
            }


contentSchemaToBodyParams : ContentSchema -> CliMonad (List ( Common.UnsafeName, Elm.Annotation.Annotation ))
contentSchemaToBodyParams contentSchema =
    let
        annotation : CliMonad (Maybe Elm.Annotation.Annotation)
        annotation =
            case contentSchema of
                EmptyContent ->
                    CliMonad.succeed Nothing

                JsonContent type_ ->
                    SchemaUtils.typeToAnnotationWithNullable type_
                        |> CliMonad.map Just

                StringContent _ ->
                    CliMonad.succeed (Just Elm.Annotation.string)

                BytesContent _ ->
                    CliMonad.succeed (Just Gen.Bytes.annotation_.bytes)
                        |> CliMonad.withRequiredPackage "elm/bytes"

                Base64Content _ ->
                    CliMonad.succeed (Just Gen.Bytes.annotation_.bytes)
                        |> CliMonad.withRequiredPackage "elm/bytes"
                        |> CliMonad.withRequiredPackage Common.base64PackageName

                MultipartContent parts ->
                    multipartPartsToAnnotation parts
                        |> CliMonad.map Just
    in
    annotation
        |> CliMonad.map
            (\maybeAnnotation ->
                case maybeAnnotation of
                    Nothing ->
                        []

                    Just ann ->
                        [ ( Common.UnsafeName "body", ann ) ]
            )


headersFromList :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> AuthorizationInfo
    -> Elm.Expression
    -> List (Elm.Expression -> ( Elm.Expression, Elm.Expression, Bool ))
    -> Elm.Expression
headersFromList headerBuilder auth config headerFunctions =
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
                        Elm.just (headerBuilder k v)

                    else
                        headerBuilder k v
                )
                (auth.headers config)

        paramHeaders : List Elm.Expression
        paramHeaders =
            List.map
                (\( k, v, isMaybe ) ->
                    if isMaybe then
                        Gen.Maybe.map (headerBuilder k) v

                    else if hasMaybes then
                        Elm.just (headerBuilder k v)

                    else
                        headerBuilder k v
                )
                headerParams

        allHeaders : List Elm.Expression
        allHeaders =
            authHeaders ++ paramHeaders
    in
    if hasMaybes then
        allHeaders
            |> Elm.list
            |> Gen.List.call_.filterMap Gen.Basics.values_.identity

    else
        Elm.list allHeaders


documentation : OpenApi.Operation.Operation -> AuthorizationInfo -> String
documentation operation { scopes } =
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


declarationGroup :
    OperationUtils
    -> (PerPackage (CliMonad (Elm.Expression -> Elm.Expression)) -> CliMonad (Elm.Expression -> Elm.Expression))
    -> AuthorizationInfo
    -> PerPackage (CliMonad (Elm.Expression -> Elm.Expression))
    -> ((Elm.Expression -> Elm.Expression) -> (Elm.Expression -> Elm.Expression) -> a)
    -> List ( OpenApi.Config.EffectType, a -> ( String, Elm.Expression ) )
    -> CliMonad (List CliMonad.Declaration)
declarationGroup { expect, isSinglePackage, effectTypes, operation } package auth toBodies sharedData list =
    if List.any (\( effectType, _ ) -> List.member effectType effectTypes) list then
        CliMonad.map2
            (\specificExpect toBody ->
                let
                    shared : a
                    shared =
                        sharedData specificExpect toBody
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
                                    |> Elm.withDocumentation (documentation operation auth)
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
            (package expect)
            (package toBodies)

    else
        CliMonad.succeed []


elmHttpCommands :
    OperationUtils
    -> AuthorizationInfo
    -> List (Elm.Expression -> ( Elm.Expression, Elm.Expression, Bool ))
    -> Elm.Annotation.Annotation
    -> PerPackage (CliMonad (Elm.Expression -> Elm.Expression))
    -> (Elm.Expression -> Elm.Expression)
    -> ({ requireToMsg : Bool } -> PerPackage Elm.Annotation.Annotation)
    -> CliMonad (List CliMonad.Declaration)
elmHttpCommands ({ functionName, method, toMsg } as operationUtils) auth toHeaderParams _ toBodies replaced paramType =
    declarationGroup operationUtils
        .core
        auth
        toBodies
        (\specificExpect toBody ->
            { cmdArg =
                \config ->
                    Elm.record
                        [ ( "url", replaced config )
                        , ( "method", Elm.string method )
                        , ( "headers"
                          , headersFromList Gen.Http.call_.header auth config toHeaderParams
                          )
                        , ( "expect", specificExpect <| toMsg config )
                        , ( "body", toBody config )
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
                        , ( "body", Gen.Http.annotation_.body )
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
    OperationUtils
    -> AuthorizationInfo
    -> List (Elm.Expression -> ( Elm.Expression, Elm.Expression, Bool ))
    -> Elm.Annotation.Annotation
    -> PerPackage (CliMonad (Elm.Expression -> Elm.Expression))
    -> (Elm.Expression -> Elm.Expression)
    -> ({ requireToMsg : Bool } -> PerPackage Elm.Annotation.Annotation)
    -> CliMonad (List CliMonad.Declaration)
elmHttpTasks ({ functionName, method, bodyTypeAnnotation, errorTypeAnnotation, resolver } as operationUtils) auth toHeaderParams successAnnotation toBodies replaced paramType =
    declarationGroup operationUtils
        .core
        auth
        toBodies
        (\_ toBody ->
            { taskArg =
                \config ->
                    Elm.record
                        [ ( "url", replaced config )
                        , ( "method", Elm.string method )
                        , ( "headers"
                          , headersFromList Gen.Http.call_.header auth config toHeaderParams
                          )
                        , ( "resolver", resolver.core )
                        , ( "body", toBody config )
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
    OperationUtils
    -> AuthorizationInfo
    -> List (Elm.Expression -> ( Elm.Expression, Elm.Expression, Bool ))
    -> Elm.Annotation.Annotation
    -> PerPackage (CliMonad (Elm.Expression -> Elm.Expression))
    -> (Elm.Expression -> Elm.Expression)
    -> ({ requireToMsg : Bool } -> PerPackage Elm.Annotation.Annotation)
    -> CliMonad (List CliMonad.Declaration)
dillonkearnsElmPagesBackendTask ({ toMsg, method, functionName } as operationUtils) auth toHeaderParams successAnnotation toBodies replaced paramType =
    declarationGroup operationUtils
        .elmPages
        auth
        toBodies
        (\specificExpect toBody ->
            { taskArg =
                \config ->
                    Elm.record
                        [ ( "url", replaced config )
                        , ( "method", Elm.string method )
                        , ( "headers"
                          , headersFromList Elm.tuple auth config toHeaderParams
                          )
                        , ( "body", toBody config )
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
    OperationUtils
    -> AuthorizationInfo
    -> List (Elm.Expression -> ( Elm.Expression, Elm.Expression, Bool ))
    -> Elm.Annotation.Annotation
    -> PerPackage (CliMonad (Elm.Expression -> Elm.Expression))
    -> (Elm.Expression -> Elm.Expression)
    -> ({ requireToMsg : Bool } -> PerPackage Elm.Annotation.Annotation)
    -> CliMonad (List CliMonad.Declaration)
lamderaProgramTestCommands ({ toMsg, method, functionName } as operationUtils) auth toHeaderParams _ toBodies replaced paramType =
    declarationGroup operationUtils
        .lamderaProgramTest
        auth
        toBodies
        (\specificExpect toBody ->
            { cmdArg =
                \config ->
                    Elm.record
                        [ ( "url", replaced config )
                        , ( "method", Elm.string method )
                        , ( "headers"
                          , headersFromList Gen.Effect.Http.call_.header auth config toHeaderParams
                          )
                        , ( "expect", specificExpect <| toMsg config )
                        , ( "body", toBody config )
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
    OperationUtils
    -> AuthorizationInfo
    -> List (Elm.Expression -> ( Elm.Expression, Elm.Expression, Bool ))
    -> Elm.Annotation.Annotation
    -> PerPackage (CliMonad (Elm.Expression -> Elm.Expression))
    -> (Elm.Expression -> Elm.Expression)
    -> ({ requireToMsg : Bool } -> PerPackage Elm.Annotation.Annotation)
    -> CliMonad (List CliMonad.Declaration)
lamderaProgramTestTasks ({ method, functionName, resolver, errorTypeAnnotation, bodyTypeAnnotation } as operationUtils) auth toHeaderParams successAnnotation toBodies replaced paramType =
    declarationGroup operationUtils
        .lamderaProgramTest
        auth
        toBodies
        (\_ toBody ->
            { taskArg =
                \config ->
                    Elm.record
                        [ ( "url", replaced config )
                        , ( "method", Elm.string method )
                        , ( "headers"
                          , headersFromList Gen.Effect.Http.call_.header auth config toHeaderParams
                          )
                        , ( "resolver", resolver.lamderaProgramTest )
                        , ( "body", toBody config )
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


multipartPartsToAnnotation : List { name : Common.UnsafeName, required : Bool, part : MultipartPart } -> CliMonad Elm.Annotation.Annotation
multipartPartsToAnnotation parts =
    parts
        |> CliMonad.combineMap
            (\{ name, required, part } ->
                let
                    partAnnotation : CliMonad Elm.Annotation.Annotation
                    partAnnotation =
                        case part of
                            JsonPart type_ ->
                                SchemaUtils.typeToAnnotationWithNullable type_

                            StringPart ->
                                CliMonad.succeed Elm.Annotation.string

                            BytesPart ->
                                CliMonad.succeed Gen.Bytes.annotation_.bytes
                                    |> CliMonad.withRequiredPackage "elm/bytes"
                in
                CliMonad.map
                    (\partType ->
                        if required then
                            ( Common.toValueName name, partType )

                        else
                            ( Common.toValueName name, Elm.Annotation.maybe partType )
                    )
                    partAnnotation
            )
        |> CliMonad.map Elm.Annotation.record


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
                                    paramToType concreteParam
                                        |> CliMonad.andThen
                                            (\( paramName, type_ ) ->
                                                paramToString type_
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
                                    paramToType concreteParam
                                        |> CliMonad.andThen
                                            (\( paramName, type_ ) ->
                                                paramToString type_
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
                    |> CliMonad.combineMap queryParameterToUrlBuilderArgument
                    |> CliMonad.map (\arg -> initialUrl replacements (List.concat arg))
            )


operationToAuthorizationInfo : OpenApi.Operation.Operation -> CliMonad AuthorizationInfo
operationToAuthorizationInfo operation =
    let
        step :
            Maybe (Dict String (OpenApi.Reference.ReferenceOr OpenApi.SecurityScheme.SecurityScheme))
            -> ( String, List String )
            ->
                { headers : Dict String (Elm.Expression -> Elm.Expression)
                , paramsAuthorization : Dict String Elm.Annotation.Annotation
                , scopes : List String
                , query : Dict String (Elm.Expression -> Elm.Expression)
                }
            ->
                CliMonad
                    { headers : Dict String (Elm.Expression -> Elm.Expression)
                    , paramsAuthorization : Dict String Elm.Annotation.Annotation
                    , scopes : List String
                    , query : Dict String (Elm.Expression -> Elm.Expression)
                    }
        step securitySchemes e acc =
            case e of
                ( "oauth_2_0", ss ) ->
                    if Dict.member "Authorization" acc.headers then
                        CliMonad.fail "Authorization header already set"

                    else
                        CliMonad.succeed
                            { acc
                                | headers =
                                    Dict.insert "Authorization"
                                        (\authorization ->
                                            Elm.Op.append
                                                (Elm.string "Bearer ")
                                                (authorization |> Elm.get "bearer")
                                        )
                                        acc.headers
                                , paramsAuthorization = Dict.insert "bearer" Elm.Annotation.string acc.paramsAuthorization
                                , scopes = ss ++ acc.scopes
                            }

                ( "Token", [] ) ->
                    if Dict.member "Authorization" acc.headers then
                        CliMonad.fail "Authorization header already set"

                    else
                        CliMonad.succeed
                            { acc
                                | headers =
                                    Dict.insert "Authorization"
                                        (\authorization ->
                                            Elm.Op.append
                                                (Elm.string "Token ")
                                                (authorization |> Elm.get "token")
                                        )
                                        acc.headers
                                , paramsAuthorization = Dict.insert "token" Elm.Annotation.string acc.paramsAuthorization
                            }

                ( name, _ ) ->
                    case securitySchemes of
                        Just securitySchemas ->
                            case Maybe.andThen OpenApi.Reference.toConcrete <| Dict.get name securitySchemas of
                                Nothing ->
                                    CliMonad.todoWithDefault
                                        acc
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
                                                        CliMonad.fail (apiKey.name ++ " header already set")

                                                    else
                                                        CliMonad.succeed
                                                            { acc
                                                                | headers =
                                                                    Dict.insert apiKey.name
                                                                        (\authorization ->
                                                                            authorization |> Elm.get cleanName
                                                                        )
                                                                        acc.headers
                                                                , paramsAuthorization = Dict.insert cleanName Elm.Annotation.string acc.paramsAuthorization
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
                                                        , paramsAuthorization = Dict.insert cleanName Elm.Annotation.string acc.paramsAuthorization
                                                    }
                                                        |> CliMonad.succeed

                                                OpenApi.SecurityScheme.Cookie ->
                                                    if Dict.member "Cookie" acc.headers then
                                                        CliMonad.fail "Cookie header already set"

                                                    else
                                                        CliMonad.succeed
                                                            { acc
                                                                | headers =
                                                                    Dict.insert "Cookie"
                                                                        (\authorization ->
                                                                            Elm.Op.append
                                                                                (Elm.string (apiKey.name ++ "="))
                                                                                (authorization |> Elm.get cleanName)
                                                                        )
                                                                        acc.headers
                                                                , paramsAuthorization = Dict.insert cleanName Elm.Annotation.string acc.paramsAuthorization
                                                            }

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
                                                                (\authorization ->
                                                                    Elm.Op.append
                                                                        (Elm.string "Bearer ")
                                                                        (authorization |> Elm.get cleanName)
                                                                )
                                                                acc.headers
                                                        , paramsAuthorization = Dict.insert cleanName Elm.Annotation.string acc.paramsAuthorization
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
                                                        (\authorization ->
                                                            Elm.Op.append
                                                                (Elm.string "Bearer ")
                                                                (authorization |> Elm.get cleanName)
                                                        )
                                                        acc.headers
                                                , paramsAuthorization = Dict.insert cleanName Elm.Annotation.string acc.paramsAuthorization
                                            }
                                                |> CliMonad.succeed

                                        OpenApi.SecurityScheme.OpenIdConnect _ ->
                                            CliMonad.todoWithDefault acc "Unsupported security schema: OpenIdConnect"

                        Nothing ->
                            CliMonad.todoWithDefault
                                acc
                                ("Unknown security requirement: " ++ name)
    in
    CliMonad.getApiSpec
        |> CliMonad.andThen
            (\spec ->
                let
                    components : Maybe OpenApi.Components.Components
                    components =
                        OpenApi.components spec

                    securitySchemes : Maybe (Dict String (OpenApi.Reference.ReferenceOr OpenApi.SecurityScheme.SecurityScheme))
                    securitySchemes =
                        Maybe.map OpenApi.Components.securitySchemes components
                in
                -- If present, the operation's security overrides globalSecurity.
                OpenApi.Operation.security operation
                    |> Maybe.withDefault (OpenApi.security spec)
                    |> List.concatMap (Dict.toList << OpenApi.SecurityRequirement.requirements)
                    |> CliMonad.foldl (step securitySchemes)
                        (CliMonad.succeed
                            { headers = Dict.empty
                            , paramsAuthorization = Dict.empty
                            , query = Dict.empty
                            , scopes = []
                            }
                        )
            )
        |> CliMonad.map
            (\{ headers, paramsAuthorization, query, scopes } ->
                { headers =
                    \config ->
                        headers
                            |> Dict.toList
                            |> List.map
                                (\( k, v ) ->
                                    ( Elm.string k
                                    , config
                                        |> Elm.get "authorization"
                                        |> v
                                    )
                                )
                , params =
                    if Dict.isEmpty paramsAuthorization then
                        []

                    else
                        let
                            annotation : Elm.Annotation.Annotation
                            annotation =
                                case Dict.toList paramsAuthorization of
                                    [ ( "", t ) ] ->
                                        t

                                    list ->
                                        Elm.Annotation.record list
                        in
                        [ ( Common.UnsafeName "authorization", annotation ) ]
                , query =
                    \config ->
                        query
                            |> Dict.toList
                            |> List.map (\( k, v ) -> ( Elm.string k, v config ))
                , scopes = scopes
                }
            )


operationToContentSchema : OpenApi.Operation.Operation -> CliMonad ContentSchema
operationToContentSchema operation =
    let
        makeConcrete :
            List (Common.RefTo Common.RequestBody)
            -> OpenApi.Reference.ReferenceOr OpenApi.RequestBody.RequestBody
            -> CliMonad ContentSchema
        makeConcrete seen requestOrRef =
            case OpenApi.Reference.toConcrete requestOrRef of
                Just request ->
                    OpenApi.RequestBody.content request
                        |> contentToContentSchema

                Nothing ->
                    CliMonad.succeed requestOrRef
                        |> CliMonad.stepOrFail "I found a successful response, but I couldn't convert it to a concrete one"
                            OpenApi.Reference.toReference
                        |> CliMonad.andThen
                            (\raw ->
                                OpenApi.Reference.ref raw
                                    |> Common.parseRequestBodyRef
                                    |> CliMonad.fromResult
                                    |> CliMonad.andThen
                                        (\ref ->
                                            if List.member ref seen then
                                                CliMonad.fail "Circular references"

                                            else
                                                SchemaUtils.getRequestBody ref
                                                    |> CliMonad.andThen (makeConcrete (ref :: seen))
                                        )
                            )
    in
    case OpenApi.Operation.requestBody operation of
        Nothing ->
            CliMonad.succeed EmptyContent

        Just requestOrRef ->
            makeConcrete [] requestOrRef


jsonRegex : Regex
jsonRegex =
    Regex.fromString "^application\\/(vnd\\.[a-z0-9]+(\\.v\\d+)?(\\.[a-z0-9]+)?)?\\+?json(;charset=utf-8)?$"
        |> Maybe.withDefault Regex.never


searchForJsonMediaType : Dict String OpenApi.MediaType.MediaType -> Maybe OpenApi.MediaType.MediaType
searchForJsonMediaType dict =
    Dict.Extra.find
        (\mediaType _ ->
            mediaType == "*/*" || Regex.contains jsonRegex mediaType
        )
        dict
        |> Maybe.map Tuple.second


contentToContentSchema : Dict String OpenApi.MediaType.MediaType -> CliMonad ContentSchema
contentToContentSchema content =
    let
        default : Maybe (CliMonad ContentSchema) -> CliMonad ContentSchema
        default fallback =
            case searchForJsonMediaType content of
                Just jsonSchema ->
                    CliMonad.succeed jsonSchema
                        |> CliMonad.stepOrFail "The request's application/json content option doesn't have a schema"
                            (OpenApi.MediaType.schema >> Maybe.map OpenApi.Schema.get)
                        |> CliMonad.andThen (SchemaUtils.schemaToType [])
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
                                    case Dict.get "multipart/form-data" content of
                                        Just multipartSchema ->
                                            multipartContent multipartSchema

                                        Nothing ->
                                            let
                                                msg : String
                                                msg =
                                                    "The content doesn't have an application/json, multipart/form-data, text/html or text/plain option, it has " ++ String.join ", " (Dict.keys content)
                                            in
                                            fallback
                                                |> Maybe.withDefault (CliMonad.fail msg)

        stringContent : String -> OpenApi.MediaType.MediaType -> CliMonad ContentSchema
        stringContent mime htmlSchema =
            CliMonad.succeed htmlSchema
                |> CliMonad.stepOrFail ("The request's " ++ mime ++ " content option doesn't have a schema")
                    (OpenApi.MediaType.schema >> Maybe.map OpenApi.Schema.get)
                |> CliMonad.andThen (SchemaUtils.schemaToType [])
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


multipartContent : OpenApi.MediaType.MediaType -> CliMonad ContentSchema
multipartContent mediaType =
    case OpenApi.MediaType.schema mediaType of
        Nothing ->
            CliMonad.fail "Missing schema"

        Just schema ->
            SchemaUtils.schemaToType [] (OpenApi.Schema.get schema)
                |> CliMonad.andThen
                    (\{ type_ } ->
                        case type_ of
                            Common.Object fields ->
                                fields
                                    |> List.map
                                        (\( fieldName, field ) ->
                                            { name = fieldName
                                            , required = field.required
                                            , part =
                                                case field.type_ of
                                                    Common.Basic Common.String { format } ->
                                                        case format of
                                                            Just "binary" ->
                                                                BytesPart

                                                            _ ->
                                                                StringPart

                                                    Common.Bytes ->
                                                        BytesPart

                                                    _ ->
                                                        JsonPart field.type_
                                            }
                                        )
                                    |> MultipartContent
                                    |> CliMonad.succeed

                            _ ->
                                CliMonad.fail ("Schema with a type of " ++ SchemaUtils.typeToString type_ ++ " not supported")
                    )


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
    | MultipleServers (List { name : Common.UnsafeName, url : String, description : Maybe String })


serverInfo : OpenApi.Config.Server -> CliMonad ServerInfo
serverInfo server =
    case server of
        OpenApi.Config.Single cliServer ->
            SingleServer cliServer
                |> CliMonad.succeed

        OpenApi.Config.Default ->
            CliMonad.getApiSpec
                |> CliMonad.map
                    (\spec ->
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
                                            { name = Common.UnsafeName name
                                            , url = OpenApi.Server.url value
                                            , description = description
                                            }
                                        )
                                    |> MultipleServers
                    )

        OpenApi.Config.Multiple servers ->
            servers
                |> Dict.toList
                |> List.map
                    (\( name, url ) ->
                        { name = Common.UnsafeName name
                        , url = url
                        , description = Nothing
                        }
                    )
                |> MultipleServers
                |> CliMonad.succeed


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
                        |> CliMonad.andThen paramToAnnotation
                )
            |> CliMonad.map
                (\types -> [ ( Common.UnsafeName "params", SchemaUtils.recordType types ) ])


queryParameterToUrlBuilderArgument : OpenApi.Parameter.Parameter -> CliMonad (List (Elm.Expression -> Elm.Expression))
queryParameterToUrlBuilderArgument param =
    paramToType param
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
                                    paramToString (Common.Nullable field.type_)
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
                                    paramToString field.type_
                                        |> CliMonad.map
                                            (\{ inputToString, alwaysJust } ->
                                                paramToBuilder inputToString alwaysJust [ ( fieldName, False ) ]
                                            )
                                        |> CliMonad.withPath (Common.UnsafeName "query params (object)")
                                )

                    _ ->
                        paramToString type_
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
    Common.Type
    -> CliMonad { inputToString : InputToString, alwaysJust : Bool, isMaybe : Bool }
paramToString type_ =
    let
        recursive :
            Common.Type
            -> Bool
            -> ({ inputToString : InputToString, alwaysJust : Bool, isMaybe : Bool } -> InputToString)
            -> CliMonad { inputToString : InputToString, alwaysJust : Bool, isMaybe : Bool }
        recursive p isMaybe f =
            paramToString p
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
            CliMonad.withFormat
                basicType
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
            SchemaUtils.getSchema ref
                |> CliMonad.andThen (SchemaUtils.schemaToType [])
                |> CliMonad.andThen (\param -> paramToString param.type_)

        Common.OneOf name data ->
            CliMonad.map2
                (\valType branches ->
                    { inputToString =
                        InputToString (\val -> Elm.Case.custom val valType branches)
                    , alwaysJust = True
                    , isMaybe = False
                    }
                )
                (SchemaUtils.typeToAnnotationWithNullable type_)
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
                            (paramToString alternative.type_)
                            (SchemaUtils.typeToAnnotationWithNullable alternative.type_)
                    )
                    (NonEmpty.toList data)
                )

        Common.Enum variants ->
            variants
                |> NonEmpty.toList
                |> CliMonad.enumName
                |> CliMonad.map2
                    (\importFrom maybeName ->
                        case maybeName of
                            Nothing ->
                                { inputToString = Identity, alwaysJust = True, isMaybe = False }

                            Just name ->
                                { inputToString =
                                    InputToString
                                        (\val ->
                                            Elm.apply
                                                (Elm.value
                                                    { importFrom = importFrom
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
                    (CliMonad.moduleToNamespace (Common.Types Common.Schema))

        _ ->
            SchemaUtils.typeToAnnotationWithNullable type_
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


paramToAnnotation : OpenApi.Parameter.Parameter -> CliMonad ( Common.UnsafeName, Elm.Annotation.Annotation )
paramToAnnotation concreteParam =
    paramToType concreteParam
        |> CliMonad.andThen
            (\( paramName, type_ ) ->
                SchemaUtils.typeToAnnotationWithMaybe type_
                    |> CliMonad.map
                        (\annotation -> ( paramName, annotation ))
            )


paramToType : OpenApi.Parameter.Parameter -> CliMonad ( Common.UnsafeName, Common.Type )
paramToType concreteParam =
    let
        paramName : String
        paramName =
            OpenApi.Parameter.name concreteParam
    in
    CliMonad.succeed concreteParam
        |> CliMonad.stepOrFail ("Could not get schema for parameter " ++ paramName)
            (OpenApi.Parameter.schema >> Maybe.map OpenApi.Schema.get)
        |> CliMonad.andThen (SchemaUtils.schemaToType [])
        |> CliMonad.andThen
            (\{ type_ } ->
                case type_ of
                    Common.Ref ref ->
                        ref
                            |> SchemaUtils.getSchema
                            |> CliMonad.andThen (SchemaUtils.schemaToType [])
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
                                CliMonad.getApiSpec
                                    |> CliMonad.andThen
                                        (\spec ->
                                            spec
                                                |> OpenApi.components
                                                |> Maybe.map OpenApi.Components.parameters
                                                |> Maybe.andThen (Dict.get parameterType)
                                                |> Maybe.map toConcreteParam
                                                |> Maybe.withDefault (CliMonad.fail <| "Param ref " ++ parameterType ++ " not found")
                                        )

                            _ ->
                                CliMonad.fail <| "Param reference should be to \"#/components/parameters/ref\", found:" ++ ref
                    )


type alias OperationUtils =
    { successType : SuccessType
    , bodyTypeAnnotation : Elm.Annotation.Annotation
    , errorTypeDeclaration : Maybe { name : String, declaration : Elm.Declaration, group : String }
    , errorTypeAnnotation : Elm.Annotation.Annotation
    , expect : PerPackage (CliMonad (Elm.Expression -> Elm.Expression))
    , resolver :
        { core : Elm.Expression
        , lamderaProgramTest : Elm.Expression
        }
    , effectTypes : List OpenApi.Config.EffectType
    , method : String
    , operation : OpenApi.Operation.Operation
    , isSinglePackage : Bool
    , functionName : String
    , toMsg : Elm.Expression -> Elm.Expression
    }


type SuccessType
    = SuccessType Common.Type
    | SuccessReference (Common.RefTo ())


operationToTypesExpectAndResolver :
    List OpenApi.Config.EffectType
    -> String
    -> String
    -> OpenApi.Operation.Operation
    -> CliMonad OperationUtils
operationToTypesExpectAndResolver effectTypes method pathUrl operation =
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

        responses : Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response)
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
                    errorResponses : Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response)
                    errorResponses =
                        getErrorResponses responses
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
                                                        { successType = SuccessType type_
                                                        , bodyTypeAnnotation = Elm.Annotation.string
                                                        , errorTypeDeclaration = errorTypeDeclaration_
                                                        , errorTypeAnnotation = errorTypeAnnotation
                                                        , expect = expectJsonBetter errorDecoders_ successDecoder
                                                        , resolver =
                                                            { core = OpenApi.Common.Internal.elmHttpSubmodule.call.jsonResolverCustom errorDecoders_ successDecoder
                                                            , lamderaProgramTest = OpenApi.Common.Internal.lamderaProgramTestSubmodule.call.jsonResolverCustomEffect errorDecoders_ successDecoder
                                                            }
                                                        , isSinglePackage = isSinglePackage
                                                        , effectTypes = effectTypes
                                                        , method = method
                                                        , operation = operation
                                                        , functionName = functionName
                                                        , toMsg = toMsg
                                                        }
                                                    )
                                                    (SchemaUtils.typeToDecoder type_)

                                            StringContent _ ->
                                                { successType =
                                                    Common.Basic Common.String
                                                        { const = Nothing
                                                        , format = Nothing
                                                        }
                                                        |> SuccessType
                                                , bodyTypeAnnotation = Elm.Annotation.string
                                                , errorTypeDeclaration = errorTypeDeclaration_
                                                , errorTypeAnnotation = errorTypeAnnotation
                                                , expect = expectStringBetter errorDecoders_
                                                , resolver =
                                                    { core = OpenApi.Common.Internal.elmHttpSubmodule.call.stringResolverCustom errorDecoders_
                                                    , lamderaProgramTest = OpenApi.Common.Internal.lamderaProgramTestSubmodule.call.stringResolverCustomEffect errorDecoders_
                                                    }
                                                , isSinglePackage = isSinglePackage
                                                , effectTypes = effectTypes
                                                , method = method
                                                , operation = operation
                                                , functionName = functionName
                                                , toMsg = toMsg
                                                }
                                                    |> CliMonad.succeed

                                            BytesContent _ ->
                                                { successType = SuccessType Common.Bytes
                                                , bodyTypeAnnotation = Gen.Bytes.annotation_.bytes
                                                , errorTypeDeclaration = errorTypeDeclaration_
                                                , errorTypeAnnotation = errorTypeAnnotation
                                                , expect = expectBytesBetter errorDecoders_
                                                , resolver =
                                                    { core = OpenApi.Common.Internal.elmHttpSubmodule.call.bytesResolverCustom errorDecoders_
                                                    , lamderaProgramTest = OpenApi.Common.Internal.lamderaProgramTestSubmodule.call.bytesResolverCustomEffect errorDecoders_
                                                    }
                                                , isSinglePackage = isSinglePackage
                                                , effectTypes = effectTypes
                                                , method = method
                                                , operation = operation
                                                , functionName = functionName
                                                , toMsg = toMsg
                                                }
                                                    |> CliMonad.succeed
                                                    |> CliMonad.withRequiredPackage "elm/bytes"

                                            Base64Content _ ->
                                                { successType = SuccessType Common.Bytes
                                                , bodyTypeAnnotation = Elm.Annotation.string
                                                , errorTypeDeclaration = errorTypeDeclaration_
                                                , errorTypeAnnotation = errorTypeAnnotation
                                                , expect = expectBase64Better errorDecoders_
                                                , resolver =
                                                    { core = OpenApi.Common.Internal.elmHttpBase64Submodule.call.base64ResolverCustom errorDecoders_
                                                    , lamderaProgramTest = OpenApi.Common.Internal.lamderaProgramTestBase64Submodule.call.base64ResolverCustomEffect errorDecoders_
                                                    }
                                                , isSinglePackage = isSinglePackage
                                                , effectTypes = effectTypes
                                                , method = method
                                                , operation = operation
                                                , functionName = functionName
                                                , toMsg = toMsg
                                                }
                                                    |> CliMonad.succeed
                                                    |> CliMonad.withRequiredPackage "elm/bytes"
                                                    |> CliMonad.withRequiredPackage Common.base64PackageName

                                            EmptyContent ->
                                                { successType = SuccessType Common.Unit
                                                , bodyTypeAnnotation = Elm.Annotation.string
                                                , errorTypeDeclaration = errorTypeDeclaration_
                                                , errorTypeAnnotation = errorTypeAnnotation
                                                , expect = expectJsonBetter errorDecoders_ (Gen.Json.Decode.succeed Elm.unit)
                                                , resolver =
                                                    { core = OpenApi.Common.Internal.elmHttpSubmodule.call.jsonResolverCustom errorDecoders_ (Gen.Json.Decode.succeed Elm.unit)
                                                    , lamderaProgramTest = OpenApi.Common.Internal.lamderaProgramTestSubmodule.call.jsonResolverCustomEffect errorDecoders_ (Gen.Json.Decode.succeed Elm.unit)
                                                    }
                                                , isSinglePackage = isSinglePackage
                                                , effectTypes = effectTypes
                                                , method = method
                                                , operation = operation
                                                , functionName = functionName
                                                , toMsg = toMsg
                                                }
                                                    |> CliMonad.succeed

                                            MultipartContent _ ->
                                                CliMonad.fail "operationToTypesExpectAndResolver: branch 'ReferenceContent _' not implemented"
                                    )
                                    (OpenApi.Response.content response
                                        |> contentToContentSchema
                                    )

                            Nothing ->
                                CliMonad.succeed responseOrRef
                                    |> CliMonad.stepOrFail "I found a successful response, but I couldn't convert it to a concrete one"
                                        OpenApi.Reference.toReference
                                    |> CliMonad.andThen parseReference
                                    |> CliMonad.andThen
                                        (\ref ->
                                            CliMonad.map
                                                (\decoder ->
                                                    { successType = SuccessReference ref
                                                    , bodyTypeAnnotation = Elm.Annotation.string
                                                    , errorTypeDeclaration = errorTypeDeclaration_
                                                    , errorTypeAnnotation = errorTypeAnnotation
                                                    , expect = expectJsonBetter errorDecoders_ decoder
                                                    , resolver =
                                                        { core = OpenApi.Common.Internal.elmHttpSubmodule.call.jsonResolverCustom errorDecoders_ decoder
                                                        , lamderaProgramTest = OpenApi.Common.Internal.lamderaProgramTestSubmodule.call.jsonResolverCustomEffect errorDecoders_ decoder
                                                        }
                                                    , isSinglePackage = isSinglePackage
                                                    , effectTypes = effectTypes
                                                    , method = method
                                                    , operation = operation
                                                    , functionName = functionName
                                                    , toMsg = toMsg
                                                    }
                                                )
                                                (CliMonad.refToDecoder ref)
                                        )
                    )
                    (errorResponsesToErrorDecoders functionName errorResponses)
                    (errorResponsesToType functionName errorResponses)
            )


parseReference : OpenApi.Reference.Reference -> CliMonad (Common.RefTo ())
parseReference ref =
    let
        inner : String
        inner =
            OpenApi.Reference.ref ref
    in
    Common.parseRef inner
        |> CliMonad.fromResult


errorResponsesToType : String -> Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response) -> CliMonad ( Maybe { name : String, declaration : Elm.Declaration, group : String }, Elm.Annotation.Annotation )
errorResponsesToType functionName errorResponses =
    errorResponses
        |> Dict.map
            (\_ errResponseOrRef ->
                case OpenApi.Reference.toConcrete errResponseOrRef of
                    Just errResponse ->
                        OpenApi.Response.content errResponse
                            |> contentToContentSchema
                            |> CliMonad.andThen
                                (\contentSchema ->
                                    case contentSchema of
                                        JsonContent type_ ->
                                            SchemaUtils.typeToAnnotationWithNullable type_

                                        StringContent _ ->
                                            CliMonad.succeed Elm.Annotation.string

                                        BytesContent _ ->
                                            CliMonad.succeed Gen.Bytes.annotation_.bytes
                                                |> CliMonad.withRequiredPackage "elm/bytes"

                                        EmptyContent ->
                                            CliMonad.succeed Elm.Annotation.unit

                                        Base64Content _ ->
                                            CliMonad.succeed Elm.Annotation.string

                                        MultipartContent parts ->
                                            multipartPartsToAnnotation parts
                                )

                    Nothing ->
                        CliMonad.succeed errResponseOrRef
                            |> CliMonad.stepOrFail "I found an error response, but I couldn't convert it to a concrete annotation"
                                OpenApi.Reference.toReference
                            |> CliMonad.andThen parseReference
                            |> CliMonad.andThen CliMonad.refToAnnotation
            )
        |> CliMonad.combineDict
        |> CliMonad.andThen
            (\dict ->
                case Dict.toList dict of
                    [] ->
                        ( Nothing, Elm.Annotation.var "e" )
                            |> CliMonad.succeed

                    [ ( _, annotation ) ] ->
                        ( Nothing, annotation )
                            |> CliMonad.succeed

                    errorList ->
                        let
                            errorName : String
                            errorName =
                                String.Extra.toSentenceCase functionName ++ "_Error"
                        in
                        CliMonad.moduleToNamespace (Common.Types Common.Response)
                            |> CliMonad.map
                                (\importFrom ->
                                    ( { name = errorName
                                      , declaration =
                                            errorList
                                                |> List.map (\( statusCode, annotation ) -> Elm.variantWith (toErrorVariant functionName statusCode) [ annotation ])
                                                |> Elm.customType errorName
                                                |> Elm.exposeConstructor
                                      , group = "Errors"
                                      }
                                        |> Just
                                    , Elm.Annotation.named importFrom errorName
                                    )
                                )
            )


errorResponsesToErrorDecoders : String -> Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response) -> CliMonad Elm.Expression
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
            CliMonad.moduleToNamespace (Common.Types Common.Response)
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
                                                        |> contentToContentSchema
                                                        |> CliMonad.andThen
                                                            (\contentSchema ->
                                                                case contentSchema of
                                                                    JsonContent type_ ->
                                                                        SchemaUtils.typeToDecoder type_

                                                                    StringContent _ ->
                                                                        CliMonad.succeed Gen.Json.Decode.string

                                                                    BytesContent _ ->
                                                                        CliMonad.todo "Bytes errors are not supported yet"

                                                                    Base64Content _ ->
                                                                        CliMonad.todo "Base 64 errors are not supported yet"

                                                                    EmptyContent ->
                                                                        CliMonad.succeed (Gen.Json.Decode.succeed Elm.unit)

                                                                    MultipartContent _ ->
                                                                        CliMonad.todo "Multipart errors are not supported yet"
                                                            )

                                                Nothing ->
                                                    CliMonad.succeed errResponseOrRef
                                                        |> CliMonad.stepOrFail "I found an error response, but I couldn't convert it to a concrete decoder"
                                                            OpenApi.Reference.toReference
                                                        |> CliMonad.andThen parseReference
                                                        |> CliMonad.andThen CliMonad.refToDecoder
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


getFirstSuccessResponse : Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response) -> Maybe ( String, OpenApi.Reference.ReferenceOr OpenApi.Response.Response )
getFirstSuccessResponse responses =
    responses
        |> Dict.Extra.find (\code _ -> isSuccessResponseStatus code)


getErrorResponses : Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response) -> Dict String (OpenApi.Reference.ReferenceOr OpenApi.Response.Response)
getErrorResponses responses =
    responses
        |> Dict.filter (\status _ -> not <| isSuccessResponseStatus status)


responseToSchema : OpenApi.Response.Response -> CliMonad Json.Schema.Definitions.Schema
responseToSchema response =
    CliMonad.succeed response
        |> CliMonad.stepOrFail "The response does not have a json content"
            (OpenApi.Response.content >> searchForJsonMediaType)
        |> CliMonad.stepOrFail "The response's json content option doesn't have a schema"
            OpenApi.MediaType.schema
        |> CliMonad.map OpenApi.Schema.get


makeNamespaceValid : String -> String
makeNamespaceValid str =
    String.map
        (\char ->
            if isInvalidForModuleName char then
                '_'

            else
                char
        )
        str


removeInvalidChars : String -> String
removeInvalidChars str =
    String.filter (\char -> Char.toCode char /= {- '\'' -} 39) str


isInvalidForModuleName : Char -> Bool
isInvalidForModuleName char =
    let
        code : Int
        code =
            Char.toCode char
    in
    (code == {- ' ' -} 32)
        || (code == {- '.' -} 46)
        || (code == {- '/' -} 47)
        || (code == {- '{' -} 123)
        || (code == {- '}' -} 125)
        || (code == {- '-' -} 45)
        || (code == {- ':' -} 58)
        || (code == {- '(' -} 40)
        || (code == {- ')' -} 41)
