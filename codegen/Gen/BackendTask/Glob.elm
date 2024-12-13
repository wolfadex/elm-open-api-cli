module Gen.BackendTask.Glob exposing
    ( moduleName_, capture, match, fromString, fromStringWithOptions, captureFilePath
    , wildcard, recursiveWildcard, int, digits, captureStats, expectUniqueMatch, expectUniqueMatchFromList
    , literal, map, succeed, oneOf, zeroOrMore, atLeastOne, toBackendTask
    , toBackendTaskWithOptions, defaultOptions, annotation_, make_, caseOf_, call_, values_
    )

{-|
# Generated bindings for BackendTask.Glob

@docs moduleName_, capture, match, fromString, fromStringWithOptions, captureFilePath
@docs wildcard, recursiveWildcard, int, digits, captureStats, expectUniqueMatch
@docs expectUniqueMatchFromList, literal, map, succeed, oneOf, zeroOrMore
@docs atLeastOne, toBackendTask, toBackendTaskWithOptions, defaultOptions, annotation_, make_
@docs caseOf_, call_, values_
-}


import Elm
import Elm.Annotation as Type
import Elm.Arg
import Elm.Case


{-| The name of this module. -}
moduleName_ : List String
moduleName_ =
    [ "BackendTask", "Glob" ]


{-| Adds on to the glob pattern, and captures it in the resulting Elm match value. That means this both changes which
files will match, and gives you the sub-match as Elm data for each matching file.

Exactly the same as `match` except it also captures the matched sub-pattern.

    type alias ArchivesArticle =
        { year : String
        , month : String
        , day : String
        , slug : String
        }

    archives : BackendTask error ArchivesArticle
    archives =
        Glob.succeed ArchivesArticle
            |> Glob.match (Glob.literal "archive/")
            |> Glob.capture Glob.int
            |> Glob.match (Glob.literal "/")
            |> Glob.capture Glob.int
            |> Glob.match (Glob.literal "/")
            |> Glob.capture Glob.int
            |> Glob.match (Glob.literal "/")
            |> Glob.capture Glob.wildcard
            |> Glob.match (Glob.literal ".md")
            |> Glob.toBackendTask

The file `archive/1977/06/10/apple-2-released.md` will give us this match:

    matches : List error ArchivesArticle
    matches =
        BackendTask.succeed
            [ { year = 1977
              , month = 6
              , day = 10
              , slug = "apple-2-released"
              }
            ]

When possible, it's best to grab data and turn it into structured Elm data when you have it. That way,
you don't end up with duplicate validation logic and data normalization, and your code will be more robust.

If you only care about getting the full matched file paths, you can use `match`. `capture` is very useful because
you can pick apart structured data as you build up your glob pattern. This follows the principle of
[Parse, Don't Validate](https://elm-radio.com/episode/parse-dont-validate/).

capture: 
    BackendTask.Glob.Glob a
    -> BackendTask.Glob.Glob (a -> value)
    -> BackendTask.Glob.Glob value
-}
capture : Elm.Expression -> Elm.Expression -> Elm.Expression
capture captureArg_ captureArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Glob" ]
             , name = "capture"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.var "a" ]
                          , Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.function
                                    [ Type.var "a" ]
                                    (Type.var "value")
                              ]
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Glob" ]
                               "Glob"
                               [ Type.var "value" ]
                          )
                     )
             }
        )
        [ captureArg_, captureArg_0 ]


{-| Adds on to the glob pattern, but does not capture it in the resulting Elm match value. That means this changes which
files will match, but does not change the Elm data type you get for each matching file.

Exactly the same as `capture` except it doesn't capture the matched sub-pattern.

match: 
    BackendTask.Glob.Glob a
    -> BackendTask.Glob.Glob value
    -> BackendTask.Glob.Glob value
-}
match : Elm.Expression -> Elm.Expression -> Elm.Expression
match matchArg_ matchArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Glob" ]
             , name = "match"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.var "a" ]
                          , Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.var "value" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Glob" ]
                               "Glob"
                               [ Type.var "value" ]
                          )
                     )
             }
        )
        [ matchArg_, matchArg_0 ]


{-| Runs a glob string directly, with `include = FilesAndFolders`. Behavior is similar to using glob patterns in a shell.

If you need to capture specific parts of the path, you can use `capture` and `match` functions instead. `fromString`
only allows you to capture a list of matching file paths.

The following glob syntax is supported:

  - `*` matches any number of characters except for `/`
  - `**` matches any number of characters including `/`

For example, if we have the following files:

```shell
- src/
    - Main.elm
    - Ui/
        - Icon.elm
- content/
    - blog/
        - first-post.md
        - second-post.md
```

    import BackendTask.Glob as Glob

    blogPosts : BackendTask error (List String)
    blogPosts =
        Glob.fromString "content/blog/*.md"

    --> BackendTask.succeed [ "content/blog/first-post.md", "content/blog/second-post.md" ]
    elmFiles : BackendTask error (List String)
    elmFiles =
        Glob.fromString "src/**/*.elm"

    --> BackendTask.succeed [ "src/Main.elm", "src/Ui", "src/Ui/Icon.elm" ]

fromString: String -> BackendTask.BackendTask error (List String)
-}
fromString : String -> Elm.Expression
fromString fromStringArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Glob" ]
             , name = "fromString"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.list Type.string ]
                          )
                     )
             }
        )
        [ Elm.string fromStringArg_ ]


{-| Same as [`fromString`](#fromString), but with custom [`Options`](#Options).

fromStringWithOptions: 
    BackendTask.Glob.Options
    -> String
    -> BackendTask.BackendTask error (List String)
-}
fromStringWithOptions : Elm.Expression -> String -> Elm.Expression
fromStringWithOptions fromStringWithOptionsArg_ fromStringWithOptionsArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Glob" ]
             , name = "fromStringWithOptions"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Options"
                              []
                          , Type.string
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.list Type.string ]
                          )
                     )
             }
        )
        [ fromStringWithOptionsArg_, Elm.string fromStringWithOptionsArg_0 ]


