part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

final class SignUpEvent extends AuthEvent {
  final User user;
  SignUpEvent({required this.user});
}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}
 
final class LogoutEvent extends AuthEvent {}
final class IsLoggedInEvent extends AuthEvent {}
final class GetCurrentUserEvent extends AuthEvent {}