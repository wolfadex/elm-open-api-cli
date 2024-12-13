module Gen.BackendTask.Http exposing
    ( moduleName_, get, getJson, post, expectString, expectJson
    , expectBytes, expectWhatever, request, emptyBody, stringBody, jsonBody, bytesBody
    , getWithOptions, withMetadata, annotation_, make_, caseOf_, call_, values_
    )

{-|
# Generated bindings for BackendTask.Http

@docs moduleName_, get, getJson, post, expectString, expectJson
@docs expectBytes, expectWhatever, request, emptyBody, stringBody, jsonBody
@docs bytesBody, getWithOptions, withMetadata, annotation_, make_, caseOf_
@docs call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "BackendTask", "Http" ]


{-| A simplified helper around [`BackendTask.Http.getWithOptions`](#getWithOptions), which builds up a GET request with
the default retries, timeout, and HTTP caching options. If you need to configure those options or include HTTP request headers,
use the more flexible `getWithOptions`.

    import BackendTask
    import BackendTask.Http
    import FatalError exposing (FatalError)

    getRequest : BackendTask (FatalError Error) String
    getRequest =
        BackendTask.Http.get
            "https://api.github.com/repos/dillonkearns/elm-pages"
            BackendTask.Http.expectString

get: 
    String
    -> BackendTask.Http.Expect a
    -> BackendTask.BackendTask { fatal : FatalError.FatalError
    , recoverable : BackendTask.Http.Error
    } a
-}
get : String -> Elm.Expression -> Elm.Expression
get getArg_ getArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Http" ]
             , name = "get"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "BackendTask", "Http" ]
                              "Expect"
                              [ Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.record
                                   [ ( "fatal"
                                     , Type.namedWith
                                         [ "FatalError" ]
                                         "FatalError"
                                         []
                                     )
                                   , ( "recoverable"
                                     , Type.namedWith
                                         [ "BackendTask", "Http" ]
                                         "Error"
                                         []
                                     )
                                   ]
                               , Type.var "a"
                               ]
                          )
                     )
             }
        )
        [ Elm.string getArg_, getArg_0 ]


{-| A simplified helper around [`BackendTask.Http.get`](#get), which builds up a BackendTask.Http GET request with `expectJson`.

    import BackendTask
    import BackendTask.Http
    import FatalError exposing (FatalError)
    import Json.Decode as Decode exposing (Decoder)

    getRequest : BackendTask (FatalError Error) Int
    getRequest =
        BackendTask.Http.getJson
            "https://api.github.com/repos/dillonkearns/elm-pages"
            (Decode.field "stargazers_count" Decode.int)

getJson: 
    String
    -> Json.Decode.Decoder a
    -> BackendTask.BackendTask { fatal : FatalError.FatalError
    , recoverable : BackendTask.Http.Error
    } a
-}
getJson : String -> Elm.Expression -> Elm.Expression
getJson getJsonArg_ getJsonArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Http" ]
             , name = "getJson"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.record
                                   [ ( "fatal"
                                     , Type.namedWith
                                         [ "FatalError" ]
                                         "FatalError"
                                         []
                                     )
                                   , ( "recoverable"
                                     , Type.namedWith
                                         [ "BackendTask", "Http" ]
                                         "Error"
                                         []
                                     )
                                   ]
                               , Type.var "a"
                               ]
                          )
                     )
             }
        )
        [ Elm.string getJsonArg_, getJsonArg_0 ]


{-| post: 
    String
    -> BackendTask.Http.Body
    -> BackendTask.Http.Expect a
    -> BackendTask.BackendTask { fatal : FatalError.FatalError
    , recoverable : BackendTask.Http.Error
    } a
-}
post : String -> Elm.Expression -> Elm.Expression -> Elm.Expression
post postArg_ postArg_0 postArg_1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Http" ]
             , name = "post"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "BackendTask", "Http" ] "Body" []
                          , Type.namedWith
                              [ "BackendTask", "Http" ]
                              "Expect"
                              [ Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.record
                                   [ ( "fatal"
                                     , Type.namedWith
                                         [ "FatalError" ]
                                         "FatalError"
                                         []
                                     )
                                   , ( "recoverable"
                                     , Type.namedWith
                                         [ "BackendTask", "Http" ]
                                         "Error"
                                         []
                                     )
                                   ]
                               , Type.var "a"
                               ]
                          )
                     )
             }
        )
        [ Elm.string postArg_, postArg_0, postArg_1 ]


