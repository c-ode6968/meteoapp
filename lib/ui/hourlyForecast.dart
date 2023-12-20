import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importez ce dont vous avez besoin pour le formatage de la date

class FiveDayForecastWidget extends StatelessWidget {
  final List<Map<String, dynamic>> weatherForecastData;

  const FiveDayForecastWidget({Key? key, required this.weatherForecastData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: weatherForecastData.length,
      itemBuilder: (context, index) {
        // Utilisez les données de weatherForecastData[index] pour afficher chaque prévision
        var forecast = weatherForecastData[index];
        return SizedBox(
          width: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ... Votre mise en page pour afficher les détails de la prévision ...
              Text(
                'Day ${index + 1} ', // Exemple : Jour de la semaine
                style: const TextStyle(fontSize: 18.0),
              ),
              Text(
                'Date ${DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(forecast['date'] * 1000))}', // Exemple : Date
                style: const TextStyle(fontSize: 18.0),
              ),
              Image.asset(
                'assets/icons/sunny.png', // Remplacez par votre image météo
                width: 30,
                height: 30,
              ),
              Text(
                '${forecast['temp_min']}°C', // Exemple : Température minimale
                style: const TextStyle(fontSize: 18.0),
              ),
              Text(
                '${forecast['temp_max']}°C', // Exemple : Température maximale
                style: const TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 10.0), // Espacement entre les lignes
            ],
          ),
        );
      },
    );
  }
}
