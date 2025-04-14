module OpenApi.Common.Internal exposing (CommonSubmodule, ElmHttpBase64Submodule, ElmHttpSubmodule, Error, LamderaProgramTestBase64Submodule, LamderaProgramTestSubmodule, Nullable, annotation_, commonSubmodule, declarations, elmHttpBase64Submodule, elmHttpSubmodule, lamderaProgramTestBase64Submodule, lamderaProgramTestSubmodule, make_)

import Common
import Elm
import Elm.Annotation
import Elm.Arg
import Elm.Case
import Elm.Declare
import Elm.Declare.Extra
import Gen.Bytes
import Gen.Bytes.Decode
import Gen.Dict
import Gen.Effect.Http
import Gen.Http
import Gen.Json.Decode
import Gen.Maybe
import Gen.Result
import Gen.String
import OpenApi.Config


annotation_ :
    { error : Elm.Annotation.Annotation -> Elm.Annotation.Annotation -> Elm.Annotation.Annotation
    , nullable : Elm.Annotation.Annotation -> Elm.Annotation.Annotation
    }
annotation_ =
    { error = \err ok -> Elm.Annotation.namedWith Common.commonModuleName "Error" [ err, ok ]
    , nullable = \t -> Elm.Annotation.namedWith Common.commonModuleName "Nullable" [ t ]
    }


make_ :
    { null : Elm.Expression
    , present : Elm.Expression -> Elm.Expression
    }
make_ =
    { null = commonSubmodule.call.nullable.make_.null
    , present = commonSubmodule.call.nullable.make_.present
    }


errorAnnotation : Elm.Annotation.Annotation -> Elm.Annotation.Annotation
errorAnnotation t =
    annotation_.error (Elm.Annotation.var "err") t


declarations : { a | requiresBase64 : Bool, effectTypes : List OpenApi.Config.EffectType } -> List { declaration : Elm.Declaration, group : String }
declarations { requiresBase64, effectTypes } =
    let
        requiresElmHttp : Bool
        requiresElmHttp =
            List.any
                (\effectType -> OpenApi.Config.effectTypeToPackage effectType == Common.ElmHttp)
                effectTypes

        requiresLamderaProgramTest : Bool
        requiresLamderaProgramTest =
            List.any
                (\effectType -> OpenApi.Config.effectTypeToPackage effectType == Common.LamderaProgramTest)
                effectTypes

        elmHttp : List { declaration : Elm.Declaration, group : String }
        elmHttp =
            group "elm/http" requiresElmHttp elmHttpSubmodule

        elmHttpBase64 : List { declaration : Elm.Declaration, group : String }
        elmHttpBase64 =
            group "elm/http" (requiresElmHttp && requiresBase64) elmHttpBase64Submodule

        lamderaProgramTest : List { declaration : Elm.Declaration, group : String }
        lamderaProgramTest =
            group "lamdera/program-test" requiresLamderaProgramTest lamderaProgramTestSubmodule

        lamderaProgramTestBase64 : List { declaration : Elm.Declaration, group : String }
        lamderaProgramTestBase64 =
            group "lamdera/program-test" (requiresLamderaProgramTest && requiresBase64) lamderaProgramTestBase64Submodule

        common : List { declaration : Elm.Declaration, group : String }
        common =
            group "Common" True commonSubmodule

        group :
            String
            -> Bool
            -> { sub | declarations : List Elm.Declaration }
            -> List { declaration : Elm.Declaration, group : String }
        group name condition submodule =
            if condition then
                List.map
                    (\declaration ->
                        { declaration = declaration
                        , group = name
                        }
                    )
                    submodule.declarations

            else
                []
    in
    elmHttp ++ elmHttpBase64 ++ lamderaProgramTest ++ lamderaProgramTestBase64 ++ common


type alias ElmHttpSubmodule =
    { expectJsonCustom : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , jsonResolverCustom : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectStringCustom : Elm.Expression -> Elm.Expression -> Elm.Expression
    , stringResolverCustom : Elm.Expression -> Elm.Expression
    , expectBytesCustom : Elm.Expression -> Elm.Expression -> Elm.Expression
    , bytesResolverCustom : Elm.Expression -> Elm.Expression
    }


