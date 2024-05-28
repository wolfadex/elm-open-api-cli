module Gen.Server.Request exposing (annotation_, body, call_, caseOf_, cookie, cookies, formData, formDataWithServerValidation, header, headers, jsonBody, make_, matchesContentType, method, methodToString, moduleName_, queryParam, queryParams, rawFormData, rawUrl, requestTime, values_)

{-| 
@docs moduleName_, requestTime, header, headers, method, methodToString, body, jsonBody, formData, formDataWithServerValidation, rawFormData, rawUrl, queryParam, queryParams, matchesContentType, cookie, cookies, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "Server", "Request" ]


{-| Get the `Time.Posix` when the incoming HTTP request was received.

requestTime: Server.Request.Request -> Time.Posix
-}
requestTime : Elm.Expression -> Elm.Expression
requestTime requestTimeArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Request" ]
             , name = "requestTime"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Server", "Request" ] "Request" []
                          ]
                          (Type.namedWith [ "Time" ] "Posix" [])
                     )
             }
        )
        [ requestTimeArg ]


{-| Get a header from the request. The header name is case-insensitive.

Header: Accept-Language: en-US,en;q=0.5

    request |> Request.header "Accept-Language"
    -- Just "Accept-Language: en-US,en;q=0.5"

header: String -> Server.Request.Request -> Maybe String
-}
header : String -> Elm.Expression -> Elm.Expression
header headerArg headerArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Request" ]
             , name = "header"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Server", "Request" ] "Request" []
                          ]
                          (Type.maybe Type.string)
                     )
             }
        )
        [ Elm.string headerArg, headerArg0 ]


{-| headers: Server.Request.Request -> Dict.Dict String String -}
headers : Elm.Expression -> Elm.Expression
headers headersArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Request" ]
             , name = "headers"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Server", "Request" ] "Request" []
                          ]
                          (Type.namedWith
                               [ "Dict" ]
                               "Dict"
                               [ Type.string, Type.string ]
                          )
                     )
             }
        )
        [ headersArg ]


{-| The [HTTP request method](https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods) of the incoming request.

Note that Route modules `data` is run for `GET` requests, and `action` is run for other request methods (including `POST`, `PUT`, `DELETE`).
So you don't need to check the `method` in your Route Module's `data` function, though you can choose to do so in its `action`.

method: Server.Request.Request -> Server.Request.Method
-}
method : Elm.Expression -> Elm.Expression
method methodArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Request" ]
             , name = "method"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Server", "Request" ] "Request" []
                          ]
                          (Type.namedWith [ "Server", "Request" ] "Method" [])
                     )
             }
        )
        [ methodArg ]


{-| Gets the HTTP Method as an uppercase String.

Examples:

    Get
        |> methodToString
        -- "GET"

methodToString: Server.Request.Method -> String
-}
methodToString : Elm.Expression -> Elm.Expression
methodToString methodToStringArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Request" ]
             , name = "methodToString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Server", "Request" ] "Method" [] ]
                          Type.string
                     )
             }
        )
        [ methodToStringArg ]


{-| The Request body, if present (or `Nothing` if there is no request body).

body: Server.Request.Request -> Maybe String
-}
body : Elm.Expression -> Elm.Expression
body bodyArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Request" ]
             , name = "body"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Server", "Request" ] "Request" []
                          ]
                          (Type.maybe Type.string)
                     )
             }
        )
        [ bodyArg ]


