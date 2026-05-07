# Changelog

All notable changes to this project will be documented in this file.

## 0.0.3

- Aligned release artifacts after the previous tag mismatch.
- Updated package metadata and release documentation consistency.
- No breaking API changes.

## 0.0.2

- Finalized repository and package presentation for public release.
- Added strict lint configuration and expanded documentation.
- Added CI checks for formatting, analyze, tests, and `dart pub publish --dry-run`.
- Added `recover`, `recoverWith`, `tap`, and `tapFailure` APIs.
- Improved `AppFailure` equality semantics for deterministic behavior.
- Expanded unit tests for recovery, async failures, and side effects.

## 0.0.1

- Initial release with `Result<T>`, `Success<T>`, and `Failure<T>`.
- Added `AppFailure` hierarchy and common failure implementations.
- Added sync and async helpers for functional error handling.
