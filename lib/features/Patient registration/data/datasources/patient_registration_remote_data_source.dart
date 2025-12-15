// ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dental_pt/features/Patient%20registration/data/models/patient_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class PatientRegistrationRemoteDataSource {
  Future<int> registerPatient({
    required PatientModel patientModel,
    File? nationalIdFaceImage,
    File? nationalIdBackImage,
  });
  Future<File?> pickImage();
  Future<String?> uploadImage({required File image, required String fileName});
}

class PatientRegistrationRemoteDataSourceImpl
    implements PatientRegistrationRemoteDataSource {
  final supabase = Supabase.instance.client;

  final ImagePicker picker;

  PatientRegistrationRemoteDataSourceImpl({required this.picker});

  @override
  Future<int> registerPatient({
    required PatientModel patientModel,
    File? nationalIdFaceImage,
    File? nationalIdBackImage,
  }) async {
    try {
      // Upload images if provided and get URLs
      String? faceImageUrl;
      String? backImageUrl;

      if (nationalIdFaceImage != null) {
        faceImageUrl = await uploadImage(
          image: nationalIdFaceImage,
          fileName: 'face_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
      }

      if (nationalIdBackImage != null) {
        backImageUrl = await uploadImage(
          image: nationalIdBackImage,
          fileName: 'back_${DateTime.now().millisecondsSinceEpoch}.jpg',
        );
      }

      // Prepare patient data
      var jsonData = patientModel.toJson();
      jsonData
        ..remove('id') // Ensure id is never sent (let Supabase auto-generate)
        ..remove(
            'diagnoses'); // Ensure diagnoses is not sent to the patients table

      // Add image URLs to patient data
      if (faceImageUrl != null) {
        jsonData['national_id_face_url'] = faceImageUrl;
      }
      if (backImageUrl != null) {
        jsonData['national_id_back_url'] = backImageUrl;
      }

      // Insert patient and retrieve the generated ID
      final response = await supabase
          .from("patients")
          .insert(jsonData)
          .select("id")
          .single();
      final patientId = response["id"];

      // Insert diagnoses associated with the patient
      final diagnosesData = patientModel.diagnoses
          .map((diagnosis) => {
                "patient_id": patientId,
                "name": diagnosis.name,
                "description": diagnosis.description,
                "no_of_tooth": diagnosis.noOfTooth,
              })
          .toList();

      await supabase.from("diagnosis").insert(diagnosesData);

      return patientId as int;
    } on PostgrestException catch (e) {
      throw Exception('Database Error: ${e.message}');
    } catch (e) {
      throw Exception('Registration Error: ${e.toString()}');
    }
  }

  @override
  Future<File?> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  @override
  Future<String> uploadImage({
    required File image,
    required String fileName,
  }) async {
    try {
      final path = 'national_ids/$fileName';

      await supabase.storage.from('images').upload(
            path,
            image,
            fileOptions: const FileOptions(upsert: false),
          );

      return supabase.storage.from('images').getPublicUrl(path);
    } catch (e) {
      throw Exception('Image Upload Error: $e');
    }
  }
}

