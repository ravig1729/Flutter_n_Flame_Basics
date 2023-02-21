import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'dart:ui' as ui;

class Girl extends SpriteAnimationComponent with HasHitboxes, Collidable {
  Girl({
    Vector2? position,
    Vector2? size,
  }) : super(
          position: position,
          size: size,
        ) {
  }

  Girl.fromFrameData(
    ui.Image image,
    SpriteAnimationData data, {
    Vector2? position,
    Vector2? size,
  }) : super(position: position, size: size) {
    animation:
    SpriteAnimation.fromFrameData(image, data);
    position:
    position;
    size:
    size;
    debugMode = true;
    addHitbox(HitboxRectangle());
  }
}
