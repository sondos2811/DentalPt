import 'package:flutter/material.dart';

class ForgotPasswordButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const ForgotPasswordButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: isLoading ? null : onPressed,
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
