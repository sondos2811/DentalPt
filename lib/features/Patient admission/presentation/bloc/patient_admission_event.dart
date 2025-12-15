part of 'patient_admission_bloc.dart';

abstract class PatientAdmissionEvent {
  const PatientAdmissionEvent();
}

class GetPatiantDataEvent extends PatientAdmissionEvent {
  final String type;
  final String status;
  const GetPatiantDataEvent({required this.type, required this.status});
}

class GetPatiantDataByIdEvent extends PatientAdmissionEvent {
  final int id;
  const GetPatiantDataByIdEvent({required this.id});
}

class PatientIsReservedEvent extends PatientAdmissionEvent {
  final Patient patient;
  final String status;
  const PatientIsReservedEvent({required this.patient, required this.status});
}

class DeletePatientEvent extends PatientAdmissionEvent {
  final Patient patient;
  const DeletePatientEvent({required this.patient});
}

class PatientIsNotReservedEvent extends PatientAdmissionEvent {
  final Patient patient;
  final String status;
  const PatientIsNotReservedEvent(
      {required this.patient, required this.status});
}

class GetPatientsByDoctorEvent extends PatientAdmissionEvent {
  const GetPatientsByDoctorEvent();
}

class GetAllPatientsEvent extends PatientAdmissionEvent {
  const GetAllPatientsEvent();
}

class ClearPatientDataEvent extends PatientAdmissionEvent {
  const ClearPatientDataEvent();
}
