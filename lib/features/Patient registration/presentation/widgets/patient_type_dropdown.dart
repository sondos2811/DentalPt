import 'package:flutter/material.dart';

class PatientTypeDropdown extends StatelessWidget {
  final ValueNotifier<String> typeNotifier;
  final bool enabled;

  const PatientTypeDropdown({
    super.key,
    required this.typeNotifier,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    const types = ['General', 'Orthodontics', 'Periodontics', 'Pediatric'];

    return ValueListenableBuilder<String>(
      valueListenable: typeNotifier,
      builder: (context, selectedType, child) {
        return DropdownButtonFormField<String>(
          initialValue: selectedType,
          isExpanded: true,
          decoration: InputDecoration(
            labelText: 'Patient Type',
            hintText: 'Select patient type',
            prefixIcon: const Icon(Icons.category_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          items: types
              .map(
                (type) => DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                ),
              )
              .toList(),
          onChanged: !enabled
              ? (value) {
                  if (value != null) {
                    typeNotifier.value = value;
                  }
                }
              : null,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select patient type';
            }
            return null;
          },
        );
      },
    );
  }
}
