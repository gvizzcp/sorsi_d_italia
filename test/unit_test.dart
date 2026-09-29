import 'package:flutter_test/flutter_test.dart';
import 'package:sorsi_d_italia/models/locale.dart';

void main() {
  test(
    'LocaleVino fromJson e toJson funzionano correttamente',
    () {
      final json = {
        'fsq_place_id': 'abc123',
        'name': 'Cantina Sociale',
        'location': {
          'formatted_address': 'Via del Vino, 1',
        },
        'distance': 1234,
        'latitude': 45.0,
        'longitude': 10.0,
      };

      final locale = LocaleVino.fromJson(json);
      final backToJson = locale.toJson();

      expect(locale.id, 'abc123');
      expect(locale.nome, 'Cantina Sociale');
      expect(locale.indirizzo, 'Via del Vino, 1');
      expect(locale.distanza, 1234);
      expect(locale.latitudine, 45.0);
      expect(locale.longitudine, 10.0);
      expect(backToJson['name'], 'Cantina Sociale');

      final ricaricato = LocaleVino.fromJson(backToJson);
      expect(ricaricato.id, 'abc123');
      expect(ricaricato.latitudine, 45.0);
    },
  );

  test(
    'LocaleVino legge i preferiti salvati col vecchio formato',
    () {
      final json = {
        'name': 'Enoteca Vecchia',
        'location': {
          'formatted_address': 'Via Antica, 2',
        },
        'distance': 500,
        'geocodes': {
          'main': {'latitude': 41, 'longitude': 12.5},
        },
      };

      final locale = LocaleVino.fromJson(json);

      expect(locale.id, 'Enoteca Vecchia');
      expect(locale.latitudine, 41.0);
      expect(locale.longitudine, 12.5);
    },
  );
}
