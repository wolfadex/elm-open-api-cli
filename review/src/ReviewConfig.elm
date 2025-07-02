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
import NoMissingTypeAnnotation
import NoMissingTypeAnnotationInLetIn
import NoMissingTypeExpose
import NoPrematureLetComputation
import NoSimpleLetBody
import NoUnused.CustomTypeConstructorArgs
import NoUnused.CustomTypeConstructors
import NoUnused.Dependencies
import NoUnused.Exports
import NoUnused.Modules
import NoUnused.Parameters
import NoUnused.Patterns
import NoUnused.Variables
import Review.ImportSimple
import Review.Rule as Rule exposing (Rule)
import Simplify


config : List Rule
config =
    [ Docs.NoMissing.rule
        { document = onlyExposed
        , from = exposedModules
        }
    , Docs.ReviewLinksAndSections.rule
        |> Rule.ignoreErrorsForDirectories [ "src/Gen", "codegen" ]
    , Docs.ReviewAtDocs.rule
        |> Rule.ignoreErrorsForDirectories [ "codegen" ]
    , Docs.UpToDateReadmeLinks.rule
    , NoConfusingPrefixOperator.rule
    , NoDebug.Log.rule
    , NoDebug.TodoOrToString.rule
        |> Rule.ignoreErrorsForDirectories [ "tests/" ]
    , NoExposingEverything.rule
    , NoImportingEverything.rule []
    , NoMissingTypeAnnotation.rule
        |> Rule.ignoreErrorsForDirectories [ "codegen" ]
    , NoMissingTypeAnnotationInLetIn.rule
        |> Rule.ignoreErrorsForDirectories [ "codegen" ]
    , NoMissingTypeExpose.rule
    , NoSimpleLetBody.rule
    , NoPrematureLetComputation.rule
    , NoUnused.CustomTypeConstructors.rule []
    , NoUnused.CustomTypeConstructorArgs.rule
        |> Rule.ignoreErrorsForDirectories [ "codegen" ]
    , NoUnused.Dependencies.rule
    , NoUnused.Exports.rule
        |> Rule.ignoreErrorsForFiles
            [ "src/Cli.elm"
            , "src/OpenApi/Config.elm"
            , "src/TestGenScript.elm"
            ]
        |> Rule.ignoreErrorsForDirectories [ "codegen" ]

    -- NoUnused.Modules would normally be redundant, but we are excluding codegen from NoUnused.Exports, and yet we still want to check for unused modules
    , NoUnused.Modules.rule
        |> Rule.ignoreErrorsForFiles [ "src/TestGenScript.elm" ]
    , NoUnused.Parameters.rule
    , NoUnused.Patterns.rule
    , NoUnused.Variables.rule
    , Simplify.rule Simplify.defaults
        |> Rule.ignoreErrorsForDirectories [ "src/Gen", "codegen" ]
    , Review.ImportSimple.rule
        |> Rule.ignoreErrorsForDirectories [ "src/Gen", "codegen" ]
    ]
