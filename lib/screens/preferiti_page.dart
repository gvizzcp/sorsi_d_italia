import 'package:flutter/material.dart';
import '../models/locale.dart';
import '../service/preferiti_service.dart';

class PreferitiPage extends StatefulWidget {
  const PreferitiPage({super.key});

  @override
  State<PreferitiPage> createState() =>
      _PreferitiPageState();
}

class _PreferitiPageState extends State<PreferitiPage> {
  final _service = PreferitiService();
  List<LocaleVino> _preferiti = [];

  @override
  void initState() {
    super.initState();
    _carica();
  }

  Future<void> _carica() async {
    final dati = await _service.caricaPreferiti();
    setState(() {
      _preferiti = dati;
    });
  }

  Future<void> _rimuovi(LocaleVino locale) async {
    setState(() {
      _preferiti.removeWhere((l) => l.nome == locale.nome);
    });
    await _service.salvaPreferiti(_preferiti);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preferiti"),
        backgroundColor: const Color(0xFF7B1E3A),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: _preferiti.isEmpty
          ? const Center(
              child: Text("Nessun locale preferito."),
            )
          : ListView.builder(
              itemCount: _preferiti.length,
              itemBuilder: (context, index) {
                final locale = _preferiti[index];
                return ListTile(
                  leading: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  title: Text(locale.nome),
                  subtitle: Text(locale.indirizzo),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _rimuovi(locale),
                  ),
                );
              },
            ),
    );
  }
}
