import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/presentation/screens/weather_app.dart';
import 'package:weather_app/presentation/widgets/city_search_bar.dart';

void main() {
  testWidgets('Weather App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: WeatherApp(),
      ),
    );

    // Verify that the CitySearchBar is present.
    expect(find.byType(CitySearchBar), findsOneWidget);

    // Verify that the app title is present (might need to wait for localization or just check widget type)
    // Since we are using localization, the text might depend on the locale loaded.
    // But CitySearchBar is a good indicator that the home screen loaded.
  });
}
