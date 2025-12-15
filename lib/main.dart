import 'package:dental_pt/core/routes/pages.dart';
import 'package:dental_pt/core/routes/routes_name.dart';
import 'package:dental_pt/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_pt/features/Patient%20admission/presentation/bloc/patient_admission_bloc.dart';
import 'package:dental_pt/features/Patient%20registration/presentation/bloc/patient_registration_bloc.dart';
import 'package:dental_pt/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Supabase.initialize(
    url: 'https://mzbwauvzepurhshwtedd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im16YndhdXZ6ZXB1cmhzaHd0ZWRkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ2MDU1MDAsImV4cCI6MjA4MDE4MTUwMH0.QRcUpg1T9rsnHR0pTZADHOlwijdsqLXmATivQXo_tpA',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider<PatientRegistrationBloc>(
          create: (context) => sl<PatientRegistrationBloc>(),
        ),
        BlocProvider<PatientAdmissionBloc>(
          create: (context) => sl<PatientAdmissionBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dental Pt.',
        theme: ThemeData(
          primaryColor: const Color(0xFF065091),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF065091),
            foregroundColor: Colors.white,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFee7733),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF065091),
              foregroundColor: Colors.white,
            ),
          ),
        ),
        onGenerateRoute:
            AppRoutes.generate, // Use AppRoute to handle navigation
        initialRoute:
            RoutesName.splash, // Set the initial route to SplashScreen
      ),
    );
  }
}
