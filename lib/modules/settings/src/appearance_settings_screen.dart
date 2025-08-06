import 'package:flavor_flick/services/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppearanceSettingsScreen extends StatelessWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeNotifier>().themeMode;

    String selected = switch (themeMode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      _ => 'system',
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Appearance Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Text(
              'Theme',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'system', label: Text('System')),
                    ButtonSegment(value: 'light', label: Text('Light')),
                    ButtonSegment(value: 'dark', label: Text('Dark')),
                  ],
                  selected: {selected},

                  onSelectionChanged: (Set<String> newSelection) {
                    final mode = switch (newSelection.first) {
                      'light' => ThemeMode.light,
                      'dark' => ThemeMode.dark,
                      _ => ThemeMode.system,
                    };
                    context.read<ThemeNotifier>().setThemeMode(mode);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
