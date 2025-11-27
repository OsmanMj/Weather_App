import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/services/weather_service.dart';
import '../../data/repositories/weather_repository_impl.dart';
import '../../domain/repositories/weather_repository.dart';

import 'package:geolocator/geolocator.dart';

final weatherServiceProvider = Provider<WeatherService>((ref) {
  return WeatherService();
});

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final weatherService = ref.watch(weatherServiceProvider);
  return WeatherRepositoryImpl(weatherService);
});

final currentWeatherProvider =
    FutureProvider.family<Map<String, dynamic>, Position>(
        (ref, position) async {
  final repository = ref.watch(weatherRepositoryProvider);
  return await repository.getWeatherAndForecast(
      position.latitude, position.longitude);
});

final citySearchProvider =
    FutureProvider.family<List<dynamic>, String>((ref, query) async {
  final repository = ref.watch(weatherRepositoryProvider);
  return await repository.searchCity(query);
});
