import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class WorldFinish extends PositionComponent
    with HasGameRef, Hitbox, Collidable {
  WorldFinish() {
    addHitbox(HitboxRectangle());
  }
}
