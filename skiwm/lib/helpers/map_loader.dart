import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class MapLoader {
  static Future<List<Rect>> readCollisionMap(String objects) async {
    final collidableRects = <Rect>[];
    final dynamic collisionMap =
        json.decode(await rootBundle.loadString(objects));

    for (final dynamic data in collisionMap['objects']) {
      double x = isInteger(data['x'])
          ? (data['x'] as int).toDouble()
          : data['x'] as double;
      double y = isInteger(data['y'])
          ? (data['y'] as int).toDouble()
          : data['y'] as double;
      double width = isInteger(data['width'])
          ? (data['width'] as int).toDouble()
          : data['width'] as double;
      double height = isInteger(data['height'])
          ? (data['height'] as int).toDouble()
          : data['height'] as double;
      collidableRects.add(Rect.fromLTWH(x, y, width, height));
    }

    return collidableRects;
  }

  static bool isInteger(num value) => value is int;
}
