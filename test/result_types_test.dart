import 'package:result_types/result_types.dart';
import 'package:test/test.dart';

void main() {
  group('Result', () {
    test('success maps value', () {
      final result = Result.success(2).map((v) => v * 3);

      expect(result, equals(const Success(6)));
      expect(result.isSuccess, isTrue);
    });

    test('failure keeps error on map', () {
      final failure = ParsingFailure(message: 'bad input');
      final result = Result<int>.failure(failure).map((v) => v * 3);

      expect(result.isFailure, isTrue);
      expect(result.fold((_) => null, (error) => error), same(failure));
    });
  });
}
