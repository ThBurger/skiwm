import 'package:flutter/material.dart';
import 'package:skiwm/models/race.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/utils/theme.dart';
import 'package:skiwm/widgets/credit.dart';
import 'package:skiwm/widgets/daily_credits.dart';
import 'package:skiwm/widgets/daily_task_finished.dart';
import 'package:skiwm/widgets/daily_task_started.dart';
import 'package:skiwm/widgets/drawer.dart';
import 'package:skiwm/widgets/race_item.dart';

class MenuPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _key,
      drawer: buildDrawer(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _key.currentState!.openDrawer();
          },
        ),
        actions: const [CreditChip(), SizedBox(width: 15)],
      ),
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
                    color: SkiWmColors.white,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 8),
                const DailyCredit(),
                const SizedBox(height: 8),
                const Text(
                  "Races",
                  style: TextStyle(
                    color: SkiWmColors.white,
                    fontSize: 22,
                  ),
                ),
                buildRaceList(context, racesPlayable),
                const SizedBox(height: 8.0),
                const Text(
                  "Trainings",
                  style: TextStyle(
                    color: SkiWmColors.white,
                    fontSize: 22,
                  ),
                ),
                buildRaceList(context, trainings),
                const SizedBox(height: 8.0),
                const Text(
                  "Daily Tasks",
                  style: TextStyle(
                    color: SkiWmColors.white,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 8),
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
      height: MediaQuery.of(context).size.height * 0.4,
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