{-| If the request has a body and its `Content-Type` matches JSON, then
try running a JSON decoder on the body of the request. Otherwise, return `Nothing`.

Example:

    Body: { "name": "John" }
    Headers:
    Content-Type: application/json
    request |> jsonBody (Json.Decode.field "name" Json.Decode.string)
    -- Just (Ok "John")

    Body: { "name": "John" }
    No Headers
    jsonBody (Json.Decode.field "name" Json.Decode.string) request
    -- Nothing

    No Body
    No Headers
    jsonBody (Json.Decode.field "name" Json.Decode.string) request
    -- Nothing

jsonBody: 
    Json.Decode.Decoder value
    -> Server.Request.Request
    -> Maybe (Result.Result Json.Decode.Error value)
-}
jsonBody : Elm.Expression -> Elm.Expression -> Elm.Expression
jsonBody jsonBodyArg jsonBodyArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Request" ]
             , name = "jsonBody"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.var "value" ]
                          , Type.namedWith [ "Server", "Request" ] "Request" []
                          ]
                          (Type.maybe
                               (Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.namedWith
                                        [ "Json", "Decode" ]
                                        "Error"
                                        []
                                    , Type.var "value"
                                    ]
                               )
                          )
                     )
             }
        )
        [ jsonBodyArg, jsonBodyArg0 ]


{-| Takes a [`Form.Handler.Handler`](https://package.elm-lang.org/packages/dillonkearns/elm-form/latest/Form-Handler) and
parses the raw form data into a [`Form.Validated`](https://package.elm-lang.org/packages/dillonkearns/elm-form/latest/Form#Validated) value.

This is the standard pattern for dealing with form data in `elm-pages`. You can share your code for your [`Form`](https://package.elm-lang.org/packages/dillonkearns/elm-form/latest/Form#Form)
definitions between your client and server code, using this function to parse the raw form data into a `Form.Validated` value for the backend,
and [`Pages.Form`](Pages-Form) to render the `Form` on the client.

Since we are sharing the `Form` definition between frontend and backend, we get to re-use the same validation logic so we gain confidence that
the validation errors that the user sees on the client are protected on our backend, and vice versa.

    import BackendTask exposing (BackendTask)
    import FatalError exposing (FatalError)
    import Form
    import Server.Request as Request exposing (Request)
    import Server.Response as Response exposing (Response)

    type Action
        = Delete
        | CreateOrUpdate Post

    formHandlers : Form.Handler.Handler String Action
    formHandlers =
        deleteForm
            |> Form.Handler.init (\() -> Delete)
            |> Form.Handler.with CreateOrUpdate createOrUpdateForm

    deleteForm : Form.HtmlForm String () input msg

    createOrUpdateForm : Form.HtmlForm String Post Post msg

    action :
        RouteParams
        -> Request
        -> BackendTask FatalError (Response ActionData ErrorPage)
    action routeParams request =
        case request |> Server.Request.formData formHandlers of
            Nothing ->
                BackendTask.fail (FatalError.fromString "Missing form data")

            Just ( formResponse, parsedForm ) ->
                case parsedForm of
                    Form.Valid Delete ->
                        deletePostBySlug routeParams.slug
                            |> BackendTask.map
                                (\() -> Route.redirectTo Route.Index)

                    Form.Valid (CreateOrUpdate post) ->
                        let
                            createPost : Bool
                            createPost =
                                okForm.slug == "new"
                        in
                        createOrUpdatePost post
                            |> BackendTask.map
                                (\() ->
                                    Route.redirectTo
                                        (Route.Admin__Slug_ { slug = okForm.slug })
                                )

                    Form.Invalid _ invalidForm ->
                        BackendTask.succeed
                            (Server.Response.render
                                { errors = formResponse }
                            )

You can handle form submissions as either GET or POST requests. Note that for security reasons, it's important to performing mutations with care from GET requests,
since a GET request can be performed from an outside origin by embedding an image that points to the given URL. So a logout submission should be protected by
using `POST` to ensure that you can't log users out by embedding an image with a logout URL in it.

If the request has HTTP method `GET`, the form data will come from the query parameters.

If the request has the HTTP method `POST` _and_ the `Content-Type` is `application/x-www-form-urlencoded`, it will return the
decoded form data from the body of the request.

Otherwise, this `Parser` will not match.

Note that in server-rendered Route modules, your `data` function will handle `GET` requests (and will _not_ receive any `POST` requests),
while your `action` will receive POST (and other non-GET) requests.

By default, [`Form`]'s are rendered with a `POST` method, and you can configure them to submit `GET` requests using [`withGetMethod`](https://package.elm-lang.org/packages/dillonkearns/elm-form/latest/Form#withGetMethod).
So you will want to handle any `Form`'s rendered using `withGetMethod` in your Route's `data` function, or otherwise handle forms in `action`.

formData: 
    Form.Handler.Handler error combined
    -> Server.Request.Request
    -> Maybe ( Form.ServerResponse error, Form.Validated error combined )
-}
formData : Elm.Expression -> Elm.Expression -> Elm.Expression
formData formDataArg formDataArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Request" ]
             , name = "formData"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Form", "Handler" ]
                              "Handler"
                              [ Type.var "error", Type.var "combined" ]
                          , Type.namedWith [ "Server", "Request" ] "Request" []
                          ]
                          (Type.maybe
                               (Type.tuple
                                    (Type.namedWith
                                         [ "Form" ]
                                         "ServerResponse"
                                         [ Type.var "error" ]
                                    )
                                    (Type.namedWith
                                         [ "Form" ]
                                         "Validated"
                                         [ Type.var "error"
                                         , Type.var "combined"
                                         ]
                                    )
                               )
                          )
                     )
             }
        )
        [ formDataArg, formDataArg0 ]


