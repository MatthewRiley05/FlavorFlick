import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
    if (v == null || v.isEmpty) {
      return 'Please enter a bookmark link';
    }

    final mobilePattern = RegExp(
      r'^https://www\.openrice\.com/(en|zh)/me/bookmarked-restaurants',
    );
    if (mobilePattern.hasMatch(v)) {
      return 'Mobile bookmark detected. Please use desktop version to get the public URL with userid.';
    }

    final desktopPattern = RegExp(
      r'^https://www\.openrice\.com/(en|zh)/gourmet/bookmarkrestaurant\.htm\?userid=.*&bpcatId=\d+$',
    );
    if (!desktopPattern.hasMatch(v)) {
      return 'Invalid OpenRice bookmark link. Please use the desktop version.';
    }

    return null;
  }

  @override
  void dispose() {
    _linkCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('OpenRice Bookmark Link'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                spacing: 8,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  Expanded(
                    child: Text(
                      'Use desktop site URL only. If you are on a mobile browser, please request for the desktop site.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Steps:',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              '1. Open link below in browser\n2. Login to your account\n3. Open the Bookmark page you want to save\n4. If you are on mobile, request desktop site\n5. Copy the URL from the address bar',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => _launchUrl('https://www.openrice.com/en/me'),
              icon: const Icon(Icons.open_in_new, size: 16),
              label: const Text('Open OpenRice Bookmarks'),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _linkCtrl,
              validator: _validate,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Paste bookmark URL here',
                hintText:
                    'https://www.openrice.com/en/gourmet/bookmarkrestaurant.htm?userid=...',
              ),
            ),
          ],
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

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
