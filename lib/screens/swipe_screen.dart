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

  // Variables to hold fetched and processed data
  String? html;
  dynamic json;
  dynamic parsed;
  dynamic sorted;
  List<String> candidates = [];
  List<CardContainer> cards = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      debugPrint("Fetching HTML data...");
      html = await fetchBookmarksHtml(
        "https://www.openrice.com/en/gourmet/bookmarkrestaurant.htm?userid=69106986&region=&bpcatId=17",
      );
    } catch (e) {
      debugPrint('Error fetching HTML: $e');
    }
    try {
      debugPrint("Extracting JSON data...");
      json = parseBookmarks(html!);
    } catch (e) {
      debugPrint('Error extracting JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : cards.isNotEmpty
              ? CardSwiper(
                  cardBuilder:
                      (
                        context,
                        index,
                        horizontalThresholdPercentage,
                        verticalThresholdPercentage,
                      ) => cards[index],
                  cardsCount: cards.length,
                  numberOfCardsDisplayed: 3,
                  isLoop: false,
                )
              : const Text('No cards to display'),
        ),
      ),
    );
  }
}