{-| formDataWithServerValidation: 
    Pages.Form.Handler error combined
    -> Server.Request.Request
    -> Maybe (BackendTask.BackendTask FatalError.FatalError (Result.Result (Form.ServerResponse error) ( Form.ServerResponse error, combined )))
-}
formDataWithServerValidation :
    Elm.Expression -> Elm.Expression -> Elm.Expression
formDataWithServerValidation formDataWithServerValidationArg formDataWithServerValidationArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Request" ]
             , name = "formDataWithServerValidation"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Pages", "Form" ]
                              "Handler"
                              [ Type.var "error", Type.var "combined" ]
                          , Type.namedWith [ "Server", "Request" ] "Request" []
                          ]
                          (Type.maybe
                               (Type.namedWith
                                    [ "BackendTask" ]
                                    "BackendTask"
                                    [ Type.namedWith
                                        [ "FatalError" ]
                                        "FatalError"
                                        []
                                    , Type.namedWith
                                        [ "Result" ]
                                        "Result"
                                        [ Type.namedWith
                                              [ "Form" ]
                                              "ServerResponse"
                                              [ Type.var "error" ]
                                        , Type.tuple
                                              (Type.namedWith
                                                   [ "Form" ]
                                                   "ServerResponse"
                                                   [ Type.var "error" ]
                                              )
                                              (Type.var "combined")
                                        ]
                                    ]
                               )
                          )
                     )
             }
        )
        [ formDataWithServerValidationArg, formDataWithServerValidationArg0 ]


{-| Get the raw key-value pairs from a form submission.

If the request has the HTTP method `GET`, it will return the query parameters.

If the request has the HTTP method `POST` _and_ the `Content-Type` is `application/x-www-form-urlencoded`, it will return the
decoded form data from the body of the request.

Otherwise, this `Parser` will not match.

Note that in server-rendered Route modules, your `data` function will handle `GET` requests (and will _not_ receive any `POST` requests),
while your `action` will receive POST (and other non-GET) requests.

By default, [`Form`]'s are rendered with a `POST` method, and you can configure them to submit `GET` requests using [`withGetMethod`](https://package.elm-lang.org/packages/dillonkearns/elm-form/latest/Form#withGetMethod).
So you will want to handle any `Form`'s rendered using `withGetMethod` in your Route's `data` function, or otherwise handle forms in `action`.

rawFormData: Server.Request.Request -> Maybe (List ( String, String ))
-}
rawFormData : Elm.Expression -> Elm.Expression
rawFormData rawFormDataArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Request" ]
             , name = "rawFormData"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Server", "Request" ] "Request" []
                          ]
                          (Type.maybe
                               (Type.list (Type.tuple Type.string Type.string))
                          )
                     )
             }
        )
        [ rawFormDataArg ]


