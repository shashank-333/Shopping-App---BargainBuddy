import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../Keys.dart';
import '../Model/Product.dart';
import 'package:http/http.dart' as http;


class CartItemWidget extends StatefulWidget {
  final Product product;
  final Function(Product) onAddToCart;

  CartItemWidget({required this.product, required this.onAddToCart});

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


  void _sendFirebaseMessage(Product product) async {
    String? token = await _firebaseMessaging.getToken();
    final Map<String, dynamic> message = {
      'notification': {
        'title': '${product.name} Added to Your Cart',
        'body': '${product.name} cost of each is ₹${product.price} ',
      },
      'to': token,
    };

    try {
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('Message sent successfully');
      } else {
        print('Failed to send message. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error sending Firebase message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.remove_circle_outlined),
          onPressed: () {
            if (widget.product.quantity > 0) {
              setState(() {
                widget.product.quantity--;
              });
            }
          },
        ),
        Text(
          '${widget.product.quantity}',
          style: TextStyle(fontSize: 16.0),
        ),
        IconButton(
          icon: Icon(Icons.add_circle_rounded),
          onPressed: () {
            setState(() {
              widget.product.quantity++;
            });
          },
        ),
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                widget.product.quantity == 0
                    ? null
                    : widget.onAddToCart(widget.product);
                _sendFirebaseMessage(widget.product);
              },
            ),
            Visibility(
              visible: widget.product.quantity != 0,
              child: Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  backgroundColor: Colors.red, // Change color as needed
                  radius: 8,
                  child: Text(
                    '${widget.product.quantity}',
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );


  }

}
