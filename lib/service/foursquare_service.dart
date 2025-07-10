import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/locale.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<LocaleVino>> cercaEnoteche({
  required double lat,
  required double lon,
}) async {
  final apiKey = dotenv.env['FOURSQUARE_API_KEY'] ?? '';
  const String categoriaEnoteche =
      '13018,13007'; // Categoria: 1)Wine Shops - 2)Bar(che include wine bar, ma anche bar normali)

  final url = Uri.parse(
    'https://api.foursquare.com/v3/places/search'
    '?ll=$lat,$lon'
    '&radius=50000'
    '&categories=$categoriaEnoteche'
    '&limit=20',
  );

  final response = await http.get(
    url,
    headers: {
      'Authorization': apiKey,
      'accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final results = data['results'] as List;

    return results
        .map((e) => LocaleVino.fromJson(e))
        .toList();
  } else {
    throw Exception(
      'Errore API Foursquare: ${response.statusCode}',
    );
  }
}
