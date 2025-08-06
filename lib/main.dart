import 'package:flavor_flick/modules/home/src/screens/home_screen.dart';
import 'package:flavor_flick/services/prefs_helper.dart';
import 'package:flavor_flick/services/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefService.init();
  await dotenv.load();
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const FlavorFlickApp(),
    ),
  );
}

PageTransitionsTheme get defaultPageTransitionsTheme {
  return const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
    },
  );
}

class FlavorFlickApp extends StatelessWidget {
  const FlavorFlickApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeNotifier>().themeMode;

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
      themeMode: themeMode,
      home: HomeScreen(),
    );
  }
}
