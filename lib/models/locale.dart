class LocaleVino {
  final String id;
  final String nome;
  final String indirizzo;
  final int distanza;
  final double? latitudine;
  final double? longitudine;

  LocaleVino({
    required this.id,
    required this.nome,
    required this.indirizzo,
    required this.distanza,
    this.latitudine,
    this.longitudine,
  });

  factory LocaleVino.fromJson(Map<String, dynamic> json) {
    final String nome = json['name'] ?? 'Senza nome';
    // Supporta anche i preferiti salvati col vecchio formato (API v3)
    final num? lat =
        json['latitude'] ?? json['geocodes']?['main']?['latitude'];
    final num? lon =
        json['longitude'] ?? json['geocodes']?['main']?['longitude'];

    return LocaleVino(
      id: json['fsq_place_id'] ?? json['fsq_id'] ?? nome,
      nome: nome,
      indirizzo:
          json['location']?['formatted_address'] ??
          'Indirizzo non disponibile',
      distanza: json['distance'] ?? 0,
      latitudine: lat?.toDouble(),
      longitudine: lon?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fsq_place_id': id,
      'name': nome,
      'location': {'formatted_address': indirizzo},
      'distance': distanza,
      'latitude': latitudine,
      'longitude': longitudine,
    };
  }
}
