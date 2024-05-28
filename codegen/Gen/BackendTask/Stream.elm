module Gen.BackendTask.Stream exposing (allowNon0Status, annotation_, call_, caseOf_, command, commandWithOptions, customDuplex, customRead, customReadWithMeta, customTransformWithMeta, customWrite, customWriteWithMeta, defaultCommandOptions, fileRead, fileWrite, fromString, gzip, http, httpWithInput, make_, moduleName_, pipe, read, readJson, readMetadata, run, stderr, stdin, stdout, unzip, values_, withOutput, withTimeout)

{-| 
@docs moduleName_, pipe, fileRead, fileWrite, fromString, http, httpWithInput, stdin, stdout, stderr, read, readJson, readMetadata, run, command, commandWithOptions, defaultCommandOptions, allowNon0Status, withOutput, withTimeout, gzip, unzip, customRead, customWrite, customDuplex, customReadWithMeta, customTransformWithMeta, customWriteWithMeta, annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "BackendTask", "Stream" ]


{-| You can build up a pipeline of streams by using the `pipe` function.

The stream you are piping to must be writable (`{ write : () }`),
and the stream you are piping from must be readable (`{ read : () }`).

    module HelloWorld exposing (run)

    import BackendTask
    import BackendTask.Stream as Stream
    import Pages.Script as Script exposing (Script)

    run : Script
    run =
        Script.withoutCliOptions
            (Stream.fromString "Hello, World!"
                |> Stream.stdout
                |> Stream.run
            )

pipe: 
    BackendTask.Stream.Stream errorTo metaTo { read : toReadable, write : () }
    -> BackendTask.Stream.Stream errorFrom metaFrom { read : ()
    , write : fromWriteable
    }
    -> BackendTask.Stream.Stream errorTo metaTo { read : toReadable
    , write : fromWriteable
    }
-}
pipe : Elm.Expression -> Elm.Expression -> Elm.Expression
pipe pipeArg pipeArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "pipe"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.var "errorTo"
                              , Type.var "metaTo"
                              , Type.record
                                    [ ( "read", Type.var "toReadable" )
                                    , ( "write", Type.unit )
                                    ]
                              ]
                          , Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.var "errorFrom"
                              , Type.var "metaFrom"
                              , Type.record
                                    [ ( "read", Type.unit )
                                    , ( "write", Type.var "fromWriteable" )
                                    ]
                              ]
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Stream" ]
                               "Stream"
                               [ Type.var "errorTo"
                               , Type.var "metaTo"
                               , Type.record
                                   [ ( "read", Type.var "toReadable" )
                                   , ( "write", Type.var "fromWriteable" )
                                   ]
                               ]
                          )
                     )
             }
        )
        [ pipeArg, pipeArg0 ]


{-| Open a file's contents as a Stream.

    module ReadFile exposing (run)

    import BackendTask
    import BackendTask.Stream as Stream
    import Pages.Script as Script exposing (Script)

    run : Script
    run =
        Script.withoutCliOptions
            (Stream.fileRead "elm.json"
                |> Stream.readJson (Decode.field "source-directories" (Decode.list Decode.string))
                |> BackendTask.allowFatal
                |> BackendTask.andThen
                    (\{ body } ->
                        Script.log
                            ("The source directories are: "
                                ++ String.join ", " body
                            )
                    )
            )

If you want to read a file but don't need to use any of the other Stream functions, you can use [`BackendTask.File.read`](BackendTask-File#rawFile) instead.

fileRead: String -> BackendTask.Stream.Stream () () { read : (), write : Basics.Never }
-}
fileRead : String -> Elm.Expression
fileRead fileReadArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "fileRead"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "BackendTask", "Stream" ]
                               "Stream"
                               [ Type.unit
                               , Type.unit
                               , Type.record
                                   [ ( "read", Type.unit )
                                   , ( "write"
                                     , Type.namedWith [ "Basics" ] "Never" []
                                     )
                                   ]
                               ]
                          )
                     )
             }
        )
        [ Elm.string fileReadArg ]


{-| Write a Stream to a file.

    module WriteFile exposing (run)

    import BackendTask
    import BackendTask.Stream as Stream
    import Pages.Script as Script exposing (Script)

    run : Script
    run =
        Script.withoutCliOptions
            (Stream.fileRead "logs.txt"
                |> Stream.pipe (Stream.command "grep" [ "error" ])
                |> Stream.pipe (Stream.fileWrite "errors.txt")
            )

fileWrite: String -> BackendTask.Stream.Stream () () { read : Basics.Never, write : () }
-}
fileWrite : String -> Elm.Expression
fileWrite fileWriteArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "fileWrite"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "BackendTask", "Stream" ]
                               "Stream"
                               [ Type.unit
                               , Type.unit
                               , Type.record
                                   [ ( "read"
                                     , Type.namedWith [ "Basics" ] "Never" []
                                     )
                                   , ( "write", Type.unit )
                                   ]
                               ]
                          )
                     )
             }
        )
        [ Elm.string fileWriteArg ]


{-| A handy way to turn either a hardcoded String, or any other value from Elm into a Stream.

    module HelloWorld exposing (run)

    import BackendTask
    import BackendTask.Stream as Stream
    import Pages.Script as Script exposing (Script)

    run : Script
    run =
        Script.withoutCliOptions
            (Stream.fromString "Hello, World!"
                |> Stream.stdout
                |> Stream.run
                |> BackendTask.allowFatal
            )

A more programmatic use of `fromString` to use the result of a previous `BackendTask` to a `Stream`:

    module HelloWorld exposing (run)

    import BackendTask
    import BackendTask.Stream as Stream
    import Pages.Script as Script exposing (Script)

    run : Script
    run =
        Script.withoutCliOptions
            (Glob.fromString "src/**/*.elm"
                |> BackendTask.andThen
                    (\elmFiles ->
                        elmFiles
                            |> String.join ", "
                            |> Stream.fromString
                            |> Stream.pipe Stream.stdout
                            |> Stream.run
                    )
            )

fromString: String -> BackendTask.Stream.Stream () () { read : (), write : Basics.Never }
-}
fromString : String -> Elm.Expression
fromString fromStringArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "fromString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "BackendTask", "Stream" ]
                               "Stream"
                               [ Type.unit
                               , Type.unit
                               , Type.record
                                   [ ( "read", Type.unit )
                                   , ( "write"
                                     , Type.namedWith [ "Basics" ] "Never" []
                                     )
                                   ]
                               ]
                          )
                     )
             }
        )
        [ Elm.string fromStringArg ]


{-| Uses a regular HTTP request body (not a `Stream`). Streams the HTTP response body.

If you want to pass a stream as the request body, use [`httpWithInput`](#httpWithInput) instead.

If you don't need to stream the response body, you can use the functions from [`BackendTask.Http`](BackendTask-Http) instead.

http: 
    { url : String
    , method : String
    , headers : List ( String, String )
    , body : BackendTask.Http.Body
    , retries : Maybe Int
    , timeoutInMs : Maybe Int
    }
    -> BackendTask.Stream.Stream BackendTask.Http.Error BackendTask.Http.Metadata { read :
        ()
    , write : Basics.Never
    }
-}
http :
    { url : String
    , method : String
    , headers : List Elm.Expression
    , body : Elm.Expression
    , retries : Elm.Expression
    , timeoutInMs : Elm.Expression
    }
    -> Elm.Expression
http httpArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "http"
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
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Stream" ]
                               "Stream"
                               [ Type.namedWith
                                   [ "BackendTask", "Http" ]
                                   "Error"
                                   []
                               , Type.namedWith
                                   [ "BackendTask", "Http" ]
                                   "Metadata"
                                   []
                               , Type.record
                                   [ ( "read", Type.unit )
                                   , ( "write"
                                     , Type.namedWith [ "Basics" ] "Never" []
                                     )
                                   ]
                               ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "url" (Elm.string httpArg.url)
            , Tuple.pair "method" (Elm.string httpArg.method)
            , Tuple.pair "headers" (Elm.list httpArg.headers)
            , Tuple.pair "body" httpArg.body
            , Tuple.pair "retries" httpArg.retries
            , Tuple.pair "timeoutInMs" httpArg.timeoutInMs
            ]
        ]


