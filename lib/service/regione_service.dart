import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/regione.dart';

Future<List<Regione>> caricaRegioni() async {
  final String jsonString = await rootBundle.loadString(
    'assets/vini.json',
  );
  final jsonData = json.decode(jsonString);

  List regioniJson = jsonData['regioni'];
  return regioniJson
      .map((e) => Regione.fromJson(e))
      .toList();
}
