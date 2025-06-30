// lib/page/lunch_dinner_page.dart

import 'package:flutter/material.dart';
import 'package:chefio/models/recipe_model.dart';    // Pastikan import ini benar
import 'package:chefio/page/recipe_detail_page.dart'; // Pastikan import ini benar

class LunchDinnerPage extends StatelessWidget { // <-- (1) Ganti nama kelas
  const LunchDinnerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // --- (2) DATA BARU UNTUK LUNCH & DINNER ---
    final List<Recipe> recipes = [
      Recipe(
        title: 'Nasi Goreng Teri Pete',
        description: 'Nasi goreng klasik Indonesia dengan rasa gurih dari teri dan pete, disajikan dengan telur mata sapi yang sempurna. Cocok untuk makan siang atau malam.',
        imageUrl: 'images/nasi_goreng_teri_pete.png', // Gunakan gambar baru Anda
        cookingTime: '±20 menit',
        ingredients: [
          '2 piring nasi putih',
          '3 sdm teri goreng',
          '1 papan pete, kupas dan belah dua',
          '2 butir telur',
          '2 siung bawang putih',
          '3 siung bawang merah',
          '2 cabai merah keriting',
          '2 cabai rawit (opsional, sesuai selera)',
          '1 sdm kecap manis',
          '1 sdt garam',
          'Merica secukupnya',
          'Minyak goreng secukupnya',

        ],
        steps: [
          'Panaskan minyak, tumis bawang putih, bawang merah dan cabai hingga harum.',
          'Masukkan telur, orak-arik hingga matang.',
          'Tambahkan pete, aduk sebentar sampai layu.',
          'Masukkan teri goreng dan aduk rata.',
          'Tambahkan nasi, aduk hingga tercampur rata.',
          'Tuangkan kecap manis, garam, dan merica.',
          'Aduk rata dan masak hingga bumbu meresap.',
          'Angkat dan sajikan selagi hangat',
        ],
      ),
    ];

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
                  'LUNCH & DINNER', // <-- (3) Ganti judul halaman
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Gunakan ListView.builder jika ada banyak resep
              Expanded(
                child: ListView.builder(
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    return _buildRecipeCard(
                      context: context,
                      recipe: recipes[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildSearchBar dan _buildRecipeCard tidak perlu diubah,
  // jadi kita bisa gunakan yang sudah ada dari breakfast_page.
  
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

  Widget _buildRecipeCard({
    required BuildContext context,
    required Recipe recipe,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
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
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Colors.grey.shade200,
                    child: const Center(
                      child: Icon(Icons.image_not_supported_outlined,
                          color: Colors.grey, size: 50),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Text(
              recipe.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: Text(
                    recipe.description.split('.').first,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.access_time_outlined, size: 16, color: Colors.grey.shade700),
                const SizedBox(width: 4),
                Text(
                  recipe.cookingTime.replaceAll('±', '').replaceAll(' menit', 'm'),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
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
}