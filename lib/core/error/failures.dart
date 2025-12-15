import 'package:dental_pt/core/strings/failure_and_exception.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

// Specific Failures
class ServerFailure extends Failure {
  const ServerFailure() : super(FailureMessages.serverFailureMessage);
}

class CacheFailure extends Failure {
  const CacheFailure() : super(FailureMessages.cacheFailureMessage);
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure() : super(FailureMessages.invalidInputFailureMessage);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure() : super(FailureMessages.unexpectedFailureMessage);
}

class NoInternetFailure extends Failure {
  const NoInternetFailure() : super(FailureMessages.noInternetFailureMessage);
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super(FailureMessages.unknownFailureMessage);
}