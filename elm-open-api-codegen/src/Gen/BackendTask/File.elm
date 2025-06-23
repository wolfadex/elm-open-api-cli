module Gen.BackendTask.File exposing
    ( moduleName_, bodyWithFrontmatter, bodyWithoutFrontmatter, onlyFrontmatter, jsonFile, rawFile
    , annotation_, make_, caseOf_, call_, values_
    )

{-|
# Generated bindings for BackendTask.File

@docs moduleName_, bodyWithFrontmatter, bodyWithoutFrontmatter, onlyFrontmatter, jsonFile, rawFile
@docs annotation_, make_, caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "BackendTask", "File" ]


{-| import BackendTask exposing (BackendTask)
    import BackendTask.File as File
    import FatalError exposing (FatalError)
    import Json.Decode as Decode exposing (Decoder)

    blogPost : BackendTask FatalError BlogPostMetadata
    blogPost =
        File.bodyWithFrontmatter blogPostDecoder
            "blog/hello-world.md"
            |> BackendTask.allowFatal

    type alias BlogPostMetadata =
        { body : String
        , title : String
        , tags : List String
        }

    blogPostDecoder : String -> Decoder BlogPostMetadata
    blogPostDecoder body =
        Decode.map2 (BlogPostMetadata body)
            (Decode.field "title" Decode.string)
            (Decode.field "tags" tagsDecoder)

    tagsDecoder : Decoder (List String)
    tagsDecoder =
        Decode.map (String.split " ")
            Decode.string

This will give us a BackendTask that results in the following value:

    value =
        { body = "Hey there! This is my first post :)"
        , title = "Hello, World!"
        , tags = [ "elm" ]
        }

It's common to parse the body with a markdown parser or other format.

    import BackendTask exposing (BackendTask)
    import BackendTask.File as File
    import FatalError exposing (FatalError)
    import Html exposing (Html)
    import Json.Decode as Decode

    example :
        BackendTask
            FatalError
            { title : String
            , body : List (Html msg)
            }
    example =
        File.bodyWithFrontmatter
            (\markdownString ->
                Decode.map2
                    (\title renderedMarkdown ->
                        { title = title
                        , body = renderedMarkdown
                        }
                    )
                    (Decode.field "title" Decode.string)
                    (markdownString
                        |> markdownToView
                        |> Decode.fromResult
                    )
            )
            "foo.md"
                |> BackendTask.allowFatal

    markdownToView :
        String
        -> Result String (List (Html msg))
    markdownToView markdownString =
        markdownString
            |> Markdown.Parser.parse
            |> Result.mapError (\_ -> "Markdown error.")
            |> Result.andThen
                (\blocks ->
                    Markdown.Renderer.render
                        Markdown.Renderer.defaultHtmlRenderer
                        blocks
                )

bodyWithFrontmatter: 
    (String -> Json.Decode.Decoder frontmatter)
    -> String
    -> BackendTask.BackendTask { fatal : FatalError.FatalError
    , recoverable : BackendTask.File.FileReadError Json.Decode.Error
    } frontmatter
-}
bodyWithFrontmatter :
    (Elm.Expression -> Elm.Expression) -> String -> Elm.Expression
bodyWithFrontmatter bodyWithFrontmatterArg_ bodyWithFrontmatterArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "File" ]
             , name = "bodyWithFrontmatter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function
                              [ Type.string ]
                              (Type.namedWith
                                 [ "Json", "Decode" ]
                                 "Decoder"
                                 [ Type.var "frontmatter" ]
                              )
                          , Type.string
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
                                         [ "BackendTask", "File" ]
                                         "FileReadError"
                                         [ Type.namedWith
                                               [ "Json", "Decode" ]
                                               "Error"
                                               []
                                         ]
                                     )
                                   ]
                               , Type.var "frontmatter"
                               ]
                          )
                     )
             }
        )
        [ Elm.functionReduced
            "bodyWithFrontmatterUnpack"
            bodyWithFrontmatterArg_
        , Elm.string bodyWithFrontmatterArg_0
        ]


{-| Same as `bodyWithFrontmatter` except it doesn't include the frontmatter.

For example, if you have a file called `blog/hello-world.md` with

```markdown
---
title: Hello, World!
tags: elm
---
Hey there! This is my first post :)
```

    import BackendTask exposing (BackendTask)
    import BackendTask.File as File
    import FatalError exposing (FatalError)

    data : BackendTask FatalError String
    data =
        File.bodyWithoutFrontmatter "blog/hello-world.md"
            |> BackendTask.allowFatal

Then data will yield the value `"Hey there! This is my first post :)"`.

bodyWithoutFrontmatter: 
    String
    -> BackendTask.BackendTask { fatal : FatalError.FatalError
    , recoverable : BackendTask.File.FileReadError decoderError
    } String
-}
bodyWithoutFrontmatter : String -> Elm.Expression
bodyWithoutFrontmatter bodyWithoutFrontmatterArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "File" ]
             , name = "bodyWithoutFrontmatter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
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
                                         [ "BackendTask", "File" ]
                                         "FileReadError"
                                         [ Type.var "decoderError" ]
                                     )
                                   ]
                               , Type.string
                               ]
                          )
                     )
             }
        )
        [ Elm.string bodyWithoutFrontmatterArg_ ]


