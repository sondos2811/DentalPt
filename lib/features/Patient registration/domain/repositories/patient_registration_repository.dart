import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dental_pt/core/error/failures.dart';
import 'package:dental_pt/features/Patient%20registration/domain/entities/patient.dart';

abstract class PatientRegistrationRepository {
  Future<Either<Failure, int>> registerPatient({
    required Patient patient,
    File? nationalIdFaceImage,
    File? nationalIdBackImage,
  });
  Future<File?> pickImage();
  Future<String?> uploadImage({required File image, required String fileName});
}

