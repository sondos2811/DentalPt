// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:dental_pt/core/error/failures.dart';
import 'package:dental_pt/features/Auth/data/datasources/auth_local_datasources.dart';
import 'package:dental_pt/features/Auth/data/datasources/auth_remote_datasources.dart';
import 'package:dental_pt/features/Auth/domain/entities/user.dart';
import 'package:dental_pt/features/Auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final hasSession = await localDataSource.hasSession();
      return Right(hasSession);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> login(
      {required String email, required String password}) async {
    try {
      final user =
          await remoteDataSource.logIn(email: email, password: password);
      // Save tokens after successful login for session persistence
      final session = Supabase.instance.client.auth.currentSession;
      if (session != null) {
        await localDataSource.saveTokens(
            session.accessToken, session.refreshToken ?? '');
      }
      return Right(user.toEntity());
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      // Sign out from Supabase first
      await remoteDataSource.logout();
      // Then clear local session
      await localDataSource.clearSession();
      return const Right(unit);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp({required User user}) async {
    try {
      final userModel = user.toModel();
      await remoteDataSource.signUp(userModel: userModel);
      return const Right(unit);
    } on Exception catch (e) {
      // Log the error for debugging
      print('SignUp error: $e');
      return const Left(ServerFailure());
    } catch (e) {
      print('Unexpected SignUp error: $e');
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      return Right(userModel.toEntity());
    } catch (e) {
      return const Left(ServerFailure());
    }
  }
}

