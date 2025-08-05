import 'package:flavor_flick/models/distance_result.dart';

class BookmarkHtml {
  BookmarkHtml({
    required this.imageUrl,
    required this.id,
    required this.name,
    required this.address,
    required this.tags,
    required this.price,
    required this.rating,
    this.distance,
  });

  final String imageUrl;
  final int id;
  final String name;
  final String address;
  final List<String> tags;
  final String price;
  final double rating;
  DistanceResult? distance;
}
