import 'package:dartz/dartz.dart';
import 'package:dental_pt/core/error/failures.dart';
import 'package:dental_pt/features/Patient%20registration/domain/entities/patient.dart';

abstract class PatientAdmissionRepository {
  Future<Either<Failure,List<Patient>>> fetchPatint({required String type , required String status});
  Future<Either<Failure, Unit>> changeStatus({required Patient patient, required String status});
  Future<Either<Failure, Unit>> deletePatient({required Patient patient});
  Future<Either<Failure,Patient>> fetchPatintById({required int id});
  Future<Either<Failure, List<Patient>>> getPatientsByDoctor(); 
}


