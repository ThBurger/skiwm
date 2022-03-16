import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

const maxTimeResult = 9999999999999;

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
      content: Text(message),
      backgroundColor: backgroundColor,
    ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}
