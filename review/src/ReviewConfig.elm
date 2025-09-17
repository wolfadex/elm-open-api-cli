module ReviewConfig exposing (config)

import Docs.NoMissing exposing (exposedModules, onlyExposed)
import Docs.ReviewAtDocs
import Docs.ReviewLinksAndSections
import Docs.UpToDateReadmeLinks
import NoConfusingPrefixOperator
import NoDebug.Log
import NoDebug.TodoOrToString
import NoExposingEverything
import NoImportingEverything
import NoMismatchedCliVersion
import NoMissingTypeAnnotation
import NoMissingTypeAnnotationInLetIn
import NoMissingTypeExpose
import NoPrematureLetComputation
import NoSimpleLetBody
import NoUnused.CustomTypeConstructorArgs
import NoUnused.CustomTypeConstructors
import NoUnused.Dependencies
import NoUnused.Exports
import NoUnused.Parameters
import NoUnused.Patterns
import NoUnused.Variables
import Review.ImportSimple
import Review.Rule as Rule exposing (Rule)
import Simplify


config : List Rule
config =
    includingCodegenRules
        ++ List.map
            (Rule.ignoreErrorsForDirectories [ "codegen" ])
            exceptCodegenRules


exceptCodegenRules : List Rule
exceptCodegenRules =
    [ Docs.NoMissing.rule
        { document = onlyExposed
        , from = exposedModules
        }
    , Docs.ReviewLinksAndSections.rule
        |> Rule.ignoreErrorsForDirectories [ "src/Gen" ]
    , Docs.ReviewAtDocs.rule
    , Docs.UpToDateReadmeLinks.rule
    , NoConfusingPrefixOperator.rule
    , NoDebug.Log.rule
    , NoDebug.TodoOrToString.rule
        |> Rule.ignoreErrorsForDirectories [ "tests/" ]
    , NoExposingEverything.rule
    , NoImportingEverything.rule []
    , NoMissingTypeAnnotation.rule
        |> Rule.ignoreErrorsForDirectories [ "src/Gen" ]
    , NoMissingTypeAnnotationInLetIn.rule
    , NoMissingTypeExpose.rule
    , NoSimpleLetBody.rule
    , NoPrematureLetComputation.rule
    , NoUnused.CustomTypeConstructors.rule []
    , NoUnused.CustomTypeConstructorArgs.rule
    , NoUnused.Dependencies.rule
    , NoUnused.Parameters.rule
    , NoUnused.Patterns.rule
    , Simplify.rule Simplify.defaults
        |> Rule.ignoreErrorsForDirectories [ "src/Gen" ]
    , Review.ImportSimple.rule
        |> Rule.ignoreErrorsForDirectories [ "src/Gen" ]
    , NoMismatchedCliVersion.rule
    ]


includingCodegenRules : List Rule
includingCodegenRules =
    [ NoUnused.Exports.rule
        |> Rule.ignoreErrorsForFiles
            [ "cli/src/Cli.elm"
            , "src/OpenApi/Config.elm"
            , "cli/src/TestGenScript.elm"
            ]
    , NoUnused.Variables.rule
    ]
