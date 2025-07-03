// lib/page/breakfast_page.dart

import 'package:flutter/material.dart';
import 'package:chefio/models/recipe_model.dart';
import 'package:chefio/services/recipe_service.dart';
import 'package:chefio/widgets/recipe_card.dart';

class BreakfastPage extends StatefulWidget {
  const BreakfastPage({Key? key}) : super(key: key);

  @override
  State<BreakfastPage> createState() => _BreakfastPageState();
}

class _BreakfastPageState extends State<BreakfastPage> {
  late Future<List<Recipe>> _breakfastRecipesFuture;

  @override
  void initState() {
    super.initState();
    // Panggil service untuk mengambil resep saat halaman dibuka
    _breakfastRecipesFuture = RecipeService().getRecipesByCategory('Breakfast');
  }

  // Method untuk refresh data
  Future<void> _refreshData() async {
    setState(() {
      _breakfastRecipesFuture = RecipeService().getRecipesByCategory('Breakfast');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breakfast', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      // Gunakan RefreshIndicator untuk pull-to-refresh
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<List<Recipe>>(
          future: _breakfastRecipesFuture,
          builder: (context, snapshot) {
            // State saat data sedang dimuat
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            // State jika terjadi error
            if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error: ${snapshot.error}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _refreshData,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }
            // State jika tidak ada data atau data kosong
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.breakfast_dining_outlined, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('No Breakfast recipes found.'),
                    SizedBox(height: 8),
                    Text('Pull to refresh or add a new recipe!'),
                  ],
                ),
              );
            }

            // State jika data berhasil didapat
            final recipes = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(24.0),
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return RecipeCard(recipe: recipe);
              },
            );
          },
        ),
      ),
    );
  }
}