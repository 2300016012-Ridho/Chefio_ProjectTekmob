
import 'package:flutter/material.dart';

// Import semua halaman yang Anda butuhkan
import 'package:chefio/page/GetStarted.dart';
import 'package:chefio/page/Homepage.dart';
import 'package:chefio/page/sign_in.dart';
import 'package:chefio/page/sign_up.dart';
import 'package:chefio/page/SuccessfulPage.dart';
import 'package:chefio/page/forgot_password.dart';
import 'package:chefio/page/breakfast_page.dart';
import 'package:chefio/page/lunch_dinner_page.dart';
import 'package:chefio/page/milkshake_page.dart';
import 'package:chefio/page/dessert_page.dart';
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
      // Ini adalah buku catatan Si Manajer Proyek
      routes: {
        '/getstarted': (context) => const GetStarted(),
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
        '/success': (context) => const SuccessfulPage(),
        '/home': (context) => const HomePage(initialIndex: 0),
        '/profile': (context) => const HomePage(initialIndex: 2),
        // Baris ini sekarang PASTI BENAR karena main.dart sudah "kenal" dengan BreakfastPage
        '/breakfast': (context) => const BreakfastPage(), 
        '/milkshake': (context) => const MilkshakePage(),
        '/dessert': (context) => const DessertPage(),
        '/lunch': (context) => const LunchDinnerPage()
      },
    );
  }
}

// Class AuthWrapper tidak perlu diubah, sudah bagus.
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
    setState(() {
      _isLoading = false;
    });
  }

  void _listenToAuthChanges() {
    _authService.authStateChanges.listen((data) {
      if (mounted) {
        setState(() {});
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

    final user = _authService.currentUser;
    
    if (user != null) {
      return const HomePage(initialIndex: 0);
    } else {
      return const GetStarted();
    }
  }
}