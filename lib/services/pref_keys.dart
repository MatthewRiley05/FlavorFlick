enum PrefKey { bookmarkLink, searchType, themeMode }

extension PrefKeyX on PrefKey {
  String get raw => name;
}
