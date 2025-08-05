class BookmarkHtml {
  BookmarkHtml({
    required this.imageUrl,
    required this.id,
    required this.name,
    required this.address,
    required this.tags,
    required this.price,
    required this.rating,
  });

  final String imageUrl;
  final int id;
  final String name;
  final String address;
  final List<String> tags;
  final String price;
  double rating;
}