elmHttpSubmodule : Elm.Declare.Module ElmHttpSubmodule
elmHttpSubmodule =
    Elm.Declare.module_ Common.commonModuleName ElmHttpSubmodule
        |> Elm.Declare.with expectJsonCustom
        |> Elm.Declare.with jsonResolverCustom
        |> Elm.Declare.with expectStringCustom
        |> Elm.Declare.with stringResolverCustom
        |> Elm.Declare.with expectBytesCustom
        |> Elm.Declare.with bytesResolverCustom


type alias ElmHttpBase64Submodule =
    { expectBase64Custom : Elm.Expression -> Elm.Expression -> Elm.Expression
    , base64ResolverCustom : Elm.Expression -> Elm.Expression
    }


elmHttpBase64Submodule : Elm.Declare.Module ElmHttpBase64Submodule
elmHttpBase64Submodule =
    Elm.Declare.module_ Common.commonModuleName ElmHttpBase64Submodule
        |> Elm.Declare.with expectBase64Custom
        |> Elm.Declare.with base64ResolverCustom


expectJsonCustom : Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
expectJsonCustom =
    outerExpectJsonCustom "expectJsonCustom"
        (\errorDecoders successDecoder toMsg ->
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Http.caseOf_.response response (innerExpectJsonCustom errorDecoders successDecoder)
            in
            Gen.Http.expectStringResponse toMsg toResult
                |> Elm.withType (Gen.Http.annotation_.expect (Elm.Annotation.var "msg"))
        )


jsonResolverCustom : Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression)
jsonResolverCustom =
    outerJsonResolverCustom "jsonResolverCustom" <|
        \errorDecoders successDecoder ->
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Http.caseOf_.response response
                        (innerExpectJsonCustom errorDecoders successDecoder)
            in
            Gen.Http.stringResolver toResult
                |> Elm.withType (Gen.Http.annotation_.resolver (errorAnnotation Elm.Annotation.string) (Elm.Annotation.var "success"))


expectStringCustom : Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression)
expectStringCustom =
    outerExpectStringCustom "expectStringCustom"
        (\errorDecoders toMsg ->
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Http.caseOf_.response response
                        (innerExpectRawCustom { isBytes = False } errorDecoders)
            in
            Gen.Http.expectStringResponse toMsg toResult
                |> Elm.withType (Gen.Http.annotation_.expect (Elm.Annotation.var "msg"))
        )


stringResolverCustom : Elm.Declare.Function (Elm.Expression -> Elm.Expression)
stringResolverCustom =
    outerRawResolverCustom "stringResolverCustom" <|
        \errorDecoders ->
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Http.caseOf_.response response
                        (innerExpectRawCustom { isBytes = False } errorDecoders)
            in
            Gen.Http.stringResolver toResult
                |> Elm.withType (Gen.Http.annotation_.resolver (errorAnnotation Elm.Annotation.string) Elm.Annotation.string)


expectBytesCustom : Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression)
expectBytesCustom =
    outerExpectBytesCustom "expectBytesCustom"
        (\errorDecoders toMsg ->
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Http.caseOf_.response response
                        (innerExpectRawCustom { isBytes = True } errorDecoders)
            in
            Gen.Http.expectBytesResponse toMsg toResult
                |> Elm.withType (Gen.Http.annotation_.expect (Elm.Annotation.var "msg"))
        )


bytesResolverCustom : Elm.Declare.Function (Elm.Expression -> Elm.Expression)
bytesResolverCustom =
    outerRawResolverCustom "bytesResolverCustom" <|
        \errorDecoders ->
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Http.caseOf_.response response
                        (innerExpectRawCustom { isBytes = True } errorDecoders)
            in
            Gen.Http.bytesResolver toResult
                |> Elm.withType (Gen.Http.annotation_.resolver (errorAnnotation Gen.Bytes.annotation_.bytes) Gen.Bytes.annotation_.bytes)


