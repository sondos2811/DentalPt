import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String label;

  const SignUpButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.label = 'Create New Account',
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
