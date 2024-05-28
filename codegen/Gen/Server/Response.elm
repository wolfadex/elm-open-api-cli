module Gen.Server.Response exposing (annotation_, base64Body, body, bytesBody, call_, emptyBody, errorPage, json, map, mapError, moduleName_, permanentRedirect, plainText, render, temporaryRedirect, toJson, values_, withHeader, withHeaders, withSetCookieHeader, withStatusCode)

{-| 
@docs moduleName_, render, map, errorPage, mapError, temporaryRedirect, permanentRedirect, json, plainText, emptyBody, body, bytesBody, base64Body, withHeader, withHeaders, withStatusCode, withSetCookieHeader, toJson, annotation_, call_, values_
-}


import Elm
import Elm.Annotation as Type


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Server", "Response" ]


{-| Render the Route Module with the supplied data. Used for both the `data` and `action` functions in a server-rendered Route Module.

    Response.render project

render: data -> Server.Response.Response data error
-}
render : Elm.Expression -> Elm.Expression
render renderArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Response" ]
             , name = "render"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "data" ]
                          (Type.namedWith
                               [ "Server", "Response" ]
                               "Response"
                               [ Type.var "data", Type.var "error" ]
                          )
                     )
             }
        )
        [ renderArg ]


{-| Maps the `data` for a Render response. Usually not needed, but always good to have the option.

map: 
    (data -> mappedData)
    -> Server.Response.Response data error
    -> Server.Response.Response mappedData error
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg mapArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Response" ]
             , name = "map"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "data" ]
                              (Type.var "mappedData")
                          , Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "error" ]
                          ]
                          (Type.namedWith
                               [ "Server", "Response" ]
                               "Response"
                               [ Type.var "mappedData", Type.var "error" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapUnpack" mapArg, mapArg0 ]


{-| Instead of rendering the current Route Module, you can render an `ErrorPage` such as a 404 page or a 500 error page.

[Read more about Error Pages](https://elm-pages.com/docs/error-pages) to learn about
defining and rendering your custom ErrorPage type.

errorPage: errorPage -> Server.Response.Response data errorPage
-}
errorPage : Elm.Expression -> Elm.Expression
errorPage errorPageArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Response" ]
             , name = "errorPage"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "errorPage" ]
                          (Type.namedWith
                               [ "Server", "Response" ]
                               "Response"
                               [ Type.var "data", Type.var "errorPage" ]
                          )
                     )
             }
        )
        [ errorPageArg ]


{-| Maps the `error` for an ErrorPage response. Usually not needed, but always good to have the option.

mapError: 
    (errorPage -> mappedErrorPage)
    -> Server.Response.Response data errorPage
    -> Server.Response.Response data mappedErrorPage
-}
mapError :
    (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
mapError mapErrorArg mapErrorArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Response" ]
             , name = "mapError"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.var "errorPage" ]
                              (Type.var "mappedErrorPage")
                          , Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "errorPage" ]
                          ]
                          (Type.namedWith
                               [ "Server", "Response" ]
                               "Response"
                               [ Type.var "data", Type.var "mappedErrorPage" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapErrorUnpack" mapErrorArg, mapErrorArg0 ]


{-| temporaryRedirect: String -> Server.Response.Response data error -}
temporaryRedirect : String -> Elm.Expression
temporaryRedirect temporaryRedirectArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Response" ]
             , name = "temporaryRedirect"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "Server", "Response" ]
                               "Response"
                               [ Type.var "data", Type.var "error" ]
                          )
                     )
             }
        )
        [ Elm.string temporaryRedirectArg ]


{-| Build a 308 permanent redirect response.

Permanent redirects tell the browser that a resource has permanently moved. If you redirect because a user is not logged in,
then you **do not** want to use a permanent redirect because the page they are looking for hasn't changed, you are just
temporarily pointing them to a new page since they need to authenticate.

Permanent redirects are aggressively cached so be careful not to use them when you mean to use temporary redirects instead.

If you need to specifically rely on a 301 permanent redirect (see <https://stackoverflow.com/a/42138726> on the difference between 301 and 308),
use `customResponse` instead.

permanentRedirect: String -> Server.Response.Response data error
-}
permanentRedirect : String -> Elm.Expression
permanentRedirect permanentRedirectArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Response" ]
             , name = "permanentRedirect"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "Server", "Response" ]
                               "Response"
                               [ Type.var "data", Type.var "error" ]
                          )
                     )
             }
        )
        [ Elm.string permanentRedirectArg ]


