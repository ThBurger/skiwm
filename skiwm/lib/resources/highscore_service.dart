import 'package:shared_preferences/shared_preferences.dart';

class HighscoreService {
  Future<int> getCurrentHighscore(String raceId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('race_' + raceId) ?? 9999999999999;
  }

  Future<bool> setCurrentHighscore(String raceId, int time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt('race_' + raceId, time);
  }

  Future<bool> checkHighscore(String raceId, int time) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int savedTime = prefs.getInt('race_' + raceId) ?? 9999999999999;
    if (time < savedTime) {
      prefs.setInt('race_' + raceId, time);
      return true;
    }
    return false;
  }

  //void setStampCountOld(int newCount) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('stampCountOld', newCount);
  // }

  // void setInitScreen(int newInitScreen) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('initScreen', newInitScreen);
  // }

  // Future<bool> setQuickstamp(bool value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //  return prefs.setBool('quickstampActive', value);
  // }

  // Future<bool> setSubIdCache(String subId) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int timestamp = DateTime.now().millisecondsSinceEpoch;
  //   return prefs.setInt('cache_' + subId, timestamp);
  // }
}
