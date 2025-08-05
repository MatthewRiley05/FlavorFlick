// lib/screens/swipe_screen.dart
import 'package:flavor_flick/models/bookmark_model.dart';
import 'package:flavor_flick/services/html_fetcher.dart';
import 'package:flavor_flick/services/openrice_parser.dart';
import 'package:flavor_flick/services/pref_keys.dart';
import 'package:flavor_flick/services/prefs_helper.dart';
import 'package:flavor_flick/widgets/card_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key, required this.bookmarkLink, this.controller});

  final String bookmarkLink;
  final CardSwiperController? controller;

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  bool _isLoading = true;
  String _activeLink = '';
  List<BookmarkHtml> _bookmarks = [];

  @override
  void initState() {
    super.initState();
    _initAndFetch();
  }

  Future<void> _initAndFetch() async {
    final saved = PrefService.instance.getString(PrefKey.bookmarkLink) ?? '';

    _activeLink = widget.bookmarkLink.isNotEmpty ? widget.bookmarkLink : saved;

    if (_activeLink.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      return;
    }

    await _fetchData(_activeLink);
  }

  Future<void> _fetchData(String url) async {
    try {
      final raw = await fetchBookmarksHtml(url);
      final parsed = parseBookmarks(raw);

      setState(() {
        _bookmarks = parsed;
        _isLoading = false;
      });
    } catch (e, st) {
      debugPrint('Bookmark load failed: $e\n$st');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (_isLoading) {
      body = const CircularProgressIndicator();
    } else if (_activeLink.isEmpty) {
      body = const Text('No bookmark link saved.\nAdd one in Settings.');
    } else if (_bookmarks.isEmpty) {
      body = const Text('No cards to display');
    } else {
      body = CardSwiper(
        controller: widget.controller,
        cardsCount: _bookmarks.length,
        isLoop: false,
        cardBuilder: (_, index, __, ___) =>
            CardContainer(bookmark: _bookmarks[index]),
      );
    }

    return Scaffold(
      body: SafeArea(child: Center(child: body)),
    );
  }
}
