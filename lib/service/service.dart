import 'dart:async';
import 'package:dio/dio.dart';
class MeteoService {
  final String apiKey;

  MeteoService(this.apiKey);

  Future<Map<String, dynamic>> _fetchWeather(String endpoint, String query,
      {double? latitude, double? longitude}) async {
    final dio = Dio();

    try {
      Map<String, dynamic> queryParameters = {
        'appid': apiKey,
      };

      if (latitude != null && longitude != null) {
        queryParameters['lat'] = latitude;
        queryParameters['lon'] = longitude;
      } else if (query.isNotEmpty) {
        queryParameters['q'] = query;
      } else {

        throw ArgumentError('Si prega di fornire una città o le coordinate geografiche.');
      }

      final response = await dio.get(
        'http://api.openweathermap.org/data/2.5/$endpoint',
        queryParameters: queryParameters,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: response.requestOptions.path),
          response: response,
          error: 'Errore durante il caricamento dei dati',
        );
      }
    } on DioException catch (e) {
      if (e.type == DioException.connectionError) {
        throw DioException(
          requestOptions: RequestOptions(path: e.requestOptions.path ?? ''),
          error: 'Nessuna connessione internet',
        );
      } else {
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

  Future<Map<String, dynamic>> fetchWeatherForecastByCoordinates(double latitude, double longitude, {
    String? city,
  }) async {
    if ((latitude == null || longitude == null) && city == null) {
      throw ArgumentError('Si prega di fornire le coordinate geografiche o una città.');
    }

    return _fetchWeather('weather', city ?? '', latitude: latitude, longitude: longitude);
  }


}


