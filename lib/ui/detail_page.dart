import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response_detail.dart';
import 'package:restaurant_app/data/model/response_restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({required this.restaurant});

  @override
  _RestaurantDetailPageState createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  late Future<ResponseDetail> _detailRestaurant;
  final String pictureUrl =
      "https://restaurant-api.dicoding.dev/images/medium/";
  late Future<bool> statusConnection;

  @override
  void initState() {
    super.initState();
    _detailRestaurant = ApiService().detailRestaurant(widget.restaurant.id);
  }

  Widget _buildContent(BuildContext context) {
    return FutureBuilder(
      future: _detailRestaurant,
      builder: (context, AsyncSnapshot<ResponseDetail> snapshot) {
        var state = snapshot.connectionState;
        if (state != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (snapshot.hasData) {
            var restaurant = snapshot.data?.restaurant;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Hero(
                    tag: restaurant!.pictureId,
                    child: Image.network(pictureUrl + restaurant.pictureId),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  restaurant.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text('Kategori : '),
                                    SizedBox(
                                      height: 15,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: restaurant.categories.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Text(
                                              '${restaurant.categories[index].name}, ');
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            _buttonFavorite(context, widget.restaurant),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Icon(Icons.star_rate_outlined),
                            Text(restaurant.rating.toString()),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.location_on),
                            Text(restaurant.address + ', ' + restaurant.city),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(restaurant.description),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Restaurant Menu',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.0),
                              width: 150.0,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  Text('Foods'),
                                  ListView.builder(
                                      itemCount: restaurant.menus.foods.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Text(
                                            '- ${restaurant.menus.foods[index].name}');
                                      })
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10.0),
                              width: 150.0,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                children: [
                                  Text('Drinks'),
                                  ListView.builder(
                                      itemCount: restaurant.menus.drinks.length,
                                      shrinkWrap: true,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Text(
                                            '- ${restaurant.menus.drinks[index].name}');
                                      })
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Review Restaurant',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: restaurant.customerReviews.length,
                          itemBuilder: (BuildContext context, int index) {
                            CustomerReview customerReview =
                                restaurant.customerReviews[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(customerReview.name),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(' . ${customerReview.date}',
                                        style: TextStyle(
                                          fontSize: 10,
                                        )),
                                  ],
                                ),
                                Text(customerReview.review),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Check Your Internet Connection'));
          } else {
            return Text('');
          }
        }
      },
    );
  }

  Widget _buttonFavorite(BuildContext context, Restaurant restaurant) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.checkStatusFavorite(restaurant.id),
          builder: (context, snapshot) {
            var statusFavorite = snapshot.data ?? false;
            if (statusFavorite)
              return IconButton(
                  onPressed: () => provider.addToFavorite(restaurant),
                  icon: Icon(Icons.favorite_border));
            else
              return IconButton(
                  onPressed: () => provider.deleteFromFavorite(restaurant.id),
                  icon: Icon(Icons.favorite));
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant App'),
      ),
      body: _buildContent(context),
    );
  }
}
