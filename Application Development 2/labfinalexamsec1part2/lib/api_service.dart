import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://fakestoreapi.com/products/category/jewelery";

  Future<List<dynamic>> fetchJewelryItems() async {
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load jewelry');
    }
  }
}
