import 'package:dental_pt/features/Patient%20registration/data/models/diagnosis_model.dart';
import 'package:dental_pt/features/Patient%20registration/domain/entities/patient.dart';

class PatientModel {
  final int id;
  final String name;
  final int age;
  final int phone;
  final String gander;
  final String status;
  final List<DiagnosisModel> diagnoses;
  final String? nationalIdFaceUrl;
  final String? nationalIdBackUrl;

  PatientModel({
    required this.id,
    required this.name,
    required this.age,
    required this.phone,
    required this.gander,
    this.status = 'no',
    this.nationalIdFaceUrl,
    this.nationalIdBackUrl,
    required this.diagnoses,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      phone: json['phone'],
      gander: json['gander'],
      status: json['status'] ?? 'no',
      diagnoses: (json['diagnoses'] as List?)
              ?.map((e) => DiagnosisModel.fromJson(e))
              .toList() ??
          [],
      nationalIdFaceUrl: json['national_id_face_url'],
      nationalIdBackUrl: json['national_id_back_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'phone': phone,
      'gander': gander,
      'status': status,
      'diagnoses': diagnoses.map((e) => e.toJson()).toList(),
      'national_id_face_url': nationalIdFaceUrl,
      'national_id_back_url': nationalIdBackUrl,
    };
  }

  factory PatientModel.fromEntity(Patient patient) {
    return PatientModel(
      id: patient.id,
      name: patient.name,
      age: patient.age,
      phone: patient.phone,
      gander: patient.gander,
      status: patient.status,
      nationalIdFaceUrl: patient.nationalIdFaceUrl,
      nationalIdBackUrl: patient.nationalIdBackUrl,
      diagnoses: patient.diagnoses.map((e) => e.toModel()).toList(),
    );
  }

  Patient toEntity() {
    return Patient(
      id: id,
      name: name,
      age: age,
      phone: phone,
      gander: gander,
      status: status,
      nationalIdFaceUrl: nationalIdFaceUrl,
      nationalIdBackUrl: nationalIdBackUrl,
      diagnoses: diagnoses.map((e) => e.toEntity()).toList(),
    );
  }
}

