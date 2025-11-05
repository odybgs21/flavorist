import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();

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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO: Simpan ke database / API
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Resep berhasil disimpan ✅")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Resep"),
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
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                  ),
                  child: _image == null
                      ? const Center(
                          child: Text("Upload Foto Resep 📷"),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          // child: Image.file(
                          //   File(_image!.path),
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // Title
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(
                  labelText: "Judul Makanan",
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    v!.isEmpty ? "Judul tidak boleh kosong" : null,
              ),
              const SizedBox(height: 16),

              // Ingredients
              TextFormField(
                controller: _ingredientsCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Alat & Bahan",
                  border: OutlineInputBorder(),
                  hintText: "Contoh:\n- 2 butir telur\n- 1 sdt garam\n- Minyak secukupnya",
                ),
                validator: (v) =>
                    v!.isEmpty ? "Bahan tidak boleh kosong" : null,
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionCtrl,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Deskripsi / Langkah Memasak",
                  border: OutlineInputBorder(),
                  hintText: "1. Kocok telur...\n2. Panaskan wajan...",
                ),
                validator: (v) =>
                    v!.isEmpty ? "Deskripsi tidak boleh kosong" : null,
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: _submit,
                child: const Text("Simpan Resep"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
