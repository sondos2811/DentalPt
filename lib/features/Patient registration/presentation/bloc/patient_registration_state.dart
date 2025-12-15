part of 'patient_registration_bloc.dart';

abstract class PatientRegistrationState {}

final class PatientRegistrationInitial extends PatientRegistrationState {}

final class PatientRegistrationLoading extends PatientRegistrationState {}

final class PatientRegistrationSuccess extends PatientRegistrationState {
  final int patientId;

  PatientRegistrationSuccess({required this.patientId});
}

final class PatientRegistrationFailure extends PatientRegistrationState {
  final String error;

  PatientRegistrationFailure({required this.error});
}

final class ImagePickedSuccess extends PatientRegistrationState {
  final File image;
  final String imageType; // 'face' or 'back'

  ImagePickedSuccess({required this.image, required this.imageType});
}

final class ImageUploadLoading extends PatientRegistrationState {}

final class NationalIdImagesUploadSuccess extends PatientRegistrationState {
  final Patient patient;

  NationalIdImagesUploadSuccess({required this.patient});
}

final class NationalIdImagesUploadFailure extends PatientRegistrationState {
  final String error;

  NationalIdImagesUploadFailure({required this.error});
}