{-| Build a JSON body from a `Json.Encode.Value`.

    Json.Encode.object
        [ ( "message", Json.Encode.string "Hello" ) ]
        |> Response.json

Sets the `Content-Type` to `application/json`.

json: Json.Encode.Value -> Server.Response.Response data error
-}
json : Elm.Expression -> Elm.Expression
json jsonArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Response" ]
             , name = "json"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Json", "Encode" ] "Value" [] ]
                          (Type.namedWith
                               [ "Server", "Response" ]
                               "Response"
                               [ Type.var "data", Type.var "error" ]
                          )
                     )
             }
        )
        [ jsonArg ]


{-| Build a `Response` with a String body. Sets the `Content-Type` to `text/plain`.

    Response.plainText "Hello"

plainText: String -> Server.Response.Response data error
-}
plainText : String -> Elm.Expression
plainText plainTextArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Response" ]
             , name = "plainText"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "Server", "Response" ]
                               "Response"
                               [ Type.var "data", Type.var "error" ]
                          )
                     )
             }
        )
        [ Elm.string plainTextArg ]


{-| Build a `Response` with no HTTP response body.

emptyBody: Server.Response.Response data error
-}
emptyBody : Elm.Expression
emptyBody =
    Elm.value
        { importFrom = [ "Server", "Response" ]
        , name = "emptyBody"
        , annotation =
            Just
                (Type.namedWith
                     [ "Server", "Response" ]
                     "Response"
                     [ Type.var "data", Type.var "error" ]
                )
        }


{-| Same as [`plainText`](#plainText), but doesn't set a `Content-Type`.

body: String -> Server.Response.Response data error
-}
body : String -> Elm.Expression
body bodyArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Response" ]
             , name = "body"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "Server", "Response" ]
                               "Response"
                               [ Type.var "data", Type.var "error" ]
                          )
                     )
             }
        )
        [ Elm.string bodyArg ]


{-| Build a `Response` with a `Bytes`.

Under the hood, it will be converted to a base64 encoded String with `isBase64Encoded = True`.
Your adapter will need to handle `isBase64Encoded` to turn it into the appropriate response.

bytesBody: Bytes.Bytes -> Server.Response.Response data error
-}
bytesBody : Elm.Expression -> Elm.Expression
bytesBody bytesBodyArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Response" ]
             , name = "bytesBody"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Bytes" ] "Bytes" [] ]
                          (Type.namedWith
                               [ "Server", "Response" ]
                               "Response"
                               [ Type.var "data", Type.var "error" ]
                          )
                     )
             }
        )
        [ bytesBodyArg ]


{-| Build a `Response` with a String that should represent a base64 encoded value.

Your adapter will need to handle `isBase64Encoded` to turn it into the appropriate response.

    Response.base64Body "SGVsbG8gV29ybGQ="

base64Body: String -> Server.Response.Response data error
-}
base64Body : String -> Elm.Expression
base64Body base64BodyArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Response" ]
             , name = "base64Body"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "Server", "Response" ]
                               "Response"
                               [ Type.var "data", Type.var "error" ]
                          )
                     )
             }
        )
        [ Elm.string base64BodyArg ]


{-| Add a header to the response.

    Response.plainText "Hello!"
        -- allow CORS requests
        |> Response.withHeader "Access-Control-Allow-Origin" "*"
        |> Response.withHeader "Access-Control-Allow-Methods" "GET, POST, OPTIONS"

withHeader: 
    String
    -> String
    -> Server.Response.Response data error
    -> Server.Response.Response data error
-}
withHeader : String -> String -> Elm.Expression -> Elm.Expression
withHeader withHeaderArg withHeaderArg0 withHeaderArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Response" ]
             , name = "withHeader"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.string
                          , Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "error" ]
                          ]
                          (Type.namedWith
                               [ "Server", "Response" ]
                               "Response"
                               [ Type.var "data", Type.var "error" ]
                          )
                     )
             }
        )
        [ Elm.string withHeaderArg, Elm.string withHeaderArg0, withHeaderArg1 ]


