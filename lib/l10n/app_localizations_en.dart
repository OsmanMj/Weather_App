import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Weather App';

  @override
  String get searchCity => 'Search City...';

  @override
  String get humidity => 'Humidity';

  @override
  String get windSpeed => 'Wind Speed';

  @override
  String get feelsLike => 'Feels Like';

  @override
  String get settings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get systemMode => 'System Default';

  @override
  String get errorNoInternet => 'No Internet Connection';

  @override
  String get errorGpsDisabled => 'GPS is disabled';

  @override
  String get errorApiFailure => 'Failed to load weather data';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get clothingRecommendation => 'Clothing Recommendation';

  @override
  String get wearJacket => 'It\'s cold! Wear a jacket.';

  @override
  String get wearRainCoat => 'It\'s raining! Take an umbrella or raincoat.';

  @override
  String get wearLight => 'It\'s hot! Wear light clothes.';

  @override
  String get wearWindbreaker => 'It\'s windy! A windbreaker might be good.';

  @override
  String get wearNormal => 'Weather is pleasant. Normal clothes are fine.';

  @override
  String get weeklyForecast => '7-Day Forecast';

  @override
  String get today => 'Today';

  @override
  String get clearSky => 'Clear Sky';

  @override
  String get partlyCloudy => 'Partly Cloudy';

  @override
  String get foggy => 'Foggy';

  @override
  String get rainy => 'Rainy';

  @override
  String get snowy => 'Snowy';

  @override
  String get heavyRain => 'Heavy Rain';

  @override
  String get thunderstorm => 'Thunderstorm';

  @override
  String get unknown => 'Unknown';

  @override
  String get myLocation => 'My Location';
}