{-| Same as `bodyWithFrontmatter` except it doesn't include the body.

This is often useful when you're aggregating data, for example getting a listing of blog posts and need to extract
just the metadata.

    import BackendTask exposing (BackendTask)
    import BackendTask.File as File
    import FatalError exposing (FatalError)
    import Json.Decode as Decode exposing (Decoder)

    blogPost : BackendTask FatalError BlogPostMetadata
    blogPost =
        File.onlyFrontmatter
            blogPostDecoder
            "blog/hello-world.md"
            |> BackendTask.allowFatal

    type alias BlogPostMetadata =
        { title : String
        , tags : List String
        }

    blogPostDecoder : Decoder BlogPostMetadata
    blogPostDecoder =
        Decode.map2 BlogPostMetadata
            (Decode.field "title" Decode.string)
            (Decode.field "tags" (Decode.list Decode.string))

If you wanted to use this to get this metadata for all blog posts in a folder, you could use
the [`BackendTask`](BackendTask) API along with [`BackendTask.Glob`](BackendTask-Glob).

    import BackendTask exposing (BackendTask)
    import BackendTask.File as File
    import Decode exposing (Decoder)

    blogPostFiles : BackendTask (List String)
    blogPostFiles =
        Glob.succeed identity
            |> Glob.captureFilePath
            |> Glob.match (Glob.literal "content/blog/")
            |> Glob.match Glob.wildcard
            |> Glob.match (Glob.literal ".md")
            |> Glob.toBackendTask

    allMetadata : BackendTask (List BlogPostMetadata)
    allMetadata =
        blogPostFiles
            |> BackendTask.map
                (List.map
                    (File.onlyFrontmatter
                        blogPostDecoder
                    )
                )
            |> BackendTask.resolve

onlyFrontmatter: 
    Json.Decode.Decoder frontmatter
    -> String
    -> BackendTask.BackendTask { fatal : FatalError.FatalError
    , recoverable : BackendTask.File.FileReadError Json.Decode.Error
    } frontmatter
-}
onlyFrontmatter : Elm.Expression -> String -> Elm.Expression
onlyFrontmatter onlyFrontmatterArg_ onlyFrontmatterArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "File" ]
             , name = "onlyFrontmatter"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.var "frontmatter" ]
                          , Type.string
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
                                         [ "BackendTask", "File" ]
                                         "FileReadError"
                                         [ Type.namedWith
                                               [ "Json", "Decode" ]
                                               "Error"
                                               []
                                         ]
                                     )
                                   ]
                               , Type.var "frontmatter"
                               ]
                          )
                     )
             }
        )
        [ onlyFrontmatterArg_, Elm.string onlyFrontmatterArg_0 ]


{-| Read a file as JSON.

The Decode will strip off any unused JSON data.

    import BackendTask exposing (BackendTask)
    import BackendTask.File as File
    import FatalError exposing (FatalError)
    import Json.Decode as Decode

    sourceDirectories : BackendTask FatalError (List String)
    sourceDirectories =
        File.jsonFile
            (Decode.field
                "source-directories"
                (Decode.list Decode.string)
            )
            "elm.json"
            |> BackendTask.allowFatal

jsonFile: 
    Json.Decode.Decoder a
    -> String
    -> BackendTask.BackendTask { fatal : FatalError.FatalError
    , recoverable : BackendTask.File.FileReadError Json.Decode.Error
    } a
-}
jsonFile : Elm.Expression -> String -> Elm.Expression
jsonFile jsonFileArg_ jsonFileArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "File" ]
             , name = "jsonFile"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "Json", "Decode" ]
                              "Decoder"
                              [ Type.var "a" ]
                          , Type.string
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
                                         [ "BackendTask", "File" ]
                                         "FileReadError"
                                         [ Type.namedWith
                                               [ "Json", "Decode" ]
                                               "Error"
                                               []
                                         ]
                                     )
                                   ]
                               , Type.var "a"
                               ]
                          )
                     )
             }
        )
        [ jsonFileArg_, Elm.string jsonFileArg_0 ]


