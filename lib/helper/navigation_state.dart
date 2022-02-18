import 'package:flutter/cupertino.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NavigationState{
  static intentWithData(String routeName, Object argument){
    navigatorKey.currentState?.pushNamed(routeName, arguments: argument);
  }

  static back() => navigatorKey.currentState?.pop();
}