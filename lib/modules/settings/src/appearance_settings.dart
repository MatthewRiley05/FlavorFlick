import 'package:flavor_flick/modules/settings/src/appearance_settings_screen.dart';
import 'package:flutter/material.dart';

class AppearanceSettings extends StatelessWidget {
  const AppearanceSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.palette_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Appearance'),
              subtitle: const Text('Theme'),
              trailing: const Icon(Icons.chevron_right_rounded),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 0,
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AppearanceSettingsScreen(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
