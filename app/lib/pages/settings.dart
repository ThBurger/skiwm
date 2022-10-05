import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:retroskiing/resources/globals.dart';
import 'package:retroskiing/utils/theme.dart';
import 'package:retroskiing/widgets/credit.dart';
import 'package:retroskiing/widgets/drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  Future<bool> saveSwitchState(String name, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(name, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
      drawer: buildDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
        actions: const [CreditChip(), SizedBox(width: 15)],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 50.0),
              Card(
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 0,
                ),
                child: Column(
                  children: <Widget>[
                    SwitchListTile(
                      activeColor: RetroSkiingColors.primary,
                      value: isMusic,
                      title: const Text("Music"),
                      onChanged: (bool value) {
                        setState(() {
                          isMusic = value;
                          saveSwitchState('music', value);
                        });
                      },
                    ),
                    _buildDivider(),
                    SwitchListTile(
                      // TODO
                      activeColor: RetroSkiingColors.primary,
                      value: isSoundFx,
                      title: const Text("Sound FX"),
                      onChanged: (bool value) {
                        setState(() {
                          isSoundFx = value;
                          saveSwitchState('soundfx', value);
                        });
                      },
                    ),
                    _buildDivider(),
                    SwitchListTile(
                      // TODO
                      activeColor: RetroSkiingColors.primary,
                      value: isDarkMode,
                      title: const Text("Dark Mode"),
                      onChanged: (bool value) {
                        setState(() {
                          isDarkMode = value;
                          saveSwitchState('darkmode', value);
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18.0),
              Container(
                height: RetroSkiingStyle.buttonHeight,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: RetroSkiingStyle.gradient,
                  borderRadius: RetroSkiingStyle.borderRadius,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/onboarding');
                  },
                  child: const Text('Show Tutorial'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade300,
    );
  }
}
