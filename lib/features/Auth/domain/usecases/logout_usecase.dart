import 'package:dartz/dartz.dart';
import 'package:dental_pt/core/error/failures.dart';
import 'package:dental_pt/features/Auth/domain/repositories/auth_repository.dart';

class LogoutUsecase {
  final AuthRepository authRepository;
  LogoutUsecase({required this.authRepository});

  Future<Either<Failure, Unit>> call() {
    return authRepository.logout();
  }
}
