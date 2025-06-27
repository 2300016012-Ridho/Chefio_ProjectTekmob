// main.dart - Updated dengan Auth Check dan Route Management
import 'package:flutter/material.dart';
import 'package:chefio/page/GetStarted.dart';
import 'package:chefio/page/Homepage.dart';
import 'package:chefio/page/sign_in.dart';
import 'package:chefio/page/sign_up.dart';
import 'package:chefio/page/SuccessfulPage.dart';
import 'package:chefio/page/forgot_password.dart';
import 'package:chefio/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Supabase.initialize(
    url: "https://gmnlzpixswdpdlcfnqbp.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtbmx6cGl4c3dkcGRsY2ZucWJwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTA5NDkyOTEsImV4cCI6MjA2NjUyNTI5MX0.ecQOXNHh2r_KGbKal4mGn1OvBDox3wMTvW_yRQJqKLg"
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chefio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.pink,
      ),
      home: const AuthWrapper(),
      routes: {
        '/getstarted': (context) => const GetStarted(),
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
        '/success': (context) => const SuccessfulPage(),
        '/home': (context) => const HomePage(initialIndex: 0),
        '/profile': (context) => const HomePage(initialIndex: 2),
      },
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  final AuthService _authService = AuthService();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuthState();
    _listenToAuthChanges();
  }

  void _checkAuthState() {
    // Check if user is already logged in
    setState(() {
      _isLoading = false;
    });
  }

  void _listenToAuthChanges() {
    _authService.authStateChanges.listen((data) {
      if (mounted) {
        setState(() {
          // Trigger rebuild when auth state changes
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFFE91E63),
          ),
        ),
      );
    }

    // Check if user is logged in
    final user = _authService.currentUser;
    
    if (user != null) {
      // User is logged in, show home page
      return const HomePage(initialIndex: 0);
    } else {
      // User is not logged in, show get started page
      return const GetStarted();
    }
  }
}