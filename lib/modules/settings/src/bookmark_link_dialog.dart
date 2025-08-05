import 'package:flutter/material.dart';

class BookmarkLinkDialog extends StatefulWidget {
  const BookmarkLinkDialog({super.key, required this.currentLink});
  final String currentLink;

  @override
  State<BookmarkLinkDialog> createState() => _BookmarkLinkDialogState();
}

class _BookmarkLinkDialogState extends State<BookmarkLinkDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _linkCtrl;

  @override
  void initState() {
    super.initState();
    _linkCtrl = TextEditingController(text: widget.currentLink);
  }

  String? _validate(String? v) {
    final r = RegExp(
      r'^https://www\.openrice\.com/en/gourmet/bookmarkrestaurant\.htm\?userid=\d+&region=.*&bpcatId=\d+$',
    );
    return (v == null || v.isEmpty)
        ? 'Please enter a bookmark link'
        : (!r.hasMatch(v) ? 'Invalid OpenRice link' : null);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('OpenRice Bookmark Link'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _linkCtrl,
          validator: _validate,
          maxLines: 3,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText:
                'https://www.openrice.com/en/gourmet/bookmarkrestaurant.htm?userid=...',
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop(_linkCtrl.text.trim());
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _linkCtrl.dispose();
    super.dispose();
  }
}
