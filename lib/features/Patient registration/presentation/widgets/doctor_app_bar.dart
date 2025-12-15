import 'package:flutter/material.dart';

class DoctorAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String doctorName;
  final VoidCallback? onProfileTap;

  const DoctorAppBar({
    super.key,
    required this.doctorName,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).primaryColor,
      foregroundColor: Colors.white,
      title: Text(
        'Welcome, $doctorName',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
