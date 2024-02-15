import 'package:flutter/foundation.dart';

import '../Model/Product.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => _products;

  void updateQuantity(Product product, int newQuantity) {
    if (newQuantity < 0) {
      throw Exception('Quantity cannot be negative.'); // Handle error
    } else if (newQuantity > product.maxQuantity) {
      throw Exception('Quantity exceeds product limit.'); // Handle error
    }

    final index = _products.indexOf(product);
    if (index >= 0) {
      _products[index].quantity = newQuantity;
      notifyListeners();
    } else {
      // Handle missing product error (if applicable)
    }
  }

// ... other product-related methods (if needed)
}
