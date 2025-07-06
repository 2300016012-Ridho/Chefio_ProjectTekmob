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
      backgroundColor: const Color(0xFFF7A0B9),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. MENGURANGI SPASI DI ATAS
              const Spacer(flex: 1), // Diubah dari 2 menjadi 1

              // Menampilkan logo (gambar + tulisan Chefio)
              Image.asset(
                "images/logo.png",
                // 2. UKURAN LOGO DIPERBESAR SECARA SIGNIFIKAN
                height: MediaQuery.of(context).size.height * 0.45, // Diubah dari 0.35 menjadi 0.45
              ),

              // 3. MENGURANGI SPASI DI ANTARA LOGO DAN TEKS
              const Spacer(flex: 2), // Diubah dari 3 menjadi 2

              // Headline
              const Text(
                "Where Every Recipe Tells a Story",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.black26,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Deskripsi
              const Text(
                "Discover the best home-style recipes with step-by-step guides, anytime you crave, right at your fingertips",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13.0,
                  fontFamily: 'Poppins',
                  height: 1.5,
                ),
              ),
              
              // 4. MENGURANGI SPASI DI ANTARA TEKS DAN TOMBOL
              const Spacer(flex: 1), // Diubah dari 2 menjadi 1

              // Tombol
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFF091CC),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 8,
                    shadowColor: Colors.black.withOpacity(0.25),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signin');
                  },
                  child: const Text(
                    "GET STARTED",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}