{-| Same as [`withHeader`](#withHeader), but allows you to add multiple headers at once.

    Response.plainText "Hello!"
        -- allow CORS requests
        |> Response.withHeaders
            [ ( "Access-Control-Allow-Origin", "*" )
            , ( "Access-Control-Allow-Methods", "GET, POST, OPTIONS" )
            ]

withHeaders: 
    List ( String, String )
    -> Server.Response.Response data error
    -> Server.Response.Response data error
-}
withHeaders : List Elm.Expression -> Elm.Expression -> Elm.Expression
withHeaders withHeadersArg withHeadersArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Response" ]
             , name = "withHeaders"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list (Type.tuple Type.string Type.string)
                          , Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "error" ]
                          ]
                          (Type.namedWith
                               [ "Server", "Response" ]
                               "Response"
                               [ Type.var "data", Type.var "error" ]
                          )
                     )
             }
        )
        [ Elm.list withHeadersArg, withHeadersArg0 ]


{-| Set the [HTTP Response status code](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status) for the `Response`.

    Response.plainText "Not Authorized"
        |> Response.withStatusCode 401

withStatusCode: 
    Int
    -> Server.Response.Response data Basics.Never
    -> Server.Response.Response data Basics.Never
-}
withStatusCode : Int -> Elm.Expression -> Elm.Expression
withStatusCode withStatusCodeArg withStatusCodeArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Response" ]
             , name = "withStatusCode"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data"
                              , Type.namedWith [ "Basics" ] "Never" []
                              ]
                          ]
                          (Type.namedWith
                               [ "Server", "Response" ]
                               "Response"
                               [ Type.var "data"
                               , Type.namedWith [ "Basics" ] "Never" []
                               ]
                          )
                     )
             }
        )
        [ Elm.int withStatusCodeArg, withStatusCodeArg0 ]


{-| Set a [`Server.SetCookie`](Server-SetCookie) value on the response.

The easiest way to manage cookies in your Routes is through the [`Server.Session`](Server-Session) API, but this
provides a more granular way to set cookies.

withSetCookieHeader: 
    Server.SetCookie.SetCookie
    -> Server.Response.Response data error
    -> Server.Response.Response data error
-}
withSetCookieHeader : Elm.Expression -> Elm.Expression -> Elm.Expression
withSetCookieHeader withSetCookieHeaderArg withSetCookieHeaderArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Response" ]
             , name = "withSetCookieHeader"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Server", "SetCookie" ]
                              "SetCookie"
                              []
                          , Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "error" ]
                          ]
                          (Type.namedWith
                               [ "Server", "Response" ]
                               "Response"
                               [ Type.var "data", Type.var "error" ]
                          )
                     )
             }
        )
        [ withSetCookieHeaderArg, withSetCookieHeaderArg0 ]


{-| For internal use or more advanced use cases for meta frameworks.

toJson: Server.Response.Response Basics.Never Basics.Never -> Json.Encode.Value
-}
toJson : Elm.Expression -> Elm.Expression
toJson toJsonArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Response" ]
             , name = "toJson"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.namedWith [ "Basics" ] "Never" []
                              , Type.namedWith [ "Basics" ] "Never" []
                              ]
                          ]
                          (Type.namedWith [ "Json", "Encode" ] "Value" [])
                     )
             }
        )
        [ toJsonArg ]


annotation_ :
    { response : Type.Annotation -> Type.Annotation -> Type.Annotation }
annotation_ =
    { response =
        \responseArg0 responseArg1 ->
            Type.alias
                moduleName_
                "Response"
                [ responseArg0, responseArg1 ]
                (Type.namedWith
                     [ "PageServerResponse" ]
                     "PageServerResponse"
                     [ Type.var "data", Type.var "error" ]
                )
    }


