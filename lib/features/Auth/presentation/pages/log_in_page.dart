// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:dental_pt/core/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  void _handleLogin(BuildContext context, TextEditingController emailController,
      TextEditingController passwordController, GlobalKey<FormState> formKey) {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            LoginEvent(
              email: emailController.text.trim(),
              password: passwordController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red.shade700,
                ),
              );
            } else if (state is AuthLoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login successful!'),
                  backgroundColor: Color(0xFFee7733),
                ),
              );
              // Navigate based on user role
              if (state.user.role.toLowerCase() == 'student') {
                Navigator.pushReplacementNamed(
                    context, RoutesName.diagnosesList);
              } else {
                // Dentist or other roles
                Navigator.pushReplacementNamed(context, RoutesName.dentistHome);
              }
            }
          },
          builder: (context, state) {
            final isLoading = state is AuthLoading;

            return Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo or App Icon
                    
                      const SizedBox(height: 16),

                      // App Title and Subtitle
                      const AuthHeader(
                        title: 'Dental Pt.',
                        subtitle: 'Welcome back! Please login to continue',
                      ),
                      const SizedBox(height: 48),

                      // Email Field
                      EmailField(
                        controller: _emailController,
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      PasswordField(
                        controller: _passwordController,
                        enabled: !isLoading,
                      ),
                      const SizedBox(height: 8),

                      
                      const SizedBox(height: 24),

                      // Login Button
                      LoginButton(
                        onPressed: () => _handleLogin(context, _emailController,
                            _passwordController, _formKey),
                        isLoading: isLoading,
                      ),
                      const SizedBox(height: 24),

                      // Divider
                      const OrDivider(),
                      const SizedBox(height: 24),

                      // Sign Up Button
                      SignUpButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, RoutesName.signUp);
                        },
                        isLoading: isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

