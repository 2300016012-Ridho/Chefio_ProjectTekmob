// lib/widgets/recipe_card.dart

import 'package:flutter/material.dart';
import 'package:chefio/models/recipe_model.dart';
import 'package:chefio/page/recipe_detail_page.dart';
import 'package:chefio/services/recipe_service.dart'; // <-- PENTING: TAMBAHKAN IMPORT INI

// 1. UBAH DARI StatelessWidget MENJADI StatefulWidget
class RecipeCard extends StatefulWidget {
  final Recipe recipe;

  const RecipeCard({Key? key, required this.recipe}) : super(key: key);

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  // --- LOGIKA BOOKMARK DITAMBAHKAN DI SINI ---
  bool _isBookmarked = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    if (!mounted || widget.recipe.id == null) return;
    
    // Kita tidak set isLoading di sini agar tidak ada lompatan UI
    try {
      final bookmarked = await RecipeService().isBookmarked(widget.recipe.id!);
      if (mounted) {
        setState(() {
          _isBookmarked = bookmarked;
          _isLoading = false; // Set loading selesai setelah status didapat
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleBookmark() async {
    // Tombol bookmarknya sendiri yang akan menangani state loading,
    // jadi kita tidak perlu setState untuk seluruh kartu
    if (_isLoading || widget.recipe.id == null) return;
    
    setState(() => _isLoading = true); // Tampilkan loading indicator di tombol

    try {
      if (_isBookmarked) {
        await RecipeService().removeBookmark(widget.recipe.id!);
      } else {
        await RecipeService().addBookmark(widget.recipe.id!);
      }
      if (mounted) {
        // Perbarui state setelah berhasil
        setState(() => _isBookmarked = !_isBookmarked);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false); // Sembunyikan loading
    }
  }
  // --- AKHIR DARI LOGIKA BOOKMARK ---

  @override
  Widget build(BuildContext context) {
    // Kode UI Anda sepenuhnya dipertahankan, hanya dengan satu perubahan kecil
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            // Gunakan widget.recipe karena kita sekarang di dalam State class
            builder: (context) => RecipeDetailPage(recipe: widget.recipe),
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
              child: Image.network(
                widget.recipe.imageUrl, // Gunakan widget.recipe
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 180,
                    color: Colors.grey.shade200,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image, color: Colors.grey, size: 40),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipe.title, // Gunakan widget.recipe
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.recipe.description, // Gunakan widget.recipe
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade500),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.access_time_outlined, size: 18, color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 8),
                      Text(widget.recipe.cookingTime, style: const TextStyle(fontWeight: FontWeight.w500)),
                      const Spacer(),
                      // --- TOMBOL BOOKMARK STATIS DIGANTI DENGAN YANG DINAMIS ---
                      _buildBookmarkButton(), // Memanggil tombol bookmark kita yang pintar
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

  // Widget helper untuk tombol bookmark, agar kode build tetap rapi
  Widget _buildBookmarkButton() {
    // Jika masih loading, tampilkan spinner
    if (_isLoading) {
      return const SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }
    // Jika tidak, tampilkan IconButton
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: Icon(
        _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        color: _isBookmarked ? Theme.of(context).colorScheme.primary : Colors.grey.shade500,
        size: 24,
      ),
      onPressed: _toggleBookmark,
    );
  }
}