{-| The full URL of the incoming HTTP request, including the query params.

Note that the fragment is not included because this is client-only (not sent to the server).

    rawUrl request

    -- url: http://example.com?coupon=abc
    -- parses into: "http://example.com?coupon=abc"

    rawUrl request

    -- url: https://example.com?coupon=abc&coupon=xyz
    -- parses into: "https://example.com?coupon=abc&coupon=xyz"

rawUrl: Server.Request.Request -> String
-}
rawUrl : Elm.Expression -> Elm.Expression
rawUrl rawUrlArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Request" ]
             , name = "rawUrl"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Server", "Request" ] "Request" []
                          ]
                          Type.string
                     )
             }
        )
        [ rawUrlArg ]


{-| Get `Nothing` if the query param with the given name is missing, or `Just` the value if it is present.

If there are multiple query params with the same name, the first one is returned.

    queryParam "coupon"

    -- url: http://example.com?coupon=abc
    -- parses into: Just "abc"

    queryParam "coupon"

    -- url: http://example.com?coupon=abc&coupon=xyz
    -- parses into: Just "abc"

    queryParam "coupon"

    -- url: http://example.com
    -- parses into: Nothing

See also [`queryParams`](#queryParams), or [`rawUrl`](#rawUrl) if you need something more low-level.

queryParam: String -> Server.Request.Request -> Maybe String
-}
queryParam : String -> Elm.Expression -> Elm.Expression
queryParam queryParamArg queryParamArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Request" ]
             , name = "queryParam"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Server", "Request" ] "Request" []
                          ]
                          (Type.maybe Type.string)
                     )
             }
        )
        [ Elm.string queryParamArg, queryParamArg0 ]


{-| Gives all query params from the URL.

    queryParam "coupon"

    -- url: http://example.com?coupon=abc
    -- parses into: Dict.fromList [("coupon", ["abc"])]

    queryParam "coupon"

    -- url: http://example.com?coupon=abc&coupon=xyz
    -- parses into: Dict.fromList [("coupon", ["abc", "xyz"])]

queryParams: Server.Request.Request -> Dict.Dict String (List String)
-}
queryParams : Elm.Expression -> Elm.Expression
queryParams queryParamsArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Request" ]
             , name = "queryParams"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Server", "Request" ] "Request" []
                          ]
                          (Type.namedWith
                               [ "Dict" ]
                               "Dict"
                               [ Type.string, Type.list Type.string ]
                          )
                     )
             }
        )
        [ queryParamsArg ]


{-| True if the `content-type` header is present AND matches the given argument.

Examples:

    Content-Type: application/json; charset=utf-8
    request |> matchesContentType "application/json"
    -- True

    Content-Type: application/json
    request |> matchesContentType "application/json"
    -- True

    Content-Type: application/json
    request |> matchesContentType "application/xml"
    -- False

matchesContentType: String -> Server.Request.Request -> Bool
-}
matchesContentType : String -> Elm.Expression -> Elm.Expression
matchesContentType matchesContentTypeArg matchesContentTypeArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Request" ]
             , name = "matchesContentType"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Server", "Request" ] "Request" []
                          ]
                          Type.bool
                     )
             }
        )
        [ Elm.string matchesContentTypeArg, matchesContentTypeArg0 ]


{-| Get a cookie from the request. For a more high-level API, see [`Server.Session`](Server-Session).

cookie: String -> Server.Request.Request -> Maybe String
-}
cookie : String -> Elm.Expression -> Elm.Expression
cookie cookieArg cookieArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Request" ]
             , name = "cookie"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Server", "Request" ] "Request" []
                          ]
                          (Type.maybe Type.string)
                     )
             }
        )
        [ Elm.string cookieArg, cookieArg0 ]