{-| Streams the data from the input stream as the body of the HTTP request. The HTTP response body becomes the output stream.

httpWithInput: 
    { url : String
    , method : String
    , headers : List ( String, String )
    , retries : Maybe Int
    , timeoutInMs : Maybe Int
    }
    -> BackendTask.Stream.Stream BackendTask.Http.Error BackendTask.Http.Metadata { read :
        ()
    , write : ()
    }
-}
httpWithInput :
    { url : String
    , method : String
    , headers : List Elm.Expression
    , retries : Elm.Expression
    , timeoutInMs : Elm.Expression
    }
    -> Elm.Expression
httpWithInput httpWithInputArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "httpWithInput"
             , annotation =
                 Just
                     (Type.function
                          [ Type.record
                              [ ( "url", Type.string )
                              , ( "method", Type.string )
                              , ( "headers"
                                , Type.list (Type.tuple Type.string Type.string)
                                )
                              , ( "retries", Type.maybe Type.int )
                              , ( "timeoutInMs", Type.maybe Type.int )
                              ]
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Stream" ]
                               "Stream"
                               [ Type.namedWith
                                   [ "BackendTask", "Http" ]
                                   "Error"
                                   []
                               , Type.namedWith
                                   [ "BackendTask", "Http" ]
                                   "Metadata"
                                   []
                               , Type.record
                                   [ ( "read", Type.unit )
                                   , ( "write", Type.unit )
                                   ]
                               ]
                          )
                     )
             }
        )
        [ Elm.record
            [ Tuple.pair "url" (Elm.string httpWithInputArg.url)
            , Tuple.pair "method" (Elm.string httpWithInputArg.method)
            , Tuple.pair "headers" (Elm.list httpWithInputArg.headers)
            , Tuple.pair "retries" httpWithInputArg.retries
            , Tuple.pair "timeoutInMs" httpWithInputArg.timeoutInMs
            ]
        ]


{-| The `stdin` from the process. When you execute an `elm-pages` script, this will be the value that is piped in to it. For example, given this script module:

    module CountLines exposing (run)

    import BackendTask
    import BackendTask.Stream as Stream
    import Pages.Script as Script exposing (Script)

    run : Script
    run =
        Script.withoutCliOptions
            (Stream.stdin
                |> Stream.read
                |> BackendTask.allowFatal
                |> BackendTask.andThen
                    (\{ body } ->
                        body
                            |> String.lines
                            |> List.length
                            |> String.fromInt
                            |> Script.log
                    )
            )

If you run the script without any stdin, it will wait until stdin is closed.

```shell
elm-pages run script/src/CountLines.elm
# pressing ctrl-d (or your platform-specific way of closing stdin) will print the number of lines in the input
```

Or you can pipe to it and it will read that input:

```shell
ls | elm-pages run script/src/CountLines.elm
# prints the number of files in the current directory
```

stdin: BackendTask.Stream.Stream () () { read : (), write : Basics.Never }
-}
stdin : Elm.Expression
stdin =
    Elm.value
        { importFrom = [ "BackendTask", "Stream" ]
        , name = "stdin"
        , annotation =
            Just
                (Type.namedWith
                     [ "BackendTask", "Stream" ]
                     "Stream"
                     [ Type.unit
                     , Type.unit
                     , Type.record
                         [ ( "read", Type.unit )
                         , ( "write", Type.namedWith [ "Basics" ] "Never" [] )
                         ]
                     ]
                )
        }


{-| Streaming through to stdout can be a convenient way to print a pipeline directly without going through to Elm.

    module UnzipFile exposing (run)

    import BackendTask
    import BackendTask.Stream as Stream
    import Pages.Script as Script exposing (Script)

    run : Script
    run =
        Script.withoutCliOptions
            (Stream.fileRead "data.gzip.txt"
                |> Stream.pipe Stream.unzip
                |> Stream.pipe Stream.stdout
                |> Stream.run
                |> BackendTask.allowFatal
            )

stdout: BackendTask.Stream.Stream () () { read : Basics.Never, write : () }
-}
stdout : Elm.Expression
stdout =
    Elm.value
        { importFrom = [ "BackendTask", "Stream" ]
        , name = "stdout"
        , annotation =
            Just
                (Type.namedWith
                     [ "BackendTask", "Stream" ]
                     "Stream"
                     [ Type.unit
                     , Type.unit
                     , Type.record
                         [ ( "read", Type.namedWith [ "Basics" ] "Never" [] )
                         , ( "write", Type.unit )
                         ]
                     ]
                )
        }


{-| Similar to [`stdout`](#stdout), but writes to `stderr` instead.

stderr: BackendTask.Stream.Stream () () { read : Basics.Never, write : () }
-}
stderr : Elm.Expression
stderr =
    Elm.value
        { importFrom = [ "BackendTask", "Stream" ]
        , name = "stderr"
        , annotation =
            Just
                (Type.namedWith
                     [ "BackendTask", "Stream" ]
                     "Stream"
                     [ Type.unit
                     , Type.unit
                     , Type.record
                         [ ( "read", Type.namedWith [ "Basics" ] "Never" [] )
                         , ( "write", Type.unit )
                         ]
                     ]
                )
        }


{-| Read the body of the `Stream` as text.

read: 
    BackendTask.Stream.Stream error metadata { read : (), write : write }
    -> BackendTask.BackendTask { fatal : FatalError.FatalError
    , recoverable : BackendTask.Stream.Error error String
    } { metadata : metadata, body : String }
-}
read : Elm.Expression -> Elm.Expression
read readArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "read"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.var "error"
                              , Type.var "metadata"
                              , Type.record
                                    [ ( "read", Type.unit )
                                    , ( "write", Type.var "write" )
                                    ]
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
                                         [ "BackendTask", "Stream" ]
                                         "Error"
                                         [ Type.var "error", Type.string ]
                                     )
                                   ]
                               , Type.record
                                   [ ( "metadata", Type.var "metadata" )
                                   , ( "body", Type.string )
                                   ]
                               ]
                          )
                     )
             }
        )
        [ readArg ]


{-| Read the body of the `Stream` as JSON.

    module ReadJson exposing (run)

    import BackendTask
    import BackendTask.Stream as Stream
    import Json.Decode as Decode
    import Pages.Script as Script exposing (Script)

    run : Script
    run =
        Script.withoutCliOptions
            (Stream.fileRead "data.json"
                |> Stream.readJson (Decode.field "name" Decode.string)
                |> BackendTask.allowFatal
                |> BackendTask.andThen
                    (\{ body } ->
                        Script.log ("The name is: " ++ body)
                    )
            )

readJson: 
    Json.Decode.Decoder value
    -> BackendTask.Stream.Stream error metadata { read : (), write : write }
    -> BackendTask.BackendTask { fatal : FatalError.FatalError
    , recoverable : BackendTask.Stream.Error error value
    } { metadata : metadata, body : value }
-}
readJson : Elm.Expression -> Elm.Expression -> Elm.Expression
readJson readJsonArg readJsonArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "readJson"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.var "value" ]
                          , Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.var "error"
                              , Type.var "metadata"
                              , Type.record
                                    [ ( "read", Type.unit )
                                    , ( "write", Type.var "write" )
                                    ]
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
                                         [ "BackendTask", "Stream" ]
                                         "Error"
                                         [ Type.var "error", Type.var "value" ]
                                     )
                                   ]
                               , Type.record
                                   [ ( "metadata", Type.var "metadata" )
                                   , ( "body", Type.var "value" )
                                   ]
                               ]
                          )
                     )
             }
        )
        [ readJsonArg, readJsonArg0 ]


