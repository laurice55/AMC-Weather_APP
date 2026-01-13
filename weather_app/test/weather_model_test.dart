import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather.dart';

void main() {
  group('Weather Model', () {
    test('should create a Weather object from a valid Manila OpenWeatherMap JSON', () {
      // Realistic Manila JSON sample from OpenWeatherMap
      const String jsonString = '''
      {
        "coord": { "lon": 120.9822, "lat": 14.5995 },
        "weather": [
          { "id": 803, "main": "Clouds", "description": "broken clouds", "icon": "04d" }
        ],
        "base": "stations",
        "main": {
          "temp": 30.5,
          "feels_like": 35.5,
          "temp_min": 29.5,
          "temp_max": 31.5,
          "pressure": 1008,
          "humidity": 70
        },
        "visibility": 10000,
        "wind": { "speed": 4.12, "deg": 240 },
        "clouds": { "all": 75 },
        "dt": 1690000000,
        "sys": {
          "type": 1,
          "id": 7905,
          "country": "PH",
          "sunrise": 1689975600,
          "sunset": 1690021200
        },
        "timezone": 28800,
        "id": 1701668,
        "name": "Manila",
        "cod": 200
      }
      ''';

      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final weather = Weather.fromJson(jsonMap);

      expect(weather.city, 'Manila');
      expect(weather.temperature, 30.5);
      expect(weather.description, 'Clouds');
      expect(weather.humidity, 70);
      expect(weather.windSpeed, 4.12);
    });

    test('should use default values when JSON fields are missing', () {
      final Map<String, dynamic> emptyJson = {
        'main': {},
        'weather': [{}],
        'wind': {}
      };

      final weather = Weather.fromJson(emptyJson);

      expect(weather.city, 'Unknown');
      expect(weather.temperature, 0.0);
      expect(weather.description, 'Unknown');
      expect(weather.humidity, 0);
      expect(weather.windSpeed, 0.0);
    });
  });
}
