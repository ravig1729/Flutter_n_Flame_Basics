import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';

class RedDragon extends SpriteComponent with  HasHitboxes, Collidable {
  RedDragon({
    Vector2? position,
    Vector2? size,
  }) : super(
          position: position,
          size: size,
        ) {
    debugMode = true;
    addHitbox(HitboxRectangle());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    print('...HIT!....');
  }
}
