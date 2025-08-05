import 'package:flavor_flick/modules/settings/src/bookmark_settings.dart';
import 'package:flavor_flick/modules/settings/src/map_settings.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key, required this.onBookmarkSubmitted});
  final ValueChanged<String> onBookmarkSubmitted;

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
          spacing: 16,
          children: [
            BookmarkSettings(onBookmarkSubmitted: widget.onBookmarkSubmitted),
            MapSettings(),
          ],
        ),
      ),
    ),
  );
}
