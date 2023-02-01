import 'package:flutter/material.dart';
import 'package:retroskiing/resources/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:retroskiing/resources/globals.dart';
import 'package:retroskiing/utils/constants.dart';
import 'package:retroskiing/utils/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    animationController.repeat();
    _loadUser();
    _loadOptions();
    _loadRaceData();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> _loadUser() async {
    final SharedPreferences prefs = await _prefs;
    userNameGlobal = prefs.getString(profileUsername) ?? userNameGlobal;
    userCountryGlobal = prefs.getString(profileCountry) ?? userCountryGlobal;
  }

  Future<void> _loadOptions() async {
    final SharedPreferences prefs = await _prefs;
    showOnboarding = !(prefs.getBool('onboardingDone') ?? false);
    isMusic = (prefs.getBool('music') ?? false);
    isSoundFx = (prefs.getBool('soundfx') ?? false);
    isDarkMode = (prefs.getBool('darkmode') ?? false);

    if (showOnboarding) {
      // first start = get 50 credits
      SharedPreferencesService().increaseCredits(50);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Expanded(
              flex: 12,
              child: Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/skier.png"),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            const Expanded(
              flex: 6,
              child: Align(
                child: Text("getting ready..."),
              ),
            ),
            Expanded(
              flex: 4,
              child: Align(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Colors.green,
                      valueColor: animationController.drive(ColorTween(
                          begin: RetroSkiingColors.primary,
                          end: RetroSkiingColors.label)),
                      minHeight: 7,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Future<void> _loadRaceData() async {
    for (var race in racesList) {
      racesAndTrainings.add(race);
      if (race.training!) {
        trainings.add(race);
      } else {
        racesPlayable.add(race);
      }
    }
    await Future.delayed(const Duration(seconds: 2));
    String nextRoute = showOnboarding ? '/onboarding' : '/menu';
    Navigator.of(context).pushNamedAndRemoveUntil(nextRoute, (route) => false);
  }
}
