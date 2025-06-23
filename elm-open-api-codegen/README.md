# elm-open-api-codegen

Generate Elm code for OpenAPI schemas. This powers
[elm-open-api-cli][elm-open-api-cli], but can be used directly for more powerful
customized code generation.

The main advantage of using this package directly is that you can define your
own custom formats in Elm, which means you can customize the types and generated
code based on the `format` listed in your OpenAPI schema.

See the [example of using this package][example], located in the `-cli`
repository.

[elm-open-api-cli]: https://github.com/wolfadex/elm-open-api-cli
[example]: https://github.com/wolfadex/elm-open-api-cli/tree/main/example-using-api
