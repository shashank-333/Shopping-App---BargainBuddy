
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoppingcarts/views/MainScreen.dart';
import 'package:shoppingcarts/views/login_view.dart';


class InitialScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Still waiting for authentication state, return a loading screen
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          // Error occurred during authentication, display error message
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          // Authentication state retrieved successfully
          final User? user = snapshot.data;

          if (user != null) {
            // User is logged in, navigate to the main screen
            return MainScreen();
          } else {
            // User is not logged in, navigate to the login screen
            return LoginView();
          }
        }
      },
    );
  }
}
