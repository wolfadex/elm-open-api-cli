module NoMismatchedCliVersion exposing (rule)

import Dict exposing (Dict)
import Elm.Syntax.Expression as Expression exposing (Expression)
import Elm.Syntax.ModuleName exposing (ModuleName)
import Elm.Syntax.Node as Node exposing (Node(..))
import Elm.Syntax.Range as Range
import Json.Decode
import Review.FilePattern as FilePattern
import Review.Fix as Fix
import Review.Rule as Rule exposing (ModuleKey, Rule)
import String


rule : Rule
rule =
    Rule.newProjectRuleSchema "NoMismatchedCliVersion" initialContext
        |> Rule.withExtraFilesProjectVisitor staticFilesVisitor
            [ FilePattern.include "package.json" ]
        |> Rule.withModuleVisitor (Rule.withExpressionEnterVisitor expressionVisitor)
        |> Rule.withModuleContext
            { fromProjectToModule = fromProjectToModule
            , fromModuleToProject = fromModuleToProject
            , foldProjectContexts = foldProjectContexts
            }
        |> Rule.fromProjectRuleSchema


type alias ProjectContext =
    { versionFromPackageJson : Maybe String
    }


type alias ModuleContext =
    { versionFromPackageJson : Maybe String
    , isCliModule : Bool
    }


initialContext : ProjectContext
initialContext =
    { versionFromPackageJson = Nothing
    }


staticFilesVisitor :
    Dict String { fileKey : Rule.ExtraFileKey, content : String }
    -> ProjectContext
    -> ( List (Rule.Error { useErrorForModule : () }), ProjectContext )
staticFilesVisitor files context =
    case Dict.values files of
        packageJson :: [] ->
            case Json.Decode.decodeString (Json.Decode.field "version" Json.Decode.string) packageJson.content of
                Ok version ->
                    ( []
                    , { context
                        | versionFromPackageJson = Just version
                      }
                    )

                Err err ->
                    ( [ Rule.errorForExtraFile packageJson.fileKey
                            { message = "Failed to decode package.json"
                            , details = [ Json.Decode.errorToString err ]
                            }
                            Range.empty
                      ]
                    , context
                    )

        _ ->
            ( [ Rule.globalError
                    { message = "Missing package.json"
                    , details = []
                    }
              ]
            , context
            )


expressionVisitor : Node Expression -> ModuleContext -> ( List (Rule.Error {}), ModuleContext )
expressionVisitor node context =
    case ( context.isCliModule, context.versionFromPackageJson, Node.value node ) of
        ( True, Just version, Expression.Application [ Node _ (Expression.FunctionOrValue _ "withDoc"), Node range (Expression.Literal doc) ] ) ->
            case String.lines doc of
                "" :: firstLine :: _ ->
                    let
                        prefix =
                            "version: "
                    in
                    if firstLine == prefix ++ version then
                        ( [], context )

                    else if String.startsWith prefix firstLine then
                        let
                            versionRange =
                                { start =
                                    { row = range.start.row + 1
                                    , column = String.length prefix + 1
                                    }
                                , end =
                                    { row = range.start.row + 1
                                    , column = String.length prefix + String.length version + 1
                                    }
                                }
                        in
                        ( [ Rule.errorWithFix
                                { message = "Mismatched version"
                                , details = [ "Expected: " ++ version ]
                                }
                                versionRange
                                [ Fix.replaceRangeBy versionRange version ]
                          ]
                        , context
                        )

                    else
                        let
                            firstLineRange =
                                { start =
                                    { row = range.start.row + 1
                                    , column = 1
                                    }
                                , end =
                                    { row = range.start.row + 1
                                    , column = String.length firstLine
                                    }
                                }
                        in
                        ( [ Rule.error
                                { message = "Missing version line"
                                , details = [ "Expected first line to start with \"" ++ prefix ++ "\"" ]
                                }
                                firstLineRange
                          ]
                        , context
                        )

                _ ->
                    ( [ Rule.error
                            { message = "Unexpected documentation format"
                            , details = [ "Expected a multi-line string, starting with a newline character" ]
                            }
                            range
                      ]
                    , context
                    )

        _ ->
            ( [], context )


fromProjectToModule : ModuleKey -> Node ModuleName -> ProjectContext -> ModuleContext
fromProjectToModule _ moduleName context =
    { versionFromPackageJson = context.versionFromPackageJson
    , isCliModule = Node.value moduleName == [ "Cli" ]
    }


fromModuleToProject : ModuleKey -> Node ModuleName -> ModuleContext -> ProjectContext
fromModuleToProject _ _ context =
    { versionFromPackageJson = context.versionFromPackageJson
    }


foldProjectContexts : ProjectContext -> ProjectContext -> ProjectContext
foldProjectContexts x y =
    let
        versionFromPackageJson =
            case
                ( x.versionFromPackageJson, y.versionFromPackageJson )
            of
                ( Just version, _ ) ->
                    Just version

                ( _, Just version ) ->
                    Just version

                _ ->
                    Nothing
    in
    { versionFromPackageJson = versionFromPackageJson
    }
