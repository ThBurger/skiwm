import 'package:flutter/material.dart';
import 'package:retroskiing/utils/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

const maxTimeResult = 9999999999999;

const dailyRaceStarted = 'dailyRaceStarted';
const dailyRaceFinished = 'dailyRaceFinished';
const profileRaces = 'races';
const profileCrashed = 'crashed';
const profileFinished = 'finished';
const profileTime = 'time';

enum GameState {
  init,
  start,
  playing,
  paused,
  gameOver,
  inFinish,
  finish,
}

extension ShowSnackBar on BuildContext {
  void showSnackBar({
    required String message,
    Color backgroundColor = Colors.white,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: RetroSkiingColors.black),
      ),
      backgroundColor: backgroundColor,
    ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}