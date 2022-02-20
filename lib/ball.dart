import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class Ball extends PositionComponent with HasHitboxes, Collidable, HasGameRef {

  late double ballSize;
  late double ballSpeed;
  final ballPaint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill;

  bool directionx = true;
  bool directiony = true;

  Ball({
    required double ballSize,
    required double ballSpeed,
  })  : ballSize = ballSize,
        ballSpeed = ballSpeed,
        super(
          anchor: Anchor.center,
          size: Vector2.all(ballSize),
        );

  @override
  void onGameResize(Vector2 gameSize) {
    position = Vector2(
      gameSize.x / 2.0,
      gameSize.y / 2.0,
    );
  }

  @override
  Future<void> onLoad() async {
    addHitbox(HitboxCircle());
    await super.onLoad();
  }

  @override
  void update(double dt) {
    if (directiony) {
      position += Vector2(0, ballSpeed);
    } else {
      position -= Vector2(0, ballSpeed);
    }
    if (directionx) {
      position += Vector2(ballSpeed, 0);
    } else {
      position -= Vector2(ballSpeed, 0);
    }
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    renderHitboxes(canvas, paint: ballPaint);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    collisionDirection(intersectionPoints);
  }

  void collisionDirection(Set<Vector2> intersectionPoints) {
    //最初に衝突判定をした2点から衝突方向を求める
    if (intersectionPoints.length >= 2) {
      final relativePoint1 =
          intersectionPoints.elementAt(0) - hitboxes.first.position;
      final relativePoint2 =
          intersectionPoints.elementAt(1) - hitboxes.first.position;

      if (relativePoint1.x > 0 && relativePoint2.x > 0) {
        directionx = !directionx;
      } else if (relativePoint1.x < 0 && relativePoint2.x < 0) {
        directionx = !directionx;
      } else if (relativePoint1.y > 0 && relativePoint2.y > 0) {
        directiony = !directiony;
      } else if (relativePoint1.y < 0 && relativePoint2.y < 0) {
        directiony = !directiony;
      } else {
        directionx = !directionx;
        directiony = !directiony;
      }
    } else {
      directionx = !directionx;
      directiony = !directiony;
    }
  }
}
