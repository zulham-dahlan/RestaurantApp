import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/response_restaurant.dart';
import 'package:restaurant_app/helper/state_helper.dart';

class DatabaseProvider extends ChangeNotifier{
  final DatabaseHelper databaseHelper = DatabaseHelper();

  DatabaseProvider(){
    _getDataFavorite();
  }

  late ResultState _state ;
  List<Restaurant> _favoriteRestaurant = [];
  String _message = '';

  ResultState get state => _state ;
  List<Restaurant> get favoriteRestaurant => _favoriteRestaurant;
  String get message => _message ;

  void _getDataFavorite() async {
    _state = ResultState.loading;
    _favoriteRestaurant = await databaseHelper.getFavorite();
    if(_favoriteRestaurant.isNotEmpty){
      _state = ResultState.hasData;
    }else{
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addToFavorite(Restaurant restaurant) async {
    try{
      await databaseHelper.addFavorite(restaurant);
      _getDataFavorite();
    }catch (e){
      _state = ResultState.error;
      _message = 'Error : $e';
    }
    notifyListeners();
  } 

  Future<bool> checkStatusFavorite(String id) async {
    final favoriteDataRestaurant = await databaseHelper.getFavoriteById(id);
    return favoriteDataRestaurant.isEmpty;
  }

  void deleteFromFavorite(String id) async{
    try{
      await databaseHelper.deleteFavoriteById(id);
      _getDataFavorite();
    }catch (e){
      _state = ResultState.error;
      _message = 'Error : $e';
    }
    notifyListeners();
  }
  
}