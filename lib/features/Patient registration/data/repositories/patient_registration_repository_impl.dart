// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dental_pt/core/error/failures.dart';
import 'package:dental_pt/features/Patient%20registration/data/datasources/patient_registration_remote_data_source.dart';
import 'package:dental_pt/features/Patient%20registration/domain/entities/patient.dart';
import 'package:dental_pt/features/Patient%20registration/domain/repositories/patient_registration_repository.dart';

class PatientRegistrationRepositoryImpl
    implements PatientRegistrationRepository {
  final PatientRegistrationRemoteDataSource remoteDataSource;

  PatientRegistrationRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, int>> registerPatient({
    required Patient patient,
    File? nationalIdFaceImage,
    File? nationalIdBackImage,
  }) async {
    try {
      final patientId = await remoteDataSource.registerPatient(
        patientModel: patient.toModel(),
        nationalIdFaceImage: nationalIdFaceImage,
        nationalIdBackImage: nationalIdBackImage,
      );
      return Right(patientId);
    } catch (e) {
      print("Error in remote data source in 'register patient': $e");
      return const Left(ServerFailure());
    }
  }

  @override
  Future<File?> pickImage() {
    return remoteDataSource.pickImage();
  }

  @override
  Future<String?> uploadImage({required File image, required String fileName}) {
    return remoteDataSource.uploadImage(image: image, fileName: fileName);
  }
}