{-| Gives the HTTP response body as a raw String.

    import BackendTask exposing (BackendTask)
    import BackendTask.Http

    request : BackendTask String
    request =
        BackendTask.Http.request
            { url = "https://example.com/file.txt"
            , method = "GET"
            , headers = []
            , body = BackendTask.Http.emptyBody
            }
            BackendTask.Http.expectString

expectString: BackendTask.Http.Expect String
-}
expectString : Elm.Expression
expectString =
    Elm.value
        { importFrom = [ "BackendTask", "Http" ]
        , name = "expectString"
        , annotation =
            Just
                (Type.namedWith
                     [ "BackendTask", "Http" ]
                     "Expect"
                     [ Type.string ]
                )
        }


{-| Handle the incoming response as JSON and don't optimize the asset and strip out unused values.
Be sure to use the `BackendTask.Http.request` function if you want an optimized request that
strips out unused JSON to optimize your asset size. This function makes sense to use for things like a GraphQL request
where the JSON payload is already trimmed down to the data you explicitly requested.

If the function you pass to `expectString` yields an `Err`, then you will get a build error that will
fail your `elm-pages` build and print out the String from the `Err`.

expectJson: Json.Decode.Decoder value -> BackendTask.Http.Expect value
-}
expectJson : Elm.Expression -> Elm.Expression
expectJson expectJsonArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Http" ]
             , name = "expectJson"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Http" ]
                               "Expect"
                               [ Type.var "value" ]
                          )
                     )
             }
        )
        [ expectJsonArg_ ]


{-| expectBytes: Bytes.Decode.Decoder value -> BackendTask.Http.Expect value -}
expectBytes : Elm.Expression -> Elm.Expression
expectBytes expectBytesArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Http" ]
             , name = "expectBytes"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Bytes", "Decode" ]
                              "Decoder"
                              [ Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Http" ]
                               "Expect"
                               [ Type.var "value" ]
                          )
                     )
             }
        )
        [ expectBytesArg_ ]


{-| expectWhatever: value -> BackendTask.Http.Expect value -}
expectWhatever : Elm.Expression -> Elm.Expression
expectWhatever expectWhateverArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Http" ]
             , name = "expectWhatever"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "value" ]
                          (Type.namedWith
                               [ "BackendTask", "Http" ]
                               "Expect"
                               [ Type.var "value" ]
                          )
                     )
             }
        )
        [ expectWhateverArg_ ]


{-| request: 
    { url : String
    , method : String
    , headers : List ( String, String )
    , body : BackendTask.Http.Body
    , retries : Maybe Int
    , timeoutInMs : Maybe Int
    }
    -> BackendTask.Http.Expect a
    -> BackendTask.BackendTask { fatal : FatalError.FatalError
    , recoverable : BackendTask.Http.Error
    } a
-}
request :
    { url : String
    , method : String
    , headers : List Elm.Expression
    , body : Elm.Expression
    , retries : Elm.Expression
    , timeoutInMs : Elm.Expression
    }
    -> Elm.Expression
    -> Elm.Expression
request requestArg_ requestArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Http" ]
             , name = "request"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "url", Type.string )
                              , ( "method", Type.string )
                              , ( "headers"
                                , Type.list (Type.tuple Type.string Type.string)
                                )
                              , ( "body"
                                , Type.namedWith
                                    [ "BackendTask", "Http" ]
                                    "Body"
                                    []
                                )
                              , ( "retries", Type.maybe Type.int )
                              , ( "timeoutInMs", Type.maybe Type.int )
                              ]
                          , Type.namedWith
                              [ "BackendTask", "Http" ]
                              "Expect"
                              [ Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.record
                                   [ ( "fatal"
                                     , Type.namedWith
                                         [ "FatalError" ]
                                         "FatalError"
                                         []
                                     )
                                   , ( "recoverable"
                                     , Type.namedWith
                                         [ "BackendTask", "Http" ]
                                         "Error"
                                         []
                                     )
                                   ]
                               , Type.var "a"
                               ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "url" (Elm.string requestArg_.url)
            , Tuple.pair "method" (Elm.string requestArg_.method)
            , Tuple.pair "headers" (Elm.list requestArg_.headers)
            , Tuple.pair "body" requestArg_.body
            , Tuple.pair "retries" requestArg_.retries
            , Tuple.pair "timeoutInMs" requestArg_.timeoutInMs
            ]
        , requestArg_0
        ]


