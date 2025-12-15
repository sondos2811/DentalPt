import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_pt/core/routes/routes_name.dart';
import 'package:dental_pt/features/Patient%20admission/presentation/bloc/patient_admission_bloc.dart';
import 'package:dental_pt/features/Patient%20admission/presentation/widgets/patient_card.dart';

class PatientsByDiagnosisPage extends StatefulWidget {
  final String diagnosisType;

  const PatientsByDiagnosisPage({
    super.key,
    required this.diagnosisType,
  });

  @override
  State<PatientsByDiagnosisPage> createState() =>
      _PatientsByDiagnosisPageState();
}

class _PatientsByDiagnosisPageState extends State<PatientsByDiagnosisPage> {
  @override
  void initState() {
    super.initState();
    _loadPatients();
  }

  void _loadPatients() {
    context.read<PatientAdmissionBloc>().add(
          GetPatiantDataEvent(
            type: widget.diagnosisType,
            status: 'no',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          _loadPatients();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.diagnosisType,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue.shade700,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.shade700,
                Colors.grey.shade50,
              ],
              stops: const [0.0, 0.2],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Patients with ${widget.diagnosisType}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<PatientAdmissionBloc, PatientAdmissionState>(
                  builder: (context, state) {
                    if (state is PatientAdmissionLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    } else if (state is PatientAdmissionFailure) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          _loadPatients();
                        },
                        child: ListView(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 60,
                                    color: Colors.red.shade300,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    state.error,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.red.shade700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton.icon(
                                    onPressed: _loadPatients,
                                    icon: const Icon(Icons.refresh),
                                    label: const Text('Retry'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF065091),
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else if (state is PatientDataLoaded) {
                      if (state.patientData.isEmpty) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            _loadPatients();
                          },
                          child: ListView(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.people_outline,
                                      size: 80,
                                      color: Colors.grey.shade400,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'No patients found',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.grey.shade600,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'There are no patients with this diagnosis',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          _loadPatients();
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.only(top: 8, bottom: 16),
                          itemCount: state.patientData.length,
                          itemBuilder: (context, index) {
                            final patient = state.patientData[index];
                            return PatientCard(
                              patient: patient,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.patientProfile,
                                  arguments: patient.id,
                                ).then((_) {
                                  // Reload data when returning from patient profile
                                  _loadPatients();
                                });
                              },
                            );
                          },
                        ),
                      );
                    }

                    return const Center(
                      child: Text(
                        'Select a diagnosis to view patients',
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