{-| Get the raw file content. Unlike the frontmatter helpers in this module, this function will not strip off frontmatter if there is any.

This is the function you want if you are reading in a file directly. For example, if you read in a CSV file, a raw text file, or any other file that doesn't
have frontmatter.

There's a special function for reading in JSON files, [`jsonFile`](#jsonFile). If you're reading a JSON file then be sure to
use `jsonFile` to get the benefits of the `Decode` here.

You could read a file called `hello.txt` in your root project directory like this:

    import BackendTask exposing (BackendTask)
    import BackendTask.File as File
    import FatalError exposing (FatalError)

    elmJsonFile : BackendTask FatalError String
    elmJsonFile =
        File.rawFile "hello.txt"
            |> BackendTask.allowFatal

rawFile: 
    String
    -> BackendTask.BackendTask { fatal : FatalError.FatalError
    , recoverable : BackendTask.File.FileReadError decoderError
    } String
-}
rawFile : String -> Elm.Expression
rawFile rawFileArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "File" ]
             , name = "rawFile"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
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
                                         [ "BackendTask", "File" ]
                                         "FileReadError"
                                         [ Type.var "decoderError" ]
                                     )
                                   ]
                               , Type.string
                               ]
                          )
                     )
             }
        )
        [ Elm.string rawFileArg_ ]


annotation_ : { fileReadError : Type.Annotation -> Type.Annotation }
annotation_ =
    { fileReadError =
        \fileReadErrorArg0 ->
            Type.namedWith
                [ "BackendTask", "File" ]
                "FileReadError"
                [ fileReadErrorArg0 ]
    }


make_ :
    { fileDoesntExist : Elm.Expression
    , fileReadError : Elm.Expression -> Elm.Expression
    , decodingError : Elm.Expression -> Elm.Expression
    }
make_ =
    { fileDoesntExist =
        Elm.value
            { importFrom = [ "BackendTask", "File" ]
            , name = "FileDoesntExist"
            , annotation =
                Just (Type.namedWith [] "FileReadError" [ Type.var "decoding" ])
            }
    , fileReadError =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "File" ]
                     , name = "FileReadError"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "FileReadError"
                                  [ Type.var "decoding" ]
                             )
                     }
                )
                [ ar0 ]
    , decodingError =
        \ar0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "File" ]
                     , name = "DecodingError"
                     , annotation =
                         Just
                             (Type.namedWith
                                  []
                                  "FileReadError"
                                  [ Type.var "decoding" ]
                             )
                     }
                )
                [ ar0 ]
    }


caseOf_ :
    { fileReadError :
        Elm.Expression
        -> { fileDoesntExist : Elm.Expression
        , fileReadError : Elm.Expression -> Elm.Expression
        , decodingError : Elm.Expression -> Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { fileReadError =
        \fileReadErrorExpression fileReadErrorTags ->
            Elm.Case.custom
                fileReadErrorExpression
                (Type.namedWith
                     [ "BackendTask", "File" ]
                     "FileReadError"
                     [ Type.var "decoding" ]
                )
                [ Elm.Case.branch
                    (Elm.Arg.customType
                       "FileDoesntExist"
                       fileReadErrorTags.fileDoesntExist
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "FileReadError"
                       fileReadErrorTags.fileReadError |> Elm.Arg.item
                                                                (Elm.Arg.varWith
                                                                       "arg_0"
                                                                       Type.string
                                                                )
                    )
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "DecodingError"
                       fileReadErrorTags.decodingError |> Elm.Arg.item
                                                                (Elm.Arg.varWith
                                                                       "decoding"
                                                                       (Type.var
                                                                              "decoding"
                                                                       )
                                                                )
                    )
                    Basics.identity
                ]
    }


call_ :
    { bodyWithFrontmatter : Elm.Expression -> Elm.Expression -> Elm.Expression
    , bodyWithoutFrontmatter : Elm.Expression -> Elm.Expression
    , onlyFrontmatter : Elm.Expression -> Elm.Expression -> Elm.Expression
    , jsonFile : Elm.Expression -> Elm.Expression -> Elm.Expression
    , rawFile : Elm.Expression -> Elm.Expression
    }
call_ =
    { bodyWithFrontmatter =
        \bodyWithFrontmatterArg_ bodyWithFrontmatterArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "File" ]
                     , name = "bodyWithFrontmatter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.string ]
                                      (Type.namedWith
                                         [ "Json", "Decode" ]
                                         "Decoder"
                                         [ Type.var "frontmatter" ]
                                      )
                                  , Type.string
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
                                                 [ "BackendTask", "File" ]
                                                 "FileReadError"
                                                 [ Type.namedWith
                                                       [ "Json", "Decode" ]
                                                       "Error"
                                                       []
                                                 ]
                                             )
                                           ]
                                       , Type.var "frontmatter"
                                       ]
                                  )
                             )
                     }
                )
                [ bodyWithFrontmatterArg_, bodyWithFrontmatterArg_0 ]
    , bodyWithoutFrontmatter =
        \bodyWithoutFrontmatterArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "File" ]
                     , name = "bodyWithoutFrontmatter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
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
                                                 [ "BackendTask", "File" ]
                                                 "FileReadError"
                                                 [ Type.var "decoderError" ]
                                             )
                                           ]
                                       , Type.string
                                       ]
                                  )
                             )
                     }
                )
                [ bodyWithoutFrontmatterArg_ ]
    , onlyFrontmatter =
        \onlyFrontmatterArg_ onlyFrontmatterArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "File" ]
                     , name = "onlyFrontmatter"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Decoder"
                                      [ Type.var "frontmatter" ]
                                  , Type.string
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
                                                 [ "BackendTask", "File" ]
                                                 "FileReadError"
                                                 [ Type.namedWith
                                                       [ "Json", "Decode" ]
                                                       "Error"
                                                       []
                                                 ]
                                             )
                                           ]
                                       , Type.var "frontmatter"
                                       ]
                                  )
                             )
                     }
                )
                [ onlyFrontmatterArg_, onlyFrontmatterArg_0 ]
    , jsonFile =
        \jsonFileArg_ jsonFileArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "File" ]
                     , name = "jsonFile"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "Json", "Decode" ]
                                      "Decoder"
                                      [ Type.var "a" ]
                                  , Type.string
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
                                                 [ "BackendTask", "File" ]
                                                 "FileReadError"
                                                 [ Type.namedWith
                                                       [ "Json", "Decode" ]
                                                       "Error"
                                                       []
                                                 ]
                                             )
                                           ]
                                       , Type.var "a"
                                       ]
                                  )
                             )
                     }
                )
                [ jsonFileArg_, jsonFileArg_0 ]
    , rawFile =
        \rawFileArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "File" ]
                     , name = "rawFile"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
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
                                                 [ "BackendTask", "File" ]
                                                 "FileReadError"
                                                 [ Type.var "decoderError" ]
                                             )
                                           ]
                                       , Type.string
                                       ]
                                  )
                             )
                     }
                )
                [ rawFileArg_ ]
    }


