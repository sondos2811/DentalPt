import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dental_pt/core/error/failures.dart';
import 'package:dental_pt/features/Patient%20registration/domain/entities/patient.dart';
import 'package:dental_pt/features/Patient%20registration/domain/repositories/patient_registration_repository.dart';

class RegisterPatientUseCase {
  final PatientRegistrationRepository patientRegistrationRepository;
  RegisterPatientUseCase({required this.patientRegistrationRepository});
  Future<Either<Failure, int>> call({
    required Patient patient,
    File? nationalIdFaceImage,
    File? nationalIdBackImage,
  }) async {
    return await patientRegistrationRepository.registerPatient(
      patient: patient,
      nationalIdFaceImage: nationalIdFaceImage,
      nationalIdBackImage: nationalIdBackImage,
    );
  }
}

