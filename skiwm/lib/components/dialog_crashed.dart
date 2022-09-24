import 'package:flutter/material.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/utils/theme.dart';

class CrashedDialog extends StatelessWidget {
  const CrashedDialog({Key? key}) : super(key: key);

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
                    'CRASHED',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: SkiWmStyle.buttonHeight,
                    decoration: BoxDecoration(
                      gradient: SkiWmStyle.gradient,
                      borderRadius: SkiWmStyle.borderRadius,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName('/race'));
                      },
                      child: const Text('Ok'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
