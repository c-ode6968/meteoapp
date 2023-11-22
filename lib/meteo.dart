import 'dart:convert';
import 'package:http/http.dart' as http;

class MeteoService {
  final String apiKey;

  MeteoService(this.apiKey);

  Future<Map<String, dynamic>> fetchWeatherData(String city) async {
    final response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}

class WeatherUtils {
  static String getImagePath(String weatherCondition,
      {required int width, required int height}) {
    if (weatherCondition == 'Clear') {
      return 'assets/icons/sunny.png';
    } else if (weatherCondition == 'Clouds') {
      return 'assets/icons/cloudy.png';
    } else if (weatherCondition == 'Rain') {
      return 'assets/icons/rainy.png';
    } else {
      return 'assets/icons/default.png';
    }
  }
}
