import 'dart:io';

import 'package:dental_pt/features/Patient%20registration/domain/repositories/patient_registration_repository.dart';

class UploadImageUsecase {
  final PatientRegistrationRepository patientRegistrationRepository;
  UploadImageUsecase({required this.patientRegistrationRepository});
  Future<void> call({required File imagePath}) {
    return patientRegistrationRepository.uploadImage(image: imagePath, fileName: imagePath.path.split('/').last);
  }
}
