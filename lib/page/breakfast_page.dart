// lib/page/breakfast_page.dart

import 'package:flutter/material.dart';
import 'package:chefio/models/recipe_model.dart';      // <-- IMPORT MODEL
import 'package:chefio/page/recipe_detail_page.dart'; // <-- IMPORT HALAMAN DETAIL

// =======================================================
// LANGKAH 1: Siapkan data lengkap untuk resep ini
// =======================================================
final Recipe avocadoToastRecipe = Recipe(
  title: 'Avocado Toast',
  description: 'Roti panggang dengan olesan alpukat segar yang creamy, pilihan sarapan sehat dan cepat.',
  imageUrl: 'images/avocado_toast.png', // Pastikan nama file gambarnya benar
  cookingTime: '10 menit',
  ingredients: [
    '2 lembar roti gandum',
    '1 buah alpukat matang',
    '1 sdt jus lemon',
    'Garam dan lada secukupnya',
    'Chili flakes (opsional)',
    '1 butir telur (opsional, untuk dibuat telur mata sapi)'
  ],
  steps: [
    'Panggang roti hingga berwarna keemasan.',
    'Sambil menunggu, kerok daging alpukat ke dalam mangkuk.',
    'Hancurkan alpukat dengan garpu, tambahkan jus lemon, garam, dan lada. Aduk rata.',
    'Oleskan campuran alpukat secara merata di atas roti panggang.',
    'Jika suka, taburi dengan chili flakes dan letakkan telur mata sapi di atasnya.',
    'Sajikan segera.'
  ],
);


class BreakfastPage extends StatelessWidget {
  const BreakfastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // ... (AppBar Anda tidak perlu diubah)
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
              // ... (SearchBar dan Judul 'BREAKFAST' tidak perlu diubah)
              _buildSearchBar(),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'BREAKFAST',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                ),
              ),
              const SizedBox(height: 16),
              
              // Menampilkan kartu resep
              _buildRecipeCard(
                context: context,          // <-- kita butuh context untuk navigasi
                recipe: avocadoToastRecipe, // <-- Kirim semua data resep
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget ini bisa Anda biarkan di sini, atau pindahkan ke file widget terpisah nanti
  Widget _buildRecipeCard({
    required BuildContext context,
    required Recipe recipe, // <-- Terima satu object Recipe, bukan banyak String
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
                recipe.imageUrl, // <-- Ambil data dari object recipe
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
              recipe.title, // <-- Ambil data dari object recipe
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    recipe.description, // <-- Ambil data dari object recipe
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.access_time_outlined, size: 16, color: Colors.grey.shade700),
                const SizedBox(width: 4),
                Text(
                  recipe.cookingTime, // <-- Ambil data dari object recipe
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

  // Widget SearchBar tidak perlu diubah
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        // ... (kode search bar Anda)
      ),
    );
  }
}