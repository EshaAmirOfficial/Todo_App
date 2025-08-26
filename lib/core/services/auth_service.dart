// lib/core/services/auth_service.dart

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Sign in with email and password
  Future<AuthResponse> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      // Supabase listener in AuthGate will handle navigation
      return response;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (_) {
      throw Exception('Something went wrong');
    }
  }

  // Sign up with email and password
  Future<AuthResponse> signUpWithEmailPassword(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );
      // Supabase listener in AuthGate will handle navigation
      return response;
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (_) {
      throw Exception('Something went wrong');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  String? getCurrnetUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}