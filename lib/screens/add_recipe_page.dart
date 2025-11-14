import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../db/database_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import '../constant/colors.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();
  final db = DatabaseHelper();

  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _ingredientsCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();

  XFile? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final photo = await picker.pickImage(source: ImageSource.gallery);

    if (photo != null) {
      setState(() => _image = photo);
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      if (_image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Foto resep tidak boleh kosong")),
        );
        return;
      }

      // 1. Dapatkan direktori permanen aplikasi
      final appDir = await getApplicationDocumentsDirectory();
      // Buat nama file unik menggunakan timestamp untuk menghindari penimpaan file
      final String fileExtension = path.extension(_image!.path);
      final String newFileName = '${DateTime.now().millisecondsSinceEpoch}$fileExtension';
      final String newPath = path.join(appDir.path, newFileName);
      final savedImage = await File(_image!.path).copy(newPath);

      // 2. Simpan path gambar yang sudah disalin ke database
      await db.addRecipe({
        'title': _titleCtrl.text,
        'ingredients': _ingredientsCtrl.text,
        'description': _descriptionCtrl.text,
        'imagePath': savedImage.path, // Gunakan path baru yang permanen
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Resep berhasil disimpan ✅")),
        );
        Navigator.pop(context, true); // Kirim nilai true untuk refresh
      }
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _ingredientsCtrl.dispose();
    _descriptionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Tambah Resep"),
        backgroundColor: AppColors.pinkPrimary,
        foregroundColor: AppColors.white,
        elevation: 1,
        shadowColor: AppColors.pinkDark.withOpacity(0.5),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // Upload photo
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.pinkLight.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _image == null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt_outlined, color: AppColors.pinkDark, size: 32),
                              SizedBox(height: 8),
                              Text("Upload Foto Resep", style: TextStyle(color: AppColors.pinkDark, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(_image!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // Title
              TextFormField(
                controller: _titleCtrl,
                decoration: InputDecoration(
                  labelText: "Judul Makanan",
                  filled: true,
                  fillColor: AppColors.pinkLight.withOpacity(.4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  floatingLabelStyle: const TextStyle(color: AppColors.black),
                ),
                validator: (v) =>
                    v!.isEmpty ? "Judul tidak boleh kosong" : null,
              ),
              const SizedBox(height: 16),
 
              // Ingredients
              TextFormField(
                controller: _ingredientsCtrl,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Alat & Bahan",
                  hintText: "Contoh:\n- 2 butir telur\n- 1 sdt garam\n- Minyak secukupnya",
                  filled: true,
                  fillColor: AppColors.pinkLight.withOpacity(.4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  floatingLabelStyle: const TextStyle(color: AppColors.black),
                ),
                validator: (v) =>
                    v!.isEmpty ? "Bahan tidak boleh kosong" : null,
              ),
              const SizedBox(height: 16),
 
              // Description
              TextFormField(
                controller: _descriptionCtrl,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Deskripsi / Langkah Memasak",
                  hintText: "1. Kocok telur...\n2. Panaskan wajan...",
                  filled: true,
                  fillColor: AppColors.pinkLight.withOpacity(.4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  floatingLabelStyle: const TextStyle(color: AppColors.black),
                ),
                validator: (v) =>
                    v!.isEmpty ? "Deskripsi tidak boleh kosong" : null,
              ),
              const SizedBox(height: 24),
 
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pinkPrimary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _submit,
                  child: const Text("Simpan Resep"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
