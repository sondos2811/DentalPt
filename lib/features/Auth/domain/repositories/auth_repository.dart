import 'package:dental_pt/core/error/failures.dart';
import 'package:dental_pt/features/Auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> signUp({
    required User user,
  });

  Future<Either<Failure, User>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, bool>> isLoggedIn();
  Future<Either<Failure, User>> getCurrentUser();
}

