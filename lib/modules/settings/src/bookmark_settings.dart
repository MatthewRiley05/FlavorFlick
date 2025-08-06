import 'package:flavor_flick/modules/settings/src/bookmark_link_dialog.dart';
import 'package:flavor_flick/services/pref_keys.dart';
import 'package:flavor_flick/services/prefs_helper.dart';
import 'package:flutter/material.dart';

class BookmarkSettings extends StatefulWidget {
  const BookmarkSettings({super.key, required this.onBookmarkSubmitted});

  final ValueChanged<String> onBookmarkSubmitted;

  @override
  State<BookmarkSettings> createState() => _BookmarkSettingsState();
}

class _BookmarkSettingsState extends State<BookmarkSettings> {
  String _bookmarkLink = '';

  @override
  void initState() {
    super.initState();
    _loadBookmarkLink();
  }

  void _loadBookmarkLink() {
    final savedLink = PrefService.instance.getString(PrefKey.bookmarkLink);
    if (savedLink != null && savedLink.isNotEmpty) {
      setState(() {
        _bookmarkLink = savedLink;
      });
    }
  }

  Future<void> _saveBookmarkLink(String link) async {
    await PrefService.instance.setString(PrefKey.bookmarkLink, link);
    widget.onBookmarkSubmitted(link);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.bookmark_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('OpenRice Bookmark Link'),
              subtitle: Text(
                _bookmarkLink.isEmpty
                    ? 'Not configured'
                    : _bookmarkLink.length > 25
                    ? '${_bookmarkLink.substring(0, 25)}...'
                    : _bookmarkLink,
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 0,
              ),
              onTap: () => _showBookmarkLinkDialog(),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showBookmarkLinkDialog() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) => BookmarkLinkDialog(currentLink: _bookmarkLink),
    );

    if (result != null) {
      setState(() {
        _bookmarkLink = result;
      });
      await _saveBookmarkLink(result);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Bookmark saved')));
      }
    }
  }
}
