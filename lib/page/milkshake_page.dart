import 'package:flutter/material.dart';
import 'package:chefio/models/recipe_model.dart';
import 'package:chefio/services/recipe_service.dart';
import 'package:chefio/widgets/recipe_card.dart';

class MilkshakePage extends StatefulWidget {
  const MilkshakePage({Key? key}) : super(key: key);

  @override
  State<MilkshakePage> createState() => _MilkshakePageState();
}

class _MilkshakePageState extends State<MilkshakePage> {
  late Future<List<Recipe>> _milkshakeRecipesFuture;

  @override
  void initState() {
    super.initState();
    _milkshakeRecipesFuture = RecipeService().getRecipesByCategory('MilkShake');
  }

  Future<void> _refreshData() async {
    setState(() {
      _milkshakeRecipesFuture = RecipeService().getRecipesByCategory('MilkShake');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MilkShake', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<List<Recipe>>(
          future: _milkshakeRecipesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
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
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_drink_outlined, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('No MilkShake recipes found.'),
                    SizedBox(height: 8),
                    Text('Pull to refresh or add a new recipe!'),
                  ],
                ),
              );
            }

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