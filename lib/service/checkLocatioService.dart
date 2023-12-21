
/*
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';



Future<void> checkLocationAndFetchWeather() async {
  await _getCurrentLocation();
  if (!await Geolocator.isLocationServiceEnabled()) {
    await showLocationEnableDialog(context);
  }
  if (await Geolocator.isLocationServiceEnabled()) {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    await fetchWeatherForecastByCoordinates(
      position.latitude,
      position.longitude,
    );
  }

}


  _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

Future<void> showLocationEnableDialog(context) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnabled) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Activer la localisation'),
          content: const Text('Veuillez activer la localisation pour utiliser cette fonctionnalité.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fermer'),
            ),
          ],
        );
      },
    );
  }
}

 */