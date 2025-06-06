import 'package:flavor_flick/screens/history_screen.dart';
import 'package:flavor_flick/screens/settings_screen.dart';
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
  late final CardSwiperController _cardController;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _cardController = CardSwiperController();
    _screens = <Widget>[
      SwipeScreen(controller: _cardController),
      const HistoryScreen(),
      const SettingsScreen(),
    ];
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
          IconButton(
            icon: const Icon(Icons.replay),
            onPressed: () {
              if (_selectedIndex == 0) {
                _cardController.undo();
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const <NavigationDestination>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.history), label: 'History'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
      ),
      body: IndexedStack(index: _selectedIndex, children: _screens),
    );
  }
}
