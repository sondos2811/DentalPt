import 'package:dartz/dartz.dart';
import 'package:dental_pt/core/error/failures.dart';
import 'package:dental_pt/features/Patient%20admission/domain/repositories/patient_admission_repository.dart';
import 'package:dental_pt/features/Patient%20registration/domain/entities/patient.dart';

class FetchPatintUsecase {
  final PatientAdmissionRepository patientAdmissionRepository;
  FetchPatintUsecase({required this.patientAdmissionRepository});
  Future<Either<Failure, List<Patient>>> call({required String type, required String status}) {
    return patientAdmissionRepository.fetchPatint(type: type, status: status);
  }
}