{-| Get all of the cookies from the incoming HTTP request. For a more high-level API, see [`Server.Session`](Server-Session).

cookies: Server.Request.Request -> Dict.Dict String String
-}
cookies : Elm.Expression -> Elm.Expression
cookies cookiesArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "Server", "Request" ]
             , name = "cookies"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith [ "Server", "Request" ] "Request" []
                          ]
                          (Type.namedWith
                               [ "Dict" ]
                               "Dict"
                               [ Type.string, Type.string ]
                          )
                     )
             }
        )
        [ cookiesArg ]


annotation_ : { request : Type.Annotation, method : Type.Annotation }
annotation_ =
    { request =
        Type.alias
            moduleName_
            "Request"
            []
            (Type.namedWith [ "Internal", "Request" ] "Request" [])
    , method = Type.namedWith [ "Server", "Request" ] "Method" []
    }


make_ :
    { connect : Elm.Expression
    , delete : Elm.Expression
    , get : Elm.Expression
    , head : Elm.Expression
    , options : Elm.Expression
    , patch : Elm.Expression
    , post : Elm.Expression
    , put : Elm.Expression
    , trace : Elm.Expression
    , nonStandard : Elm.Expression -> Elm.Expression
    }
make_ =
    { connect =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "Connect"
            , annotation = Just (Type.namedWith [] "Method" [])
            }
    , delete =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "Delete"
            , annotation = Just (Type.namedWith [] "Method" [])
            }
    , get =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "Get"
            , annotation = Just (Type.namedWith [] "Method" [])
            }
    , head =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "Head"
            , annotation = Just (Type.namedWith [] "Method" [])
            }
    , options =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "Options"
            , annotation = Just (Type.namedWith [] "Method" [])
            }
    , patch =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "Patch"
            , annotation = Just (Type.namedWith [] "Method" [])
            }
    , post =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "Post"
            , annotation = Just (Type.namedWith [] "Method" [])
            }
    , put =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "Put"
            , annotation = Just (Type.namedWith [] "Method" [])
            }
    , trace =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "Trace"
            , annotation = Just (Type.namedWith [] "Method" [])
            }
    , nonStandard =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Request" ]
                     , name = "NonStandard"
                     , annotation = Just (Type.namedWith [] "Method" [])
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { method :
        Elm.Expression
        -> { methodTags_0_0
            | connect : Elm.Expression
            , delete : Elm.Expression
            , get : Elm.Expression
            , head : Elm.Expression
            , options : Elm.Expression
            , patch : Elm.Expression
            , post : Elm.Expression
            , put : Elm.Expression
            , trace : Elm.Expression
            , nonStandard : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { method =
        \methodExpression methodTags ->
            Elm.Case.custom
                methodExpression
                (Type.namedWith [ "Server", "Request" ] "Method" [])
                [ Elm.Case.branch0 "Connect" methodTags.connect
                , Elm.Case.branch0 "Delete" methodTags.delete
                , Elm.Case.branch0 "Get" methodTags.get
                , Elm.Case.branch0 "Head" methodTags.head
                , Elm.Case.branch0 "Options" methodTags.options
                , Elm.Case.branch0 "Patch" methodTags.patch
                , Elm.Case.branch0 "Post" methodTags.post
                , Elm.Case.branch0 "Put" methodTags.put
                , Elm.Case.branch0 "Trace" methodTags.trace
                , Elm.Case.branch1
                    "NonStandard"
                    ( "stringString", Type.string )
                    methodTags.nonStandard
                ]
    }


call_ :
    { requestTime : Elm.Expression -> Elm.Expression
    , header : Elm.Expression -> Elm.Expression -> Elm.Expression
    , headers : Elm.Expression -> Elm.Expression
    , method : Elm.Expression -> Elm.Expression
    , methodToString : Elm.Expression -> Elm.Expression
    , body : Elm.Expression -> Elm.Expression
    , jsonBody : Elm.Expression -> Elm.Expression -> Elm.Expression
    , formData : Elm.Expression -> Elm.Expression -> Elm.Expression
    , formDataWithServerValidation :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    , rawFormData : Elm.Expression -> Elm.Expression
    , rawUrl : Elm.Expression -> Elm.Expression
    , queryParam : Elm.Expression -> Elm.Expression -> Elm.Expression
    , queryParams : Elm.Expression -> Elm.Expression
    , matchesContentType : Elm.Expression -> Elm.Expression -> Elm.Expression
    , cookie : Elm.Expression -> Elm.Expression -> Elm.Expression
    , cookies : Elm.Expression -> Elm.Expression
    }
call_ =
    { requestTime =
        \requestTimeArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Request" ]
                     , name = "requestTime"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Server", "Request" ]
                                      "Request"
                                      []
                                  ]
                                  (Type.namedWith [ "Time" ] "Posix" [])
                             )
                     }
                )
                [ requestTimeArg ]
    , header =
        \headerArg headerArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Request" ]
                     , name = "header"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Server", "Request" ]
                                      "Request"
                                      []
                                  ]
                                  (Type.maybe Type.string)
                             )
                     }
                )
                [ headerArg, headerArg0 ]
    , headers =
        \headersArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Request" ]
                     , name = "headers"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Server", "Request" ]
                                      "Request"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Dict" ]
                                       "Dict"
                                       [ Type.string, Type.string ]
                                  )
                             )
                     }
                )
                [ headersArg ]
    , method =
        \methodArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Request" ]
                     , name = "method"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Server", "Request" ]
                                      "Request"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Server", "Request" ]
                                       "Method"
                                       []
                                  )
                             )
                     }
                )
                [ methodArg ]
    , methodToString =
        \methodToStringArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Request" ]
                     , name = "methodToString"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Server", "Request" ]
                                      "Method"
                                      []
                                  ]
                                  Type.string
                             )
                     }
                )
                [ methodToStringArg ]
    , body =
        \bodyArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Request" ]
                     , name = "body"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Server", "Request" ]
                                      "Request"
                                      []
                                  ]
                                  (Type.maybe Type.string)
                             )
                     }
                )
                [ bodyArg ]
    , jsonBody =
        \jsonBodyArg jsonBodyArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Request" ]
                     , name = "jsonBody"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Decoder"
                                      [ Type.var "value" ]
                                  , Type.namedWith
                                      [ "Server", "Request" ]
                                      "Request"
                                      []
                                  ]
                                  (Type.maybe
                                       (Type.namedWith
                                            [ "Result" ]
                                            "Result"
                                            [ Type.namedWith
                                                [ "Json", "Decode" ]
                                                "Error"
                                                []
                                            , Type.var "value"
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ jsonBodyArg, jsonBodyArg0 ]
    , formData =
        \formDataArg formDataArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Request" ]
                     , name = "formData"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Form", "Handler" ]
                                      "Handler"
                                      [ Type.var "error", Type.var "combined" ]
                                  , Type.namedWith
                                      [ "Server", "Request" ]
                                      "Request"
                                      []
                                  ]
                                  (Type.maybe
                                       (Type.tuple
                                            (Type.namedWith
                                                 [ "Form" ]
                                                 "ServerResponse"
                                                 [ Type.var "error" ]
                                            )
                                            (Type.namedWith
                                                 [ "Form" ]
                                                 "Validated"
                                                 [ Type.var "error"
                                                 , Type.var "combined"
                                                 ]
                                            )
                                       )
                                  )
                             )
                     }
                )
                [ formDataArg, formDataArg0 ]
    , formDataWithServerValidation =
        \formDataWithServerValidationArg formDataWithServerValidationArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Request" ]
                     , name = "formDataWithServerValidation"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Pages", "Form" ]
                                      "Handler"
                                      [ Type.var "error", Type.var "combined" ]
                                  , Type.namedWith
                                      [ "Server", "Request" ]
                                      "Request"
                                      []
                                  ]
                                  (Type.maybe
                                       (Type.namedWith
                                            [ "BackendTask" ]
                                            "BackendTask"
                                            [ Type.namedWith
                                                [ "FatalError" ]
                                                "FatalError"
                                                []
                                            , Type.namedWith
                                                [ "Result" ]
                                                "Result"
                                                [ Type.namedWith
                                                      [ "Form" ]
                                                      "ServerResponse"
                                                      [ Type.var "error" ]
                                                , Type.tuple
                                                      (Type.namedWith
                                                           [ "Form" ]
                                                           "ServerResponse"
                                                           [ Type.var "error" ]
                                                      )
                                                      (Type.var "combined")
                                                ]
                                            ]
                                       )
                                  )
                             )
                     }
                )
                [ formDataWithServerValidationArg
                , formDataWithServerValidationArg0
                ]
    , rawFormData =
        \rawFormDataArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Request" ]
                     , name = "rawFormData"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Server", "Request" ]
                                      "Request"
                                      []
                                  ]
                                  (Type.maybe
                                       (Type.list
                                            (Type.tuple Type.string Type.string)
                                       )
                                  )
                             )
                     }
                )
                [ rawFormDataArg ]
    , rawUrl =
        \rawUrlArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Request" ]
                     , name = "rawUrl"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Server", "Request" ]
                                      "Request"
                                      []
                                  ]
                                  Type.string
                             )
                     }
                )
                [ rawUrlArg ]
    , queryParam =
        \queryParamArg queryParamArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Request" ]
                     , name = "queryParam"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Server", "Request" ]
                                      "Request"
                                      []
                                  ]
                                  (Type.maybe Type.string)
                             )
                     }
                )
                [ queryParamArg, queryParamArg0 ]
    , queryParams =
        \queryParamsArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Request" ]
                     , name = "queryParams"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Server", "Request" ]
                                      "Request"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Dict" ]
                                       "Dict"
                                       [ Type.string, Type.list Type.string ]
                                  )
                             )
                     }
                )
                [ queryParamsArg ]
    , matchesContentType =
        \matchesContentTypeArg matchesContentTypeArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Request" ]
                     , name = "matchesContentType"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Server", "Request" ]
                                      "Request"
                                      []
                                  ]
                                  Type.bool
                             )
                     }
                )
                [ matchesContentTypeArg, matchesContentTypeArg0 ]
    , cookie =
        \cookieArg cookieArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Request" ]
                     , name = "cookie"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Server", "Request" ]
                                      "Request"
                                      []
                                  ]
                                  (Type.maybe Type.string)
                             )
                     }
                )
                [ cookieArg, cookieArg0 ]
    , cookies =
        \cookiesArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "Server", "Request" ]
                     , name = "cookies"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Server", "Request" ]
                                      "Request"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "Dict" ]
                                       "Dict"
                                       [ Type.string, Type.string ]
                                  )
                             )
                     }
                )
                [ cookiesArg ]
    }


