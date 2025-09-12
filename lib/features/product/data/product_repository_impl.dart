import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/product.dart';

class ProductRepositoryImpl {
  Future<Product?> fetchProduct(int id) async {
    final url = Uri.parse('https://dummyjson.com/products/$id');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Product.fromJson(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
