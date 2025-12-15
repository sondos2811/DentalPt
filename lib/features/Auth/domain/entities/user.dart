import 'package:dental_pt/features/Auth/data/models/user_model.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final String role;
  final int phone;
  final int age;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.phone,
    required this.age,
  });

UserModel toModel() {
    return UserModel.fromEntity(this);
  }

}

