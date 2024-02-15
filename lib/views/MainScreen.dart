import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../Model/Product.dart';
import 'CartPage.dart';
import 'Home.dart';
import 'ProfileScreen.dart';
import 'Search.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchPage(),
    CartPage(),
    ProfileScreen(),
  ];
  // Future<void> _selectPage(int index) async {
  //   // Add a delay of 2 seconds
  //   await Future.delayed(Duration(seconds: 2));
  //
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        Positioned(
          left: 10,
          right: 10,
          bottom: 30,
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                // BoxShadow(
                //   color: Colors.black26,
                //   spreadRadius: 1,
                //   blurRadius: 10,
                //   offset: Offset(0, 3),
                // ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Lottie.asset(
                      'assets/Home.json',
                      height: 30,
                      width: 30,
                      fit: BoxFit.fill,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Lottie.asset(
                      'assets/Search.json',
                      height: 35,
                      width: 35,
                      fit: BoxFit.fill,
                    ),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Lottie.asset(
                      'assets/cart.json',
                      height: 35,
                      width: 35,
                      fit: BoxFit.fitHeight,
                    ),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Lottie.asset(
                      'assets/Profile.json',
                      height: 30,
                      width: 30,
                      fit: BoxFit.fill,
                    ),
                    label: 'Profile',
                  ),
                ],
                selectedItemColor: Colors.amber,
                currentIndex: _selectedIndex,
                unselectedItemColor: Colors.amber,
                // onTap: _selectPage,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
