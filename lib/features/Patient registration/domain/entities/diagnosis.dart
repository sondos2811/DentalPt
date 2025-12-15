import 'package:dental_pt/features/Patient%20registration/data/models/diagnosis_model.dart';

class Diagnosis {
  final int id;
  final String name;
  final String description;
  final String noOfTooth; 
  Diagnosis({
    required this.id,
    required this.name,
    required this.description,
    required this.noOfTooth,
  });
  DiagnosisModel toModel() {
    return DiagnosisModel.fromEntity(this);
  }
}
