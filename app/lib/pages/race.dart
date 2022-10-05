import 'package:flutter/material.dart';
import 'package:retroskiing/models/race.dart';
import 'package:retroskiing/resources/globals.dart';
import 'package:retroskiing/utils/theme.dart';
import 'package:retroskiing/widgets/daily_credits.dart';
import 'package:retroskiing/widgets/daily_task_finished.dart';
import 'package:retroskiing/widgets/daily_task_started.dart';
import 'package:retroskiing/widgets/race_item.dart';

class RacePage extends StatelessWidget {
  const RacePage({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.only(right: 12, left: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Credits",
                  style: TextStyle(
                    color: RetroSkiingColors.white,
                    fontSize: 22,
                  ),
                ),
                const DailyCredit(),
                const SizedBox(height: 18),
                const Text(
                  "Races",
                  style: TextStyle(
                    color: RetroSkiingColors.white,
                    fontSize: 22,
                  ),
                ),
                buildRaceList(context, racesPlayable),
                const SizedBox(height: 8.0),
                const Text(
                  "Trainings",
                  style: TextStyle(
                    color: RetroSkiingColors.white,
                    fontSize: 22,
                  ),
                ),
                buildRaceList(context, trainings),
                const SizedBox(height: 8.0),
                const Text(
                  "Daily Tasks",
                  style: TextStyle(
                    color: RetroSkiingColors.white,
                    fontSize: 22,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    DailyTaskStartedComponent(),
                    DailyTaskFinishedComponent(),
                  ],
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildRaceList(BuildContext context, List<Race> races) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.4,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: races.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: RaceItemComponent(raceItem: races[index]),
          );
        },
      ),
    );
  }
}
