import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiwm/pages/account.dart';
import 'package:skiwm/pages/race_after.dart';
import 'package:skiwm/pages/login.dart';
import 'package:skiwm/pages/menu.dart';
import 'package:skiwm/pages/race_start.dart';
import 'package:skiwm/pages/settings.dart';
import 'package:skiwm/pages/splash.dart';
import 'package:skiwm/training_easy_main.dart';
import 'package:skiwm/utils/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ski WM',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: SkiWmColors.info,
            primary: SkiWmColors.primary,
          ),
        ),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/menu': (_) => const MenuPage(),
        '/race': (_) => const RaceStartPage(),
        '/setting': (_) => const SettingsPage(),
        '/login': (_) => const LoginPage(),
        '/account': (_) => const AccountPage(),
        '/trainig_easy': (_) => const TrainingEasyPage(),
        '/afterrace': (_) => const AfterRacePage(),
      },
    );
  }
}
