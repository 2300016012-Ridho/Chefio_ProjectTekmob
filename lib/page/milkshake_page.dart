// page/milkshake_page.dart

import 'package:flutter/material.dart';
import 'package:chefio/models/recipe_model.dart';
import 'package:chefio/page/recipe_detail_page.dart';

final Recipe chocolateMilkshakeRecipe = Recipe(
  title: 'Classic Chocolate Milkshake',
  description: 'Minuman manis dan creamy yang terbuat dari es krim coklat, susu dingin, dan sirup coklat. Sempurna untuk hari yang panas.',
  imageUrl: 'images/chocolate_milkshake.png',
  cookingTime: '5 menit',
  category: 'MilkShake', // <-- Disesuaikan dengan model baru
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
      appBar: AppBar(
        title: const Text('Milkshake', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          _buildRecipeCard(
            context: context,
            recipe: chocolateMilkshakeRecipe,
          ),
        ],
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
      child: Container(
        margin: const EdgeInsets.only(bottom: 24.0),
        decoration: BoxDecoration(
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
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    recipe.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined,
                          size: 18, 
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