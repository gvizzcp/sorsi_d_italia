class LocaleVino {
  final String nome;
  final String indirizzo;
  final int distanza;
  final double? latitudine;
  final double? longitudine;

  LocaleVino({
    required this.nome,
    required this.indirizzo,
    required this.distanza,
    this.latitudine,
    this.longitudine,
  });

  factory LocaleVino.fromJson(Map<String, dynamic> json) {
    return LocaleVino(
      nome: json['name'] ?? 'Senza nome',
      indirizzo:
          json['location']?['formatted_address'] ??
          'Indirizzo non disponibile',
      distanza: json['distance'] ?? 0,
      latitudine: json['geocodes']?['main']?['latitude'],
      longitudine: json['geocodes']?['main']?['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': nome,
      'location': {'formatted_address': indirizzo},
      'distance': distanza,
      'geocodes': {
        'main': {
          'latitude': latitudine,
          'longitude': longitudine,
        },
      },
    };
  }
}
