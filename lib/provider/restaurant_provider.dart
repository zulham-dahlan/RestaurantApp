import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response_restaurant.dart';
import 'package:restaurant_app/helper/state_helper.dart';
import 'package:http/http.dart' as http;

class RestaurantProvider extends ChangeNotifier {
  ApiService apiServices = ApiService();

  RestaurantProvider() {
    _fetchAllRestaurant();
  }

  late ResponseRestaurant _responseRestaurant;
  late ResultState _state;
  String _message = '';

  ResponseRestaurant get responseRestaurant => _responseRestaurant;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final getConnection = await apiServices.checkConnection();
      if (getConnection) {
        final restaurant = await apiServices.listRestaurant(http.Client());
        if (restaurant.restaurants.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _responseRestaurant = restaurant;
        }
      } else {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Check Your Internet Connection';
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error : $e';
    }
  }
}
