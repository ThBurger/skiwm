import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:skiwm/components/dialog_start.dart';
import 'package:skiwm/components/stopwatch.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/training_soelden.dart';
import 'package:skiwm/utils/constants.dart';
import 'components/dialog_pause.dart';

class TrainingSoeldenPage extends StatefulWidget {
  const TrainingSoeldenPage({Key? key}) : super(key: key);

  @override
  TrainingSoeldenState createState() => TrainingSoeldenState();
}

class TrainingSoeldenState extends State<TrainingSoeldenPage> {
  TrainingSoeldenGame game = TrainingSoeldenGame();

  @override
  void initState() {
    super.initState();
    gameState = GameState.init;
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return const StartDialog();
          });
    });
  }

  void onTapDown(BuildContext context, TapDownDetails details) {
    if (gameState == GameState.init) {
      gameState = GameState.playing;
      game.onGameStateChanged();
      stopwatch.currentState?.start();
      game.playerStart();
    } else if (gameState == GameState.playing) {
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
                    gameState = GameState.paused;
                    game.onGameStateChanged();
                    stopwatch.currentState?.stop();
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return const PauseDialog();
                        }).then((value) => {
                          if (value == 'continue')
                            {
                              gameState = GameState.playing,
                              game.onGameStateChanged(),
                              stopwatch.currentState?.start()
                            }
                        });
                  },
                ),
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomLeft,
            //   child: Padding(
            //     padding: const EdgeInsets.all(32.0),
            //     child: IconButton(
            //       icon: const Icon(Icons.exit_to_app),
            //       highlightColor: Colors.pink,
            //       onPressed: () {
            //         gameState = GameState.finish;
            //         game.onGameStateChanged();
            //         stopwatch.currentState?.stop();
            //         Get.to(AfterRacePage(
            //           timeRace: stopwatch.currentState!.getTime(),
            //         ));
            //       },
            //     ),
            //   ),
            // ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: StopWatchPage(key: stopwatch),
              ),
            )
          ],
        ),
      ),
    );
  }
}