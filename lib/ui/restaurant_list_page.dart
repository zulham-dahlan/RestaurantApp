import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/helper/state_helper.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/widgets/header_widget.dart';
import 'package:restaurant_app/widgets/platform_widget.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class RestaurantListPage extends StatefulWidget {
  static const routeName = '/restaurant_list';
  static const String homeTitle = 'Home';
  @override
  _RestaurantListPageState createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: mainColor),
        centerTitle: true,
        title: Icon(Icons.local_restaurant),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.routeName);
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderWidget(),
          SizedBox(
            height: 25,
          ),
          Expanded(
            child: Consumer<RestaurantProvider>(
              builder: (context, value, child) {
                if (value.state == ResultState.loading) {
                  return Center(child: CircularProgressIndicator());
                } else if (value.state == ResultState.hasData) {
                  return ListView.builder(
                    itemCount: value.responseRestaurant.restaurants.length,
                    itemBuilder: (context, index) {
                      var restaurant =
                          value.responseRestaurant.restaurants[index];
                      return RestaurantItem(restaurant: restaurant);
                    },
                  );
                } else if (value.state == ResultState.noData) {
                  return Center(child: Text(value.message));
                } else if (value.state == ResultState.error) {
                  return Center(child: Text(value.message));
                } else {
                  return Center(child: Text(''));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
