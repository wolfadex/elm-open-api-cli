# Contributing to Development of this tool

The general flow of the app is:

1. parse args & read in the spec using `elm-pages`
1. generate the Elm code with `elm-codegen`
1. write it to disk using `elm-pages`.

## Getting Started

Make sure you have Nix installed (with flakes enabled) so you can use the
project's development shell. An easy way to satisfy this requirement is the
[Determinate Nix Installer][determinate-nix]).

- Clone this repo
- Inside your cloned repo, run `direnv allow` or, if you don't use direnv, run
  `nix develop` to manually enter a development shell
- Start coding!
- Run `npm run dev <path to oas spec>`
  - e.g. `npm run dev ./example/github-spec.json` will produce: `generated/GithubV3RestApi/Api.elm`, `generated/GithubV3RestApi/Json.elm`, `generated/GithubV3RestApi/Types.elm`, and `generated/OpenApi/Common.elm`
- Please run `npm run test:gen` when making a pull request to ensure that the generated code is correct. _(would be nice to have this as part of the CI checks in the future)_

[determinate-nix]: https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#determinate-nix-installer

## Working on the elm-open-api-codegen package

In order for your local code for `elm-open-api-cli` and the example project
(`example-using-api`) to use your local `elm-open-api-codegen` code, you'll
need to trick the Elm/Lamdera compiler by running a special script:

    ./scripts/link-local-package

This will modify some `elm.json` files locally. Make sure not to commit these
changes.

When you want to undo the link.run

    ./scripts/unlink-local-package

## Project structure

The top-level project is a command-line interface to the functionality in the
`elm-open-api-codegen` package.

```
src/
└──  Cli.elm             The main entry point for the tool
elm-open-api-codegen/
└── src/
    ├── JsonSchema/          Anything specific to JSON Schema code gen
    │   └── Generate.elm
    ├── OpenApi/             Anything specific to OpenAPI code gen
    │   └── Generate.elm
    ├── Util/                Utility functions for common Elm code,
    │   │                    similar to the common `Extra.*` packages
    │   └── List.elm
    ├── CliMonad.elm         An abstraction for wrapping code gen & warnings
    ├── Common.elm           Common, shared types & functions
    └── SchemaUtils.elm      Utility functions for working with these Schemas
```
