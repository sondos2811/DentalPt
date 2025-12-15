import 'package:bloc/bloc.dart';
import 'package:dental_pt/core/network/network_info.dart';
import 'package:dental_pt/core/strings/failure_and_exception.dart';
import 'package:dental_pt/features/Auth/domain/entities/user.dart';
import 'package:dental_pt/features/Auth/domain/usecases/get_current_user_usecase.dart';
import 'package:dental_pt/features/Auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:dental_pt/features/Auth/domain/usecases/login_usecase.dart';
import 'package:dental_pt/features/Auth/domain/usecases/logout_usecase.dart';
import 'package:dental_pt/features/Auth/domain/usecases/signup_usecase.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final SignupUsecase signupUsecase;
  final IsLoggedInUsecase isLoggedInUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final LogoutUsecase logoutUsecase;

  final NetworkInfo networkInfo;
  AuthBloc(
      {required this.loginUsecase,
      required this.signupUsecase,
      required this.isLoggedInUsecase,
      required this.getCurrentUserUsecase,
      required this.logoutUsecase,
      required this.networkInfo})
      : super(AuthInitial()) {
    on<LoginEvent>(_loginRequested);
    on<SignUpEvent>(_signUpRequested);
    on<IsLoggedInEvent>(_isLoggedInRequested);
    on<GetCurrentUserEvent>(_getCurrentUserRequested);
    on<LogoutEvent>(_logoutRequested);
  }
  Future<void> _getCurrentUserRequested(GetCurrentUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        emit(AuthFailure(error: FailureMessages.noInternetFailureMessage));
        return;
      }
      final result = await getCurrentUserUsecase();
      result.fold((failure) {
        emit(AuthFailure(error: failure.message));
      }, (user) {
        emit(AuthUserLoaded(user: user));
      });
    } catch (e) {
      emit(AuthFailure(error: ExceptionMessages.unexpectedExceptionMessage));
    }
  }
  Future<void> _isLoggedInRequested(
    IsLoggedInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        emit(AuthFailure(error: FailureMessages.noInternetFailureMessage));
        return;
      }
      final result = await isLoggedInUsecase();
      result.fold(
        (failure) {
          emit(AuthFailure(error: failure.message));
        },
        (isLoggedIn) {
          if (isLoggedIn) {
            emit(AuthLoggedIn());
          } else {
            emit(AuthLoggedOut());
          }
        },
      );
    } catch (e) {
      emit(AuthFailure(error: ExceptionMessages.unexpectedExceptionMessage));
    }
  }

  Future<void> _loginRequested(
      LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        emit(AuthFailure(error: FailureMessages.noInternetFailureMessage));
        return;
      }
      final result =
          await loginUsecase(email: event.email, password: event.password);
      result.fold(
        (failure) {
          emit(AuthFailure(error: failure.message));
        },
        (user) {
          emit(AuthLoginSuccess(user: user));
        },
      );
    } catch (e) {
      emit(AuthFailure(error: ExceptionMessages.unexpectedExceptionMessage));
    }
  }

  Future<void> _signUpRequested(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        emit(AuthFailure(error: FailureMessages.noInternetFailureMessage));
        return;
      }
      final result = await signupUsecase(user: event.user);
      result.fold((failure) {
        emit(AuthFailure(error: failure.message));
      }, (unit) {
        emit(AuthSignUpSuccess());
      });
    } catch (e) {
      emit(AuthFailure(error: ExceptionMessages.unexpectedExceptionMessage));
    }
  }

  Future<void> _logoutRequested(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        emit(AuthFailure(error: FailureMessages.noInternetFailureMessage));
        return;
      }
      final result = await logoutUsecase();
      result.fold((failure) {
        emit(AuthFailure(error: failure.message));
      }, (unit) {
        emit(AuthLoggedOut());
      });
    } catch (e) {
      emit(AuthFailure(error: ExceptionMessages.unexpectedExceptionMessage));
    }
  }
}

