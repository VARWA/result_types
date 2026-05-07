import '../result_types.dart';

extension ResultOps<T> on Result<T> {
  T? orNull() => switch (this) {
    Success(value: final data) => data,
    Failure() => null,
  };

  T or(T fallback) => switch (this) {
    Success(value: final data) => data,
    Failure() => fallback,
  };

  R match<R>({
    required R Function(T) onSuccess,
    required R Function(AppFailure error) onFailure,
  }) => switch (this) {
    Success(value: final data) => onSuccess(data),
    Failure(error: final error) => onFailure(error),
  };

  Future<Result<U>> mapAsync<U>(Future<U> Function(T) f) async =>
      switch (this) {
        Success(value: final data) => Success(await f(data)),
        Failure(error: final failure) => Failure<U>(failure),
      };

  Future<Result<U>> flatMapAsync<U>(Future<Result<U>> Function(T) f) async =>
      switch (this) {
        Success(value: final data) => await f(data),
        Failure(error: final failure) => Failure<U>(failure),
      };

  // static Future<Result<T>> fromAsync<T>(
  //   Future<T> Function() fn, {
  //   AppFailure Function(Object, StackTrace)? onError,
  //   void Function(Object, StackTrace)? logger,
  // }) async {
  //   try {
  //     return Success(await fn());
  //   } catch (e, s) {
  //     logger?.call(e, s);
  //     final failure = onError?.call(e, s) ?? UnknownFailure(message: e.toString(), stackTrace: s);
  //     return Failure<T>(failure);
  //   }
  // }
}
