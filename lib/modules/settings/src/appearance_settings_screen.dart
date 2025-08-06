import 'package:flutter/material.dart';

class AppearanceSettingsScreen extends StatefulWidget {
  const AppearanceSettingsScreen({super.key});

  @override
  State<AppearanceSettingsScreen> createState() =>
      _AppearanceSettingsScreenState();
}

class _AppearanceSettingsScreenState extends State<AppearanceSettingsScreen> {
  String _selectedTheme = 'system';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appearance Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                  segments: const <ButtonSegment<String>>[
                    ButtonSegment<String>(
                      value: 'system',
                      label: Text('System'),
                    ),
                    ButtonSegment<String>(value: 'light', label: Text('Light')),
                    ButtonSegment<String>(value: 'dark', label: Text('Dark')),
                  ],
                  selected: {_selectedTheme},
                  onSelectionChanged: (Set<String> newSelection) {
                    setState(() {
                      _selectedTheme = newSelection.first;
                    });
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
