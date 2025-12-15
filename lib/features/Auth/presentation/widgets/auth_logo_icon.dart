import 'package:flutter/material.dart';

class AuthLogoIcon extends StatelessWidget {
  final double size;
  final IconData icon;

  const AuthLogoIcon({
    super.key,
    this.size = 80,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: Theme.of(context).primaryColor,
    );
  }
}
