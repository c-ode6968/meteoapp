import 'dart:async';
import 'package:dio/dio.dart';
class MeteoService {
  final String apiKey;

  MeteoService(this.apiKey);

  get meteoService => null;

  get cityname => null;

  // Funzione asincrona che recupera i dati meteorologici da un endpint specifico(lat, lon, città)
  Future<Map<String, dynamic>> _fetchWeather(String endpoint, String query,
      {double? latitude, double? longitude}) async {
    //Creazione di un oggetto Dio per effetuare le richieste HTTP
    final dio = Dio();

    try {
      //Creazione di un dizionario per i parametri della query, inizializzato con l'apikey
      Map<String, dynamic> queryParameters = {
        'appid': apiKey,
      };

      //Condizione che verifica se sono disponibile le coordinate geologiche (lat...e lon...)
      if (latitude != null && longitude != null) {
        //Aggiunge delle coordinate ai parametri della query
        queryParameters['lat'] = latitude;
        queryParameters['lon'] = longitude;
      } else if (query.isNotEmpty) {
        //Se le coordinate geologiche non sono disponibile e la query non è query non è vuota, aggiunge la query ai parametri della query
        queryParameters['q'] = query;
      } else {
        //Se le ne coordinate ne la query non sono disponibile , solleva un eccezione
        throw ArgumentError('Si prega di fornire una città o le coordinate geografiche.');
      }

      final response = await dio.get(
        'http://api.openweathermap.org/data/2.5/$endpoint',
        queryParameters: queryParameters,
      );


      if (response.statusCode == 200) {
        return response.data;
      } else {
        //Se la risposta ha uno stato diverso da 200, solleva un'eccezione DioExeption
        throw DioException(
          requestOptions: RequestOptions(path: response.requestOptions.path),
          response: response,
          error: 'Errore durante il caricamento dei dati',
        );
      }
    } on DioException catch (e) {
      //Gestione delle eccezioni specifiche di Dio, come errori di connessione
      if (e.type == DioException.connectionError) {
        throw DioException(
          requestOptions: RequestOptions(path: e.requestOptions.path ?? ''),
          error: 'Nessuna connessione internet',
        );
      } else {
        //Se c'è un eccezione di Dio diversa da un errore di connessione , solleva un errore generico.
        throw Exception('Erreur inconnue: $e');
      }
    }

  }


  Future<Map<String, dynamic>> fetchWeatherForecastByCity(String city) async {
    return _fetchWeather('weather', city);
  }


  Future<List<Map<String, dynamic>>> fetchHourlyWeatherForecast(
      String city) async {
    final response = await _fetchWeather('forecast', city);
    if (response.containsKey('list')) {
      List<Map<String, dynamic>> hourlyForecastList =
          List<Map<String, dynamic>>.from(response['list']);
      return hourlyForecastList;
    } else {
      throw Exception('Impossibile caricare le previsioni meteo orarie');
    }
  }


/*
  Future<List<Map<String, dynamic>>> fetchDailyWeatherForecast({required String? selectedCity, double? latitude, double? longitude }) async {
    if(selectedCity != null){
      final response = await _fetchWeather('forecast', selectedCity);
      if(response.containsKey('list')){
        List<Map<String, dynamic>> dailyForecastList = List<Map<String, dynamic>>.from(response['list']);
        return dailyForecastList;
      }else{
        throw Exception('Failed to load daily weather forecast');
      }
    }else{
      if(latitude != null && longitude != null){
        final response = await _fetchWeather('forecast', '', latitude: latitude, longitude: longitude);
        if(response.containsKey('list')){
          List<Map<String, dynamic>> dailyForecastList = List<Map<String, dynamic>>.from(response['list']);
          return dailyForecastList;
        }else{
          throw Exception('Failed to load daily weather forecast');
        }
      }else{
        throw Exception('Please specify a city or provide coordinates');
      }
    }
  }

*/

  /*
  Future<List<Map<String, dynamic>>> fetchDailyWeatherForecast(
      String city) async {
    final response = await _fetchWeather('forecast', city);
    if(response.containsKey('list')){
      List<Map<String, dynamic>> dailyForecastList = List<Map<String, dynamic>>.from(response['list']);
      return dailyForecastList;
    }else{
      throw Exception('Impossibile caricare le previsioni meteo orarie');
    }
  }
   */

  Future<List<Map<String, dynamic>>> fetchDailyWeatherForecast(String city) async {
    try {
      // Chiama all'api per ottenere le previsioni giornaliere
      final response = await _fetchWeather('forecast', city);

      if (response.containsKey('list')) {
        List<Map<String, dynamic>> dailyForecastList = [];
        //Crea una mappa per raggruppare le previsioni giornaliere
        Map<String, List<Map<String, dynamic>>> groupedByDate = {};

        for (Map<String, dynamic> forecast in response['list'] ?? []) {
          // Estrarre la data da ogni previsione
          String? date = forecast['dt_txt'];

          // Verificare se la data non è nulla prima di elaborarla
          if (date != null) {
            // Verificare se la data esiste già nella mappa
            if (groupedByDate.containsKey(date)) {
              // Aggiungere la previsione alla lista esistente per questa data
              groupedByDate[date]?.add(forecast);
            } else {
              // Creare una nuova lista per questa data e aggiungere la previsione
              groupedByDate[date] = [forecast];
            }
          }
        }

        // Aggiungere le liste di previsioni raggruppate alla lista finale
        groupedByDate.forEach((date, forecasts) {
          dailyForecastList.add({'date': date, 'forecasts': forecasts});
        });

        return dailyForecastList;
      } else {
        throw Exception('Impossibile caricare le previsioni meteo orarie');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }



  Future<Map<String, dynamic>> fetchWeatherForecastByCoordinates(double latitude, double longitude, {
    String? city,
  }) async {
    if ((latitude == null || longitude == null) && city == null) {
      throw ArgumentError('Si prega di fornire le coordinate geografiche o una città.');
    }

    return _fetchWeather('weather', city ?? '', latitude: latitude, longitude: longitude);
  }

}


