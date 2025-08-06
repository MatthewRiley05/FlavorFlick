import 'package:flavor_flick/screens/home_screen.dart';
import 'package:flavor_flick/services/prefs_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefService.init();
  await dotenv.load();
  runApp(const MyApp());
}

PageTransitionsTheme get defaultPageTransitionsTheme {
  return const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlavorFlick',
      theme: ThemeData(
        useMaterial3: true,
        pageTransitionsTheme: defaultPageTransitionsTheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        pageTransitionsTheme: defaultPageTransitionsTheme,
      ),
      themeMode: ThemeMode.system,
      home: HomeScreen(),
    );
  }
}
