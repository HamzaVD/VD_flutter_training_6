import 'dart:convert';

import 'package:architecture/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static String apiKey = '5554e8a86471f37f80bd4fdbb3d3f820';
  static Future<WeatherResponse> getWeatherData(String cityName) async {
    var response = await http.get(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return WeatherResponse.fromJson(json.decode(response.body));
  }
}
