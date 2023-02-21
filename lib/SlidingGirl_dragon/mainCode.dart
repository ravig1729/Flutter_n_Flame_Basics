// ignore_for_file: empty_constructor_bodies

import 'dart:collection';
import 'dart:ui' as ui;
// import 'package:first_app/greenDragon.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/flame.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import './girl.dart';
import './redDragon.dart';
import './greenDragon.dart';
import './platform.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();

  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame with DoubleTapDetector, HasCollidables {
  RedDragon redDragon = RedDragon();
  GreenDragon greenDragon = GreenDragon();
  Platform platform = Platform();
  SpriteComponent safe = SpriteComponent();
  SpriteComponent dragonBg = SpriteComponent();
  Girl girl = Girl();
  bool running = true;
  String direction = 'down';
  // SpriteAnimationComponent redDragonAnimation = SpriteAnimationComponent();
  SpriteAnimationComponent girlAnimation = SpriteAnimationComponent();
  double speed = 2.0;

  Future<void> initPlatform(Sprite sprite,size) async {
    for (var i = 1; i < 10; i++) {
      var x = 0.0;
      var anchor;
      if (i % 2 == 0) {
        x = 0;
        anchor = Anchor.centerLeft;
      } else {
        x = size[0];
        anchor = Anchor.centerRight;
      }
      platform
        ..sprite = sprite
        ..anchor = Anchor.centerLeft
        ..position = Vector2(x, i * 100)
        ..size = Vector2(100.0, 20.0);
      add(platform);
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    dragonBg
      ..sprite = await loadSprite('dragonBg.jpg')
      ..size = size;
    add(dragonBg);

    // girl
    //   ..sprite = await loadSprite('girl.png')
    //   ..size = Vector2.all(100.0)
    //   ..x = 150
    //   ..y = 20;
    //add(girl);

    //dragonImages
    // redDragon
    //   ..sprite = await loadSprite('redDragon.png')
    //   ..size = Vector2.all(100.0)
    //   ..x = 150
    //   ..y = 590;
    // add(redDragon);

    greenDragon
      ..sprite = await loadSprite('greenDragon.png')
      ..size = Vector2.all(100.0)
      ..x = 150
      ..y = 10;
    add(greenDragon);

    var sprite = await loadSprite('platform.png');
    initPlatform(sprite, size);

    safe
      ..sprite = await loadSprite('safe.png')
      ..size = Vector2.all(80.0)
      ..x = 330
      ..y = size.y - 80;
    add(safe);

    //dragonSpritesheet
    // var spritesheet = await images.load('symbolAnimation_redDragon.png');
    // final spriteSize = Vector2(152.0*1.4, 142.0*1.4);
    // SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
    //     amount: 9, stepTime: 0.03, textureSize: Vector2(152.0, 142.0));
    // redDragonAnimation =
    //     SpriteAnimationComponent.fromFrameData(spritesheet, spriteData)
    //       ..x = 50
    //       ..y = 50
    //       ..size = spriteSize;
    // add(redDragonAnimation);

    //girlspriteSheet
    var spritesheet = await images.load('girl_spritesheet.png');
    final spriteSize = Vector2(152.0 * 0.5, 142.0 * 0.5);
    SpriteAnimationData spriteData = SpriteAnimationData.sequenced(
        amount: 9, stepTime: 0.03, textureSize: Vector2(152.0, 142.0));
    girlAnimation =
        SpriteAnimationComponent.fromFrameData(spritesheet, spriteData)
          ..x = 100
          ..y = 30
          ..size = spriteSize;
    add(girlAnimation);
  }

  @override
  void update(double dt) {
    super.update(dt);

    switch (direction) {
      case 'down':
        girlAnimation.y += speed;
        break;
      case 'up':
        girlAnimation.y -= speed;
    }

    if (girlAnimation.y >= 500) {
      direction = 'up';
    }
    if (girlAnimation.y <= 10) {
      direction = 'down';
    }
  }

  @override
  void onDoubleTap() {
    if (running) {
      pauseEngine();
    } else {
      resumeEngine();
    }
    running = !running;
  }
}
