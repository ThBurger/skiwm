import 'package:flutter/material.dart';
import 'package:retroskiing/utils/value_notifiers.dart';

class DailyTaskFinishedComponent extends StatelessWidget {
  const DailyTaskFinishedComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: dailyTaskFinishedValueNotifier,
      builder: (BuildContext context, int counterValue, Widget? child) {
        return Container(
          padding: const EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width * 0.43,
          height: MediaQuery.of(context).size.width * 0.33,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Races finished',
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '' + counterValue.toString() + '/3',
                  style: const TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                child: LinearProgressIndicator(
                  value: counterValue / 3,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  ' + 30 Credits',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: const SizedBox(),
    );
  }
}
