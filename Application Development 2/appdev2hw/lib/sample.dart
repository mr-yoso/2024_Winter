import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizza App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/registration': (context) => RegistrationScreen(),
      },
    );
  }
}

class UserData {
  static String? userId;
  static String? password;
}

class RegistrationScreen extends StatelessWidget {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _register(BuildContext context) {
    String userId = userIdController.text.trim();
    String password = passwordController.text.trim();

    if (userId.isEmpty && password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User ID and password cannot be empty'),
        ),
      );
      return;
    }

    UserData.userId = userId;
    UserData.password = password;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Registration successful'),
      ),
    );
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userIdController,
              decoration: InputDecoration(
                labelText: 'User ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => _register(context),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login(BuildContext context) {
    String userId = userIdController.text.trim();
    String password = passwordController.text.trim();

    if (userId.isEmpty && password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User ID and password cannot be empty'),
        ),
      );
      return;
    }

    if (UserData.userId == userId && UserData.password == password) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login successful'),
        ),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Incorrect User ID or Password'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: userIdController,
              decoration: InputDecoration(
                labelText: 'User ID',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => _login(context),
              child: Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/registration');
              },
              child: Text('Create an account'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<PizzaItem> pizzaItems = [
      PizzaItem(
          name: 'Margherita',
          description: 'Tomato sauce, mozzarella, basil',
          image: 'assets/pizza_margherita.jpg',
          price: 5.99),
      PizzaItem(
          name: 'Pepperoni',
          description: 'Pepperoni, tomato sauce, cheese',
          image: 'assets/pizza_pepperoni.jpg',
          price: 6.99),
      // Add more pizzas as desired...
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${UserData.userId ?? 'Guest'}'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              UserData.userId = null;
              UserData.password = null;
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(8),
        itemCount: pizzaItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PizzaDescriptionScreen(pizza: pizzaItems[index]),
                ),
              );
            },
            child: Card(
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.asset(
                      pizzaItems[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      pizzaItems[index].name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PizzaDescriptionScreen extends StatefulWidget {
  final PizzaItem pizza;

  PizzaDescriptionScreen({Key? key, required this.pizza}) : super(key: key);

  @override
  _PizzaDescriptionScreenState createState() => _PizzaDescriptionScreenState();
}

class _PizzaDescriptionScreenState extends State<PizzaDescriptionScreen> {
  int _selectedSizeIndex = 1; // Default to Medium size
  int _quantity = 1;
  int _toppingsQuantity = 0;

  double get _basePrice =>
      [10.0, 20.0, 30.0][_selectedSizeIndex]; // Small, Medium, Big
  double get _toppingPrice =>
      [2.0, 3.0, 5.0][_selectedSizeIndex]; // Small, Medium, Big

  double get _totalCost =>
      (_basePrice + _toppingsQuantity * _toppingPrice) * _quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pizza.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(
                widget.pizza.image,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              widget.pizza.description,
              style: TextStyle(fontSize: 16),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderScreen(pizza: widget.pizza),
                    ),
                  );
                },
                child: Text('Order'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class OrderScreen extends StatefulWidget {
  final PizzaItem pizza;

  OrderScreen({Key? key, required this.pizza}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    double totalCost = widget.pizza.price * _quantity;

    return Scaffold(
      appBar: AppBar(
        title: Text('Order ${widget.pizza.name}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pizza: ${widget.pizza.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'User ID: ${UserData.userId ?? 'Anonymous'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Quantity:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_quantity > 1) _quantity--;
                    });
                  },
                  icon: Icon(Icons.remove),
                ),
                Text(
                  '$_quantity',
                  style: TextStyle(fontSize: 16),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OrderSummaryScreen(totalPrice: totalCost),
                    ),
                  );
                },
                child: Text('Order - \$${totalCost.toStringAsFixed(2)}'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderSummaryScreen extends StatelessWidget {
  final double totalPrice;

  OrderSummaryScreen({Key? key, required this.totalPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Price: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/home'));
              },
              child: Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class PizzaItem {
  final String name;
  final String image;
  final String description;
  final double price;

  PizzaItem({
    required this.name,
    required this.image,
    required this.description,
    this.price = 10.99,
  });
}
