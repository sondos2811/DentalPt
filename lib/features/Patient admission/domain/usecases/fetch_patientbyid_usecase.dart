import 'package:dartz/dartz.dart';
import 'package:dental_pt/core/error/failures.dart';
import 'package:dental_pt/features/Patient%20admission/domain/repositories/patient_admission_repository.dart';
import 'package:dental_pt/features/Patient%20registration/domain/entities/patient.dart';

class FetchPatientbyidUsecase {
  final PatientAdmissionRepository patientAdmissionRepository;
  FetchPatientbyidUsecase({required this.patientAdmissionRepository});

  Future<Either<Failure, Patient>> call({required int id}) async {
    return await patientAdmissionRepository.fetchPatintById(id: id);
  }
}
