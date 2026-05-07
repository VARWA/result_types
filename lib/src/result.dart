import 'package:result_types/result_types.dart';

/// Represents a computation that can complete with either success or failure.
sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is Failure<T>;

  /// Creates a successful [Result] with [value].
  factory Result.success(T value) => Success(value);

  /// Creates a failed [Result] with [error].
  factory Result.failure(AppFailure error) => Failure(error);

  /// Returns the successful value or throws [AppFailure].
  T getOrThrow() => switch (this) {
    Success(value: final data) => data,
    Failure(error: final failure) => throw failure,
  };

  /// Executes [operation] and converts thrown exceptions into [AppFailure].
  static Future<Result<T>> tryAsync<T>(
    Future<T> Function() operation, {
    AppFailure Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    try {
      final result = await operation();
      return Result.success(result);
    } catch (e, s) {
      final mappedFailure =
          onError?.call(e, s) ?? UnknownFailure(message: '$e', stackTrace: s);
      return Result.failure(mappedFailure);
    }
  }

  /// Transforms the success value while preserving failure.
  Result<U> map<U>(U Function(T value) f);

  /// Chains operations that already return [Result].
  Result<U> flatMap<U>(Result<U> Function(T value) f);

  /// Transforms a failure while preserving success.
  Result<T> mapFailure(AppFailure Function(AppFailure error) f);

  /// Reduces [Result] into a single value.
  U fold<U>(U Function(T) onSuccess, U Function(AppFailure) onFailure);

  /// Returns the success value or computes a fallback from failure.
  T getOrElse(T Function(AppFailure) orElse);

  /// Converts failure into success using [recovery].
  Result<T> recover(T Function(AppFailure error) recovery);

  /// Converts failure into another [Result] using [recovery].
  Result<T> recoverWith(Result<T> Function(AppFailure error) recovery);
}

final class Success<T> extends Result<T> {
  /// Value produced by a successful computation.
  final T value;

  const Success(this.value);

  @override
  Result<U> map<U>(U Function(T value) f) => Result.success(f(value));

  @override
  Result<U> flatMap<U>(Result<U> Function(T value) f) => f(value);

  @override
  Result<T> mapFailure(AppFailure Function(AppFailure error) f) => this;

  @override
  U fold<U>(U Function(T) onSuccess, U Function(AppFailure) onFailure) =>
      onSuccess(value);

  @override
  T getOrElse(T Function(AppFailure) orElse) => value;

  @override
  Result<T> recover(T Function(AppFailure error) recovery) => this;

  @override
  Result<T> recoverWith(Result<T> Function(AppFailure error) recovery) => this;

  @override
  bool operator ==(Object other) => other is Success<T> && other.value == value;

  @override
  int get hashCode => value.hashCode;
}

final class Failure<T> extends Result<T> {
  /// Error produced by a failed computation.
  final AppFailure error;

  const Failure(this.error);

  @override
  Result<U> map<U>(U Function(T value) f) => Result.failure(error);

  @override
  Result<U> flatMap<U>(Result<U> Function(T value) f) => Result.failure(error);

  @override
  Result<T> mapFailure(AppFailure Function(AppFailure error) f) =>
      Result.failure(f(error));

  @override
  U fold<U>(U Function(T) onSuccess, U Function(AppFailure) onFailure) =>
      onFailure(error);

  @override
  T getOrElse(T Function(AppFailure) orElse) => orElse(error);

  @override
  Result<T> recover(T Function(AppFailure error) recovery) =>
      Result.success(recovery(error));

  @override
  Result<T> recoverWith(Result<T> Function(AppFailure error) recovery) =>
      recovery(error);

  @override
  bool operator ==(Object other) => other is Failure<T> && other.error == error;

  @override
  int get hashCode => error.hashCode;
}
