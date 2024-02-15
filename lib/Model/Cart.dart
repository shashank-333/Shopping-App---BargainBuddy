class CartItem {
  final String productId;
  final String productName;
  final dynamic price;
  int quantity;
  bool isSelected; // Add quantity property

  CartItem({
    required this.productId,
    required this.productName,
    required this.price,
    this.quantity = 0,
    this.isSelected = false,
  });
  dynamic get subtotal => price * quantity;
}
