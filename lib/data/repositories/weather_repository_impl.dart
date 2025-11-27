import '../../data/services/weather_service.dart';
import '../../domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherService _weatherService;

  WeatherRepositoryImpl(this._weatherService);

  @override
  Future<Map<String, dynamic>> getWeatherAndForecast(
      double lat, double lon) async {
    return await _weatherService.fetchWeather(lat, lon);
  }

  @override
  Future<List<dynamic>> searchCity(String query,
      {String language = 'en'}) async {
    return await _weatherService.searchCity(query, language: language);
  }
}
