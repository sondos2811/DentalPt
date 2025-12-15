// ignore_for_file: unused_element

import 'package:bloc/bloc.dart';
import 'package:dental_pt/core/network/network_info.dart';
import 'package:dental_pt/core/strings/failure_and_exception.dart';
import 'package:dental_pt/features/Patient%20admission/domain/usecases/change_status_usecase.dart';
import 'package:dental_pt/features/Patient%20admission/domain/usecases/delete_patient_usecase.dart';
import 'package:dental_pt/features/Patient%20admission/domain/usecases/fetch_patientbyid_usecase.dart';
import 'package:dental_pt/features/Patient%20admission/domain/usecases/fetch_patint_usecase.dart';
import 'package:dental_pt/features/Patient%20admission/domain/usecases/get_patients_by_doctor_usecase.dart';
import 'package:dental_pt/features/Patient%20registration/domain/entities/patient.dart';

part 'patient_admission_event.dart';
part 'patient_admission_state.dart';

class PatientAdmissionBloc
    extends Bloc<PatientAdmissionEvent, PatientAdmissionState> {
  final NetworkInfo networkInfo;
  final FetchPatintUsecase fetchPatintUsecase;
  final ChangeStatusUsecase changeStatusUsecase;
  final FetchPatientbyidUsecase fetchPatientbyidUsecase;
  final DeletePatientUsecase deletePatientUsecase;
  final GetPatientsByDoctorUsecase getPatientsByDoctorUsecase;
  PatientAdmissionBloc(
      {required this.networkInfo,
      required this.fetchPatintUsecase,
      required this.changeStatusUsecase,
      required this.fetchPatientbyidUsecase,
      required this.deletePatientUsecase,
      required this.getPatientsByDoctorUsecase})
      : super(PatientAdmissionInitial()) {
    on<GetPatiantDataEvent>(_fetchPatint);
    on<GetPatiantDataByIdEvent>(_fetchPatintById);
    on<PatientIsReservedEvent>(_patientIsReserved);
    on<PatientIsNotReservedEvent>(_patientIsNotReserved);
    on<DeletePatientEvent>(_deletePatient);
    on<GetPatientsByDoctorEvent>(_getPatientsByDoctor);
    on<GetAllPatientsEvent>(_getAllPatients);
    on<ClearPatientDataEvent>(_clearPatientData);
  }

  Future<void> _fetchPatint(
      GetPatiantDataEvent event, Emitter<PatientAdmissionState> emit) async {
    emit(PatientAdmissionLoading());
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        emit(const PatientAdmissionFailure(
            error: FailureMessages.noInternetFailureMessage));
        return;
      }
      final result = await fetchPatintUsecase(
        status: event.status,
        type: event.type,
      );
      result.fold(
        (failure) {
          emit(PatientAdmissionFailure(error: failure.message));
        },
        (patientData) {
          emit(PatientDataLoaded(patientData: patientData));
        },
      );
    } catch (e) {
      emit(const PatientAdmissionFailure(
          error: FailureMessages.unexpectedFailureMessage));
    }
  }

  Future<void> _fetchPatintById(GetPatiantDataByIdEvent event,
      Emitter<PatientAdmissionState> emit) async {
    emit(PatientAdmissionLoading());
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        emit(const PatientAdmissionFailure(
            error: FailureMessages.noInternetFailureMessage));
        return;
      }
      final result = await fetchPatientbyidUsecase(id: event.id);
      result.fold(
        (failure) {
          emit(PatientAdmissionFailure(error: failure.message));
        },
        (patientData) {
          emit(SinglePatientDataLoaded(patientData: patientData));
        },
      );
    } catch (e) {
      emit(const PatientAdmissionFailure(
          error: FailureMessages.unexpectedFailureMessage));
    }
  }

  Future<void> _patientIsReserved(
      PatientIsReservedEvent event, Emitter<PatientAdmissionState> emit) async {
    emit(PatientAdmissionLoading());
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        emit(const PatientAdmissionFailure(
            error: FailureMessages.noInternetFailureMessage));
        return;
      }
      final result = await changeStatusUsecase(
        patient: event.patient,
        status: event.status,
      );
      result.fold(
        (failure) {
          emit(PatientAdmissionFailure(error: failure.message));
        },
        (updated) {
          emit(PatientAdmissionUpdated());
        },
      );
    } catch (e) {
      emit(const PatientAdmissionFailure(
          error: FailureMessages.unexpectedFailureMessage));
    }
  }

  Future<void> _patientIsNotReserved(PatientIsNotReservedEvent event,
      Emitter<PatientAdmissionState> emit) async {
    emit(PatientAdmissionLoading());
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        emit(const PatientAdmissionFailure(
            error: FailureMessages.noInternetFailureMessage));
        return;
      }
      final result = await changeStatusUsecase(
        patient: event.patient,
        status: event.status,
      );
      result.fold(
        (failure) {
          emit(PatientAdmissionFailure(error: failure.message));
        },
        (updated) {
          emit(PatientAdmissionUpdated());
        },
      );
    } catch (e) {
      emit(const PatientAdmissionFailure(
          error: FailureMessages.unexpectedFailureMessage));
    }
  }

  Future<void> _deletePatient(
      DeletePatientEvent event, Emitter<PatientAdmissionState> emit) async {
    emit(PatientAdmissionLoading());
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        emit(const PatientAdmissionFailure(
            error: FailureMessages.noInternetFailureMessage));
        return;
      }
      final result = await deletePatientUsecase(patient: event.patient);
      result.fold(
        (failure) {
          emit(PatientAdmissionFailure(error: failure.message));
        },
        (deleted) {
          emit(PatientAdmissionDeleted());
        },
      );
    } catch (e) {
      emit(const PatientAdmissionFailure(
          error: FailureMessages.unexpectedFailureMessage));
    }
  }

  Future<void> _getPatientsByDoctor(GetPatientsByDoctorEvent event,
      Emitter<PatientAdmissionState> emit) async {
    emit(PatientAdmissionLoading());
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        emit(const PatientAdmissionFailure(
            error: FailureMessages.noInternetFailureMessage));
        return;
      }
      final result = await getPatientsByDoctorUsecase();
      result.fold(
        (failure) {
          emit(PatientAdmissionFailure(error: failure.message));
        },
        (patients) {
          emit(PatientsByDoctorLoaded(patients: patients));
        },
      );
    } catch (e) {
      emit(const PatientAdmissionFailure(
          error: FailureMessages.unexpectedFailureMessage));
    }
  }

  Future<void> _getAllPatients(
      GetAllPatientsEvent event, Emitter<PatientAdmissionState> emit) async {
    emit(PatientAdmissionLoading());
    try {
      final isConnected = await networkInfo.isConnected;
      if (!isConnected) {
        emit(const PatientAdmissionFailure(
            error: FailureMessages.noInternetFailureMessage));
        return;
      }
      final result = await getPatientsByDoctorUsecase();
      result.fold(
        (failure) {
          emit(PatientAdmissionFailure(error: failure.message));
        },
        (patients) {
          emit(AllPatientsDataLoaded(patientData: patients));
        },
      );
    } catch (e) {
      emit(const PatientAdmissionFailure(
          error: FailureMessages.unexpectedFailureMessage));
    }
  }

  Future<void> _clearPatientData(
      ClearPatientDataEvent event, Emitter<PatientAdmissionState> emit) async {
    emit(PatientAdmissionInitial());
  }
}

