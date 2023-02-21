import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  ComponentExample001 myGame = ComponentExample001();
  runApp(
    GameWidget(
      game: myGame,
    ),
  );
}

//
//
// Simple component shape example of a square component
class Square extends PositionComponent {
  //
  // default values
  //

  // velocity is 0 here
  //normalized() is normalizes the vector(ie.,it makes magnitude as 1)
  // var velocity = Vector2(0, 0).normalized() * 25;
  var velocity = Vector2(0, 25);
  var rotationSpeed = 0.3;
  // large square
  var squareSize = 128.0;
  // colored white with no-fill and an outline strike
  // var color = BasicPalette.white.paint()
  var color = Paint()
    ..color = Colors.orange
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;
  List<RectangleComponent> lifeBarElements = List<RectangleComponent>.filled(
      4, RectangleComponent(size: Vector2(1, 1)),
      growable: false);

  @override
  //
  // initialize the component
  Future<void> onLoad() async {
    super.onLoad();
    size.setValues(squareSize, squareSize);
    anchor = Anchor.center;
    createLifeBar();
  }

  @override
  //
  // update the inner state of the shape
  // in our case the position based on velocity
  void update(double dt) {
    super.update(dt);
    // speed is refresh frequency independent
    position += velocity * dt;
    //add rotational speed and update as well.
    var angleDelta = dt * rotationSpeed;
    angle = (angle + angleDelta) % (2 * 180);
    //angle + angleDelta rotates clockwise and angle - angleDelta rotates antiClockwise
  }

  @override
  //
  // render the shape
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(size.toRect(), color);
  }

  // Create a rudimentary lifebar shape
  createLifeBar() {
    var lifeBarSize = Vector2(40, 10);
    var backgroundFillColor = Paint()
      ..color = Colors.grey.withOpacity(0.35)
      ..style = PaintingStyle.fill;
    var outlineColor = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    var lifeDangerColor = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    var lifeSaveColor = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    // All positions here are in relation to the parent's position
    lifeBarElements = [
      //
      // The outline of the life bar
      RectangleComponent(
        position: Vector2(size.x - lifeBarSize.x, -lifeBarSize.y - 2),
        size: lifeBarSize,
        angle: 0,
        paint: outlineColor,
      ),
      //
      // The fill portion of the bar. The semi-transparent portion
      RectangleComponent(
        position: Vector2(size.x - lifeBarSize.x, -lifeBarSize.y - 2),
        size: lifeBarSize,
        angle: 0,
        paint: backgroundFillColor,
      ),
      //
      // The actual life percentage as a fill of red or green
      RectangleComponent(
        position: Vector2(size.x - lifeBarSize.x, -lifeBarSize.y - 2),
        size: Vector2(10, 10),
        angle: 0,
        paint: lifeDangerColor,
      ),

      RectangleComponent(
        position: Vector2(size.x - lifeBarSize.x, -lifeBarSize.y - 2),
        size: Vector2(30, 10),
        angle: 0,
        paint: lifeSaveColor,
      ),
    ];

    //
    // add all lifebar elements to the children of the Square instance
    addAll(lifeBarElements);
  }
}

//
//
// The game class
class ComponentExample001 extends FlameGame
    with DoubleTapDetector, TapDetector {
  //controls if engine is paused or not
  bool running = true;

  @override
  //runnning in debug mode : if its true, it shows coordinates
  bool debugMode = false;

  //text rendering const
  final TextPaint textPaint = TextPaint(
    style: const TextStyle(
      fontSize: 14,
      fontFamily: 'Awesome Font',
    ),
  );
  //
  //
  // Process user's single tap (tap up)
  void onTapUp(TapUpInfo info) {
    // location of user's tap
    final touchPoint = info.eventPosition.game;
    print("<user tap> touchpoint: $touchPoint");
    // handle the tap action
    //
    // check if the tap location is within any of the shapes on the screen
    // and if so remove the shape from the screen
    // children denotes the square , user click on screen increase the no.of squares on screen
    final handled = children.any((component) {
      if (component is Square && component.containsPoint(touchPoint)) {
        //remove(): removing the existing objects from screen.
        //remove(component);
        //negate() - which reverses the direction of vector.
        component.velocity.negate();
        return true;
      }
      return false;
    });

    //
    // this is a clean location with no shapes
    // create and add a new shape to the component tree under the FlameGame
    if (!handled) {
      add(Square()
        ..position = touchPoint
        ..squareSize = 45.0
        ..velocity = Vector2(0, 1).normalized() * 25
        // ..color = (BasicPalette.red.paint()
        //   ..style = PaintingStyle.stroke
        //   ..strokeWidth = 2));
        ..color = (Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2));
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

  @override
  void render(Canvas canvas) {
    textPaint.render(
        canvas, "object active : ${children.length}", Vector2(10, 20));
    super.render(canvas);
  }
}
