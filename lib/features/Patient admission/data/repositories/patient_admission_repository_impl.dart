import 'package:dartz/dartz.dart';
import 'package:dental_pt/core/error/failures.dart';
import 'package:dental_pt/features/Patient%20admission/data/datasources/patient_addmissin_remote_datasource.dart';
import 'package:dental_pt/features/Patient%20admission/domain/repositories/patient_admission_repository.dart';
import 'package:dental_pt/features/Patient%20registration/domain/entities/patient.dart';

class PatientAdmissionRepositoryImpl implements PatientAdmissionRepository {
  final PatientAdmissionRemoteDatasource remoteDataSource;

  PatientAdmissionRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, Unit>> changeStatus(
      {required Patient patient, required String status}) async {
    try {
      await remoteDataSource.changeStatus(
          patient: patient.toModel(), status: status);
      return const Right(unit);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePatient(
      {required Patient patient}) async {
    try {
      await remoteDataSource.deletePatient(patient: patient.toModel());
      return const Right(unit);
    } catch (e) {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Patient>>> fetchPatint(
      {required String type, required String status}) async {
    try {
      final patientsModel =
          await remoteDataSource.fetchPatient(type: type, status: status);
      return Right(patientsModel
          .map((patientModel) => patientModel.toEntity())
          .toList());
    } catch (e) {
      return const Left(ServerFailure());
    }
  }
  
  @override
  Future<Either<Failure, Patient>> fetchPatintById({required int id}) async {
    try{
      final patientModel = await remoteDataSource.fetchPatientById(id: id);
      return Right(patientModel.toEntity());
    } catch (e) {
      return const Left(ServerFailure());
    }
  }
  
  @override
  
  @override
  Future<Either<Failure, List<Patient>>> getPatientsByDoctor() async {
    try {
      final patientsModel = await remoteDataSource.getPatientsByDoctor();
      return Right(patientsModel
          .map((patientModel) => patientModel.toEntity())
          .toList());
    } catch (e) {
      return const Left(ServerFailure());
    }
  }
}

