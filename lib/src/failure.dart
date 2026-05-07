library;

import 'app_failure.dart';

class NetworkFailure extends AppFailure {
  NetworkFailure({super.message, super.stackTrace});
}

class TokenFailure extends AppFailure {}

class ServerFailure extends AppFailure {}

class UnknownFailure extends AppFailure {
  UnknownFailure({super.message, super.stackTrace});
}

class CancelledFailure extends AppFailure {
  CancelledFailure({required String message}) : super(message: message);
}

class ParsingFailure extends AppFailure {
  ParsingFailure({super.message, super.stackTrace});
}
