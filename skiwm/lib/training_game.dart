import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/services.dart';
import 'package:skiwm/components/training.dart';
import 'package:skiwm/main_training_page.dart';

import 'components/player.dart';
import 'components/world_collidable.dart';
import 'helpers/direction.dart';
import 'package:flutter/material.dart';

import 'helpers/map_loader.dart';

class TrainingGame extends FlameGame with HasCollidables, KeyboardEvents {
  final Player _player = Player();
  final TrainingWorld _world = TrainingWorld();
  GameState _gameState = GameState.init;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(_world);
    add(_player);
    addWorldCollision();

    _player.position = _world.size / 5; // TODO!!!!
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
  }

  void addWorldCollision() async =>
      (await MapLoader.readTrainingCollisionMap()).forEach((rect) {
        add(WorldCollidable()
          ..position = Vector2(rect.left, rect.top)
          ..width = rect.width
          ..height = rect.height);
      });

  void onGameStateChanged(GameState gameState) {
    _gameState = gameState;
    if (_gameState == GameState.playing) {
      _player.isSkiing = true;
    } else {
      _player.isSkiing = false;
    }
  }

  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }

  void playerLeft() {
    switch (_player.direction) {
      case Direction.lleft:
        _player.direction = Direction.lleft;
        break;
      case Direction.left:
        _player.direction = Direction.lleft;
        break;
      case Direction.down:
        _player.direction = Direction.left;
        break;
      case Direction.right:
        _player.direction = Direction.down;
        break;
      case Direction.rright:
        _player.direction = Direction.right;
        break;
      case Direction.none:
        _player.direction = Direction.left;
        break;
    }
  }

  void playerRight() {
    switch (_player.direction) {
      case Direction.lleft:
        _player.direction = Direction.left;
        break;
      case Direction.left:
        _player.direction = Direction.down;
        break;
      case Direction.down:
        _player.direction = Direction.right;
        break;
      case Direction.right:
        _player.direction = Direction.rright;
        break;
      case Direction.rright:
        _player.direction = Direction.rright;
        break;
      case Direction.none:
        _player.direction = Direction.right;
        break;
    }
  }

  WorldCollidable createWorldCollidable(Rect rect) {
    final collidable = WorldCollidable();
    collidable.position = Vector2(rect.left, rect.top);
    collidable.width = rect.width;
    collidable.height = rect.height;
    return collidable;
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isKeyDown = event is RawKeyDownEvent;

    print(isKeyDown);
    print(event);

    return super.onKeyEvent(event, keysPressed);
  }
}