{-| Ignore the body of the `Stream`, while capturing the metadata from the final part of the Stream.

readMetadata: 
    BackendTask.Stream.Stream error metadata { read : read, write : write }
    -> BackendTask.BackendTask { fatal : FatalError.FatalError
    , recoverable : BackendTask.Stream.Error error String
    } metadata
-}
readMetadata : Elm.Expression -> Elm.Expression
readMetadata readMetadataArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "readMetadata"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.var "error"
                              , Type.var "metadata"
                              , Type.record
                                    [ ( "read", Type.var "read" )
                                    , ( "write", Type.var "write" )
                                    ]
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
                                         [ "BackendTask", "Stream" ]
                                         "Error"
                                         [ Type.var "error", Type.string ]
                                     )
                                   ]
                               , Type.var "metadata"
                               ]
                          )
                     )
             }
        )
        [ readMetadataArg ]


{-| Gives a `BackendTask` to execute the `Stream`, ignoring its body and metadata.

This is useful if you only want the side-effect from the `Stream` and don't need to programmatically use its
output. For example, if the end result you want is:

  - Printing to the console
  - Writing to a file
  - Making an HTTP request

If you need to read the output of the `Stream`, use [`read`](#read), [`readJson`](#readJson), or [`readMetadata`](#readMetadata) instead.

run: 
    BackendTask.Stream.Stream error metadata kind
    -> BackendTask.BackendTask FatalError.FatalError ()
-}
run : Elm.Expression -> Elm.Expression
run runArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "run"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.var "error"
                              , Type.var "metadata"
                              , Type.var "kind"
                              ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.namedWith [ "FatalError" ] "FatalError" []
                               , Type.unit
                               ]
                          )
                     )
             }
        )
        [ runArg ]


{-| Run a command (or `child_process`). The command's output becomes the body of the `Stream`.

command: 
    String
    -> List String
    -> BackendTask.Stream.Stream Int () { read : read, write : write }
-}
command : String -> List String -> Elm.Expression
command commandArg commandArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "command"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string, Type.list Type.string ]
                          (Type.namedWith
                               [ "BackendTask", "Stream" ]
                               "Stream"
                               [ Type.int
                               , Type.unit
                               , Type.record
                                   [ ( "read", Type.var "read" )
                                   , ( "write", Type.var "write" )
                                   ]
                               ]
                          )
                     )
             }
        )
        [ Elm.string commandArg, Elm.list (List.map Elm.string commandArg0) ]


{-| Pass in custom [`CommandOptions`](#CommandOptions) to configure the behavior of the command.

For example, `grep` will return a non-zero status code if it doesn't find any matches. To ignore the non-zero status code and proceed with
empty output, you can use `allowNon0Status`.

    module GrepErrors exposing (run)

    import BackendTask
    import BackendTask.Stream as Stream
    import Pages.Script as Script exposing (Script)

    run : Script
    run =
        Script.withoutCliOptions
            (Stream.fileRead "log.txt"
                |> Stream.pipe
                    (Stream.commandWithOptions
                        (Stream.defaultCommandOptions |> Stream.allowNon0Status)
                        "grep"
                        [ "error" ]
                    )
                |> Stream.pipe Stream.stdout
                |> Stream.run
            )

commandWithOptions: 
    BackendTask.Stream.CommandOptions
    -> String
    -> List String
    -> BackendTask.Stream.Stream Int () { read : read, write : write }
-}
commandWithOptions : Elm.Expression -> String -> List String -> Elm.Expression
commandWithOptions commandWithOptionsArg commandWithOptionsArg0 commandWithOptionsArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "commandWithOptions"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "CommandOptions"
                              []
                          , Type.string
                          , Type.list Type.string
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Stream" ]
                               "Stream"
                               [ Type.int
                               , Type.unit
                               , Type.record
                                   [ ( "read", Type.var "read" )
                                   , ( "write", Type.var "write" )
                                   ]
                               ]
                          )
                     )
             }
        )
        [ commandWithOptionsArg
        , Elm.string commandWithOptionsArg0
        , Elm.list (List.map Elm.string commandWithOptionsArg1)
        ]


{-| The default options that are used for [`command`](#command). Used to build up `CommandOptions`
to pass in to [`commandWithOptions`](#commandWithOptions).

defaultCommandOptions: BackendTask.Stream.CommandOptions
-}
defaultCommandOptions : Elm.Expression
defaultCommandOptions =
    Elm.value
        { importFrom = [ "BackendTask", "Stream" ]
        , name = "defaultCommandOptions"
        , annotation =
            Just
                (Type.namedWith [ "BackendTask", "Stream" ] "CommandOptions" [])
        }


{-| By default, the `Stream` will halt with an error if a command returns a non-zero status code.

With `allowNon0Status`, the stream will continue without an error if the command returns a non-zero status code.

allowNon0Status: BackendTask.Stream.CommandOptions -> BackendTask.Stream.CommandOptions
-}
allowNon0Status : Elm.Expression -> Elm.Expression
allowNon0Status allowNon0StatusArg =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "allowNon0Status"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "CommandOptions"
                              []
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Stream" ]
                               "CommandOptions"
                               []
                          )
                     )
             }
        )
        [ allowNon0StatusArg ]


{-| Configure the [`StderrOutput`](#StderrOutput) behavior.

withOutput: 
    BackendTask.Stream.StderrOutput
    -> BackendTask.Stream.CommandOptions
    -> BackendTask.Stream.CommandOptions
-}
withOutput : Elm.Expression -> Elm.Expression -> Elm.Expression
withOutput withOutputArg withOutputArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "withOutput"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "StderrOutput"
                              []
                          , Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "CommandOptions"
                              []
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Stream" ]
                               "CommandOptions"
                               []
                          )
                     )
             }
        )
        [ withOutputArg, withOutputArg0 ]


{-| By default, commands do not have a timeout. This will set the timeout, in milliseconds, for the given command. If that duration is exceeded,
the `Stream` will fail with an error.

withTimeout: Int -> BackendTask.Stream.CommandOptions -> BackendTask.Stream.CommandOptions
-}
withTimeout : Int -> Elm.Expression -> Elm.Expression
withTimeout withTimeoutArg withTimeoutArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "withTimeout"
             , annotation =
                 Just
                     (Type.function
                          [ Type.int
                          , Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "CommandOptions"
                              []
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Stream" ]
                               "CommandOptions"
                               []
                          )
                     )
             }
        )
        [ Elm.int withTimeoutArg, withTimeoutArg0 ]


{-| Transforms the input with gzip compression.

Under the hood this builds a Stream using Node's [`zlib.createGzip`](https://nodejs.org/api/zlib.html#zlibcreategzipoptions).

gzip: BackendTask.Stream.Stream () () { read : (), write : () }
-}
gzip : Elm.Expression
gzip =
    Elm.value
        { importFrom = [ "BackendTask", "Stream" ]
        , name = "gzip"
        , annotation =
            Just
                (Type.namedWith
                     [ "BackendTask", "Stream" ]
                     "Stream"
                     [ Type.unit
                     , Type.unit
                     , Type.record
                         [ ( "read", Type.unit ), ( "write", Type.unit ) ]
                     ]
                )
        }


