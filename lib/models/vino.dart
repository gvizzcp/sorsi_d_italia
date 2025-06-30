class Vino {
  final String nome;
  final String descrizione;
  final String denominazione;

  Vino({
    required this.nome,
    required this.descrizione,
    required this.denominazione,
  });

  factory Vino.fromJson(Map<String, dynamic> json) {
    return Vino(
      nome: json['nome'],
      descrizione: json['descrizione'],
      denominazione: json['denominazione'],
    );
  }
}