{-| Build an empty body for a BackendTask.Http request. See [elm/http's `Http.emptyBody`](https://package.elm-lang.org/packages/elm/http/latest/Http#emptyBody).

emptyBody: BackendTask.Http.Body
-}
emptyBody : Elm.Expression
emptyBody =
    Elm.value
        { importFrom = [ "BackendTask", "Http" ]
        , name = "emptyBody"
        , annotation = Just (Type.namedWith [ "BackendTask", "Http" ] "Body" [])
        }


{-| Builds a string body for a BackendTask.Http request. See [elm/http's `Http.stringBody`](https://package.elm-lang.org/packages/elm/http/latest/Http#stringBody).

Note from the `elm/http` docs:

> The first argument is a [MIME type](https://en.wikipedia.org/wiki/Media_type) of the body. Some servers are strict about this!

stringBody: String -> String -> BackendTask.Http.Body
-}
stringBody : String -> String -> Elm.Expression
stringBody stringBodyArg_ stringBodyArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Http" ]
             , name = "stringBody"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string, Type.string ]
                          (Type.namedWith [ "BackendTask", "Http" ] "Body" [])
                     )
             }
        )
        [ Elm.string stringBodyArg_, Elm.string stringBodyArg_0 ]


{-| Builds a JSON body for a BackendTask.Http request. See [elm/http's `Http.jsonBody`](https://package.elm-lang.org/packages/elm/http/latest/Http#jsonBody).

jsonBody: Json.Encode.Value -> BackendTask.Http.Body
-}
jsonBody : Elm.Expression -> Elm.Expression
jsonBody jsonBodyArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Http" ]
             , name = "jsonBody"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Json", "Encode" ] "Value" [] ]
                          (Type.namedWith [ "BackendTask", "Http" ] "Body" [])
                     )
             }
        )
        [ jsonBodyArg_ ]


{-| Build a body from `Bytes` for a BackendTask.Http request. See [elm/http's `Http.bytesBody`](https://package.elm-lang.org/packages/elm/http/latest/Http#bytesBody).

bytesBody: String -> Bytes.Bytes -> BackendTask.Http.Body
-}
bytesBody : String -> Elm.Expression -> Elm.Expression
bytesBody bytesBodyArg_ bytesBodyArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Http" ]
             , name = "bytesBody"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string, Type.namedWith [ "Bytes" ] "Bytes" [] ]
                          (Type.namedWith [ "BackendTask", "Http" ] "Body" [])
                     )
             }
        )
        [ Elm.string bytesBodyArg_, bytesBodyArg_0 ]


{-| Perform a GET request, with some additional options for the HTTP request, including options for caching behavior.

  - `retries` - Default is 0. Will try performing request again if set to a number greater than 0.
  - `timeoutInMs` - Default is no timeout.
  - `cacheStrategy` - The [caching options are passed to the NPM package `make-fetch-happen`](https://github.com/npm/make-fetch-happen#opts-cache)
  - `cachePath` - override the default directory for the local HTTP cache. This can be helpful if you want more granular control to clear some HTTP caches more or less frequently than others. Or you may want to preserve the local cache for some requests in your build server, but not store the cache for other requests.

getWithOptions: 
    { url : String
    , expect : BackendTask.Http.Expect a
    , headers : List ( String, String )
    , cacheStrategy : Maybe BackendTask.Http.CacheStrategy
    , retries : Maybe Int
    , timeoutInMs : Maybe Int
    , cachePath : Maybe String
    }
    -> BackendTask.BackendTask { fatal : FatalError.FatalError
    , recoverable : BackendTask.Http.Error
    } a
-}
getWithOptions :
    { url : String
    , expect : Elm.Expression
    , headers : List Elm.Expression
    , cacheStrategy : Elm.Expression
    , retries : Elm.Expression
    , timeoutInMs : Elm.Expression
    , cachePath : Elm.Expression
    }
    -> Elm.Expression
getWithOptions getWithOptionsArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Http" ]
             , name = "getWithOptions"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "url", Type.string )
                              , ( "expect"
                                , Type.namedWith
                                    [ "BackendTask", "Http" ]
                                    "Expect"
                                    [ Type.var "a" ]
                                )
                              , ( "headers"
                                , Type.list (Type.tuple Type.string Type.string)
                                )
                              , ( "cacheStrategy"
                                , Type.maybe
                                    (Type.namedWith
                                       [ "BackendTask", "Http" ]
                                       "CacheStrategy"
                                       []
                                    )
                                )
                              , ( "retries", Type.maybe Type.int )
                              , ( "timeoutInMs", Type.maybe Type.int )
                              , ( "cachePath", Type.maybe Type.string )
                              ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.record
                                   [ ( "fatal"
                                     , Type.namedWith
                                         [ "FatalError" ]
                                         "FatalError"
                                         []
                                     )
                                   , ( "recoverable"
                                     , Type.namedWith
                                         [ "BackendTask", "Http" ]
                                         "Error"
                                         []
                                     )
                                   ]
                               , Type.var "a"
                               ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "url" (Elm.string getWithOptionsArg_.url)
            , Tuple.pair "expect" getWithOptionsArg_.expect
            , Tuple.pair "headers" (Elm.list getWithOptionsArg_.headers)
            , Tuple.pair "cacheStrategy" getWithOptionsArg_.cacheStrategy
            , Tuple.pair "retries" getWithOptionsArg_.retries
            , Tuple.pair "timeoutInMs" getWithOptionsArg_.timeoutInMs
            , Tuple.pair "cachePath" getWithOptionsArg_.cachePath
            ]
        ]


