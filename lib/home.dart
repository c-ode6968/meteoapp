// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:meteoapp/api/api.dart';
import 'package:meteoapp/model/costanti.dart';
import 'package:intl/intl.dart';
import 'package:meteoapp/utility.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

@override
State<HomePage> createState() => _HomePageState();
Costanti myCostanti = Costanti();

class _HomePageState extends State<HomePage> {
  late Map<String, dynamic>? weatherData;
  late String cityName = '';
  String temperature = '';
  String feelsLike = '';
  String windSpeed = '';
  String rain = '';
  String humidity = '';

  get meteoService => null;

  @override
  initState() {
    super.initState();
    weatherData = {};
    fetchWeatherDataForCity('Paris');
  }
  Future<void> fetchWeatherDataForCity(String city) async {
    try {
      final data = await meteoService.fetchWeatherData(city);
      setState(() {
        weatherData = data;
        cityName = data['name'];
      });
    } catch (e) {
      // Gession des erreurs
    }
  }

  void openMenu(BuildContext context) async {
    final RenderBox appBar = context.findRenderObject() as RenderBox;
    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        appBar.localToGlobal(const Offset(0.0, 0.0)).dx,
        appBar.localToGlobal(const Offset(0.0, 0.0)).dy -
            appBar.size.height * 2,
        appBar.localToGlobal(appBar.size.bottomLeft(Offset.zero)).dx,
        appBar.localToGlobal(const Offset(0.0, 0.0)).dy,
      ),
      items: const [
        PopupMenuItem(
          value: 1,
          child: Text('City'),
        ),
        PopupMenuItem(
          value: 2,
          child: Text('Settings'),
        ),
      ],
    );

    if (result != null) {
      // Logique pour gérer les actions en fonction de la sélection du menu
      if (result == 1) {
        // Action pour gerer les ville
      } else if (result == 2) {
        // Action pour gerer les parametre
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate =
        DateFormat('EEEE, d MMMM yyyy').format(DateTime.now());
    if (weatherData != null && weatherData!['main'] != null) {
      temperature = (weatherData?['main']['temp'] - 273.15).toStringAsFixed(1);
      feelsLike =
          (weatherData?['main']['feels_like'] - 273.15).toStringAsFixed(1);
      humidity = (weatherData?['main']['hymidity']).toString();
      windSpeed = (weatherData?['main']['wind_speed']).toString();
      rain = (weatherData?['main']['rain']).toString();
    }

    String weatherCondition = '';
    if (weatherData != null &&
        weatherData?['weather'] != null &&
        weatherData?['weather'].isNotEmpty) {
      weatherCondition = weatherData?['weather'][0]['main'];
    }
    Image.asset(  WeatherUtils.getImagePath(weatherCondition, width: 90, height: 90),
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
            icon: const Icon(Icons.search),
            onPressed: () {
              //logique pour la recherche
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5.0), // Espacement du haut de la page

            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                // Utilisation d'une ListView pour le défilement vertical
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
                                      width:
                                          40), // Espacement entre le texte et la première image

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
                              const SizedBox(height: 25),

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
                                          height:
                                              5), // Espace entre l'image et le texte
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
                                          height:
                                              5), // Espace entre l'image et le texte
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
                        onTap: () {
                          // Action lors du tap sur la carte 1
                        },
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
                            // Hauteur pour les images
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: 20, // Nombre total d'images à afficher
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Text(
                                        '20:00',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(height: 20.0),
                                      Image.asset(
                                        'assets/icons/fog.png',
                                        width: 80.0, // largeur des images
                                        height: 80.0, //  hauteur des images
                                      ),
                                      const SizedBox(height: 20.0),
                                      const Text(
                                        '10 °C',
                                        style: TextStyle(fontSize: 18),
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
                    height: 300.0,
                    child: Card(
                      color: myCostanti.secondaryColor.withOpacity(.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: ListTile(
                        title: const Text('Card 3'),
                        subtitle: const Text('Description 3'),
                        onTap: () {
                          // Action lors du tap sur la carte 3
                        },
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
                    height: 300.0,
                    width: 120.0,
                    child: Card(
                      color: myCostanti.secondaryColor.withOpacity(.8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                      ),
                      child: ListTile(
                        title: const Text('Card 4'),
                        subtitle: const Text('Description 4'),
                        onTap: () {
                          // Action lors du tap sur la carte 4
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 150.0),
                  const Text('Autre contenu en dessous de la carte'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions pour la barre de recherche
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icône à gauche de la barre de recherche
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Affiche les résultats de la recherche
    return Container(
        //logique pour afficher les résultats de la recherche
        );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions pendant la saisie de la recherche
    return Container(
        //logique pour afficher les suggestions de recherche
        );
  }
}
