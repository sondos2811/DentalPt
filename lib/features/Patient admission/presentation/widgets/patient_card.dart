import 'package:flutter/material.dart';
import 'package:dental_pt/features/Patient%20registration/domain/entities/patient.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  final VoidCallback onTap;

  const PatientCard({
    super.key,
    required this.patient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shadowColor: const Color(0xFF065091).withOpacity(0.3),
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white,
                Colors.grey.shade50,
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF065091).withOpacity(0.15),
                      const Color(0xFFee7733).withOpacity(0.15),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Text(
                    patient.name.isNotEmpty ? patient.name[0].toUpperCase() : 'P',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF065091),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF065091),
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.cake,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${patient.age} years',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.wc,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          patient.gander,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(
                          Icons.phone,
                          size: 14,
                          color: Color(0xFFee7733),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${patient.phone}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFFee7733),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: patient.status == 'yes'
                            ? [
                                const Color(0xFFee7733),
                                const Color(0xFFee7733).withOpacity(0.8),
                              ]
                            : [
                                Colors.green.shade400,
                                Colors.green.shade600,
                              ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      patient.status == 'yes' ? 'Reserved' : 'Available',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF065091).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Color(0xFF065091),
                      size: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

