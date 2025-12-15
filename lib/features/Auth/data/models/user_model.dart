import 'package:dental_pt/features/Auth/domain/entities/user.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String password;
  final String role;
  final int phone;
  final int age;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.phone,
    required this.age,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      phone: json['phone'],
      age: json['age'],
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      name: user.name,
      email: user.email,
      password: user.password,
      role: user.role,
      phone: user.phone,
      age: user.age,
    );
  }

  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      password: password,
      role: role,
      phone: phone,
      age: age,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'age': age,
      'password': password,
    };
  }
}

