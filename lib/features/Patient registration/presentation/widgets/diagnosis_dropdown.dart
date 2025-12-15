import 'package:flutter/material.dart';

class DiagnosisDropdown extends StatelessWidget {
  final ValueNotifier<String> diagnosisNotifier;

  const DiagnosisDropdown({
    super.key,
    required this.diagnosisNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final items = [
      "Pediatric department",
      "Surgery department",
      "Periodontics department",
      "Conservative department",
      "Fixed prosthesis department",
      "Removal prosthesis department",
      "Endodontic department",
      "Orthodontic department",
    ];

    return ValueListenableBuilder<String>(
      valueListenable: diagnosisNotifier,
      builder: (context, value, child) {
        // Check if the current value exists in the items list
        final isValidValue = items.contains(value);

        return DropdownButtonFormField<String>(
          initialValue: isValidValue ? value : null,
          items: items.map((diagnosis) {
            return DropdownMenuItem(
              value: diagnosis,
              child: Text(diagnosis),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              diagnosisNotifier.value = newValue;
            }
          },
          decoration: InputDecoration(
            labelText: 'Diagnosis',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}
