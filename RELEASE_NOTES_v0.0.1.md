# v0.0.1

Initial public release of `result_types`: a lightweight, composable Result/Failure toolkit for Dart.

## Highlights

- Introduced typed `Result<T>` with `Success<T>` and `Failure<T>` branches.
- Added composition primitives: `map`, `flatMap`, `fold`, `mapFailure`, `getOrElse`, `getOrThrow`.
- Added recovery APIs: `recover` and `recoverWith`.
- Added async-safe operations: `Result.tryAsync`, `mapAsync`, `flatMapAsync`.
- Added ergonomic helpers: `match`, `tap`, `tapFailure`, `or`, `orNull`.

## Failure Model

- Introduced extensible `AppFailure` base type.
- Added common failure variants: `NetworkFailure`, `ServerFailure`, `TokenFailure`, `ParsingFailure`, `CancelledFailure`, `UnknownFailure`.
- Implemented value equality for failures to improve deterministic testing.

## Quality and Tooling

- Added strict static analysis configuration (`analysis_options.yaml`).
- Added CI workflow for format, analyze, test, and `dart pub publish --dry-run`.
- Added contributor guide and improved package documentation.

## Testing

- Added unit tests for success/failure mapping behavior.
- Added tests for recovery paths and async error mapping.
- Added tests for side-effect hooks (`tap`, `tapFailure`).
