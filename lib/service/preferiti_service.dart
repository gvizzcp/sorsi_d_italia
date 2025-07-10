import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/locale.dart';

class PreferitiService {
  static const _key = 'preferiti';

  Future<List<LocaleVino>> caricaPreferiti() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    return list.map((s) {
      final jsonMap =
          json.decode(s) as Map<String, dynamic>;
      return LocaleVino.fromJson(jsonMap);
    }).toList();
  }

  Future<void> salvaPreferiti(List<LocaleVino> list) async {
    final prefs = await SharedPreferences.getInstance();
    final strList = list
        .map((l) => json.encode(l.toJson()))
        .toList();
    await prefs.setStringList(_key, strList);
  }
}
