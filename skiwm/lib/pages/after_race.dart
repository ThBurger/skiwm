import 'package:flutter/material.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/resources/highscore_service.dart';

class AfterRacePage extends StatefulWidget {
  const AfterRacePage({Key? key}) : super(key: key);
  @override
  _AfterRaceState createState() => _AfterRaceState();
}

class _AfterRaceState extends State<AfterRacePage> {
  bool highscore = false;
  int timeRace = stopwatch.currentState!.getTime();

  @override
  void initState() {
    super.initState();
    checkHighscore();
  }

  Future<void> checkHighscore() async {
    highscore = await HighscoreService()
        .checkHighscore('96be68d8-e768-4af3-a430-39299f06a6fd', timeRace);
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
              highscore
                  ? const Expanded(
                      flex: 6,
                      child: Align(
                        child:
                            Text("congrats new best time 🚀 savig score ..."),
                      ),
                    )
                  : const Expanded(
                      flex: 6,
                      child: Align(
                        child: Text(
                            "your time ... and your best time ... c'mon you can do it "),
                      ),
                    ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .popUntil(ModalRoute.withName('/loading'));
                },
                // TODO Unhandled Exception: setState() called after dispose(): LoadingState#7908b(lifecycle state: defunct, not mounted)
                child: const Text('Retry'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil(ModalRoute.withName('/menu'));
                },
                child: const Text('Back To Menu'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
