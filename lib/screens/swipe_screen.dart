import 'package:flavor_flick/services/bookmark_model.dart';
import 'package:flavor_flick/services/html_fetcher.dart';
import 'package:flavor_flick/services/openrice_parser.dart';
import 'package:flavor_flick/widgets/card_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({super.key});

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  final CardSwiperController controller = CardSwiperController();

  bool isLoading = true;
  List<BookmarkHtml> bookmarks = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final raw = await fetchBookmarksHtml(
        'https://www.openrice.com/en/gourmet/bookmarkrestaurant.htm'
        '?userid=69106986&region=&bpcatId=17',
      );

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
                  controller: controller,
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
