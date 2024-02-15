import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcarts/route.dart';


import 'IntialPage.dart';
import 'Provider/CartProvider.dart';
import 'Provider/NotificationCount.dart';
import 'PushNotification/firebase_api.dart';
import 'Theme/TheameProvider.dart';
import 'Theme/app_style.dart';
import 'controller/simple_ui_controller.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  Stripe.publishableKey = '';
  await dotenv.load(fileName:"assets/.env");
  await Stripe.instance.applySettings();
  Get.put(SimpleUIController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => NotificationCount()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BargainBuddy',
            home: InitialScreen(),
            onGenerateRoute: RouteGenerator.generateRoute,
            theme: themeProvider.isDarkMode ? AppTheme.dark : AppTheme.light,
            // routes: {
            //   CartPage.route :(context) =>  CartPage()
            // },
          );
        },
      ),
    );
  }
}
