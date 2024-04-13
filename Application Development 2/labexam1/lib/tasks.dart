//Q#1
List<int> findEvenAndSort(List<int> numbers) {
  return numbers.where((number) => number.isEven).toList()..sort();
}

//Q#2
int calculateFactorial(int n, int factorial(int n)) {
  if (n == 0) return 1;
  return factorial(n - 1) * n;
}

//Q#3
class UserProfile {
  final String email;
  final String username;
  final String profilePictureUrl;

  UserProfile.full(this.email, this.username, this.profilePictureUrl);

  UserProfile.fromEmail(this.email,
      {this.username = "", this.profilePictureUrl = ""});

  UserProfile.fromUsername(this.username,
      {this.email = "", this.profilePictureUrl = ""});
}

//Q#4
num performMathOperation(num num1, num num2, {String operation = "+"}) {
  switch (operation) {
    case "+":
      return num1 + num2;
    case "-":
      return num1 - num2;
    case "*":
      return num1 * num2;
    case "/":
      return num1 / num2;
    default:
      return 0;
  }
}

//Q#5

//Q#6
String orderPizza({
  String size = "medium",
  String crust = "thin",
  List<String> toppings = const [],
  String specialInstructions = "",
}) {
  var orderDetails =
      "Size: $size, Crust: $crust, Toppings: ${toppings.join(', ')}";
  if (specialInstructions.isNotEmpty) {
    orderDetails += ", Special Instructions: $specialInstructions";
  }
  return "Your pizza order: $orderDetails";
}

void main() {
  //Q#1
  var inputList = [1, 12, 3, 14, 5, 6, 7, 8, 9, 10, 2];
  var evenSortedList = findEvenAndSort(inputList);
  print(evenSortedList); // Output: [2, 6, 8, 10, 12, 14]

  //Q#2
  int factorial(int n) => calculateFactorial(n, factorial);
  var result = factorial(5);
  print(result); // Output: 120

  //Q#4
  var sum = performMathOperation(5, 3);
  var difference = performMathOperation(5, 3, operation: "-");
  print(sum); // Output: 8
  print(difference); // Output: 2

  //Q#6
  var basicOrder = orderPizza();
  var veggieLover = orderPizza(toppings: ["mushrooms", "peppers", "onions"]);
  var specialRequest = orderPizza(
      size: "large",
      crust: "stuffed",
      specialInstructions: "Extra cheese, please!");

  print(
      basicOrder);
  print(
      veggieLover);
  print(
      specialRequest);
}
