import 'dart:convert';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';

import '../Model/user.dart';
import '../views/login_view.dart';
import '../constants.dart';
import '../controller/simple_ui_controller.dart';
import 'Home.dart';
import 'MainScreen.dart';
import 'package:http/http.dart' as http;


class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isLoading1 = false;
  UserProfile? userProfile;
  bool _isEmailVerified = true;


  final _formKey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // BuildContext ctx;


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  SimpleUIController simpleUIController = Get.put(SimpleUIController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          // backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildLargeScreen(size, simpleUIController, theme);
              } else {
                return _buildSmallScreen(size, simpleUIController, theme);
              }
            },
          )),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
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
          child: _buildMainBody(size, simpleUIController, theme),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Center(
      child: _buildMainBody(size, simpleUIController, theme),
    );
  }

  /// Main Body
  Widget _buildMainBody(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
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
                  'assets/login.json',
                  height: size.height * 0.35,
                  width: size.width,
                  fit: BoxFit.fitWidth,
                ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Sign Up',
              style: kLoginTitleStyle(size),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Create Account',
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
                  /// username
                  TextFormField(
                    style: kTextFormFieldStyle(),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),

                    controller: nameController,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter username';
                      } else if (value.length < 4) {
                        return 'at least enter 4 characters';
                      } else if (value.length > 13) {
                        return 'maximum character is 13';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  /// Gmail
                  TextFormField(
                    style: kTextFormFieldStyle(),
                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      hintText: 'gmail',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    onChanged:(text){
                      _isEmailVerified = true;
                    },
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter gmail';
                      } else if (!value.endsWith('@gmail.com')) {
                        return 'please enter valid gmail';
                      }
                      return null;
                    },
                  ),
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

                  /// SignUp Button
                  signUpButton(theme),
                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  /// Navigate To Login Screen
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);

                      nameController.clear();
                      emailController.clear();
                      passwordController.clear();
                      _formKey.currentState?.reset();

                      simpleUIController.isObscure.value = true;
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account?',
                        style: kHaveAnAccountStyle(size),
                        children: [
                          TextSpan(
                              text: " Login",
                              style: kLoginOrSignUpTextStyle(size)),
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

  Widget orDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 1,
              color: Color(0xFF2D5D70),
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
              color: Color(0xFF2D5D70),
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


  // Widget signUpButton(ThemeData theme) {
  //   return SizedBox(
  //     width: double.infinity,
  //     height: 55,
  //     child: ElevatedButton(
  //       style: ButtonStyle(
  //         backgroundColor: MaterialStateProperty.all(Colors.amber),
  //         shape: MaterialStateProperty.all(
  //           RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(15),
  //           ),
  //         ),
  //       ),
  //       onPressed: _isEmailVerified ? () async {
  //         // Validate returns true if the form is valid, or false otherwise.
  //         if (_formKey.currentState!.validate()) {
  //           setState(() {
  //             _isLoading = true; // Start loading
  //           });
  //           try {
  //             UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
  //               email: emailController.text,
  //               password: passwordController.text,
  //             );
  //
  //             // Send email verification
  //             await userCredential.user!.sendEmailVerification();
  //             AnimatedSnackBar.material(
  //               'Email verification Message sent Your email Kindly check!',
  //               type: AnimatedSnackBarType.success,
  //             ).show(context);
  //             // Show a message or navigate to a screen informing the user to verify their email
  //
  //             // Disable sign-up button until email is verified
  //             setState(() {
  //               _isEmailVerified = false;
  //             });
  //
  //             // Listen for changes in user authentication state to check email verification status
  //             _auth.authStateChanges().listen((User? user) {
  //               if (user != null) {
  //                 if (user.emailVerified) {
  //                   // Enable sign-up button once email is verified
  //                   setState(() {
  //                     _isEmailVerified = true;
  //                   });
  //                   Navigator.of(context).pushNamedAndRemoveUntil('/mainScreen', (Route<dynamic> route) => false);
  //                   // Optionally, proceed with sign-up logic or navigate to the home screen
  //                   AnimatedSnackBar.material(
  //                     'Email verified. You can now sign up!',
  //                     type: AnimatedSnackBarType.success,
  //                   ).show(context);
  //                 }
  //               }
  //             });
  //           } catch (e) {
  //             print('Error during sign up: $e');
  //             AnimatedSnackBar.material(
  //               'Error during sign up: $e',
  //               type: AnimatedSnackBarType.warning,
  //             ).show(context);
  //             // Handle sign-up errors.
  //           }
  //           finally {
  //             setState(() {
  //               _isLoading = false; // Stop loading
  //             });
  //           }
  //         }
  //       } : null, // Disable button if email is not verified
  //       child: Stack(
  //         alignment: Alignment.center,
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               const Text('SignUp'),
  //               const SizedBox(width: 10,),
  //               if(_isLoading) const SizedBox(
  //                 height: 20,
  //                 width: 20,
  //                 child: CircularProgressIndicator(
  //                   valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
  //                   strokeWidth: 4,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           // Loading indicator
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget signUpButton(ThemeData theme) {
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
          if (_formKey.currentState!.validate()) {
            setState(() {
              _isLoading = true; // Start loading
            });
            try {
              UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                // name : nameController.text,
                email: emailController.text,
                password: passwordController.text,
              );
              await userCredential.user!.sendEmailVerification();
              getCurrentUser();
              _sendFirebaseMessage(userProfile!);
              AnimatedSnackBar.material(
                'Signup Successfull..',
                type: AnimatedSnackBarType.success,
              ).show(context);
              Navigator.of(context).pushNamedAndRemoveUntil('/mainScreen', (Route<dynamic> route) => false);

              // Successfully signed up, navigate to the home screen or perform other tasks.
            } catch (e) {
              print('Error during sign up: $e');
              AnimatedSnackBar.material(
                'Error during sign up: $e',
                type: AnimatedSnackBarType.warning,
              ).show(context);
              // Handle sign-up errors.
            }
            finally {
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
                const Text('SignUp'),
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

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        userProfile = UserProfile(
          uid: user.uid,
          displayName: user.displayName ?? nameController.text,
          email: user.email,
          photoUrl: user.photoURL,
          emailVerified: user.emailVerified,
          phoneNumber: user.phoneNumber,
          name: nameController.text,
        );
      });
    }
  }

  void _sendFirebaseMessage(UserProfile userProfile) async {
    final String serverKey = ''; // Replace with your Firebase server key
    String? token = await _firebaseMessaging.getToken();
    final Map<String, dynamic> message = {
      'notification': {
        'title': '${userProfile.displayName ?? userProfile.name }',
        'body': 'Welcome to Shopping Cart, ${userProfile.displayName ?? userProfile.name }! Happy shopping with us.',
        'image': 'https://cdn-icons-png.flaticon.com/512/904/904151.png'
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
