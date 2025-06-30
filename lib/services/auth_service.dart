// services/auth_service.dart - Fixed with missing methods
import 'package:supabase_flutter/supabase_flutter.dart';
import 'profile_service.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final ProfileService _profileService = ProfileService();

  // Get current user
  User? getCurrentUser() {
    return _supabase.auth.currentUser;
  }

  // Add the missing currentUser getter
  User? get currentUser {
    return _supabase.auth.currentUser;
  }

  // Add the missing isLoggedIn getter
  bool get isLoggedIn {
    return _supabase.auth.currentUser != null;
  }

  // Sign up with profile creation
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
        },
      );

      // Create profile after successful signup
      if (response.user != null) {
        await _profileService.createOrUpdateProfile(
          userId: response.user!.id,
          fullName: fullName,
          email: email,
        );
      }

      return response;
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }

  // Sign in
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return response;
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: $e');
    }
  }

  // Reset password - Fixed method signature
  Future<void> resetPassword({required String email}) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }

  // Listen to auth state changes
  Stream<AuthState> get authStateChanges {
    return _supabase.auth.onAuthStateChange;
  }
}