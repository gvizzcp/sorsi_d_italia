import 'package:flutter/material.dart';
import '../models/locale.dart';
import '../service/preferiti_service.dart';

class PreferitiProvider extends ChangeNotifier {
  final _service = PreferitiService();
  List<LocaleVino> _preferiti = [];

  List<LocaleVino> get preferiti => _preferiti;

  bool isPreferito(LocaleVino locale) =>
      _preferiti.any((p) => p.nome == locale.nome);

  Future<void> carica() async {
    _preferiti = await _service.caricaPreferiti();
    notifyListeners();
  }

  Future<void> toggle(LocaleVino locale) async {
    if (isPreferito(locale)) {
      _preferiti.removeWhere((p) => p.nome == locale.nome);
    } else {
      _preferiti.add(locale);
    }
    await _service.salvaPreferiti(_preferiti);
    notifyListeners();
  }

  Future<void> rimuovi(LocaleVino locale) async {
    _preferiti.removeWhere((p) => p.nome == locale.nome);
    await _service.salvaPreferiti(_preferiti);
    notifyListeners();
  }
}
