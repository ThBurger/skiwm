import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skiwm/pages/shop.dart';
import 'package:skiwm/utils/value_notifiers.dart';

class CreditChip extends StatelessWidget {
  const CreditChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: creditsValueNotifier,
      builder: (BuildContext context, int counterValue, Widget? child) {
        return Chip(
          labelPadding: EdgeInsets.all(3.0),
          avatar: CircleAvatar(
            backgroundColor: Colors.white70,
            child: Text("C"),
          ),
          label: Text(
            creditsValueNotifier.value.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 6.0,
          shadowColor: Colors.grey[60],
          deleteIcon: FaIcon(FontAwesomeIcons.plusCircle),
          onDeleted: () {
            Get.to(ShopPage());
          },
        );
      },
      child: new SizedBox(),
    );
  }
}
