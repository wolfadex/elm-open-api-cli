# elm-open-api-codegen example

This example uses `elm-open-api-codegen` to generate Elm code for an API schema,
customizing some of the generated code in the process, by use of the
`OpenApi.Config.withFormat` function.

The "project" includes a `Data.Id` module that defines an opaque id type for API
entities. `elm-codegen install src/Data/Id.elm` has been run in order to be able
to generate code using this custom module, when defining how to generate code
for custom formats in the main script.

See [the main generation script here](scripts/src/CodeGenOpenApi.elm).
