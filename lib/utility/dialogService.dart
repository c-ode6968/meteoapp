import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appState.dart';

Future<void> seachCityDialog(BuildContext context) async {
  TextEditingController cityNameController = TextEditingController();
  String? selectedCity  = await showDialog<String?>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Cercare una città'),
        content: TextField(
          controller: cityNameController,
          decoration: const InputDecoration(hintText: 'Nome della città'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Annulla'),
            onPressed: () {
              Navigator.of(context).pop(); // Fermer la boîte de dialogue sans sélection
            },
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () async {
              String cityName = cityNameController.text;
              Navigator.of(context).pop(cityName);
              if (cityName != null && cityName.isNotEmpty) {
                Provider.of<AppState>(context, listen: false).seachCity(cityName);
                await Provider.of(context, listen: false).fetchWeatherForecastByCity(cityName);
                //await fetchWeatherForecastByCity(cityName);
              }
            },
          ),
        ],
      );
    },
  );
}