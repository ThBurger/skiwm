import 'package:flame/components.dart';

class TrainingSoeldenWorld extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('Training_Soelden.png');
    size = sprite!.originalSize;
    return super.onLoad();
  }
}
