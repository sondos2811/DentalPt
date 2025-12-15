import 'package:flutter/material.dart';
import 'package:dental_pt/core/routes/routes_name.dart';

class DentistHomePage extends StatelessWidget {
  const DentistHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dental Pt',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF065091),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.doctorProfile);
            },
            tooltip: 'Doctor Profile',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF065091),
              const Color(0xFF065091).withOpacity(0.1),
            ],
            stops: const [0.0, 0.3],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Welcome, Doctor!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'What would you like to do today?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildNavigationCard(
                        context,
                        title: 'Register Patient',
                        description: 'Add new patient information',
                        icon: Icons.person_add,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFFee7733),
                            const Color(0xFFee7733).withOpacity(0.8)
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.homeDoctor);
                        },
                      ),
                      const SizedBox(height: 20),
                      _buildNavigationCard(
                        context,
                        title: 'View Diagnoses',
                        description: 'Browse patients by diagnosis',
                        icon: Icons.medical_services,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF065091),
                            const Color(0xFF065091).withOpacity(0.8)
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                              context, RoutesName.diagnosesList);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

