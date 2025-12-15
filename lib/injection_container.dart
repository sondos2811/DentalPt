import 'package:dental_pt/core/network/network_info.dart';
import 'package:dental_pt/core/network/network_info_impl.dart';
import 'package:dental_pt/features/Auth/data/datasources/auth_local_datasources.dart';
import 'package:dental_pt/features/Auth/data/datasources/auth_remote_datasources.dart';
import 'package:dental_pt/features/Auth/data/repositories/auth_repository_impl.dart';
import 'package:dental_pt/features/Auth/domain/repositories/auth_repository.dart';
import 'package:dental_pt/features/Auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:dental_pt/features/Auth/domain/usecases/login_usecase.dart';
import 'package:dental_pt/features/Auth/domain/usecases/logout_usecase.dart';
import 'package:dental_pt/features/Auth/domain/usecases/get_current_user_usecase.dart';
import 'package:dental_pt/features/Auth/domain/usecases/signup_usecase.dart';
import 'package:dental_pt/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_pt/features/Patient%20admission/data/datasources/patient_addmissin_remote_datasource.dart';
import 'package:dental_pt/features/Patient%20admission/data/repositories/patient_admission_repository_impl.dart';
import 'package:dental_pt/features/Patient%20admission/domain/repositories/patient_admission_repository.dart';
import 'package:dental_pt/features/Patient%20admission/domain/usecases/change_status_usecase.dart';
import 'package:dental_pt/features/Patient%20admission/domain/usecases/delete_patient_usecase.dart';
import 'package:dental_pt/features/Patient%20admission/domain/usecases/fetch_patientbyid_usecase.dart';
import 'package:dental_pt/features/Patient%20admission/domain/usecases/fetch_patint_usecase.dart';
import 'package:dental_pt/features/Patient%20admission/domain/usecases/get_patients_by_doctor_usecase.dart';
import 'package:dental_pt/features/Patient%20admission/presentation/bloc/patient_admission_bloc.dart';
import 'package:dental_pt/features/Patient%20registration/data/datasources/patient_registration_remote_data_source.dart';
import 'package:dental_pt/features/Patient%20registration/data/repositories/patient_registration_repository_impl.dart';
import 'package:dental_pt/features/Patient%20registration/domain/repositories/patient_registration_repository.dart';
import 'package:dental_pt/features/Patient%20registration/domain/usecases/register_patient_usecase.dart';
import 'package:dental_pt/features/Patient%20registration/domain/usecases/pick_image_usecase.dart';
import 'package:dental_pt/features/Patient%20registration/presentation/bloc/patient_registration_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies

  // Register Supabase client

  // Registering NetworkInfo (if used in your app)
  // Assuming you have a NetworkInfo class for network status checking.
  // Register NetworkInfo and Connectivity
  sl.registerLazySingleton<Connectivity>(() => Connectivity());
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectivity: sl()));
  sl.registerLazySingleton(() => Supabase.instance.client);
  sl.registerLazySingleton(() => SupabaseClient);
  sl.registerLazySingleton(() => ImagePicker());
  // Data sources

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDatasourcesImpl());

  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDatasourcesImpl());

  sl.registerLazySingleton<PatientRegistrationRemoteDataSource>(
      () => PatientRegistrationRemoteDataSourceImpl(
            picker: sl(),
          ));

  sl.registerLazySingleton<PatientAdmissionRemoteDatasource>(
      () => PatientAdmissionRemoteDatasourceImpl());

  // Repositories

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()));

  sl.registerLazySingleton<PatientRegistrationRepository>(
      () => PatientRegistrationRepositoryImpl(remoteDataSource: sl()));

  sl.registerLazySingleton<PatientAdmissionRepository>(
      () => PatientAdmissionRepositoryImpl(remoteDataSource: sl()));

// Use cases

  sl.registerLazySingleton<LoginUsecase>(
      () => LoginUsecase(authRepository: sl()));
  sl.registerLazySingleton<SignupUsecase>(
      () => SignupUsecase(authRepository: sl()));
  sl.registerLazySingleton<IsLoggedInUsecase>(
      () => IsLoggedInUsecase(authRepository: sl()));
  sl.registerLazySingleton<LogoutUsecase>(
      () => LogoutUsecase(authRepository: sl()));
  sl.registerLazySingleton<GetCurrentUserUsecase>(
      () => GetCurrentUserUsecase(authRepository: sl()));
  sl.registerLazySingleton<RegisterPatientUseCase>(() => RegisterPatientUseCase(
        patientRegistrationRepository: sl(),
      ));
  sl.registerLazySingleton<PickImageUseCase>(() => PickImageUseCase(
        patientRegistrationRepository: sl(),
      ));
  sl.registerLazySingleton<FetchPatintUsecase>(() => FetchPatintUsecase(
        patientAdmissionRepository: sl(),
      ));
  sl.registerLazySingleton<FetchPatientbyidUsecase>(
      () => FetchPatientbyidUsecase(
            patientAdmissionRepository: sl(),
          ));

  sl.registerLazySingleton<ChangeStatusUsecase>(() => ChangeStatusUsecase(
        patientAdmissionRepository: sl(),
      ));

  sl.registerLazySingleton<DeletePatientUsecase>(() => DeletePatientUsecase(
        patientAdmissionRepository: sl(),
      ));

  sl.registerLazySingleton<GetPatientsByDoctorUsecase>(
      () => GetPatientsByDoctorUsecase(
            patientAdmissionRepository: sl(),
          ));

  // BLoC

  sl.registerFactory(() => AuthBloc(
        loginUsecase: sl(),
        signupUsecase: sl(),
        isLoggedInUsecase: sl(),
        getCurrentUserUsecase: sl(),
        logoutUsecase: sl(),
        networkInfo: sl(),
      ));

  sl.registerFactory(() => PatientRegistrationBloc(
        networkInfo: sl(),
        registerPatientUseCase: sl(),
        pickImageUseCase: sl(),
      ));

  sl.registerFactory(() => PatientAdmissionBloc(
        networkInfo: sl(),
        fetchPatintUsecase: sl(),
        changeStatusUsecase: sl(),
        fetchPatientbyidUsecase: sl(),
        deletePatientUsecase: sl(),
        getPatientsByDoctorUsecase: sl(),
      ));
}
