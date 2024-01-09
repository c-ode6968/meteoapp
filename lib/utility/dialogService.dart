import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'appState.dart';

// Funzione asincrona per mostrare una finestra di dialogo per la ricerca di una città
Future<void> seachCityDialog(BuildContext context) async {
  // Controller per il campo di testo della città
  TextEditingController cityNameController = TextEditingController();

  // Mostra la finestra di dialogo e attende la selezione della città
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
              Navigator.of(context).pop(); // Chiude la finestra di dialogo e restituisce il nome della città
            },
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () async {
              // Ottiene il nome della città inserito dall'utente
              String cityName = cityNameController.text;
              Navigator.of(context).pop(cityName);

              // Se il nome della città non è vuoto, esegui le operazioni necessarie
              if (cityName != null && cityName.isNotEmpty) {
                // Aggiorna lo stato dell'applicazione con la città cercata
                Provider.of<AppState>(context, listen: false).seachCity(cityName);
                // Esegue la richiesta delle previsioni del tempo per la città
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