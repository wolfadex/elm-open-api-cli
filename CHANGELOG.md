# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.2] - 2024-04-14

### Added

- Custom error handling: now generates a custom error type for each endpoint that has a non-2xx responses.
- Post generation notes: after generating the SDK, a message will be displayed with additional dependencies to install.

### Changed

- Warnings are now grouped instead of duplicated

### Removed

- [elm-community/json-extra](https://package.elm-lang.org/packages/elm-community/json-extra/latest/) is no loonger required as a dependency

## [0.2.1] - 2024-04-14

- A duplicate release of 0.2.0

## [0.2.0] - 2024-01-16

### Added

- Custom error handling:
  - Now generates a custom error type for each endpoint that has a non-2xx responses.

## [0.1.3-beta.1] - 2023-11-17

## [0.1.2] - 2023-11-13

### Fixed

- I published the wrong build for 0.1.1, this published the correct build. See 0.1.1 for changes.

## [0.1.1] - 2023-11-01

### Fixed

- [incorrect parsing of JSON files](https://github.com/wolfadex/elm-open-api-cli/issues/53)

  - Resolved by https://github.com/wolfadex/elm-open-api-cli/pull/54/, by @lawik

## [0.1.0] - 2023-10-06

### Initial release
