import 'package:dental_pt/features/Patient%20registration/data/models/patient_model.dart';
import 'package:dental_pt/features/Patient%20registration/domain/entities/diagnosis.dart';

class Patient {
  final int id;
  final String name;
  final String gander;
  final int age;
  final int phone;
  final String status; //recived or not
  final List<Diagnosis> diagnoses;
  final String? nationalIdFaceUrl;
  final String? nationalIdBackUrl;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.phone,
    required this.gander,
    this.status = 'no',
    this.nationalIdFaceUrl,
    required this.diagnoses,
    this.nationalIdBackUrl,
  });

  PatientModel toModel() {
    return PatientModel.fromEntity(this);
  }
}

