import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class ClothingLogic {
  static String getRecommendation(BuildContext context, double temperature,
      int weatherCode, double windSpeed) {
    final l10n = AppLocalizations.of(context)!;

    // Rain codes: 51, 53, 55, 61, 63, 65, 80, 81, 82
    final rainCodes = [51, 53, 55, 61, 63, 65, 80, 81, 82];

    if (rainCodes.contains(weatherCode)) {
      return l10n.wearRainCoat;
    }

    if (temperature < 10) {
      return l10n.wearJacket;
    }

    if (temperature > 25) {
      return l10n.wearLight;
    }

    if (windSpeed > 20) {
      return l10n.wearWindbreaker;
    }

    return l10n.wearNormal;
  }

  static IconData getIcon(double temperature, int weatherCode) {
    // Rain codes
    final rainCodes = [51, 53, 55, 61, 63, 65, 80, 81, 82];
    if (rainCodes.contains(weatherCode)) {
      return Icons.umbrella;
    }

    if (temperature < 10) {
      return Icons.checkroom; // Jacket/Coat
    }

    if (temperature > 25) {
      return Icons.wb_sunny; // T-shirt/Light
    }

    return Icons.accessibility_new; // Normal
  }
}
