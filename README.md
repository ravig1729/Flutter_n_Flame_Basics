# first_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Content

- length() : gives us the size/magnitude of the vector
- random() : generates random vector in the range of (0,0) to (1,1) - Vector2.random()
- negate() : which reverses the direction of vector.
- normalized() is normalizes the vector(ie.,it makes magnitude as 1) -  Vector2().normalized() * 25
- To control the magnitude , we could do this:  Vector2.random().normalized() * 25

Case Study: ## Vector2 - Random Generation
 -- First we get the random velocity and set its velocity: 
    velocity = Vector2.random().normalized() * 25;
 -- Then we set the position of the component to the location we want: 
    position = Vector2(80, 100);

Case Study: ## Vector2 - Angle of Vector
We want to do that when we want to know how far a vector has been rotated. Lets call this angle A.
The way that we can do this, is by getting a signed angle from a representative vector with 0deg, and take the angle b/w them.
   -- angleA = v1.angleToSigned(v2);

Case Study: ## Position Component - Angular Momentum
We can also have the shape rotated at a certain speed (with refernce to dt- delta time, in the update method)
   -- angleDelta = dt * rotationSpeed;
      angle = (angle + angleDelta) % (2*pi);
