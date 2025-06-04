import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 1, // square
              child: Container(
                decoration: BoxDecoration(color: Colors.grey[200]),
                child: const Icon(Icons.image, size: 96, color: Colors.grey),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  Text(
                    "Restaurant Name",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 16,
                    children: [
                      Chip(
                        label: Text('Italian', style: TextStyle(fontSize: 14)),
                      ),
                      Chip(
                        label: Text('Pizza', style: TextStyle(fontSize: 14)),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 16,
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      Text('4.5', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                  Row(
                    spacing: 16,
                    children: [
                      Icon(Icons.location_on, color: Colors.red, size: 16),
                      Text("0.5 m", style: TextStyle(fontSize: 14)),
                      Text("·", style: TextStyle(fontSize: 14)),
                      Icon(Icons.payments, color: Colors.green, size: 16),
                      Text("\$\$\$", style: TextStyle(fontSize: 14)),
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
