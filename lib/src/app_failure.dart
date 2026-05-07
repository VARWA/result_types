/// Base contract for all domain/application failures.
abstract class AppFailure {
  final String? message;
  final StackTrace? stackTrace;

  const AppFailure({this.message, this.stackTrace});

  @override
  String toString() => '${runtimeType.toString()}: $message';

  @override
  bool operator ==(Object other) {
    return other.runtimeType == runtimeType &&
        other is AppFailure &&
        other.message == message &&
        other.stackTrace?.toString() == stackTrace?.toString();
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, stackTrace?.toString());
}
