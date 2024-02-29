// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:http/http.dart' as http;
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   Map<String, dynamic>? paymentIntent;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Stripe Payment'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextButton(
//               child: const Text('Buy Now'),
//               onPressed: () async {
//                 await makePayment();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> makePayment() async {
//     try {
//       paymentIntent = await createPaymentIntent('10000', 'USD');
//       // print(paymentIntent);
//       var gpay = const PaymentSheetGooglePay(
//           merchantCountryCode: "US", currencyCode: "USD", testEnv: true);
// // print(gpay);
//       print(paymentIntent![
//       'client_secret'],);
//       //STEP 2: Initialize Payment Sheet
//       await Stripe.instance
//           .initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//               paymentIntentClientSecret: paymentIntent![
//               'client_secret'], //Gotten from payment intent
//               style: ThemeMode.light,
//               merchantDisplayName: 'Shashank',
//               googlePay: gpay))
//           .then((value) {
//         print("Payment Sheet initialized successfully");
//       });
//       print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
//       //STEP 3: Display Payment sheet
//       displayPaymentSheet();
//
//     } catch (err) {
//       print(err.runtimeType);
//       print("err");
//     }
//   }
//
//   displayPaymentSheet() async {
//     try {
//       await Stripe.instance.presentPaymentSheet();
//       print("Done");
//     } catch (e) {
//       print('$e');
//       print("object");
//     }
//   }
//
//   createPaymentIntent(String amount, String currency) async {
//     try {
//       Map<String, dynamic> body = {
//         'amount': amount,
//         'currency': currency,
//       };
//
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization':
//           'Bearer ',
//           'Content-Type': 'application/x-www-form-urlencoded'
//         },
//         body: body,
//       );
//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }
// }
