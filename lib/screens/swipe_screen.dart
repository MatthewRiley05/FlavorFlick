// lib/screens/swipe_screen.dart
import 'package:flavor_flick/models/bookmark_model.dart';
import 'package:flavor_flick/services/html_fetcher.dart';
import 'package:flavor_flick/services/location_service.dart';
import 'package:flavor_flick/services/openrice_parser.dart';
import 'package:flavor_flick/services/pref_keys.dart';
import 'package:flavor_flick/services/prefs_helper.dart';
import 'package:flavor_flick/services/routes_service.dart';
import 'package:flavor_flick/widgets/card_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';

class SwipeScreen extends StatefulWidget {
  const SwipeScreen({
    super.key,
    required this.bookmarkLink,
    required this.searchType,
    this.controller,
  });

  final String bookmarkLink;
  final String searchType;
  final CardSwiperController? controller;

  @override
  State<SwipeScreen> createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  bool _isLoading = true;
  String _activeLink = '';
  List<BookmarkHtml> _bookmarks = [];
  final _userLocation = LocationService();
  late final RoutesService _routes;

  @override
  void initState() {
    super.initState();
    final apiKey = dotenv.env['ROUTES_API_KEY'] ?? '';
    if (kDebugMode) {
      debugPrint(
        'API Key loaded: ${apiKey.isNotEmpty ? "Yes (${apiKey.length} chars)" : "No"}',
      );
    }
    _routes = RoutesService(apiKey);
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
      debugPrint('Raw HTML length: ${raw.length}');

      final parsed = parseBookmarks(raw);
      debugPrint('Parsed bookmarks count: ${parsed.length}');

      final pos = await _userLocation.current();
      if (pos != null) {
        const int batchSize = 5;
        for (int i = 0; i < parsed.length; i += batchSize) {
          final batch = parsed.skip(i).take(batchSize).toList();
          await Future.wait(
            batch.map((b) async {
              try {
                final distanceResult = await _routes.distance(
                  originLat: pos.latitude,
                  originLng: pos.longitude,
                  destinationAddress: b.address,
                );
                b.distance = distanceResult;
                debugPrint('Distance to ${b.name}: ${distanceResult?.pretty}');
              } catch (e) {
                debugPrint('Failed to get distance for ${b.name}: $e');
              }
            }),
          );
        }
      }

      parsed.sort((a, b) {
        if (a.distance == null && b.distance == null) return 0;
        if (a.distance == null) return 1;
        if (b.distance == null) return -1;

        return a.distance!.meters.compareTo(b.distance!.meters);
      });

      setState(() {
        _bookmarks = parsed;
        _isLoading = false;
      });
    } catch (e, st) {
      debugPrint('Bookmark load failed: $e\n$st');
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _openInGoogleMaps(BookmarkHtml bookmark) async {
    try {
      final query = Uri.encodeComponent('${bookmark.name} ${bookmark.address}');

      final url = widget.searchType == 'Directions'
          ? 'https://www.google.com/maps/dir/?api=1&destination=$query'
          : 'https://www.google.com/maps/search/?api=1&query=$query';

      debugPrint('Attempting to open: $url');

      final uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
        debugPrint('Successfully launched Google Maps');
      } else {
        debugPrint('canLaunchUrl returned false for: $url');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open Google Maps')),
          );
        }
      }
    } catch (e) {
      debugPrint('Failed to open Google Maps: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error opening Google Maps')),
        );
      }
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
        onSwipe: (previousIndex, currentIndex, direction) {
          if (direction == CardSwiperDirection.right) {
            if (previousIndex >= 0 && previousIndex < _bookmarks.length) {
              _openInGoogleMaps(_bookmarks[previousIndex]);
            }
          }
          return true;
        },
        cardBuilder: (_, index, __, ___) =>
            CardContainer(bookmark: _bookmarks[index]),
      );
    }

    return Scaffold(
      body: SafeArea(child: Center(child: body)),
    );
  }
}
