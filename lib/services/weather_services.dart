import 'dart:convert';
import 'package:flutter_weather_app/models/wether_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'http://api.weatherapi.com/v1/current.json';
  static const MY_API_KEY = '26b1942eeb0240a4b10175838242611';
  final String apiKey;

  WeatherService({String? apiKey}) : apiKey = apiKey ?? MY_API_KEY;

  Future<Weather> getWeather(String cityName) async {
    final response =
        await http.get(Uri.parse('$BASE_URL?key=$apiKey&q=$cityName&aqi=no'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Weather.fromJson(json);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
