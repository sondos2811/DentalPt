import 'package:dental_pt/features/Patient%20registration/domain/entities/diagnosis.dart';

class DiagnosisModel {
  final int id;
  final String name;
  final String description;
  final String noOfTooth; 
  DiagnosisModel({
    required this.id,
    required this.name,
    required this.description,
    required this.noOfTooth,
  });
  factory DiagnosisModel.fromEntity(Diagnosis diagnosis) {
    return DiagnosisModel(
      id: diagnosis.id,
      name: diagnosis.name,
      description: diagnosis.description,
      noOfTooth: diagnosis.noOfTooth,
    );
  }


  Diagnosis toEntity() {
    return Diagnosis(
      id: id,
      name: name,
      description: description,
      noOfTooth: noOfTooth,
    );
  }


  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      noOfTooth: json['no_of_tooth'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'no_of_tooth': noOfTooth,
    };
  }
}
