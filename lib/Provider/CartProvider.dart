import 'package:flutter/foundation.dart';

import '../Model/Cart.dart';

class CartProvider extends ChangeNotifier {
  Map<String, CartItem> _cartItemsMap = {};

  List<CartItem> get cartItems => _cartItemsMap.values.toList();

  double _totalSelectedPrice = 0;

  double get totalSelectedPrice => _totalSelectedPrice;

  set totalSelectedPrice(double value) {
    _totalSelectedPrice = value;
    notifyListeners();
  }

  void addToCart(CartItem cartItem) {
    if (_cartItemsMap.containsKey(cartItem.productId)) {
      // Product already in the cart, update the quantity
      _cartItemsMap[cartItem.productId]!.quantity += cartItem.quantity;
    } else {
      // Product not in the cart, add it
      _cartItemsMap[cartItem.productId] = cartItem;
    }

    notifyListeners();
  }

  void removeFromCart(CartItem cartItem) {
    _cartItemsMap.remove(cartItem.productId);
    notifyListeners();
  }
}
