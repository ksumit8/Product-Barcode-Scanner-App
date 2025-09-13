import 'dart:async';
import 'package:flutter/material.dart';
import '../../data/product_repository_impl.dart';
import '../../../product/data/product_repository_impl.dart' as product_api;
import '../../../product/domain/product.dart';

class ScannerProvider extends ChangeNotifier {
  final _repo = ProductRepositoryImpl(); // existing product validation repo
  final _productRepo = product_api.ProductRepositoryImpl();

  String? scannedResult;
  Product? scannedProduct;
  bool isLoading = false;

  Future<void> onScanned(String code) async {
    // reset previous values
    scannedResult = null;
    scannedProduct = null;
    isLoading = true; // show loader
    notifyListeners();

    // Extract the number at the end of barcode
    final regExp = RegExp(r'(\d+)$');
    final match = regExp.firstMatch(code);

    if (match == null) {
      isLoading = false;
      scannedResult = "Invalid Product";
      notifyListeners();
      return;
    }

    final id = int.tryParse(match.group(1)!);
    if (id == null) {
      isLoading = false;
      scannedResult = "Invalid Product";
      notifyListeners();
      return;
    }

    // Check valid product IDs (1–5)
    if (!_repo.isValidProduct(code)) {
      isLoading = false;
      scannedResult = "Invalid Product";
      notifyListeners();
      return;
    }

    // Fetch product details
    try {
      final product = await _productRepo.fetchProduct(id);
      if (product != null) {
        scannedProduct = product;
        scannedResult = "Product Found!";
      } else {
        scannedProduct = null;
        scannedResult = "Product not found";
      }
    } catch (e) {
      scannedProduct = null;
      scannedResult = "Error while fetching product";
    } finally {
      isLoading = false; // stop loading
      notifyListeners();
    }
  }

  void clear() {
    scannedResult = null;
    scannedProduct = null;
    isLoading = false;
    notifyListeners();
  }
}
