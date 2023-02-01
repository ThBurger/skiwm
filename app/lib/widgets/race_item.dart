import 'package:flutter/material.dart';
import 'package:retroskiing/models/race.dart';
import 'package:retroskiing/resources/highscore_service.dart';
import 'package:retroskiing/utils/constants.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class RaceItemComponent extends StatefulWidget {
  final Race raceItem;

  const RaceItemComponent({
    Key? key,
    required this.raceItem,
  }) : super(key: key);

  @override
  _RaceItemComponentState createState() => _RaceItemComponentState();
}

class _RaceItemComponentState extends State<RaceItemComponent> {
  String _textHighScore = '--:--:--';

  Future<void> _loadHighscore() async {
    int selectedRaceCurrentHighscore =
        await HighscoreService().getCurrentHighscore(widget.raceItem.id!);

    if (selectedRaceCurrentHighscore != maxTimeResult) {
      setState(() {
        _textHighScore = StopWatchTimer.getDisplayTime(
            selectedRaceCurrentHighscore,
            hours: false);
      });
    }
  }

  @override
  void initState() {
    _loadHighscore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.7,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/race',
              arguments: widget.raceItem,
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 3.0,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      child: Hero(
                        tag: widget.raceItem.id!,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0),
                              ),
                              child: Image.asset(
                                'assets/images/snow_race.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 6.0,
                      right: 6.0,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            " ${widget.raceItem.raceType!} ",
                            style: const TextStyle(
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    buildRaceWidget(),
                  ],
                ),
                const SizedBox(height: 7.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      widget.raceItem.racename!,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                const SizedBox(height: 7.0),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      "Currently race time: " + _textHighScore,
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildRaceWidget() {
    return Positioned(
      top: 6.0,
      left: 6.0,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.0)),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: const [
              Text(
                ' OPEN',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
