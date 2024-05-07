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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: FutureBuilder<List<dynamic>>(
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
                var item = JewelryItem.fromJson(snapshot.data![index]);
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.network(item.imageUrl, fit: BoxFit.cover),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(item.title, style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text("\$${item.price}", style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}