import 'package:flutter/material.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/helper/notification_helper.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:restaurant_app/ui/setting_page.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main_page';

  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _bottomIndex = 0 ;
  final NotificationHelper notificationHelper = NotificationHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: IconThemeData(color: mainColor),
        selectedItemColor: mainColor,
        currentIndex: _bottomIndex,
        items: _bottomNavBarItem,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  @override
  void initState(){
    super.initState();
    notificationHelper.configureSelectNotificationSubject(RestaurantDetailPage.routName);
  }

  List<Widget> _listWidget = [
    RestaurantListPage(),
    FavoritePage(),
    SettingPage(),
  ];

  List<BottomNavigationBarItem> _bottomNavBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: RestaurantListPage.homeTitle,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite_border),
      label: FavoritePage.favoriteTitle
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: SettingPage.settingTitle,
    ),
  ];

  void _onBottomNavTapped(int index){
    setState(() {
      _bottomIndex = index ;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    selectNotificationSubject.close();
  }
}