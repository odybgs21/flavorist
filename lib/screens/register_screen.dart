import 'package:flutter/material.dart';
import '../db/database_helper.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final emailC = TextEditingController();
    final passC = TextEditingController();
    final db = DatabaseHelper();

    register() async {
      try {
        await db.register(emailC.text, passC.text);
        Navigator.pop(context);
      } catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email sudah terdaftar"))
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text("Daftar")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(controller: emailC, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: passC, obscureText: true, decoration: InputDecoration(labelText: "Password")),
            SizedBox(height: 20),
            ElevatedButton(onPressed: register, child: Text("Daftar"))
          ],
        ),
      ),
    );
  }
}
