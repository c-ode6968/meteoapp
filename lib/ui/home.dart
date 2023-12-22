// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meteoapp/api/api.dart';
import 'package:meteoapp/model/costanti.dart';
import 'package:intl/intl.dart';
import 'package:meteoapp/service/service.dart';
import 'package:meteoapp/utility/appState.dart';
import 'package:meteoapp/utility/navigation.dart';
import 'package:meteoapp/utility/utility.dart';
import 'package:provider/provider.dart';
import 'city.dart';

class HomePage extends StatefulWidget {
  final String selectedCity;
  const HomePage({Key? key, required this.title, required this.selectedCity})
      : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

@override
State<HomePage> createState() => _HomePageState();
Costanti myCostanti = Costanti();

class _HomePageState extends State<HomePage> {
  bool isGeolocationEnabled = true;

  late Map<String, dynamic>? weatherData;
  List<String> addedCities = [];
  late String cityName = '';

  String temperature = '';
  String feelsLike = '';
  String windSpeed = '';
  String rain = '';
  String humidity = '';
  String visibility = '';
  String cloudiness = '';
  String sunrise = '';
  String sunset = '';
  String pressure = '';
  String day = '';
  String date = '';

  // ignore: non_constant_identifier_names
  List<String> temp_min = [];

  // ignore: non_constant_identifier_names
  List<String> temp_max = [];

  // ignore: prefer_typing_uninitialized_variables

  get city => null;

  // get city => null;
  late MeteoService meteoService;

  @override
  void initState() {
    super.initState();
    meteoService = MeteoService(apiKey);
    weatherData = {};

    fetchWeatherForecastByCity(widget.selectedCity);
    addedCities = [];
    checkLocationAndFetchWeather();
  }

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