expectBase64Custom : Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression)
expectBase64Custom =
    outerExpectStringCustom "expectBase64Custom"
        (\errorDecoders toMsg ->
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Http.caseOf_.response response
                        (innerExpectRawCustom { isBytes = True } errorDecoders)
            in
            Gen.Http.expectStringResponse toMsg toResult
                |> Elm.withType (Gen.Http.annotation_.expect (Elm.Annotation.var "msg"))
        )


base64ResolverCustom : Elm.Declare.Function (Elm.Expression -> Elm.Expression)
base64ResolverCustom =
    outerRawResolverCustom "base64ResolverCustom" <|
        \errorDecoders ->
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Http.caseOf_.response response
                        (innerExpectRawCustom { isBytes = True } errorDecoders)
            in
            Gen.Http.bytesResolver toResult
                |> Elm.withType (Gen.Http.annotation_.resolver (errorAnnotation Elm.Annotation.string) Gen.Bytes.annotation_.bytes)


type alias LamderaProgramTestSubmodule =
    { expectJsonCustomEffect : Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , jsonResolverCustomEffect : Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectStringCustomEffect : Elm.Expression -> Elm.Expression -> Elm.Expression
    , stringResolverCustomEffect : Elm.Expression -> Elm.Expression
    , expectBytesCustomEffect : Elm.Expression -> Elm.Expression -> Elm.Expression
    , bytesResolverCustomEffect : Elm.Expression -> Elm.Expression
    }


lamderaProgramTestSubmodule : Elm.Declare.Module LamderaProgramTestSubmodule
lamderaProgramTestSubmodule =
    Elm.Declare.module_ Common.commonModuleName LamderaProgramTestSubmodule
        |> Elm.Declare.with expectJsonCustomEffect
        |> Elm.Declare.with jsonResolverCustomEffect
        |> Elm.Declare.with expectStringCustomEffect
        |> Elm.Declare.with stringResolverCustomEffect
        |> Elm.Declare.with expectBytesCustomEffect
        |> Elm.Declare.with bytesResolverCustomEffect


type alias LamderaProgramTestBase64Submodule =
    { expectBase64CustomEffect : Elm.Expression -> Elm.Expression -> Elm.Expression
    , base64ResolverCustomEffect : Elm.Expression -> Elm.Expression
    }


lamderaProgramTestBase64Submodule : Elm.Declare.Module LamderaProgramTestBase64Submodule
lamderaProgramTestBase64Submodule =
    Elm.Declare.module_ Common.commonModuleName LamderaProgramTestBase64Submodule
        |> Elm.Declare.with expectBase64CustomEffect
        |> Elm.Declare.with base64ResolverCustomEffect


expectJsonCustomEffect : Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
expectJsonCustomEffect =
    outerExpectJsonCustom "expectJsonCustomEffect"
        (\errorDecoders successDecoder toMsg ->
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Effect.Http.caseOf_.response response (innerExpectJsonCustom errorDecoders successDecoder)
            in
            Gen.Effect.Http.expectStringResponse toMsg toResult
                |> Elm.withType (Gen.Effect.Http.annotation_.expect (Elm.Annotation.var "msg"))
        )


jsonResolverCustomEffect : Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression)
jsonResolverCustomEffect =
    outerJsonResolverCustom "jsonResolverCustomEffect" <|
        \errorDecoders successDecoder ->
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Effect.Http.caseOf_.response response
                        (innerExpectJsonCustom errorDecoders successDecoder)
            in
            Gen.Effect.Http.stringResolver toResult
                |> Elm.withType (Gen.Effect.Http.annotation_.resolver (Elm.Annotation.var "restrictions") (errorAnnotation Elm.Annotation.string) (Elm.Annotation.var "success"))


expectBytesCustomEffect : Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression)
expectBytesCustomEffect =
    outerExpectBytesCustom "expectBytesCustomEffect"
        (\errorDecoders toMsg ->
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Effect.Http.caseOf_.response response
                        (innerExpectRawCustom { isBytes = True } errorDecoders)
            in
            Gen.Effect.Http.expectBytesResponse toMsg toResult
                |> Elm.withType (Gen.Effect.Http.annotation_.expect (Elm.Annotation.var "msg"))
        )


