# Contributing to Development of this tool

The general flow of the app is:

1. parse args & read in the spec using `elm-pages`
2. generate the Elm code with `elm-codegen`
3. write it to disk using `elm-pages`.

## Getting Started

Make sure you have Nix installed (with flakes enabled) so you can use the
project's development shell. An easy way to satisfy this requirement is the
[Determinate Nix Installer][determinate-nix].

- Clone this repo
- Inside your cloned repo, run `direnv allow` to automatically enter the development shell,
  - if you don't use direnv, run `nix develop` to manually enter a development shell
- Start coding!
- Run `npm run dev <path to oas spec>`
  - e.g. `npm run dev ./example/github-spec.json` will produce: `generated/GithubV3RestApi/Api.elm`, `generated/GithubV3RestApi/Json.elm`, `generated/GithubV3RestApi/Types.elm`, and `generated/OpenApi/Common.elm`
- Please run `npm run test:gen` when making a pull request to ensure that the generated code is correct. _(would be nice to have this as part of the CI checks in the future)_

[determinate-nix]: https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#determinate-nix-installer

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
