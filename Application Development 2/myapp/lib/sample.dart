class Student {
  static var stdBranch;
  var stdName;
  var rollNum;

  // Student();

  // Student(this.stdName, this.rollNum);

  showStdInfo() {
    print("Student name is : ${stdName}");
    print("Student branch is : ${stdBranch}");
    print("Student roll number is : ${rollNum}");
  }
}

class Parent {
  Parent() {
    print("This is the super class constructor");
  }
}

class Child extends Parent {
  Child() : super() {
    print("This is the sub class constructor");
  }
}

class Superclass {
  Superclass(String msg) {
    print("This is a superclass constructor");
    print(msg);
  }
}

class Subclass extends Superclass {
  Subclass() : super("We are calling superclass constructor explicitly") {
    print("This is a subclass constructor");
  }

  display() {
    print("Welcome to Dart!");
  }
}

class Human {
  void run() {
    print("Human is running");
  }
}

class Man extends Human {
  void run() {
    super.run();
    print("Boy is running");
  }
}

void main() {
  var words = ['sky', 'cloud', 'forest', 'welcome'];
  words.forEach((String word) {
    print('$word has ${word.length} characters');
  });

  Man m = new Man();
  m.run();

  print("Dart Implicit Superclass constructor example");
  Subclass s = new Subclass();
  s.display();

  Child c = new Child();

  Student std1 = new Student();
  Student std2 = Student();
  std1.rollNum = 90183;
  std1.stdName = "Bob";
  Student.stdBranch = "CST";

  var heartSymbol = '\u2665';
  var laughSymbol = '\u{1f600}';
  print(heartSymbol);
  print(laughSymbol);

  std1.showStdInfo();

  int integerNumber = 5;
  double doubleNumber = 42.15;
  print("Integer : $integerNumber, Double : $doubleNumber");

  String text = "Hello";
  print(text);
  print("String : $text");

  bool isDartFun = true;
  bool isPythonFun = false;
  print("Dart is fun: $isDartFun , Python is fun: $isPythonFun");

  List<int> nums = [1, 2, 3, 4, 5, 6];
  print("List: $nums");

  Set<String> fruits = {'apple', 'banana', 'mango'};
  print("Fruits: $fruits");

  Map<dynamic, dynamic> person = {
    'name': 'Alice',
    'age': 30,
    'isStudent': true,
  };
  print("Persons: $person");

  var i = "sakku";

  // creating a fixed length of list with a length of 5
  // but we have to explicitly fill the default values
  var list1 = List<int>.filled(5, 0);
  print(list1);

  list1[1] = 101;

  final int runtimeValue = DateTime.now().hour;
  print(runtimeValue);
  const int compileTimeValue = 3;
  print(compileTimeValue);

  const num1 = 10;
  const num2 = 23;
  const op = Operation.multiply;
  switch (op) {
    case Operation.plus:
      print('$num1 + $num2 = ${num1 + num2}');
      break;
    case Operation.minus:
      print('$num1 - $num2 = ${num1 - num2}');
      break;
    case Operation.multiply:
      print('$num1 * $num2 = ${num1 * num2}');
      break;
    case Operation.divide:
      print('$num1 / $num2 = ${num1 ~/ num2}');
      break;
  }

  var add = (int x, int y) => x + y;

  print(add(100, 43));
}

enum Operation { plus, minus, multiply, divide }
