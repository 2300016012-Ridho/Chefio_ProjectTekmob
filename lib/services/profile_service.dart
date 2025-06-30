// services/profile_service.dart
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Get user profile data
  Future<Map<String, dynamic>> getUserProfile(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select('*')
          .eq('id', userId)
          .single();
      
      return response;
    } catch (e) {
      print('Error getting user profile: $e');
      // Return empty profile if not found
      return {};
    }
  }

  // Create or update user profile
  Future<void> createOrUpdateProfile({
    required String userId,
    required String fullName,
    required String email,
    String? username,
    String? gender,
    String? phoneNumber,
    String? profileImageUrl,
  }) async {
    try {
      await _supabase.from('profiles').upsert({
        'id': userId,
        'full_name': fullName,
        'email': email,
        'username': username,
        'gender': gender,
        'phone_number': phoneNumber,
        'profile_image_url': profileImageUrl,
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  // Upload profile image to Supabase Storage
  Future<String> uploadProfileImage(File imageFile, String userId) async {
    try {
      // Generate unique file name
      final fileExtension = imageFile.path.split('.').last;
      final fileName = '$userId/profile_${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
      
      // Upload to Supabase Storage
      await _supabase.storage
          .from('profiles')
          .upload(fileName, imageFile);

      // Get public URL
      final imageUrl = _supabase.storage
          .from('profiles')
          .getPublicUrl(fileName);

      return imageUrl;
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }

  // Update profile image URL in database
  Future<void> updateProfileImage(String userId, String imageUrl) async {
    try {
      await _supabase
          .from('profiles')
          .update({'profile_image_url': imageUrl})
          .eq('id', userId);
    } catch (e) {
      throw Exception('Failed to update profile image: $e');
    }
  }

  // Delete old profile image from storage
  Future<void> deleteProfileImage(String imageUrl) async {
    try {
      // Extract file path from URL
      final uri = Uri.parse(imageUrl);
      final pathSegments = uri.pathSegments;
      final fileName = pathSegments.skip(pathSegments.indexOf('profiles') + 1).join('/');
      
      await _supabase.storage
          .from('profiles')
          .remove([fileName]);
    } catch (e) {
      print('Error deleting old profile image: $e');
      // Don't throw error as this is not critical
    }
  }
}