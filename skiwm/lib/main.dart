import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiwm/pages/Menu.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SKI-WM',
      home: MenuPage(),
    );
  }
}
