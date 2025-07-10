import 'package:flutter_test/flutter_test.dart';
import 'package:sorsi_d_italia/models/locale.dart';

void main() {
  test(
    'LocaleVino fromJson e toJson funzionano correttamente',
    () {
      final json = {
        'name': 'Cantina Sociale',
        'location': {
          'formatted_address': 'Via del Vino, 1',
        },
        'distance': 1234,
        'geocodes': {
          'main': {'latitude': 45.0, 'longitude': 10.0},
        },
      };

      final locale = LocaleVino.fromJson(json);
      final backToJson = locale.toJson();

      expect(locale.nome, 'Cantina Sociale');
      expect(locale.indirizzo, 'Via del Vino, 1');
      expect(locale.distanza, 1234);
      expect(locale.latitudine, 45.0);
      expect(locale.longitudine, 10.0);
      expect(backToJson['name'], 'Cantina Sociale');
    },
  );
}
