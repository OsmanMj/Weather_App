import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../data/models/weather_model.dart';
import '../../l10n/app_localizations.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;
  final String cityName;

  const WeatherCard({
    super.key,
    required this.weather,
    required this.cityName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cityName,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${weather.temperature.round()}°',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ).animate().fadeIn().scale(),
                  Text(
                    _getWeatherCondition(context, weather.weatherCode),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ],
              ),
              Icon(
                _getWeatherIcon(weather.weatherCode),
                size: 80,
                color: Colors.white,
              ).animate().fadeIn(delay: 200.ms).slideX(),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDetailItem(
                  context, Icons.water_drop, '${weather.humidity}%'),
              _buildDetailItem(context, Icons.air, '${weather.windSpeed} km/h'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(width: 5),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
              ),
        ),
      ],
    );
  }

  String _getWeatherCondition(BuildContext context, int code) {
    final l10n = AppLocalizations.of(context)!;
    if (code == 0) return l10n.clearSky;
    if (code >= 1 && code <= 3) return l10n.partlyCloudy;
    if (code >= 45 && code <= 48) return l10n.foggy;
    if (code >= 51 && code <= 67) return l10n.rainy;
    if (code >= 71 && code <= 77) return l10n.snowy;
    if (code >= 80 && code <= 82) return l10n.heavyRain;
    if (code >= 85 && code <= 86) return l10n.snowy; // Snow showers
    if (code >= 95) return l10n.thunderstorm; // Thunderstorm
    return l10n.unknown;
  }

  IconData _getWeatherIcon(int code) {
    final isDay = weather.isDay == 1;
    if (code == 0) return isDay ? Icons.wb_sunny : Icons.nightlight_round;
    if (code >= 1 && code <= 3) return isDay ? Icons.cloud : Icons.nights_stay;
    if (code >= 45 && code <= 48) return Icons.foggy;
    if (code >= 51 && code <= 67) return Icons.grain;
    if (code >= 71 && code <= 77) return Icons.ac_unit;
    if (code >= 80 && code <= 82) return Icons.umbrella;
    if (code >= 85 && code <= 86) return Icons.ac_unit;
    if (code >= 95) return Icons.flash_on;
    return Icons.help_outline;
  }
}
