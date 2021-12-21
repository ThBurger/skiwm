import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiwm/components/stopwatch.dart';
import 'package:skiwm/training_game.dart';
import 'components/dialog.dart';
import 'helpers/joypad.dart';

enum GameState {
  init,
  start,
  playing,
  paused,
  gameOver,
  inFinish,
  finish,
}

class MainTrainingPage extends StatefulWidget {
  const MainTrainingPage({Key? key}) : super(key: key);

  @override
  MainTrainingState createState() => MainTrainingState();
}

class MainTrainingState extends State<MainTrainingPage> {
  GameState currentGameState = GameState.init;
  TrainingGame game = TrainingGame();
  GlobalKey<StopWatchState> _stopwatch = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        body: Stack(
          children: [
            GameWidget(game: game),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: IconButton(
                  icon: const Icon(Icons.pause),
                  highlightColor: Colors.pink,
                  onPressed: () {
                    currentGameState = GameState.paused;
                    _stopwatch.currentState?.stop();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AdvanceCustomAlert();
                        }).then((value) => {
                          if (value == null) {Get.back()}
                        });
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: StopWatchPage(key: _stopwatch),
              ),
            ),
            Visibility(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: ElevatedButton(
                    child: const Text('Start'),
                    onPressed: () {
                      currentGameState = GameState.playing;
                      _stopwatch.currentState?.start();
                    },
                  ),
                ),
              ),
              visible: currentGameState == GameState.init,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child:
                    Joypad(onDirectionChanged: game.onJoypadDirectionChanged),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: ElevatedButton(
                  child: const Text('Back'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            )
          ],
        ));
  }
}
