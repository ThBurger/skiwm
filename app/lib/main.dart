import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:retroskiing/pages/account.dart';
import 'package:retroskiing/pages/onboarding.dart';
import 'package:retroskiing/pages/race_after.dart';
import 'package:retroskiing/pages/menu.dart';
import 'package:retroskiing/pages/race_start.dart';
import 'package:retroskiing/pages/settings.dart';
import 'package:retroskiing/pages/splash.dart';
import 'package:retroskiing/race_game_main.dart';
import 'package:retroskiing/utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Flame.device.fullScreen();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ski WM',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: RetroSkiingStyle.borderRadius),
          ),
        ),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/onboarding': (_) => const OnBoardingPage(),
        '/menu': (_) => MenuPage(),
        '/race': (_) => const RaceStartPage(),
        '/setting': (_) => const SettingsPage(),
        '/account': (_) => const AccountPage(),
        '/race_game': (_) => const RaceGamePage(
              mapPic: '',
              playerX: 0,
              playerY: 0,
            ),
        '/afterrace': (_) => const AfterRacePage(
              timeRace: 0,
            ),
      },
    );
  }
}