{-| import BackendTask exposing (BackendTask)
    import BackendTask.Glob as Glob

    blogPosts :
        BackendTask
            error
            (List
                { filePath : String
                , slug : String
                }
            )
    blogPosts =
        Glob.succeed
            (\filePath slug ->
                { filePath = filePath
                , slug = slug
                }
            )
            |> Glob.captureFilePath
            |> Glob.match (Glob.literal "content/blog/")
            |> Glob.capture Glob.wildcard
            |> Glob.match (Glob.literal ".md")
            |> Glob.toBackendTask

This function does not change which files will or will not match. It just gives you the full matching
file path in your `Glob` pipeline.

Whenever possible, it's a good idea to use function to make sure you have an accurate file path when you need to read a file.

captureFilePath: BackendTask.Glob.Glob (String -> value) -> BackendTask.Glob.Glob value
-}
captureFilePath : Elm.Expression -> Elm.Expression
captureFilePath captureFilePathArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Glob" ]
             , name = "captureFilePath"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.function [ Type.string ] (Type.var "value")
                              ]
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Glob" ]
                               "Glob"
                               [ Type.var "value" ]
                          )
                     )
             }
        )
        [ captureFilePathArg_ ]


{-| Matches anything except for a `/` in a file path. You may be familiar with this syntax from shells like bash
where you can run commands like `rm client/*.js` to remove all `.js` files in the `client` directory.

Just like a `*` glob pattern in bash, this `Glob.wildcard` function will only match within a path part. If you need to
match 0 or more path parts like, see `recursiveWildcard`.

    import BackendTask exposing (BackendTask)
    import BackendTask.Glob as Glob

    type alias BlogPost =
        { year : String
        , month : String
        , day : String
        , slug : String
        }

    example : BackendTask error (List BlogPost)
    example =
        Glob.succeed BlogPost
            |> Glob.match (Glob.literal "blog/")
            |> Glob.capture Glob.wildcard
            |> Glob.match (Glob.literal "-")
            |> Glob.capture Glob.wildcard
            |> Glob.match (Glob.literal "-")
            |> Glob.capture Glob.wildcard
            |> Glob.match (Glob.literal "/")
            |> Glob.capture Glob.wildcard
            |> Glob.match (Glob.literal ".md")
            |> Glob.toBackendTask

```shell

- blog/
  - 2021-05-27/
    - first-post.md
```

That will match to:

    results : BackendTask error (List BlogPost)
    results =
        BackendTask.succeed
            [ { year = "2021"
              , month = "05"
              , day = "27"
              , slug = "first-post"
              }
            ]

Note that we can "destructure" the date part of this file path in the format `yyyy-mm-dd`. The `wildcard` matches
will match _within_ a path part (think between the slashes of a file path). `recursiveWildcard` can match across path parts.

wildcard: BackendTask.Glob.Glob String
-}
wildcard : Elm.Expression
wildcard =
    Elm.value
        { importFrom = [ "BackendTask", "Glob" ]
        , name = "wildcard"
        , annotation =
            Just
                (Type.namedWith [ "BackendTask", "Glob" ] "Glob" [ Type.string ]
                )
        }


{-| Matches any number of characters, including `/`, as long as it's the only thing in a path part.

In contrast, `wildcard` will never match `/`, so it only matches within a single path part.

This is the elm-pages equivalent of `**/*.txt` in standard shell syntax:

    import BackendTask exposing (BackendTask)
    import BackendTask.Glob as Glob

    example : BackendTask error (List ( List String, String ))
    example =
        Glob.succeed Tuple.pair
            |> Glob.match (Glob.literal "articles/")
            |> Glob.capture Glob.recursiveWildcard
            |> Glob.match (Glob.literal "/")
            |> Glob.capture Glob.wildcard
            |> Glob.match (Glob.literal ".txt")
            |> Glob.toBackendTask

With these files:

```shell
- articles/
  - google-io-2021-recap.txt
  - archive/
    - 1977/
      - 06/
        - 10/
          - apple-2-announced.txt
```

We would get the following matches:

    matches : BackendTask error (List ( List String, String ))
    matches =
        BackendTask.succeed
            [ ( [ "archive", "1977", "06", "10" ], "apple-2-announced" )
            , ( [], "google-io-2021-recap" )
            ]

Note that the recursive wildcard conveniently gives us a `List String`, where
each String is a path part with no slashes (like `archive`).

And also note that it matches 0 path parts into an empty list.

If we didn't include the `wildcard` after the `recursiveWildcard`, then we would only get
a single level of matches because it is followed by a file extension.

    example : BackendTask error (List String)
    example =
        Glob.succeed identity
            |> Glob.match (Glob.literal "articles/")
            |> Glob.capture Glob.recursiveWildcard
            |> Glob.match (Glob.literal ".txt")

    matches : BackendTask error (List String)
    matches =
        BackendTask.succeed
            [ "google-io-2021-recap"
            ]

This is usually not what is intended. Using `recursiveWildcard` is usually followed by a `wildcard` for this reason.

recursiveWildcard: BackendTask.Glob.Glob (List String)
-}
recursiveWildcard : Elm.Expression
recursiveWildcard =
    Elm.value
        { importFrom = [ "BackendTask", "Glob" ]
        , name = "recursiveWildcard"
        , annotation =
            Just
                (Type.namedWith
                     [ "BackendTask", "Glob" ]
                     "Glob"
                     [ Type.list Type.string ]
                )
        }


