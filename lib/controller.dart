import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

class Controller extends PositionComponent  with HasHitboxes, Collidable, HasGameRef {
  Controller({
    required double controllerSize,
  })
      : controllerSize = controllerSize,
        super(
        anchor: Anchor.center,
        size: Vector2(100.0, 20.0),
      );
  late double controllerSize;

  final controllerPaint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.fill;

  @override
  void onGameResize(Vector2 gameSize) {
    position = Vector2(
      gameSize.x / 2.0,
      gameSize.y / 1.15,
    );
  }

  @override
  Future<void> onLoad() async {
    addHitbox(HitboxRectangle(relation: Vector2(1.0, 1.0)));
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    renderHitboxes(canvas, paint: controllerPaint);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
  }

}