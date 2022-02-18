import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/main_page.dart';


class SplashScreen extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        () => Navigator.pushReplacementNamed(
            context, MainPage.routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('images/splash.png'),
      ),
    );
  }
}

class SplashScreenPage extends StatefulWidget {
  static const reouteName = '/splash_screen';

  SplashScreen createState() => SplashScreen();
}
