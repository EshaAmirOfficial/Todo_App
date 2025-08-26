// lib/presentation/auth/auth_gate.dart

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_app/presentation/auth/view/login_screen.dart';
import 'package:todo_app/presentation/home/view/home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
         
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If a user session exists, navigate to the Home screen.
        final session = snapshot.data?.session;
        if (session != null) {
          return  HomeScreen();
        }

        // Otherwise, show the Login screen.
        return  LoginScreen();
      },
    );
  }
}