import 'vino.dart';

class Regione {
  final String nome;
  final List<Vino> vini;

  Regione({required this.nome, required this.vini});

  factory Regione.fromJson(Map<String, dynamic> json) {
    var viniJson = json['vini'] as List;
    List<Vino> viniList = viniJson
        .map((vino) => Vino.fromJson(vino))
        .toList();

    return Regione(nome: json['nome'], vini: viniList);
  }
}