{-| Same as [`digits`](#digits), but it safely turns the digits String into an `Int`.

Leading 0's are ignored.

    import BackendTask exposing (BackendTask)
    import BackendTask.Glob as Glob

    slides : BackendTask error (List Int)
    slides =
        Glob.succeed identity
            |> Glob.match (Glob.literal "slide-")
            |> Glob.capture Glob.int
            |> Glob.match (Glob.literal ".md")
            |> Glob.toBackendTask

With files

```shell
- slide-no-match.md
- slide-.md
- slide-1.md
- slide-01.md
- slide-2.md
- slide-03.md
- slide-4.md
- slide-05.md
- slide-06.md
- slide-007.md
- slide-08.md
- slide-09.md
- slide-10.md
- slide-11.md
```

Yields

    matches : BackendTask error (List Int)
    matches =
        BackendTask.succeed
            [ 1
            , 1
            , 2
            , 3
            , 4
            , 5
            , 6
            , 7
            , 8
            , 9
            , 10
            , 11
            ]

Note that neither `slide-no-match.md` nor `slide-.md` match.
And both `slide-1.md` and `slide-01.md` match and turn into `1`.

int: BackendTask.Glob.Glob Int
-}
int : Elm.Expression
int =
    Elm.value
        { importFrom = [ "BackendTask", "Glob" ]
        , name = "int"
        , annotation =
            Just (Type.namedWith [ "BackendTask", "Glob" ] "Glob" [ Type.int ])
        }


{-| This is similar to [`wildcard`](#wildcard), but it will only match 1 or more digits (i.e. `[0-9]+`).

See [`int`](#int) for a convenience function to get an Int value instead of a String of digits.

digits: BackendTask.Glob.Glob String
-}
digits : Elm.Expression
digits =
    Elm.value
        { importFrom = [ "BackendTask", "Glob" ]
        , name = "digits"
        , annotation =
            Just
                (Type.namedWith [ "BackendTask", "Glob" ] "Glob" [ Type.string ]
                )
        }


{-| import BackendTask.Glob as Glob

    recentlyChangedRouteModules : BackendTask error (List ( Time.Posix, List String ))
    recentlyChangedRouteModules =
        Glob.succeed
            (\fileStats directoryName fileName ->
                ( fileStats.lastContentChange
                , directoryName ++ [ fileName ]
                )
            )
            |> Glob.captureStats
            |> Glob.match (Glob.literal "app/Route/")
            |> Glob.capture Glob.recursiveWildcard
            |> Glob.match (Glob.literal "/")
            |> Glob.capture Glob.wildcard
            |> Glob.match (Glob.literal ".elm")
            |> Glob.toBackendTask
            |> BackendTask.map
                (\entries ->
                    entries
                        |> List.sortBy (\( lastChanged, _ ) -> Time.posixToMillis lastChanged)
                        |> List.reverse
                )

captureStats: 
    BackendTask.Glob.Glob (BackendTask.Glob.FileStats -> value)
    -> BackendTask.Glob.Glob value
-}
captureStats : Elm.Expression -> Elm.Expression
captureStats captureStatsArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Glob" ]
             , name = "captureStats"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.function
                                    [ Type.namedWith
                                        [ "BackendTask", "Glob" ]
                                        "FileStats"
                                        []
                                    ]
                                    (Type.var "value")
                              ]
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Glob" ]
                               "Glob"
                               [ Type.var "value" ]
                          )
                     )
             }
        )
        [ captureStatsArg_ ]


{-| Sometimes you want to make sure there is a unique file matching a particular pattern.
This is a simple helper that will give you a `BackendTask` error if there isn't exactly 1 matching file.
If there is exactly 1, then you successfully get back that single match.

For example, maybe you can have

    import BackendTask exposing (BackendTask)
    import BackendTask.Glob as Glob

    findBlogBySlug : String -> BackendTask FatalError String
    findBlogBySlug slug =
        Glob.succeed identity
            |> Glob.captureFilePath
            |> Glob.match (Glob.literal "blog/")
            |> Glob.match (Glob.literal slug)
            |> Glob.match
                (Glob.oneOf
                    ( ( "", () )
                    , [ ( "/index", () ) ]
                    )
                )
            |> Glob.match (Glob.literal ".md")
            |> Glob.expectUniqueMatch
            |> BackendTask.allowFatal

If we used `findBlogBySlug "first-post"` with these files:

```markdown
- blog/
    - first-post/
        - index.md
```

This would give us:

    results : BackendTask FatalError String
    results =
        BackendTask.succeed "blog/first-post/index.md"

If we used `findBlogBySlug "first-post"` with these files:

```markdown
- blog/
    - first-post.md
    - first-post/
        - index.md
```

Then we will get a `BackendTask` error saying `More than one file matched.` Keep in mind that `BackendTask` failures
in build-time routes will cause a build failure, giving you the opportunity to fix the problem before users see the issue,
so it's ideal to make this kind of assertion rather than having fallback behavior that could silently cover up
issues (like if we had instead ignored the case where there are two or more matching blog post files).

expectUniqueMatch: 
    BackendTask.Glob.Glob a
    -> BackendTask.BackendTask { fatal : FatalError.FatalError
    , recoverable : String
    } a
-}
expectUniqueMatch : Elm.Expression -> Elm.Expression
expectUniqueMatch expectUniqueMatchArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Glob" ]
             , name = "expectUniqueMatch"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
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
                                   , ( "recoverable", Type.string )
                                   ]
                               , Type.var "a"
                               ]
                          )
                     )
             }
        )
        [ expectUniqueMatchArg_ ]


{-| expectUniqueMatchFromList: List (BackendTask.Glob.Glob a) -> BackendTask.BackendTask String a -}
expectUniqueMatchFromList : List Elm.Expression -> Elm.Expression
expectUniqueMatchFromList expectUniqueMatchFromListArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Glob" ]
             , name = "expectUniqueMatchFromList"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list
                              (Type.namedWith
                                 [ "BackendTask", "Glob" ]
                                 "Glob"
                                 [ Type.var "a" ]
                              )
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.string, Type.var "a" ]
                          )
                     )
             }
        )
        [ Elm.list expectUniqueMatchFromListArg_ ]


