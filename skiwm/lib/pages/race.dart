import 'package:flutter/material.dart';
import 'package:skiwm/models/race.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/utils/constants.dart';
import 'package:skiwm/widgets/daily_credits.dart';
import 'package:skiwm/widgets/daily_task_item.dart';
import 'package:skiwm/widgets/race_item.dart';

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
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Credits",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
                const DailyCredit(),
                const SizedBox(height: 18),
                const Text(
                  "Races",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
                buildRaceList(context, racesPlayable),
                const SizedBox(height: 8.0),
                const Text(
                  "Trainings",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
                buildRaceList(context, trainings), const SizedBox(height: 8.0),
                const Text(
                  "Daily Tasks",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    DailyTaskComponent(
                      task: DAILY_RACE_STARTED,
                      count: 5,
                    ),
                    DailyTaskComponent(
                      task: DAILY_RACE_FINISHED,
                      count: 3,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                // const SizedBox(height: 10.0),
                // const Text(
                //   "Made with ❤ by Toburg Labs.",
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(height: 10.0),
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
