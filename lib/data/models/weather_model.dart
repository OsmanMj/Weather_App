class WeatherModel {
  final double temperature;
  final double windSpeed;
  final int humidity;
  final int weatherCode;
  final int isDay;

  WeatherModel({
    required this.temperature,
    required this.windSpeed,
    required this.humidity,
    required this.weatherCode,
    required this.isDay,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final current = json['current_weather'];
    // OpenMeteo 'current_weather' has temperature, windspeed, weathercode, is_day, time
    // Humidity is usually in 'hourly' or needs separate parameter, but for simplicity let's check structure.
    // Actually OpenMeteo v1 'current_weather' doesn't have humidity.
    // We need to use 'current' block if using the new API or 'hourly' for humidity.
    // Let's assume we request 'current=temperature_2m,relative_humidity_2m,is_day,weather_code,wind_speed_10m'

    // Adjusting for OpenMeteo new API structure:
    final currentUnits = json['current_units'];
    final currentData = json['current'];

    return WeatherModel(
      temperature: (currentData['temperature_2m'] as num).toDouble(),
      windSpeed: (currentData['wind_speed_10m'] as num).toDouble(),
      humidity: (currentData['relative_humidity_2m'] as num).toInt(),
      weatherCode: (currentData['weather_code'] as num).toInt(),
      isDay: (currentData['is_day'] as num).toInt(),
    );
  }
}
