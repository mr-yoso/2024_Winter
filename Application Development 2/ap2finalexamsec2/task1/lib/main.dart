import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Item 1',
                  icon: Icon(
                    Icons.home,
                    color: Colors.blue,
                  ),
                ),
                Tab(
                  text: 'Item 2',
                  icon: Icon(Icons.person),
                ),
                Tab(
                  text: 'Item 3',
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
                Tab(
                  text: 'Item 4',
                  icon: Icon(Icons.search),
                ),
                Tab(
                  text: 'Item 5',
                  icon: Icon(
                    Icons.settings,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            title: Text('Products'),
          ),
          body: TabBarView(
            children: [
              ProductView(0),
              ProductView(1),
              ProductView(2),
              ProductView(3),
              ProductView(4),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductView extends StatelessWidget {
  final int index;

  ProductView(this.index);

  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: apiService.fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var product = snapshot.data![index];
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      product['image'],
                      fit: BoxFit.contain,
                      // Ensures the image fits without cropping
                      width:
                          MediaQuery.of(context).size.width, // Use screen width
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(product['title'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('\$${product['price']}',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[600])),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              // Align rating to the end
                              children: [
                                Icon(Icons.star, color: Colors.yellow[700]),
                                Text("${product['rating']['rate']}",
                                    style: TextStyle(fontSize: 14)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class ApiService {
  final String baseUrl = "https://fakestoreapi.com/products?limit=5";

  Future<List<dynamic>> fetchProducts() async {
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }
}
