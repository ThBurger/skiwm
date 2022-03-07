import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<int> getScore(String scoreId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('score_' + scoreId) ?? 0;
  }

  Future<void> increaseScore(String scoreId, int increaseBy) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int score = prefs.getInt('score_' + scoreId) ?? 0;
    int newScore = score + increaseBy;
    prefs.setInt('score_' + scoreId, newScore);
  }
}
