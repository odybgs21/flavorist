import 'package:flavorist/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Flavorist();
  }
}

class Flavorist extends StatefulWidget {
  const Flavorist({super.key});

  @override
  State<Flavorist> createState() => _FlavoristState();
}

class _FlavoristState extends State<Flavorist> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const LoginScreen(),
      // home: const HomeScreen(),
    );
  }
}
