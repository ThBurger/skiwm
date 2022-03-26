import 'package:shared_preferences/shared_preferences.dart';
import 'package:skiwm/utils/constants.dart';

class HighscoreService {
  Future<int> getCurrentHighscore(String raceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('race_' + raceId) ?? maxTimeResult;
  }

  Future<bool> setCurrentHighscore(String raceId, int time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt('race_' + raceId, time);
  }

  Future<bool> checkHighscore(String raceId, int time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedTime = prefs.getInt('race_' + raceId) ?? maxTimeResult;
    if (time < savedTime) {
      prefs.setInt('race_' + raceId, time);
      return true;
    }
    return false;
  }
}
