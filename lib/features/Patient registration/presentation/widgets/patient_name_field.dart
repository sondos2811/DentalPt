import 'package:flutter/material.dart';

class PatientNameField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;

  const PatientNameField({
    super.key,
    required this.controller,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: 'Patient Name',
        hintText: 'Enter full name',
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter patient name';
        }
        if (value.length < 3) {
          return 'Name must be at least 3 characters';
        }
        return null;
      },
    );
  }
}
