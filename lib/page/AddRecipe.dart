import 'package:flutter/material.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _timeController = TextEditingController();

  List<TextEditingController> _introductionControllers = [];
  List<TextEditingController> _ingredientControllers = [];  // List untuk ingredients

  @override
  void initState() {
    super.initState();
    _addIntroductionStep();
    _addIngredientStep(); // Menambahkan step untuk ingredients
  }

  // Fungsi untuk menambah step introduction
  void _addIntroductionStep() {
    setState(() {
      _introductionControllers.add(TextEditingController());
    });
  }

  // Fungsi untuk menghapus step introduction
  void _removeIntroductionStep(int index) {
    _introductionControllers[index].dispose();
    setState(() {
      _introductionControllers.removeAt(index);
    });
  }

  // Fungsi untuk menambah step ingredient
  void _addIngredientStep() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  // Fungsi untuk menghapus step ingredient
  void _removeIngredientStep(int index) {
    _ingredientControllers[index].dispose();
    setState(() {
      _ingredientControllers.removeAt(index);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _timeController.dispose();
    for (var controller in _introductionControllers) {
      controller.dispose();
    }
    for (var controller in _ingredientControllers) {
      controller.dispose();
    }
    super.dispose();
  }

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
        title: const Text(
          'ADD OWN RECIPE',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              label: 'Title',
              hintText: 'Give your recipe a name',
              controller: _titleController,
            ),
            const SizedBox(height: 24),
            _buildTextField(
              label: 'Description',
              hintText: 'Introduce a short description for your recipe',
              controller: _descriptionController,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            
            const Text(
              'Ingredients',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Ingredient input fields
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _ingredientControllers.length,
              itemBuilder: (context, index) {
                return _buildIngredientStep(index);
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: _addIngredientStep,
                child: const Text('Add Ingredient'),
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'Introduction',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Introduction input fields
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _introductionControllers.length,
              itemBuilder: (context, index) {
                return _buildIntroductionStep(index);
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: _addIntroductionStep,
                child: const Text('Add Step'),
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: 'Time',
              hintText: 'Enter Time',
              controller: _timeController,
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print('Recipe saved!');
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save Recipe',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membuat text input dengan label
  Widget _buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade500),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  // Widget untuk membuat input step introduction
  Widget _buildIntroductionStep(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Text(
              '${index + 1}',
              style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _introductionControllers[index],
              decoration: InputDecoration(
                hintText: 'Add step ${index + 1}',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.grey.shade600),
            onPressed: () => _removeIntroductionStep(index),
          ),
        ],
      ),
    );
  }

  // Widget untuk membuat input ingredient
  Widget _buildIngredientStep(int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: Text(
              '${index + 1}',
              style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: _ingredientControllers[index],
              decoration: InputDecoration(
                hintText: 'Add ingredient ${index + 1}',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.delete_outline, color: Colors.grey.shade600),
            onPressed: () => _removeIngredientStep(index),
          ),
        ],
      ),
    );
  }
}