import 'package:flavor_flick/modules/settings/src/search_type_dialog.dart';
import 'package:flavor_flick/services/pref_keys.dart';
import 'package:flavor_flick/services/prefs_helper.dart';
import 'package:flutter/material.dart';

class MapSettings extends StatefulWidget {
  const MapSettings({super.key});

  @override
  State<MapSettings> createState() => _MapSettingsState();
}

class _MapSettingsState extends State<MapSettings> {
  String _selectedSearchType = 'Directions';

  @override
  void initState() {
    super.initState();
    _loadSearchType();
  }

  void _loadSearchType() {
    final savedType = PrefService.instance.getString(PrefKey.searchType);
    if (savedType != null && savedType.isNotEmpty) {
      setState(() {
        _selectedSearchType = savedType;
      });
    }
  }

  Future<void> _saveSearchType(String searchType) async {
    await PrefService.instance.setString(PrefKey.searchType, searchType);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Map Settings',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Column(
          children: [
            ListTile(
              leading: const Icon(Icons.map_rounded),
              title: const Text('Search Type'),
              subtitle: Text(_selectedSearchType),
              trailing: const Icon(Icons.chevron_right_rounded),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 0,
              ),
              onTap: () => _showSearchTypeDialog(),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showSearchTypeDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) =>
          SearchTypeDialog(currentSelection: _selectedSearchType),
    );

    if (result != null) {
      setState(() {
        _selectedSearchType = result;
      });
      await _saveSearchType(result);
    }
  }
}
