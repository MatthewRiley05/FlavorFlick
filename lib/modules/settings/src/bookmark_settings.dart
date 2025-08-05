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
  final _formKey = GlobalKey<FormState>();
  final _linkCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _linkCtrl.text = PrefService.instance.getString(PrefKey.bookmarkLink) ?? '';
  }

  String? _validate(String? v) {
    final r = RegExp(
      r'^https://www\.openrice\.com/en/gourmet/bookmarkrestaurant\.htm\?userid=\d+&region=.*&bpcatId=\d+$',
    );
    return (v == null || v.isEmpty)
        ? 'Please enter a bookmark link'
        : (!r.hasMatch(v) ? 'Invalid OpenRice link' : null);
  }

  Future<void> _save() async {
    if (_formKey.currentState!.validate()) {
      final link = _linkCtrl.text.trim();

      await PrefService.instance.setString(PrefKey.bookmarkLink, link);
      widget.onBookmarkSubmitted(link);

      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Bookmark saved')));
        FocusScope.of(context).unfocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Bookmark Settings',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: _linkCtrl,
              validator: _validate,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText:
                    'https://www.openrice.com/en/gourmet/bookmarkrestaurant.htm?userid=...',
              ),
            ),
          ),
          Center(
            child: FilledButton(onPressed: _save, child: const Text('Save')),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _linkCtrl.dispose();
    super.dispose();
  }
}