{-| Match a literal part of a path. Can include `/`s.

Some common uses include

  - The leading part of a pattern, to say "starts with `content/blog/`"
  - The ending part of a pattern, to say "ends with `.md`"
  - In-between wildcards, to say "these dynamic parts are separated by `/`"

```elm
import BackendTask exposing (BackendTask)
import BackendTask.Glob as Glob

blogPosts =
    Glob.succeed
        (\section slug ->
            { section = section, slug = slug }
        )
        |> Glob.match (Glob.literal "content/blog/")
        |> Glob.capture Glob.wildcard
        |> Glob.match (Glob.literal "/")
        |> Glob.capture Glob.wildcard
        |> Glob.match (Glob.literal ".md")
```

literal: String -> BackendTask.Glob.Glob String
-}
literal : String -> Elm.Expression
literal literalArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Glob" ]
             , name = "literal"
             , annotation =
                 Just
                     (Type.function
                          [ Type.string ]
                          (Type.namedWith
                               [ "BackendTask", "Glob" ]
                               "Glob"
                               [ Type.string ]
                          )
                     )
             }
        )
        [ Elm.string literalArg_ ]


{-| A `Glob` can be mapped. This can be useful for transforming a sub-match in-place.

For example, if you wanted to take the slugs for a blog post and make sure they are normalized to be all lowercase, you
could use

    import BackendTask exposing (BackendTask)
    import BackendTask.Glob as Glob

    blogPostsGlob : BackendTask error (List String)
    blogPostsGlob =
        Glob.succeed (\slug -> slug)
            |> Glob.match (Glob.literal "content/blog/")
            |> Glob.capture (Glob.wildcard |> Glob.map String.toLower)
            |> Glob.match (Glob.literal ".md")
            |> Glob.toBackendTask

If you want to validate file formats, you can combine that with some `BackendTask` helpers to turn a `Glob (Result String value)` into
a `BackendTask FatalError (List value)`.

For example, you could take a date and parse it.

    import BackendTask exposing (BackendTask)
    import BackendTask.Glob as Glob

    example : BackendTask FatalError (List ( String, String ))
    example =
        Glob.succeed
            (\dateResult slug ->
                dateResult
                    |> Result.map (\okDate -> ( okDate, slug ))
            )
            |> Glob.match (Glob.literal "blog/")
            |> Glob.capture (Glob.recursiveWildcard |> Glob.map expectDateFormat)
            |> Glob.match (Glob.literal "/")
            |> Glob.capture Glob.wildcard
            |> Glob.match (Glob.literal ".md")
            |> Glob.toBackendTask
            |> BackendTask.map (List.map BackendTask.fromResult)
            |> BackendTask.resolve

    expectDateFormat : List String -> Result FatalError String
    expectDateFormat dateParts =
        case dateParts of
            [ year, month, date ] ->
                Ok (String.join "-" [ year, month, date ])

            _ ->
                Err <| FatalError.fromString "Unexpected date format, expected yyyy/mm/dd folder structure."

map: (a -> b) -> BackendTask.Glob.Glob a -> BackendTask.Glob.Glob b
-}
map : (Elm.Expression -> Elm.Expression) -> Elm.Expression -> Elm.Expression
map mapArg_ mapArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Glob" ]
             , name = "map"
             , annotation =
                 Just
                     (Type.function
                          [ Type.function [ Type.var "a" ] (Type.var "b")
                          , Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Glob" ]
                               "Glob"
                               [ Type.var "b" ]
                          )
                     )
             }
        )
        [ Elm.functionReduced "mapUnpack" mapArg_, mapArg_0 ]


{-| `succeed` is how you start a pipeline for a `Glob`. You will need one argument for each `capture` in your `Glob`.

succeed: constructor -> BackendTask.Glob.Glob constructor
-}
succeed : Elm.Expression -> Elm.Expression
succeed succeedArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Glob" ]
             , name = "succeed"
             , annotation =
                 Just
                     (Type.function
                          [ Type.var "constructor" ]
                          (Type.namedWith
                               [ "BackendTask", "Glob" ]
                               "Glob"
                               [ Type.var "constructor" ]
                          )
                     )
             }
        )
        [ succeedArg_ ]


{-| import BackendTask.Glob as Glob

    type Extension
        = Json
        | Yml

    type alias DataFile =
        { name : String
        , extension : String
        }

    dataFiles : BackendTask error (List DataFile)
    dataFiles =
        Glob.succeed DataFile
            |> Glob.match (Glob.literal "my-data/")
            |> Glob.capture Glob.wildcard
            |> Glob.match (Glob.literal ".")
            |> Glob.capture
                (Glob.oneOf
                    ( ( "yml", Yml )
                    , [ ( "json", Json )
                      ]
                    )
                )

If we have the following files

```shell
- my-data/
    - authors.yml
    - events.json
```

That gives us

    results : BackendTask error (List DataFile)
    results =
        BackendTask.succeed
            [ { name = "authors"
              , extension = Yml
              }
            , { name = "events"
              , extension = Json
              }
            ]

You could also match an optional file path segment using `oneOf`.

    rootFilesMd : BackendTask error (List String)
    rootFilesMd =
        Glob.succeed (\slug -> slug)
            |> Glob.match (Glob.literal "blog/")
            |> Glob.capture Glob.wildcard
            |> Glob.match
                (Glob.oneOf
                    ( ( "", () )
                    , [ ( "/index", () ) ]
                    )
                )
            |> Glob.match (Glob.literal ".md")
            |> Glob.toBackendTask

With these files:

```markdown
- blog/
    - first-post.md
    - second-post/
        - index.md
```

This would give us:

    results : BackendTask error (List String)
    results =
        BackendTask.succeed
            [ "first-post"
            , "second-post"
            ]

oneOf: ( ( String, a ), List ( String, a ) ) -> BackendTask.Glob.Glob a
-}
oneOf : Elm.Expression -> Elm.Expression
oneOf oneOfArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Glob" ]
             , name = "oneOf"
             , annotation =
                 Just
                     (Type.function
                          [ Type.tuple
                              (Type.tuple Type.string (Type.var "a"))
                              (Type.list (Type.tuple Type.string (Type.var "a"))
                              )
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Glob" ]
                               "Glob"
                               [ Type.var "a" ]
                          )
                     )
             }
        )
        [ oneOfArg_ ]


