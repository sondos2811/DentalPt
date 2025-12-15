import 'package:flutter/material.dart';

class PatientPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;

  const PatientPhoneField({
    super.key,
    required this.controller,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        hintText: 'Enter phone number',
        prefixIcon: const Icon(Icons.phone_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter phone number';
        }
        if (value.length < 10) {
          return 'Please enter a valid phone number';
        }
        return null;
      },
    );
  }
}
