import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:retroskiing/resources/credits_service.dart';
import 'package:retroskiing/resources/shared_preferences_service.dart';
import 'package:retroskiing/utils/theme.dart';
import 'package:retroskiing/utils/utils.dart';
import 'package:retroskiing/utils/value_notifiers.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

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
    if (Utility.isUser()) {
      CreditsService.addCredits(25);
    } else {
      SharedPreferencesService().increaseCredits(25);
    }
    _nextCredits = DateTime.now().add(const Duration(hours: 6));
    final SharedPreferences prefs = await _prefs;
    setState(() {
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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: RetroSkiingStyle.buttonHeight,
      decoration: BoxDecoration(
        gradient: _redeemed
            ? RetroSkiingStyle.gradientGrey
            : RetroSkiingStyle.gradient,
        borderRadius: RetroSkiingStyle.borderRadius,
      ),
      child: ElevatedButton(
        onPressed: _redeemed ? null : _getCredits,
        child: _redeemed
            ? Row(
                children: [
                  const Text('Next Credits in '),
                  CountdownTimer(
                    endTime: _nextCredits.millisecondsSinceEpoch,
                  ),
                ],
              )
            : const Text('Get 25 Credits'),
      ),
    );
  }
}
