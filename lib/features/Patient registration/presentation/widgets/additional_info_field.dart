import 'package:flutter/material.dart';

class AdditionalInfoField extends StatelessWidget {
  final TextEditingController controller;

  const AdditionalInfoField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Additional Info',
        hintText: 'Enter additional information',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter additional information';
        }
        return null;
      },
    );
  }
}
