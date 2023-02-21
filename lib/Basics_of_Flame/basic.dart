import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  //removing battery ,time,navigation button on the phone to show fullscreen
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();

  runApp(GameWidget(game: MyFirstGame()));
}

class MyFirstGame extends FlameGame with TapDetector, FPSCounter {
  static final fpsTextPaint = TextPaint(
    // config: const TextPaintConfig(color: Colors.black, fontSize: 23),
    style: TextStyle(fontSize: 23, color: Colors.black),
  );

  @override
  Future<void>? onLoad() {
    super.onLoad();

    //print('<game loop> onLoad() called');
  }

  @override
  void update(double dt) {
    super.update(dt);

    //print('<game loop> update() called delta time $dt');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawPaint(Paint()..color = Colors.green.shade300);

    // format and show the FPS for the game loop
    var stringFormatterFps = NumberFormat("##", "en_US");
    String fpsString = "fps: " + stringFormatterFps.format(fps(60));
    fpsTextPaint.render(canvas, fpsString, Vector2(10, 10));

    //print('<game loop> render() called');
  }


  @override
  void onTapUp(TapUpInfo info) {
    print(
      '<game loop> onTap Location: (${info.eventPosition.game.x}, ${info.eventPosition.game.y})',
    );
    super.onTapUp(info);
  }
}
