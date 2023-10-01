# Elm API SDK Generator

Generate an Elm SDK from an OpenAPI Spec (OAS).

## Goal

To allow developers to generate an Elm module(s) from an OpenAPI Spec. This is primarily for developers wanting to integrate with a 3rd party service that doesn't provide an Elm SDK for their service. It can also be used within a company where the back end generates an OAS from the written code or an OAS is written and used to generate both the backend and Elm SDKs.

## Getting Started

- `npm install -D elm-open-api`
- `node elm-open-api ./page/to/oas.json`

Arguments you can pass:

- `<entryFilePath>`: The path to the Open API Spec, either `.json` or `.y[a]ml`
  - Technically the OAS allows for parts of a spec to be in separate files, but this isn't supported yet.
- `[--output <output>]`: The file to output. Defaults to `generated/<OAS info.title>.elm`.
- `[--namespace <namespace>]`: Similar to the `--output` (need better docs around these 2 options).
- `[--generateTodos <generateTodos>]`: Whether to generate TODOs for unimplemented endpoints, or fail when something unexpected is encountered. Defaults to `no`. To generate `Debug.todo ""` instead of failing use one of: `yes`, `y`, `true`.

## Development

The general flow of the app is: parse args & read in the spec using `elm-pages`, generate the Elm code with `elm-codegen`, and write it to disk using `elm-pages`.

- Clone this repo
- Inside your cloned repo, run `direnv allow`
- Start coding!
- Run `npm run dev <path to oas spec>.json`
  - e.g. `npm run dev ./example/github-spec.json` will produce `generated/GitHub_v3_REST_API.elm`

## Notes

- This was setup with Nix, and I'm not a Nix expert.
- This currently compiles everything into a single file. This isn't neessarily bad as Elm has live-code-inclusion, but it does make it harder to work with. Maybe we should compile to multiple modules?
  - The GitHub Spec currently generates 120k+ loc, well below the ~1M loc limit for a module.

## Thank you

- [miniBill](https://github.com/miniBill/) for your **many** contributions
- [elm-pages](https://elm-pages.com/) for making it easy to write a CLI app in Elm
- [Elm](https://elm-lang.org/) for an easy to use & maintain language
