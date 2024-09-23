# Using the CLI

### Install the CLI:

-   `npm install -D elm-open-api`

### Run the CLI:

-   `npx elm-open-api ./page/to/oas.json`

### Arguments you can pass:

-   `<entryFilePath>`: The path to the Open API Spec, either `.json` or `.y[a]ml`
    -   Technically the OAS allows for parts of a spec to be in separate files, but this isn't supported yet.
-   `[--output-dir <output dir>]`: The directory to output to. Defaults to `generated/`.
-   `[--module-name <module name>]`: The Elm module name. Default to `<OAS info.title>`.
-   `[--auto-convert-swagger]`: If passed in, and a Swagger doc is encountered, will attempt to convert it to an Open API file. If not passed in, and a Swagger doc is encountered, the user will be manually prompted to convert.
-   `[--swagger-conversion-url]`: The URL to use to convert a Swagger doc to an Open API file. Defaults to `https://converter.swagger.io/api/convert`.
-   `[--swagger-conversion-command]`: Instead of making an HTTP request to convert from Swagger to Open API, use this command.
-   `[--swagger-conversion-command-args]`: Additional arguments to pass to the Swagger conversion command, before the contents of the Swagger file are passed in.
-   `[--generateTodos <generateTodos>]`: Whether to generate TODOs for unimplemented endpoints, or fail when something unexpected is encountered. Defaults to `no`. To generate `Debug.todo ""` instead of failing use one of: `yes`, `y`, `true`.
-   `[--overrides <file path>]`: Load an additional file to override parts of the original Open API file.
    - This is most commonly used for malformed OAS files (e.g. missing `required` on a required field) but can be used for anything you want
-   `[--write-merged-to <file path>]`: Write the merged Open API spec to the given file (see `--overrides` for merging).
## Example outputs:

Assume we have an OAS file named `my-cool-company-oas.json` and it has a field `"title": "My Coool Company"` and we run the CLI like so

```sh
npx elm-open-api ./my-cool-company-oas.json
```

then we'll output like

```sh
🎉 SDK generated:

    generated/MyCooolCompany/Api.elm
    generated/MyCooolCompany/Json.elm
    generated/MyCooolCompany/Types.elm
    generated/OpenApi/Common.elm


You'll also need elm/http and elm/json installed. Try running:

    elm install elm/http
    elm install elm/json


and possibly need elm/bytes and elm/url installed. If that's the case, try running:
    elm install elm/bytes
    elm install elm/url
```

That's nice, but maybe we want to have a less specific module name. We could instead run

```sh
npx elm-open-api ./my-cool-company-oas.json --module-name="My.Comp"
```

which would result in

```sh
🎉 SDK generated:

    generated/My/Comp/Api.elm
    generated/My/Comp/Json.elm
    generated/My/Comp/Types.elm
    generated/OpenApi/Common.elm


You'll also need elm/http and elm/json installed. Try running:

    elm install elm/http
    elm install elm/json


and possibly need elm/bytes and elm/url installed. If that's the case, try running:
    elm install elm/bytes
    elm install elm/url
```

Notice the new path (and Elm module name) for the files.

Alternatively, maybe we have a different directory naming scheme for our project. We could do

```sh
npx elm-open-api ./my-cool-company-oas.json --output-dir="src"
```

which gives us

```sh
🎉 SDK generated:

    src/MyCooolCompany/Api.elm
    src/MyCooolCompany/Json.elm
    src/MyCooolCompany/Types.elm
    src/OpenApi/Common.elm


You'll also need elm/http and elm/json installed. Try running:

    elm install elm/http
    elm install elm/json


and possibly need elm/bytes and elm/url installed. If that's the case, try running:
    elm install elm/bytes
    elm install elm/url
```

This time only the root directory has changed.
