import 'package:flutter/material.dart';
import 'package:chefio/page/GetStarted.dart';
import 'package:chefio/page/Homepage.dart';
import 'package:chefio/page/sign_in.dart';
import 'package:chefio/page/sign_up.dart';
import 'package:chefio/page/SuccessfulPage.dart';

void main() {
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
      initialRoute: '/',
      routes: {
        '/': (context) => const GetStarted(),
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
        '/success': (context) => const SuccessfulPage(),
        '/home': (context) => const HomePage(initialIndex: 0),
        '/profile': (context) => const HomePage(initialIndex: 2),
      },
    );
  }
}