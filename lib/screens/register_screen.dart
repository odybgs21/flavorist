import 'package:flutter/material.dart';
import 'package:flavorist/constant/colors.dart';
import '../db/database_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final confirmPassC = TextEditingController();
  final db = DatabaseHelper();

  register() async {
    // Validasi password match
    if (passC.text != confirmPassC.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password tidak cocok"))
      );
      return;
    }

    try {
      await db.register(emailC.text, passC.text);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registrasi berhasil! Silakan login"))
      );
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email sudah terdaftar"))
      );
    }
  }

  @override
  void dispose() {
    emailC.dispose();
    passC.dispose();
    confirmPassC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.pinkPrimary,
              AppColors.pinkLight,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.white.withOpacity(.85),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.pinkDark.withOpacity(.3),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Column(
                children: [
                  // Back button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: AppColors.pinkDark),
                    ),
                  ),
                  
                  Text(
                    "Daftar Akun Baru 🎉",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.pinkDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Buat akun untuk memulai",
                    style: TextStyle(color: AppColors.grey),
                  ),
                  const SizedBox(height: 24),

                  // Email field
                  TextField(
                    controller: emailC,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.pinkLight.withOpacity(.4),
                      labelText: "Email",
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelStyle: TextStyle(color: AppColors.black),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Password field
                  TextField(
                    controller: passC,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.pinkLight.withOpacity(.4),
                      labelText: "Password",
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelStyle: TextStyle(color: AppColors.black),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Confirm Password field
                  TextField(
                    controller: confirmPassC,
                    obscureText: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.pinkLight.withOpacity(.4),
                      labelText: "Konfirmasi Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      floatingLabelStyle: TextStyle(color: AppColors.black),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Register button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Daftar",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Login link
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Sudah punya akun? Masuk disini",
                      style: TextStyle(color: AppColors.pinkDark),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}