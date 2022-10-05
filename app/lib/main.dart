import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:retroskiing/pages/account.dart';
import 'package:retroskiing/pages/onboarding.dart';
import 'package:retroskiing/pages/race_after.dart';
import 'package:retroskiing/pages/login.dart';
import 'package:retroskiing/pages/menu.dart';
import 'package:retroskiing/pages/race_leaderboard.dart';
import 'package:retroskiing/pages/race_start.dart';
import 'package:retroskiing/pages/settings.dart';
import 'package:retroskiing/pages/splash.dart';
import 'package:retroskiing/race_game_main.dart';
import 'package:retroskiing/utils/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Supabase.initialize(
    url: 'https://xakuozmtkrvgebyvriiq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlIjoiYW5vbiIsImlhdCI6MTY0MDcxMjM1NywiZXhwIjoxOTU2Mjg4MzU3fQ.WUFdHin4ASWB_6c-HXvolfEhW49mbX_JZaloBEwoIt0',
  );
  await Flame.device.fullScreen();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

// TODO
  // theme: ThemeData(
  //   textTheme:
  //        GoogleFonts.varelaRoundTextTheme(Theme.of(context).textTheme),
  // ),
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
        '/race_leaderboard': (_) => const RaceLeaderboardPage(),
        '/setting': (_) => const SettingsPage(),
        '/login': (_) => const LoginPage(),
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
