import 'package:geolocator/geolocator.dart';

class Bookmark {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final List<String> cuisines;
  final double rating;
  final String price;

  Bookmark.fromJson(Map<String, dynamic> j)
    : id = j['poiid'].toString(),
      name = j['shopName'] ?? j['enName'],
      lat = (j['latitude'] as num).toDouble(),
      lng = (j['longitude'] as num).toDouble(),
      cuisines = (j['cuisine'] as List?)?.cast<String>() ?? const [],
      rating = (j['rating'] ?? 0).toDouble(),
      price = j['priceRange'] ?? '\$\$';
}

List<Bookmark> parseBookmarks(Map<String, dynamic> nextData) {
  final items =
      nextData['props']['pageProps']['initialState']['bookmark']['bookmarkList']
          as List;
  return items.map((e) => Bookmark.fromJson(e)).toList();
}

Future<List<Bookmark>> nearestBookmarks(List<Bookmark> all) async {
  final pos = await Geolocator.getCurrentPosition();
  all.sort(
    (a, b) =>
        Geolocator.distanceBetween(
          pos.latitude,
          pos.longitude,
          a.lat,
          a.lng,
        ).compareTo(
          Geolocator.distanceBetween(pos.latitude, pos.longitude, b.lat, b.lng),
        ),
  );
  return all;
}
