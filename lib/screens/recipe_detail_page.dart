import 'package:flutter/material.dart';
import 'dart:io';
import 'package:share_plus/share_plus.dart';
import '../constant/colors.dart';

class RecipeDetailPage extends StatelessWidget {
  final String title;
  final String ingredients;
  final String description;
  final String? imagePath;

  const RecipeDetailPage({
    super.key,
    required this.title,
    required this.ingredients,
    required this.description,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar dengan gambar banner
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.pinkDark),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                // child: IconButton(
                //   icon: const Icon(
                //     Icons.favorite_border,
                //     color: AppColors.pinkPrimary,
                //   ),
                //   onPressed: () {
                //     // TODO: Tambah ke favorit
                //   },
                // ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Banner Image
                  imagePath != null && imagePath!.isNotEmpty
                      ? Image.file(
                          File(imagePath!),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildPlaceholderImage();
                          },
                        )
                      : _buildPlaceholderImage(),
                  // Gradient overlay
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul Resep
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.pinkDark,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Info tambahan
                    Row(
                      children: [
                        _buildInfoChip(Icons.access_time, "30 min"),
                        const SizedBox(width: 12),
                        _buildInfoChip(Icons.local_fire_department, "Medium"),
                        const SizedBox(width: 12),
                        _buildInfoChip(Icons.person, "2-3 porsi"),
                      ],
                    ),

                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),

                    // Alat & Bahan
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.pinkLight.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.shopping_basket,
                            color: AppColors.pinkDark,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Alat & Bahan",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.pinkDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.pinkLight.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.pinkLight.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        ingredients,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.black,
                          height: 1.6,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Langkah Memasak
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.pinkLight.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.restaurant_menu,
                            color: AppColors.pinkDark,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          "Langkah Memasak",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.pinkDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.pinkLight.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.pinkLight.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        description,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColors.black,
                          height: 1.6,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Tombol Action
                    Row(
                      children: [
//                         Expanded(
//                           child: ElevatedButton.icon(
//                             onPressed: () async {
//                               final recipeText = """
// *${title}*

// *Bahan-bahan:*
// ${ingredients}

// *Langkah Memasak:*
// ${description}
// """;
//                               await Share.share(recipeText, subject: 'Coba resep ini: $title');
//                             },
//                             icon: const Icon(Icons.share, color: Colors.white),
//                             label: const Text(
//                               "Bagikan",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.pinkPrimary,
//                               padding: const EdgeInsets.symmetric(vertical: 14),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                             ),
//                           ),
//                         ),
                        const SizedBox(width: 12),
                        // Expanded(
                        //   child: OutlinedButton.icon(
                        //     onPressed: () {
                        //       // TODO: Edit recipe
                        //       ScaffoldMessenger.of(context).showSnackBar(
                        //         const SnackBar(content: Text("Edit resep")),
                        //       );
                        //     },
                        //     icon: const Icon(
                        //       Icons.edit,
                        //       color: AppColors.pinkDark,
                        //     ),
                        //     label: const Text(
                        //       "Edit",
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         color: AppColors.pinkDark,
                        //       ),
                        //     ),
                        //     style: OutlinedButton.styleFrom(
                        //       padding: const EdgeInsets.symmetric(vertical: 14),
                        //       side: const BorderSide(
                        //         color: AppColors.pinkPrimary,
                        //         width: 2,
                        //       ),
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(12),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: AppColors.pinkLight.withOpacity(0.3),
      child: const Center(
        child: Icon(Icons.restaurant, size: 80, color: AppColors.pinkPrimary),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.pinkLight.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.pinkLight.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.pinkDark),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.pinkDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