{-| withMetadata: 
    (BackendTask.Http.Metadata -> value -> combined)
    -> BackendTask.Http.Expect value
    -> BackendTask.Http.Expect combined
-}
withMetadata :
    (Elm.Expression -> Elm.Expression -> Elm.Expression)
    -> Elm.Expression
    -> Elm.Expression
withMetadata withMetadataArg_ withMetadataArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Http" ]
             , name = "withMetadata"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.namedWith
                                    [ "BackendTask", "Http" ]
                                    "Metadata"
                                    []
                              , Type.var "value"
                              ]
                              (Type.var "combined")
                          , Type.namedWith
                              [ "BackendTask", "Http" ]
                              "Expect"
                              [ Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Http" ]
                               "Expect"
                               [ Type.var "combined" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "withMetadataUnpack"
            (\functionReducedUnpack ->
               Elm.functionReduced
                   "unpack"
                   (withMetadataArg_ functionReducedUnpack)
            )
        , withMetadataArg_0
        ]


annotation_ :
    { expect : Type.Annotation -> Type.Annotation
    , error : Type.Annotation
    , body : Type.Annotation
    , cacheStrategy : Type.Annotation
    , metadata : Type.Annotation
    }
annotation_ =
    { expect =
        \expectArg0 ->
            Type.namedWith [ "BackendTask", "Http" ] "Expect" [ expectArg0 ]
    , error = Type.namedWith [ "BackendTask", "Http" ] "Error" []
    , body =
        Type.alias
            moduleName_
            "Body"
            []
            (Type.namedWith [ "Pages", "Internal", "StaticHttpBody" ] "Body" [])
    , cacheStrategy =
        Type.namedWith [ "BackendTask", "Http" ] "CacheStrategy" []
    , metadata =
        Type.alias
            moduleName_
            "Metadata"
            []
            (Type.record
                 [ ( "url", Type.string )
                 , ( "statusCode", Type.int )
                 , ( "statusText", Type.string )
                 , ( "headers"
                   , Type.namedWith
                         [ "Dict" ]
                         "Dict"
                         [ Type.string, Type.string ]
                   )
                 ]
            )
    }


make_ :
    { badUrl : Elm.Expression -> Elm.Expression
    , timeout : Elm.Expression
    , networkError : Elm.Expression
    , badStatus : Elm.Expression -> Elm.Expression -> Elm.Expression
    , badBody : Elm.Expression -> Elm.Expression -> Elm.Expression
    , ignoreCache : Elm.Expression
    , forceRevalidate : Elm.Expression
    , forceReload : Elm.Expression
    , forceCache : Elm.Expression
    , errorUnlessCached : Elm.Expression
    , metadata :
        { url : Elm.Expression
        , statusCode : Elm.Expression
        , statusText : Elm.Expression
        , headers : Elm.Expression
        }
        -> Elm.Expression
    }
make_ =
    { badUrl =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Http" ]
                     , name = "BadUrl"
                     , annotation = Just (Type.namedWith [] "Error" [])
                     }
                )
                [ ar0 ]
    , timeout =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "Timeout"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , networkError =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "NetworkError"
            , annotation = Just (Type.namedWith [] "Error" [])
            }
    , badStatus =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Http" ]
                     , name = "BadStatus"
                     , annotation = Just (Type.namedWith [] "Error" [])
                     }
                )
                [ ar0, ar1 ]
    , badBody =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Http" ]
                     , name = "BadBody"
                     , annotation = Just (Type.namedWith [] "Error" [])
                     }
                )
                [ ar0, ar1 ]
    , ignoreCache =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "IgnoreCache"
            , annotation = Just (Type.namedWith [] "CacheStrategy" [])
            }
    , forceRevalidate =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "ForceRevalidate"
            , annotation = Just (Type.namedWith [] "CacheStrategy" [])
            }
    , forceReload =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "ForceReload"
            , annotation = Just (Type.namedWith [] "CacheStrategy" [])
            }
    , forceCache =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "ForceCache"
            , annotation = Just (Type.namedWith [] "CacheStrategy" [])
            }
    , errorUnlessCached =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "ErrorUnlessCached"
            , annotation = Just (Type.namedWith [] "CacheStrategy" [])
            }
    , metadata =
        \metadata_args ->
            Elm.withType
                (Type.alias
                     [ "BackendTask", "Http" ]
                     "Metadata"
                     []
                     (Type.record
                          [ ( "url", Type.string )
                          , ( "statusCode", Type.int )
                          , ( "statusText", Type.string )
                          , ( "headers"
                            , Type.namedWith
                                  [ "Dict" ]
                                  "Dict"
                                  [ Type.string, Type.string ]
                            )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "url" metadata_args.url
                     , Tuple.pair "statusCode" metadata_args.statusCode
                     , Tuple.pair "statusText" metadata_args.statusText
                     , Tuple.pair "headers" metadata_args.headers
                     ]
                )
    }


