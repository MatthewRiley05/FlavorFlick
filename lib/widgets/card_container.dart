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
          Expanded(flex: 1, child: Padding(padding: EdgeInsets.all(12))),
        ],
      ),
    );
  }
}
