part of 'patient_admission_bloc.dart';

abstract class PatientAdmissionState {
  const PatientAdmissionState();
}

final class PatientAdmissionInitial extends PatientAdmissionState {}

final class PatientAdmissionLoading extends PatientAdmissionState {}

final class PatientDataLoaded extends PatientAdmissionState {
  final List<Patient> patientData;

  const PatientDataLoaded({required this.patientData});
}

final class PatientAdmissionFailure extends PatientAdmissionState {
  final String error;
  const PatientAdmissionFailure({required this.error});
}

final class PatientAdmissionDeleted extends PatientAdmissionState {}

final class PatientAdmissionUpdated extends PatientAdmissionState {}

final class SinglePatientDataLoaded extends PatientAdmissionState {
  final Patient patientData;

  const SinglePatientDataLoaded({required this.patientData});
}

final class AllPatientsDataLoaded extends PatientAdmissionState {
  final List<Patient> patientData;

  const AllPatientsDataLoaded({required this.patientData});
}

final class PatientsByDoctorLoaded extends PatientAdmissionState {
  final List<Patient> patients;

  const PatientsByDoctorLoaded({required this.patients});
}
