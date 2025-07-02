import 'package:flutter/material.dart';
import '../models/regione.dart';
import '../service/regione_service.dart';
import 'regione_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Regione> _regioni = [];
  bool _caricamento = true;
  bool _errore = false;

  @override
  void initState() {
    super.initState();
    _caricaDati();
  }

  Future<void> _caricaDati() async {
    try {
      final dati = await caricaRegioni();
      setState(() {
        _regioni = dati;
        _caricamento = false;
      });
    } catch (e) {
      setState(() {
        _errore = true;
        _caricamento = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_caricamento) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_errore) {
      return const Scaffold(
        body: Center(
          child: Text("Errore nel caricamento dei dati."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7B1E3A),
        foregroundColor: Colors.white,
        title: const Text(
          "Sorsi d’Italia",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _regioni.length,
        itemBuilder: (context, index) {
          final regione = _regioni[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 2,
            shadowColor: Colors.black,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              title: Text(
                regione.nome,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF7B1E3A),
                ),
              ),
              trailing: const Icon(
                Icons.chevron_right,
                color: Color(0xFF7B1E3A),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        RegionePage(regione: regione),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
