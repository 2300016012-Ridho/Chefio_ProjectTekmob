// lib/services/recipe_service.dart

import 'dart:io';
import 'package:chefio/models/recipe_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RecipeService {
  final _supabase = Supabase.instance.client;

  // Mengambil resep berdasarkan kategori
  Future<List<Recipe>> getRecipesByCategory(String category) async {
    try {
      print('Fetching recipes for category: $category'); // Debug log
      
      final response = await _supabase
          .from('recipes')
          .select()
          .eq('category', category)
          .order('created_at', ascending: false);

      print('Response data: $response'); // Debug log

      // Konversi List<dynamic> ke List<Recipe>
      final recipes = (response as List)
          .map((data) => Recipe.fromJson(data))
          .toList();
      
      print('Parsed recipes count: ${recipes.length}'); // Debug log
      
      return recipes;
    } catch (e) {
      print('Error fetching recipes: $e');
      rethrow; // Lempar kembali error untuk ditangani di UI
    }
  }

  // Mengambil semua resep (untuk debugging)
  Future<List<Recipe>> getAllRecipes() async {
    try {
      final response = await _supabase
          .from('recipes')
          .select()
          .order('created_at', ascending: false);

      final recipes = (response as List)
          .map((data) => Recipe.fromJson(data))
          .toList();
      
      return recipes;
    } catch (e) {
      print('Error fetching all recipes: $e');
      return [];
    }
  }

  // Menambah resep baru
  Future<void> addRecipe({
    required Recipe recipe,
    required File imageFile,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      throw Exception('User must be logged in to add a recipe.');
    }

    try {
      // 1. Unggah gambar ke Supabase Storage
      final imagePath = '${user.id}/${DateTime.now().millisecondsSinceEpoch}.jpg';
      
      print('Uploading image to path: $imagePath'); // Debug log
      
      await _supabase.storage.from('recipeimages').upload(
            imagePath,
            imageFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
          );

      // 2. Dapatkan URL publik dari gambar yang baru diunggah
      final imageUrl = _supabase.storage.from('recipeimages').getPublicUrl(imagePath);
      
      print('Image URL: $imageUrl'); // Debug log

      // 3. Siapkan data untuk dimasukkan ke tabel 'recipes'
      final recipeData = {
        'user_id': user.id,
        'title': recipe.title,
        'description': recipe.description,
        'image_url': imageUrl,
        'cooking_time': recipe.cookingTime,
        'ingredients': recipe.ingredients,
        'steps': recipe.steps,
        'category': recipe.category,
        'created_at': DateTime.now().toIso8601String(),
      };

      print('Inserting recipe data: $recipeData'); // Debug log

      // 4. Masukkan data ke tabel
      final result = await _supabase.from('recipes').insert(recipeData).select();
      
      print('Insert result: $result'); // Debug log
      
    } catch (e) {
      print('Error adding recipe: $e');
      throw Exception('Failed to add recipe. Please try again.');
    }
  }
}