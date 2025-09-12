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
    // Always reset previous values
    scannedResult = null;
    scannedProduct = null;
    isLoading = false;
    notifyListeners();

    // Extract the number at the end of barcode
    final regExp = RegExp(r'(\d+)$');
    final match = regExp.firstMatch(code);

    if (match == null) {
      scannedResult = "Invalid Product";
      notifyListeners();
      return;
    }

    final id = int.tryParse(match.group(1)!);
    if (id == null) {
      scannedResult = "Invalid Product";
      notifyListeners();
      return;
    }

    // Check valid product IDs (1–5)
    if (!_repo.isValidProduct(code)) {
      scannedResult = "Invalid Product";
      notifyListeners();
      return;
    }

    // Valid product ID, start loading
    isLoading = true;
    scannedResult = "Fetching product...";
    notifyListeners();

    // Fetch product details (always fetch, even if same product scanned again)
    try {
      final product = await _productRepo.fetchProduct(id);
      if (product != null) {
        scannedProduct = product;
        scannedResult = "Valid Product ID: $id";
      } else {
        scannedProduct = null;
        scannedResult = "Product not found";
      }
    } catch (e) {
      scannedProduct = null;
      scannedResult = "Error fetching product";
    } finally {
      isLoading = false;
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
