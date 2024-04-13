import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _nameController = TextEditingController();

  String userName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/coffeebook.jpg',
              height: 250.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Enter your name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  userName = _nameController.text;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookListScreen(userName: userName),
                  ),
                );
              },
              child: Text('Visit'),
            ),
          ],
        ),
      ),
    );
  }
}

class BookListScreen extends StatelessWidget {
  final String userName;

  BookListScreen({required this.userName});

  final List<Book> books = [
    Book(
      image: 'assets/coffeebook.jpg',
      name: 'Book Title 1',
      mrp: 1500.0,
      price: 20,
    ),
    Book(
      image: 'assets/coffeebook.jpg',
      name: 'Book Title 2',
      mrp: 1500.0,
      price: 25,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $userName'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return InkWell(
            onTap: index < 2
                ? () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailsScreen(book: book),
                      ),
                    )
                : null,
            child: BookListItem(book: book),
          );
        },
      ),
    );
  }
}

class BookListItem extends StatelessWidget {
  final Book book;

  BookListItem({required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image.asset(
            book.image,
            width: 100,
            height: 100,
          ),
          SizedBox(width: 16.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book.name,
                style: TextStyle(fontSize: 16.0),
              ),
              Text(
                '\$${book.price}',
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BookDetailsScreen extends StatefulWidget {
  final Book book;

  BookDetailsScreen({required this.book});

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final book = widget.book;

    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.asset(
                book.image,
                width: double.infinity,
              ),
              SizedBox(height: 16.0),
              Text(
                book.name,
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                '\$${book.price}',
                style: TextStyle(fontSize: 18.0, color: Colors.green),
              ),
              SizedBox(height: 16.0),
              Text(
                'A captivating story that will keep you on the edge of your seat...',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quantity:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () => setState(() {
                          if (quantity > 1) {
                            quantity--;
                          }
                          updateTotalPrice();
                        }),
                      ),
                      Text(
                        '$quantity',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () => setState(() {
                          quantity++;
                          updateTotalPrice();
                        }),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                '\$${calculateTotalPrice(book.price, quantity)}',
                style: TextStyle(fontSize: 18.0, color: Colors.green),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        book: book,
                        quantity: quantity,
                        totalPrice: calculateTotalPrice(book.price, quantity),
                      ),
                    ),
                  );
                },
                child: Text('Buy Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateTotalPrice() {
    setState(() {});
  }

  double calculateTotalPrice(double price, int quantity) {
    return price * quantity;
  }
}

class PaymentScreen extends StatelessWidget {
  final Book book;
  final int quantity;
  final double totalPrice;

  PaymentScreen(
      {required this.book, required this.quantity, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Book: ${book.name}',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              'Quantity: $quantity',
              style: TextStyle(fontSize: 16.0),
            ),
            Text(
              'Total Price: \$${totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16.0, color: Colors.green),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final snackBar = SnackBar(
                  content: Text(
                    'Thanks for the payment of \$${totalPrice.toStringAsFixed(2)} via Paytm, your request has been processed.',
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text('Paytm'),
            ),
            ElevatedButton(
              onPressed: () {
                final snackBar = SnackBar(
                  content: Text(
                    'Thanks for the payment of \$${totalPrice.toStringAsFixed(2)} via GooglePay, your request has been processed.',
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text('GooglePay'),
            ),
            // Add more payment options (optional)
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen())),
              // Navigate back to Book List
              child: Text('Home'),
            ),
          ],
        ),
      ),
    );
  }
}

class Book {
  final String name;
  final String image;
  final double mrp;
  final double price;

  Book({
    required this.name,
    required this.image,
    required this.mrp,
    required this.price,
  });
}
