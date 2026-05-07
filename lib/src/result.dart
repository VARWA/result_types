import 'package:result_types/result_types.dart';

sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;

  bool get isFailure => this is Failure<T>;

  /// Успешный результат
  factory Result.success(T value) => Success(value);

  /// Ошибка
  factory Result.failure(AppFailure error) => Failure(error);

  T getOrThrow() => switch (this) {
    Success(value: final data) => data,
    Failure(error: final failure) => throw failure,
  };

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

  Result<U> map<U>(U Function(T value) f);

  Result<U> flatMap<U>(Result<U> Function(T value) f);

  Result<T> mapFailure(AppFailure Function(AppFailure error) f);

  U fold<U>(U Function(T) onSuccess, U Function(AppFailure) onFailure);

  T getOrElse(T Function(AppFailure) orElse);
}

final class Success<T> extends Result<T> {
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
  bool operator ==(Object other) => other is Success<T> && other.value == value;

  @override
  int get hashCode => value.hashCode;
}

final class Failure<T> extends Result<T> {
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
  bool operator ==(Object other) => other is Failure<T> && other.error == error;

  @override
  int get hashCode => error.hashCode;
}
