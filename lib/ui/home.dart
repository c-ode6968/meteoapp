// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:meteoapp/api/api.dart';
import 'package:meteoapp/model/costanti.dart';
import 'package:intl/intl.dart';
import 'package:meteoapp/service/service.dart';
import 'package:meteoapp/utility/navigation.dart';
import 'package:meteoapp/utility/utility.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

@override
State<HomePage> createState() => _HomePageState();
Constanti myCostanti = Constanti();
//List<City> cities = []; // Liste de villes

class _HomePageState extends State<HomePage> {
  late Map<String, dynamic>? weatherData;

  late String cityName = '';

  String temperature = '';
  String feelsLike = '';
  String windSpeed = '';
  String rain = '';
  String humidity = '';
  String visibility = '';
  String nuvolosita = '';
  String sunrise = '';
  String sunset = '';
  String pressione = '';
  String day = '';
  String date = '';
  // ignore: non_constant_identifier_names
  List<String> temp_min = [];
  // ignore: non_constant_identifier_names
  List<String> temp_max = [];
  
  get city => null;
   


  @override
  initState() {
    super.initState();
    late MeteoService meteoService;
    weatherData = {};
    fetchWeatherDataForCity('Ancona');
  }
  

  Future<void> fetchWeatherDataForCity(String city) async {
    try {
      final data = await meteoService.fetchWeatherData(city);
      setState(() {
        weatherData = data;
        cityName = data['name'];
        if (data['list'] != null) {
          for (int i = 0; i < 5; i++) {
            temp_min.add((data['list'][i]['main']['temp_min'] - 273.15)
                .toStringAsFixed(1));
            temp_max.add((data['list'][i]['main']['temp_max'] - 273.15)
                .toStringAsFixed(1));
          }
        }
      });
    } catch (e) {
      // ignore: avoid_print
      print('Errore durante la recuperazione de dati: $e');
    }
  }
 
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate =
        DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
    if (weatherData != null && weatherData!['main'] != null) {
      temperature = (weatherData?['main']['temp'] - 273.15).toStringAsFixed(1);
      // temp_min = (weatherData?['main']['temp_min']-273.15).toString();
      // temp_max = (weatherData?['main']['temp_max']-273.15).toString();
      feelsLike = (weatherData?['main']['feels_like'] - 273.15).toStringAsFixed(1);
      humidity = (weatherData?['main']['humidity']).toString();
      windSpeed = (weatherData?['main']['wind_speed']).toString();
      rain = (weatherData?['main']['rain']).toString();
      visibility = (weatherData?['visibility']).toString();
      nuvolosita = (weatherData?['clouds']['all']).toString();
      sunrise = (weatherData?['sys']['sunrise']).toString();
      sunset = (weatherData?['sys']['sunset']).toString();
      pressione = (weatherData?['pressure']).toString();
    }

