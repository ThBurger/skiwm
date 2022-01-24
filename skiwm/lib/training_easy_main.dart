import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiwm/components/dialog_start.dart';
import 'package:skiwm/components/stopwatch.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/training_easy.dart';
import 'package:skiwm/utils/constants.dart';
import 'components/dialog_pause.dart';

class TrainingEasyPage extends StatefulWidget {
  const TrainingEasyPage({Key? key}) : super(key: key);

  @override
  TrainingEasyState createState() => TrainingEasyState();
}

class TrainingEasyState extends State<TrainingEasyPage> {
  TrainingEasyGame game = TrainingEasyGame();
  GameState currentGameState = GameState.init;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const StartDialog();
          }).then((value) => {
            //playerStart()
          });
    });
  }

  void onTapDown(BuildContext context, TapDownDetails details) {
    if (currentGameState == GameState.init) {
      currentGameState = GameState.playing;
      game.onGameStateChanged(currentGameState);
      stopwatch.currentState?.start();
      game.playerStart();
    } else {
      if (details.globalPosition.dx < MediaQuery.of(context).size.width / 2) {
        game.playerLeft();
      } else {
        game.playerRight();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
      body: GestureDetector(
        onTapDown: (details) => onTapDown(context, details),
        child: Stack(
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
                    game.onGameStateChanged(currentGameState);
                    stopwatch.currentState?.stop();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const PauseDialog();
                        }).then((value) => {
                          if (value == null) {Get.back()}
                        });
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: StopWatchPage(key: stopwatch),
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
        ),
      ),
    );
  }
}
