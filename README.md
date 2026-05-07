# result_types

A lightweight Dart package that provides `Result<T>` and `AppFailure` types for explicit, functional-style error handling.

## Features

- `Result.success(value)` and `Result.failure(error)` constructors
- Functional helpers: `map`, `flatMap`, `fold`, `getOrElse`, `match`
- Async helpers: `Result.tryAsync`, `mapAsync`, `flatMapAsync`
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

## License

MIT - see the `LICENSE` file.
