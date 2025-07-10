import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import '../service/location_service.dart';
import '../service/foursquare_service.dart';
import '../service/preferiti_service.dart';
import '../models/locale.dart';

class MappaPage extends StatefulWidget {
  const MappaPage({super.key});

  @override
  State<MappaPage> createState() => _MappaPageState();
}

class _MappaPageState extends State<MappaPage> {
  Position? _posizioneUtente;
  List<LocaleVino> _locali = [];
  bool _caricamento = false;
  String? _errore;
  final _servicePref = PreferitiService();
  List<LocaleVino> _preferiti = [];

  @override
  void initState() {
    super.initState();
    _caricaDati();
  }

  Future<void> _caricaDati() async {
    setState(() {
      _caricamento = true;
      _errore = null;
    });

    try {
      final posizione = await getPosizioneUtente();
      final locali = await cercaEnoteche(
        lat: posizione.latitude,
        lon: posizione.longitude,
      );

      setState(() {
        _posizioneUtente = posizione;
        _locali = locali;
        _caricamento = false;
      });
      setState(() {
        _posizioneUtente = posizione;
        _locali = locali;
        _caricamento = false;
      });
      _preferiti = await _servicePref.caricaPreferiti();
    } catch (e) {
      setState(() {
        _errore = e.toString();
        _caricamento = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final posizione = _posizioneUtente;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Enoteche vicine"),
          backgroundColor: const Color(0xFF7B1E3A),
          foregroundColor: Colors.white,
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.map), text: "Mappa"),
              Tab(icon: Icon(Icons.list), text: "Lista"),
            ],
          ),
        ),
        body: _caricamento
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : posizione == null
            ? Center(
                child: Text(
                  _errore ?? 'Posizione non disponibile',
                ),
              )
            : TabBarView(
                children: [
                  _buildMappa(posizione),
                  _buildLista(),
                ],
              ),
      ),
    );
  }

  // Funzione: Mappa con marker
  Widget _buildMappa(Position posizione) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(
          posizione.latitude,
          posizione.longitude,
        ),
        initialZoom: 14,
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.sorsiitalia',
        ),
        MarkerLayer(markers: _buildMarkers(posizione)),
      ],
    );
  }

  // Funzione: Lista ordinata per distanza
  Widget _buildLista() {
    final localiOrdinati = [..._locali];
    localiOrdinati.sort(
      (a, b) => a.distanza.compareTo(b.distanza),
    );

    return ListView.builder(
      itemCount: localiOrdinati.length,
      itemBuilder: (context, index) {
        final locale = localiOrdinati[index];
        return ListTile(
          leading: const Icon(
            Icons.wine_bar,
            color: Color(0xFF7B1E3A),
          ),
          title: Text(locale.nome),
          subtitle: Text(
            '${locale.indirizzo}\n${locale.distanza} metri',
          ),
          isThreeLine: true,
          trailing: IconButton(
            icon: Icon(
              _preferiti.any((p) => p.nome == locale.nome)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () async {
              setState(() {
                if (_preferiti.any(
                  (p) => p.nome == locale.nome,
                )) {
                  _preferiti.removeWhere(
                    (p) => p.nome == locale.nome,
                  );
                } else {
                  _preferiti.add(locale);
                }
              });
              await _servicePref.salvaPreferiti(_preferiti);
            },
          ),
          onTap: () => _mostraDettagliLocale(locale),
        );
      },
    );
  }

  // Funzione: Marker su mappa
  List<Marker> _buildMarkers(Position posizione) {
    List<Marker> markers = [];

    markers.add(
      Marker(
        point: LatLng(
          posizione.latitude,
          posizione.longitude,
        ),
        width: 40,
        height: 40,
        child: const Icon(
          Icons.person_pin_circle,
          color: Colors.blue,
          size: 40,
        ),
      ),
    );

    for (var locale in _locali) {
      if (locale.latitudine != null &&
          locale.longitudine != null) {
        markers.add(
          Marker(
            point: LatLng(
              locale.latitudine!,
              locale.longitudine!,
            ),
            width: 40,
            height: 40,
            child: GestureDetector(
              onTap: () => _mostraDettagliLocale(locale),
              child: const Icon(
                Icons.location_on,
                color: Color(0xFF7B1E3A),
                size: 36,
              ),
            ),
          ),
        );
      }
    }

    return markers;
  }

  // Funzione: BottomSheet con dettagli
  void _mostraDettagliLocale(LocaleVino locale) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                locale.nome,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7B1E3A),
                ),
              ),
              const SizedBox(height: 8),
              Text(locale.indirizzo),
              const SizedBox(height: 8),
              Text('Distanza: ${locale.distanza} metri'),
            ],
          ),
        );
      },
    );
  }
}
