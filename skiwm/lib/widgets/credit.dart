import 'package:flutter/material.dart';
import 'package:skiwm/utils/theme.dart';
import 'package:skiwm/utils/value_notifiers.dart';

class CreditChip extends StatelessWidget {
  const CreditChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: creditsValueNotifier,
      builder: (BuildContext context, int counterValue, Widget? child) {
        return Chip(
          labelPadding: const EdgeInsets.all(3.0),
          avatar: const CircleAvatar(
            backgroundColor: Colors.white70,
            child: Text("C"),
          ),
          label: Text(
            creditsValueNotifier.value.toString(),
            style: const TextStyle(
              color: SkiWmColors.primary,
            ),
          ),
          elevation: 6.0,
          shadowColor: Colors.grey[60],
        );
      },
      child: const SizedBox(),
    );
  }
}
