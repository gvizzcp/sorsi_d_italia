import 'package:flutter/material.dart';
import '../models/regione.dart';
import '../models/vino.dart';

class RegionePage extends StatelessWidget {
  final Regione regione;

  const RegionePage({super.key, required this.regione});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF7B1E3A),
        foregroundColor: Colors.white,
        title: Text(
          "${regione.nome} – I nostri migliori 3 vini",
          style: const TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
            fontFamily: 'Georgia',
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: regione.vini.length,
        itemBuilder: (context, index) {
          Vino vino = regione.vini[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 3,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 14,
              ),
              title: Text(
                vino.nome,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B1E3A),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text(
                    vino.descrizione,
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Denominazione: ${vino.denominazione}",
                    style: const TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
