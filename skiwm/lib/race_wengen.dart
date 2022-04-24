import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:skiwm/components/race_wengen.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/utils/constants.dart';
import 'components/player.dart';
import 'components/world_collidable.dart';
import 'helpers/direction.dart';
import 'package:flutter/material.dart';
import 'helpers/map_loader.dart';

class RaceWengenGame extends FlameGame with HasCollidables, KeyboardEvents {
  late final Player _player = Player();
  final RaceWengenWorld _world = RaceWengenWorld();

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(_world);
    add(_player);
    addWorldCollision();
    addWorldFinish();

    _player.position = Vector2(300, 200); // TODO mitte
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
  }

  void addWorldCollision() async => (await MapLoader.readCollisionMap(
              'assets/Sölden_Training_Collisions.json'))
          .forEach((rect) {
        // TODO!!
        //add(WorldCollidable()
        //  ..position = Vector2(rect.left, rect.top)
        //  ..width = rect.width
        //  ..height = rect.height);
      });

  void addWorldFinish() async =>
      (await MapLoader.readCollisionMap('assets/Sölden_Training_Finish.json'))
          .forEach((rect) {
        // add(WorldFinish()
        //  ..position = Vector2(rect.left, rect.top)
        //   ..width = rect.width
        //   ..height = rect.height);
      });

  void onGameStateChanged() {
    if (gameState == GameState.playing) {
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

  void playerStart() {
    _player.direction = Direction.down;
  }

  WorldCollidable createWorldCollidable(Rect rect) {
    final collidable = WorldCollidable();
    collidable.position = Vector2(rect.left, rect.top);
    collidable.width = rect.width;
    collidable.height = rect.height;
    return collidable;
  }

  //@override
  //KeyEventResult onKeyEvent(
  //    RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
  //  final isKeyDown = event is RawKeyDownEvent;
  //
  //  print(isKeyDown);
  //  print(event);
  //
  // return super.onKeyEvent(event, keysPressed);
  //}
}
