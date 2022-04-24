import 'package:flame/components.dart';

class RaceWengenWorld extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('Race_Wengen_Piste.png');
    size = sprite!.originalSize;
    return super.onLoad();
  }
}
