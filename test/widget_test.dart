import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sorsi_d_italia/models/regione.dart';
import 'package:sorsi_d_italia/models/vino.dart';
import 'package:sorsi_d_italia/screens/regione_page.dart';

void main() {
  testWidgets('Tap su una regione apre RegionePage', (
    WidgetTester tester,
  ) async {
    final regione = Regione(
      nome: 'Sicilia',
      vini: [
        Vino(
          nome: 'Nero d’Avola',
          descrizione:
              'Vino rosso corposo tipico della Sicilia.',
          denominazione: 'DOC',
        ),
        Vino(
          nome: 'Cerasuolo di Vittoria',
          descrizione:
              'Unico vino DOCG siciliano, elegante e fruttato.',
          denominazione: 'DOCG',
        ),
        Vino(
          nome: 'Marsala',
          descrizione:
              'Vino liquoroso ambrato, con note di caramello.',
          denominazione: 'DOC',
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ListView(
            children: [
              ListTile(
                title: Text(regione.nome),
                onTap: () {
                  Navigator.push(
                    tester.element(find.text(regione.nome)),
                    MaterialPageRoute(
                      builder: (_) =>
                          RegionePage(regione: regione),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Sicilia'), findsOneWidget);

    await tester.tap(find.text('Sicilia'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('I nostri migliori 3 vini'),
      findsOneWidget,
    );
  });
}
