import 'package:flutter/material.dart';
import 'package:skiwm/components/auth_state.dart';
import 'package:skiwm/models/leaderboard_entry.dart';
import 'package:skiwm/models/race.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/utils/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends AuthState<SplashPage> {
  @override
  void initState() {
    _loadLeaderboradData();
    _loadRaceData().then((value) => {recoverSupabaseSession()});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: const LinearProgressIndicator(
            backgroundColor: Colors.grey,
            color: Colors.green,
            minHeight: 7,
          ),
        ),
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
