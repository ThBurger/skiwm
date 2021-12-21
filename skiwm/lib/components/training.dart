import 'package:flame/components.dart';

class TrainingWorld extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('Training_1.png');
    size = sprite!.originalSize;
    return super.onLoad();
  }
}
