import 'package:flutter/material.dart';
import 'package:skiwm/models/leaderboard_entry.dart';
import 'package:skiwm/models/race.dart';
import 'package:skiwm/network/leaderboard_repository.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/utils/constants.dart';
import 'package:skiwm/widgets/results.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:uuid/uuid.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final LeaderBoardRepository _repository = LeaderBoardRepository();
  String _chosenRaceId = '';
  bool _isLoading = false;

  Future<void> _newEntry() async {
    setState(() {
      _isLoading = true;
    });
    String id = '';
    List<LeaderboardEntry> userEntries = userLeaderboard
        .where((element) => element.raceId == _chosenRaceId)
        .toList();
    if (userEntries.isNotEmpty && userEntries.length == 1) {
      id = userEntries[0].id!;
    } else {
      id = const Uuid().v4();
    }
    final user = supabase.auth.currentUser;
    final userId =
        user != null ? user.id : '7e4f7c5b-504d-4851-b25c-1553cb4d4dfc'; // TODO
    final entry = LeaderboardEntry(
        id: id,
        userId: userId,
        raceId: _chosenRaceId,
        updatedAt: DateTime.now(),
        finishedTime: '00:15:15');
    await _repository.setLeaderboardEntry(entry);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Leaderboards',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.only(right: 24, left: 24, bottom: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Select Race",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8.0),
                DropdownSearch<Race>(
                    showSelectedItems: true,
                    compareFn: (i, s) => i?.isEqual(s) ?? false,
                    validator: (v) => v == null ? "required field" : null,
                    dropdownSearchDecoration: const InputDecoration(
                      hintText: "Select a race",
                      labelText: "Race",
                      contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                      border: OutlineInputBorder(),
                    ),
                    mode: Mode.MENU,
                    items: races,
                    itemAsString: (Race? r) => r!.racename!,
                    onChanged: (Race? data) => {
                          setState(() {
                            _chosenRaceId = data!.id!;
                          })
                        }),
                const Divider(),
                const SizedBox(height: 8.0),
                ResultPage(
                    key: ValueKey<String>(_chosenRaceId),
                    raceId: _chosenRaceId),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: _isLoading ? null : _newEntry,
                  child: Text(_isLoading ? 'Loading' : 'Add Test Entry'),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  "Made with ❤ by Toburg Labs.",
                  textAlign: TextAlign.center,
                ),
                //const SizedBox(height: 8.0),
                // ProductCarousel(imgArray: articlesCards["Music"]!["products"]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
