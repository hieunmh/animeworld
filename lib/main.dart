// import 'package:animeworld/config/themes/app_theme.dart';
import 'package:animeworld/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}