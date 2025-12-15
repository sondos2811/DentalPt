// Custom Exceptions

import 'package:dental_pt/core/strings/failure_and_exception.dart';

class ServerException implements Exception {
  final String message;

  ServerException([this.message = ExceptionMessages.serverExceptionMessage]);
}

class CacheException implements Exception {
  final String message;

  CacheException([this.message = ExceptionMessages.cacheExceptionMessage]);
}

class InvalidInputException implements Exception {
  final String message;

  InvalidInputException([this.message = ExceptionMessages.invalidInputExceptionMessage]);
}

class NoInternetException implements Exception {
  final String message;

  NoInternetException([this.message = ExceptionMessages.noInternetExceptionMessage]);
}

class UnexpectedException implements Exception {
  final String message;

  UnexpectedException([this.message = ExceptionMessages.unexpectedExceptionMessage]);
}