values_ :
    { bodyWithFrontmatter : Elm.Expression
    , bodyWithoutFrontmatter : Elm.Expression
    , onlyFrontmatter : Elm.Expression
    , jsonFile : Elm.Expression
    , rawFile : Elm.Expression
    }
values_ =
    { bodyWithFrontmatter =
        Elm.value
            { importFrom = [ "BackendTask", "File" ]
            , name = "bodyWithFrontmatter"
            , annotation =
                Just
                    (Type.function
                         [ Type.function
                             [ Type.string ]
                             (Type.namedWith
                                [ "Json", "Decode" ]
                                "Decoder"
                                [ Type.var "frontmatter" ]
                             )
                         , Type.string
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
                                        [ "BackendTask", "File" ]
                                        "FileReadError"
                                        [ Type.namedWith
                                              [ "Json", "Decode" ]
                                              "Error"
                                              []
                                        ]
                                    )
                                  ]
                              , Type.var "frontmatter"
                              ]
                         )
                    )
            }
    , bodyWithoutFrontmatter =
        Elm.value
            { importFrom = [ "BackendTask", "File" ]
            , name = "bodyWithoutFrontmatter"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
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
                                        [ "BackendTask", "File" ]
                                        "FileReadError"
                                        [ Type.var "decoderError" ]
                                    )
                                  ]
                              , Type.string
                              ]
                         )
                    )
            }
    , onlyFrontmatter =
        Elm.value
            { importFrom = [ "BackendTask", "File" ]
            , name = "onlyFrontmatter"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Json", "Decode" ]
                             "Decoder"
                             [ Type.var "frontmatter" ]
                         , Type.string
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
                                        [ "BackendTask", "File" ]
                                        "FileReadError"
                                        [ Type.namedWith
                                              [ "Json", "Decode" ]
                                              "Error"
                                              []
                                        ]
                                    )
                                  ]
                              , Type.var "frontmatter"
                              ]
                         )
                    )
            }
    , jsonFile =
        Elm.value
            { importFrom = [ "BackendTask", "File" ]
            , name = "jsonFile"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "Json", "Decode" ]
                             "Decoder"
                             [ Type.var "a" ]
                         , Type.string
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
                                        [ "BackendTask", "File" ]
                                        "FileReadError"
                                        [ Type.namedWith
                                              [ "Json", "Decode" ]
                                              "Error"
                                              []
                                        ]
                                    )
                                  ]
                              , Type.var "a"
                              ]
                         )
                    )
            }
    , rawFile =
        Elm.value
            { importFrom = [ "BackendTask", "File" ]
            , name = "rawFile"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
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
                                        [ "BackendTask", "File" ]
                                        "FileReadError"
                                        [ Type.var "decoderError" ]
                                    )
                                  ]
                              , Type.string
                              ]
                         )
                    )
            }
    }