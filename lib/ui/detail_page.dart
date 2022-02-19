import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/style.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response_detail.dart';
import 'package:restaurant_app/data/model/response_restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/widgets/foods_menu.dart';

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
                child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(pictureUrl + restaurant!.pictureId),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            restaurant.address + ", " + restaurant.city,
                          )
                        ],
                      ),
                      _buttonFavorite(context, widget.restaurant),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    restaurant.description,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Kategori',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: darkColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children:
                        List.generate(restaurant.categories.length, (index) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 15, top: 5, right: 15, bottom: 5),
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: mainColor,
                        ),
                        child: Text(restaurant.categories[index].name),
                      );
                    }),
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Restaurant Menu',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: darkColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FoodsMenu(foodCategory: restaurant.menus.foods,categoryMenu: 'Foods'),
                   const SizedBox(
                    height: 10,
                  ),
                  FoodsMenu(foodCategory: restaurant.menus.drinks,categoryMenu: 'Drinks',),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Review Restaurant',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: darkColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // ListView.builder(
                  //   shrinkWrap: true,
                  //   itemCount: restaurant.customerReviews.length,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     CustomerReview customerReview =
                  //         restaurant.customerReviews[index];
                  //     return Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Row(
                  //           children: [
                  //             Text(customerReview.name),
                  //             const SizedBox(
                  //               width: 5,
                  //             ),
                  //             Text(' . ${customerReview.date}',
                  //                 style: TextStyle(
                  //                   fontSize: 10,
                  //                 )),
                  //           ],
                  //         ),
                  //         Text(customerReview.review),
                  //         const SizedBox(
                  //           height: 5,
                  //         ),
                  //       ],
                  //     );
                  //   },
                  // ),
                ],
              ),
            ));
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
                  icon: Icon(
                    Icons.favorite_border,
                    color: mainColor,
                    size: 30,
                  ));
            else
              return IconButton(
                  onPressed: () => provider.deleteFromFavorite(restaurant.id),
                  icon: Icon(
                    Icons.favorite,
                    color: mainColor,
                    size: 30,
                  ));
          });
    });
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
