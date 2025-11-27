import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/weather_provider.dart';
import '../../l10n/app_localizations.dart';

class CitySearchBar extends ConsumerStatefulWidget {
  final Function(double lat, double lon, String name) onCitySelected;
  final VoidCallback? onMyLocation;

  const CitySearchBar(
      {super.key, required this.onCitySelected, this.onMyLocation});

  @override
  ConsumerState<CitySearchBar> createState() => _CitySearchBarState();
}

class _CitySearchBarState extends ConsumerState<CitySearchBar> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isLoading = false;

  void _onSearchChanged(String query) async {
    if (query.length < 3) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final language = Localizations.localeOf(context).languageCode;
      final results = await ref
          .read(weatherRepositoryProvider)
          .searchCity(query, language: language);
      if (mounted) {
        setState(() {
          _searchResults = results;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: l10n.searchCity,
            prefixIcon: IconButton(
              icon: const Icon(Icons.my_location),
              onPressed: () {
                _controller.clear();
                widget.onMyLocation?.call();
              },
            ),
            suffixIcon: _isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                      setState(() {
                        _searchResults = [];
                      });
                    },
                  ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Theme.of(context).cardColor,
          ),
          onChanged: _onSearchChanged,
        ),
        if (_searchResults.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final city = _searchResults[index];
                return ListTile(
                  title: Text(city['name']),
                  subtitle: Text('${city['country'] ?? ''}'),
                  onTap: () {
                    widget.onCitySelected(
                      (city['latitude'] as num).toDouble(),
                      (city['longitude'] as num).toDouble(),
                      city['name'],
                    );
                    _controller.clear();
                    setState(() {
                      _searchResults = [];
                    });
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
