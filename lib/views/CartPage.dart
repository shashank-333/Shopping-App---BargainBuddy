import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../Model/Cart.dart';
import '../Provider/CartProvider.dart';
import 'Payment.dart';
import 'PaymentOptions.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
  static const route = '/cart_page';
}

// class TotalPriceNotifier extends ChangeNotifier {
//   double _totalSelectedPrice = 0;
//
//   double get totalSelectedPrice => _totalSelectedPrice;
//
//   set totalSelectedPrice(double value) {
//     _totalSelectedPrice = value;
//     notifyListeners();
//   }
// }

class _CartPageState extends State<CartPage> {

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments;
    var cartProvider = Provider.of<CartProvider>(context);
    var totalPriceNotifier = Provider.of<CartProvider>(context);

    // double totalSelectedPrice = 0;
    final GlobalKey<_CartPageState> _key = GlobalKey<_CartPageState>();

    // Calculate total price for selected items
    // double totalSelectedPrice = cartProvider.cartItems
    //     .where((item) => item.isSelected)
    //     .fold(0, (prev, item) => prev + item.subtotal);

    return Scaffold(
        appBar: AppBar(
          title: const Padding(
            padding: EdgeInsets.only(left: 22.0),
            child: Text(
              'Cart',
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: cartProvider.cartItems.length == 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/No Item Found.json',
                      height: 250,
                      width: 250,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
              )
            : ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        height: 550,
                        padding: const EdgeInsets.all(16.0),
                        child: ListView.builder(
                          itemCount: cartProvider.cartItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            var cartItem = cartProvider.cartItems[index];
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset(
                                      'assets/mock_images/products/${cartItem.productId}.jpg',
                                      fit: BoxFit.cover,
                                      width: 75, // Adjust image width as needed
                                      height:
                                          75, // Adjust image height as needed
                                    ),
                                  ),
                                  const SizedBox(width: 16.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartItem.productName,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Price: \₹${cartItem.price.toInt()}",
                                              style: const TextStyle(
                                                  fontSize: 14.0),
                                            ),
                                            Expanded(
                                              child: CartItemWidget(
                                                cartItem: cartItem,
                                                onTotalPriceChanged:
                                                    (subtotal) {
                                                  // Update the totalSelectedPrice when a checkbox is clicked
                                                  double totalSelectedPrice =
                                                      cartProvider.cartItems
                                                          .where((item) =>
                                                              item.isSelected)
                                                          .fold(
                                                              0,
                                                              (prev, item) =>
                                                                  prev +
                                                                  item.subtotal);

                                                  totalPriceNotifier
                                                          .totalSelectedPrice =
                                                      totalSelectedPrice;
                                                  // // Update the totalSelectedPrice when a checkbox is clicked
                                                  // setState(() {
                                                  //   totalSelectedPrice = cartProvider
                                                  //       .cartItems
                                                  //       .where(
                                                  //           (item) => item.isSelected)
                                                  //       .fold(
                                                  //           0,
                                                  //           (prev, item) =>
                                                  //               prev + item.subtotal);
                                                  // });
                                                  //
                                                  // print(totalSelectedPrice);

                                                  print(
                                                      "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // SizedBox(height: 12),
                      Consumer<CartProvider>(
                        builder: (context, totalPriceNotifier, _) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total : \₹${totalPriceNotifier.totalSelectedPrice.toInt()}',
                                  style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                 ElevatedButton(
                                  onPressed: () {
                                    totalPriceNotifier.totalSelectedPrice.toInt() == 0 ?  AnimatedSnackBar.material(
                                      'Please Select a Item In Cart to proceed with checkout',
                                      type: AnimatedSnackBarType.info,
                                    ).show(context) :
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (ctx) => PaymentOptionPage(
                                                  totalAmount:
                                                      totalPriceNotifier
                                                          .totalSelectedPrice,
                                                )));
                                    // Navigator.push(
                                    //     context,
                                    //     CupertinoPageRoute(
                                    //         builder: (ctx) => MySample()));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Adjust the border radius as needed
                                    ),
                                    // You can also customize other properties like padding, background color, etc.
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 12.0),
                                    // primary: Colors
                                    //     .amber, // Adjust the button color as needed
                                  ),
                                  child: const Text(
                                    'Place Order',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ));
  }
}

class CartItemWidget extends StatefulWidget {
  final CartItem cartItem;
  final Function(int) onTotalPriceChanged;

  CartItemWidget({
    required this.cartItem,
    required this.onTotalPriceChanged,
  });

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Checkbox(
              value: widget.cartItem.isSelected,
              onChanged: (value) {
                setState(() {
                  widget.cartItem.isSelected = value ?? false;

                  // widget.onTotalPriceChanged(widget.cartItem.subtotal.toInt());
                });
                // Calculate the subtotal for the current cart item
                dynamic subtotal =
                    widget.cartItem.price * widget.cartItem.quantity;

                // Trigger the callback to update the total price
                widget.onTotalPriceChanged(subtotal.toInt());
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle_outlined),
            onPressed: () {
              // if (widget.cartItem.quantity > 0) {
              setState(() {
                widget.cartItem.quantity--;
                // If quantity becomes zero, remove the item from the cart
                if (widget.cartItem.quantity == 0) {
                  // Remove the item from the cart
                  // (Assuming you have a removeItemFromCart method in your cartProvider)
                  Provider.of<CartProvider>(context, listen: false)
                      .removeFromCart(widget.cartItem);
                }
              });
              // Calculate the subtotal for the current cart item
              dynamic subtotal =
                  widget.cartItem.price * widget.cartItem.quantity;

              // Trigger the callback to update the total price
              widget.onTotalPriceChanged(subtotal.toInt());
            },
          ),
          Text(
            '${widget.cartItem.quantity}',
            style: const TextStyle(fontSize: 16.0),
          ),
          Expanded(
            child: IconButton(
              icon: const Icon(Icons.add_circle_rounded),
              onPressed: () {
                setState(() {
                  widget.cartItem.quantity++;
                });
                // Calculate the subtotal for the current cart item
                dynamic subtotal =
                    widget.cartItem.price * widget.cartItem.quantity;

                // Trigger the callback to update the total price
                widget.onTotalPriceChanged(subtotal.toInt());
              },
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () {
                    // Handle add to cart logic
                  },
                ),
                Visibility(
                  visible: widget.cartItem.quantity != 0,
                  child: Positioned(
                    top: 5,
                    right: 5,
                    child: CircleAvatar(
                      backgroundColor: Colors.red, // Change color as needed
                      radius: 8,
                      child: Text(
                        '${widget.cartItem.quantity}',
                        style:
                            const TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