caseOf_ =
    { error =
        \errorExpression errorTags ->
            Elm.Case.custom
                errorExpression
                (Type.namedWith [ "BackendTask", "Http" ] "Error" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "BadUrl"
                       errorTags.badUrl |> Elm.Arg.item
                                                 (Elm.Arg.varWith
                                                        "arg_0"
                                                        Type.string
                                                 )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "Timeout" errorTags.timeout)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "NetworkError" errorTags.networkError)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "BadStatus"
                       errorTags.badStatus |> Elm.Arg.item
                                                    (Elm.Arg.varWith
                                                           "backendTaskHttpMetadata"
                                                           (Type.namedWith
                                                                  [ "BackendTask"
                                                                  , "Http"
                                                                  ]
                                                                  "Metadata"
                                                                  []
                                                           )
                                                    ) |> Elm.Arg.item
                                                               (Elm.Arg.varWith
                                                                      "arg_1"
                                                                      Type.string
                                                               )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "BadBody"
                       errorTags.badBody |> Elm.Arg.item
                                                  (Elm.Arg.varWith
                                                         "maybeMaybe"
                                                         (Type.maybe
                                                                (Type.namedWith
                                                                       [ "Json"
                                                                       , "Decode"
                                                                       ]
                                                                       "Error"
                                                                       []
                                                                )
                                                         )
                                                  ) |> Elm.Arg.item
                                                             (Elm.Arg.varWith
                                                                    "arg_1"
                                                                    Type.string
                                                             )
                    )
                    Basics.identity
                ]
    , cacheStrategy =
        \cacheStrategyExpression cacheStrategyTags ->
            Elm.Case.custom
                cacheStrategyExpression
                (Type.namedWith [ "BackendTask", "Http" ] "CacheStrategy" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "IgnoreCache"
                       cacheStrategyTags.ignoreCache
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ForceRevalidate"
                       cacheStrategyTags.forceRevalidate
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ForceReload"
                       cacheStrategyTags.forceReload
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ForceCache"
                       cacheStrategyTags.forceCache
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "ErrorUnlessCached"
                       cacheStrategyTags.errorUnlessCached
                    )
                    Basics.identity
                ]
    }


