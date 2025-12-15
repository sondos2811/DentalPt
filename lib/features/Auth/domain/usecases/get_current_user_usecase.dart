import 'package:dartz/dartz.dart';
import 'package:dental_pt/core/error/failures.dart';
import 'package:dental_pt/features/Auth/domain/entities/user.dart';
import 'package:dental_pt/features/Auth/domain/repositories/auth_repository.dart';

final class GetCurrentUserUsecase {
  final AuthRepository authRepository;
  GetCurrentUserUsecase({required this.authRepository});

  Future<Either<Failure, User>> call() {
    return authRepository.getCurrentUser();
  }
}