{-| Transforms the input by auto-detecting the header and decompressing either a Gzip- or Deflate-compressed stream.

Under the hood, this builds a Stream using Node's [`zlib.createUnzip`](https://nodejs.org/api/zlib.html#zlibcreateunzip).

unzip: BackendTask.Stream.Stream () () { read : (), write : () }
-}
unzip : Elm.Expression
unzip =
    Elm.value
        { importFrom = [ "BackendTask", "Stream" ]
        , name = "unzip"
        , annotation =
            Just
                (Type.namedWith
                     [ "BackendTask", "Stream" ]
                     "Stream"
                     [ Type.unit
                     , Type.unit
                     , Type.record
                         [ ( "read", Type.unit ), ( "write", Type.unit ) ]
                     ]
                )
        }


{-| Calls an async function from your `custom-backend-task` definitions and uses the NodeJS `ReadableStream` it returns.

customRead: 
    String
    -> Json.Encode.Value
    -> BackendTask.Stream.Stream () () { read : (), write : Basics.Never }
-}
customRead : String -> Elm.Expression -> Elm.Expression
customRead customReadArg customReadArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "customRead"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Json", "Encode" ] "Value" []
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Stream" ]
                               "Stream"
                               [ Type.unit
                               , Type.unit
                               , Type.record
                                   [ ( "read", Type.unit )
                                   , ( "write"
                                     , Type.namedWith [ "Basics" ] "Never" []
                                     )
                                   ]
                               ]
                          )
                     )
             }
        )
        [ Elm.string customReadArg, customReadArg0 ]


{-| Calls an async function from your `custom-backend-task` definitions and uses the NodeJS `WritableStream` it returns.

customWrite: 
    String
    -> Json.Encode.Value
    -> BackendTask.Stream.Stream () () { read : Basics.Never, write : () }
-}
customWrite : String -> Elm.Expression -> Elm.Expression
customWrite customWriteArg customWriteArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "customWrite"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Json", "Encode" ] "Value" []
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Stream" ]
                               "Stream"
                               [ Type.unit
                               , Type.unit
                               , Type.record
                                   [ ( "read"
                                     , Type.namedWith [ "Basics" ] "Never" []
                                     )
                                   , ( "write", Type.unit )
                                   ]
                               ]
                          )
                     )
             }
        )
        [ Elm.string customWriteArg, customWriteArg0 ]


{-| Calls an async function from your `custom-backend-task` definitions and uses the NodeJS `DuplexStream` it returns.

customDuplex: 
    String
    -> Json.Encode.Value
    -> BackendTask.Stream.Stream () () { read : (), write : () }
-}
customDuplex : String -> Elm.Expression -> Elm.Expression
customDuplex customDuplexArg customDuplexArg0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "customDuplex"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Json", "Encode" ] "Value" []
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Stream" ]
                               "Stream"
                               [ Type.unit
                               , Type.unit
                               , Type.record
                                   [ ( "read", Type.unit )
                                   , ( "write", Type.unit )
                                   ]
                               ]
                          )
                     )
             }
        )
        [ Elm.string customDuplexArg, customDuplexArg0 ]


{-| Calls an async function from your `custom-backend-task` definitions and uses the NodeJS `DuplexStream` it returns.

customReadWithMeta: 
    String
    -> Json.Encode.Value
    -> Json.Decode.Decoder (Result.Result { fatal : FatalError.FatalError
    , recoverable : error
    } metadata)
    -> BackendTask.Stream.Stream error metadata { read : (), write : Basics.Never }
-}
customReadWithMeta :
    String -> Elm.Expression -> Elm.Expression -> Elm.Expression
customReadWithMeta customReadWithMetaArg customReadWithMetaArg0 customReadWithMetaArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "customReadWithMeta"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Json", "Encode" ] "Value" []
                          , Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.record
                                        [ ( "fatal"
                                          , Type.namedWith
                                              [ "FatalError" ]
                                              "FatalError"
                                              []
                                          )
                                        , ( "recoverable", Type.var "error" )
                                        ]
                                    , Type.var "metadata"
                                    ]
                              ]
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Stream" ]
                               "Stream"
                               [ Type.var "error"
                               , Type.var "metadata"
                               , Type.record
                                   [ ( "read", Type.unit )
                                   , ( "write"
                                     , Type.namedWith [ "Basics" ] "Never" []
                                     )
                                   ]
                               ]
                          )
                     )
             }
        )
        [ Elm.string customReadWithMetaArg
        , customReadWithMetaArg0
        , customReadWithMetaArg1
        ]


{-| Calls an async function from your `custom-backend-task` definitions and uses the NodeJS `DuplexStream` and metadata function it returns.

customTransformWithMeta: 
    String
    -> Json.Encode.Value
    -> Json.Decode.Decoder (Result.Result { fatal : FatalError.FatalError
    , recoverable : error
    } metadata)
    -> BackendTask.Stream.Stream error metadata { read : (), write : () }
-}
customTransformWithMeta :
    String -> Elm.Expression -> Elm.Expression -> Elm.Expression
customTransformWithMeta customTransformWithMetaArg customTransformWithMetaArg0 customTransformWithMetaArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "customTransformWithMeta"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Json", "Encode" ] "Value" []
                          , Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.record
                                        [ ( "fatal"
                                          , Type.namedWith
                                              [ "FatalError" ]
                                              "FatalError"
                                              []
                                          )
                                        , ( "recoverable", Type.var "error" )
                                        ]
                                    , Type.var "metadata"
                                    ]
                              ]
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Stream" ]
                               "Stream"
                               [ Type.var "error"
                               , Type.var "metadata"
                               , Type.record
                                   [ ( "read", Type.unit )
                                   , ( "write", Type.unit )
                                   ]
                               ]
                          )
                     )
             }
        )
        [ Elm.string customTransformWithMetaArg
        , customTransformWithMetaArg0
        , customTransformWithMetaArg1
        ]


{-| Calls an async function from your `custom-backend-task` definitions and uses the NodeJS `WritableStream` and metadata function it returns.

customWriteWithMeta: 
    String
    -> Json.Encode.Value
    -> Json.Decode.Decoder (Result.Result { fatal : FatalError.FatalError
    , recoverable : error
    } metadata)
    -> BackendTask.Stream.Stream error metadata { read : Basics.Never, write : () }
-}
customWriteWithMeta :
    String -> Elm.Expression -> Elm.Expression -> Elm.Expression
customWriteWithMeta customWriteWithMetaArg customWriteWithMetaArg0 customWriteWithMetaArg1 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Stream" ]
             , name = "customWriteWithMeta"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string
                          , Type.namedWith [ "Json", "Encode" ] "Value" []
                          , Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.namedWith
                                    [ "Result" ]
                                    "Result"
                                    [ Type.record
                                        [ ( "fatal"
                                          , Type.namedWith
                                              [ "FatalError" ]
                                              "FatalError"
                                              []
                                          )
                                        , ( "recoverable", Type.var "error" )
                                        ]
                                    , Type.var "metadata"
                                    ]
                              ]
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Stream" ]
                               "Stream"
                               [ Type.var "error"
                               , Type.var "metadata"
                               , Type.record
                                   [ ( "read"
                                     , Type.namedWith [ "Basics" ] "Never" []
                                     )
                                   , ( "write", Type.unit )
                                   ]
                               ]
                          )
                     )
             }
        )
        [ Elm.string customWriteWithMetaArg
        , customWriteWithMetaArg0
        , customWriteWithMetaArg1
        ]


