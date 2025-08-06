import 'package:flavor_flick/services/pref_keys.dart';
import 'package:flavor_flick/services/prefs_helper.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  ThemeNotifier() {
    _load();
  }

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    await PrefService.instance.setString(PrefKey.themeMode, mode.name);
  }

  Future<void> _load() async {
    final saved = await PrefService.instance.getString(PrefKey.themeMode);
    if (saved != null && ThemeMode.values.any((mode) => mode.name == saved)) {
      _themeMode = ThemeMode.values.byName(saved);
    }
    notifyListeners();
  }
}
