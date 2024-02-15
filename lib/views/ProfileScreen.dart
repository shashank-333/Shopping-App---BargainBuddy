// import 'dart:io';
//
// import 'package:animated_snack_bar/animated_snack_bar.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
//
// import '../Model/user.dart';
// import '../Provider/NotificationCount.dart';
// import '../controller/simple_ui_controller.dart';
//
//
// class ProfileScreen extends StatefulWidget {
//   @override
//   _ProfileScreenState createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   UserProfile? userProfile;
//   File? _image;
//   bool userImage = false;
//   final ImagePicker _imagePicker = ImagePicker();
//   // SimpleUIController simpleUIController = Get.find<SimpleUIController>();
//
//
//   @override
//   void initState() {
//     super.initState();
//     // Get the current user when the screen is initialized
//     getCurrentUser();
//   }
//   User? user = FirebaseAuth.instance.currentUser;
//   Future<void> getCurrentUser() async {
//
//
//     if (user != null) {
//       setState(() {
//         userProfile = UserProfile(
//           uid: user!.uid,
//           displayName: user!.displayName,
//           email: user!.email,
//           photoUrl: user!.photoURL,
//           emailVerified: user!.emailVerified,
//           phoneNumber: user!.phoneNumber,
//         );
//       });
//     }
//   }
//
//   Future<void> _pickImage() async {
//     final pickedFile =
//         await _imagePicker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Padding(
//           padding: EdgeInsets.only(left: 22.0),
//           child: Text(
//             'Profile',
//             style: TextStyle(
//               fontSize: 26.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         backgroundColor: Colors.amber,
//         automaticallyImplyLeading: false,
//       ),
//       body: userProfile != null
//           ? Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Stack(children: [
//                       userImage
//                           ? CircleAvatar(
//                               radius: 70,
//                               backgroundImage: FileImage(_image!),
//                             )
//                           : CircleAvatar(
//                               radius: 70,
//                               child: Lottie.asset(
//                                 'assets/userProfile.json',
//                                 height: 500,
//                                 width: 500,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                       Positioned(
//                           bottom: 5,
//                           right: 5,
//                           child: CircleAvatar(
//                               child: IconButton(
//                             onPressed: () async {
//                               await _pickImage();
//                               userImage = true;
//                               setState(
//                                   () {}); // Update the state to rebuild the UI with the selected image
//                             },
//                             icon: const Icon(
//                               Icons.camera_alt_rounded,
//                             ),
//                           )))
//                     ]),
//                     // You can use the user's profile picture URL here
//                     const SizedBox(height: 16),
//                     Text(
//                       'User ID:',
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//                     Text(
//                       userProfile!.uid!,
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     const Divider(),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Name:',
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//                     Text(
//                       userProfile!.displayName ?? 'N/A',
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     const Divider(),
//                     const SizedBox(height: 8),
//                     Text(
//                       'Email:',
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//                     Text(
//                       userProfile!.email ?? 'N/A',
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Email Verified: ',
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.grey[800],
//                       ),
//                     ),
//                     Text(
//                       (userProfile!.emailVerified).toString() == 'true' ? "Yes" : "No",
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                    if(user!.emailVerified==false) ElevatedButton(
//                       onPressed: (){
//                         user!.sendEmailVerification();
//                         AnimatedSnackBar.material(
//                           'Email verification mail has sent to your mail. Please verify your mail!',
//                           type: AnimatedSnackBarType.info,
//                         ).show(context);
//                       },
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(Colors.amber),
//                         padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 32, vertical: 6)),
//                         shape: MaterialStateProperty.all(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       child: const Text(
//                         'Verify Your Email',
//                         style: TextStyle(
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.deepPurpleAccent,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     ElevatedButton(
//                       onPressed: _logout,
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(Colors.amber),
//                         padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 32, vertical: 6)),
//                         shape: MaterialStateProperty.all(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       child: const Text(
//                         'Logout',
//                         style: TextStyle(
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.deepPurpleAccent,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     ElevatedButton(
//                       onPressed: _resetPassword,
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(Colors.amber),
//                         padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 32, vertical: 6)),
//                         shape: MaterialStateProperty.all(
//                           RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                       ),
//                       child: const Text(
//                         'Reset Password',
//                         style: TextStyle(
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.deepPurpleAccent,
//                         ),
//                       ),
//                     ),
//                     // Consumer<NotificationCount>(
//                     //   builder: (context, notifier, _) {
//                     //     return Text(
//                     //       'Notification Count: ${notifier.count}',
//                     //       style: TextStyle(fontSize: 16.0),
//                     //     );
//                     //   },
//                     // ),
//
//
//                   ],
//                 ),
//               ),
//             )
//           : const Center(
//               child: CircularProgressIndicator(),
//             ),
//     );
//   }
//   Future<void> _logout() async {
//     try {
//       await FirebaseAuth.instance.signOut();
//       // Sign out from Google Sign-In
//       final GoogleSignIn googleSignIn = GoogleSignIn();
//       await googleSignIn.signOut();
//       // Handle successful logout (e.g., navigate to login screen)
//       Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
//     } catch (e) {
//       // Handle errors
//       print(e);
//       showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text('Logout Error'),
//             content: Text('Failed to log out: $e'),
//             actions: [
//               TextButton(
//                   onPressed: () => Navigator.of(context).pop(),
//                   child: const Text('OK'))
//             ],
//           ));
//     }
//   }
//   Future<void> _resetPassword() async {
//     try {
//       await FirebaseAuth.instance.sendPasswordResetEmail(email: userProfile!.email!);
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Password Reset'),
//           content: Text('A password reset link has been sent to your email address.'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     } catch (e) {
//       print('Error sending password reset email: $e');
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Password Reset Error'),
//           content: Text('Failed to send password reset email: $e'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }
//
//
// }
import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

import '../Model/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? userProfile;
  File? _image;
  bool userImage = false;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Get the current user when the screen is initialized
    getCurrentUser();
  }

  User? user = FirebaseAuth.instance.currentUser;

  Future<void> getCurrentUser() async {
    if (user != null) {
      setState(() {
        userProfile = UserProfile(
          uid: user!.uid,
          displayName: user!.displayName,
          email: user!.email,
          photoUrl: user!.photoURL,
          emailVerified: user!.emailVerified,
          phoneNumber: user!.phoneNumber,
        );
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
    await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 22.0),
          child: Text(
            'Profile',
            style: TextStyle(
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: userProfile != null
          ? SizedBox(
            height: 600,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          userImage
                              ? CircleAvatar(
                            radius: 70,
                            backgroundImage: FileImage(_image!),
                          )
                              : CircleAvatar(
                            radius: 70,
                            child: Lottie.asset(
                              'assets/userProfile.json',
                              height: 500,
                              width: 500,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: CircleAvatar(
                              child: IconButton(
                                onPressed: () async {
                                  await _pickImage();
                                  userImage = true;
                                  setState(() {});
                                },
                                icon: const Icon(
                                  Icons.camera_alt_rounded,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        readOnly: true,
                        initialValue: '${userProfile!.uid}',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'User ID',
                          labelStyle: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        readOnly: true,
                        initialValue:
                        userProfile!.displayName ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        readOnly: true,
                        initialValue: userProfile!.email ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        readOnly: true,
                        initialValue: userProfile!.emailVerified ? "Yes" : "No",
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Email Verified',
                          labelStyle: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (user!.emailVerified == false)
                        ElevatedButton(
                          onPressed: () {
                            user!.sendEmailVerification();
                            AnimatedSnackBar.material(
                              'Email verification mail has sent to your mail. Please verify your mail!',
                              type: AnimatedSnackBarType.info,
                            ).show(context);
                          },
                          style: ButtonStyle(
                            // backgroundColor:
                            // MaterialStateProperty.all(Colors.amber),
                            padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 6),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Verify Your Email',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              // color: Colors.deepPurpleAccent,
                            ),
                          ),
                        ),
                      const SizedBox(height: 6),
                      ElevatedButton(
                        onPressed: _logout,
                        style: ButtonStyle(
                          // backgroundColor:
                          // MaterialStateProperty.all(Colors.amber),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 6),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            // color: Colors.deepPurpleAccent,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      ElevatedButton(
                        onPressed: _resetPassword,
                        style: ButtonStyle(
                          // backgroundColor:
                          // MaterialStateProperty.all(Colors.amber),
                          padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 6),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            // color: Colors.deepPurpleAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
          : const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      // Sign out from Google Sign-In
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      // Handle successful logout (e.g., navigate to login screen)
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
    } catch (e) {
      // Handle errors
      print(e);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Logout Error'),
            content: Text('Failed to log out: $e'),
            actions: [
              TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'))
            ],
          ));
    }
  }

  Future<void> _resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: userProfile!.email!);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Password Reset'),
          content: const Text(
              'A password reset link has been sent to your email address.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error sending password reset email: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Password Reset Error'),
          content: Text('Failed to send password reset email: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
