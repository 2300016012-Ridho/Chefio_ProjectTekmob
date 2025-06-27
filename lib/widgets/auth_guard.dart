// lib/widgets/auth_guard.dart
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../page/GetStarted.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;
  final AuthService _authService = AuthService();

  AuthGuard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _authService.authStateChanges,
      builder: (context, snapshot) {
        // Check if user is logged in
        if (_authService.isLoggedIn) {
          return child;
        } else {
          // Redirect to GetStarted if not logged in
          return const GetStarted();
        }
      },
    );
  }
}