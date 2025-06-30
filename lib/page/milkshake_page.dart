// lib/page/milkshake_page.dart

import 'package:flutter/material.dart';
import 'package:chefio/models/recipe_model.dart';      // <-- IMPORT MODEL
import 'package:chefio/page/recipe_detail_page.dart'; // <-- IMPORT HALAMAN DETAIL

// =======================================================
// LANGKAH 1: Siapkan data lengkap untuk resep ini
// =======================================================
final Recipe chocolateMilkshakeRecipe = Recipe(
  title: 'Chocolate Milkshake',
  description: 'Milkshake Coklat adalah minuman manis dan creamy yang terbuat dari es krim coklat, susu dingin, dan sirup coklat.',
  imageUrl: 'images/chocolate_milkshake.png', // Pastikan nama file gambarnya benar
  cookingTime: '5 menit',
  ingredients: [
    '3 scoops es krim coklat',
    '1 cangkir susu dingin',
    '2 sendok makan sirup coklat',
    '1/2 sendok teh ekstrak vanila (Opsional)',
    'Topping: Whipped Cream, Coklat serut (opsional)'
  ],
  steps: [
    'Masukkan es krim, susu, dan sirup coklat ke dalam blender.',
    'Blender dengan kecepatan tinggi hingga semua bahan tercampur rata dan lembut.',
    'Jika menggunakan, tambahkan ekstrak vanila dan blender sebentar.',
    'Tuang milkshake ke dalam gelas saji.',
    'Hias dengan whipped cream dan taburan coklat serut jika suka. Sajikan segera!'
  ],
);

class MilkshakePage extends StatelessWidget {
  const MilkshakePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSearchBar(),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'MILKSHAKE',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Menampilkan kartu resep
              _buildRecipeCard(
                context: context,
                recipe: chocolateMilkshakeRecipe, // <-- Kirim semua data resep milkshake
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget ini sama persis seperti yang ada di breakfast_page.dart
  Widget _buildRecipeCard({
    required BuildContext context,
    required Recipe recipe,
  }) {
    return GestureDetector(
      // =======================================================
      // LANGKAH 2: Beri perintah navigasi di sini
      // =======================================================
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            // Arahkan ke RecipeDetailPage dan "bawa" data resepnya
            builder: (context) => RecipeDetailPage(recipe: recipe),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.asset(
                recipe.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Colors.grey.shade200,
                  child: const Center(child: Icon(Icons.image_not_supported_outlined, color: Colors.grey, size: 50)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              recipe.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    recipe.description,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.access_time_outlined, size: 16, color: Colors.grey.shade700),
                const SizedBox(width: 4),
                Text(
                  recipe.cookingTime,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 12),
                Icon(Icons.bookmark_border, size: 22, color: Colors.grey.shade800),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget SearchBar juga sama, tidak perlu diubah
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cari Menu',
        hintStyle: TextStyle(color: Colors.grey.shade500),
        prefixIcon: Icon(Icons.search, color: Colors.grey.shade500),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
        ),
      ),
    );
  }
}