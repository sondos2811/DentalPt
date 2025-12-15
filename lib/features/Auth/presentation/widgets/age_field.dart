import 'package:flutter/material.dart';

class AgeField extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;

  const AgeField({
    super.key,
    required this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: 'Age',
        hintText: 'Enter your age',
        prefixIcon: const Icon(Icons.cake_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your age';
        }
        final age = int.tryParse(value);
        if (age == null || age < 18 || age > 120) {
          return 'Please enter a valid age (18-120)';
        }
        return null;
      },
    );
  }
}