annotation_ :
    { stream :
        Type.Annotation -> Type.Annotation -> Type.Annotation -> Type.Annotation
    , error : Type.Annotation -> Type.Annotation -> Type.Annotation
    , stderrOutput : Type.Annotation
    , commandOptions : Type.Annotation
    }
annotation_ =
    { stream =
        \streamArg0 streamArg1 streamArg2 ->
            Type.namedWith
                [ "BackendTask", "Stream" ]
                "Stream"
                [ streamArg0, streamArg1, streamArg2 ]
    , error =
        \errorArg0 errorArg1 ->
            Type.namedWith
                [ "BackendTask", "Stream" ]
                "Error"
                [ errorArg0, errorArg1 ]
    , stderrOutput =
        Type.namedWith [ "BackendTask", "Stream" ] "StderrOutput" []
    , commandOptions =
        Type.namedWith [ "BackendTask", "Stream" ] "CommandOptions" []
    }


make_ :
    { streamError : Elm.Expression -> Elm.Expression
    , customError : Elm.Expression -> Elm.Expression -> Elm.Expression
    , printStderr : Elm.Expression
    , ignoreStderr : Elm.Expression
    , mergeStderrAndStdout : Elm.Expression
    , stderrInsteadOfStdout : Elm.Expression
    }
make_ =
    { streamError =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "StreamError"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Error"
                                  [ Type.var "error", Type.var "body" ]
                             )
                     }
                )
                [ ar0 ]
    , customError =
        \ar0 ar1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "CustomError"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "Error"
                                  [ Type.var "error", Type.var "body" ]
                             )
                     }
                )
                [ ar0, ar1 ]
    , printStderr =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "PrintStderr"
            , annotation = Just (Type.namedWith [] "StderrOutput" [])
            }
    , ignoreStderr =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "IgnoreStderr"
            , annotation = Just (Type.namedWith [] "StderrOutput" [])
            }
    , mergeStderrAndStdout =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "MergeStderrAndStdout"
            , annotation = Just (Type.namedWith [] "StderrOutput" [])
            }
    , stderrInsteadOfStdout =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "StderrInsteadOfStdout"
            , annotation = Just (Type.namedWith [] "StderrOutput" [])
            }
    }


