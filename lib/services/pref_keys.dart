enum PrefKey { bookmarkLink, searchType }

extension PrefKeyX on PrefKey {
  String get raw => name;
}
