// lib/models/recipe_model.dart

class Recipe {
  final String title;
  final String description;
  final String imageUrl;
  final String cookingTime;
  final List<String> ingredients;
  final List<String> steps;

  Recipe({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.cookingTime,
    required this.ingredients,
    required this.steps,
  });
}