{-| zeroOrMore: List String -> BackendTask.Glob.Glob (Maybe String) -}
zeroOrMore : List String -> Elm.Expression
zeroOrMore zeroOrMoreArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Glob" ]
             , name = "zeroOrMore"
             , annotation =
                 Just
                     (Type.function
                          [ Type.list Type.string ]
                          (Type.namedWith
                               [ "BackendTask", "Glob" ]
                               "Glob"
                               [ Type.maybe Type.string ]
                          )
                     )
             }
        )
        [ Elm.list (List.map Elm.string zeroOrMoreArg_) ]


{-| atLeastOne: ( ( String, a ), List ( String, a ) ) -> BackendTask.Glob.Glob ( a, List a ) -}
atLeastOne : Elm.Expression -> Elm.Expression
atLeastOne atLeastOneArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Glob" ]
             , name = "atLeastOne"
             , annotation =
                 Just
                     (Type.function
                          [ Type.tuple
                              (Type.tuple Type.string (Type.var "a"))
                              (Type.list (Type.tuple Type.string (Type.var "a"))
                              )
                          ]
                          (Type.namedWith
                               [ "BackendTask", "Glob" ]
                               "Glob"
                               [ Type.tuple
                                   (Type.var "a")
                                   (Type.list (Type.var "a"))
                               ]
                          )
                     )
             }
        )
        [ atLeastOneArg_ ]


{-| In order to get match data from your glob, turn it into a `BackendTask` with this function.

toBackendTask: BackendTask.Glob.Glob a -> BackendTask.BackendTask error (List a)
-}
toBackendTask : Elm.Expression -> Elm.Expression
toBackendTask toBackendTaskArg_ =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Glob" ]
             , name = "toBackendTask"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.list (Type.var "a") ]
                          )
                     )
             }
        )
        [ toBackendTaskArg_ ]


{-| Same as toBackendTask, but lets you set custom glob options. For example, to list folders instead of files,

    import BackendTask.Glob as Glob exposing (OnlyFolders, defaultOptions)

    matchingFiles : Glob a -> BackendTask error (List a)
    matchingFiles glob =
        glob
            |> Glob.toBackendTaskWithOptions { defaultOptions | include = OnlyFolders }

toBackendTaskWithOptions: 
    BackendTask.Glob.Options
    -> BackendTask.Glob.Glob a
    -> BackendTask.BackendTask error (List a)
-}
toBackendTaskWithOptions : Elm.Expression -> Elm.Expression -> Elm.Expression
toBackendTaskWithOptions toBackendTaskWithOptionsArg_ toBackendTaskWithOptionsArg_0 =
    Elm.apply
        (Elm.value
             { importFrom = [ "BackendTask", "Glob" ]
             , name = "toBackendTaskWithOptions"
             , annotation =
                 Just
                     (Type.function
                          [ Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Options"
                              []
                          , Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.var "a" ]
                          ]
                          (Type.namedWith
                               [ "BackendTask" ]
                               "BackendTask"
                               [ Type.var "error", Type.list (Type.var "a") ]
                          )
                     )
             }
        )
        [ toBackendTaskWithOptionsArg_, toBackendTaskWithOptionsArg_0 ]


{-| The default options used in [`toBackendTask`](#toBackendTask). To use a custom set of options, use [`toBackendTaskWithOptions`](#toBackendTaskWithOptions).

defaultOptions: BackendTask.Glob.Options
-}
defaultOptions : Elm.Expression
defaultOptions =
    Elm.value
        { importFrom = [ "BackendTask", "Glob" ]
        , name = "defaultOptions"
        , annotation =
            Just (Type.namedWith [ "BackendTask", "Glob" ] "Options" [])
        }


annotation_ :
    { glob : Type.Annotation -> Type.Annotation
    , fileStats : Type.Annotation
    , options : Type.Annotation
    , include : Type.Annotation
    }
annotation_ =
    { glob =
        \globArg0 ->
            Type.alias
                moduleName_
                "Glob"
                [ globArg0 ]
                (Type.namedWith
                     [ "BackendTask", "Internal", "Glob" ]
                     "Glob"
                     [ Type.var "a" ]
                )
    , fileStats =
        Type.alias
            moduleName_
            "FileStats"
            []
            (Type.record
                 [ ( "fullPath", Type.string )
                 , ( "sizeInBytes", Type.int )
                 , ( "lastContentChange", Type.namedWith [ "Time" ] "Posix" [] )
                 , ( "lastAccess", Type.namedWith [ "Time" ] "Posix" [] )
                 , ( "lastFileChange", Type.namedWith [ "Time" ] "Posix" [] )
                 , ( "createdAt", Type.namedWith [ "Time" ] "Posix" [] )
                 , ( "isDirectory", Type.bool )
                 ]
            )
    , options =
        Type.alias
            moduleName_
            "Options"
            []
            (Type.record
                 [ ( "includeDotFiles", Type.bool )
                 , ( "include"
                   , Type.namedWith [ "BackendTask", "Glob" ] "Include" []
                   )
                 , ( "followSymbolicLinks", Type.bool )
                 , ( "caseSensitiveMatch", Type.bool )
                 , ( "gitignore", Type.bool )
                 , ( "maxDepth", Type.maybe Type.int )
                 ]
            )
    , include = Type.namedWith [ "BackendTask", "Glob" ] "Include" []
    }


make_ :
    { fileStats :
        { fullPath : Elm.Expression
        , sizeInBytes : Elm.Expression
        , lastContentChange : Elm.Expression
        , lastAccess : Elm.Expression
        , lastFileChange : Elm.Expression
        , createdAt : Elm.Expression
        , isDirectory : Elm.Expression
        }
        -> Elm.Expression
    , options :
        { includeDotFiles : Elm.Expression
        , include : Elm.Expression
        , followSymbolicLinks : Elm.Expression
        , caseSensitiveMatch : Elm.Expression
        , gitignore : Elm.Expression
        , maxDepth : Elm.Expression
        }
        -> Elm.Expression
    , onlyFiles : Elm.Expression
    , onlyFolders : Elm.Expression
    , filesAndFolders : Elm.Expression
    }
make_ =
    { fileStats =
        \fileStats_args ->
            Elm.withType
                (Type.alias
                     [ "BackendTask", "Glob" ]
                     "FileStats"
                     []
                     (Type.record
                          [ ( "fullPath", Type.string )
                          , ( "sizeInBytes", Type.int )
                          , ( "lastContentChange"
                            , Type.namedWith [ "Time" ] "Posix" []
                            )
                          , ( "lastAccess"
                            , Type.namedWith [ "Time" ] "Posix" []
                            )
                          , ( "lastFileChange"
                            , Type.namedWith [ "Time" ] "Posix" []
                            )
                          , ( "createdAt"
                            , Type.namedWith [ "Time" ] "Posix" []
                            )
                          , ( "isDirectory", Type.bool )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "fullPath" fileStats_args.fullPath
                     , Tuple.pair "sizeInBytes" fileStats_args.sizeInBytes
                     , Tuple.pair
                         "lastContentChange"
                         fileStats_args.lastContentChange
                     , Tuple.pair "lastAccess" fileStats_args.lastAccess
                     , Tuple.pair "lastFileChange" fileStats_args.lastFileChange
                     , Tuple.pair "createdAt" fileStats_args.createdAt
                     , Tuple.pair "isDirectory" fileStats_args.isDirectory
                     ]
                )
    , options =
        \options_args ->
            Elm.withType
                (Type.alias
                     [ "BackendTask", "Glob" ]
                     "Options"
                     []
                     (Type.record
                          [ ( "includeDotFiles", Type.bool )
                          , ( "include"
                            , Type.namedWith
                                  [ "BackendTask", "Glob" ]
                                  "Include"
                                  []
                            )
                          , ( "followSymbolicLinks", Type.bool )
                          , ( "caseSensitiveMatch", Type.bool )
                          , ( "gitignore", Type.bool )
                          , ( "maxDepth", Type.maybe Type.int )
                          ]
                     )
                )
                (Elm.record
                     [ Tuple.pair "includeDotFiles" options_args.includeDotFiles
                     , Tuple.pair "include" options_args.include
                     , Tuple.pair
                         "followSymbolicLinks"
                         options_args.followSymbolicLinks
                     , Tuple.pair
                         "caseSensitiveMatch"
                         options_args.caseSensitiveMatch
                     , Tuple.pair "gitignore" options_args.gitignore
                     , Tuple.pair "maxDepth" options_args.maxDepth
                     ]
                )
    , onlyFiles =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "OnlyFiles"
            , annotation = Just (Type.namedWith [] "Include" [])
            }
    , onlyFolders =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "OnlyFolders"
            , annotation = Just (Type.namedWith [] "Include" [])
            }
    , filesAndFolders =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "FilesAndFolders"
            , annotation = Just (Type.namedWith [] "Include" [])
            }
    }


