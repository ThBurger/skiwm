import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/resources/shared_preferences_service.dart';
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
    SharedPreferencesService().increaseScore('races', 1);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('was here!!!!');
    Future.delayed(const Duration(seconds: 3), () {
      //TODO id better
      if (widget.title == 'Bormio') {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/trainig_easy', ModalRoute.withName('/race'));
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
