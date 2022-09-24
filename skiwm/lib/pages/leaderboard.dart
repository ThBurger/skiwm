import 'package:flutter/material.dart';
import 'package:skiwm/models/race.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/utils/theme.dart';
import 'package:skiwm/widgets/credit.dart';
import 'package:skiwm/widgets/drawer.dart';
import 'package:skiwm/widgets/results.dart';
import 'package:dropdown_search/dropdown_search.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String _chosenRaceId = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      extendBodyBehindAppBar: true,
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
          padding: const EdgeInsets.only(right: 24, left: 24, bottom: 12),
          child: Column(
            children: [
              const SizedBox(height: 50),
              const SizedBox(height: 8.0),
              DropdownSearch<Race>(
                  showSelectedItems: true,
                  compareFn: (i, s) => i?.isEqual(s) ?? false,
                  validator: (v) => v == null ? "required field" : null,
                  dropdownSearchDecoration: const InputDecoration(
                    hintText: 'Select a race',
                    labelText: 'Select a race',
                    labelStyle: TextStyle(color: SkiWmColors.white),
                    hintStyle: TextStyle(color: SkiWmColors.white),
                    contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: SkiWmColors.white)), // TODO white
                  ),
                  mode: Mode.BOTTOM_SHEET,
                  items: racesAndTrainings,
                  itemAsString: (Race? r) => r!.racename!,
                  onChanged: (Race? data) => {
                        setState(() {
                          _chosenRaceId = data!.id!;
                        })
                      }),
              const Divider(),
              const SizedBox(height: 8.0),
              ResultPage(
                  key: ValueKey<String>(_chosenRaceId), raceId: _chosenRaceId),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