caseOf_ :
    { include :
        Elm.Expression
        -> { onlyFiles : Elm.Expression
        , onlyFolders : Elm.Expression
        , filesAndFolders : Elm.Expression
        }
        -> Elm.Expression
    }
caseOf_ =
    { include =
        \includeExpression includeTags ->
            Elm.Case.custom
                includeExpression
                (Type.namedWith [ "BackendTask", "Glob" ] "Include" [])
                [ Elm.Case.branch
                    (Elm.Arg.customType "OnlyFiles" includeTags.onlyFiles)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType "OnlyFolders" includeTags.onlyFolders)
                    Basics.identity
                , Elm.Case.branch
                    (Elm.Arg.customType
                       "FilesAndFolders"
                       includeTags.filesAndFolders
                    )
                    Basics.identity
                ]
    }


call_ :
    { capture : Elm.Expression -> Elm.Expression -> Elm.Expression
    , match : Elm.Expression -> Elm.Expression -> Elm.Expression
    , fromString : Elm.Expression -> Elm.Expression
    , fromStringWithOptions : Elm.Expression -> Elm.Expression -> Elm.Expression
    , captureFilePath : Elm.Expression -> Elm.Expression
    , captureStats : Elm.Expression -> Elm.Expression
    , expectUniqueMatch : Elm.Expression -> Elm.Expression
    , expectUniqueMatchFromList : Elm.Expression -> Elm.Expression
    , literal : Elm.Expression -> Elm.Expression
    , map : Elm.Expression -> Elm.Expression -> Elm.Expression
    , succeed : Elm.Expression -> Elm.Expression
    , oneOf : Elm.Expression -> Elm.Expression
    , zeroOrMore : Elm.Expression -> Elm.Expression
    , atLeastOne : Elm.Expression -> Elm.Expression
    , toBackendTask : Elm.Expression -> Elm.Expression
    , toBackendTaskWithOptions :
        Elm.Expression -> Elm.Expression -> Elm.Expression
    }
