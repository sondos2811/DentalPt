// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:dental_pt/features/Patient%20registration/data/models/patient_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PatientAdmissionRemoteDatasource {
  Future<List<PatientModel>> fetchPatient(
      {required String type, required String status});
  Future<Unit> changeStatus(
      {required PatientModel patient, required String status});
  Future<Unit> deletePatient({required PatientModel patient});

  Future<PatientModel> fetchPatientById({required int id});

  Future<List<PatientModel>> getPatientsByDoctor();
}

class PatientAdmissionRemoteDatasourceImpl
    implements PatientAdmissionRemoteDatasource {
  final supabase = Supabase.instance.client;
  final currentUser = Supabase.instance.client.auth.currentUser;

  @override
  Future<Unit> changeStatus(
      {required PatientModel patient, required String status}) async {
    try {
      await supabase
          .from("patients")
          .update({'status': status}).eq('id', patient.id);
      if (status == 'yes' || status == 'finished') {
        await supabase.from('patients').update({
          'doctor_id': currentUser!.id,
        }).eq("id", patient.id);
      }
      return Future.value(unit);
    } catch (e) {
      print('Error in changing status: $e');
      return Future.value(unit);
    }
  }

  @override
  Future<Unit> deletePatient({required PatientModel patient}) async {
    try {
      await supabase.from("patients").delete().eq('id', patient.id);
      return Future.value(unit);
    } catch (e) {
      print('Error in deleting patient: $e');
      return Future.value(unit);
    }
  }

  @override
  Future<List<PatientModel>> fetchPatient(
      {required String type, required String status}) async {
    try {
      final response = await supabase
          .from("diagnosis")
          .select("patient_id")
          .eq("name", type) as List<dynamic>;
      final patientIds =
          response.map((data) => data['patient_id'] as int).toList();
      
      print('Found ${patientIds.length} patient IDs for $type');
      
      final patients = <PatientModel>[];
      
      for (int id in patientIds) {
        try {
          // Fetch patient data
          final patientResponse = await supabase
              .from("patients")
              .select()
              .eq("id", id)
              .single();

          print('Patient $id status: ${patientResponse['status']}, looking for: $status');

          // Filter by status
          if (patientResponse['status'] == status) {
            // Fetch diagnoses for this patient
            final diagnosesResponse = await supabase
                .from("diagnosis")
                .select()
                .eq("patient_id", id) as List<dynamic>;

            // Combine patient data with diagnoses
            patientResponse['diagnoses'] = diagnosesResponse;

            patients.add(PatientModel.fromJson(patientResponse));
            print('Added patient $id to results');
          }
        } catch (e) {
          print('Error fetching patient $id for diagnosis $type: $e');
        }
      }
      
      print('Returning ${patients.length} patients for $type');
      return patients;
    } catch (e) {
      print('Error in fetching patient: $e');
      return [];
    }
  }

  @override
  Future<PatientModel> fetchPatientById({required int id}) async {
    try {
      // Fetch patient data
      final patientResponse =
          await supabase.from('patients').select().eq('id', id).single();

      // Fetch diagnoses for this patient
      final diagnosesResponse = await supabase
          .from('diagnosis')
          .select()
          .eq('patient_id', id) as List<dynamic>;

      // Combine patient data with diagnoses
      patientResponse['diagnoses'] = diagnosesResponse;

      final patient = PatientModel.fromJson(patientResponse);

      return patient;
    } catch (e) {
      print('Error in fetching patient by id: $e');
      rethrow;
    }
  }
  
  @override
  Future<List<PatientModel>> getPatientsByDoctor() async {
    try {
      final response = await supabase
          .from('patients')
          .select()
          .eq('doctor_id', currentUser!.id) as List<dynamic>;

      final patients = await Future.wait(response.map((patientData) async {
        final patientId = patientData['id'] as int;

        // Fetch diagnoses for this patient
        final diagnosesResponse = await supabase
            .from('diagnosis')
            .select()
            .eq('patient_id', patientId) as List<dynamic>;

        // Combine patient data with diagnoses
        patientData['diagnoses'] = diagnosesResponse;

        return PatientModel.fromJson(patientData);
      }));

      return patients;
    } catch (e) {
      print('Error in fetching patients by doctor: $e');
      return [];
    }
  }
}

