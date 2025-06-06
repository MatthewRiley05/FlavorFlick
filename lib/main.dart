import 'package:flavor_flick/screens/home_screen.dart';
import 'package:flavor_flick/services/prefs_helper.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlavorFlick',
      theme: ThemeData(useMaterial3: true),
      home: HomeScreen(),
    );
  }
}
