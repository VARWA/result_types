# result_types

A lightweight Dart package that provides `Result<T>` and `AppFailure` types for explicit, functional-style error handling.

![Dart](https://img.shields.io/badge/dart-%3E%3D3.7.2-blue)
![License: MIT](https://img.shields.io/badge/license-MIT-green)

## Features

- `Result.success(value)` and `Result.failure(error)` constructors
- Functional helpers: `map`, `flatMap`, `fold`, `getOrElse`, `match`
- Recovery helpers: `recover`, `recoverWith`
- Async helpers: `Result.tryAsync`, `mapAsync`, `flatMapAsync`
- Side-effect helpers: `tap`, `tapFailure`
- Built-in failure types: `NetworkFailure`, `ServerFailure`, `ParsingFailure`, `UnknownFailure`, and more

## Installation

Add to `pubspec.yaml`:

```yaml
dependencies:
  result_types: ^0.0.1
```

Then run:

```bash
dart pub get
```

## Quick Start

```dart
import 'package:result_types/result_types.dart';

Result<int> parsePositiveInt(String input) {
  final value = int.tryParse(input);
  if (value == null) {
    return Result.failure(ParsingFailure(message: 'Invalid number: $input'));
  }
  if (value < 0) {
    return Result.failure(ParsingFailure(message: 'Negative value: $value'));
  }
  return Result.success(value);
}

void main() {
  final result = parsePositiveInt('42')
      .map((x) => x * 2)
      .map((x) => x + 1);

  final text = result.fold(
    (value) => 'Success: $value',
    (error) => 'Failure: $error',
  );

  // ignore: avoid_print
  print(text);
}
```

## Async Example

```dart
import 'package:result_types/result_types.dart';

Future<Result<String>> loadUserName() {
  return Result.tryAsync(
    () async {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      return 'Bogdan';
    },
    onError: (error, stackTrace) =>
        NetworkFailure(message: error.toString(), stackTrace: stackTrace),
  );
}
```

## Recovery Example

```dart
import 'package:result_types/result_types.dart';

Result<int> parsePort(String rawPort) {
  final parsed = int.tryParse(rawPort);
  if (parsed == null) {
    return Result.failure(ParsingFailure(message: 'Port is not a number'));
  }
  return Result.success(parsed);
}

void main() {
  final port = parsePort('invalid')
      .recover((_) => 8080)
      .getOrThrow();

  assert(port == 8080);
}
```

## Why use `Result<T>`

- Keeps happy path and error path explicit in the type system
- Prevents exception-heavy control flow in domain logic
- Makes composition predictable with `map` and `flatMap`
- Improves testability of error scenarios

## Best Practices

- Model failures at the domain boundary (`NetworkFailure`, `ParsingFailure`, etc.)
- Convert thrown exceptions into `AppFailure` using `Result.tryAsync`
- Keep UI and application layers focused on `fold`/`match` instead of `try/catch`

## License

MIT - see the `LICENSE` file.
