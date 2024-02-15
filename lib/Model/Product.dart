import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final String subCategory;
  final int availableQuantity;
  final int orderedQuantity;
  final dynamic price;
  final int maxQuantity;
  int quantity;
  bool isInCart;
  // final int color1;
  // final String color2;
  // final String color3;
  // final String color4;
  // final int size1;
  // final String size2;
  // final String size3;
  // final String size4;
  // final String size5;
  // final String size6;
  // final String size7;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.subCategory,
    required this.availableQuantity,
    required this.orderedQuantity,
    required this.price,
    required this.maxQuantity,
    this.quantity = 0,
    this.isInCart = true,
    // required this.color1,
    // required this.color2,
    // required this.color3,
    // required this.color4,
    // required this.size1,
    // required this.size2,
    // required this.size3,
    // required this.size4,
    // required this.size5,
    // required this.size6,
    // required this.size7,
  });
  // void updateQuantity(int newQuantity) {
  //   quantity = newQuantity;
  //   notifyListeners();
  // }
}