call_ :
    { render : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , errorPage : Elm.Expression -> Elm.Expression
    , mapError : Elm.Expression -> Elm.Expression -> Elm.Expression
    , temporaryRedirect : Elm.Expression -> Elm.Expression
    , permanentRedirect : Elm.Expression -> Elm.Expression
    , json : Elm.Expression -> Elm.Expression
    , plainText : Elm.Expression -> Elm.Expression
    , body : Elm.Expression -> Elm.Expression
    , bytesBody : Elm.Expression -> Elm.Expression
    , base64Body : Elm.Expression -> Elm.Expression
    , withHeader :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , withHeaders : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withStatusCode : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withSetCookieHeader : Elm.Expression -> Elm.Expression -> Elm.Expression
    , toJson : Elm.Expression -> Elm.Expression
    }
call_ =
    { render =
        \renderArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Response" ]
                     , name = "render"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "data" ]
                                  (Type.namedWith
                                       [ "Server", "Response" ]
                                       "Response"
                                       [ Type.var "data", Type.var "error" ]
                                  )
                             )
                     }
                )
                [ renderArg ]
    , map =
        \mapArg mapArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Response" ]
                     , name = "map"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "data" ]
                                      (Type.var "mappedData")
                                  , Type.namedWith
                                      [ "Server", "Response" ]
                                      "Response"
                                      [ Type.var "data", Type.var "error" ]
                                  ]
                                  (Type.namedWith
                                       [ "Server", "Response" ]
                                       "Response"
                                       [ Type.var "mappedData"
                                       , Type.var "error"
                                       ]
                                  )
                             )
                     }
                )
                [ mapArg, mapArg0 ]
    , errorPage =
        \errorPageArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Response" ]
                     , name = "errorPage"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "errorPage" ]
                                  (Type.namedWith
                                       [ "Server", "Response" ]
                                       "Response"
                                       [ Type.var "data", Type.var "errorPage" ]
                                  )
                             )
                     }
                )
                [ errorPageArg ]
    , mapError =
        \mapErrorArg mapErrorArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Response" ]
                     , name = "mapError"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "errorPage" ]
                                      (Type.var "mappedErrorPage")
                                  , Type.namedWith
                                      [ "Server", "Response" ]
                                      "Response"
                                      [ Type.var "data", Type.var "errorPage" ]
                                  ]
                                  (Type.namedWith
                                       [ "Server", "Response" ]
                                       "Response"
                                       [ Type.var "data"
                                       , Type.var "mappedErrorPage"
                                       ]
                                  )
                             )
                     }
                )
                [ mapErrorArg, mapErrorArg0 ]
    , temporaryRedirect =
        \temporaryRedirectArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Response" ]
                     , name = "temporaryRedirect"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Server", "Response" ]
                                       "Response"
                                       [ Type.var "data", Type.var "error" ]
                                  )
                             )
                     }
                )
                [ temporaryRedirectArg ]
    , permanentRedirect =
        \permanentRedirectArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Response" ]
                     , name = "permanentRedirect"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Server", "Response" ]
                                       "Response"
                                       [ Type.var "data", Type.var "error" ]
                                  )
                             )
                     }
                )
                [ permanentRedirectArg ]
    , json =
        \jsonArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Response" ]
                     , name = "json"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Json", "Encode" ]
                                      "Value"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Server", "Response" ]
                                       "Response"
                                       [ Type.var "data", Type.var "error" ]
                                  )
                             )
                     }
                )
                [ jsonArg ]
    , plainText =
        \plainTextArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Response" ]
                     , name = "plainText"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Server", "Response" ]
                                       "Response"
                                       [ Type.var "data", Type.var "error" ]
                                  )
                             )
                     }
                )
                [ plainTextArg ]
    , body =
        \bodyArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Response" ]
                     , name = "body"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Server", "Response" ]
                                       "Response"
                                       [ Type.var "data", Type.var "error" ]
                                  )
                             )
                     }
                )
                [ bodyArg ]
    , bytesBody =
        \bytesBodyArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Response" ]
                     , name = "bytesBody"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith [ "Bytes" ] "Bytes" [] ]
                                  (Type.namedWith
                                       [ "Server", "Response" ]
                                       "Response"
                                       [ Type.var "data", Type.var "error" ]
                                  )
                             )
                     }
                )
                [ bytesBodyArg ]
    , base64Body =
        \base64BodyArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Response" ]
                     , name = "base64Body"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "Server", "Response" ]
                                       "Response"
                                       [ Type.var "data", Type.var "error" ]
                                  )
                             )
                     }
                )
                [ base64BodyArg ]
    , withHeader =
        \withHeaderArg withHeaderArg0 withHeaderArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Response" ]
                     , name = "withHeader"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.string
                                  , Type.namedWith
                                      [ "Server", "Response" ]
                                      "Response"
                                      [ Type.var "data", Type.var "error" ]
                                  ]
                                  (Type.namedWith
                                       [ "Server", "Response" ]
                                       "Response"
                                       [ Type.var "data", Type.var "error" ]
                                  )
                             )
                     }
                )
                [ withHeaderArg, withHeaderArg0, withHeaderArg1 ]
    , withHeaders =
        \withHeadersArg withHeadersArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Response" ]
                     , name = "withHeaders"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.tuple Type.string Type.string)
                                  , Type.namedWith
                                      [ "Server", "Response" ]
                                      "Response"
                                      [ Type.var "data", Type.var "error" ]
                                  ]
                                  (Type.namedWith
                                       [ "Server", "Response" ]
                                       "Response"
                                       [ Type.var "data", Type.var "error" ]
                                  )
                             )
                     }
                )
                [ withHeadersArg, withHeadersArg0 ]
    , withStatusCode =
        \withStatusCodeArg withStatusCodeArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Response" ]
                     , name = "withStatusCode"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.namedWith
                                      [ "Server", "Response" ]
                                      "Response"
                                      [ Type.var "data"
                                      , Type.namedWith [ "Basics" ] "Never" []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Server", "Response" ]
                                       "Response"
                                       [ Type.var "data"
                                       , Type.namedWith [ "Basics" ] "Never" []
                                       ]
                                  )
                             )
                     }
                )
                [ withStatusCodeArg, withStatusCodeArg0 ]
    , withSetCookieHeader =
        \withSetCookieHeaderArg withSetCookieHeaderArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Response" ]
                     , name = "withSetCookieHeader"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Server", "SetCookie" ]
                                      "SetCookie"
                                      []
                                  , Type.namedWith
                                      [ "Server", "Response" ]
                                      "Response"
                                      [ Type.var "data", Type.var "error" ]
                                  ]
                                  (Type.namedWith
                                       [ "Server", "Response" ]
                                       "Response"
                                       [ Type.var "data", Type.var "error" ]
                                  )
                             )
                     }
                )
                [ withSetCookieHeaderArg, withSetCookieHeaderArg0 ]
    , toJson =
        \toJsonArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Response" ]
                     , name = "toJson"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Server", "Response" ]
                                      "Response"
                                      [ Type.namedWith [ "Basics" ] "Never" []
                                      , Type.namedWith [ "Basics" ] "Never" []
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "Json", "Encode" ]
                                       "Value"
                                       []
                                  )
                             )
                     }
                )
                [ toJsonArg ]
    }


