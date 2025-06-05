import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _linkController = TextEditingController();

  String? _validateBookmarkLink(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a bookmark link';
    }

    final regex = RegExp(
      r'^https://www\.openrice\.com/en/gourmet/bookmarkrestaurant\.htm\?userid=\d+&region=.*&bpcatId=\d+$',
    );

    if (!regex.hasMatch(value)) {
      return 'Please enter a valid OpenRice bookmark link';
    }

    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Valid bookmark link!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              spacing: 16,
              children: [
                Text("Bookmark Link", style: TextStyle(fontSize: 16)),
                TextFormField(
                  controller: _linkController,
                  validator: _validateBookmarkLink,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Bookmark Link',
                    hintText:
                        'https://www.openrice.com/en/gourmet/bookmarkrestaurant.htm?userid=...',
                  ),
                ),
                FilledButton(
                  onPressed: _submitForm,
                  child: Text('Validate Link'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }
}
