# elm-open-api-codegen example

OpenAPI has built-in formats, such as `date-time`, but you can define your own
custom ones, too--and with the `elm-open-api-codegen` package, you can control
how data with your custom format is decoded, encoded, and transformed into a URL
param!

OpenAPI formats are specified by setting `format` alongside `type` in a spec.
For example, this looks like:

```yaml
components:
  schemas:
    ArticleId:
      type: string
      format: article-id
```

To define a custom format, we use an Elm Pages script that calls the
`elm-open-api-codegen` package to generate Elm code for an API schema, rather
than using the `elm-open-api` CLI. This allows us to configure the code
generator by using, for example, the `OpenApi.Config.withFormat` function.

This example includes an `ArticleId` module that defines an opaque id type for
"articles" retrieved through a hypothetical API. We'd like the OpenAPI code
generator to use our `ArticleId.decode` and `ArticleId.encode` functions when
serializing Article IDs, so we need to define a custom format.

We have already run `elm-codegen install src/ArticleId.elm` in order to create
the `codegen/Gen/ArticleId.elm` module. This is an `elm-codegen` helper module
that makes it easier to generate code that uses the types and functions defined
in `src/ArticleId.elm`. We use this helper module in our main script when
telling the OpenAPI code generator what code should be generated for decoding
and encoding our custom `article-id` OpenAPI format.

Take a look at [the example Elm Pages script](scripts/src/CodeGenOpenApi.elm) to
see the code.
