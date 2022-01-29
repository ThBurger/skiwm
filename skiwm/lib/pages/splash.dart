import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skiwm/components/auth_state.dart';
import 'package:skiwm/models/leaderboard_entry.dart';
import 'package:skiwm/models/race.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/utils/constants.dart';
import 'package:skiwm/utils/value_notifiers.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends AuthState<SplashPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    _loadCredits();
    _loadLeaderboradData();
    _loadRaceData().then((value) => {recoverSupabaseSession()});
    super.initState();
  }

  Future<void> _loadCredits() async {
    final SharedPreferences prefs = await _prefs;
    final int credits = (prefs.getInt('credits') ?? 0);
    creditsValueNotifier.value = creditsValueNotifier.value = credits;
  }

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
                child: Text("getting ready..."),
              ),
            ),
            Expanded(
              flex: 4,
              child: Align(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: const LinearProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                    minHeight: 7,
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Future<void> _loadRaceData() async {
    final response = await supabase.from('races').select().execute();
    final error = response.error;
    if (error != null && response.status != 406) {
      context.showErrorSnackBar(message: error.message);
    }
    final data = response.data;
    if (data != null) {
      for (var race in data) {
        Race r = Race.fromMap(race);
        races.add(r);
      }
    }
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> _loadLeaderboradData() async {
    String userId = '7e4f7c5b-504d-4851-b25c-1553cb4d4dfc'; // TODO
    if (supabase.auth.currentUser != null) {
      userId = supabase.auth.currentUser!.id;
    }
    final response =
        await supabase.from('results').select().eq('user_id', userId).execute();
    final error = response.error;
    if (error != null && response.status != 406) {
      context.showErrorSnackBar(message: error.message);
    }
    final data = response.data;
    if (data != null) {
      for (var entry in data) {
        LeaderboardEntry r = LeaderboardEntry.fromMap(entry);
        userLeaderboard.add(r);
      }
    }
  }
}
