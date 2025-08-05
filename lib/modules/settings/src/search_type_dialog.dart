import 'package:flutter/material.dart';

class SearchTypeDialog extends StatefulWidget {
  final String currentSelection;

  const SearchTypeDialog({super.key, required this.currentSelection});

  @override
  State<SearchTypeDialog> createState() => _SearchTypeDialogState();
}

class _SearchTypeDialogState extends State<SearchTypeDialog> {
  late String _selection;

  @override
  void initState() {
    super.initState();
    _selection = widget.currentSelection;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Search Type'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<String>(
            title: const Text('Directions'),
            value: 'Directions',
            groupValue: _selection,
            onChanged: (value) {
              setState(() {
                _selection = value!;
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Search'),
            value: 'Search',
            groupValue: _selection,
            onChanged: (value) {
              setState(() {
                _selection = value!;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(_selection),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
