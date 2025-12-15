part of 'patient_registration_bloc.dart';

abstract class PatientRegistrationEvent {
  const PatientRegistrationEvent();
}

final class RegisterPatientEvent extends PatientRegistrationEvent {
  final Patient patient;
  final File? nationalIdFaceImage;
  final File? nationalIdBackImage;

  RegisterPatientEvent({
    required this.patient,
    this.nationalIdFaceImage,
    this.nationalIdBackImage,
  });
}

final class PickImageEvent extends PatientRegistrationEvent {
  final String imageType; // 'face' or 'back'
  const PickImageEvent({required this.imageType});
}
