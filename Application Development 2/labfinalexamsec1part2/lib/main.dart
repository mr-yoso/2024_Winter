import 'package:flutter/material.dart';
import 'api_service.dart';
import 'jewelry_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jewelry Store',
      home: JewelryPage(),
    );
  }
}

class JewelryPage extends StatefulWidget {
  @override
  _JewelryPageState createState() => _JewelryPageState();
}

class _JewelryPageState extends State<JewelryPage> {
  final ApiService apiService = ApiService();
  int _selectedIndex =
      0; // Variable to track the selected index in the bottom navigation bar

  Widget _buildPage(int index) {
    switch (index) {
      case 0: // Home
        return Center(child: Text("Welcome to the Home Page!"));
      case 1: // Favorites
        return FutureBuilder<List<dynamic>>(
          future: apiService.fetchJewelryItems(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  JewelryItem item =
                      JewelryItem.fromJson(snapshot.data![index]);
                  return Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child:
                              Image.network(item.imageUrl, fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Icon(Icons.star),
                              Text("${item.ratingRate} (${item.ratingCount})"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(item.title,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text("\$${item.price}",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        );
      case 2: // Browse
        return Center(
            child: Text("Explore our collections on the Browse Page!"));
      case 3: // Profile
        return Center(child: Text("Manage your profile here."));
      default:
        return Center(child: Text("This page is not available."));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: _buildPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Browse'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
