import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:skiwm/main.dart';
import 'package:skiwm/pages/shop.dart';
import 'package:skiwm/utils/Theme.dart';

Widget creditChip() {
  return Chip(
    labelPadding: EdgeInsets.all(3.0),
    avatar: CircleAvatar(
      backgroundColor: Colors.white70,
      child: Text("C"),
    ),
    label: Text(
      "10000",
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
}
