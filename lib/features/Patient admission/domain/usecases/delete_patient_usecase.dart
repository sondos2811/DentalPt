import 'package:dartz/dartz.dart';
import 'package:dental_pt/core/error/failures.dart';
import 'package:dental_pt/features/Patient%20admission/domain/repositories/patient_admission_repository.dart';
import 'package:dental_pt/features/Patient%20registration/domain/entities/patient.dart';

class DeletePatientUsecase {
  final PatientAdmissionRepository patientAdmissionRepository;
  DeletePatientUsecase({required this.patientAdmissionRepository});
  Future<Either<Failure, Unit>> call({required Patient patient}) {
    return patientAdmissionRepository.deletePatient(patient: patient);
  }
}
