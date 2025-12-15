import 'package:dartz/dartz.dart';
import 'package:dental_pt/core/error/failures.dart';
import 'package:dental_pt/features/Patient%20admission/domain/repositories/patient_admission_repository.dart';

class ChangeStatusUsecase {
  final PatientAdmissionRepository patientAdmissionRepository;
  ChangeStatusUsecase({required this.patientAdmissionRepository});

  Future<Either<Failure, Unit>> call({required patient, required String status}) {
    return patientAdmissionRepository.changeStatus(patient: patient, status: status);
  }
}
