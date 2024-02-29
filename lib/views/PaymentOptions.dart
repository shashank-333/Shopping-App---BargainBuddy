import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingcarts/views/paymentUpi.dart';

import '../Keys.dart';
import 'Payment.dart';
import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:http/http.dart' as http;

class PaymentOptionPage extends StatefulWidget {
  final double totalAmount;

  PaymentOptionPage({required this.totalAmount});

  @override
  _PaymentOptionPageState createState() => _PaymentOptionPageState();
}

class _PaymentOptionPageState extends State<PaymentOptionPage> {
  String selectedPaymentOption = '';
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Options'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Amount: ₹${widget.totalAmount.toStringAsFixed(2)}',
              style:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            buildPaymentOption('UPI', Icons.mobile_friendly),
            buildPaymentOption('Credit Card / Debit Card', Icons.credit_card),
            // Add more payment options as needed
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                if (selectedPaymentOption.isNotEmpty) {
                  // Implement payment processing logic here
                  // You will need to integrate a payment gateway SDK
                  // and handle the payment process based on the selected option
                  if (selectedPaymentOption == 'UPI') {
                    Navigator.push(
                        context, CupertinoPageRoute(builder: (ctx) => PaymentUpi( totalAmount: widget.totalAmount,)));

                    print("UPI");
                  } else {
                    await makePayment();
                  }
                  // showPaymentProcessingDialog();
                } else {
                  // Show an error message if no payment option is selected
                  showNoPaymentOptionSelectedDialog();
                }
              },
              style: ElevatedButton.styleFrom(
                // primary: Colors.amber,
              ),
              child: const Text('Proceed to Pay'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPaymentOption(String title, IconData icon) {
    return InkWell(
      onTap: () {
        // Handle the selected payment option
        // You may show additional UI or perform specific actions based on the option
        setState(() {
          selectedPaymentOption = title;
          print(selectedPaymentOption);
        });
      },
      child: Card(
        elevation: 2.0,
        color: selectedPaymentOption == title ? Colors.amber : null,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 30.0),
              const SizedBox(width: 20.0),
              Text(
                title,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showPaymentProcessingDialog() async {
    // Simulate a loading dialog while processing the payment
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16.0),
              Text('Processing Payment...'),
            ],
          ),
        );
      },
    );
  }

  Future<void> showNoPaymentOptionSelectedDialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Please select a payment option.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent(
          "${widget.totalAmount.toInt().toString()}00", 'INR');
      // print(paymentIntent);
      var gpay = const stripe.PaymentSheetGooglePay(
          merchantCountryCode: "GB", currencyCode: "GBP", testEnv: true);
// print(gpay);
      print(
        paymentIntent!['client_secret'],
      );
      //STEP 2: Initialize Payment Sheet
      await stripe.Stripe.instance
          .initPaymentSheet(
          paymentSheetParameters: stripe.SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent![
              'client_secret'], //Gotten from payment intent
              style: ThemeMode.light,
              merchantDisplayName: 'Shashank',
              googlePay: gpay))
          .then((value) {
            print("intialed");
      });
      print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      print(err.runtimeType);
      print("err");
    }
  }

  displayPaymentSheet() async {
    try {
      await stripe.Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print('$e');
    }
  }
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
        "description": 'Order #1234',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer $Stripe_Secret',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
