import 'package:flame/geometry.dart';
import 'package:flame/extensions.dart';

class HitboxRectanglePlayer extends Rectangle with HitboxShape {
  HitboxRectanglePlayer({Vector2? relation})
      : super.fromDefinition(
          relation: Vector2.all(10),
        );
}
