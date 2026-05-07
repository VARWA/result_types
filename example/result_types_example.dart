import 'package:result_types/result_types.dart';

Future<Result<int>> safeDivision(int a, int b) {
  return Result.tryAsync(
    () async {
      if (b == 0) {
        throw ArgumentError('Division by zero');
      }
      return a ~/ b;
    },
    onError:
        (error, stackTrace) =>
            ParsingFailure(message: error.toString(), stackTrace: stackTrace),
  );
}

Future<void> main() async {
  final value = await safeDivision(10, 2);

  final message = value.match(
    onSuccess: (data) => 'Result: $data',
    onFailure: (error) => 'Error: $error',
  );

  print(message);
}
