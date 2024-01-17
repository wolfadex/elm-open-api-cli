
# Using the CLI

### Install the CLI:
- `npm install -D elm-open-api`

### Run the CLI:
- `node elm-open-api ./page/to/oas.json`

### Arguments you can pass:

- `<entryFilePath>`: The path to the Open API Spec, either `.json` or `.y[a]ml`
  - Technically the OAS allows for parts of a spec to be in separate files, but this isn't supported yet.
- `[--output-dir <output dir>]`: The directory to output to. Defaults to `generated/`.
- `[--module-name <module name>]`: The Elm module name. Default to `<OAS info.title>`.
- `[--generateTodos <generateTodos>]`: Whether to generate TODOs for unimplemented endpoints, or fail when something unexpected is encountered. Defaults to `no`. To generate `Debug.todo ""` instead of failing use one of: `yes`, `y`, `true`.
