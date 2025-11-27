import 'package:flutter/material.dart';
import '../../domain/logic/clothing_logic.dart';

class ClothingRecommendationWidget extends StatelessWidget {
  final double temperature;
  final int weatherCode;
  final double windSpeed;

  const ClothingRecommendationWidget({
    super.key,
    required this.temperature,
    required this.weatherCode,
    required this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    final recommendation = ClothingLogic.getRecommendation(
        context, temperature, weatherCode, windSpeed);
    final icon = ClothingLogic.getIcon(temperature, weatherCode);

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon,
              size: 40,
              color: Theme.of(context).colorScheme.onTertiaryContainer),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              recommendation,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
