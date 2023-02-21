import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';

class GreenDragon extends SpriteComponent with HasHitboxes, Collidable {
  double value = 110.0;

  GreenDragon({
    Vector2? position,
    Vector2? size,
  }) : super(
          position: position,
          size: size,
        ) {
    debugMode = false;
    //addHitbox(HitboxRectangle());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    super.onCollision(intersectionPoints, other);
    print('...HIT!....');
  }
}
