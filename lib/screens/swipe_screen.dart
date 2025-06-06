import 'package:flavor_flick/services/bookmark_model.dart';
import 'package:flavor_flick/services/html_fetcher.dart';
import 'package:flavor_flick/services/openrice_parser.dart';
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
  bool isLoading = true;
  bool isEmpty = false;
  List<BookmarkHtml> bookmarks = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      if (widget.bookmarkLink.isEmpty) {
        setState(() {
          isLoading = false;
          isEmpty = true;
        });
        return;
      }

      final raw = await fetchBookmarksHtml(widget.bookmarkLink);

      final parsed = parseBookmarks(raw);

      setState(() {
        bookmarks = parsed;
        isLoading = false;
      });
    } catch (e, st) {
      debugPrint('Bookmark load failed: $e\n$st');
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : bookmarks.isEmpty
              ? const Text('No cards to display')
              : CardSwiper(
                  controller: widget.controller,
                  cardsCount: bookmarks.length,
                  isLoop: false,
                  cardBuilder:
                      (
                        context,
                        index,
                        horizontalThresholdPercentage,
                        verticalThresholdPercentage,
                      ) => CardContainer(bookmark: bookmarks[index]),
                ),
        ),
      ),
    );
  }
}
