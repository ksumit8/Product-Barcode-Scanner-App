import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../domain/product.dart';

class ProductRepositoryImpl {
  Future<Product?> fetchProduct(int id) async {
    final url = Uri.parse('https://dummyjson.com/products/$id');

    try {
      final response = await http.get(url).timeout(
        const Duration(seconds: 10),
        onTimeout: () => throw TimeoutException("Request timed out"),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Product.fromJson(data);
      } else if (response.statusCode == 404) {
        // Product not found
        throw HttpException("Product not found", uri: url);
      } else {
        // Other server errors
        throw HttpException(
          "Failed to fetch product. Status code: ${response.statusCode}",
          uri: url,
        );
      }
    } on SocketException {
      // No internet connection
      throw const SocketException("No Internet connection");
    } on TimeoutException catch (e) {
      // Timeout error
      throw TimeoutException(e.message);
    } on FormatException {
      // JSON parsing error
      throw const FormatException("Invalid JSON format");
    } catch (e) {
      // Any other error
      rethrow;
    }
  }
}
