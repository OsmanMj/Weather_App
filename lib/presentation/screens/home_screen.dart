import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../../l10n/app_localizations.dart';
import '../providers/weather_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/language_provider.dart';
import '../widgets/weather_card.dart';
import '../widgets/week_forecast_card.dart';
import '../widgets/city_search_bar.dart';
import '../widgets/clothing_recommendation_widget.dart';
import '../../data/models/weather_model.dart';
import '../../data/models/forecast_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Position? _currentPosition;
  String _cityName = "My Location";

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return;
    }

    final position = await Geolocator.getCurrentPosition();

    // Update position first
    setState(() {
      _currentPosition = position;
    });

    // Then fetch city name
    await _updateCityNameFromPosition(position);
  }

  Future<void> _updateCityNameFromPosition(Position position) async {
    try {
      final locale = ref.read(languageProvider);
      await setLocaleIdentifier(locale.languageCode);
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        String? city = place.locality;
        if (city == null || city.isEmpty) {
          city = place.subAdministrativeArea;
        }
        if (city == null || city.isEmpty) {
          city = "Unknown";
        }
        if (mounted) {
          setState(() {
            _cityName = city!;
          });
        }
      }
    } catch (e) {
      debugPrint("Error getting placemark: $e");
    }
  }

  void _onCitySelected(double lat, double lon, String name) {
    setState(() {
      _currentPosition = Position(
        longitude: lon,
        latitude: lat,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );
      _cityName = name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeProvider);
    final locale = ref.watch(languageProvider);

    ref.listen(languageProvider, (previous, next) {
      if (previous?.languageCode != next.languageCode &&
          _currentPosition != null) {
        _updateCityNameFromPosition(_currentPosition!);
      }
    });

    // Use localized "My Location" if _cityName matches the default key or is "My Location"
    String displayCityName = _cityName;
    if (_cityName == "My Location" || _cityName == "موقعي") {
      displayCityName = l10n.myLocation;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                l10n.settings,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.brightness_6),
              title: Text(l10n.theme),
              trailing: DropdownButton<ThemeMode>(
                value: themeMode,
                onChanged: (ThemeMode? newValue) {
                  if (newValue != null) {
                    ref.read(themeProvider.notifier).setTheme(newValue);
                  }
                },
                items: [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text(l10n.systemMode),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text(l10n.lightMode),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text(l10n.darkMode),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text(l10n.language),
              trailing: DropdownButton<String>(
                value: locale.languageCode,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    ref
                        .read(languageProvider.notifier)
                        .setLanguage(Locale(newValue));
                  }
                },
                items: const [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: 'ar',
                    child: Text('العربية'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 80.0, left: 16.0, right: 16.0, bottom: 16.0),
              child: _currentPosition == null
                  ? const Center(child: CircularProgressIndicator())
                  : Consumer(
                      builder: (context, ref, child) {
                        final weatherAsyncValue = ref
                            .watch(currentWeatherProvider(_currentPosition!));

                        return weatherAsyncValue.when(
                          data: (data) {
                            final weather = WeatherModel.fromJson(data);
                            final dailyData = data['daily'];
                            final forecastList = <ForecastModel>[];
                            for (int i = 0; i < 7; i++) {
                              forecastList
                                  .add(ForecastModel.fromJson(dailyData, i));
                            }

                            return RefreshIndicator(
                              onRefresh: () async {
                                // Invalidate provider to refresh
                                ref.invalidate(
                                    currentWeatherProvider(_currentPosition!));
                              },
                              child: ListView(
                                children: [
                                  WeatherCard(
                                      weather: weather,
                                      cityName: displayCityName),
                                  const SizedBox(height: 20),
                                  ClothingRecommendationWidget(
                                    temperature: weather.temperature,
                                    weatherCode: weather.weatherCode,
                                    windSpeed: weather.windSpeed,
                                  ),
                                  const SizedBox(height: 20),
                                  WeekForecastCard(forecast: forecastList),
                                ],
                              ),
                            );
                          },
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (error, stack) => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(l10n.errorApiFailure),
                                ElevatedButton(
                                  onPressed: () {
                                    ref.invalidate(currentWeatherProvider(
                                        _currentPosition!));
                                  },
                                  child: Text(l10n.tryAgain),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: CitySearchBar(
                onCitySelected: _onCitySelected,
                onMyLocation: () {
                  _determinePosition();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