  Future<void> showLocationEnableDialog(context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Abilita posizione'),
            content: const Text(
                'Abilita la posizione per utilizzare questa funzione.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Chiudere'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> fetchWeatherForecastByCity(String city) async {
    try {
      final data = await meteoService.fetchWeatherForecastByCity(city);
      setState(() {
        weatherData = data;
        cityName = data['name'];
      });
    } catch (e) {
      // ignore: avoid_print
      print('Errore durante il recupero dei dati:$e');
    }
  }

  Future<void> fetchWeatherForecastByCoordinates(double latitude,
      double longitude) async {
    try {
      final data = await meteoService.fetchWeatherForecastByCoordinates(
          latitude, longitude);
      setState(() {
        weatherData = data;
        cityName = data['name'];
      });
    } catch (e) {
      if (kDebugMode) {
        print('Errore durante il recupero dei dati meteo: $e');
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
      //temp_min = (weatherData?['main']['temp_min']-273.15) .toStringAsFixed(1) ;
      //temp_max = (weatherData?['main']['temp_max']-273.15) .toStringAsFixed(1);
      feelsLike =
          (weatherData?['main']['feels_like'] - 273.15).toStringAsFixed(1);
      humidity = (weatherData?['main']['humidity']).toString();
      windSpeed = (weatherData?['main']['wind_speed']).toString();
      rain = (weatherData?['main']['rain']).toString();
      visibility = (weatherData?['visibility']).toString();
      cloudiness = (weatherData?['clouds']['all']).toString();
      sunrise = (weatherData?['sys']['sunrise']).toString();
      sunset = (weatherData?['sys']['sunset']).toString();
      pressure = (weatherData?['main']['pressure']).toString();
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
            padding: const EdgeInsets.only(right: 23.0),
            icon: const Icon(Icons.search, size: 30.0,),
            onPressed: () async {
              //await addCityDialog(context);
              final selectedCityName = await seachCityDialog(context);
              if (cityName.isNotEmpty) {
                await fetchWeatherForecastByCity(cityName);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CityPage(addedCities: addedCities, cityName: cityName),
                  ),
                );
              }
              ;
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5.0),
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              child: ListView(
                // Utilisazione di una ListView per Scrollare verticalmente
                  children: <Widget>[
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
                          const EdgeInsets.only(top: 20.0, left: 30.0),
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
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        if (weatherData != null &&
                                            weatherData!.containsKey('main') &&
                                            weatherData?['main'] != null &&
                                            weatherData?['main']
                                                .containsKey('temp'))
                                          Text(
                                            '${(weatherData?['main']['temp'] -
                                                273.15).toStringAsFixed(0)} °C',
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
                                    const SizedBox(height: 70),
                                    const SizedBox(width: 50),
                                    if (weatherData != null &&
                                        weatherData?['weather'] != null &&
                                        weatherData?['weather'].isNotEmpty)
                                      Image.asset(
                                        WeatherUtils.getImagePath(
                                            weatherData?['weather'][0]
                                            ['main'] ??
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
                                          weatherData!
                                              .containsKey('main') &&
                                          weatherData?['main'] != null &&
                                          weatherData?['main']
                                              .containsKey('feels_like')
                                          ? 'Feels like: ${(weatherData?['main']['feels_like'] -
                                          273.15).toStringAsFixed(0)} °C'
                                          : '',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),

                                const SizedBox(
                                    height: 20), // Spaziatura tra gli elementi
                                Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'assets/icons/rain.png',
                                          width: 50,
                                          height: 50,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          weatherData != null &&
                                              weatherData!
                                                  .containsKey('rain') &&
                                              weatherData?['rain'] != null
                                              ? '${weatherData?['rain']['1h'] ??
                                              ''} mm'
                                              : 'N/D',
                                        ),
                                        const Text('Pioggia'),
                                      ],
                                    ),
                                    const SizedBox(
                                        width:
                                        35), // Spaziatura tra le immagini
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/icons/fog.png',
                                          width: 50,
                                          height: 50,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          weatherData != null &&
                                              weatherData!
                                                  .containsKey('wind') &&
                                              weatherData?['wind'] !=
                                                  null &&
                                              weatherData?['wind']
                                                  .containsKey('speed')
                                              ? '${weatherData?['wind']['speed']} m/s'
                                              : '',
                                        ),
                                        const Text('Velocità del vento'),
                                      ],
                                    ),
                                    const SizedBox(
                                        width:
                                        30), // Spaziatura tra le immagini
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
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
                                              weatherData?['main'] !=
                                                  null &&
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
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
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
                              child: FutureBuilder<List<Map<String, dynamic>>>(
                                future: meteoService.fetchHourlyWeatherForecast(
                                    widget.selectedCity),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (!snapshot.hasData ||
                                      snapshot.data!.isEmpty) {
                                    return const Text(
                                        'Nessuna previsione oraria disponibile');
                                  } else {
                                    List<Map<String, dynamic>>
                                    hourlyForecastList = snapshot.data!;
                                    return ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: hourlyForecastList.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        var hourlyForecast =
                                        hourlyForecastList[index];

                                        String weatherImagePath =
                                        WeatherUtils.getImagePath(
                                          weatherData?['weather'][0]['main'] ??
                                              '',
                                          width: 30,
                                          height: 30,
                                        );

                                        return Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                DateFormat('HH:mm').format(
                                                    DateTime.parse(
                                                        hourlyForecast[
                                                        'dt_txt'])),
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                              const SizedBox(height: 20.0),
                                              if (weatherData != null &&
                                                  weatherData?['weather'] !=
                                                      null &&
                                                  weatherData?['weather']
                                                      .isNotEmpty)
                                                Image.asset(
                                                  weatherImagePath,
                                                  width: 50,
                                                  height: 50,
                                                ),
                                              const SizedBox(height: 20.0),
                                              Text(
                                                '${(hourlyForecast['main']['temp'] -
                                                    273.15).toStringAsFixed(
                                                    1) ?? ''} °C',
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
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
                            fontSize: 20.0,
                            color: Color.fromARGB(255, 12, 7, 7)),
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
                          child: FutureBuilder<List<Map<String, dynamic>>>(
                            future: meteoService
                                .fetchDailyWeatherForecast(widget.selectedCity),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return const Text(
                                    'Nessuna previsione giornaliera disponibile');
                              } else {
                                List<Map<String, dynamic>> dailyForecastList =
                                snapshot.data!;

                                return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: dailyForecastList.length > 5
                                      ? 5
                                      : dailyForecastList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var dailyForecast =
                                    dailyForecastList[index];

                                    List<Map<String, dynamic>> filteredData =
                                    [];
                                    List<double> minTemps = [];
                                    List<double> maxTemps = [];

                                    // Scorrere l'elenco dei dati originali
                                    for (int i = 0;
                                    i < dailyForecastList.length;
                                    i++) {
                                      var dailyForecast = dailyForecastList[i];

                                      // Ottieni la data corrente
                                      DateTime currentDate = DateTime.parse(
                                          dailyForecast['dt_txt'] ?? '');

                                      // Controlla se la data non è già nell'elenco filtrato
                                      if (!filteredData.any((element) =>
                                      DateTime
                                          .parse(
                                          element['dt_txt'] ?? '')
                                          .day ==
                                          currentDate.day)) {
                                        // Aggiunge la prima voce di questo giorno all'elenco filtrato
                                        filteredData.add(dailyForecast);

                                        minTemps.add(dailyForecast['main']
                                        ['temp_min'] ??
                                            0.0);
                                        maxTemps.add(dailyForecast['main']
                                        ['temp_max'] ??
                                            0.0);
                                      }
                                    }
                                    double totalMinTemp = minTemps.fold(
                                        0.0,
                                            (previous, current) =>
                                        previous + current);
                                    double totalMaxTemp = maxTemps.fold(
                                        0.0,
                                            (previous, current) =>
                                        previous + current);

                                    double moyenneMinTemp = totalMinTemp /
                                        filteredData.length.toDouble();
                                    double moyenneMaxTemp = totalMaxTemp /
                                        filteredData.length.toDouble();

                                    String weatherImagePath;
                                    weatherImagePath =
                                        WeatherUtils.getImagePath(
                                          filteredData[index]['weather'][0]
                                          ['main'] ??
                                              '',
                                          width: 30,
                                          height: 30,
                                        );

                                    return SizedBox(
                                      width: 300.0,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    DateFormat('EEEE').format(
                                                        DateTime.parse(
                                                            filteredData[index][
                                                            'dt_txt'] ??
                                                                '')),
                                                    style: const TextStyle(
                                                        fontSize: 18.0),
                                                  ),
                                                ],
                                              ),
                                              Image.asset(
                                                weatherImagePath,
                                                width: 30,
                                                height: 30,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '${moyenneMinTemp
                                                        .toStringAsFixed(0)}°C',
                                                    style: const TextStyle(
                                                        fontSize: 18.0),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    '${moyenneMaxTemp
                                                        .toStringAsFixed(0)}°C',
                                                    style: const TextStyle(
                                                        fontSize: 18.0),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10.0),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
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
                            fontSize: 20.0,
                            color: Color.fromARGB(255, 10, 6, 6)),
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
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.visibility,
                                    color: Color.fromARGB(255, 80, 4, 49)),
                                title: const Text('Visibilità'),
                                trailing: Text(visibility.isNotEmpty
                                    ? '$visibility m'
                                    : 'N/D'),
                              ),
                              const SizedBox(height: 2),
                              ListTile(
                                leading: const Icon(Icons.cloud,
                                    color: Color.fromARGB(255, 49, 188, 105)),
                                title: const Text('Nuvolosità'),
                                trailing: Text(
                                    cloudiness.isNotEmpty ? cloudiness : 'N/D'),
                              ),
                              const SizedBox(height: 2),
                              ListTile(
                                leading: const Icon(Icons.wb_sunny,
                                    color: Color.fromARGB(255, 228, 163, 11)),
                                title: const Text('Sunrise'),
                                trailing: Text(sunrise.isNotEmpty
                                    ? DateFormat('HH:mm').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        int.parse(sunrise) * 1000))
                                    : 'N/D'),
                              ),
                              const SizedBox(height: 2),
                              ListTile(
                                leading: const Icon(Icons.nightlight_round,
                                    color: Color.fromARGB(255, 165, 232, 11)),
                                title: const Text('Sunset'),
                                trailing: Text(sunset.isNotEmpty
                                    ? DateFormat('HH:mm').format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                        int.parse(sunset) * 1000))
                                    : 'N/D'),
                              ),
                              const SizedBox(height: 2),
                              ListTile(
                                leading: const Icon(Icons.bathroom_outlined,
                                    color: Color.fromARGB(255, 69, 162, 225)),
                                title: const Text('Pressione'),
                                trailing: Text(
                                    pressure.isNotEmpty ? pressure : 'N/D'),
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


  Future<void> seachCityDialog(BuildContext context) async {
    TextEditingController cityNameController = TextEditingController();

    String? cityName = await showDialog<String?>(
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
                  await fetchWeatherForecastByCity(cityName);
                }
              },
            ),
          ],
        );
      },
    );


  }


//Utilizzo della localisazione

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
}
