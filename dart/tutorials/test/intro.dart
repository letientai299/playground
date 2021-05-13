import 'dart:math';

void intro() {
  var shapes = <Shape>[
    Circle(1),
    Square(2),
    Rect(3, 4),
  ];

  shapes.forEach(print);
}

Shape makeShape(String type) {
  switch (type) {
    case 'rect':
      return Rect(3, 4);
    case 'square':
      return Square(4);
    case 'circle':
      return Circle(1);
    default:
      throw 'wtf';
  }
}

abstract class Shape {
  num get area;

  @override
  String toString() => '$runtimeType: $area';
}

class Circle extends Shape {
  final num radius;

  Circle(this.radius);

  @override
  num get area => pi * pow(radius, 2);
}

class Square extends Shape {
  final num side;

  Square(this.side);

  @override
  num get area => side * side;
}

class Rect extends Shape {
  final num w;
  final num h;

  Rect(this.w, this.h);

  @override
  num get area => w * h;
}
