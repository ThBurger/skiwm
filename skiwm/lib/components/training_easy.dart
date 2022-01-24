import 'package:flame/components.dart';

class TrainingEasyWorld extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('Training_Easy.png');
    size = sprite!.originalSize;
    return super.onLoad();
  }
}
