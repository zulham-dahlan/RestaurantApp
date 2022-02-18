import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/helper/state_helper.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _queryController = TextEditingController();

  Widget _buildContent(BuildContext context) {
    return Container(
      child: Consumer<SearchProvider>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20, left: 20, top: 20),
                child: TextField(
                  controller: _queryController,
                  onSubmitted: (String input) async {
                    setState(() {
                      value.searchRestaurant(input);
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nama Restaurant',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text('Search Result', style: TextStyle(color: mainColor, fontWeight: FontWeight.bold, fontSize: 20),)
              ),
              Expanded(
                child: _buildList(context, value),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildList(BuildContext context, SearchProvider value) {
    if (value.state == ResultState.noInput) {
      return Text('');
    } else if (value.state == ResultState.loading) {
      return Center(child: CircularProgressIndicator());
    } else if (value.state == ResultState.hasData) {
      return ListView.builder(
        itemCount: value.responseRestaurant.restaurants.length,
        itemBuilder: (context, index) {
          var restaurant = value.responseRestaurant.restaurants[index];
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
  }

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
      ),
      body: _buildContent(context),
    );
  }
}
