# Contributing to Development of this tool

The general flow of the app is:

1. parse args & read in the spec using `elm-pages`
1. generate the Elm code with `elm-codegen`
1. write it to disk using `elm-pages`.

## Getting Started

- Clone this repo
- Inside your cloned repo, run `direnv allow`
- Start coding!
- Run `npm run dev <path to oas spec>`
  - e.g. `npm run dev ./example/github-spec.json` will produce `generated/GithubV3RestApi/APi.elm` and `generated/GithubV3RestApi/OpenApi.elm`

## Project structure

```
src/
├── JsonSchema/          Anything specific to JSON Schema code gen
│   └── Generate.elm
├── OpenApi/             Anything specific to OpenAPI code gen
│   └── Generate.elm
├── Util/                Utility functions for common Elm code,
│   │                    similar to the common `Extra.*` packages
│   └── List.elm
├── Cli.elm              The main entry point for the tool
├── CliMonad.elm         An abstraction for wrapping code gen & warnings
├── Common.elm           Common, shared types & functions
└── SchemaUtils.elm      Utility functions for working with these Schemas
```
