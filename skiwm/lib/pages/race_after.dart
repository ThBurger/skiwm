import 'package:flutter/material.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/resources/highscore_service.dart';
import 'package:skiwm/resources/shared_preferences_service.dart';
import 'package:skiwm/utils/constants.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class AfterRacePage extends StatefulWidget {
  final int timeRace; // doens
  const AfterRacePage({
    Key? key,
    required this.timeRace,
  }) : super(key: key);
  @override
  _AfterRaceState createState() => _AfterRaceState();
}

class _AfterRaceState extends State<AfterRacePage> {
  int _currentHighscore = 0;
  bool _highscore = false;
  var _loading = false;

  @override
  void initState() {
    super.initState();
    SharedPreferencesService().increaseScore('time', widget.timeRace);
    getCurrentHighscore();
  }

  Future<void> getCurrentHighscore() async {
    int __currentHighscore =
        await HighscoreService().getCurrentHighscore(selectedRace);
    setState(() {
      _currentHighscore = __currentHighscore;
      _highscore = _currentHighscore > widget.timeRace;
    });
    if (widget.timeRace < __currentHighscore) {
      _updateHighscore();
      HighscoreService().setCurrentHighscore(selectedRace, widget.timeRace);
    }
  }

  Future<void> _updateHighscore() async {
    setState(() {
      _loading = true;
    });
    final userId = supabase.auth.currentUser!.id;
    final raceId = selectedRace;
    var _id = '';
    final _leaderboardId = userLeaderboardEntries.where((element) =>
        element.raceId == selectedRace && element.userId == userId);
    if (_leaderboardId.isEmpty) {
      _id = const Uuid().v4();
    } else {
      _id = _leaderboardId.first.id!;
    }
    final updates = {
      'id': _id,
      'updated_at': DateTime.now().toIso8601String(),
      'user_id': userId,
      'race_id': raceId,
      'finished_time': widget.timeRace,
    };
    final response = await supabase.from('results').upsert(updates).execute();
//    final error = response.error; // TODO erroR?
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
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  StopWatchTimer.getDisplayTime(_currentHighscore,
                      hours: false),
                  style: const TextStyle(
                      fontSize: 40,
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.bold),
                ),
              ),
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
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  StopWatchTimer.getDisplayTime(widget.timeRace, hours: false),
                  style: const TextStyle(
                      fontSize: 40,
                      fontFamily: 'Helvetica',
                      fontWeight: FontWeight.bold),
                ),
              ),
              _highscore
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
              _highscore
                  ? Text(_loading ? 'Saving Highscore' : 'Highscore saved!')
                  : const SizedBox(
                      height: 18.0,
                    ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil(ModalRoute.withName('/race'));
                },
                child: const Text('Back To Race'),
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
