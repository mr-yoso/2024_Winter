class Employee {
  var _name = "Rolly";
  var _age = 20;
  var _salary = 1000;

  get name => _name;

  set name(value) {
    _name = value;
  }

  get age => _age;

  get salary => _salary;

  set salary(value) {
    _salary = value;
  }

  set age(value) {
    _age = value;
  }
}

abstract class Shape {
  void getArea();
}

class Rectangle extends Shape {
  @override
  void getArea() {
    // TODO: implement getArea
    var _length = 10;
    var _width = 6;
    print("Rectangle area = ${_length * _width}");
  }
}

class Circle extends Shape {
  @override
  void getArea() {
    // TODO: implement getArea
    var _radius = 5;
    print("Circle area = ${_radius * _radius}");
  }
}

class A {
  var _first;
  var _second;
}

int inc(int x) => ++x;

int dec(int x) => --x;

int apply(int x, Function f) {
  return f(x);
}

class Laptop {

  Laptop({var name, var color}) {
    print("Laptop constructor");
    print("Name: ${name}");
    print("Color: ${color}");
  }
}

class MacBook extends Laptop {

  MacBook({var name, var color}) : super(name: name, color: color) {
    print("MacBook constructor");
  }
}
void main() {
  var macbook = new MacBook(name: "MacBook Pro", color: "Silver");

  String buildMessage(String name, String occupation) {
    return "$name is a $occupation";
  }

  var name = "John Doe";
  var occupation = "gardener";

  var msg = buildMessage(name, occupation);
  print(msg);

  int r1 = apply(3, inc);
  int r2 = apply(2, dec);
  print(r1);
  print(r2);

  String title = "Dart course";
  print(title);
  title = title.toUpperCase();
  print(title);
  title = title.toLowerCase();
  print(title);

  var values = {1, 3, 5, 7, 9};
  var sum = 0;
  for (var value in values) {
    sum += value;
  }
  print(sum);

  Rectangle r = new Rectangle();
  r.getArea();
  Circle c = new Circle();
  c.getArea();

  A a = new A();
  a._first = "New first";
  a._second = "New second";
  print("${a._first}: ${a._second}");
}
