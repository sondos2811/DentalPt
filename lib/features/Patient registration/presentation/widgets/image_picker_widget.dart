import 'dart:io';
import 'package:flutter/material.dart';

class ImagePickerWidget extends StatelessWidget {
  final String label;
  final File? image;
  final VoidCallback onPickImage;
  final bool enabled;

  const ImagePickerWidget({
    super.key,
    required this.label,
    required this.image,
    required this.onPickImage,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: enabled ? onPickImage : null,
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: enabled ? Colors.grey : Colors.grey.shade300,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade50,
            ),
            child: image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        size: 48,
                        color: enabled ? Colors.grey : Colors.grey.shade300,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Tap to select image',
                        style: TextStyle(
                          color: enabled ? Colors.grey : Colors.grey.shade400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
