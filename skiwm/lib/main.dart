import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiwm/pages/AccountPage.dart';
import 'package:skiwm/pages/LoginPage.dart';
import 'package:skiwm/pages/MenuPage.dart';
import 'package:skiwm/pages/SettingsPage.dart';
import 'package:skiwm/pages/SplashPage.dart';
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
      title: 'Ski WM',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.green,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: Colors.green,
          ),
        ),
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const SplashPage(),
        '/menu': (_) => const MenuPage(),
        '/setting': (_) => const SettingsPage(),
        '/login': (_) => const LoginPage(),
        '/account': (_) => const AccountPage(),
      },
    );
  }
}
