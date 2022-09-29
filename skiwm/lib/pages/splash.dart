import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skiwm/components/auth_state.dart';
import 'package:skiwm/models/race.dart';
import 'package:skiwm/resources/daily_task_service.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/utils/constants.dart';
import 'package:skiwm/utils/theme.dart';
import 'package:skiwm/utils/value_notifiers.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends AuthState<SplashPage>
    with TickerProviderStateMixin {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  bool _hasInternet = true;
  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    animationController.repeat();
    _loadDailyTasks();
    _loadOptions();
    _checkInternet().then((value) => {
          if (_hasInternet)
            {
              _loadRaceData().then((value) => {recoverSupabaseSession()})
            }
        });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Future<void> _checkInternet() async {
    bool __hasInternet = false;
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        __hasInternet = true;
      }
    } on SocketException catch (_) {
      __hasInternet = false;
    }
    setState(() {
      _hasInternet = __hasInternet;
    });
  }

  Future<void> _loadDailyTasks() async {
    dailyTaskStartedValueNotifier.value =
        await TaskService().getCurrentTaskScore(dailyRaceStarted);
    dailyTaskFinishedValueNotifier.value =
        await TaskService().getCurrentTaskScore(dailyRaceFinished);
  }

  Future<void> _loadOptions() async {
    final SharedPreferences prefs = await _prefs;
    showOnboarding = !(prefs.getBool('onboardingDone') ?? false);
    isMusic = (prefs.getBool('music') ?? false);
    isSoundFx = (prefs.getBool('soundfx') ?? false);
    isDarkMode = (prefs.getBool('darkmode') ?? false);
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasInternet) {
      // not yet perfect working TODO
      return _noInternetWidget();
    }
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
                          begin: SkiWmColors.primary, end: SkiWmColors.label)),
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
    if (!_hasInternet) {
      return;
    }
    final response = await supabase.from('races').select().execute();
    final error = response.error;
    if (error != null && response.status != 406) {
      context.showErrorSnackBar(message: error.message);
    }
    final data = response.data;
    if (data != null) {
      for (var race in data) {
        Race r = Race.fromMap(race);
        racesAndTrainings.add(r);
        if (r.training!) {
          trainings.add(r);
        } else {
          if (DateTime.now().isBefore(r.tillDate!) &&
              racesPlayable.length <= 5) {
            racesPlayable.add(r);
          }
          races.add(r);
        }
      }
    }
    await Future.delayed(const Duration(seconds: 2));
  }

  Widget _noInternetWidget() {
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
                  child: Icon(FontAwesomeIcons.wifi),
                ),
              ),
              const Expanded(
                flex: 6,
                child: Align(
                  child: Text("no internet connection..."),
                ),
              ),
              const Expanded(
                flex: 6,
                child: Align(
                  child: Text("please make sure you have a connections..."),
                ),
              ),
              const Expanded(
                flex: 6,
                child: Align(
                  child: Text("and restart the game"),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: SkiWmStyle.buttonHeight,
                      decoration: BoxDecoration(
                        gradient: SkiWmStyle.gradient,
                        borderRadius: SkiWmStyle.borderRadius,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (Platform.isAndroid) {
                            SystemNavigator.pop();
                          } else if (Platform.isIOS) {
                            exit(0);
                          }
                        },
                        child: const Text('Exit App'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
