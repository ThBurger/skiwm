import 'package:shared_preferences/shared_preferences.dart';
import 'package:skiwm/utils/constants.dart';
import 'package:skiwm/utils/value_notifiers.dart';

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

    if (task == DAILY_RACE_FINISHED) {
      if (_currentScore == 3) {
        return true;
      }
      if (_currentScore < 3) {
        _currentScore = _currentScore + 1;
        dailyTaskFinishedValueNotifier.value = _currentScore;
      }
      if (_currentScore == 3) {
        //daily task completed
        int credits = (prefs.getInt('credits') ?? 0);
        prefs.setInt('credits', credits + 30);
      }
    } else if (task == DAILY_RACE_STARTED) {
      if (_currentScore == 5) {
        return true;
      }
      if (_currentScore < 5) {
        _currentScore = _currentScore + 1;
        dailyTaskStartedValueNotifier.value = _currentScore;
      }
      if (_currentScore == 5) {
        //daily task completed
        int credits = (prefs.getInt('credits') ?? 0);
        prefs.setInt('credits', credits + 30);
      }
    }
    return prefs.setInt('task_' + date.toString() + '_' + task, _currentScore);
  }

  DateTime getDate() {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return date;
  }
}
