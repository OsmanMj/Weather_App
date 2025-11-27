import 'package:flutter/material.dart';
import '../../data/models/forecast_model.dart';
import 'package:intl/intl.dart';
import '../../l10n/app_localizations.dart';

class WeekForecastCard extends StatelessWidget {
  final List<ForecastModel> forecast;

  const WeekForecastCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.weeklyForecast,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: forecast.length,
            itemBuilder: (context, index) {
              final day = forecast[index];
              final date = DateTime.parse(day.date);
              final dayName = DateFormat(
                      'EEEE', Localizations.localeOf(context).languageCode)
                  .format(date);

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        dayName,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Icon(_getWeatherIcon(day.weatherCode)),
                    Text(
                      '${day.maxTemp.round()}° / ${day.minTemp.round()}°',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  IconData _getWeatherIcon(int code) {
    if (code == 0) return Icons.wb_sunny;
    if (code >= 1 && code <= 3) return Icons.cloud;
    if (code >= 45 && code <= 48) return Icons.foggy;
    if (code >= 51 && code <= 67) return Icons.grain;
    if (code >= 71 && code <= 77) return Icons.ac_unit;
    if (code >= 80 && code <= 82) return Icons.umbrella;
    if (code >= 95) return Icons.flash_on;
    return Icons.help_outline;
  }
}
