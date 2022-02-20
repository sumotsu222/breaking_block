
import 'package:flutter/material.dart';

import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

import 'ball.dart';
import 'controller.dart';
import 'block.dart';

Future<void> main() async {
  final game = BreakingBlockGame();

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'AldotheApache',
      ),
      home: GameWidget(
        game: game,
        loadingBuilder: (context) => const Material(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        //Work in progress error handling
        errorBuilder: (context, ex) {
          //Print the error in th dev console
          debugPrint(ex.toString());
          return const Material(
            child: Center(
              child: Text('Sorry, something went wrong. Reload me'),
            ),
          );
        },
      ),
    ),
  );
}

class BreakingBlockGame extends FlameGame with HasCollidables, TapDetector, HorizontalDragDetector {

  late Ball ball;
  late Controller controller;
  late BlockGenerator blockGenerator;
  final paint = Paint()..color = Colors.blue;

  @override
  Future<void> onLoad() async {
    add(ScreenCollidable());
    ball =  Ball(ballSize: 20.0, ballSpeed: 10);
    controller =  Controller(controllerSize: 20.0);
    blockGenerator = BlockGenerator(rowNumber: 3, columnNumber: 3, blockWidth: 100.0);
    add(ball);
    add(controller);
    add(blockGenerator);
    await super.onLoad();
  }

  @override
  void render(Canvas canvas){
    canvas.drawRect(Rect.fromLTWH(0.0, 0.0, canvasSize.x, canvasSize.y), paint);
    super.render(canvas);
  }

  @override
  void onHorizontalDragUpdate(DragUpdateInfo details) {
    controller.position += Vector2(
      details.raw.delta.dx,
      details.raw.delta.dy,
    );
  }

}