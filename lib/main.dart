import 'package:flutter/material.dart';
import 'screens/navigation_container';

void main() {
  runApp(const SorsiApp());
}

class SorsiApp extends StatelessWidget {
  const SorsiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sorsi d’Italia',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF8F2),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF7B1E3A),
          brightness: Brightness.light,
        ),
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(fontSize: 16),
        ),
      ),
      home: const MainScaffold(),
      debugShowCheckedModeBanner: false,
    );
  }
}
