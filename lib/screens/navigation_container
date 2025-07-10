import 'package:flutter/material.dart';
import 'home_page.dart';
import 'mappa_page.dart';
import 'preferiti_page.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _paginaCorrente = 0;

  final List<Widget> _pagine = [
    HomePage(),
    MappaPage(),
    PreferitiPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pagine[_paginaCorrente],
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: _paginaCorrente,
      onTap: (index) => setState(() => _paginaCorrente = index),
      backgroundColor: const Color(0xFF7B1E3A),
  selectedItemColor: Colors.white,
  unselectedItemColor: Colors.white,
  
  selectedFontSize: 14,
  unselectedFontSize: 13,
  type: BottomNavigationBarType.fixed,
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.wine_bar),
      label: 'Vini',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.map),
      label: 'Enoteche',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Preferiti',
    ),
  ],
),

    );
  }
}
