import 'package:flavor_flick/services/bookmark_model.dart';
import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({super.key, required this.bookmark});

  final BookmarkHtml bookmark;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 1,
              child: bookmark.imageUrl.isEmpty
                  ? Container(
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, size: 96),
                    )
                  : Image.network(bookmark.imageUrl, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    bookmark.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Wrap(
                    spacing: 8,
                    children: [
                      ...bookmark.tags
                          .take(3)
                          .map(
                            (tag) => Chip(
                              label: Text(tag, style: TextStyle(fontSize: 10)),
                            ),
                          ),
                      if (bookmark.tags.length > 3)
                        Chip(
                          label: Text(
                            '+${bookmark.tags.length - 3} more',
                            style: TextStyle(fontSize: 10),
                          ),
                          backgroundColor: Colors.grey[300],
                        ),
                    ],
                  ),
                  Row(
                    spacing: 16,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Text(
                        bookmark.rating.toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 16,
                    children: [
                      Icon(Icons.location_on, color: Colors.red, size: 16),
                      Text("0.5 m", style: TextStyle(fontSize: 14)),
                      Text("·", style: TextStyle(fontSize: 14)),
                      Icon(Icons.payments, color: Colors.green, size: 16),
                      Text(bookmark.price, style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
