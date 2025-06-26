import 'package:flutter/material.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        "CHEFIO",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 40),
                      Image.asset(
                        "images/loading.png",
                        fit: BoxFit.contain,
                        height: MediaQuery.of(context).size.height * 0.3,
                      ),
                      const SizedBox(height: 40),
                      const Text(
                        "All your favorites",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Discover the best home-style recipes\nwith step-by-step guides, anytime you crave,\nright at your fingertips",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(137, 0, 0, 0),
                          fontSize: 15.0,
                          fontFamily: 'Poppins',
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // Warna disesuaikan dengan permintaan Anda
                    backgroundColor: const Color.fromARGB(255, 233, 30, 99),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: const Text(
                    "GET STARTED",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Poppins', // Tambahkan font family agar konsisten
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}