import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';

import '../Keys.dart';
import '../Model/user.dart';
import '../constants.dart';
import '../controller/simple_ui_controller.dart';
import 'Home.dart';
import 'MainScreen.dart';
import 'package:http/http.dart' as http;


class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String errorMsg = '';
  String errorMsg1 = '';
  bool _isLoading = false;
  bool _isLoading1 = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  UserProfile? userProfile;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SimpleUIController simpleUIController = Get.find<SimpleUIController>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        // backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return _buildLargeScreen(size, simpleUIController);
            } else {
              return _buildSmallScreen(size, simpleUIController);
            }
          },
        ),
      ),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: RotatedBox(
            quarterTurns: 3,
            child: Lottie.asset(
              'assets/coin.json',
              height: size.height * 0.3,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(width: size.width * 0.06),
        Expanded(
          flex: 5,
          child: _buildMainBody(
            size,
            simpleUIController,
          ),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return Center(
      child: _buildMainBody(
        size,
        simpleUIController,
      ),
    );
  }

  /// Main Body
  Widget _buildMainBody(
    Size size,
    SimpleUIController simpleUIController,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: size.width > 600
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          size.width > 600
              ? Container()
              : Lottie.asset(
                  'assets/wave.json',
                  height: size.height * 0.2,
                  width: size.width,
                  fit: BoxFit.fill,
                ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Login',
              style: kLoginTitleStyle(size),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Welcome Back Catchy',
              style: kLoginSubtitleStyle(size),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /// username or Gmail
                  TextFormField(
                    style: kTextFormFieldStyle(),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Username or Gmail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    controller: emailController,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      } else if (value.length < 4) {
                        return 'at least enter 4 characters';
                      } else if (errorMsg == "invalid-email") {
                        return 'User Not exist';
                      }
                      return null;
                    },
                  ),
                  // SizedBox(
                  //   height: size.height * 0.02,
                  // ),
                  // TextFormField(
                  //   controller: emailController,
                  //   decoration: const InputDecoration(
                  //     prefixIcon: Icon(Icons.email_rounded),
                  //     hintText: 'gmail',
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.all(Radius.circular(15)),
                  //     ),
                  //   ),
                  //   // The validator receives the text that the user has entered.
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter gmail';
                  //     } else if (!value.endsWith('@gmail.com')) {
                  //       return 'please enter valid gmail';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  /// password
                  Obx(
                    () => TextFormField(
                      style: kTextFormFieldStyle(),
                      controller: passwordController,
                      obscureText: simpleUIController.isObscure.value,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_open),
                        suffixIcon: IconButton(
                          icon: Icon(
                            simpleUIController.isObscure.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            simpleUIController.isObscureActive();
                          },
                        ),
                        hintText: 'Password',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        } else if (value.length < 7) {
                          return 'at least enter 6 characters';
                        } else if (value.length > 13) {
                          return 'maximum character is 13';
                        } else if (errorMsg1 == "invalid-credential") {
                          return 'Please enter a correct password';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'Creating an account means you\'re okay with our Terms of Services and our Privacy Policy',
                    style: kLoginTermsAndPrivacyStyle(size),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  /// Login Button
                  loginButton(),
                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  /// Navigate To Login Screen
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('/signup', (Route<dynamic> route) => false);
                      nameController.clear();
                      emailController.clear();
                      passwordController.clear();
                      _formKey.currentState?.reset();
                      simpleUIController.isObscure.value = true;
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account?',
                        style: kHaveAnAccountStyle(size),
                        children: [
                          TextSpan(
                            text: " Sign up",
                            style: kLoginOrSignUpTextStyle(
                              size,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  orDivider(),

                  logos()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Login Button
  Widget loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          // backgroundColor: MaterialStateProperty.all(Colors.amber),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () async {
          // Validate returns true if the form is valid, or false otherwise.
          errorMsg = '';
          errorMsg1 = '';
          if (_formKey.currentState!.validate()) {
            // ... Navigate To your Home Page
            try {
              // Validate email and password before attempting to sign in
              String email = emailController.text.trim();
              String password = passwordController.text;

              if (email.isEmpty || password.isEmpty) {
                print('Please enter both email and password.');
                // Display a user-friendly message to the user.
                return;
              }

              setState(() {
                _isLoading = true; // Start loading
              });

              await _auth.signInWithEmailAndPassword(
                email: email,
                password: password,
              );
              getCurrentUser();
              _sendFirebaseMessage(userProfile!);
              print("Login Successful");
              AnimatedSnackBar.material(
                'Login Succesfull..',
                type: AnimatedSnackBarType.success,
              ).show(context);
              Navigator.of(context).pushNamedAndRemoveUntil('/mainScreen', (Route<dynamic> route) => false);
            } on FirebaseAuthException catch (e) {
              print(e.code);
              print("hhhhhhhhhhhhhh");

              if (e.code == 'invalid-email') {
                errorMsg = 'invalid-email';
                AnimatedSnackBar.material(
                  'User not found.',
                  type: AnimatedSnackBarType.error,
                ).show(context);
                print('User not found.');
                // Display a user-friendly message to the user, like "Incorrect email or password."
              } else if (e.code == 'invalid-credential') {
                errorMsg1 = 'invalid-credential';
                AnimatedSnackBar.material(
                  'Wrong password provided for that user.',
                  type: AnimatedSnackBarType.error,
                ).show(context);
                print('Wrong password provided for that user.');
                // Display a message indicating the password is incorrect.
              } else {
                AnimatedSnackBar.material(
                  'Please check the email or password',
                  type: AnimatedSnackBarType.error,
                ).show(context);
                print('Error during login: $e');
                // Handle other login errors.
              }
            } finally {
              setState(() {
                _isLoading = false; // Stop loading
              });
            }
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Login'),
                const SizedBox(width: 10,),
                if(_isLoading)const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
                    strokeWidth: 4,
                  ),
                ),
              ],
            ),
            // Loading indicator
          ],
        ),
      ),
    );
  }

  Widget orDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 1,
              color: const Color(0xFF2D5D70),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'or',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 1,
              color: const Color(0xFF2D5D70),
            ),
          ),
        ],
      ),
    );
  }

  Widget logos() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Card(
            elevation: 5,
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      signInWithGoogle();
                    },
                    child: Image.asset('assets/google.png')),
                SizedBox(width: 5,),
                if(_isLoading1)const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
                    strokeWidth: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<User?> signInWithGoogle() async {
    setState(() {
      _isLoading1 = true; // Start loading
    });
    final GoogleSignInAccount? googleSignInAccount =
    await GoogleSignIn().signIn();
    if (googleSignInAccount == null) {
      // The user canceled the sign-in process
      return null;
    }

    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    try {
      final UserCredential authResult =
      await FirebaseAuth.instance.signInWithCredential(credential);
      getCurrentUser();
      _sendFirebaseMessage(userProfile!);
      Navigator.of(context).pushNamedAndRemoveUntil('/mainScreen', (Route<dynamic> route) => false);

      return authResult.user;
    } catch (e) {
      print('Error during Google Sign-In: $e');
      return null;
    }finally {
      setState(() {
        _isLoading1 = false; // Stop loading
      });
    }
  }
  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        userProfile = UserProfile(
          uid: user.uid,
          displayName: user.displayName,
          email: user.email,
          photoUrl: user.photoURL,
          emailVerified: user.emailVerified,
          phoneNumber: user.phoneNumber,
        );
      });
    }
  }

  void _sendFirebaseMessage(UserProfile userProfile) async {
    String? token = await _firebaseMessaging.getToken();
    final Map<String, dynamic> message = {
      'notification': {
        'title': '${userProfile.displayName ?? userProfile.email }',
        'body': 'Welcome to Shopping Cart, ${userProfile.displayName ?? userProfile.email }! Happy shopping with us.',
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

}