values_ :
    { requestTime : Elm.Expression
    , header : Elm.Expression
    , headers : Elm.Expression
    , method : Elm.Expression
    , methodToString : Elm.Expression
    , body : Elm.Expression
    , jsonBody : Elm.Expression
    , formData : Elm.Expression
    , formDataWithServerValidation : Elm.Expression
    , rawFormData : Elm.Expression
    , rawUrl : Elm.Expression
    , queryParam : Elm.Expression
    , queryParams : Elm.Expression
    , matchesContentType : Elm.Expression
    , cookie : Elm.Expression
    , cookies : Elm.Expression
    }
values_ =
    { requestTime =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "requestTime"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Server", "Request" ] "Request" [] ]
                         (Type.namedWith [ "Time" ] "Posix" [])
                    )
            }
    , header =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "header"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Server", "Request" ] "Request" []
                         ]
                         (Type.maybe Type.string)
                    )
            }
    , headers =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "headers"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Server", "Request" ] "Request" [] ]
                         (Type.namedWith
                              [ "Dict" ]
                              "Dict"
                              [ Type.string, Type.string ]
                         )
                    )
            }
    , method =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "method"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Server", "Request" ] "Request" [] ]
                         (Type.namedWith [ "Server", "Request" ] "Method" [])
                    )
            }
    , methodToString =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "methodToString"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Server", "Request" ] "Method" [] ]
                         Type.string
                    )
            }
    , body =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "body"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Server", "Request" ] "Request" [] ]
                         (Type.maybe Type.string)
                    )
            }
    , jsonBody =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "jsonBody"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Json", "Decode" ]
                             "Decoder"
                             [ Type.var "value" ]
                         , Type.namedWith [ "Server", "Request" ] "Request" []
                         ]
                         (Type.maybe
                              (Type.namedWith
                                   [ "Result" ]
                                   "Result"
                                   [ Type.namedWith
                                       [ "Json", "Decode" ]
                                       "Error"
                                       []
                                   , Type.var "value"
                                   ]
                              )
                         )
                    )
            }
    , formData =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "formData"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Form", "Handler" ]
                             "Handler"
                             [ Type.var "error", Type.var "combined" ]
                         , Type.namedWith [ "Server", "Request" ] "Request" []
                         ]
                         (Type.maybe
                              (Type.tuple
                                   (Type.namedWith
                                        [ "Form" ]
                                        "ServerResponse"
                                        [ Type.var "error" ]
                                   )
                                   (Type.namedWith
                                        [ "Form" ]
                                        "Validated"
                                        [ Type.var "error"
                                        , Type.var "combined"
                                        ]
                                   )
                              )
                         )
                    )
            }
    , formDataWithServerValidation =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "formDataWithServerValidation"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Pages", "Form" ]
                             "Handler"
                             [ Type.var "error", Type.var "combined" ]
                         , Type.namedWith [ "Server", "Request" ] "Request" []
                         ]
                         (Type.maybe
                              (Type.namedWith
                                   [ "BackendTask" ]
                                   "BackendTask"
                                   [ Type.namedWith
                                       [ "FatalError" ]
                                       "FatalError"
                                       []
                                   , Type.namedWith
                                       [ "Result" ]
                                       "Result"
                                       [ Type.namedWith
                                             [ "Form" ]
                                             "ServerResponse"
                                             [ Type.var "error" ]
                                       , Type.tuple
                                             (Type.namedWith
                                                  [ "Form" ]
                                                  "ServerResponse"
                                                  [ Type.var "error" ]
                                             )
                                             (Type.var "combined")
                                       ]
                                   ]
                              )
                         )
                    )
            }
    , rawFormData =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "rawFormData"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Server", "Request" ] "Request" [] ]
                         (Type.maybe
                              (Type.list (Type.tuple Type.string Type.string))
                         )
                    )
            }
    , rawUrl =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "rawUrl"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Server", "Request" ] "Request" [] ]
                         Type.string
                    )
            }
    , queryParam =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "queryParam"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Server", "Request" ] "Request" []
                         ]
                         (Type.maybe Type.string)
                    )
            }
    , queryParams =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "queryParams"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Server", "Request" ] "Request" [] ]
                         (Type.namedWith
                              [ "Dict" ]
                              "Dict"
                              [ Type.string, Type.list Type.string ]
                         )
                    )
            }
    , matchesContentType =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "matchesContentType"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Server", "Request" ] "Request" []
                         ]
                         Type.bool
                    )
            }
    , cookie =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "cookie"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Server", "Request" ] "Request" []
                         ]
                         (Type.maybe Type.string)
                    )
            }
    , cookies =
        Elm.value
            { importFrom = [ "Server", "Request" ]
            , name = "cookies"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "Server", "Request" ] "Request" [] ]
                         (Type.namedWith
                              [ "Dict" ]
                              "Dict"
                              [ Type.string, Type.string ]
                         )
                    )
            }
    }