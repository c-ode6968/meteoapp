import 'package:http/http.dart' as http;
import 'dart:convert';

class MeteoService {
  final String apiKey;

  MeteoService(this.apiKey);

  Future<Map<String, dynamic>> _fetchWeather(String endpoint, String city, {double? latitude, double? longitude}) async {
    final response = await http.get(Uri.parse('http://api.openweathermap.org/data/2.5/$endpoint?q=$city&lat=${latitude ?? ''}&lon=${longitude ?? ''}&appid=$apiKey'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<Map<String, dynamic>> fetchWeatherData(String city) async {
    return _fetchWeather('weather', city);
  }

  Future<Map<String, dynamic>> fetchWeatherForecast(String city) async {
    return _fetchWeather('forecast', city);
  }

  Future<Map<String, dynamic>> fetchWeatherForecastByCoordinates(double latitude, double longitude) async {
    return _fetchWeather('weather', '', latitude: latitude, longitude: longitude);
  }
}

