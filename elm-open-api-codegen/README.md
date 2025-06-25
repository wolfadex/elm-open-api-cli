# elm-open-api-codegen

Generate Elm code for OpenAPI schemas. This powers
[elm-open-api-cli][elm-open-api-cli], but can be used directly for more powerful
customized code generation.

The main advantage of using this package directly is that you can define your
own custom formats in Elm, which means you can customize the types and generated
code based on the `format` listed in your OpenAPI schema.

See the [example of using this package][example], located in the `-cli`
repository.

The `elm.codegen.json` file in this project is located in the `src` directory.
Since this isn't the standard directory, you'll need to tell elm-codegen where
it is. You can run `elm-codegen install --cwd=src` or use this wrapper script:

    ./scripts/codegen

The codegen config is in `src` so that the `Gen.*` modules are written to the
`src/` folder, which is necessary because the code in this project is part of an
Elm _package_, and unlike Elm applications, Elm packages do not support
specifying extra source directories.

Note that `elm-codegen run` isn't used (there is no `Generate.elm` file).

[elm-open-api-cli]: https://github.com/wolfadex/elm-open-api-cli
[example]: https://github.com/wolfadex/elm-open-api-cli/tree/main/example-using-api
