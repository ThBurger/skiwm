import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatchPage extends StatefulWidget {
  const StopWatchPage({Key? key}) : super(key: key);

  static Future<void> navigatorPush(BuildContext context) async {
    return Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => const StopWatchPage(),
      ),
    );
  }

  @override
  StopWatchState createState() => StopWatchState();
}

class StopWatchState extends State<StopWatchPage> {
  final _isHours = false;

  final StopWatchTimer _stopWatchTimer =
      StopWatchTimer(mode: StopWatchMode.countUp);

  void start() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  void stop() {
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: StreamBuilder<int>(
          stream: _stopWatchTimer.rawTime,
          initialData: _stopWatchTimer.rawTime.value,
          builder: (context, snap) {
            final value = snap.data!;
            final displayTime =
                StopWatchTimer.getDisplayTime(value, hours: _isHours);
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    displayTime,
                    style: const TextStyle(
                        fontSize: 40,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