call_ =
    { capture =
        \captureArg_ captureArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Glob" ]
                     , name = "capture"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask", "Glob" ]
                                      "Glob"
                                      [ Type.var "a" ]
                                  , Type.namedWith
                                      [ "BackendTask", "Glob" ]
                                      "Glob"
                                      [ Type.function
                                            [ Type.var "a" ]
                                            (Type.var "value")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Glob" ]
                                       "Glob"
                                       [ Type.var "value" ]
                                  )
                             )
                     }
                )
                [ captureArg_, captureArg_0 ]
    , match =
        \matchArg_ matchArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Glob" ]
                     , name = "match"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask", "Glob" ]
                                      "Glob"
                                      [ Type.var "a" ]
                                  , Type.namedWith
                                      [ "BackendTask", "Glob" ]
                                      "Glob"
                                      [ Type.var "value" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Glob" ]
                                       "Glob"
                                       [ Type.var "value" ]
                                  )
                             )
                     }
                )
                [ matchArg_, matchArg_0 ]
    , fromString =
        \fromStringArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Glob" ]
                     , name = "fromString"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.list Type.string
                                       ]
                                  )
                             )
                     }
                )
                [ fromStringArg_ ]
    , fromStringWithOptions =
        \fromStringWithOptionsArg_ fromStringWithOptionsArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Glob" ]
                     , name = "fromStringWithOptions"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask", "Glob" ]
                                      "Options"
                                      []
                                  , Type.string
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.list Type.string
                                       ]
                                  )
                             )
                     }
                )
                [ fromStringWithOptionsArg_, fromStringWithOptionsArg_0 ]
    , captureFilePath =
        \captureFilePathArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Glob" ]
                     , name = "captureFilePath"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask", "Glob" ]
                                      "Glob"
                                      [ Type.function
                                            [ Type.string ]
                                            (Type.var "value")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Glob" ]
                                       "Glob"
                                       [ Type.var "value" ]
                                  )
                             )
                     }
                )
                [ captureFilePathArg_ ]
    , captureStats =
        \captureStatsArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Glob" ]
                     , name = "captureStats"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask", "Glob" ]
                                      "Glob"
                                      [ Type.function
                                            [ Type.namedWith
                                                [ "BackendTask", "Glob" ]
                                                "FileStats"
                                                []
                                            ]
                                            (Type.var "value")
                                      ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Glob" ]
                                       "Glob"
                                       [ Type.var "value" ]
                                  )
                             )
                     }
                )
                [ captureStatsArg_ ]
    , expectUniqueMatch =
        \expectUniqueMatchArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Glob" ]
                     , name = "expectUniqueMatch"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask", "Glob" ]
                                      "Glob"
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
                                           , ( "recoverable", Type.string )
                                           ]
                                       , Type.var "a"
                                       ]
                                  )
                             )
                     }
                )
                [ expectUniqueMatchArg_ ]
    , expectUniqueMatchFromList =
        \expectUniqueMatchFromListArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Glob" ]
                     , name = "expectUniqueMatchFromList"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list
                                      (Type.namedWith
                                         [ "BackendTask", "Glob" ]
                                         "Glob"
                                         [ Type.var "a" ]
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.string, Type.var "a" ]
                                  )
                             )
                     }
                )
                [ expectUniqueMatchFromListArg_ ]
    , literal =
        \literalArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Glob" ]
                     , name = "literal"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.string ]
                                  (Type.namedWith
                                       [ "BackendTask", "Glob" ]
                                       "Glob"
                                       [ Type.string ]
                                  )
                             )
                     }
                )
                [ literalArg_ ]
    , map =
        \mapArg_ mapArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Glob" ]
                     , name = "map"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.function
                                      [ Type.var "a" ]
                                      (Type.var "b")
                                  , Type.namedWith
                                      [ "BackendTask", "Glob" ]
                                      "Glob"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Glob" ]
                                       "Glob"
                                       [ Type.var "b" ]
                                  )
                             )
                     }
                )
                [ mapArg_, mapArg_0 ]
    , succeed =
        \succeedArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Glob" ]
                     , name = "succeed"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.var "constructor" ]
                                  (Type.namedWith
                                       [ "BackendTask", "Glob" ]
                                       "Glob"
                                       [ Type.var "constructor" ]
                                  )
                             )
                     }
                )
                [ succeedArg_ ]
    , oneOf =
        \oneOfArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Glob" ]
                     , name = "oneOf"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.tuple
                                      (Type.tuple Type.string (Type.var "a"))
                                      (Type.list
                                         (Type.tuple Type.string (Type.var "a"))
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Glob" ]
                                       "Glob"
                                       [ Type.var "a" ]
                                  )
                             )
                     }
                )
                [ oneOfArg_ ]
    , zeroOrMore =
        \zeroOrMoreArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Glob" ]
                     , name = "zeroOrMore"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.list Type.string ]
                                  (Type.namedWith
                                       [ "BackendTask", "Glob" ]
                                       "Glob"
                                       [ Type.maybe Type.string ]
                                  )
                             )
                     }
                )
                [ zeroOrMoreArg_ ]
    , atLeastOne =
        \atLeastOneArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Glob" ]
                     , name = "atLeastOne"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.tuple
                                      (Type.tuple Type.string (Type.var "a"))
                                      (Type.list
                                         (Type.tuple Type.string (Type.var "a"))
                                      )
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask", "Glob" ]
                                       "Glob"
                                       [ Type.tuple
                                           (Type.var "a")
                                           (Type.list (Type.var "a"))
                                       ]
                                  )
                             )
                     }
                )
                [ atLeastOneArg_ ]
    , toBackendTask =
        \toBackendTaskArg_ ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Glob" ]
                     , name = "toBackendTask"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask", "Glob" ]
                                      "Glob"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.list (Type.var "a")
                                       ]
                                  )
                             )
                     }
                )
                [ toBackendTaskArg_ ]
    , toBackendTaskWithOptions =
        \toBackendTaskWithOptionsArg_ toBackendTaskWithOptionsArg_0 ->
            Elm.apply
                (Elm.value
                     { importFrom = [ "BackendTask", "Glob" ]
                     , name = "toBackendTaskWithOptions"
                     , annotation =
                         Just
                             (Type.function
                                  [ Type.namedWith
                                      [ "BackendTask", "Glob" ]
                                      "Options"
                                      []
                                  , Type.namedWith
                                      [ "BackendTask", "Glob" ]
                                      "Glob"
                                      [ Type.var "a" ]
                                  ]
                                  (Type.namedWith
                                       [ "BackendTask" ]
                                       "BackendTask"
                                       [ Type.var "error"
                                       , Type.list (Type.var "a")
                                       ]
                                  )
                             )
                     }
                )
                [ toBackendTaskWithOptionsArg_, toBackendTaskWithOptionsArg_0 ]
    }


