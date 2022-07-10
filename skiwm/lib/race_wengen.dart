import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:skiwm/components/race_wengen.dart';
import 'package:skiwm/components/world_finish.dart';
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

  List<WorldCollidable> activeCollidable = List.empty(growable: true);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(_world);
    add(_player);
    addWorldFinish();
    // super.debugMode = true; TODO debug MODUS!

    _player.position = Vector2(1300, 200); // TODO
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
  }

  void addWorldCollisionFromPlayer() {
    for (var c in activeCollidable) {
      remove(c);
    }
    activeCollidable.clear();

    // filter which to Add
    var toAdd = collidableGates.where((element) =>
        element.position.y >= _player.position.y - 50 &&
        element.position.y <= _player.position.y + 250);
    activeCollidable.addAll(toAdd);

    debugPrint("added " + toAdd.length.toString() + " collidables");
    addAll(activeCollidable);
  }

  void addWorldFinish() async =>
      (await MapLoader.readCollisionMap('assets/Wengen_Race_Finish.json'))
          .forEach((rect) {
        add(WorldFinish()
          ..position = Vector2(rect.left, rect.top)
          ..width = rect.width
          ..height = rect.height);
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
    addWorldCollisionFromPlayer();
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
    addWorldCollisionFromPlayer();
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
    addWorldCollisionFromPlayer();
    _player.direction = Direction.down;
  }
}
