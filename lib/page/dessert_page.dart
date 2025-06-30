// lib/page/dessert_page.dart

import 'package:flutter/material.dart';
import 'package:chefio/models/recipe_model.dart';
import 'package:chefio/page/recipe_detail_page.dart';

// =======================================================
// LANGKAH 1: Siapkan data lengkap untuk resep ini
// =======================================================
final Recipe chocoLavaCakeRecipe = Recipe(
  title: 'Chocolate Lava Cake',
  description: 'Chocolate Lava Cake adalah dessert lembut dengan bagian luar kue yang matang sempurna dan bagian dalam yang masih lumer seperti lava cokelat panas.',
  imageUrl: 'images/lava_cake.png', // <-- Ganti dengan nama file gambar Anda
  cookingTime: '±20 menit',
  ingredients: [
    '100gr dark chocolate',
    '100gr butter',
    '2 butir telur utuh',
    '2 kuning telur',
    '50gr gula halus',
    '1/2 sdt vanila ekstrak (opsional)',
    '30gr tepung terigu (ayak)',
    'Margarin dan sedikit tepung untuk melapisi cetakan (ramekin)'
  ],
  steps: [
    'Panaskan oven ke 200°C.',
    'Lelehkan cokelat dan butter (bisa di-tim atau microwave).',
    'Di wadah terpisah, kocok telur, kuning telur, gula, dan vanila hingga mengembang dan pucat.',
    'Campur adonan telur dengan cokelat leleh, aduk perlahan hingga rata.',
    'Tambahkan tepung terigu yang sudah diayak, aduk rata jangan sampai overmix.',
    'Olesi cetakan (ramekin) dengan margarin dan taburin sedikit tepung.',
    'Tuang adonan ke cetakan (isi sekitar 3/4 penuh).',
    'Panggang selama 10-12 menit. Bagian pinggirnya akan matang dan tengahnya masih sedikit goyang.',
    'Diamkan sebentar sekitar 1-2 menit, lalu balikkan di atas piring saji. Sajikan hangat.'
  ],
);

class DessertPage extends StatelessWidget {
  const DessertPage({Key? key}) : super(key: key);

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
                  'DESSERT',
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
                recipe: chocoLavaCakeRecipe, // <-- Kirim semua data resep lava cake
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget ini sama persis seperti yang lain
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