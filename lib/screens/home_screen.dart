import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'add_recipe_page.dart';
import '../constant/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Dummy data for carousels
    final List<Map<String, String>> trendingRecipes = [
      {"title": "Ayam Panggang Madu", "image": "https://www.mokapos.com/blog/_next/image?url=https%3A%2F%2Fwp.mokapos.com%2Fwp-content%2Fuploads%2F2023%2F02%2Finspirasi-foto-makanan-yang-enak-ayam-panggang.jpg&w=3840&q=75"},
      {"title": "Sate Ayam Khas Madura", "image": "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=3387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"},
      {"title": "Rendang Daging Sapi", "image": "https://images.unsplash.com/photo-1565557623262-b51c2513a641?q=80&w=3424&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"},
    ];

    final List<Map<String, String>> recentPosts = [
      {"title": "Nasi Goreng Seafood", "image": "https://images.unsplash.com/photo-1512058564366-18510be2db19?q=80&w=3540&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"},
      {"title": "Mie Ayam Bakso", "image": "https://images.unsplash.com/photo-1585032226651-759b368d7246?q=80&w=3387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"},
      {"title": "Gado-Gado Siram", "image": "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?q=80&w=3387&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"},
    ];

    // Build carousel items from data and add "See More" card
    final List<Widget> trendingCarouselItems = [
      ...trendingRecipes.map((recipe) => _buildCarouselItem(context, recipe['image']!, recipe['title']!)).toList(),
      _buildSeeMoreCard(context),
    ];

    final List<Widget> recentCarouselItems = [
      ...recentPosts.map((recipe) => _buildCarouselItem(context, recipe['image']!, recipe['title']!)).toList(),
      _buildSeeMoreCard(context),
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.pinkPrimary,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const AddRecipePage())),
        child: const Icon(Icons.edit_outlined, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.pinkLight.withValues(alpha: 0.6),
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
                  const Text("Resep Tranding", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 10),
                  CarouselSlider(
                    items: trendingCarouselItems,
                    options: CarouselOptions(
                      height: 150,
                      viewportFraction: 0.8,
                      enableInfiniteScroll: false,
                      padEnds: false,
                    ),
                  ),
              
                  const SizedBox(height: 16),
                  const Text("Upload Terbaru", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 10),
                  CarouselSlider(
                    items: recentCarouselItems,
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

  Widget _buildCarouselItem(BuildContext context, String imageUrl, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(imageUrl, fit: BoxFit.cover),
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
    );
  }

  Widget _buildSeeMoreCard(BuildContext context) {
    return GestureDetector(
      onTap: () { /* TODO: Navigate to see more page */ },
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
