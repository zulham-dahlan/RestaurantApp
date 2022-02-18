import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response_restaurant.dart';
import 'package:restaurant_app/helper/state_helper.dart';

class SearchProvider extends ChangeNotifier {
  ApiService apiService = ApiService();

  SearchProvider() {
    _state = ResultState.noInput;
  }

  late ResponseRestaurant _responseRestaurant;
  late ResultState _state;
  String _message = '';

  ResponseRestaurant get responseRestaurant => _responseRestaurant;
  ResultState get state => _state;
  String get message => _message;

  Future<void> searchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final getConnection = await apiService.checkConnection();
      if (getConnection) {
        final result = await apiService.searchrestaurant(query);
        if (result.restaurants.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          _message = 'Empty Data';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          _responseRestaurant = result;
        }
      } else {
        _state = ResultState.error;
        notifyListeners();
        _message = 'Check Your Internet Connection';
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Error : $e $query';
    }
  }
}
