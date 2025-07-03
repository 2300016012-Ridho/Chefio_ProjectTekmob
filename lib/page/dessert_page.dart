// page/dessert_page.dart

import 'package:flutter/material.dart';
import 'package:chefio/models/recipe_model.dart';
import 'package:chefio/page/recipe_detail_page.dart';

final Recipe chocoLavaCakeRecipe = Recipe(
  title: 'Chocolate Lava Cake',
  description: 'Dessert lembut dengan bagian luar kue yang matang sempurna dan bagian dalam yang masih lumer seperti lava cokelat panas.',
  imageUrl: 'images/lava_cake.png',
  cookingTime: '20 menit',
  category: 'Dessert', // <-- Disesuaikan dengan model baru
  ingredients: [
    '100gr dark chocolate',
    '100gr butter',
    '2 butir telur utuh',
    '2 kuning telur',
    '50gr gula halus',
    '1/2 sdt vanila ekstrak (opsional)',
    '30gr tepung terigu (ayak)',
    'Margarin dan sedikit tepung untuk melapisi cetakan'
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
      appBar: AppBar(
        title: const Text('Dessert', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          _buildRecipeCard(
            context: context,
            recipe: chocoLavaCakeRecipe,
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