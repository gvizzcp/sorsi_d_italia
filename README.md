# 🍷 Sorsi d'Italia

App mobile in Flutter per scoprire i vini tipici delle regioni italiane e trovare le enoteche più vicine a te.

## Funzionalità

- **Vini per regione**: scegli una delle 20 regioni e scopri i suoi vini più rappresentativi, con descrizione e denominazione (DOC, DOCG).
- **Enoteche vicine**: l'app usa la tua posizione per mostrarti wine bar, enoteche e cantine nei dintorni, su mappa o in lista ordinata per distanza.
- **Preferiti**: salva i locali che ti piacciono e ritrovali anche dopo aver chiuso l'app.

## Tecnologie

- [Flutter](https://flutter.dev) / Dart
- [Foursquare Places API](https://docs.foursquare.com/) per la ricerca dei locali
- [OpenStreetMap](https://www.openstreetmap.org) + [flutter_map](https://pub.dev/packages/flutter_map) per la mappa
- [geolocator](https://pub.dev/packages/geolocator) per la posizione
- [provider](https://pub.dev/packages/provider) e [shared_preferences](https://pub.dev/packages/shared_preferences) per i preferiti

## Come avviarla

### 1. Requisiti

- [Flutter](https://docs.flutter.dev/get-started/install) installato
- Un emulatore Android o un telefono collegato

### 2. Scarica il progetto

```bash
git clone https://github.com/gvizzcp/sorsi_d_italia.git
cd sorsi_d_italia
flutter pub get
```

### 3. Aggiungi la chiave Foursquare

L'app ha bisogno di una chiave gratuita di Foursquare per cercare le enoteche.

1. Crea un account su [foursquare.com/developers](https://foursquare.com/developers).
2. Crea un nuovo progetto e genera una **Service API Key**.
3. Nella cartella principale del progetto crea un file chiamato `.env` con questa riga:

```
FOURSQUARE_API_KEY=la_tua_chiave
```

> Il file `.env` non viene caricato su GitHub, quindi la tua chiave resta privata.
> Senza questo file l'app non si avvia.

### 4. Avvia l'app

```bash
flutter run
```

> **Usi l'emulatore Android?** Di default la posizione è impostata negli Stati Uniti.
> Per cambiarla: clicca i tre puntini (⋯) nella barra dell'emulatore → **Location** → scegli un punto in Italia → **Set location**.

## Struttura del progetto

```
lib/
├── main.dart          # Avvio dell'app e tema
├── models/            # Vino, Regione, Locale
├── providers/         # Gestione dei preferiti
├── screens/           # Le schermate dell'app
└── service/           # Posizione, Foursquare, dati dei vini
assets/
└── vini.json          # Elenco delle regioni e dei vini
```

## Test

```bash
flutter test
```

## Prossimi sviluppi

- [ ] Pagina di dettaglio per ogni vino (vitigni, abbinamenti, temperatura di servizio)
- [ ] Ricerca e filtri per tipo di vino
- [ ] Dati dei vini su un database online invece che nel file JSON
- [ ] Supporto completo per iOS
