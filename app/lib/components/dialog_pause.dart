import 'package:flutter/material.dart';
import 'package:retroskiing/resources/globals.dart';
import 'package:retroskiing/utils/theme.dart';

class PauseDialog extends StatelessWidget {
  const PauseDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    audioPlayer.pause();
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
                      'PAUSED',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: RetroSkiingStyle.buttonHeight,
                      decoration: BoxDecoration(
                        gradient: RetroSkiingStyle.gradient,
                        borderRadius: RetroSkiingStyle.borderRadius,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop('continue');
                        },
                        child: const Text('Continue'),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: RetroSkiingStyle.buttonHeight,
                      decoration: BoxDecoration(
                        gradient: RetroSkiingStyle.gradient,
                        borderRadius: RetroSkiingStyle.borderRadius,
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .popUntil(ModalRoute.withName('/race'));
                        },
                        child: const Text('Exit'),
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
