import 'package:flutter/material.dart';
import 'package:chefio/models/recipe_model.dart';

class RecipeDetailPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailPage({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  bool _isShowingIngredients = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageAndTopBar(context),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipe.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.recipe.description,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  _buildCookingTime(),
                  const SizedBox(height: 24),
                  _buildToggleButtons(),
                  const SizedBox(height: 24),
                  _isShowingIngredients
                      ? _buildNumberedList(widget.recipe.ingredients)
                      : _buildNumberedList(widget.recipe.steps),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageAndTopBar(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          widget.recipe.imageUrl,
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            height: 300,
            color: Colors.grey.shade200,
            child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey, size: 60),
          ),
        ),
        Positioned(
          top: 50,
          left: 16,
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.8),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        Positioned(
          top: 50,
          right: 16,
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.8),
            child: IconButton(
              icon: const Icon(Icons.bookmark_border, color: Colors.black),
              onPressed: () { /* Aksi simpan resep */ },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCookingTime() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.access_time_outlined, color: Colors.grey, size: 20),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Cooking time', style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text(widget.recipe.cookingTime, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildToggleButtons() {
    const Color activeColor = Color(0xFFE91E63);
    const Color inactiveColor = Colors.white;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (!_isShowingIngredients) {
                setState(() => _isShowingIngredients = true);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _isShowingIngredients ? activeColor : inactiveColor,
              foregroundColor: _isShowingIngredients ? inactiveColor : activeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: activeColor),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              elevation: _isShowingIngredients ? 4 : 0,
            ),
            child: const Text('Ingredient', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (_isShowingIngredients) {
                setState(() => _isShowingIngredients = false);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: !_isShowingIngredients ? activeColor : inactiveColor,
              foregroundColor: !_isShowingIngredients ? inactiveColor : activeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: activeColor),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              elevation: !_isShowingIngredients ? 4 : 0,
            ),
            child: const Text('Steps', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildNumberedList(List<String> items) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: const Color(0xFFE91E63).withOpacity(0.1),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Color(0xFFE91E63),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(items[index], style: const TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}