abstract class WeatherRepository {
  Future<Map<String, dynamic>> getWeatherAndForecast(double lat, double lon);
  Future<List<dynamic>> searchCity(String query, {String language = 'en'});
}