    String weatherCondition = '';
    if (weatherData != null &&
        weatherData?['weather'] != null &&
        weatherData?['weather'].isNotEmpty) {
      weatherCondition = weatherData?['weather'][0]['main'];
    }
    Image.asset(
      WeatherUtils.getImagePath(weatherCondition, width: 90, height: 90),
    );
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              cityName,
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              weatherData != null &&
                      weatherData?['weather'] != null &&
                      weatherData?['weather'].isNotEmpty
                  ? '${weatherData?['weather'][0]['main']}'
                  : 'Loading...',
              style: const TextStyle(fontSize: 12.0),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => openMenu(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
             addCityDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5.0),

            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                // Utilisazione di una ListView per Scrollare verticalmente
                children: [
                  SizedBox(
                    height: 300.0,
                    child: Card(
                      color: myCostanti.secondaryColor.withOpacity(.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.only(top: 30.0, left: 30.0),
                        title: Text(
                          formattedDate,
                          style: const TextStyle(color: Colors.black),
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (weatherData != null &&
                                          weatherData!.containsKey('main') &&
                                          weatherData?['main'] != null &&
                                          weatherData?['main']
                                              .containsKey('temp'))
                                        Text(
                                          '${(weatherData?['main']['temp'] - 273.15).toStringAsFixed(0)} °C',
                                          style: const TextStyle(
                                              fontSize: 60.0,
                                              color: Colors.amber),
                                        )
                                      else
                                        const CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.amber),
                                          strokeWidth: 8,
                                        ),
                                    ],
                                  ),

                                  const SizedBox(
                                      width: 40), 
                                  if (weatherData != null &&
                                      weatherData?['weather'] != null &&
                                      weatherData?['weather'].isNotEmpty)
                                    Image.asset(
                                      WeatherUtils.getImagePath(
                                          weatherData?['weather'][0]['main'] ??
                                              '',
                                          width: 90,
                                          height: 90),
                                      width: 90,
                                      height: 90,
                                    )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    weatherData != null &&
                                            weatherData!.containsKey('main') &&
                                            weatherData?['main'] != null &&
                                            weatherData?['main']
                                                .containsKey('feels_like')
                                        ? 'Feels like: ${(weatherData?['main']['feels_like'] - 273.15).toStringAsFixed(0)} °C'
                                        : '',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              const SizedBox(
                                  height: 20), // Espacement entre les éléments
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/icons/rain.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                      const SizedBox(
                                          height:5), 
                                      Text(
                                        weatherData != null &&
                                                weatherData!
                                                    .containsKey('rain') &&
                                                weatherData?['rain'] != null
                                            ? '${weatherData?['rain'] ?? ''} mm'
                                            : 'no data',
                                      ),
                                      const Text('Pioggia'),
                                    ],
                                  ),
                                  const SizedBox(
                                      width: 35), // Espacement entre les images
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/icons/fog.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                      const SizedBox(
                                          height:  5),
                                      Text(
                                        weatherData != null &&
                                                weatherData!
                                                    .containsKey('wind') &&
                                                weatherData?['wind'] != null &&
                                                weatherData?['wind']
                                                    .containsKey('speed')
                                            ? '${weatherData?['wind']['speed']} m/s'
                                            : '',
                                      ),
                                      const Text('Velocità del vento'),
                                    ],
                                  ),
                                  const SizedBox(
                                      width: 35), // Espacement entre les images
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/icons/humidity.png',
                                        width: 50,
                                        height: 50,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        weatherData != null &&
                                                weatherData!
                                                    .containsKey('main') &&
                                                weatherData?['main'] != null &&
                                                weatherData?['main']
                                                    .containsKey('humidity')
                                            ? '${weatherData?['main']['humidity']} %'
                                            : '',
                                      ),
                                      const Text('Humidità'),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),

                  const Center(
                    child: Text(
                      'Durante le giornata',
                      style: TextStyle(
                          fontSize: 20.0, color: Color.fromARGB(255, 15, 9, 9)),
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Deuxieme card
                  SizedBox(
                    height: 200.0,
                    child: Card(
                      color: myCostanti.secondaryColor.withOpacity(.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 200.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: weatherData?['hourlyForecast']?.length ?? 0, 
                              itemBuilder: (BuildContext context, int index) {
                                var hourlyForecast = weatherData?['hourlyForecast'][index]; // Recuperare i dati per questo index

                                return Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        hourlyForecast['time'],
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(height: 20.0),
                                      Image.asset(
                                        WeatherUtils.getImagePath(hourlyForecast['weatherCondition'], width: 80, height: 80),
                                        width: 80.0, 
                                        height: 80.0, 
                                      ),
                                      const SizedBox(height: 20.0),
                                      Text(
                                        '${hourlyForecast['temperature']} °C',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10.0,
                  ),
                  // ignore: prefer_const_constructors
                  Center(
                    child: const Text(
                      'Previsioni 5 giorni',
                      style: TextStyle(
                          fontSize: 20.0, color: Color.fromARGB(255, 12, 7, 7)),
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Troisieme card
                  SizedBox(
                    height: 220.0,
                    child: Card(
                      color: myCostanti.secondaryColor.withOpacity(.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [
                            for (int i = 0; i < 5; i++)
                              SizedBox(
                                width: 300.0,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Day ${i + 1} ',
                                              style: const TextStyle(fontSize: 18.0),
                                            ), // Giorno della settimane 
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Date ${i + 1}',
                                              style: const TextStyle(fontSize: 18.0),
                                            ), // Data
                                          ],
                                        ),
                                        Image.asset(
                                          'assets/icons/sunny.png',
                                          width: 30,
                                          height: 30,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${temp_min.isNotEmpty ? temp_min[i] : ''}°C',
                                              style: const TextStyle(fontSize: 18.0),
                                            ), // TempMax
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '${temp_max.isNotEmpty ? temp_max[i] : ''}°C',
                                              style: const TextStyle(fontSize: 18.0),
                                            ), // TempMin
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10.0),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),


            
                  const SizedBox(
                    height: 10.0,
                  ),
                  // ignore: prefer_const_constructors
                  Center(
                    child: const Text(
                      'Magiori informazioni sulla giornata',
                      style: TextStyle(
                          fontSize: 20.0, color: Color.fromARGB(255, 10, 6, 6)),
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // quatrieme card
                  SizedBox(
                    height: 340.0,
                    child: Card(
                      color: myCostanti.secondaryColor.withOpacity(.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child:  Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                                leading: const Icon(Icons.visibility, color: Color.fromARGB(255, 80, 4, 49)),
                                title: const Text('Visibilità'),
                                trailing:Text(visibility.isNotEmpty ? '$visibility m' : 'N/D'),
                                ),
                            const SizedBox(height: 2),
                            ListTile(
                              leading: const Icon(Icons.cloud, color: Color.fromARGB(255, 49, 188, 105)),
                              title: const Text('Nuvolosità'),
                              trailing: Text(nuvolosita.isNotEmpty ? nuvolosita : 'N/D'),
                            ),
                            const SizedBox(height: 2),
                            ListTile(
                              leading: const Icon(Icons.wb_sunny, color: Color.fromARGB(255, 228, 163, 11)),
                              title: const Text('Sunrise'),
                              trailing: Text(sunrise.isNotEmpty ? DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(int.parse(sunrise) * 1000)) : 'N/D'),
                            ),
                            const SizedBox(height: 2),
                            ListTile(
                              leading: const Icon(Icons.nightlight_round, color: Color.fromARGB(255, 165, 232, 11)),
                              title: const Text('Sunset'),
                              trailing: Text(sunset.isNotEmpty ? DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(int.parse(sunset) * 1000)) : 'N/D'),
                            ),
                            const SizedBox(height: 2),
                            ListTile(
                              leading: const Icon(Icons.bathroom_outlined, color: Color.fromARGB(255, 69, 162, 225)),
                              title: const Text('Pressione'),
                              trailing: Text(pressione.isNotEmpty ? pressione : 'N/D'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 100.0),
          ]),
            ),
          ],
        ),
      ),
    );
  }


  
 Future<void> addCityDialog(BuildContext context) async {
    TextEditingController cityNameController = TextEditingController();

    String? cityName = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agiungere una città'),
          content: TextField(
            controller: cityNameController,
            decoration: const InputDecoration(hintText: 'Nome della città'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Aggiungi'),
              onPressed: () {
                String cityName = cityNameController.text;
                Navigator.of(context).pop(cityName);
              },
            ),
          ],
        );
      },
    );

    if (cityName != null && cityName.isNotEmpty) {

      city.addCityToList(cityName); // Ajoute la ville à l'aide de la méthode dans la classe City
    }
  }
  

// class CustomSearchDelegate extends SearchDelegate<String> {
//   final Function(String) onSearch;
//   CustomSearchDelegate({required this.onSearch});
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     // Actions pour la barre de recherche
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }

  // @override
  // Widget buildLeading(BuildContext context) {
  //   // Icône à gauche de la barre de recherche
  //   return IconButton(
  //     icon: const Icon(Icons.arrow_back),
  //     onPressed: () {
  //       close(context, '');
  //     },
  //   );
  // }

  // @override
  // Widget buildResults(BuildContext context) {
  //   // Affiche les résultats de la recherche
  //  final selectedCity = query;
  //   return Container(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Text(
  //       'Afficher les données météo pour $selectedCity ici...',
  //       style: const TextStyle(fontSize: 18.0),
  //     ),
  //   );
  // }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Suggestions pendant la saisie de la recherche
  //   return Text('Suggestions pour : $query');
  // }

}