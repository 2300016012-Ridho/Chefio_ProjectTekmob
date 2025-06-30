import 'package:flutter/material.dart';
import 'package:chefio/page/profilepage.dart';

// Tidak ada perubahan di sini
class HomePage extends StatefulWidget {
  final int initialIndex;

  const HomePage({
    Key? key,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

// Tidak ada perubahan di sini
class _HomePageState extends State<HomePage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> get _widgetOptions => <Widget>[
        const HomeContent(),
        const Center(
          child: Text('Halaman Bookmark',
              style: TextStyle(fontSize: 24, fontFamily: 'Poppins')),
        ),
        ProfilePage(onGoToHome: () => _onItemTapped(0)),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1.0)),
      ),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline),
              activeIcon: Icon(Icons.bookmark),
              label: 'Bookmark'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey.shade600,
        onTap: _onItemTapped,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle:
            const TextStyle(fontFamily: 'Poppins', fontSize: 12),
        unselectedLabelStyle:
            const TextStyle(fontFamily: 'Poppins', fontSize: 12),
      ),
    );
  }
}

// Tidak ada perubahan di sini
class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        title: SizedBox(
          height: 50,
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Masak apa hari ini?',
              hintStyle:
                  const TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
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
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'images/home_preview.png',
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Icon(Icons.image_not_supported,
                          size: 50, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text(
                'Pilih Kategori',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildCategoryGrid(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }


  Widget _buildCategoryGrid(BuildContext context) {
    final categories = [
      {'title': 'Breakfast', 'imagePath': 'images/breakfast.png', 'route': '/breakfast'},
      {'title': 'Milkshake', 'imagePath': 'images/milkshake.png', 'route': '/milkshake'},
      // Untuk kategori yang belum siap, kita bisa hapus rutenya atau biarkan null
      {'title': 'Lunch & Dinner', 'imagePath': 'images/lunch_dinner.png', 'route': '/lunch'},
      // Mengubah 'route' dari null menjadi '/dessert'
      {'title': 'Dessert', 'imagePath': 'images/dessert.png', 'route': '/dessert'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.0,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        final route = category['route'];

        return CategoryCard(
          title: category['title']!,
          imagePath: category['imagePath']!,
          onTap: () {
            if (route != null) {
              Navigator.pushNamed(context, route);
            } else {
              print("Navigasi ke ${category['title']} belum diimplementasikan.");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${category['title']} page is under construction."))
              );
            }
          },
        );
      },
    );
  }
}


// Tidak ada perubahan di sini
class CategoryCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const CategoryCard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.07),
              blurRadius: 15,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Center(
                          child: Icon(Icons.broken_image, color: Colors.grey)),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}