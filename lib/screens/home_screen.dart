import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'add_recipe_page.dart';
import '../constant/colors.dart';
import 'all_recipes_screen.dart';
import '../db/database_helper.dart';
import 'recipe_detail_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final db = DatabaseHelper();
  List<Map<String, dynamic>> _recipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final recipes = await db.getRecipes();
    setState(() {
      _recipes = recipes;
    });
  }

  void _navigateAndRefresh() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddRecipePage()),
    );

    if (result == true) {
      _loadRecipes();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build carousel items from data and add "See More" card
    final List<Widget> trendingCarouselItems = [
      ..._recipes.take(5).map((recipe) => _buildCarouselItem(context, recipe)).toList(),
      _buildSeeMoreCard(context),
    ];

    final List<Widget> recentCarouselItems = [
      ..._recipes.take(3).map((recipe) => _buildCarouselItem(context, recipe)).toList(),
      _buildSeeMoreCard(context),
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.pinkPrimary,
        onPressed: _navigateAndRefresh,
        child: const Icon(Icons.edit_outlined, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.pinkLight.withOpacity(0.6),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Image.asset(  
                'assets/images/banner_fix.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300, 
              ),
            ),
            const SizedBox(height: 16),
            Container(
            padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text("Resep Tranding", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  // const SizedBox(height: 10), 
                  // _recipes.isEmpty
                  //     ? const Center(child: Text("Belum ada resep tranding."))
                  //     : CarouselSlider(
                  //         items: trendingCarouselItems,
                  //         options: CarouselOptions(
                  //           height: 150,
                  //           viewportFraction: 0.8,
                  //           enableInfiniteScroll: false,
                  //           padEnds: false,
                  //         ),
                  //       ),
              
                  const SizedBox(height: 16),
                  const Text("Upload Terbaru", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 10),
                  _recipes.isEmpty
                      ? const Center(child: Text("Belum ada resep yang diupload."))
                      : CarouselSlider(
                    items: recentCarouselItems, // Menggunakan data yang sama untuk contoh
                    options: CarouselOptions(
                      height: 150,
                      viewportFraction: 0.8,
                      enableInfiniteScroll: false,
                      padEnds: false,
                    ),
                  ),
              
                  const SizedBox(height: 16),
                  const Text("Artikel & Tips", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 10),
                  // Using Column for a fixed list of articles
                  Column(
                    children: [
                      _buildArticleCard(
                        "https://images.unsplash.com/photo-1543353071-873f17a7a088?q=80&w=3540&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        "5 Tips Memasak Daging Sapi Agar Empuk",
                        "Daging sapi yang empuk adalah kunci kenikmatan masakan. Berikut tipsnya...",
                      ),
                      _buildArticleCard(
                        "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=3387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        "Cara Memilih Wajan Anti Lengket Terbaik",
                        "Jangan salah pilih, wajan yang tepat akan membuat pengalaman memasak lebih menyenangkan.",
                      ),
                      _buildArticleCard(
                        "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=3387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                        "Mengenal Bumbu Dapur Dasar untuk Pemula",
                        "Untuk kamu yang baru mulai belajar memasak, yuk kenali bumbu-bumbu ini!",
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _buildCarouselItem(BuildContext context, Map<String, dynamic> recipe) {
    final String imageUrl = recipe['imagePath'];
    final String title = recipe['title'];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RecipeDetailPage(
              title: recipe['title'],
              ingredients: recipe['ingredients'],
              description: recipe['description'],
              imagePath: recipe['imagePath'],
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.file(File(imageUrl), fit: BoxFit.cover),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                right: 10,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    shadows: [Shadow(blurRadius: 2.0, color: Colors.black54)],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeeMoreCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const AllRecipesScreen()),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          color: AppColors.pinkLight.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Lihat\nSelengkapnya", textAlign: TextAlign.center, style: TextStyle(color: AppColors.pinkDark, fontWeight: FontWeight.bold)),
              Icon(Icons.arrow_forward_rounded, color: AppColors.pinkDark),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticleCard(String imageUrl, String title, String description) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            imageUrl,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
        subtitle: Text(description, style: const TextStyle(color: AppColors.grey)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.grey),
        onTap: () { /* TODO: Navigate to article detail */ },
      ),
    );
  }
}
