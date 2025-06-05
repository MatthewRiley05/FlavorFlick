class BookmarkHtml {
  const BookmarkHtml({
    required this.id,
    required this.name,
    required this.address,
    required this.tags,
    required this.price,
    this.lat,
    this.lng,
  });

  final int id;
  final String name;
  final String address;
  final List<String> tags;
  final String price;

  final double? lat;
  final double? lng;
}
