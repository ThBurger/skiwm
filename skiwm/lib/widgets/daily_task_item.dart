import 'package:flutter/material.dart';
import 'package:skiwm/resources/daily_task_service.dart';

class DailyTaskComponent extends StatefulWidget {
  final String task;
  final int count;
  const DailyTaskComponent({Key? key, required this.task, required this.count})
      : super(key: key);

  @override
  _DailyTaskComponentState createState() => _DailyTaskComponentState();
}

class _DailyTaskComponentState extends State<DailyTaskComponent> {
  int _currentTaskScore = 0;

  @override
  void initState() {
    super.initState();
    getCurrentTask();
  }

  Future<void> getCurrentTask() async {
    int __currentTaskScore =
        await TaskService().getCurrentTaskScore(widget.task);
    setState(() {
      _currentTaskScore = __currentTaskScore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
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
                'Races started',
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
                '' +
                    _currentTaskScore.toString() +
                    '/' +
                    widget.count.toString(),
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
                  value: _currentTaskScore / widget.count,
                ))
          ],
        ),
      ),
    );
  }
}
