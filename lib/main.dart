import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame with TapDetector, DoubleTapDetector {
  SpriteComponent girl = SpriteComponent();
  SpriteComponent boy = SpriteComponent();
  SpriteComponent background = SpriteComponent();
  // SpriteComponent background2 = SpriteComponent();

  final double characterSize = 200.0;
  bool turnAway = false;
  int dialogLevel = 0;
  // int sceneLevel = 1;
  bool playingMusic = false;
  int trackNumber = 1;

  TextPaint dialogText = TextPaint(style: const TextStyle(fontSize: 26));

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final screenWidth = size[0];
    final screenHeight = size[1];
    const textBoxHeight = 100;

    add(background
      ..sprite = await loadSprite('flowerbackground.png')
      ..size = Vector2(size[0], size[1] - 50));

    // background2
    //   ..sprite = await loadSprite('indoor.png')
    //   ..size = Vector2(size[0], size[1] - 50);
    // load girl
    girl
      ..sprite = await loadSprite('shygirl.png')
      ..size = Vector2(characterSize, characterSize)
      ..y = screenHeight - characterSize - textBoxHeight
      ..anchor = Anchor.topCenter;
    add(girl);

    boy
      ..sprite = await loadSprite('boy.png')
      ..size = Vector2(characterSize, characterSize)
      ..y = screenHeight - characterSize - textBoxHeight
      ..x = screenWidth - characterSize
      ..anchor = Anchor.topCenter
      ..flipHorizontally();

    add(boy);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (girl.x < size[0] / 2 - 100) {
      girl.x += 30 * dt;
      if (girl.x > 30 && dialogLevel == 0) {
        dialogLevel = 1;
      }
      if (girl.x > 80 && dialogLevel == 1) {
        dialogLevel = 2;
      }
      if (girl.x > 150 && dialogLevel == 2) {
        dialogLevel = 3;
      }
    } else if (turnAway == false) {
      boy.flipHorizontally();
      turnAway = true;
      if (dialogLevel == 3) {
        dialogLevel = 4;
      }
    }

    if (boy.x > size[0] / 2 - 50) {
      boy.x -= 30 * dt;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    switch (dialogLevel) {
      case 1:
        dialogText.render(canvas, 'Keiko : Hi! I am waiting for you',
            Vector2(10, size[1] - 50));
        break;
      case 2:
        dialogText.render(canvas, 'Ken : Why, is there any reason?',
            Vector2(10, size[1] - 50));
        break;
      case 3:
        dialogText.render(canvas, 'Keiko : Yes, I got something for you!',
            Vector2(10, size[1] - 50));
        break;
      case 4:
        dialogText.render(
            canvas,
            'Ken : Sorry! I am not interested to take now. I ll take it later',
            Vector2(10, size[1] - 50));
        break;
    }

    // if (dialogLevel == 4 && sceneLevel == 1) {
    //   remove(background);
    //   add(background2);
    //   dialogText.render(
    //       canvas,
    //       'Ken : Sorry! to say like that, can you pl give it to me now!',
    //       Vector2(10, size[1] - 50));
    // }
  }

  @override
  void onTapUp(TapUpInfo info) {
    if (!playingMusic) {
      switch (trackNumber) {
        case 1:
          FlameAudio.bgm.play('Free_BGM.mp3');
          playingMusic = true;
          break;
        case 2:
          FlameAudio.bgm.play('Base_BGM.mp3');
          playingMusic = true;
          break;
      }
    } else {
      FlameAudio.bgm.stop();
      playingMusic = false;
    }
  }

  @override
  void onDoubleTap() {
    trackNumber++;
    if (trackNumber > 2) {
      trackNumber = 1;
    }
  }
}
