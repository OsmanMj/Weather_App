class ForecastModel {
  final String date;
  final double maxTemp;
  final double minTemp;
  final int weatherCode;

  ForecastModel({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherCode,
  });

  factory ForecastModel.fromJson(Map<String, dynamic> json, int index) {
    // OpenMeteo 'daily' structure:
    // {
    //   "time": ["2023-01-01", ...],
    //   "temperature_2m_max": [20.0, ...],
    //   "temperature_2m_min": [10.0, ...],
    //   "weather_code": [1, ...]
    // }

    return ForecastModel(
      date: json['time'][index],
      maxTemp: (json['temperature_2m_max'][index] as num).toDouble(),
      minTemp: (json['temperature_2m_min'][index] as num).toDouble(),
      weatherCode: (json['weather_code'][index] as num).toInt(),
    );
  }
}
