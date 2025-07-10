import 'package:geolocator/geolocator.dart';

Future<Position> getPosizioneUtente() async {
  bool servizioAttivo =
      await Geolocator.isLocationServiceEnabled();
  if (!servizioAttivo) {
    return Future.error(
      'Servizi di localizzazione disattivati.',
    );
  }

  LocationPermission permesso =
      await Geolocator.checkPermission();
  if (permesso == LocationPermission.denied) {
    permesso = await Geolocator.requestPermission();
    if (permesso == LocationPermission.denied) {
      return Future.error('Permesso posizione negato.');
    }
  }

  if (permesso == LocationPermission.deniedForever) {
    return Future.error('Permesso negato permanentemente.');
  }

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );
}
