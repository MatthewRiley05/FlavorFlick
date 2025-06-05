import 'package:flavor_flick/helpers/bookmark_model.dart';
import 'package:flavor_flick/helpers/html_fetcher.dart';
import 'package:flavor_flick/helpers/json_extractor.dart';
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
      debugPrint("🔍 Starting data fetch...");
      html = await fetchBookmarksHtml(
        "https://www.openrice.com/en/gourmet/bookmarkrestaurant.htm?userid=69106986&region=&bpcatId=17",
      );
      debugPrint(
        "📄 HTML fetched successfully, length is ${html?.length ?? 0}",
      );

      // Add detailed HTML debugging
      if (html != null && html!.isNotEmpty) {
        debugPrint(
          "📄 HTML preview (first 500 chars): ${html!.length > 500 ? html!.substring(0, 500) : html}",
        );
        debugPrint("📄 Looking for __NEXT_DATA__ in HTML...");

        if (html!.contains('__NEXT_DATA__')) {
          debugPrint("✅ Found __NEXT_DATA__ in HTML");
          // Try the original approach
          json = extractNextData(html!);
        } else {
          debugPrint("❌ __NEXT_DATA__ NOT found in HTML");

          // Look for other common data patterns
          debugPrint("🔍 Looking for alternative data sources...");

          // Check for JSON-LD scripts
          if (html!.contains('application/ld+json')) {
            debugPrint("📋 Found JSON-LD data");
          }

          // Check for inline JavaScript variables
          if (html!.contains('window.')) {
            debugPrint("📋 Found window variables");
          }

          // Check for data attributes
          if (html!.contains('data-')) {
            debugPrint("📋 Found data attributes");
          }

          // For now, create mock data to test the card rendering
          // For now, create mock data to test the card rendering
          debugPrint("🧪 Using mock data for testing");
          json = {
            "bookmark": [
              {
                "name": "Test Restaurant 1",
                "id": "1",
                "latitude": 22.3193,
                "longitude": 114.1694,
                "address": "Test Address 1",
              },
              {
                "name": "Test Restaurant 2",
                "id": "2",
                "latitude": 22.3200,
                "longitude": 114.1700,
                "address": "Test Address 2",
              },
              {
                "name": "Test Restaurant 3",
                "id": "3",
                "latitude": 22.3210,
                "longitude": 114.1710,
                "address": "Test Address 3",
              },
            ],
          };
        }
      } else {
        debugPrint("❌ HTML is null or empty!");
        throw Exception("Failed to fetch HTML");
      }

      debugPrint("🔍 Processing data...");
      debugPrint("📋 JSON type: ${json.runtimeType}");
      debugPrint("📋 JSON content: $json");

      // Add debugging before parseBookmarks
      debugPrint("🔧 About to parse bookmarks...");
      try {
        parsed = parseBookmarks(json);
        debugPrint("🔧 Parsed data: $parsed");
      } catch (parseError) {
        debugPrint("💥 Parse error: $parseError");
        // For testing, let's bypass the parsing and create test data directly
        parsed = [
          {
            "name": "Test Restaurant 1",
            "latitude": 22.3193,
            "longitude": 114.1694,
          },
          {
            "name": "Test Restaurant 2",
            "latitude": 22.3200,
            "longitude": 114.1700,
          },
          {
            "name": "Test Restaurant 3",
            "latitude": 22.3210,
            "longitude": 114.1710,
          },
        ];
        debugPrint("🔧 Using fallback parsed data: $parsed");
      }

      debugPrint("📍 About to sort bookmarks...");
      try {
        sorted = await nearestBookmarks(parsed);
        debugPrint("📍 Sorted data: $sorted");
      } catch (sortError) {
        debugPrint("💥 Sort error: $sortError");
        // For testing, use the parsed data as-is
        sorted = parsed;
        debugPrint("📍 Using fallback sorted data: $sorted");
      }

      setState(() {
        // Update candidates with restaurant names from sorted data
        if (sorted != null && sorted is List && sorted.isNotEmpty) {
          debugPrint("✅ Processing ${sorted.length} restaurants");
          candidates = sorted
              .map<String>(
                (restaurant) =>
                    restaurant['name']?.toString() ?? 'Unknown Restaurant',
              )
              .toList();
        } else {
          debugPrint("❌ No restaurants found, using fallback");
          candidates = ['No restaurants found'];
        }

        debugPrint("📝 Final candidates: $candidates");

        // Generate cards from the updated candidates
        cards = candidates
            .map<CardContainer>((name) => CardContainer())
            .toList();

        debugPrint("🎯 Final cards count: ${cards.length}");
        isLoading = false;
      });
    } catch (e) {
      debugPrint("💥 Error in _fetchData: $e");
      debugPrint("💥 Error type: ${e.runtimeType}");
      setState(() {
        candidates = ['Error loading restaurants: ${e.toString()}'];
        cards = candidates
            .map<CardContainer>((name) => CardContainer())
            .toList();
        isLoading = false;
      });
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
