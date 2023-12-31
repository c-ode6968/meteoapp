import 'dart:async';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:meteoapp/ui/cityList.dart';

class MeteoService {
  final String apiKey;

  MeteoService(this.apiKey);

  Future<Map<String, dynamic>> _fetchWeather(String endpoint, String city,
      {double? latitude, double? longitude}) async {
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/$endpoint?q=$city&lat=${latitude ?? ''}&lon=${longitude ?? ''}&appid=$apiKey'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
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
      throw Exception('Failed to load hourly weather forecast');
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
      throw Exception('Failed to load daily weather forecast');
    }
  }

  Future<Map<String, dynamic>> fetchWeatherForecastByCoordinates(
      double latitude, double longitude) async {
    return _fetchWeather('weather', '',
        latitude: latitude, longitude: longitude);
  }

}


