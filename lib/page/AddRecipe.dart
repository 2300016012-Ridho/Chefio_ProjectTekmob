import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  File? _image;
  int _servingCount = 2;
  int _timeInMinutes = 0;
  String? _selectedCategory;

  List<TextEditingController> _ingredientControllers = [TextEditingController()];
  List<TextEditingController> _introductionControllers = [TextEditingController()];

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    for (var controller in _ingredientControllers) controller.dispose();
    for (var controller in _introductionControllers) controller.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => _image = File(pickedFile.path));
    }
  }

  void _addStep(List<TextEditingController> controllers) {
    setState(() => controllers.add(TextEditingController()));
  }

  void _removeStep(List<TextEditingController> controllers, int index) {
    controllers[index].dispose();
    setState(() => controllers.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Recipe', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Title'),
            _buildTextField(controller: _titleController, hintText: 'Give your recipe a name'),
            const SizedBox(height: 24),
            
            _buildSectionTitle('Picture'),
            _buildImagePicker(),
            const SizedBox(height: 24),
            
            _buildSectionTitle('Description'),
            _buildTextField(controller: _descriptionController, hintText: 'A short & sweet description', maxLines: 3),
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
            _buildDynamicList(_ingredientControllers, 'Add ingredient', () => _addStep(_ingredientControllers), (i) => _removeStep(_ingredientControllers, i)),
            const SizedBox(height: 24),
            
            _buildSectionTitle('Steps'),
            _buildDynamicList(_introductionControllers, 'Add step', () => _addStep(_introductionControllers), (i) => _removeStep(_introductionControllers, i)),
            const SizedBox(height: 24),

            _buildSectionTitle('Select a Category'),
            _buildCategorySelector(),
            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                // TODO: Implement save logic here
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Save My Recipe', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextField({required TextEditingController controller, required String hintText, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Theme.of(context).cardColor,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: _image != null
            ? ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.file(_image!, fit: BoxFit.cover))
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_camera_back_outlined, color: Colors.grey.shade400, size: 40),
                    const SizedBox(height: 8),
                    Text("Add a cover picture", style: TextStyle(color: Colors.grey.shade500)),
                  ],
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
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [
              _buildCounterButton(Icons.remove, () { if (value > minValue) onChanged(value - 1); }),
              Expanded(child: Text('$value ${unit ?? ''}'.trim(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
              _buildCounterButton(Icons.add, () => onChanged(value + 1)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCounterButton(IconData icon, VoidCallback onPressed) {
    return IconButton(icon: Icon(icon, size: 20), onPressed: onPressed, color: Theme.of(context).colorScheme.primary);
  }

  Widget _buildDynamicList(List<TextEditingController> controllers, String hintText, VoidCallback onAdd, ValueChanged<int> onRemove) {
    return Column(
      children: [
        ...List.generate(controllers.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              children: [
                Text('${index + 1}.', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey)),
                const SizedBox(width: 12),
                Expanded(child: _buildTextField(controller: controllers[index], hintText: '$hintText ${index + 1}')),
                IconButton(icon: const Icon(Icons.delete_outline, color: Colors.grey), onPressed: () => onRemove(index)),
              ],
            ),
          );
        }),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add),
            label: const Text('Add More'),
            style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySelector() {
    final categories = ['Breakfast', 'MilkShake', 'Lunch & Dinner', 'Dessert'];
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: categories.map((category) {
          return RadioListTile<String>(
            title: Text(category),
            value: category,
            groupValue: _selectedCategory,
            onChanged: (value) => setState(() => _selectedCategory = value),
            activeColor: Theme.of(context).colorScheme.primary,
            contentPadding: EdgeInsets.zero,
          );
        }).toList(),
      ),
    );
  }
}