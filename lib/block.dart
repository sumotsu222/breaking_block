import 'package:flutter/material.dart';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'ball.dart';

class BlockGenerator extends Component with HasGameRef {
  late int rowNumber;
  late int columnNumber;
  late double blockWidth;
  late double gap;
  late double blockPositionx;

  BlockGenerator({
    required int rowNumber,
    required int columnNumber,
    required double blockWidth,
  })  : rowNumber = rowNumber,
        columnNumber = columnNumber,
        blockWidth = blockWidth,
        super();


  //gapの算出式
  //gap = (screenSize-n*blockWidth) / (n+1)
  //
  //ブロックの開始位置算出式
  //blockPositionx(n) = n*blockWidth + gap(n+1)
  //
  // gap = ___
  // block = ■■■■
  //
  // ___■■■■___■■■■___■■■■___
  // ___■■■■___■■■■___■■■■___
  // ___■■■■___■■■■___■■■■___
  //
  //
  //       ○
  //
  //
  //         ■■■■■■
  //
  //
  @override
  Future<void> onLoad() async {
    //横に並ぶブロックの作成
    gap = ((gameRef.canvasSize.x - (rowNumber * blockWidth)) / (rowNumber + 1));

    for (var j = 0; j < columnNumber; j++) {
      for (var n = 0; n < rowNumber; n++) {
        add(Blocksaaa(
            position:
                Vector2(((n * blockWidth) + (gap * (n + 1))), (j + 1) * 50),
            size: Vector2(blockWidth, 10)));
      }
    }
  }
}

class Blocksaaa extends PositionComponent
    with HasHitboxes, Collidable, HasGameRef {
  Blocksaaa({
    required Vector2 position,
    required Vector2 size,
  }) : super(
          position: position,
          //anchor: Anchor.center,
          size: size,
        );

  final blockPaint = Paint()
    ..color = Colors.green
    ..style = PaintingStyle.fill;

  final shape = HitboxRectangle(relation: Vector2(1.0, 1.0));

  @override
  Future<void> onLoad() async {
    addHitbox(shape);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    renderHitboxes(canvas, paint: blockPaint);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Ball) {
      removeHitbox(shape);
      removeFromParent();
    }
  }
}
