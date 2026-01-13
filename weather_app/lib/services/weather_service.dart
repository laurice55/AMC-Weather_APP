import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/weather.dart';

class WeatherService {
  static const String apikey = "4e504df1896606d212ad7436a6fbe98b";
  static const String apiUrl = "https://api.openweathermap.org/data/2.5/weather";

  static Future<Weather> getWeather(String cityName) async {
    try {
      String url = '$apiUrl?q=$cityName&appid=$apikey&units=metric';

      if (kIsWeb) {
        url = '$apiUrl?q=$cityName&appid=$apikey&units=metric';
      }

      final http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Weather.fromJson(data);
      } else if (response.statusCode == 404) {
        throw Exception('City not found');
      } else {
        throw Exception('Failed to load weather data. Status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching weather data: $e');
    }
  }
}
