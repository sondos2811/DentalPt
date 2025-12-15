import 'package:flutter/material.dart';

class RoleDropdown extends StatefulWidget {
  final Function(String) onRoleChanged;
  final bool enabled;

  const RoleDropdown({
    super.key,
    required this.onRoleChanged,
    this.enabled = true,
  });

  @override
  State<RoleDropdown> createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  String _selectedRole = 'Dentist';
  final List<String> _roles = ['Student', 'Dentist',];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: _selectedRole,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: 'Role',
        hintText: 'Select your role',
        prefixIcon: const Icon(Icons.badge_outlined),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      items: _roles
          .map(
            (role) => DropdownMenuItem<String>(
              value: role,
              child: Text(role),
            ),
          )
          .toList(),
      onChanged: widget.enabled
          ? (value) {
              if (value != null) {
                setState(() {
                  _selectedRole = value;
                });
                widget.onRoleChanged(value);
              }
            }
          : null,
      disabledHint: Text(_selectedRole),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a role';
        }
        return null;
      },
    );
  }
}
