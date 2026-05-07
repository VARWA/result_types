library;

import 'app_failure.dart';

class NetworkFailure extends AppFailure {
  const NetworkFailure({super.message, super.stackTrace});
}

class TokenFailure extends AppFailure {
  const TokenFailure({super.message, super.stackTrace});
}

class ServerFailure extends AppFailure {
  const ServerFailure({super.message, super.stackTrace});
}

class UnknownFailure extends AppFailure {
  const UnknownFailure({super.message, super.stackTrace});
}

class CancelledFailure extends AppFailure {
  const CancelledFailure({required String message}) : super(message: message);
}

class ParsingFailure extends AppFailure {
  const ParsingFailure({super.message, super.stackTrace});
}
