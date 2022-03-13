import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiwm/components/dialog_start.dart';
import 'package:skiwm/components/stopwatch.dart';
import 'package:skiwm/training_game.dart';
import 'package:skiwm/utils/constants.dart';
import 'components/dialog_pause.dart';

class MainTrainingPage extends StatefulWidget {
  const MainTrainingPage({Key? key}) : super(key: key);

  @override
  MainTrainingState createState() => MainTrainingState();
}

class MainTrainingState extends State<MainTrainingPage> {
  GameState currentGameState = GameState.init;
  TrainingGame game = TrainingGame();
  final GlobalKey<StopWatchState> _stopwatch = GlobalKey();

  @override
  void initState() {
    super.initState();
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
    if (details.globalPosition.dx < MediaQuery.of(context).size.width / 2) {
      game.playerLeft();
    } else {
      game.playerRight();
    }
  }

  void playerStart() {
    game.playerStart();
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
                    _stopwatch.currentState?.stop();
                    showDialog(
                        barrierDismissible: false,
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
                child: StopWatchPage(key: _stopwatch),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
