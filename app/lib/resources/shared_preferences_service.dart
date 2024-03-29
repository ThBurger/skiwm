import 'package:shared_preferences/shared_preferences.dart';
import 'package:retroskiing/utils/value_notifiers.dart';

class SharedPreferencesService {
  Future<String> getString(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(id) ?? '';
  }

  Future<void> setString(String id, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(id, value);
  }

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

  Future<void> deleteAllSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<int> getCredits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('credits') ?? 0;
  }

  Future<void> increaseCredits(int increaseBy) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int credits = prefs.getInt('credits') ?? 0;
    int newCredits = credits + increaseBy;
    creditsValueNotifier.value = newCredits;
    prefs.setInt('credits', newCredits);
  }
}
