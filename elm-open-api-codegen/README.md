# elm-open-api-codegen

Generate Elm code for OpenAPI schemas. This powers
[elm-open-api-cli][elm-open-api-cli], but can be used directly for more powerful
customized code generation.

The main advantage of using this package directly is that you can define your
own custom formats in Elm, which means you can customize the types and generated
code based on the `format` listed in your OpenAPI schema.

See the [example of using this package][example], located in the `-cli`
repository.

When running `elm-codegen`--or in any other way modifying this package's
`codegen/elm.codegen.json` file--be sure to run this script afterward:

    ./scripts/sync-elm-codegen

This moves the `Gen.*` modules to the `src/` folder, which is necessary because
the code in this project is part of an Elm _package_, and unlike Elm
applications, Elm packages do not support specifying extra source directories.

[elm-open-api-cli]: https://github.com/wolfadex/elm-open-api-cli
[example]: https://github.com/wolfadex/elm-open-api-cli/tree/main/example-using-api
