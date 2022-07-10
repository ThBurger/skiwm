import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:skiwm/components/world_collidable.dart';
import 'package:skiwm/helpers/map_loader.dart';
import 'package:skiwm/resources/daily_task_service.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/resources/highscore_service.dart';
import 'package:skiwm/resources/shared_preferences_service.dart';
import 'package:skiwm/utils/constants.dart';
import 'package:skiwm/utils/theme.dart';

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
    SharedPreferencesService().increaseScore(PROFILE_RACES, 1);
    TaskService().increaseCurrentTaskScore(DAILY_RACE_STARTED);
    _loadCurrentHighscore();
    _loadCollidables();
    super.initState();
  }

  Future<void> _loadCollidables() async {
    if (widget.raceId == '4cfdc5e0-2bbc-46c5-93c3-473e6cbcda2a') {
      List<Rect> list = (await MapLoader.readCollisionMap(
          'assets/Wengen_Race_Collisions.json'));
      for (var rect in list) {
        collidableGates.add(WorldCollidable()
          ..position = Vector2(rect.left + 25,
              rect.top + 36) // TODO nachbesern, auch anders handy?
          ..width = rect.width
          ..height = rect.height);
      }
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
      if (widget.raceId == '8816a988-7815-41da-b9f1-71fa78f7e977') {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/trainig_soelden', ModalRoute.withName('/race'));
      } else if (widget.raceId == '4cfdc5e0-2bbc-46c5-93c3-473e6cbcda2a') {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/race_wengen', ModalRoute.withName('/race'));
      } else if (widget.title == 'Bormio') {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/trainig_easy', ModalRoute.withName('/race'));
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/trainig_easy', ModalRoute.withName('/race'));
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
                            begin: SkiWmColors.primary,
                            end: SkiWmColors.label)),
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