bytesResolverCustomEffect : Elm.Declare.Function (Elm.Expression -> Elm.Expression)
bytesResolverCustomEffect =
    outerRawResolverCustom "bytesResolverCustomEffect" <|
        \errorDecoders ->
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Effect.Http.caseOf_.response response
                        (innerExpectRawCustom { isBytes = True } errorDecoders)
            in
            Gen.Effect.Http.bytesResolver toResult
                |> Elm.withType (Gen.Effect.Http.annotation_.resolver (Elm.Annotation.var "restrictions") (errorAnnotation Gen.Bytes.annotation_.bytes) Gen.Bytes.annotation_.bytes)


expectStringCustomEffect : Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression)
expectStringCustomEffect =
    outerExpectStringCustom "expectStringCustomEffect"
        (\errorDecoders toMsg ->
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Effect.Http.caseOf_.response response
                        (innerExpectRawCustom { isBytes = False } errorDecoders)
            in
            Gen.Effect.Http.expectStringResponse toMsg toResult
                |> Elm.withType (Gen.Effect.Http.annotation_.expect (Elm.Annotation.var "msg"))
        )


stringResolverCustomEffect : Elm.Declare.Function (Elm.Expression -> Elm.Expression)
stringResolverCustomEffect =
    outerRawResolverCustom "stringResolverCustomEffect" <|
        \errorDecoders ->
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Effect.Http.caseOf_.response response
                        (innerExpectRawCustom { isBytes = False } errorDecoders)
            in
            Gen.Effect.Http.stringResolver toResult
                |> Elm.withType (Gen.Effect.Http.annotation_.resolver (Elm.Annotation.var "restrictions") (errorAnnotation Elm.Annotation.string) Elm.Annotation.string)


expectBase64CustomEffect : Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression)
expectBase64CustomEffect =
    outerExpectStringCustom "expectBase64CustomEffect"
        (\errorDecoders toMsg ->
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Effect.Http.caseOf_.response response
                        (innerExpectRawCustom { isBytes = True } errorDecoders)
            in
            Gen.Effect.Http.expectStringResponse toMsg toResult
                |> Elm.withType (Gen.Http.annotation_.expect (Elm.Annotation.var "msg"))
        )


base64ResolverCustomEffect : Elm.Declare.Function (Elm.Expression -> Elm.Expression)
base64ResolverCustomEffect =
    outerRawResolverCustom "base64ResolverCustomEffect" <|
        \errorDecoders ->
            let
                toResult : Elm.Expression -> Elm.Expression
                toResult response =
                    Gen.Effect.Http.caseOf_.response response
                        (innerExpectRawCustom { isBytes = True } errorDecoders)
            in
            Gen.Effect.Http.bytesResolver toResult
                |> Elm.withType (Gen.Effect.Http.annotation_.resolver (Elm.Annotation.var "restrictions") (errorAnnotation Elm.Annotation.string) Gen.Bytes.annotation_.bytes)


type alias CommonSubmodule =
    { decodeOptionalField : Elm.Expression -> Elm.Expression -> Elm.Expression
    , jsonDecodeAndMap : Elm.Expression -> Elm.Expression -> Elm.Expression
    , error :
        { annotation : Elm.Annotation.Annotation
        , case_ : Elm.Expression -> Error -> Elm.Expression
        , make_ : Error
        }
    , nullable :
        { annotation : Elm.Annotation.Annotation
        , case_ : Elm.Expression -> Nullable -> Elm.Expression
        , make_ : Nullable
        }
    }


commonSubmodule : Elm.Declare.Module CommonSubmodule
commonSubmodule =
    Elm.Declare.module_ Common.commonModuleName CommonSubmodule
        |> Elm.Declare.with decodeOptionalField
        |> Elm.Declare.with jsonDecodeAndMap
        |> Elm.Declare.with error
        |> Elm.Declare.with nullable


