import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class MapLoader {
  static Future<List<Rect>> readRayWorldCollisionMap() async {
    final collidableRects = <Rect>[];
    final dynamic collisionMap = json.decode(
        await rootBundle.loadString('assets/rayworld_collision_map.json'));

    for (final dynamic data in collisionMap['objects']) {
      collidableRects.add(Rect.fromLTWH(
          data['x'] as double,
          data['y'] as double,
          data['width'] as double,
          data['height'] as double));
    }

    return collidableRects;
  }

  static Future<List<Rect>> readTrainingCollisionMap() async {
    final collidableRects = <Rect>[];
    final dynamic collisionMap =
        json.decode(await rootBundle.loadString('assets/Training_1.json'));

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
