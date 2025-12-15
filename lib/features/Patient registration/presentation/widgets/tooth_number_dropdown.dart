import 'package:flutter/material.dart';

class ToothNumberDropdown extends StatelessWidget {
  final ValueNotifier<String> toothNumberNotifier;

  const ToothNumberDropdown({
    super.key,
    required this.toothNumberNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: toothNumberNotifier,
      builder: (context, value, child) {
        return DropdownButtonFormField<String>(
          initialValue: value,
          items:
              List.generate(32, (index) => (index + 1).toString()).map((tooth) {
            return DropdownMenuItem(
              value: tooth,
              child: Text('Tooth $tooth'),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              toothNumberNotifier.value = newValue;
            }
          },
          decoration: InputDecoration(
            labelText: 'Tooth Number',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      },
    );
  }
}
