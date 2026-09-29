import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/locale.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<List<LocaleVino>> cercaEnoteche({
  required double lat,
  required double lon,
}) async {
  final apiKey = dotenv.env['FOURSQUARE_API_KEY'] ?? '';
  const String categorieEnoteche =
      '4bf58dd8d48988d123941735,' // Wine Bar
      '4bf58dd8d48988d119951735,' // Wine Store (enoteche)
      '4bf58dd8d48988d14b941735'; // Winery (cantine)

  final url = Uri.https('places-api.foursquare.com', '/places/search', {
    'll': '$lat,$lon',
    'radius': '50000',
    'fsq_category_ids': categorieEnoteche,
    'limit': '20',
    'sort': 'DISTANCE',
    'fields': 'fsq_place_id,name,latitude,longitude,distance,location',
  });

  final response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $apiKey',
      'X-Places-Api-Version': '2025-06-17',
      'accept': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final results = data['results'] as List;

    return results.map((e) => LocaleVino.fromJson(e)).toList();
  } else {
    throw Exception('Errore API Foursquare: ${response.statusCode}');
  }
}
