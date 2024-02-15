import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppingcarts/splashScreen.dart';
import 'package:shoppingcarts/views/CartPage.dart';
import 'package:shoppingcarts/views/MainScreen.dart';
import 'package:shoppingcarts/views/login_view.dart';
import 'package:shoppingcarts/views/signUp_view.dart';


class RouteGenerator {
  static const String routeInitial = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    var encodedString = jsonEncode(args);
    Map<String, dynamic> valueMap = {};
    if(encodedString != "null")
    {
      valueMap = json.decode(encodedString);
    }

    switch (settings.name) {

      case routeInitial:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case '/mainScreen':
        return MaterialPageRoute(builder: (_) => MainScreen());

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginView());

      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignUpView());

      case '/cart':
        return MaterialPageRoute(builder: (_) =>  CartPage());

      default:
        return _errorRoute();
    }
  }


  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Bad Gateway'),
        ),
        body: const Center(
          child: Text('Oops Something Went Wrong..!'),
        ),
      );
    });
  }
}