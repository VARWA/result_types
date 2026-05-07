import '../result_types.dart';

extension ResultOps<T> on Result<T> {
  /// Returns success value or `null` on failure.
  T? orNull() => switch (this) {
    Success(value: final data) => data,
    Failure() => null,
  };

  /// Returns success value or [fallback] on failure.
  T or(T fallback) => switch (this) {
    Success(value: final data) => data,
    Failure() => fallback,
  };

  /// Pattern matching helper for `Result`.
  R match<R>({
    required R Function(T) onSuccess,
    required R Function(AppFailure error) onFailure,
  }) => switch (this) {
    Success(value: final data) => onSuccess(data),
    Failure(error: final error) => onFailure(error),
  };

  /// Async variant of [Result.map].
  Future<Result<U>> mapAsync<U>(Future<U> Function(T) f) async =>
      switch (this) {
        Success(value: final data) => Success(await f(data)),
        Failure(error: final failure) => Failure<U>(failure),
      };

  /// Async variant of [Result.flatMap].
  Future<Result<U>> flatMapAsync<U>(Future<Result<U>> Function(T) f) async =>
      switch (this) {
        Success(value: final data) => await f(data),
        Failure(error: final failure) => Failure<U>(failure),
      };

  /// Runs [action] for success values and returns original [Result].
  Result<T> tap(void Function(T value) action) => switch (this) {
    Success(value: final data) =>
      (() {
        action(data);
        return this;
      })(),
    Failure() => this,
  };

  /// Runs [action] for failure values and returns original [Result].
  Result<T> tapFailure(void Function(AppFailure error) action) =>
      switch (this) {
        Success() => this,
        Failure(error: final error) =>
          (() {
            action(error);
            return this;
          })(),
      };
}
