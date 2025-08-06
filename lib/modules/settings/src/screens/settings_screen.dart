import 'package:flavor_flick/modules/settings/src/appearance_settings.dart';
import 'package:flavor_flick/modules/settings/src/bookmark_settings.dart';
import 'package:flavor_flick/modules/settings/src/map_settings.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    super.key,
    required this.onBookmarkSubmitted,
    required this.onSearchTypeChanged,
  });
  final ValueChanged<String> onBookmarkSubmitted;
  final ValueChanged<String> onSearchTypeChanged;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            BookmarkSettings(onBookmarkSubmitted: onBookmarkSubmitted),
            AppearanceSettings(),
            MapSettings(onSearchTypeChanged: onSearchTypeChanged),
          ],
        ),
      ),
    ),
  );
}
