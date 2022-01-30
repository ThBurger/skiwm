import 'package:flutter/material.dart';

class CrashedDialog extends StatelessWidget {
  const CrashedDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName('/race'));
                      },
                      child: const Text('Retry'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName('/menu'));
                      },
                      child: const Text('Exit'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
