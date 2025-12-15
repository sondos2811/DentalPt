part of 'auth_bloc.dart';

abstract class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSignUpSuccess extends AuthState {}

final class AuthLoginSuccess extends AuthState {
  final User user;
  AuthLoginSuccess({required this.user});
}

final class AuthFailure extends AuthState {
  final String error;
  AuthFailure({required this.error});
}

final class AuthLoggedIn extends AuthState {}

final class AuthLoggedOut extends AuthState {}

final class AuthUserLoaded extends AuthState {
  final User user;
  AuthUserLoaded({required this.user});
}