{-| Decode an optional field

    decodeString (decodeOptionalField "x" int) "{ \"x\": 3 }"
    --> Ok (Just 3)

    decodeString (decodeOptionalField "x" int) "{ \"x\": true }"
    --> Err ...

    decodeString (decodeOptionalField "x" int) "{ \"y\": 4 }"
    --> Ok Nothing

-}
decodeOptionalField : Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression)
decodeOptionalField =
    let
        decoderAnnotation : Elm.Annotation.Annotation
        decoderAnnotation =
            Gen.Json.Decode.annotation_.decoder (Elm.Annotation.var "t")

        resultAnnotation : Elm.Annotation.Annotation
        resultAnnotation =
            Gen.Json.Decode.annotation_.decoder (Gen.Maybe.annotation_.maybe <| Elm.Annotation.var "t")

        body : Elm.Expression -> Elm.Expression -> Elm.Expression
        body key fieldDecoder =
            -- The tricky part is that we want to make sure that
            -- if the field exists we error out if it has an incorrect shape.
            -- So what we do is we `oneOf` with `value` to avoid the `Nothing` branch,
            -- `andThen` we decode it. This is why we can't just use `maybe`, we would
            -- give `Nothing` when the shape is wrong.
            Gen.Json.Decode.oneOf
                [ Gen.Json.Decode.call_.map
                    (Elm.fn Elm.Arg.ignore <| \_ -> Elm.bool True)
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
    in
    Elm.Declare.fn2 "decodeOptionalField"
        (Elm.Arg.varWith "key" Elm.Annotation.string)
        (Elm.Arg.varWith "fieldDecoder" decoderAnnotation)
        body
        |> Elm.Declare.Extra.withDocumentation decodeOptionalFieldDocumentation


decodeOptionalFieldDocumentation : String
decodeOptionalFieldDocumentation =
    """Decode an optional field

    decodeString (decodeOptionalField "x" int) "{ "x": 3 }"
    --> Ok (Just 3)

    decodeString (decodeOptionalField "x" int) "{ "x": true }"
    --> Err ...

    decodeString (decodeOptionalField "x" int) "{ "y": 4 }"
    --> Ok Nothing"""


jsonDecodeAndMap : Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression)
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
    Elm.Declare.fn2 "jsonDecodeAndMap"
        (Elm.Arg.varWith "dx" (Gen.Json.Decode.annotation_.decoder aVarAnnotation))
        (Elm.Arg.varWith "df" (Gen.Json.Decode.annotation_.decoder aToBAnnotation))
        (\dx df ->
            Gen.Json.Decode.call_.map2 (Elm.val "(|>)") dx df
                |> Elm.withType (Gen.Json.Decode.annotation_.decoder bVarAnnotation)
        )
        |> Elm.Declare.Extra.withDocumentation "Chain JSON decoders, when `Json.Decode.map8` isn't enough."


type alias Error =
    { badUrl : Elm.Expression -> Elm.Expression
    , timeout : Elm.Expression
    , networkError : Elm.Expression
    , knownBadStatus : Elm.Expression -> Elm.Expression -> Elm.Expression
    , unknownBadStatus : Elm.Expression -> Elm.Expression -> Elm.Expression
    , badErrorBody : Elm.Expression -> Elm.Expression -> Elm.Expression
    , badBody : Elm.Expression -> Elm.Expression -> Elm.Expression
    }


error :
    { declaration : Elm.Declaration
    , annotation : Elm.Annotation.Annotation -> Elm.Annotation.Annotation -> Elm.Annotation.Annotation
    , make_ : Error
    , case_ : Elm.Expression -> Error -> Elm.Expression
    , internal :
        Elm.Declare.Internal
            { annotation : Elm.Annotation.Annotation
            , make_ : Error
            , case_ : Elm.Expression -> Error -> Elm.Expression
            }
    }
