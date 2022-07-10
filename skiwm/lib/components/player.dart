import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:skiwm/components/dialog_crashed.dart';
import 'package:skiwm/components/dialog_finished.dart';
import 'package:skiwm/components/world_collidable.dart';
import 'package:skiwm/components/world_finish.dart';
import 'package:skiwm/resources/daily_task_service.dart';
import 'package:skiwm/resources/globals.dart';
import 'package:skiwm/resources/shared_preferences_service.dart';
import 'package:skiwm/utils/constants.dart';
import '../helpers/direction.dart';
import 'package:flame/sprite.dart';

class Player extends SpriteAnimationComponent
    with HasGameRef, Hitbox, Collidable {
  final double _playerSpeedMax = 400.0;
  double _playerSpeed = 0.0;
  bool isSkiing = false;
  final double _animationSpeed = 0.15;

  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runLleftAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _runRrightAnimation;
  late final SpriteAnimation _standingAnimation;

  Direction direction = Direction.none;
  Direction _collisionDirection = Direction.none;
  bool _hasCollided = false;
  bool _hasFinished = false;

  Player()
      : super(
          size: Vector2.all(32.0),
        ) {
    addHitbox(HitboxRectangle()); // normal
    //addHitbox(HitboxRectanglePlayer()); // better
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _loadAnimations().then((_) => {animation = _standingAnimation});
  }

  @override
  void update(double dt) {
    super.update(dt);
    movePlayer(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);

    if (other is WorldCollidable) {
      if (!_hasCollided) {
        debugPrint("COLLIDABLE");
        debugPrint("OTHER: " +
            other.x.toString() +
            " | " +
            other.y.toString() +
            " | " +
            other.height.toString() +
            " | " +
            other.width.toString());
        debugPrint(
            "PLAYER: " + position.x.toString() + " | " + position.y.toString());
        stopwatch.currentState?.stop();
        gameState = GameState.gameOver;
        _hasCollided = true;
        SharedPreferencesService().increaseScore(PROFILE_CRASHED, 1);
        _collisionDirection = direction;
        Get.dialog(
          const CrashedDialog(),
          barrierDismissible: false,
        );
      }
    }
    if (other is WorldFinish) {
      if (!_hasFinished) {
        debugPrint("FINISHED");
        debugPrint("OTHER: " + other.x.toString() + " | " + other.y.toString());
        debugPrint(
            "PLAYER: " + position.x.toString() + " | " + position.y.toString());
        stopwatch.currentState?.stop();
        gameState = GameState.inFinish;
        _hasFinished = true;
        SharedPreferencesService().increaseScore(PROFILE_FINISHED, 1);
        TaskService().increaseCurrentTaskScore(DAILY_RACE_FINISHED);
        Get.dialog(
          const FinishedDialog(),
          barrierDismissible: false,
        );
      }
    }
  }

  @override
  void onCollisionEnd(Collidable other) {
    _hasCollided = false;
  }

  Future<void> _loadAnimations() async {
    final spriteSheetDown = SpriteSheet(
      image: await gameRef.images.load('spritesheet_down.png'),
      srcSize: Vector2(62.0, 102.0),
    );

    _standingAnimation = spriteSheetDown.createAnimation(
        row: 0, stepTime: _animationSpeed, to: 2);

    final spriteSheetLeft = SpriteSheet(
      image: await gameRef.images.load('spritesheet_left.png'),
      srcSize: Vector2(92.0, 97.0),
    );
    final spriteSheetLleft = SpriteSheet(
      image: await gameRef.images.load('spritesheet_lleft.png'),
      srcSize: Vector2(91.0, 87.0),
    );
    final spriteSheetRight = SpriteSheet(
      image: await gameRef.images.load('spritesheet_right.png'),
      srcSize: Vector2(92.0, 97.0),
    );
    final spriteSheetRright = SpriteSheet(
      image: await gameRef.images.load('spritesheet_rright.png'),
      srcSize: Vector2(87.0, 87.0),
    );

    _runDownAnimation = spriteSheetDown.createAnimation(
        row: 0, stepTime: _animationSpeed, to: 2);

    _runLeftAnimation = spriteSheetLeft.createAnimation(
        row: 0, stepTime: _animationSpeed, to: 2);

    _runLleftAnimation = spriteSheetLleft.createAnimation(
        row: 0, stepTime: _animationSpeed, to: 2);

    _runRightAnimation = spriteSheetRight.createAnimation(
        row: 0, stepTime: _animationSpeed, to: 2);

    _runRrightAnimation = spriteSheetRright.createAnimation(
        row: 0, stepTime: _animationSpeed, to: 2);
  }

  void movePlayer(double delta) {
    if (isSkiing) {
      calcSpeed();
    } else {
      _playerSpeed = 0;
    }
    switch (direction) {
      case Direction.down:
        if (canPlayerMoveDown()) {
          animation = _runDownAnimation;
          moveDown(delta);
        }
        break;
      case Direction.left:
        if (canPlayerMoveLeft()) {
          animation = _runLeftAnimation;
          moveLeft(delta);
        }
        break;
      case Direction.right:
        if (canPlayerMoveRight()) {
          animation = _runRightAnimation;
          moveRight(delta);
        }
        break;
      case Direction.none:
        animation = _standingAnimation;
        _playerSpeed = 0;
        break;
      case Direction.lleft:
        if (canPlayerMoveLeft()) {
          animation = _runLleftAnimation;
          moveLLeft(delta);
        }
        break;
      case Direction.rright:
        if (canPlayerMoveRight()) {
          animation = _runRrightAnimation;
          moveRRight(delta);
        }
        break;
    }
  }

  calcSpeed() {
    if (_playerSpeed <= _playerSpeedMax) {
      _playerSpeed += 30;
    }
  }

  bool canPlayerMoveDown() {
    if (_hasCollided && _collisionDirection == Direction.down) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveLeft() {
    if (_hasCollided && _collisionDirection == Direction.left) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveRight() {
    if (_hasCollided && _collisionDirection == Direction.right) {
      return false;
    }
    return true;
  }

  void moveDown(double delta) {
    position.add(Vector2(0, delta * _playerSpeed));
  }

  void moveLeft(double delta) {
    position.add(
        Vector2((delta * -_playerSpeed) / 2.5, (delta * _playerSpeed) / 2.5));
  }

  void moveLLeft(double delta) {
    position.add(
        Vector2((delta * -_playerSpeed) / 1.5, (delta * _playerSpeed) / 8));
  }

  void moveRight(double delta) {
    position.add(
        Vector2((delta * _playerSpeed) / 2.5, (delta * _playerSpeed) / 2.5));
  }

  void moveRRight(double delta) {
    position
        .add(Vector2((delta * _playerSpeed) / 1.5, (delta * _playerSpeed) / 8));
  }
}