values_ :
    { capture : Elm.Expression
    , match : Elm.Expression
    , fromString : Elm.Expression
    , fromStringWithOptions : Elm.Expression
    , captureFilePath : Elm.Expression
    , wildcard : Elm.Expression
    , recursiveWildcard : Elm.Expression
    , int : Elm.Expression
    , digits : Elm.Expression
    , captureStats : Elm.Expression
    , expectUniqueMatch : Elm.Expression
    , expectUniqueMatchFromList : Elm.Expression
    , literal : Elm.Expression
    , map : Elm.Expression
    , succeed : Elm.Expression
    , oneOf : Elm.Expression
    , zeroOrMore : Elm.Expression
    , atLeastOne : Elm.Expression
    , toBackendTask : Elm.Expression
    , toBackendTaskWithOptions : Elm.Expression
    , defaultOptions : Elm.Expression
    }
values_ =
    { capture =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "capture"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask", "Glob" ]
                             "Glob"
                             [ Type.var "a" ]
                         , Type.namedWith
                             [ "BackendTask", "Glob" ]
                             "Glob"
                             [ Type.function [ Type.var "a" ] (Type.var "value")
                             ]
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.var "value" ]
                         )
                    )
            }
    , match =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "match"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask", "Glob" ]
                             "Glob"
                             [ Type.var "a" ]
                         , Type.namedWith
                             [ "BackendTask", "Glob" ]
                             "Glob"
                             [ Type.var "value" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.var "value" ]
                         )
                    )
            }
    , fromString =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "fromString"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.list Type.string ]
                         )
                    )
            }
    , fromStringWithOptions =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "fromStringWithOptions"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "BackendTask", "Glob" ] "Options" []
                         , Type.string
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.list Type.string ]
                         )
                    )
            }
    , captureFilePath =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "captureFilePath"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask", "Glob" ]
                             "Glob"
                             [ Type.function [ Type.string ] (Type.var "value")
                             ]
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.var "value" ]
                         )
                    )
            }
    , wildcard =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "wildcard"
            , annotation =
                Just
                    (Type.namedWith
                         [ "BackendTask", "Glob" ]
                         "Glob"
                         [ Type.string ]
                    )
            }
    , recursiveWildcard =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "recursiveWildcard"
            , annotation =
                Just
                    (Type.namedWith
                         [ "BackendTask", "Glob" ]
                         "Glob"
                         [ Type.list Type.string ]
                    )
            }
    , int =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "int"
            , annotation =
                Just
                    (Type.namedWith
                         [ "BackendTask", "Glob" ]
                         "Glob"
                         [ Type.int ]
                    )
            }
    , digits =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "digits"
            , annotation =
                Just
                    (Type.namedWith
                         [ "BackendTask", "Glob" ]
                         "Glob"
                         [ Type.string ]
                    )
            }
    , captureStats =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "captureStats"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask", "Glob" ]
                             "Glob"
                             [ Type.function
                                   [ Type.namedWith
                                       [ "BackendTask", "Glob" ]
                                       "FileStats"
                                       []
                                   ]
                                   (Type.var "value")
                             ]
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.var "value" ]
                         )
                    )
            }
    , expectUniqueMatch =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "expectUniqueMatch"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask", "Glob" ]
                             "Glob"
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
                                  , ( "recoverable", Type.string )
                                  ]
                              , Type.var "a"
                              ]
                         )
                    )
            }
    , expectUniqueMatchFromList =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "expectUniqueMatchFromList"
            , annotation =
                Just
                    (Type.function
                         [ Type.list
                             (Type.namedWith
                                [ "BackendTask", "Glob" ]
                                "Glob"
                                [ Type.var "a" ]
                             )
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.string, Type.var "a" ]
                         )
                    )
            }
    , literal =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "literal"
            , annotation =
                Just
                    (Type.function
                         [ Type.string ]
                         (Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.string ]
                         )
                    )
            }
    , map =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "map"
            , annotation =
                Just
                    (Type.function
                         [ Type.function [ Type.var "a" ] (Type.var "b")
                         , Type.namedWith
                             [ "BackendTask", "Glob" ]
                             "Glob"
                             [ Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.var "b" ]
                         )
                    )
            }
    , succeed =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "succeed"
            , annotation =
                Just
                    (Type.function
                         [ Type.var "constructor" ]
                         (Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.var "constructor" ]
                         )
                    )
            }
    , oneOf =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "oneOf"
            , annotation =
                Just
                    (Type.function
                         [ Type.tuple
                             (Type.tuple Type.string (Type.var "a"))
                             (Type.list (Type.tuple Type.string (Type.var "a")))
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.var "a" ]
                         )
                    )
            }
    , zeroOrMore =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "zeroOrMore"
            , annotation =
                Just
                    (Type.function
                         [ Type.list Type.string ]
                         (Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.maybe Type.string ]
                         )
                    )
            }
    , atLeastOne =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "atLeastOne"
            , annotation =
                Just
                    (Type.function
                         [ Type.tuple
                             (Type.tuple Type.string (Type.var "a"))
                             (Type.list (Type.tuple Type.string (Type.var "a")))
                         ]
                         (Type.namedWith
                              [ "BackendTask", "Glob" ]
                              "Glob"
                              [ Type.tuple
                                  (Type.var "a")
                                  (Type.list (Type.var "a"))
                              ]
                         )
                    )
            }
    , toBackendTask =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "toBackendTask"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith
                             [ "BackendTask", "Glob" ]
                             "Glob"
                             [ Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.list (Type.var "a") ]
                         )
                    )
            }
    , toBackendTaskWithOptions =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "toBackendTaskWithOptions"
            , annotation =
                Just
                    (Type.function
                         [ Type.namedWith [ "BackendTask", "Glob" ] "Options" []
                         , Type.namedWith
                             [ "BackendTask", "Glob" ]
                             "Glob"
                             [ Type.var "a" ]
                         ]
                         (Type.namedWith
                              [ "BackendTask" ]
                              "BackendTask"
                              [ Type.var "error", Type.list (Type.var "a") ]
                         )
                    )
            }
    , defaultOptions =
        Elm.value
            { importFrom = [ "BackendTask", "Glob" ]
            , name = "defaultOptions"
            , annotation =
                Just (Type.namedWith [ "BackendTask", "Glob" ] "Options" [])
            }
    }