import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retroskiing/components/world_collidable.dart';
import 'package:retroskiing/components/world_finish.dart';
import 'package:retroskiing/helpers/map_loader.dart';
import 'package:retroskiing/race_game_main.dart';
import 'package:retroskiing/resources/globals.dart';
import 'package:retroskiing/resources/highscore_service.dart';
import 'package:retroskiing/resources/shared_preferences_service.dart';
import 'package:retroskiing/utils/constants.dart';
import 'package:retroskiing/utils/theme.dart';
import 'package:retroskiing/utils/utils.dart';

class LoadingPage extends StatefulWidget {
  final String title;
  final String raceId;
  const LoadingPage(this.title, this.raceId, {UniqueKey? key})
      : super(key: key);

  @override
  LoadingState createState() => LoadingState();
}

class LoadingState extends State<LoadingPage> with TickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    selectedRace = widget.raceId;
    animationController =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    animationController.repeat();
    SharedPreferencesService().increaseScore(profileRaces, 1);
    _loadCurrentHighscore();
    _loadCollidables();
    super.initState();
  }

  Future<void> _loadCollidables() async {
    List<Rect> listGates = List.empty(growable: true);
    List<Rect> listFinish = List.empty(growable: true);
    collidableGates = List.empty(growable: true);
    collidableFinish = List.empty(growable: true);
    if (widget.raceId == uuidRaceWengen) {
      listGates = (await MapLoader.readCollisionMap(
          'assets/Wengen_Race_Collisions.json'));
      listFinish =
          (await MapLoader.readCollisionMap('assets/Wengen_Race_Finish.json'));
    } else if (widget.raceId == uuidTraining1) {
      listGates = (await MapLoader.readCollisionMap(
          'assets/Training_1_Collisions.json'));
      listFinish =
          (await MapLoader.readCollisionMap('assets/Training_1_Finish.json'));
    } else if (widget.raceId == uuidTraining2) {
      listGates = (await MapLoader.readCollisionMap(
          'assets/Training_2_Collisions.json'));
      listFinish =
          (await MapLoader.readCollisionMap('assets/Training_2_Finish.json'));
    }
    for (var rect in listGates) {
      collidableGates.add(WorldCollidable()
        ..position = Vector2(rect.left, rect.top)
        ..width = rect.width
        ..height = rect.height);
    }
    for (var rect in listFinish) {
      collidableFinish.add(WorldFinish()
        ..position = Vector2(rect.left, rect.top)
        ..width = rect.width
        ..height = rect.height);
    }
  }

  Future<void> _loadCurrentHighscore() async {
    selectedRaceCurrentHighscore =
        await HighscoreService().getCurrentHighscore(selectedRace);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      if (widget.raceId == uuidTraining2) {
        Navigator.of(context).popUntil(ModalRoute.withName('/race'));
        Get.to(const RaceGamePage(
          mapPic: 'Training_2.png',
          playerX: 300,
          playerY: 150,
        ));
      } else if (widget.raceId == uuidTraining1) {
        Navigator.of(context).popUntil(ModalRoute.withName('/race'));
        Get.to(const RaceGamePage(
          mapPic: 'Training_1.png',
          playerX: 300,
          playerY: 150,
        ));
      } else if (widget.raceId == uuidRaceWengen) {
        Navigator.of(context).popUntil(ModalRoute.withName('/race'));
        Get.to(const RaceGamePage(
          mapPic: 'Race_Wengen.png',
          playerX: 1600,
          playerY: 350,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('cant load race - contact the admin'),
            duration: Duration(milliseconds: 1500),
          ),
        );
        Navigator.pop(context);
      }
    });

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
                  child: Text("preparing slope..."),
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
          ),
        ),
      ),
    );
  }
}
