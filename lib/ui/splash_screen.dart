import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/ui/main_page.dart';


class SplashScreen extends StatelessWidget{
 static const reouteName = '/splash_screen';

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4),(){
      Navigator.of(context).pushReplacementNamed(MainPage.routeName);
    });

    return Stack(
      children: [
        Container(color:mainColor),
        Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.local_restaurant,
            color: Colors.white,
            size: 80,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 160,
            height: 160,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black.withOpacity(0.2)),
              strokeWidth: 10,
            ),
          ),
        )
      ],
    );
  }
}
