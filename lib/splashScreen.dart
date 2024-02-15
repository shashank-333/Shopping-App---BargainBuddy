import 'dart:async';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  String companyLogoPath = "";
  BuildContext ? ctx;
  late Timer? _timer;


  @override
  void initState() {
    _timer = Timer(const Duration(milliseconds: 1000), () async {
      loadData();
    });
    super.initState();
  }

  loadData() async
  {
    await loadSharedItems();
  }

  @override
  void dispose() {
    if (_timer?.isActive ?? false) {
      _timer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(companyLogoPath, width: 250, height: 250),
          ],
        ),
      ),
    );
  }

  loadSharedItems() async {
    try{
      bool login = true;
      bool region = false;
      if (login) {
        Navigator.of(ctx!).pushNamedAndRemoveUntil('/mainScreen',
                (Route<dynamic> route) => false);
      } else if(region != 5) {
        Navigator.of(ctx!).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }else
      {
        Navigator.of(context).pushNamedAndRemoveUntil('/server', (Route<dynamic> route) => false);
      }
    }catch(e)
    {
      debugPrint(e.toString());
    }
  }
}
