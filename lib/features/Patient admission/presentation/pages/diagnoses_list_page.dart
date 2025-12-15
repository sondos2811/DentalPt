import 'package:flutter/material.dart';
import 'package:dental_pt/core/routes/routes_name.dart';
import 'package:dental_pt/features/Patient%20admission/presentation/widgets/diagnosis_card.dart';

class DiagnosesListPage extends StatelessWidget {
  const DiagnosesListPage({super.key});

  // Common dental diagnoses
  static const List<String> diagnosesList = [
    "Pediatric department",
    "Surgery department",
    "Periodontics department",
    "Conservative department",
    "Fixed prosthesis department",
    "Removal prosthesis department",
    "Endodontic department",
    "Orthodontic department",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome Back',

          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF065091),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, RoutesName.doctorProfile);
            },
            tooltip: 'Profile',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF065091).withOpacity(0.95),
              const Color(0xFF0d71b8),
            ],
            stops: const [0.0, 1.0],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                color: const Color(0xFF065091),
                backgroundColor: Colors.white,
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 500));
                },
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: diagnosesList.length,
                  itemBuilder: (context, index) {
                    final diagnosis = diagnosesList[index];
                    return DiagnosisCard(
                      diagnosisName: diagnosis,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.patientsByDiagnosis,
                          arguments: diagnosis,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

