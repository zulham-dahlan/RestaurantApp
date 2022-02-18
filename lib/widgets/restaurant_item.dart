import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/response_restaurant.dart';

import 'package:restaurant_app/ui/detail_page.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;

  final String pictureUrl =
      "https://restaurant-api.dicoding.dev/images/medium/";

  const RestaurantItem({Key? key, required this.restaurant}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routName,
              arguments: restaurant);
        },
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
            child: Image.network(pictureUrl + restaurant.pictureId,
                width: 100, fit: BoxFit.cover),
            tag: restaurant.pictureId),
        title: Text(restaurant.name),
        subtitle: Text(restaurant.city),
      ),
    );
  }
}
