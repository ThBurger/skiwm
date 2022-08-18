import 'package:flame/components.dart';

class RaceWorld extends SpriteComponent with HasGameRef {
  String mapPic;
  RaceWorld(this.mapPic);

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite(mapPic);
    size = sprite!.originalSize;
    return super.onLoad();
  }
}
