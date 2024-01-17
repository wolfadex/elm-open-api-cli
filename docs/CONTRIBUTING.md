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
  - e.g. `npm run dev ./example/github-spec.json` will produce `generated/GitHub_v3_REST_API.elm`
