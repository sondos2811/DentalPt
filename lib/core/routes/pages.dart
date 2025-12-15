import 'package:dental_pt/core/routes/routes_name.dart';
import 'package:dental_pt/features/Auth/presentation/pages/log_in_page.dart';
import 'package:dental_pt/features/Auth/presentation/pages/sign_up_page.dart';
import 'package:dental_pt/features/Auth/presentation/pages/splash_screen.dart';
import 'package:dental_pt/features/Auth/presentation/pages/doctor_profile_page.dart';
import 'package:dental_pt/features/Auth/presentation/pages/dentist_home_page.dart';
import 'package:dental_pt/features/Patient%20registration/presentation/pages/home_doctor_page.dart';
import 'package:dental_pt/features/Patient%20admission/presentation/pages/diagnoses_list_page.dart';
import 'package:dental_pt/features/Patient%20admission/presentation/pages/patients_by_diagnosis_page.dart';
import 'package:dental_pt/features/Patient%20admission/presentation/pages/patient_profile_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static Route<dynamic> generate(RouteSettings? settings) {
    switch (settings?.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (_) {
          return const SplashScreen();
        });
      case RoutesName.login:
        return MaterialPageRoute(builder: (_) {
          return const LoginPage();
        });
      case RoutesName.signUp:
        return MaterialPageRoute(builder: (_) {
          return const SignUpPage();
        });
      case RoutesName.homeDoctor:
        return MaterialPageRoute(builder: (_) {
          return HomeDoctorPage();
        });
      case RoutesName.dentistHome:
        return MaterialPageRoute(builder: (_) {
          return const DentistHomePage();
        });
      case RoutesName.diagnosesList:
        return MaterialPageRoute(builder: (_) {
          return const DiagnosesListPage();
        });
      case RoutesName.patientsByDiagnosis:
        final diagnosisType = settings?.arguments as String;
        return MaterialPageRoute(builder: (_) {
          return PatientsByDiagnosisPage(diagnosisType: diagnosisType);
        });
      case RoutesName.patientProfile:
        final patientId = settings?.arguments as int;
        return MaterialPageRoute(builder: (_) {
          return PatientProfilePage(patientId: patientId);
        });
      case RoutesName.doctorProfile:
        return MaterialPageRoute(builder: (_) {
          return const DoctorProfilePage();
        });

      // end of cases
      default:
        throw Exception('Route not found!');
    }
  }
}
