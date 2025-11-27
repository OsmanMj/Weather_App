import 'package:dio/dio.dart';

class WeatherService {
  final Dio _dio = Dio();
  static const String _baseUrl = 'https://api.open-meteo.com/v1/forecast';

  Future<Map<String, dynamic>> fetchWeather(double lat, double lon) async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'latitude': lat,
          'longitude': lon,
          'current':
              'temperature_2m,relative_humidity_2m,is_day,weather_code,wind_speed_10m',
          'daily': 'weather_code,temperature_2m_max,temperature_2m_min',
          'timezone': 'auto',
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Error fetching weather: $e');
    }
  }

  Future<List<dynamic>> searchCity(String query,
      {String language = 'en'}) async {
    try {
      final response = await _dio.get(
        'https://geocoding-api.open-meteo.com/v1/search',
        queryParameters: {
          'name': query,
          'count': 5,
          'language': language,
          'format': 'json',
        },
      );

      if (response.statusCode == 200 && response.data['results'] != null) {
        return response.data['results'];
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