call_ :
    { get : Elm.Expression -> Elm.Expression -> Elm.Expression
    , getJson : Elm.Expression -> Elm.Expression -> Elm.Expression
    , post :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , expectJson : Elm.Expression -> Elm.Expression
    , expectBytes : Elm.Expression -> Elm.Expression
    , expectWhatever : Elm.Expression -> Elm.Expression
    , request : Elm.Expression -> Elm.Expression -> Elm.Expression
    , stringBody : Elm.Expression -> Elm.Expression -> Elm.Expression
    , jsonBody : Elm.Expression -> Elm.Expression
    , bytesBody : Elm.Expression -> Elm.Expression -> Elm.Expression
    , getWithOptions : Elm.Expression -> Elm.Expression
    , withMetadata : Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { get =
        \getArg_ getArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Http" ]
                     , name = "get"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "BackendTask", "Http" ]
                                      "Expect"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.record
                                           [ ( "fatal"
                                             , Type.namedWith
                                                 [ "FatalError" ]
                                                 "FatalError"
                                                 []
                                             )
                                           , ( "recoverable"
                                             , Type.namedWith
                                                 [ "BackendTask", "Http" ]
                                                 "Error"
                                                 []
                                             )
                                           ]
                                       , Type.var "a"
                                       ]
                                  )
                             )
                     }
                )
                [ getArg_, getArg_0 ]
    , getJson =
        \getJsonArg_ getJsonArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Http" ]
                     , name = "getJson"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Decoder"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.record
                                           [ ( "fatal"
                                             , Type.namedWith
                                                 [ "FatalError" ]
                                                 "FatalError"
                                                 []
                                             )
                                           , ( "recoverable"
                                             , Type.namedWith
                                                 [ "BackendTask", "Http" ]
                                                 "Error"
                                                 []
                                             )
                                           ]
                                       , Type.var "a"
                                       ]
                                  )
                             )
                     }
                )
                [ getJsonArg_, getJsonArg_0 ]
    , post =
        \postArg_ postArg_0 postArg_1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Http" ]
                     , name = "post"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "BackendTask", "Http" ]
                                      "Body"
                                      []
                                  , Type.namedWith
                                      [ "BackendTask", "Http" ]
                                      "Expect"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.record
                                           [ ( "fatal"
                                             , Type.namedWith
                                                 [ "FatalError" ]
                                                 "FatalError"
                                                 []
                                             )
                                           , ( "recoverable"
                                             , Type.namedWith
                                                 [ "BackendTask", "Http" ]
                                                 "Error"
                                                 []
                                             )
                                           ]
                                       , Type.var "a"
                                       ]
                                  )
                             )
                     }
                )
                [ postArg_, postArg_0, postArg_1 ]
    , expectJson =
        \expectJsonArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Http" ]
                     , name = "expectJson"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Decoder"
                                      [ Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Http" ]
                                       "Expect"
                                       [ Type.var "value" ]
                                  )
                             )
                     }
                )
                [ expectJsonArg_ ]
    , expectBytes =
        \expectBytesArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Http" ]
                     , name = "expectBytes"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Bytes", "Decode" ]
                                      "Decoder"
                                      [ Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Http" ]
                                       "Expect"
                                       [ Type.var "value" ]
                                  )
                             )
                     }
                )
                [ expectBytesArg_ ]
    , expectWhatever =
        \expectWhateverArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Http" ]
                     , name = "expectWhatever"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "value" ]
                                  (Type.namedWith
                                       [ "BackendTask", "Http" ]
                                       "Expect"
                                       [ Type.var "value" ]
                                  )
                             )
                     }
                )
                [ expectWhateverArg_ ]
    , request =
        \requestArg_ requestArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Http" ]
                     , name = "request"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "url", Type.string )
                                      , ( "method", Type.string )
                                      , ( "headers"
                                        , Type.list
                                            (Type.tuple Type.string Type.string)
                                        )
                                      , ( "body"
                                        , Type.namedWith
                                            [ "BackendTask", "Http" ]
                                            "Body"
                                            []
                                        )
                                      , ( "retries", Type.maybe Type.int )
                                      , ( "timeoutInMs", Type.maybe Type.int )
                                      ]
                                  , Type.namedWith
                                      [ "BackendTask", "Http" ]
                                      "Expect"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.record
                                           [ ( "fatal"
                                             , Type.namedWith
                                                 [ "FatalError" ]
                                                 "FatalError"
                                                 []
                                             )
                                           , ( "recoverable"
                                             , Type.namedWith
                                                 [ "BackendTask", "Http" ]
                                                 "Error"
                                                 []
                                             )
                                           ]
                                       , Type.var "a"
                                       ]
                                  )
                             )
                     }
                )
                [ requestArg_, requestArg_0 ]
    , stringBody =
        \stringBodyArg_ stringBodyArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Http" ]
                     , name = "stringBody"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string, Type.string ]
                                  (Type.namedWith
                                       [ "BackendTask", "Http" ]
                                       "Body"
                                       []
                                  )
                             )
                     }
                )
                [ stringBodyArg_, stringBodyArg_0 ]
    , jsonBody =
        \jsonBodyArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Http" ]
                     , name = "jsonBody"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Json", "Encode" ]
                                      "Value"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Http" ]
                                       "Body"
                                       []
                                  )
                             )
                     }
                )
                [ jsonBodyArg_ ]
    , bytesBody =
        \bytesBodyArg_ bytesBodyArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Http" ]
                     , name = "bytesBody"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith [ "Bytes" ] "Bytes" []
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Http" ]
                                       "Body"
                                       []
                                  )
                             )
                     }
                )
                [ bytesBodyArg_, bytesBodyArg_0 ]
    , getWithOptions =
        \getWithOptionsArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Http" ]
                     , name = "getWithOptions"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.record
                                      [ ( "url", Type.string )
                                      , ( "expect"
                                        , Type.namedWith
                                            [ "BackendTask", "Http" ]
                                            "Expect"
                                            [ Type.var "a" ]
                                        )
                                      , ( "headers"
                                        , Type.list
                                            (Type.tuple Type.string Type.string)
                                        )
                                      , ( "cacheStrategy"
                                        , Type.maybe
                                            (Type.namedWith
                                               [ "BackendTask", "Http" ]
                                               "CacheStrategy"
                                               []
                                            )
                                        )
                                      , ( "retries", Type.maybe Type.int )
                                      , ( "timeoutInMs", Type.maybe Type.int )
                                      , ( "cachePath", Type.maybe Type.string )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.record
                                           [ ( "fatal"
                                             , Type.namedWith
                                                 [ "FatalError" ]
                                                 "FatalError"
                                                 []
                                             )
                                           , ( "recoverable"
                                             , Type.namedWith
                                                 [ "BackendTask", "Http" ]
                                                 "Error"
                                                 []
                                             )
                                           ]
                                       , Type.var "a"
                                       ]
                                  )
                             )
                     }
                )
                [ getWithOptionsArg_ ]
    , withMetadata =
        \withMetadataArg_ withMetadataArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Http" ]
                     , name = "withMetadata"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.namedWith
                                            [ "BackendTask", "Http" ]
                                            "Metadata"
                                            []
                                      , Type.var "value"
                                      ]
                                      (Type.var "combined")
                                  , Type.namedWith
                                      [ "BackendTask", "Http" ]
                                      "Expect"
                                      [ Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Http" ]
                                       "Expect"
                                       [ Type.var "combined" ]
                                  )
                             )
                     }
                )
                [ withMetadataArg_, withMetadataArg_0 ]
    }


