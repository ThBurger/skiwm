import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/widgets/button.dart';

class CrashedDialog extends StatelessWidget {
  const CrashedDialog({Key? key}) : super(key: key);

  void _onPressed(BuildContext context) {
    if (kDebugMode) {
      Navigator.pop(context);
    } else {
      Navigator.of(context).popUntil(ModalRoute.withName('/race'));
    }
  }

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
                  MyButton(
                    onPressed: () => _onPressed(context),
                    child: const Text('OK'),
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
