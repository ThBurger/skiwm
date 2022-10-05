import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:retroskiing/pages/race_after.dart';
import 'package:retroskiing/resources/globals.dart';
import 'package:retroskiing/utils/theme.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class FinishedDialog extends StatelessWidget {
  const FinishedDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    audioPlayer.stop();
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: 250,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    const Text(
                      'FINISHED',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        StopWatchTimer.getDisplayTime(
                            stopwatch.currentState!.getTime(),
                            hours: false),
                        style: const TextStyle(
                            fontSize: 40,
                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: RetroSkiingStyle.buttonHeight,
                      decoration: BoxDecoration(
                        gradient: RetroSkiingStyle.gradient,
                        borderRadius: RetroSkiingStyle.borderRadius,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(AfterRacePage(
                              timeRace: stopwatch.currentState!.getTime()));
                        },
                        child: const Text('Continue'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
