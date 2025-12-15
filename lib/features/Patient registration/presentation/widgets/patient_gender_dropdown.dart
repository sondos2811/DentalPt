import 'package:flutter/material.dart';

class PatientGenderDropdown extends StatelessWidget {
  final ValueNotifier<String> genderNotifier;
  final bool enabled;

  const PatientGenderDropdown({
    super.key,
    required this.genderNotifier,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    const genders = ['Male', 'Female'];

    return ValueListenableBuilder<String>(
      valueListenable: genderNotifier,
      builder: (context, selectedGender, child) {
        return DropdownButtonFormField<String>(
          initialValue: selectedGender,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: 'Gender',
            hintText: 'Select gender',
            prefixIcon: const Icon(Icons.person_outline),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          items: genders
              .map(
                (gender) => DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                ),
              )
              .toList(),
          onChanged: !enabled
              ? (value) {
                  if (value != null) {
                    genderNotifier.value = value;
                  }
                }
              : null,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select gender';
            }
            return null;
          },
        );
      },
    );
  }
}