values_ :
    { render : Elm.Expression
    , map : Elm.Expression
    , errorPage : Elm.Expression
    , mapError : Elm.Expression
    , temporaryRedirect : Elm.Expression
    , permanentRedirect : Elm.Expression
    , json : Elm.Expression
    , plainText : Elm.Expression
    , emptyBody : Elm.Expression
    , body : Elm.Expression
    , bytesBody : Elm.Expression
    , base64Body : Elm.Expression
    , withHeader : Elm.Expression
    , withHeaders : Elm.Expression
    , withStatusCode : Elm.Expression
    , withSetCookieHeader : Elm.Expression
    , toJson : Elm.Expression
    }
values_ =
    { render =
        Elm.value
            { importFrom = [ "Server", "Response" ]
            , name = "render"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "data" ]
                         (Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "error" ]
                         )
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "Server", "Response" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "data" ]
                             (Type.var "mappedData")
                         , Type.namedWith
                             [ "Server", "Response" ]
                             "Response"
                             [ Type.var "data", Type.var "error" ]
                         ]
                         (Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "mappedData", Type.var "error" ]
                         )
                    )
            }
    , errorPage =
        Elm.value
            { importFrom = [ "Server", "Response" ]
            , name = "errorPage"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "errorPage" ]
                         (Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "errorPage" ]
                         )
                    )
            }
    , mapError =
        Elm.value
            { importFrom = [ "Server", "Response" ]
            , name = "mapError"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.var "errorPage" ]
                             (Type.var "mappedErrorPage")
                         , Type.namedWith
                             [ "Server", "Response" ]
                             "Response"
                             [ Type.var "data", Type.var "errorPage" ]
                         ]
                         (Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "mappedErrorPage" ]
                         )
                    )
            }
    , temporaryRedirect =
        Elm.value
            { importFrom = [ "Server", "Response" ]
            , name = "temporaryRedirect"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "error" ]
                         )
                    )
            }
    , permanentRedirect =
        Elm.value
            { importFrom = [ "Server", "Response" ]
            , name = "permanentRedirect"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "error" ]
                         )
                    )
            }
    , json =
        Elm.value
            { importFrom = [ "Server", "Response" ]
            , name = "json"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Json", "Encode" ] "Value" [] ]
                         (Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "error" ]
                         )
                    )
            }
    , plainText =
        Elm.value
            { importFrom = [ "Server", "Response" ]
            , name = "plainText"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "error" ]
                         )
                    )
            }
    , emptyBody =
        Elm.value
            { importFrom = [ "Server", "Response" ]
            , name = "emptyBody"
            , annotation =
                Just
                    (Type.namedWith
                         [ "Server", "Response" ]
                         "Response"
                         [ Type.var "data", Type.var "error" ]
                    )
            }
    , body =
        Elm.value
            { importFrom = [ "Server", "Response" ]
            , name = "body"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "error" ]
                         )
                    )
            }
    , bytesBody =
        Elm.value
            { importFrom = [ "Server", "Response" ]
            , name = "bytesBody"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Bytes" ] "Bytes" [] ]
                         (Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "error" ]
                         )
                    )
            }
    , base64Body =
        Elm.value
            { importFrom = [ "Server", "Response" ]
            , name = "base64Body"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "error" ]
                         )
                    )
            }
    , withHeader =
        Elm.value
            { importFrom = [ "Server", "Response" ]
            , name = "withHeader"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.string
                         , Type.namedWith
                             [ "Server", "Response" ]
                             "Response"
                             [ Type.var "data", Type.var "error" ]
                         ]
                         (Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "error" ]
                         )
                    )
            }
    , withHeaders =
        Elm.value
            { importFrom = [ "Server", "Response" ]
            , name = "withHeaders"
            , annotation =
                Just
                    (Type.function
                         [ Type.list (Type.tuple Type.string Type.string)
                         , Type.namedWith
                             [ "Server", "Response" ]
                             "Response"
                             [ Type.var "data", Type.var "error" ]
                         ]
                         (Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "error" ]
                         )
                    )
            }
    , withStatusCode =
        Elm.value
            { importFrom = [ "Server", "Response" ]
            , name = "withStatusCode"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.namedWith
                             [ "Server", "Response" ]
                             "Response"
                             [ Type.var "data"
                             , Type.namedWith [ "Basics" ] "Never" []
                             ]
                         ]
                         (Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data"
                              , Type.namedWith [ "Basics" ] "Never" []
                              ]
                         )
                    )
            }
    , withSetCookieHeader =
        Elm.value
            { importFrom = [ "Server", "Response" ]
            , name = "withSetCookieHeader"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Server", "SetCookie" ]
                             "SetCookie"
                             []
                         , Type.namedWith
                             [ "Server", "Response" ]
                             "Response"
                             [ Type.var "data", Type.var "error" ]
                         ]
                         (Type.namedWith
                              [ "Server", "Response" ]
                              "Response"
                              [ Type.var "data", Type.var "error" ]
                         )
                    )
            }
    , toJson =
        Elm.value
            { importFrom = [ "Server", "Response" ]
            , name = "toJson"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Server", "Response" ]
                             "Response"
                             [ Type.namedWith [ "Basics" ] "Never" []
                             , Type.namedWith [ "Basics" ] "Never" []
                             ]
                         ]
                         (Type.namedWith [ "Json", "Encode" ] "Value" [])
                    )
            }
    }