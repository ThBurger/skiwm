import 'package:shared_preferences/shared_preferences.dart';

class TaskService {
  Future<int> getCurrentTaskScore(String task) async {
    DateTime date = getDate();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('task_' + date.toString() + '_' + task) ?? 0;
  }

  Future<bool> increaseCurrentTaskScore(String task) async {
    int _currentScore = await getCurrentTaskScore(task);
    DateTime date = getDate();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _currentScore = _currentScore + 1;
    return prefs.setInt('task_' + date.toString() + '_' + task, _currentScore);
  }

  DateTime getDate() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return date;
  }
}
