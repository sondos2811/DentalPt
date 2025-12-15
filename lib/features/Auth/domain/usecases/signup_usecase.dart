import 'package:dartz/dartz.dart';
import 'package:dental_pt/core/error/failures.dart';
import 'package:dental_pt/features/Auth/domain/repositories/auth_repository.dart';

class SignupUsecase {
  final AuthRepository authRepository;
  SignupUsecase({required this.authRepository});
  Future<Either<Failure, Unit>> call({required user}) {
    return authRepository.signUp(user: user);
  }
}
