// page/breakfast_page.dart

import 'package:flutter/material.dart';
import 'package:chefio/models/recipe_model.dart';
import 'package:chefio/page/recipe_detail_page.dart';

// Data resep ini tidak perlu diubah.
final Recipe avocadoToastRecipe = Recipe(
  title: 'Avocado Toast',
  description: 'Roti panggang dengan olesan alpukat segar yang creamy, pilihan sarapan sehat dan cepat.',
  imageUrl: 'images/avocado_toast.png',
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
    // Scaffold dan AppBar sekarang akan otomatis mengikuti tema dari main.dart
    return Scaffold(
      appBar: AppBar(
        // Kita tidak perlu lagi mendefinisikan warna atau properti lainnya di sini.
        // Semuanya sudah diatur secara global di `main.dart`.
        title: const Text('Breakfast', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        // Menggunakan ListView agar bisa menampung banyak resep nantinya
        padding: const EdgeInsets.all(24.0),
        children: [
          _buildRecipeCard(
            context: context,
            recipe: avocadoToastRecipe,
          ),
          // Anda bisa menambahkan resep lain di sini
        ],
      ),
    );
  }

  // Widget ini dimodifikasi agar menggunakan warna dari Tema
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
      child: Container(
        margin: const EdgeInsets.only(bottom: 24.0),
        decoration: BoxDecoration(
          // Menggunakan warna kartu dari tema aktif (putih di light, abu gelap di dark)
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
              child: Image.asset(
                recipe.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    // Text akan otomatis mengambil warna dari tema (hitam/putih)
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    recipe.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    // Menggunakan warna abu-abu yang netral untuk kedua tema
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined,
                          size: 18, 
                          // Mengambil warna primer (pink) dari tema
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(
                        recipe.cookingTime,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Icon(Icons.bookmark_border,
                          size: 24, color: Colors.grey.shade500),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}