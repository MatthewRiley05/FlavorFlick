import 'package:shared_preferences/shared_preferences.dart';
import 'pref_keys.dart';

class PrefService {
  PrefService._();
  static final instance = PrefService._();

  late final SharedPreferences _prefs;

  static Future<void> init() async {
    instance._prefs = await SharedPreferences.getInstance();
  }

  String? getString(PrefKey k) => _prefs.getString(k.raw);
  Future<void> setString(PrefKey k, String v) => _prefs.setString(k.raw, v);

  bool? getBool(PrefKey k) => _prefs.getBool(k.raw);
  Future<void> setBool(PrefKey k, bool v) => _prefs.setBool(k.raw, v);

  List<String>? getStringList(PrefKey k) => _prefs.getStringList(k.raw);
  Future<void> setStringList(PrefKey k, List<String> v) =>
      _prefs.setStringList(k.raw, v);

  Future<void> remove(PrefKey k) => _prefs.remove(k.raw);
}
