import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dental_pt/features/Auth/presentation/bloc/auth_bloc.dart';
import 'package:dental_pt/core/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() {
    // Delay for 2 seconds to show splash screen
    Future.delayed(const Duration(seconds: 3), () {
      // Check if user is logged in
      context.read<AuthBloc>().add(IsLoggedInEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedIn) {
            // User is logged in - get current user to check role
            context.read<AuthBloc>().add(GetCurrentUserEvent());
          } else if (state is AuthUserLoaded) {
            // Navigate based on user role
            final userRole = state.user.role.toLowerCase();
            if (userRole == 'student') {
              Navigator.pushReplacementNamed(
                context,
                RoutesName.diagnosesList,
              );
            } else {
              // Dentist or other roles
              Navigator.pushReplacementNamed(
                context,
                RoutesName.dentistHome,
              );
            }
          } else if (state is AuthLoggedOut || state is AuthFailure) {
            // User is not logged in - navigate to login page
            Navigator.pushReplacementNamed(
              context,
              RoutesName.login,
            );
          }
        },
        child: _buildSplashContent(context),
      ),
    );
  }

  Widget _buildSplashContent(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo/Icon - Larger and elegant
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF065091).withOpacity(0.08),
              ),
              child: Image.asset(
                'assests/images/logo.png',
                width: 140,
                height: 140,
              ),
            ),
            const SizedBox(height: 50),

            // App Name - Elegant and classic
            const Text(
              'Dental Pt',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w800,
                color: Color(0xFF065091),
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 12),

            // Tagline - Classic subtitle
            Text(
              'Your Dental Care Partner',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF065091).withOpacity(0.65),
                letterSpacing: 0.5,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 80),

            // Loading Indicator - Classic style
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFee7733),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Loading text
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF065091).withOpacity(0.6),
                letterSpacing: 0.8,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

