import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:retroskiing/models/leaderboard_entry.dart';
import 'package:retroskiing/resources/globals.dart';
import 'package:retroskiing/resources/highscore_service.dart';
import 'package:retroskiing/resources/shared_preferences_service.dart';
import 'package:retroskiing/utils/constants.dart';
import 'package:retroskiing/utils/theme.dart';
import 'package:retroskiing/utils/utils.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:uuid/uuid.dart';

class AfterRacePage extends StatefulWidget {
  final int timeRace;
  const AfterRacePage({
    Key? key,
    required this.timeRace,
  }) : super(key: key);

  @override
  _AfterRaceState createState() => _AfterRaceState();
}

class _AfterRaceState extends State<AfterRacePage> {
  bool _gotNewhighscore = false;
  var _loading = false;

  final colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];

  final colorizeTextStyle = const TextStyle(
      fontSize: 40, fontFamily: 'Helvetica', fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    SharedPreferencesService().increaseScore(profileTime, widget.timeRace);
    getCurrentHighscore();
  }

  Future<void> getCurrentHighscore() async {
    setState(() {
      _gotNewhighscore = widget.timeRace < selectedRaceCurrentHighscore;
    });
    if (_gotNewhighscore && Utility.isUser()) {
      _updateHighscore();
      HighscoreService().setCurrentHighscore(selectedRace, widget.timeRace);
    }
  }

  Future<void> _updateHighscore() async {
    setState(() {
      _loading = true;
    });
    String userId = supabase.auth.currentUser!.id;
    final raceId = selectedRace;
    final response = await supabase
        .from('results')
        .select()
        .eq('user_id', userId)
        .eq('race_id', raceId)
        .execute();

    var _id = '';
    final error = response.error;
    if (error != null && response.status != 406) {
      context.showErrorSnackBar(message: error.message);
    }
    final data = response.data;
    if (data != null) {
      for (var entry in data) {
        _id = LeaderboardEntry.fromMap(entry).id!;
      }
    }
    if (_id.isEmpty) {
      _id = const Uuid().v4();
    }
    final updates = {
      'id': _id,
      'updated_at': DateTime.now().toIso8601String(),
      'user_id': userId,
      'race_id': raceId,
      'finished_time': widget.timeRace,
    };

    final responseUpsert =
        await supabase.from('results').upsert(updates).execute();
    final errorUpsert = responseUpsert.error;
    if (errorUpsert != null && response.status != 406) {
      context.showErrorSnackBar(message: errorUpsert.message);
    }

    setState(() {
      _loading = false;
    });
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
        child: Container(
          padding: const EdgeInsets.only(right: 24, left: 24),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Current Highscore: ",
                    style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                getSavedHighscoreTime(),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    "Your Time: ",
                    style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                getRaceTime(),
                Utility.isUser()
                    ? const SizedBox(
                        height: 1,
                      )
                    : const Text(
                        "Highscore will not be saved, because you aren't logged in",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                _gotNewhighscore
                    ? const Expanded(
                        flex: 6,
                        child: Align(
                          child: Text("congrats new best time 🚀"),
                        ),
                      )
                    : const Expanded(
                        flex: 6,
                        child: Align(
                          child: Text("c'mon you can do better ⛷️ "),
                        ),
                      ),
                _gotNewhighscore && Utility.isUser()
                    ? Text(_loading ? 'Saving Highscore' : 'Highscore saved!')
                    : const SizedBox(
                        height: 1,
                      ),
                const SizedBox(
                  height: 18.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        height: RetroSkiingStyle.buttonHeight,
                        decoration: BoxDecoration(
                          gradient: RetroSkiingStyle.gradient,
                          borderRadius: RetroSkiingStyle.borderRadius,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .popUntil(ModalRoute.withName('/race'));
                          },
                          child: const Text('Continue'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getSavedHighscoreTime() {
    String textHighScore = '--:--:--';
    if (selectedRaceCurrentHighscore != maxTimeResult) {
      textHighScore = StopWatchTimer.getDisplayTime(
          selectedRaceCurrentHighscore,
          hours: false);
    }
    if (_gotNewhighscore) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          textHighScore,
          style: const TextStyle(
              fontSize: 40,
              fontFamily: 'Helvetica',
              fontWeight: FontWeight.bold),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: AnimatedTextKit(animatedTexts: [
        ColorizeAnimatedText(
          textHighScore,
          textStyle: colorizeTextStyle,
          colors: colorizeColors,
        ),
      ]),
    );
  }

  Widget getRaceTime() {
    String textHighScore =
        StopWatchTimer.getDisplayTime(widget.timeRace, hours: false);
    if (_gotNewhighscore) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: AnimatedTextKit(animatedTexts: [
          ColorizeAnimatedText(
            textHighScore,
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
        ]),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        textHighScore,
        style: const TextStyle(
            fontSize: 40, fontFamily: 'Helvetica', fontWeight: FontWeight.bold),
      ),
    );
  }
}