caseOf_ :
    { error :
        Elm.Expression
        -> { errorTags_0_0
            | streamError : Elm.Expression -> Elm.Expression
            , customError : Elm.Expression -> Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    , stderrOutput :
        Elm.Expression
        -> { stderrOutputTags_1_0
            | printStderr : Elm.Expression
            , ignoreStderr : Elm.Expression
            , mergeStderrAndStdout : Elm.Expression
            , stderrInsteadOfStdout : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { error =
        \errorExpression errorTags ->
            Elm.Case.custom
                errorExpression
                (Type.namedWith
                     [ "BackendTask", "Stream" ]
                     "Error"
                     [ Type.var "error", Type.var "body" ]
                )
                [ Elm.Case.branch1
                    "StreamError"
                    ( "stringString", Type.string )
                    errorTags.streamError
                , Elm.Case.branch2
                    "CustomError"
                    ( "error", Type.var "error" )
                    ( "maybeMaybe", Type.maybe (Type.var "body") )
                    errorTags.customError
                ]
    , stderrOutput =
        \stderrOutputExpression stderrOutputTags ->
            Elm.Case.custom
                stderrOutputExpression
                (Type.namedWith [ "BackendTask", "Stream" ] "StderrOutput" [])
                [ Elm.Case.branch0 "PrintStderr" stderrOutputTags.printStderr
                , Elm.Case.branch0 "IgnoreStderr" stderrOutputTags.ignoreStderr
                , Elm.Case.branch0
                    "MergeStderrAndStdout"
                    stderrOutputTags.mergeStderrAndStdout
                , Elm.Case.branch0
                    "StderrInsteadOfStdout"
                    stderrOutputTags.stderrInsteadOfStdout
                ]
    }


call_ :
    { pipe : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fileRead : Elm.Expression -> Elm.Expression
    , fileWrite : Elm.Expression -> Elm.Expression
    , fromString : Elm.Expression -> Elm.Expression
    , http : Elm.Expression -> Elm.Expression
    , httpWithInput : Elm.Expression -> Elm.Expression
    , read : Elm.Expression -> Elm.Expression
    , readJson : Elm.Expression -> Elm.Expression -> Elm.Expression
    , readMetadata : Elm.Expression -> Elm.Expression
    , run : Elm.Expression -> Elm.Expression
    , command : Elm.Expression -> Elm.Expression -> Elm.Expression
    , commandWithOptions :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , allowNon0Status : Elm.Expression -> Elm.Expression
    , withOutput : Elm.Expression -> Elm.Expression -> Elm.Expression
    , withTimeout : Elm.Expression -> Elm.Expression -> Elm.Expression
    , customRead : Elm.Expression -> Elm.Expression -> Elm.Expression
    , customWrite : Elm.Expression -> Elm.Expression -> Elm.Expression
    , customDuplex : Elm.Expression -> Elm.Expression -> Elm.Expression
    , customReadWithMeta :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , customTransformWithMeta :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    , customWriteWithMeta :
        Elm.Expression -> Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { pipe =
        \pipeArg pipeArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "pipe"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask", "Stream" ]
                                      "Stream"
                                      [ Type.var "errorTo"
                                      , Type.var "metaTo"
                                      , Type.record
                                            [ ( "read", Type.var "toReadable" )
                                            , ( "write", Type.unit )
                                            ]
                                      ]
                                  , Type.namedWith
                                      [ "BackendTask", "Stream" ]
                                      "Stream"
                                      [ Type.var "errorFrom"
                                      , Type.var "metaFrom"
                                      , Type.record
                                            [ ( "read", Type.unit )
                                            , ( "write"
                                              , Type.var "fromWriteable"
                                              )
                                            ]
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Stream" ]
                                       "Stream"
                                       [ Type.var "errorTo"
                                       , Type.var "metaTo"
                                       , Type.record
                                           [ ( "read", Type.var "toReadable" )
                                           , ( "write"
                                             , Type.var "fromWriteable"
                                             )
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ pipeArg, pipeArg0 ]
    , fileRead =
        \fileReadArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "fileRead"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "BackendTask", "Stream" ]
                                       "Stream"
                                       [ Type.unit
                                       , Type.unit
                                       , Type.record
                                           [ ( "read", Type.unit )
                                           , ( "write"
                                             , Type.namedWith
                                                 [ "Basics" ]
                                                 "Never"
                                                 []
                                             )
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ fileReadArg ]
    , fileWrite =
        \fileWriteArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "fileWrite"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "BackendTask", "Stream" ]
                                       "Stream"
                                       [ Type.unit
                                       , Type.unit
                                       , Type.record
                                           [ ( "read"
                                             , Type.namedWith
                                                 [ "Basics" ]
                                                 "Never"
                                                 []
                                             )
                                           , ( "write", Type.unit )
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ fileWriteArg ]
    , fromString =
        \fromStringArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "fromString"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "BackendTask", "Stream" ]
                                       "Stream"
                                       [ Type.unit
                                       , Type.unit
                                       , Type.record
                                           [ ( "read", Type.unit )
                                           , ( "write"
                                             , Type.namedWith
                                                 [ "Basics" ]
                                                 "Never"
                                                 []
                                             )
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ fromStringArg ]
    , http =
        \httpArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "http"
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
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Stream" ]
                                       "Stream"
                                       [ Type.namedWith
                                           [ "BackendTask", "Http" ]
                                           "Error"
                                           []
                                       , Type.namedWith
                                           [ "BackendTask", "Http" ]
                                           "Metadata"
                                           []
                                       , Type.record
                                           [ ( "read", Type.unit )
                                           , ( "write"
                                             , Type.namedWith
                                                 [ "Basics" ]
                                                 "Never"
                                                 []
                                             )
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ httpArg ]
    , httpWithInput =
        \httpWithInputArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "httpWithInput"
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
                                      , ( "retries", Type.maybe Type.int )
                                      , ( "timeoutInMs", Type.maybe Type.int )
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Stream" ]
                                       "Stream"
                                       [ Type.namedWith
                                           [ "BackendTask", "Http" ]
                                           "Error"
                                           []
                                       , Type.namedWith
                                           [ "BackendTask", "Http" ]
                                           "Metadata"
                                           []
                                       , Type.record
                                           [ ( "read", Type.unit )
                                           , ( "write", Type.unit )
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ httpWithInputArg ]
    , read =
        \readArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "read"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask", "Stream" ]
                                      "Stream"
                                      [ Type.var "error"
                                      , Type.var "metadata"
                                      , Type.record
                                            [ ( "read", Type.unit )
                                            , ( "write", Type.var "write" )
                                            ]
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
                                                 [ "BackendTask", "Stream" ]
                                                 "Error"
                                                 [ Type.var "error"
                                                 , Type.string
                                                 ]
                                             )
                                           ]
                                       , Type.record
                                           [ ( "metadata", Type.var "metadata" )
                                           , ( "body", Type.string )
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ readArg ]
    , readJson =
        \readJsonArg readJsonArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "readJson"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Decoder"
                                      [ Type.var "value" ]
                                  , Type.namedWith
                                      [ "BackendTask", "Stream" ]
                                      "Stream"
                                      [ Type.var "error"
                                      , Type.var "metadata"
                                      , Type.record
                                            [ ( "read", Type.unit )
                                            , ( "write", Type.var "write" )
                                            ]
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
                                                 [ "BackendTask", "Stream" ]
                                                 "Error"
                                                 [ Type.var "error"
                                                 , Type.var "value"
                                                 ]
                                             )
                                           ]
                                       , Type.record
                                           [ ( "metadata", Type.var "metadata" )
                                           , ( "body", Type.var "value" )
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ readJsonArg, readJsonArg0 ]
    , readMetadata =
        \readMetadataArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "readMetadata"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask", "Stream" ]
                                      "Stream"
                                      [ Type.var "error"
                                      , Type.var "metadata"
                                      , Type.record
                                            [ ( "read", Type.var "read" )
                                            , ( "write", Type.var "write" )
                                            ]
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
                                                 [ "BackendTask", "Stream" ]
                                                 "Error"
                                                 [ Type.var "error"
                                                 , Type.string
                                                 ]
                                             )
                                           ]
                                       , Type.var "metadata"
                                       ]
                                  )
                             )
                     }
                )
                [ readMetadataArg ]
    , run =
        \runArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "run"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask", "Stream" ]
                                      "Stream"
                                      [ Type.var "error"
                                      , Type.var "metadata"
                                      , Type.var "kind"
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.namedWith
                                           [ "FatalError" ]
                                           "FatalError"
                                           []
                                       , Type.unit
                                       ]
                                  )
                             )
                     }
                )
                [ runArg ]
    , command =
        \commandArg commandArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "command"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string, Type.list Type.string ]
                                  (Type.namedWith
                                       [ "BackendTask", "Stream" ]
                                       "Stream"
                                       [ Type.int
                                       , Type.unit
                                       , Type.record
                                           [ ( "read", Type.var "read" )
                                           , ( "write", Type.var "write" )
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ commandArg, commandArg0 ]
    , commandWithOptions =
        \commandWithOptionsArg commandWithOptionsArg0 commandWithOptionsArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "commandWithOptions"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask", "Stream" ]
                                      "CommandOptions"
                                      []
                                  , Type.string
                                  , Type.list Type.string
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Stream" ]
                                       "Stream"
                                       [ Type.int
                                       , Type.unit
                                       , Type.record
                                           [ ( "read", Type.var "read" )
                                           , ( "write", Type.var "write" )
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ commandWithOptionsArg
                , commandWithOptionsArg0
                , commandWithOptionsArg1
                ]
    , allowNon0Status =
        \allowNon0StatusArg ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "allowNon0Status"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask", "Stream" ]
                                      "CommandOptions"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Stream" ]
                                       "CommandOptions"
                                       []
                                  )
                             )
                     }
                )
                [ allowNon0StatusArg ]
    , withOutput =
        \withOutputArg withOutputArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "withOutput"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask", "Stream" ]
                                      "StderrOutput"
                                      []
                                  , Type.namedWith
                                      [ "BackendTask", "Stream" ]
                                      "CommandOptions"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Stream" ]
                                       "CommandOptions"
                                       []
                                  )
                             )
                     }
                )
                [ withOutputArg, withOutputArg0 ]
    , withTimeout =
        \withTimeoutArg withTimeoutArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "withTimeout"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.int
                                  , Type.namedWith
                                      [ "BackendTask", "Stream" ]
                                      "CommandOptions"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Stream" ]
                                       "CommandOptions"
                                       []
                                  )
                             )
                     }
                )
                [ withTimeoutArg, withTimeoutArg0 ]
    , customRead =
        \customReadArg customReadArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "customRead"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Json", "Encode" ]
                                      "Value"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Stream" ]
                                       "Stream"
                                       [ Type.unit
                                       , Type.unit
                                       , Type.record
                                           [ ( "read", Type.unit )
                                           , ( "write"
                                             , Type.namedWith
                                                 [ "Basics" ]
                                                 "Never"
                                                 []
                                             )
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ customReadArg, customReadArg0 ]
    , customWrite =
        \customWriteArg customWriteArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "customWrite"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Json", "Encode" ]
                                      "Value"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Stream" ]
                                       "Stream"
                                       [ Type.unit
                                       , Type.unit
                                       , Type.record
                                           [ ( "read"
                                             , Type.namedWith
                                                 [ "Basics" ]
                                                 "Never"
                                                 []
                                             )
                                           , ( "write", Type.unit )
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ customWriteArg, customWriteArg0 ]
    , customDuplex =
        \customDuplexArg customDuplexArg0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "customDuplex"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Json", "Encode" ]
                                      "Value"
                                      []
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Stream" ]
                                       "Stream"
                                       [ Type.unit
                                       , Type.unit
                                       , Type.record
                                           [ ( "read", Type.unit )
                                           , ( "write", Type.unit )
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ customDuplexArg, customDuplexArg0 ]
    , customReadWithMeta =
        \customReadWithMetaArg customReadWithMetaArg0 customReadWithMetaArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "customReadWithMeta"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Json", "Encode" ]
                                      "Value"
                                      []
                                  , Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Decoder"
                                      [ Type.namedWith
                                            [ "Result" ]
                                            "Result"
                                            [ Type.record
                                                [ ( "fatal"
                                                  , Type.namedWith
                                                      [ "FatalError" ]
                                                      "FatalError"
                                                      []
                                                  )
                                                , ( "recoverable"
                                                  , Type.var "error"
                                                  )
                                                ]
                                            , Type.var "metadata"
                                            ]
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Stream" ]
                                       "Stream"
                                       [ Type.var "error"
                                       , Type.var "metadata"
                                       , Type.record
                                           [ ( "read", Type.unit )
                                           , ( "write"
                                             , Type.namedWith
                                                 [ "Basics" ]
                                                 "Never"
                                                 []
                                             )
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ customReadWithMetaArg
                , customReadWithMetaArg0
                , customReadWithMetaArg1
                ]
    , customTransformWithMeta =
        \customTransformWithMetaArg customTransformWithMetaArg0 customTransformWithMetaArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "customTransformWithMeta"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Json", "Encode" ]
                                      "Value"
                                      []
                                  , Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Decoder"
                                      [ Type.namedWith
                                            [ "Result" ]
                                            "Result"
                                            [ Type.record
                                                [ ( "fatal"
                                                  , Type.namedWith
                                                      [ "FatalError" ]
                                                      "FatalError"
                                                      []
                                                  )
                                                , ( "recoverable"
                                                  , Type.var "error"
                                                  )
                                                ]
                                            , Type.var "metadata"
                                            ]
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Stream" ]
                                       "Stream"
                                       [ Type.var "error"
                                       , Type.var "metadata"
                                       , Type.record
                                           [ ( "read", Type.unit )
                                           , ( "write", Type.unit )
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ customTransformWithMetaArg
                , customTransformWithMetaArg0
                , customTransformWithMetaArg1
                ]
    , customWriteWithMeta =
        \customWriteWithMetaArg customWriteWithMetaArg0 customWriteWithMetaArg1 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Stream" ]
                     , name = "customWriteWithMeta"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string
                                  , Type.namedWith
                                      [ "Json", "Encode" ]
                                      "Value"
                                      []
                                  , Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Decoder"
                                      [ Type.namedWith
                                            [ "Result" ]
                                            "Result"
                                            [ Type.record
                                                [ ( "fatal"
                                                  , Type.namedWith
                                                      [ "FatalError" ]
                                                      "FatalError"
                                                      []
                                                  )
                                                , ( "recoverable"
                                                  , Type.var "error"
                                                  )
                                                ]
                                            , Type.var "metadata"
                                            ]
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Stream" ]
                                       "Stream"
                                       [ Type.var "error"
                                       , Type.var "metadata"
                                       , Type.record
                                           [ ( "read"
                                             , Type.namedWith
                                                 [ "Basics" ]
                                                 "Never"
                                                 []
                                             )
                                           , ( "write", Type.unit )
                                           ]
                                       ]
                                  )
                             )
                     }
                )
                [ customWriteWithMetaArg
                , customWriteWithMetaArg0
                , customWriteWithMetaArg1
                ]
    }


values_ :
    { pipe : Elm.Expression
    , fileRead : Elm.Expression
    , fileWrite : Elm.Expression
    , fromString : Elm.Expression
    , http : Elm.Expression
    , httpWithInput : Elm.Expression
    , stdin : Elm.Expression
    , stdout : Elm.Expression
    , stderr : Elm.Expression
    , read : Elm.Expression
    , readJson : Elm.Expression
    , readMetadata : Elm.Expression
    , run : Elm.Expression
    , command : Elm.Expression
    , commandWithOptions : Elm.Expression
    , defaultCommandOptions : Elm.Expression
    , allowNon0Status : Elm.Expression
    , withOutput : Elm.Expression
    , withTimeout : Elm.Expression
    , gzip : Elm.Expression
    , unzip : Elm.Expression
    , customRead : Elm.Expression
    , customWrite : Elm.Expression
    , customDuplex : Elm.Expression
    , customReadWithMeta : Elm.Expression
    , customTransformWithMeta : Elm.Expression
    , customWriteWithMeta : Elm.Expression
    }
values_ =
    { pipe =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "pipe"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask", "Stream" ]
                             "Stream"
                             [ Type.var "errorTo"
                             , Type.var "metaTo"
                             , Type.record
                                   [ ( "read", Type.var "toReadable" )
                                   , ( "write", Type.unit )
                                   ]
                             ]
                         , Type.namedWith
                             [ "BackendTask", "Stream" ]
                             "Stream"
                             [ Type.var "errorFrom"
                             , Type.var "metaFrom"
                             , Type.record
                                   [ ( "read", Type.unit )
                                   , ( "write", Type.var "fromWriteable" )
                                   ]
                             ]
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.var "errorTo"
                              , Type.var "metaTo"
                              , Type.record
                                  [ ( "read", Type.var "toReadable" )
                                  , ( "write", Type.var "fromWriteable" )
                                  ]
                              ]
                         )
                    )
            }
    , fileRead =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "fileRead"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.unit
                              , Type.unit
                              , Type.record
                                  [ ( "read", Type.unit )
                                  , ( "write"
                                    , Type.namedWith [ "Basics" ] "Never" []
                                    )
                                  ]
                              ]
                         )
                    )
            }
    , fileWrite =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "fileWrite"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.unit
                              , Type.unit
                              , Type.record
                                  [ ( "read"
                                    , Type.namedWith [ "Basics" ] "Never" []
                                    )
                                  , ( "write", Type.unit )
                                  ]
                              ]
                         )
                    )
            }
    , fromString =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "fromString"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.unit
                              , Type.unit
                              , Type.record
                                  [ ( "read", Type.unit )
                                  , ( "write"
                                    , Type.namedWith [ "Basics" ] "Never" []
                                    )
                                  ]
                              ]
                         )
                    )
            }
    , http =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "http"
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
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.namedWith
                                  [ "BackendTask", "Http" ]
                                  "Error"
                                  []
                              , Type.namedWith
                                  [ "BackendTask", "Http" ]
                                  "Metadata"
                                  []
                              , Type.record
                                  [ ( "read", Type.unit )
                                  , ( "write"
                                    , Type.namedWith [ "Basics" ] "Never" []
                                    )
                                  ]
                              ]
                         )
                    )
            }
    , httpWithInput =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "httpWithInput"
            , annotation =
                Just
                    (Type.function
                         [ Type.record
                             [ ( "url", Type.string )
                             , ( "method", Type.string )
                             , ( "headers"
                               , Type.list (Type.tuple Type.string Type.string)
                               )
                             , ( "retries", Type.maybe Type.int )
                             , ( "timeoutInMs", Type.maybe Type.int )
                             ]
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.namedWith
                                  [ "BackendTask", "Http" ]
                                  "Error"
                                  []
                              , Type.namedWith
                                  [ "BackendTask", "Http" ]
                                  "Metadata"
                                  []
                              , Type.record
                                  [ ( "read", Type.unit )
                                  , ( "write", Type.unit )
                                  ]
                              ]
                         )
                    )
            }
    , stdin =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "stdin"
            , annotation =
                Just
                    (Type.namedWith
                         [ "BackendTask", "Stream" ]
                         "Stream"
                         [ Type.unit
                         , Type.unit
                         , Type.record
                             [ ( "read", Type.unit )
                             , ( "write"
                               , Type.namedWith [ "Basics" ] "Never" []
                               )
                             ]
                         ]
                    )
            }
    , stdout =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "stdout"
            , annotation =
                Just
                    (Type.namedWith
                         [ "BackendTask", "Stream" ]
                         "Stream"
                         [ Type.unit
                         , Type.unit
                         , Type.record
                             [ ( "read"
                               , Type.namedWith [ "Basics" ] "Never" []
                               )
                             , ( "write", Type.unit )
                             ]
                         ]
                    )
            }
    , stderr =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "stderr"
            , annotation =
                Just
                    (Type.namedWith
                         [ "BackendTask", "Stream" ]
                         "Stream"
                         [ Type.unit
                         , Type.unit
                         , Type.record
                             [ ( "read"
                               , Type.namedWith [ "Basics" ] "Never" []
                               )
                             , ( "write", Type.unit )
                             ]
                         ]
                    )
            }
    , read =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "read"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask", "Stream" ]
                             "Stream"
                             [ Type.var "error"
                             , Type.var "metadata"
                             , Type.record
                                   [ ( "read", Type.unit )
                                   , ( "write", Type.var "write" )
                                   ]
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
                                        [ "BackendTask", "Stream" ]
                                        "Error"
                                        [ Type.var "error", Type.string ]
                                    )
                                  ]
                              , Type.record
                                  [ ( "metadata", Type.var "metadata" )
                                  , ( "body", Type.string )
                                  ]
                              ]
                         )
                    )
            }
    , readJson =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "readJson"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Json", "Decode" ]
                             "Decoder"
                             [ Type.var "value" ]
                         , Type.namedWith
                             [ "BackendTask", "Stream" ]
                             "Stream"
                             [ Type.var "error"
                             , Type.var "metadata"
                             , Type.record
                                   [ ( "read", Type.unit )
                                   , ( "write", Type.var "write" )
                                   ]
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
                                        [ "BackendTask", "Stream" ]
                                        "Error"
                                        [ Type.var "error", Type.var "value" ]
                                    )
                                  ]
                              , Type.record
                                  [ ( "metadata", Type.var "metadata" )
                                  , ( "body", Type.var "value" )
                                  ]
                              ]
                         )
                    )
            }
    , readMetadata =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "readMetadata"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask", "Stream" ]
                             "Stream"
                             [ Type.var "error"
                             , Type.var "metadata"
                             , Type.record
                                   [ ( "read", Type.var "read" )
                                   , ( "write", Type.var "write" )
                                   ]
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
                                        [ "BackendTask", "Stream" ]
                                        "Error"
                                        [ Type.var "error", Type.string ]
                                    )
                                  ]
                              , Type.var "metadata"
                              ]
                         )
                    )
            }
    , run =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "run"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask", "Stream" ]
                             "Stream"
                             [ Type.var "error"
                             , Type.var "metadata"
                             , Type.var "kind"
                             ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.namedWith [ "FatalError" ] "FatalError" []
                              , Type.unit
                              ]
                         )
                    )
            }
    , command =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "command"
            , annotation =
                Just
                    (Type.function
                         [ Type.string, Type.list Type.string ]
                         (Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.int
                              , Type.unit
                              , Type.record
                                  [ ( "read", Type.var "read" )
                                  , ( "write", Type.var "write" )
                                  ]
                              ]
                         )
                    )
            }
    , commandWithOptions =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "commandWithOptions"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask", "Stream" ]
                             "CommandOptions"
                             []
                         , Type.string
                         , Type.list Type.string
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.int
                              , Type.unit
                              , Type.record
                                  [ ( "read", Type.var "read" )
                                  , ( "write", Type.var "write" )
                                  ]
                              ]
                         )
                    )
            }
    , defaultCommandOptions =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "defaultCommandOptions"
            , annotation =
                Just
                    (Type.namedWith
                         [ "BackendTask", "Stream" ]
                         "CommandOptions"
                         []
                    )
            }
    , allowNon0Status =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "allowNon0Status"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask", "Stream" ]
                             "CommandOptions"
                             []
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "CommandOptions"
                              []
                         )
                    )
            }
    , withOutput =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "withOutput"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask", "Stream" ]
                             "StderrOutput"
                             []
                         , Type.namedWith
                             [ "BackendTask", "Stream" ]
                             "CommandOptions"
                             []
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "CommandOptions"
                              []
                         )
                    )
            }
    , withTimeout =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "withTimeout"
            , annotation =
                Just
                    (Type.function
                         [ Type.int
                         , Type.namedWith
                             [ "BackendTask", "Stream" ]
                             "CommandOptions"
                             []
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "CommandOptions"
                              []
                         )
                    )
            }
    , gzip =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "gzip"
            , annotation =
                Just
                    (Type.namedWith
                         [ "BackendTask", "Stream" ]
                         "Stream"
                         [ Type.unit
                         , Type.unit
                         , Type.record
                             [ ( "read", Type.unit ), ( "write", Type.unit ) ]
                         ]
                    )
            }
    , unzip =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "unzip"
            , annotation =
                Just
                    (Type.namedWith
                         [ "BackendTask", "Stream" ]
                         "Stream"
                         [ Type.unit
                         , Type.unit
                         , Type.record
                             [ ( "read", Type.unit ), ( "write", Type.unit ) ]
                         ]
                    )
            }
    , customRead =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "customRead"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Json", "Encode" ] "Value" []
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.unit
                              , Type.unit
                              , Type.record
                                  [ ( "read", Type.unit )
                                  , ( "write"
                                    , Type.namedWith [ "Basics" ] "Never" []
                                    )
                                  ]
                              ]
                         )
                    )
            }
    , customWrite =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "customWrite"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Json", "Encode" ] "Value" []
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.unit
                              , Type.unit
                              , Type.record
                                  [ ( "read"
                                    , Type.namedWith [ "Basics" ] "Never" []
                                    )
                                  , ( "write", Type.unit )
                                  ]
                              ]
                         )
                    )
            }
    , customDuplex =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "customDuplex"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Json", "Encode" ] "Value" []
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.unit
                              , Type.unit
                              , Type.record
                                  [ ( "read", Type.unit )
                                  , ( "write", Type.unit )
                                  ]
                              ]
                         )
                    )
            }
    , customReadWithMeta =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "customReadWithMeta"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Json", "Encode" ] "Value" []
                         , Type.namedWith
                             [ "Json", "Decode" ]
                             "Decoder"
                             [ Type.namedWith
                                   [ "Result" ]
                                   "Result"
                                   [ Type.record
                                       [ ( "fatal"
                                         , Type.namedWith
                                             [ "FatalError" ]
                                             "FatalError"
                                             []
                                         )
                                       , ( "recoverable", Type.var "error" )
                                       ]
                                   , Type.var "metadata"
                                   ]
                             ]
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.var "error"
                              , Type.var "metadata"
                              , Type.record
                                  [ ( "read", Type.unit )
                                  , ( "write"
                                    , Type.namedWith [ "Basics" ] "Never" []
                                    )
                                  ]
                              ]
                         )
                    )
            }
    , customTransformWithMeta =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "customTransformWithMeta"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Json", "Encode" ] "Value" []
                         , Type.namedWith
                             [ "Json", "Decode" ]
                             "Decoder"
                             [ Type.namedWith
                                   [ "Result" ]
                                   "Result"
                                   [ Type.record
                                       [ ( "fatal"
                                         , Type.namedWith
                                             [ "FatalError" ]
                                             "FatalError"
                                             []
                                         )
                                       , ( "recoverable", Type.var "error" )
                                       ]
                                   , Type.var "metadata"
                                   ]
                             ]
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.var "error"
                              , Type.var "metadata"
                              , Type.record
                                  [ ( "read", Type.unit )
                                  , ( "write", Type.unit )
                                  ]
                              ]
                         )
                    )
            }
    , customWriteWithMeta =
        Elm.value
            { importFrom = [ "BackendTask", "Stream" ]
            , name = "customWriteWithMeta"
            , annotation =
                Just
                    (Type.function
                         [ Type.string
                         , Type.namedWith [ "Json", "Encode" ] "Value" []
                         , Type.namedWith
                             [ "Json", "Decode" ]
                             "Decoder"
                             [ Type.namedWith
                                   [ "Result" ]
                                   "Result"
                                   [ Type.record
                                       [ ( "fatal"
                                         , Type.namedWith
                                             [ "FatalError" ]
                                             "FatalError"
                                             []
                                         )
                                       , ( "recoverable", Type.var "error" )
                                       ]
                                   , Type.var "metadata"
                                   ]
                             ]
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Stream" ]
                              "Stream"
                              [ Type.var "error"
                              , Type.var "metadata"
                              , Type.record
                                  [ ( "read"
                                    , Type.namedWith [ "Basics" ] "Never" []
                                    )
                                  , ( "write", Type.unit )
                                  ]
                              ]
                         )
                    )
            }
    }