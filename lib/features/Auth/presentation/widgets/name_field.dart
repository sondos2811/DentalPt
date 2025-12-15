import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;

  const NameField({
    super.key,
    required this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: 'Full Name',
        hintText: 'Enter your full name',
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your full name';
        }
        if (value.length < 3) {
          return 'Name must be at least 3 characters';
        }
        return null;
      },
    );
  }
}
