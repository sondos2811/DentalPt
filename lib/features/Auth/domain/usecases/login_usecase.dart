import 'package:dartz/dartz.dart';
import 'package:dental_pt/core/error/failures.dart';
import 'package:dental_pt/features/Auth/domain/entities/user.dart';
import 'package:dental_pt/features/Auth/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;
  LoginUsecase({required this.authRepository});

  Future<Either<Failure, User>> call({required String email, required String password}) {
    return authRepository.login(email: email, password: password);
  }
}
