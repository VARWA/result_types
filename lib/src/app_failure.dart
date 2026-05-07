abstract class AppFailure {
  final String? message;
  final StackTrace? stackTrace;

  AppFailure({this.message, this.stackTrace});

  @override
  String toString() => '${runtimeType.toString()}: $message';
}