error =
    let
        base : Elm.Declare.CustomType Error
        base =
            Elm.Declare.customTypeAdvanced "Error" { exposeConstructor = True } Error
                |> Elm.Declare.variant1 "BadUrl" .badUrl Elm.Annotation.string
                |> Elm.Declare.variant0 "Timeout" .timeout
                |> Elm.Declare.variant0 "NetworkError" .networkError
                |> Elm.Declare.variant2 "KnownBadStatus" .knownBadStatus Elm.Annotation.int (Elm.Annotation.var "err")
                |> Elm.Declare.variant2 "UnknownBadStatus" .unknownBadStatus Gen.Http.annotation_.metadata (Elm.Annotation.var "body")
                |> Elm.Declare.variant2 "BadErrorBody" .badErrorBody Gen.Http.annotation_.metadata (Elm.Annotation.var "body")
                |> Elm.Declare.variant2 "BadBody" .badBody Gen.Http.annotation_.metadata (Elm.Annotation.var "body")
                |> Elm.Declare.finishCustomType
    in
    { declaration = base.declaration
    , annotation = \err ok -> Elm.Annotation.namedWith [] "Error" [ err, ok ]
    , make_ = base.make_
    , case_ = base.case_
    , internal = base.internal
    }


type alias Nullable =
    { null : Elm.Expression
    , present : Elm.Expression -> Elm.Expression
    }


nullable : Elm.Declare.CustomType Nullable
nullable =
    Elm.Declare.customTypeAdvanced "Nullable" { exposeConstructor = True } Nullable
        |> Elm.Declare.variant0 "Null" .null
        |> Elm.Declare.variant1 "Present" .present (Elm.Annotation.var "value")
        |> Elm.Declare.finishCustomType


outerJsonResolverCustom :
    String
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression)
outerJsonResolverCustom name f =
    Elm.Declare.fn2 name
        (Elm.Arg.varWith "errorDecoders"
            (Gen.Dict.annotation_.dict
                Gen.String.annotation_.string
                (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.var "err"))
            )
        )
        (Elm.Arg.varWith "successDecoder"
            (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.var "success"))
        )
        f


outerRawResolverCustom :
    String
    -> (Elm.Expression -> Elm.Expression)
    -> Elm.Declare.Function (Elm.Expression -> Elm.Expression)
outerRawResolverCustom name f =
    Elm.Declare.fn name
        (Elm.Arg.varWith "errorDecoders"
            (Gen.Dict.annotation_.dict
                Gen.String.annotation_.string
                (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.var "err"))
            )
        )
        f


outerExpectJsonCustom :
    String
    -> (Elm.Expression -> Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression)
    -> Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression)
outerExpectJsonCustom name f =
    Elm.Declare.fn3 name
        (Elm.Arg.varWith "errorDecoders"
            (Gen.Dict.annotation_.dict
                Gen.String.annotation_.string
                (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.var "err"))
            )
        )
        (Elm.Arg.varWith "successDecoder"
            (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.var "success"))
        )
        (Elm.Arg.varWith "toMsg"
            (Elm.Annotation.function
                [ Elm.Annotation.result (errorAnnotation Elm.Annotation.string) (Elm.Annotation.var "success")
                ]
                (Elm.Annotation.var "msg")
            )
        )
        (\errorDecoders successDecoders toMsg -> f errorDecoders successDecoders (\result -> Elm.apply toMsg [ result ]))


outerExpectStringCustom :
    String
    -> (Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression)
    -> Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression)
outerExpectStringCustom name f =
    Elm.Declare.fn2 name
        (Elm.Arg.varWith "errorDecoders"
            (Gen.Dict.annotation_.dict
                Gen.String.annotation_.string
                (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.var "err"))
            )
        )
        (Elm.Arg.varWith "toMsg"
            (Elm.Annotation.function
                [ Elm.Annotation.result (errorAnnotation Elm.Annotation.string) Elm.Annotation.string ]
                (Elm.Annotation.var "msg")
            )
        )
        (\errorDecoders toMsg -> f errorDecoders (\result -> Elm.apply toMsg [ result ]))


outerExpectBytesCustom :
    String
    -> (Elm.Expression -> (Elm.Expression -> Elm.Expression) -> Elm.Expression)
    -> Elm.Declare.Function (Elm.Expression -> Elm.Expression -> Elm.Expression)
