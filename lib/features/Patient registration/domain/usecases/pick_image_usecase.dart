import 'dart:io';

import 'package:dental_pt/features/Patient%20registration/domain/repositories/patient_registration_repository.dart';

class PickImageUseCase {
  final PatientRegistrationRepository patientRegistrationRepository;
  PickImageUseCase({required this.patientRegistrationRepository});
  Future<File?> call() {
    return patientRegistrationRepository.pickImage();
  }
}

