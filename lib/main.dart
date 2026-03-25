import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/navigation_container.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'providers/preferiti_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(
    ChangeNotifierProvider(
      create: (_) => PreferitiProvider()..carica(),
      child: const SorsiApp(),
    ),
  );
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
