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
      expect(result.fold((_) => null, (error) => error), equals(failure));
    });

    test('recover converts failure into success', () {
      final result = Result<int>.failure(
        const NetworkFailure(message: 'no connection'),
      ).recover((_) => 42);

      expect(result, equals(const Success(42)));
    });

    test('recoverWith replaces failure with another result', () {
      final result = Result<int>.failure(
        const ParsingFailure(message: 'invalid'),
      ).recoverWith((_) => Result.success(8080));

      expect(result, equals(const Success(8080)));
    });

    test('tryAsync maps thrown exception into failure', () async {
      final result = await Result.tryAsync<int>(() async {
        throw StateError('boom');
      });

      expect(result.isFailure, isTrue);
    });

    test('tap and tapFailure run side effects for matching state', () {
      var successSeen = 0;
      var failureSeen = 0;

      Result.success(7).tap((_) => successSeen++);
      Result<int>.failure(const UnknownFailure(message: 'x')).tapFailure((_) {
        failureSeen++;
      });

      expect(successSeen, 1);
      expect(failureSeen, 1);
    });
  });
}
