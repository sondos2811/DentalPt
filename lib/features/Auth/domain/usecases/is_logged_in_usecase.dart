import 'package:dartz/dartz.dart';
import 'package:dental_pt/core/error/failures.dart';
import 'package:dental_pt/features/Auth/domain/repositories/auth_repository.dart';

class IsLoggedInUsecase {
  final AuthRepository authRepository;
  IsLoggedInUsecase({required this.authRepository});

  Future<Either<Failure, bool>> call() {
    return authRepository.isLoggedIn();
  }
}
