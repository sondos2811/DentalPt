import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_pt/features/Patient%20admission/presentation/bloc/patient_admission_bloc.dart';

class PatientProfilePage extends StatefulWidget {
  final int patientId;

  const PatientProfilePage({
    super.key,
    required this.patientId,
  });

  @override
  State<PatientProfilePage> createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  @override
  void initState() {
    super.initState();
    _loadPatientData();
  }

  void _loadPatientData() {
    context.read<PatientAdmissionBloc>().add(
          GetPatiantDataByIdEvent(id: widget.patientId),
        );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          _loadPatientData();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Patient Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.blue.shade700,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocBuilder<PatientAdmissionBloc, PatientAdmissionState>(
          builder: (context, state) {
            if (state is PatientAdmissionLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PatientAdmissionFailure) {
              return RefreshIndicator(
                onRefresh: () async {
                  _loadPatientData();
                },
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
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
                            onPressed: _loadPatientData,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is SinglePatientDataLoaded) {
              final patient = state.patientData;

              return RefreshIndicator(
                onRefresh: () async {
                  _loadPatientData();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // Header Section
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFF065091),
                              Color(0xFF0d71b8),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: Text(
                                patient.name.isNotEmpty
                                    ? patient.name[0].toUpperCase()
                                    : 'P',
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF065091),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              patient.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: patient.status == 'finished'
                                    ? Colors.purple.shade400
                                    : patient.status == 'yes'
                                        ? const Color(0xFFee7733)
                                        : Colors.orange.shade400,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                patient.status == 'finished'
                                    ? 'Finished'
                                    : patient.status == 'yes'
                                        ? 'Reserved'
                                        : 'Available',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Personal Information Section
                      const SizedBox(height: 16),
                      _buildSectionTitle('Personal Information'),
                      _buildInfoCard(
                        icon: Icons.cake,
                        title: 'Age',
                        value: '${patient.age} years',
                        color: Colors.orange,
                      ),
                      _buildInfoCard(
                        icon: Icons.person,
                        title: 'Gender',
                        value: patient.gander,
                        color: Colors.purple,
                      ),
                      _buildInfoCard(
                        icon: Icons.phone,
                        title: 'Phone',
                        value: '${patient.phone}',
                        color: const Color(0xFFee7733),
                      ),

                      // Diagnoses Section
                      const SizedBox(height: 16),
                      _buildSectionTitle('Diagnoses'),
                      if (patient.diagnoses.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'No diagnoses recorded',
                            style: TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        )
                      else
                        ...patient.diagnoses.map((diagnosis) {
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.blue.shade100,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Icon(
                                          Icons.medical_services,
                                          color: Colors.blue.shade700,
                                          size: 24,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          diagnosis.name,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    diagnosis.description,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.medical_information,
                                        size: 16,
                                        color: Colors.grey.shade600,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Tooth: ${diagnosis.noOfTooth}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),

                      // National ID Section (if available)
                      if (patient.nationalIdFaceUrl != null ||
                          patient.nationalIdBackUrl != null) ...[
                        const SizedBox(height: 16),
                        _buildSectionTitle('National ID'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              if (patient.nationalIdFaceUrl != null)
                                Expanded(
                                  child: _buildImageCard(
                                    'Front',
                                    patient.nationalIdFaceUrl!,
                                  ),
                                ),
                              if (patient.nationalIdFaceUrl != null &&
                                  patient.nationalIdBackUrl != null)
                                const SizedBox(width: 8),
                              if (patient.nationalIdBackUrl != null)
                                Expanded(
                                  child: _buildImageCard(
                                    'Back',
                                    patient.nationalIdBackUrl!,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],

                      // Finished Banner at Top (if status is finished)
                      if (patient.status == 'finished') ...[
                        const SizedBox(height: 16),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.purple.shade400,
                                Colors.purple.shade600,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.purple.shade200,
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 32,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'FINISHED',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Action Buttons Section (only if not finished)
                      if (patient.status != 'finished') ...[
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: patient.status == 'no'
                              ? SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      context.read<PatientAdmissionBloc>().add(
                                            PatientIsReservedEvent(
                                              patient: patient,
                                              status: 'yes',
                                            ),
                                          );
                                    },
                                    icon: const Icon(Icons.event_available),
                                    label: const Text(
                                      'Reserve',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFee7733),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 2,
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          context
                                              .read<PatientAdmissionBloc>()
                                              .add(
                                                PatientIsNotReservedEvent(
                                                  patient: patient,
                                                  status: 'no',
                                                ),
                                              );
                                        },
                                        icon: const Icon(Icons.person_off),
                                        label: const Text(
                                          "Didn't Come",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.red.shade700,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          elevation: 2,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          context
                                              .read<PatientAdmissionBloc>()
                                              .add(
                                                PatientIsNotReservedEvent(
                                                  patient: patient,
                                                  status: 'finished',
                                                ),
                                              );
                                        },
                                        icon: const Icon(Icons.check_circle),
                                        label: const Text(
                                          'Finish',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(0xFF065091),
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          elevation: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ],

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              );
            } else if (state is PatientAdmissionUpdated) {
              // Refresh patient data after status update
              Future.microtask(() {
                context.read<PatientAdmissionBloc>().add(
                      GetPatiantDataByIdEvent(id: widget.patientId),
                    );
              });
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return const Center(
              child: Text('Loading patient data...'),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            color: Colors.blue.shade700,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 1,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildImageCard(String label, String imageUrl) {
    return GestureDetector(
      onTap: () {
        _showFullScreenImage(imageUrl, label);
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                imageUrl,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 150,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.zoom_in,
                    size: 16,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFullScreenImage(String imageUrl, String label) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black,
          insetPadding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade900,
                        child: const Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 100,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

