import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_pt/features/Patient%20admission/presentation/bloc/patient_admission_bloc.dart';
import 'package:dental_pt/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_pt/core/routes/routes_name.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({super.key});

  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  @override
  void initState() {
    super.initState();
    _loadAllPatients();
  }

  void _loadAllPatients() {
    context.read<PatientAdmissionBloc>().add(
          const GetAllPatientsEvent(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        if (didPop) {
          _loadAllPatients();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Doctor Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF065091),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
           
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _handleLogout,
              tooltip: 'Logout',
            ),
          ],
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoggedOut) {
              // Clear patient data from bloc before navigating to login
              context.read<PatientAdmissionBloc>().add(const ClearPatientDataEvent());
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully'),
                  backgroundColor: Color(0xFFee7733),
                  duration: Duration(seconds: 2),
                ),
              );
              Navigator.pushReplacementNamed(context, RoutesName.login);
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logout failed: ${state.error}'),
                  backgroundColor: Colors.red.shade700,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          child: FutureBuilder<Map<String, dynamic>>(
            future: _getDoctorData(),
            builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        size: 60, color: Colors.red.shade300),
                    const SizedBox(height: 16),
                    const Text('Error loading profile'),
                  ],
                ),
              );
            }

            final doctorData = snapshot.data!;
            final doctorName = doctorData['name'] ?? 'Doctor';
            final doctorEmail = doctorData['email'] ?? '';
            final doctorPhone = doctorData['phone']?.toString() ?? '';
            final doctorAge = doctorData['age']?.toString() ?? '';
            final doctorRole = doctorData['role'] ?? '';

            return RefreshIndicator(
              onRefresh: () async {
                _loadAllPatients();
                setState(() {}); // Refresh FutureBuilder
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // Header Section with gradient
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
                            radius: 60,
                            backgroundColor: Colors.white,
                            child: Text(
                              doctorName.isNotEmpty
                                  ? doctorName[0].toUpperCase()
                                  : 'D',
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF065091),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Dr. $doctorName',
                            style: const TextStyle(
                              fontSize: 28,
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
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '$doctorRole',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
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
                      icon: Icons.email,
                      title: 'Email',
                      value: doctorEmail,
                      color: const Color(0xFF065091),
                    ),
                    _buildInfoCard(
                      icon: Icons.phone,
                      title: 'Phone',
                      value: doctorPhone,
                      color: const Color(0xFFee7733),
                    ),
                    _buildInfoCard(
                      
                      title: 'Age',
                      value: '$doctorAge years',
                      color: const Color(0xFF065091),
                    ),

                    // Patient Statistics Section
                    const SizedBox(height: 24),
                    _buildSectionTitle('Patient Statistics'),
                    BlocBuilder<PatientAdmissionBloc, PatientAdmissionState>(
                      builder: (context, state) {
                        if (state is PatientAdmissionLoading) {
                          return const Padding(
                            padding: EdgeInsets.all(32.0),
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is AllPatientsDataLoaded) {
                          final allPatients = state.patientData;
                          final availablePatients =
                              allPatients.where((p) => p.status == 'no').length;
                          final reservedPatients = allPatients
                              .where((p) => p.status == 'yes')
                              .length;
                          final finishedPatients = allPatients
                              .where((p) => p.status == 'finished')
                              .length;

                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: _buildStatCard(
                                        'Total',
                                        allPatients.length.toString(),
                                        Colors.blue,
                                        Icons.people,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildStatCard(
                                        'Available',
                                        availablePatients.toString(),
                                        Colors.orange,
                                        Icons.person_outline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: _buildStatCard(
                                        'Reserved',
                                        reservedPatients.toString(),
                                        Colors.green,
                                        Icons.event_available,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _buildStatCard(
                                        'Finished',
                                        finishedPatients.toString(),
                                        Colors.purple,
                                        Icons.check_circle,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Patients List Section
                              const SizedBox(height: 24),
                              _buildSectionTitle('All Patients'),
                              if (allPatients.isEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(32.0),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.people_outline,
                                        size: 60,
                                        color: Colors.grey.shade400,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'No patients yet',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              else
                                ...allPatients.map((patient) {
                                  return _buildPatientListTile(
                                    context,
                                    patient.name,
                                    patient.status,
                                    patient.diagnoses.isNotEmpty
                                        ? patient.diagnoses.first.name
                                        : 'No diagnosis',
                                    () {
                                      Navigator.pushNamed(
                                        context,
                                        RoutesName.patientProfile,
                                        arguments: patient.id,
                                      ).then((_) {
                                        // Reload data when returning from patient profile
                                        _loadAllPatients();
                                        setState(
                                            () {}); // Refresh FutureBuilder
                                      });
                                    },
                                  );
                                }),
                            ],
                          );
                        }

                        return const SizedBox();
                      },
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            );
          },
          ),
        ),
      ),
    );
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<AuthBloc>().add(LogoutEvent());
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<Map<String, dynamic>> _getDoctorData() async {
    final currentUser = Supabase.instance.client.auth.currentUser;
    if (currentUser != null) {
      final response = await Supabase.instance.client
          .from('users')
          .select()
          .eq('uuid', currentUser.id)
          .single();
      return response;
    }
    throw Exception('No user logged in');
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
     IconData? icon,
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

  Widget _buildStatCard(
      String label, String value, Color color, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientListTile(
    BuildContext context,
    String name,
    String status,
    String diagnosis,
    VoidCallback onTap,
  ) {
    Color statusColor;
    String statusText;

    switch (status) {
      case 'yes':
        statusColor = Colors.green;
        statusText = 'Reserved';
        break;
      case 'finished':
        statusColor = Colors.purple;
        statusText = 'Finished';
        break;
      default:
        statusColor = Colors.orange;
        statusText = 'Available';
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF065091).withOpacity(0.1),
          child: Text(
            name.isNotEmpty ? name[0].toUpperCase() : 'P',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF065091),
            ),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          diagnosis,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            statusText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: statusColor.withOpacity(1.0),
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

