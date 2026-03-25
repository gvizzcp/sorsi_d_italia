import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/preferiti_provider.dart';

class PreferitiPage extends StatelessWidget {
  const PreferitiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final preferiti = context.watch<PreferitiProvider>().preferiti;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Preferiti"),
        backgroundColor: const Color(0xFF7B1E3A),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: preferiti.isEmpty
          ? const Center(
              child: Text("Nessun locale preferito."),
            )
          : ListView.builder(
              itemCount: preferiti.length,
              itemBuilder: (context, index) {
                final locale = preferiti[index];
                return ListTile(
                  leading: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                  title: Text(locale.nome),
                  subtitle: Text(locale.indirizzo),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => context
                        .read<PreferitiProvider>()
                        .rimuovi(locale),
                  ),
                );
              },
            ),
    );
  }
}
