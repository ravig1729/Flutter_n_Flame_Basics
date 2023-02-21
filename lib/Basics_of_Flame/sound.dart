import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/bgm.dart';
import 'package:flame_audio/flame_audio.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();

  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame {
  Bgm audio = Bgm();
  @override
  Future<void> onLoad() async {
    super.onLoad();
    audio.initialize();
    audio.play('Base_BGM.mp3');
  }
}