outerExpectBytesCustom name f =
    Elm.Declare.fn2 name
        (Elm.Arg.varWith "errorDecoders"
            (Gen.Dict.annotation_.dict
                Gen.String.annotation_.string
                (Gen.Json.Decode.annotation_.decoder (Elm.Annotation.var "err"))
            )
        )
        (Elm.Arg.varWith "toMsg"
            (Elm.Annotation.function
                [ Elm.Annotation.result
                    (errorAnnotation Gen.Bytes.annotation_.bytes)
                    Gen.Bytes.annotation_.bytes
                ]
                (Elm.Annotation.var "msg")
            )
        )
        (\errorDecoders toMsg -> f errorDecoders (\result -> Elm.apply toMsg [ result ]))


innerExpectJsonCustom :
    Elm.Expression
    -> Elm.Expression
    ->
        { badUrl_ : Elm.Expression -> Elm.Expression
        , timeout_ : Elm.Expression
        , networkError_ : Elm.Expression
        , badStatus_ : Elm.Expression -> Elm.Expression -> Elm.Expression
        , goodStatus_ : Elm.Expression -> Elm.Expression -> Elm.Expression
        }
innerExpectJsonCustom errorDecoders successDecoder =
    innerExpect { isBytes = False }
        errorDecoders
        (\metadata body ->
            Elm.Case.result
                (Gen.Json.Decode.call_.decodeString successDecoder body)
                { err =
                    ( "_"
                    , \_ ->
                        Gen.Result.make_.err (error.make_.badBody metadata body)
                    )
                , ok = ( "res", Gen.Result.make_.ok )
                }
        )


innerExpectRawCustom :
    { isBytes : Bool }
    -> Elm.Expression
    ->
        { badUrl_ : Elm.Expression -> Elm.Expression
        , timeout_ : Elm.Expression
        , networkError_ : Elm.Expression
        , badStatus_ : Elm.Expression -> Elm.Expression -> Elm.Expression
        , goodStatus_ : Elm.Expression -> Elm.Expression -> Elm.Expression
        }
innerExpectRawCustom config errorDecoders =
    innerExpect config errorDecoders <| \_ body -> Gen.Result.make_.ok body


innerExpect :
    { isBytes : Bool }
    -> Elm.Expression
    -> (Elm.Expression -> Elm.Expression -> Elm.Expression)
    ->
        { badUrl_ : Elm.Expression -> Elm.Expression
        , timeout_ : Elm.Expression
        , networkError_ : Elm.Expression
        , badStatus_ : Elm.Expression -> Elm.Expression -> Elm.Expression
        , goodStatus_ : Elm.Expression -> Elm.Expression -> Elm.Expression
        }
innerExpect config errorDecoders goodStatus =
    { badUrl_ = \url -> Gen.Result.make_.err (error.make_.badUrl url)
    , timeout_ = Gen.Result.make_.err error.make_.timeout
    , networkError_ = Gen.Result.make_.err error.make_.networkError
    , badStatus_ =
        \metadata body ->
            Elm.Case.maybe
                (Gen.Dict.get (Gen.String.call_.fromInt (Elm.get "statusCode" metadata)) errorDecoders)
                { nothing =
                    Gen.Result.make_.err
                        (error.make_.unknownBadStatus metadata body)
                , just =
                    ( "err"
                    , \errorDecoder ->
                        Elm.Case.result
                            (Gen.Json.Decode.call_.decodeString errorDecoder
                                (if config.isBytes then
                                    bytesToString body

                                 else
                                    body
                                )
                            )
                            { ok =
                                ( "res"
                                , \x ->
                                    Gen.Result.make_.err
                                        (error.make_.knownBadStatus (Elm.get "statusCode" metadata) x)
                                )
                            , err =
                                ( "err"
                                , \_ ->
                                    Gen.Result.make_.err
                                        (error.make_.badErrorBody metadata body)
                                )
                            }
                    )
                }
    , goodStatus_ = goodStatus
    }


bytesToString : Elm.Expression -> Elm.Expression
bytesToString bytes =
    Gen.Bytes.Decode.decode (Gen.Bytes.Decode.call_.string (Gen.Bytes.width bytes)) bytes
        |> Gen.Maybe.withDefault (Elm.string "")
