import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.image, size: 80, color: Colors.grey[600]),
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                      Text('0.5 mi', style: TextStyle(fontSize: 14)),
                      Text('\$\$', style: TextStyle(fontSize: 14)),
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
