import 'package:flavor_flick/screens/history_screen.dart';
import 'package:flavor_flick/modules/settings/src/screens/settings_screen.dart';
import 'package:flavor_flick/screens/swipe_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String bookmarkLink = "";
  String _searchType = "Directions";
  late final CardSwiperController _cardController;

  @override
  void initState() {
    super.initState();
    _cardController = CardSwiperController();
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updateBookmarkLink(String newLink) {
    setState(() {
      bookmarkLink = newLink;
    });
  }

  void _updateSearchType(String searchType) {
    setState(() {
      _searchType = searchType;
    });
  }

  List<Widget> get _screens => [
    SwipeScreen(
      key: ValueKey('$bookmarkLink-$_searchType'),
      searchType: _searchType,
      bookmarkLink: bookmarkLink,
      controller: _cardController,
    ),
    const HistoryScreen(),
    SettingsScreen(
      onBookmarkSubmitted: _updateBookmarkLink,
      onSearchTypeChanged: _updateSearchType,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Image(
          image: AssetImage("assets/icon/FlavorFlick.png"),
          height: 32,
        ),
        centerTitle: true,
        actions: [
          if (_selectedIndex == 0) ...{
            IconButton(
              icon: const Icon(Icons.replay),
              tooltip: 'Undo',
              onPressed: () => _cardController.undo(),
            ),
          },
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: <NavigationDestination>[
          NavigationDestination(
            icon: Icon(
              _selectedIndex == 0 ? Icons.home_rounded : Icons.home_outlined,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              _selectedIndex == 1
                  ? Icons.history_rounded
                  : Icons.history_outlined,
            ),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(
              _selectedIndex == 2
                  ? Icons.settings_rounded
                  : Icons.settings_outlined,
            ),
            label: 'Settings',
          ),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
      ),
      body: IndexedStack(index: _selectedIndex, children: _screens),
    );
  }
}
