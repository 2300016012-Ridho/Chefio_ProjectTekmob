// page/lunch_dinner_page.dart

import 'package:flutter/material.dart';
import 'package:chefio/models/recipe_model.dart';
import 'package:chefio/page/recipe_detail_page.dart';

final Recipe nasiGorengRecipe = Recipe(
  title: 'Nasi Goreng Teri Pete',
  description: 'Nasi goreng klasik Indonesia dengan rasa gurih dari teri dan pete, disajikan dengan telur mata sapi yang sempurna.',
  imageUrl: 'images/nasi_goreng_teri_pete.png',
  cookingTime: '20 menit',
  category: 'Lunch & Dinner', // <-- Disesuaikan dengan model baru
  ingredients: [
    '2 piring nasi putih',
    '3 sdm teri goreng',
    '1 papan pete, kupas dan belah dua',
    '2 butir telur',
    '2 siung bawang putih',
    '3 siung bawang merah',
    '2 cabai merah keriting',
    '2 cabai rawit (opsional)',
    '1 sdm kecap manis',
    '1 sdt garam & merica secukupnya',
    'Minyak goreng secukupnya',
  ],
  steps: [
    'Panaskan minyak, tumis bumbu halus (bawang dan cabai) hingga harum.',
    'Masukkan telur, orak-arik hingga matang.',
    'Tambahkan pete, aduk sebentar sampai layu.',
    'Masukkan teri goreng dan aduk rata.',
    'Masukkan nasi, aduk cepat dengan api besar hingga semua tercampur rata.',
    'Bumbui dengan kecap manis, garam, dan merica.',
    'Koreksi rasa, angkat dan sajikan selagi hangat.'
  ],
);

class LunchDinnerPage extends StatelessWidget {
  const LunchDinnerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lunch & Dinner', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          _buildRecipeCard(
            context: context,
            recipe: nasiGorengRecipe,
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