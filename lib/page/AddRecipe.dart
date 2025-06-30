import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  // Controllers for text fields
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  // State for new features
  File? _image;
  int _servingCount = 2;
  int _timeInMinutes = 0;
  String? _selectedCategory;

  // For dynamic ingredient and instruction fields
  List<TextEditingController> _ingredientControllers = [];
  List<TextEditingController> _introductionControllers = [];

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Add one initial step for both lists
    _addIngredientStep();
    _addIntroductionStep();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    for (var controller in _ingredientControllers) {
      controller.dispose();
    }
    for (var controller in _introductionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // --- LOGIC FUNCTIONS ---

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _addIngredientStep() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  void _removeIngredientStep(int index) {
    _ingredientControllers[index].dispose();
    setState(() {
      _ingredientControllers.removeAt(index);
    });
  }

  void _addIntroductionStep() {
    setState(() {
      _introductionControllers.add(TextEditingController());
    });
  }

  void _removeIntroductionStep(int index) {
    _introductionControllers[index].dispose();
    setState(() {
      _introductionControllers.removeAt(index);
    });
  }


  // --- UI BUILDER WIDGETS ---

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFE91E63);

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
          'ADD RECIPE',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Title'),
            _buildTextField(
              controller: _titleController,
              hintText: 'Give your recipe a name',
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Picture'),
            _buildImagePicker(),
            const SizedBox(height: 24),
            
            _buildSectionTitle('Description'),
            _buildTextField(
              controller: _descriptionController,
              hintText: 'Introduce a short description for your recipe',
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(child: _buildCounter('Serving', _servingCount, (val) => setState(() => _servingCount = val), 1)),
                const SizedBox(width: 20),
                Expanded(child: _buildCounter('Time', _timeInMinutes, (val) => setState(() => _timeInMinutes = val), 0, unit: 'minutes')),
              ],
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('Ingredients'),
            _buildDynamicList(_ingredientControllers, 'Add ingredient', _addIngredientStep, _removeIngredientStep),
            const SizedBox(height: 24),

            _buildSectionTitle('Introduction'),
            _buildDynamicList(_introductionControllers, 'Add step', _addIntroductionStep, _removeIntroductionStep),
            const SizedBox(height: 24),

            _buildSectionTitle('Select a Category'),
            _buildCategorySelector(),
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement save logic here
                  print('Recipe Saved!');
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String hintText, int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFE91E63)),
        ),
      ),
    );
  }
  
  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: _image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(11),
                child: Image.file(_image!, fit: BoxFit.cover),
              )
            : Center(
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Icon(Icons.add, color: Colors.grey.shade600, size: 30),
                ),
              ),
      ),
    );
  }

  Widget _buildCounter(String label, int value, ValueChanged<int> onChanged, int minValue, {String? unit}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(label),
        Row(
          children: [
            _buildCounterButton(Icons.remove, () {
              if (value > minValue) onChanged(value - 1);
            }),
            Expanded(
              child: Text(
                '$value ${unit ?? ''}'.trim(),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            _buildCounterButton(Icons.add, () => onChanged(value + 1)),
          ],
        ),
      ],
    );
  }

  Widget _buildCounterButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(icon, size: 20),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildDynamicList(
    List<TextEditingController> controllers,
    String hintText,
    VoidCallback onAdd,
    ValueChanged<int> onRemove,
  ) {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controllers.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  Text(
                    '${index + 1}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildTextField(
                      controller: controllers[index],
                      hintText: '$hintText ${index + 1}',
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.grey.shade600),
                    onPressed: () => onRemove(index),
                  )
                ],
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: onAdd,
            child: const Text('Add More', style: TextStyle(color: Color(0xFFE91E63))),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelector() {
    final categories = ['Breakfast', 'MilkShake', 'Lunch & Dinner', 'Dessert'];
    return Column(
      children: categories.map((category) {
        return RadioListTile<String>(
          title: Text(category),
          value: category,
          groupValue: _selectedCategory,
          onChanged: (value) {
            setState(() {
              _selectedCategory = value;
            });
          },
          activeColor: const Color(0xFFE91E63),
          contentPadding: EdgeInsets.zero,
        );
      }).toList(),
    );
  }
}