values_ :
    { get : Elm.Expression
    , getJson : Elm.Expression
    , post : Elm.Expression
    , expectString : Elm.Expression
    , expectJson : Elm.Expression
    , expectBytes : Elm.Expression
    , expectWhatever : Elm.Expression
    , request : Elm.Expression
    , emptyBody : Elm.Expression
    , stringBody : Elm.Expression
    , jsonBody : Elm.Expression
    , bytesBody : Elm.Expression
    , getWithOptions : Elm.Expression
    , withMetadata : Elm.Expression
    }
values_ =
    { get =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "get"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "BackendTask", "Http" ]
                             "Expect"
                             [ Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.record
                                  [ ( "fatal"
                                    , Type.namedWith
                                        [ "FatalError" ]
                                        "FatalError"
                                        []
                                    )
                                  , ( "recoverable"
                                    , Type.namedWith
                                        [ "BackendTask", "Http" ]
                                        "Error"
                                        []
                                    )
                                  ]
                              , Type.var "a"
                              ]
                         )
                    )
            }
    , getJson =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "getJson"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith
                             [ "Json", "Decode" ]
                             "Decoder"
                             [ Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.record
                                  [ ( "fatal"
                                    , Type.namedWith
                                        [ "FatalError" ]
                                        "FatalError"
                                        []
                                    )
                                  , ( "recoverable"
                                    , Type.namedWith
                                        [ "BackendTask", "Http" ]
                                        "Error"
                                        []
                                    )
                                  ]
                              , Type.var "a"
                              ]
                         )
                    )
            }
    , post =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "post"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "BackendTask", "Http" ] "Body" []
                         , Type.namedWith
                             [ "BackendTask", "Http" ]
                             "Expect"
                             [ Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.record
                                  [ ( "fatal"
                                    , Type.namedWith
                                        [ "FatalError" ]
                                        "FatalError"
                                        []
                                    )
                                  , ( "recoverable"
                                    , Type.namedWith
                                        [ "BackendTask", "Http" ]
                                        "Error"
                                        []
                                    )
                                  ]
                              , Type.var "a"
                              ]
                         )
                    )
            }
    , expectString =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "expectString"
            , annotation =
                Just
                    (Type.namedWith
                         [ "BackendTask", "Http" ]
                         "Expect"
                         [ Type.string ]
                    )
            }
    , expectJson =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "expectJson"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Json", "Decode" ]
                             "Decoder"
                             [ Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Http" ]
                              "Expect"
                              [ Type.var "value" ]
                         )
                    )
            }
    , expectBytes =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "expectBytes"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Bytes", "Decode" ]
                             "Decoder"
                             [ Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Http" ]
                              "Expect"
                              [ Type.var "value" ]
                         )
                    )
            }
    , expectWhatever =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "expectWhatever"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "value" ]
                         (Type.namedWith
                              [ "BackendTask", "Http" ]
                              "Expect"
                              [ Type.var "value" ]
                         )
                    )
            }
    , request =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "request"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "url", Type.string )
                             , ( "method", Type.string )
                             , ( "headers"
                               , Type.list (Type.tuple Type.string Type.string)
                               )
                             , ( "body"
                               , Type.namedWith
                                   [ "BackendTask", "Http" ]
                                   "Body"
                                   []
                               )
                             , ( "retries", Type.maybe Type.int )
                             , ( "timeoutInMs", Type.maybe Type.int )
                             ]
                         , Type.namedWith
                             [ "BackendTask", "Http" ]
                             "Expect"
                             [ Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.record
                                  [ ( "fatal"
                                    , Type.namedWith
                                        [ "FatalError" ]
                                        "FatalError"
                                        []
                                    )
                                  , ( "recoverable"
                                    , Type.namedWith
                                        [ "BackendTask", "Http" ]
                                        "Error"
                                        []
                                    )
                                  ]
                              , Type.var "a"
                              ]
                         )
                    )
            }
    , emptyBody =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "emptyBody"
            , annotation =
                Just (Type.namedWith [ "BackendTask", "Http" ] "Body" [])
            }
    , stringBody =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "stringBody"
            , annotation =
                Just
                    (Type.function
                         [ Type.string, Type.string ]
                         (Type.namedWith [ "BackendTask", "Http" ] "Body" [])
                    )
            }
    , jsonBody =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "jsonBody"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Json", "Encode" ] "Value" [] ]
                         (Type.namedWith [ "BackendTask", "Http" ] "Body" [])
                    )
            }
    , bytesBody =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "bytesBody"
            , annotation =
                Just
                    (Type.function
                         [ Type.string, Type.namedWith [ "Bytes" ] "Bytes" [] ]
                         (Type.namedWith [ "BackendTask", "Http" ] "Body" [])
                    )
            }
    , getWithOptions =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "getWithOptions"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "url", Type.string )
                             , ( "expect"
                               , Type.namedWith
                                   [ "BackendTask", "Http" ]
                                   "Expect"
                                   [ Type.var "a" ]
                               )
                             , ( "headers"
                               , Type.list (Type.tuple Type.string Type.string)
                               )
                             , ( "cacheStrategy"
                               , Type.maybe
                                   (Type.namedWith
                                      [ "BackendTask", "Http" ]
                                      "CacheStrategy"
                                      []
                                   )
                               )
                             , ( "retries", Type.maybe Type.int )
                             , ( "timeoutInMs", Type.maybe Type.int )
                             , ( "cachePath", Type.maybe Type.string )
                             ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.record
                                  [ ( "fatal"
                                    , Type.namedWith
                                        [ "FatalError" ]
                                        "FatalError"
                                        []
                                    )
                                  , ( "recoverable"
                                    , Type.namedWith
                                        [ "BackendTask", "Http" ]
                                        "Error"
                                        []
                                    )
                                  ]
                              , Type.var "a"
                              ]
                         )
                    )
            }
    , withMetadata =
        Elm.value
            { importFrom = [ "BackendTask", "Http" ]
            , name = "withMetadata"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.namedWith
                                   [ "BackendTask", "Http" ]
                                   "Metadata"
                                   []
                             , Type.var "value"
                             ]
                             (Type.var "combined")
                         , Type.namedWith
                             [ "BackendTask", "Http" ]
                             "Expect"
                             [ Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Http" ]
                              "Expect"
                              [ Type.var "combined" ]
                         )
                    )
            }
    }