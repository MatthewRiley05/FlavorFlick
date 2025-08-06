import 'package:flavor_flick/modules/settings/src/appearance_settings.dart';
import 'package:flavor_flick/modules/settings/src/bookmark_settings.dart';
import 'package:flavor_flick/modules/settings/src/map_settings.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required this.onBookmarkSubmitted,
    required this.onSearchTypeChanged,
  });
  final ValueChanged<String> onBookmarkSubmitted;
  final ValueChanged<String> onSearchTypeChanged;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            BookmarkSettings(onBookmarkSubmitted: widget.onBookmarkSubmitted),
            AppearanceSettings(),
            MapSettings(onSearchTypeChanged: widget.onSearchTypeChanged),
          ],
        ),
      ),
    ),
  );
}
