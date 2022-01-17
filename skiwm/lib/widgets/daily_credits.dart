import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skiwm/utils/value_notifiers.dart';

class DailyCredit extends StatefulWidget {
  const DailyCredit({Key? key}) : super(key: key);

  @override
  _DailyCreditState createState() => _DailyCreditState();
}

class _DailyCreditState extends State<DailyCredit> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _redeemed = false;
  DateTime _nextCredits = DateTime.now();

  Future<void> _getCredits() async {
    final SharedPreferences prefs = await _prefs;
    final int credits = (prefs.getInt('credits') ?? 0) + 25;
    _nextCredits = DateTime.now().add(const Duration(hours: 6));
    creditsValueNotifier.value = creditsValueNotifier.value = credits;
    setState(() {
      prefs.setInt('credits', credits);
      prefs.setInt('credits_next', _nextCredits.millisecondsSinceEpoch);
      _redeemed = true;
    });
  }

  Future<void> _init() async {
    final SharedPreferences prefs = await _prefs;
    int timestamp = (prefs.getInt('credits_next')) ?? 0;
    _nextCredits = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime now = DateTime.now();
    if (now.isBefore(_nextCredits)) {
      setState(() {
        _redeemed = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _redeemed ? null : _getCredits,
      child: Text(_redeemed
          ? 'Next Credits at ' + DateFormat('hh:mm').format(_nextCredits)
          : 'Get 25 Credits'),
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
