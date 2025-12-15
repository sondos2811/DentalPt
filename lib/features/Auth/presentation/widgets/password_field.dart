import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool enabled;

  const PasswordField({
    super.key,
    required this.controller,
    this.label = 'Password',
    this.enabled = true,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscurePassword,
      enabled: widget.enabled,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: 'Enter your ${widget.label.toLowerCase()}',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your ${widget.label.toLowerCase()}';
        }
        if (value.length < 6) {
          return '${widget.label} must be at least 6 characters';
        }
        return null;
      },
    );
  }
}
